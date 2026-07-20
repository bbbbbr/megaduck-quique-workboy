
; Compatibility functions to translate between Workboy IO commands
; and MegaDuck laptop IO commands


; Regs: Preserves all
duck_laptop_vars_init::
    push af
    ld   a, DUCK_IO_KEYBD_SAFE_POLL_COUNT_RESET
    ldh  [duck_keyboard_safe_poll_interval_count_hram], a

    ; Reset keyboard vars
    xor  a
    ld   [duck_key_flags_prev], a
    ld   [duck_workboy_key_queued], a
    ld   [duck_workboy_shift_mock_state], a
    ld   [duck_workboy_caps_lock_enabled], a

    pop  af
    ret



; Performs MegaDuck laptop IO init
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;
; Regs: Does not preserve F
duck_laptop_hardware_init::

    ; Refresh the MegaDuck laptop rtc valid key in WRAM in case it's been overwritten
    ; to try and avoid causing the system rom to reset the RTC
    call duck_io_set_laptop_sysrom_rtc_wram_valid_keys

    push bc

    ; Save interrupt enables state
    di
    ldh  a, [rIE]
    ld   b, a

    ; Don't re-init if init has been already been performed
    ld   a, [serial_io__keyboard_detected_status__RAM_C10A]
    cp   a, KYBD_STATUS__OK
    jr   z, .duck_init_ok

    ; Clear Serial IO registers
    xor  a
    ldh  [rSC], a
    ldh  [rSB], a

    ; Initialize serially attached peripheral
    call duck_io_controller_init
    cp   a, DUCK_IO_OK
    jr   nz, .return_failure

    ; Save response from some unknown command
    ld   a, DUCK_IO_CMD_INIT_UNKNOWN_0x09
    call duck_io_send_byte
    ; TODO: This wait with no timeout is how the System ROM does it,
    ;       but it can probably be changed to a long delay and
    ;       attempt to fail somewhat gracefully.
    call duck_io_read_byte_no_timeout
    ; Discard the reply data (from DUCK_IO_CMD_INIT_UNKNOWN_0x09)
    ; since at present it doesn't get used and the purpose isn't known
    ;; ld   a, [duck_io_rx_byte]

    ; Ignore the RTC init check for now

    ; Return Success (and save in status var)
    .duck_init_ok
    call duck_laptop_vars_init
    ld   c, KYBD_STATUS__OK ; Modified for Workboy ROM ; DUCK_IO_OK

    ; Restore saved interrupt enables and turn them on
    .status_in_C__return
        ld   a, b   ; B has cached rIE
        ldh  [rIE], a
        ; C has Return Status
        ld   a, c
        ; Version modified for Workboy ROM
        ; Store result in serial_io__keyboard_detected_status__RAM_C10A
        ; since that's where the original ROM expects to find it.
        ; KYBD_STATUS__OK or KYBD_STATUS__NOT_FOUND
        ld [serial_io__keyboard_detected_status__RAM_C10A], a
        pop  bc
        ei
        ret

    .return_failure
        ld   c, KYBD_STATUS__NOT_FOUND ; Modified for Workboy ROM 
        jr   .status_in_C__return



; Read Mega Duck RTC data and translate into Workboy RTC format
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;                      (RTC struct data not updated if polling failed)
;
; Regs: Does not preserve F
duck_rtc_read__translate_to_workboy_siobuffer::

    call duck_io_get_rtc
    cp   a, DUCK_IO_OK
    jr   nz, .return_failure

    ; Load the Megaduck rtc data into the expected Workboy BCD formatted RTC buffer
    ;
    ; [2] = Seconds BCD
    ld   a, [duck_rtc_sec]
    ld   [sioxfer_time__seconds__BCD__RAM_C2B0], a

    ; [3] = Minutes BCD
    ld   a, [duck_rtc_min]
    ld   [sioxfer_time__minutes__BCD__RAM_C2B1], a

    ; [4] = Hours BCD
    ; Translate MegaDuck AM/PM style to Workboy 24 hour style
    ld   a, [duck_rtc_ampm]
    jr   z, .am
    .pm
        ld   a, [duck_rtc_hour]
        add  a, $12
        daa  ; BCD add correction
        jr   .ampmdone
    .am
        ld   a, [duck_rtc_hour]
    .ampmdone
    ld   [sioxfer_time__hours__BCD__RAM_C2B2], a

    ; [5] = Day BCD
    ld   a, [duck_rtc_day]
    ld   [sioxfer_time__days__RAM_C2B3], a

    ; [6] = Month BCD + DoW packed        
    push bc
    ; Pack DoW into upper 3 bits
    ld   a, [duck_rtc_weekday]
    swap a ; << 4
    add  a ; << 1
    ld   c, a
    ; Add Month
    ld   a, [duck_rtc_mon]
    add  c
    ld   [sioxfer_time__month__RAM_C2B4], a
    pop  bc        

    ; [F] = Year, decimal (same for Megaduck RTC)
    ld   a, [duck_rtc_year]
    ; MegaDuck RTC stores year as BCD since 2000 (if >= 2000) or since 1900 (if < 2000)
    ; Workboy stores year as DEC since 1900
    ; So convert and add 100 years
    ; (Don't support years < 2000)
    ; (Also duck system rom doesn't support setting year > 2011 due to missing leap year tables)
    call bcd2dec_result_in_A
    add  a, 100
    ld   [sioxfer_time__year__RAM_C2BD], a

    ; Refresh the MegaDuck laptop rtc valid key in WRAM in case it's been overwritten
    ; to try and avoid causing the system rom to reset the RTC
    call duck_io_set_laptop_sysrom_rtc_wram_valid_keys


    .return_success
        call delay_2_94msec__334A
        ld   a, DUCK_IO_OK
        ret

    .return_failure
        call delay_2_94msec__334A
        ld   a, DUCK_IO_FAIL
        ret


; Translate Workboy RTC data into Mega Duck format and send to Laptop Hardware
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;                      (RTC struct data not updated if polling failed)
;
; Regs: Does not preserve F
duck_rtc_write__translate_from_workboy_siobuffer::
    ; Pick out the relevant workboy rtc bytes
    ; and reformat them into the megaduck rtc buffer
    ;
    ; [2] = Seconds BCD
    ld   a, [sioxfer_time__seconds__BCD__RAM_C2B0]
    ld   [duck_rtc_sec], a

    ; [3] = Minutes BCD
    ld   a, [sioxfer_time__minutes__BCD__RAM_C2B1]
    ld   [duck_rtc_min], a

    ; [4] = Hours BCD
    ; Translate Workboy 24 hour style -> MegaDuck AM/PM style
    ld   a, [sioxfer_time__hours__BCD__RAM_C2B2]
    cp   $12   ; if (hour < 12) then -> AM
    jr   c, .am
    .pm
        sub  a, $12
        daa  ; BCD sub correction
        ld   [duck_rtc_hour], a

        ld   a, DUCK_RTC_PM
        jr .ampmload
    .am
        ld   [duck_rtc_hour], a
        ld   a, DUCK_RTC_AM
    .ampmload
    ld   [duck_rtc_ampm], a

    ; [5] = Day BCD
    ld   a, [sioxfer_time__days__RAM_C2B3]
    ld   [duck_rtc_day], a

    ; [6] = Month BCD
    ; Easier to pull Month from standalone var instead of packed [Month + DoW]
    ; ld   a, [sioxfer_time__month__RAM_C2B4]
    ld   a, [date__month__decimal__maybe__RAM_C138]
    ld   [duck_rtc_mon], a

    ; [F] = Year, decimal (Megaduck RTC is BCD)
    ;
    ; MegaDuck RTC stores year as BCD since 2000 (if >= 2000) or since 1900 (if < 2000)
    ; Workboy stores year as DEC since 1900
    ; So subtract 100 years and convert
    ; (Don't support years < 2000)
    ; (Also duck system rom doesn't support setting year > 2011 due to missing leap year tables)
    ld   a, [sioxfer_time__year__RAM_C2BD]
    sub  a, 100
    call dec2bcd_result_in_A    
    ld   [duck_rtc_year], a

    ; Easier to pull Day of Week from standalone var instead of packed [Month + DoW]
    ; Workboy and Mega Duck use same style (0-6 = sun-sat)
    ld  a, [date__dayofweek_0_to_6_sun_to_mon__decimal__RAM_C304]
    ld  [duck_rtc_weekday], a

    ; Now send the RTC command
    call duck_io_set_rtc

    ; Refresh the MegaDuck laptop rtc valid key in WRAM in case it's been overwritten
    ; to try and avoid causing the system rom to reset the RTC
    call duck_io_set_laptop_sysrom_rtc_wram_valid_keys

    call delay_2_94msec__334A

    ; cp   a, DUCK_IO_OK
    ; Result in A from above call is return value
    ;
    ; Force always returning success (upstream calling code may permaloop if not)
    ld   a, DUCK_IO_OK
    ret


; Key processing flow
;
; Workboy ROM
; -> serial_io__poll_keyboard__3278
;    -> duck_keyboard_read_wrapper_bank_0
;       -> duck_keyboard_poll_and_translate
;          - Workboy Shift key mocking state updates
;          - Safe IO timing gate
;          -> duck_io_keyboard_poll
;             - Polls Mega Duck hardware for Duck Scan Key presses and modifiers
;          -> duck_io_keyboard_recode_duck_to_workboy
;             - Use Duck Caps Lock key to emulate Workboy NUM / CAPS keys (Shift Pressed / Released)
;             - Apply Duck Shift Key to Scan Keys
;             - Translate to Workboy Scan Key via Recode Table
;          - Workboy Shift key mocking initial check
;          - Return Workboy Scan Key 



; Called via helper: duck_keyboard_read_wrapper_bank_0
;
; Request Keyboard data and handle the response
;
; Returns: translated Workboy keycode data in A
;
; Regs: Does not preserve F
duck_keyboard_poll_and_translate::

    ; The shift mocking processing is exempted from the 2 frame
    ; Mega Duck safe polling wait requirement.
    ; If there is a key to emit A will be non-zero and contain it
    call duck_keyboard_shift_mock_update
    or   a
    ret  nz

    ; Have to wait 2 frames between polling to prevent
    ; duck laptop io controller from freezing up
    ldh  a, [duck_keyboard_safe_poll_interval_count_hram]
    cp   a, DUCK_IO_KEYBD_SAFE_POLL_COUNT_OK
    jr   nz, .key_read_hardware_not_ready_to_poll
    ;
    ; Ok to read, reload safe read counter for next time
    ld   a, DUCK_IO_KEYBD_SAFE_POLL_COUNT_RESET
    ldh  [duck_keyboard_safe_poll_interval_count_hram], a

    ; Cache previous keyboard flags for testing Caps lock state changes, etc
    ld   a, [duck_key_flags]
    ld   [duck_key_flags_prev], a
    call duck_io_keyboard_poll

    cp   a, DUCK_IO_OK
    jr   nz, .key_read_failure

        .key_read_success
        ld   a, [duck_io_rx_buf_len]
        cp   a, DUCK_IO_LEN_KBD_GET
        jr   nz, .key_read_failure

        ; Scan Code and Flags
        ld   a,  [duck_io_rx_buf + DUCK_IO_KBD_FLAGS]
        ld   [duck_key_flags], a

        ld   a,  [duck_io_rx_buf + DUCK_IO_KBD_KEYCODE]
        ld   [duck_key_scancode], a

        call duck_io_keyboard_recode_duck_to_workboy
        cp   a, WORKBOY_SCAN_KEY_NONE
        ret  z
        .debug_has_key

        call duck_keyboard_shift_mock_initial_check
        ret

    .key_read_hardware_not_ready_to_poll
    ; Not sure this is required, but there may be
    ; some expectation in the code that polling
    ; the keyboard always takes at least the following
    ; delay time, since that's part of the poll function
    ; in the original code.
    ;
    ; So add that delay even when skipping polling
    ; every N frames for megaduck safe keyboard read timing
    call delay_2_94msec__334A
    ld    a, WORKBOY_SCAN_KEY_NONE
    ret

    .key_read_failure
    ; ld   a, DUCK_IO_FAIL
    ld    a, WORKBOY_SCAN_KEY_NONE
    ret


; Handle emulated NUM (SHIFT) button pressing/releasing
; which wraps keys such as "1" with the SHIFT that would
; be required to activate them on the real Workboy keyboard.
; - But without having to press SHIFT + Q.
; - Although "1" can still be sent by pressing the
;   equivalent of SHIFT + Q.
; 
; Note!
; This process is skipped IF the Workboy "shift" key was "Pressed"
; via Caps Lock on the Mega Duck being engaged.
;
DEF DUCK_WORKBOY_SHIFT_WRAP_SEND_SHIFT_DOWN  EQU 3 ; This state never gets used since it's sent immediately
DEF DUCK_WORKBOY_SHIFT_WRAP_SEND_QUEUED_KEY  EQU 2
DEF DUCK_WORKBOY_SHIFT_WRAP_SEND_SHIFT_UP    EQU 1
DEF DUCK_WORKBOY_SHIFT_WRAP_RESET            EQU 0

DEF DUCK_WORKBOY_CAPS_LOCK_NOT_ENABLED       EQU 0
DEF DUCK_WORKBOY_CAPS_LOCK_ENABLED           EQU 1
DEF DUCK_WORKBOY_CAPS_LOCK_ENABLED_BIT       EQU 0

; Preserves everything except AF
;
; Returns workboy scan key value in A
; - A will be unchanged (^1) if Shift Mocking is not needed. 1: Shift mocking bit will be stripped
; - A will have WORKBOY_SCAN_KEY_SHIFT_DOWN is needed (and will queue up follow up keys)
duck_keyboard_shift_mock_initial_check::
    ; Check if Caps lock is enabled, if so then skip the shift mocking
    push hl
    ld   hl, duck_workboy_caps_lock_enabled
    bit  DUCK_WORKBOY_CAPS_LOCK_ENABLED_BIT, [hl]
    pop  hl                        
    jr   nz, .caps_lock_on_skip_shift_mocking

        ; Check for and handle shift key emulation wrapping if needed
        bit  WORKBOY_IO_MOCK_SHIFT_BIT, a
        jr   z, .shift_mocking_check_done
            ; Strip the flag and save the keycode for sending on next poll.
            ; Then set up the state machine for handling the remaining
            ; shift mocking tasks
            res  WORKBOY_IO_MOCK_SHIFT_BIT, a
            ld   [duck_workboy_key_queued], a            
            ld   a, DUCK_WORKBOY_SHIFT_WRAP_SEND_QUEUED_KEY
            ld   [duck_workboy_shift_mock_state], a
            ; This is the key that will be returned for use
            ld   a, WORKBOY_SCAN_KEY_SHIFT_DOWN
    
        .shift_mocking_check_done
    
    .caps_lock_on_skip_shift_mocking

    ; Make sure the shift mock flag is not present and return keycode
    res  WORKBOY_IO_MOCK_SHIFT_BIT, a
    ret


; Preserves everything except AF
;
; Returns workboy scan key value in A
; - If there is no key to emit, returns: WORKBOY_SCAN_KEY_EMPTY_MAYBE
; - Otherwise returns key to send, which should be returned to app for processing
duck_keyboard_shift_mock_update::
    ld   a, [duck_workboy_shift_mock_state]
    or   a
    jr   z, .shift_mock_handling_done ; Aka: DUCK_WORKBOY_SHIFT_WRAP_RESET

    cp   a, DUCK_WORKBOY_SHIFT_WRAP_SEND_QUEUED_KEY
    jr   nz, .send_shift_released_key_and_state_to_reset

        ; DUCK_WORKBOY_SHIFT_WRAP_SEND_QUEUED_KEY
        .send_queued_key_and_increment_state
        dec  a
        ld   [duck_workboy_shift_mock_state], a
        ; This is the key that will be returned for use
        ld   a, [duck_workboy_key_queued]
        ret

        ; DUCK_WORKBOY_SHIFT_WRAP_SEND_SHIFT_UP
        .send_shift_released_key_and_state_to_reset
        ld   a, DUCK_WORKBOY_SHIFT_WRAP_RESET
        ld   [duck_workboy_shift_mock_state], a
        ; This is the key that will be returned for use
        ld   a, WORKBOY_SCAN_KEY_SHIFT_UP
        ret

    ; Done with shift mock handling and no key to send,
    ; so return WORKBOY_SCAN_KEY_EMPTY_MAYBE ($00)
    .shift_mock_handling_done    
    ld   a, WORKBOY_SCAN_KEY_EMPTY_MAYBE
    ret


; TODO: SUPPORT GERMAN MODEL VIA SHORT TRANSLATE FUNCTION
;       if (megaduck_model == MEGADUCK_LAPTOP_GERMAN)
;
; TODO: key repeat handling
;
; Returns: translated Workboy keycode data in A
;
; TODO: Handle key repeat from Duck. Simplest might be masking for no repeat
;
; Regs: Does not preserve F
duck_io_keyboard_recode_duck_to_workboy:

    push hl
    push bc

    ld   a, [duck_key_scancode]
    ld   c, a

    ; Caps lock is reserved for emulating the Workboy Shift key
    ; and is not used for normal caps lock purposes.
    ; Check whether it's state (pressed or not) has changed since the last poll
    ld   a, [duck_key_flags]
    ld   b, a
    ld   a, [duck_key_flags_prev]
    xor  b
    bit  DUCK_IO_KEY_FLAG_CAPSLOCK_BIT, a ; A has xored prev and current flags
    jr   z, .capslock_state_check_done

        .capslock_state_changed
        bit  DUCK_IO_KEY_FLAG_CAPSLOCK_BIT, b  ; B has current key state flags
        jr   z, .capslock_change_to_released

            .capslock_change_to_pressed
            ld   a, DUCK_WORKBOY_CAPS_LOCK_ENABLED
            ld   [duck_workboy_caps_lock_enabled], a  ; For tracking interaction with Mock Shifting
            ld   a, WORKBOY_SCAN_KEY_SHIFT_DOWN
            jr   .key_in_a_processing_done_ready_for_return

            .capslock_change_to_released
            ld   a, DUCK_WORKBOY_CAPS_LOCK_NOT_ENABLED
            ld   [duck_workboy_caps_lock_enabled], a  ; For tracking interaction with Mock Shifting
            ld   a, WORKBOY_SCAN_KEY_SHIFT_UP
            jr   .key_in_a_processing_done_ready_for_return
    .capslock_state_check_done


    ; Skip Shift adjustment is no key is pressed (C >= 0x80)
    bit  DUCK_IO_KEY_BASE_BIT, c
    jr   z, .shift_check_done

        ; Check Shift (used for accessing Shift-alternate keys on Duck keyboard)
        ld   a, [duck_key_flags]
        and  a, DUCK_IO_KEY_FLAG_SHIFT
        jr   z, .shift_check_done

            ; If shift is enabled, use keycode translation
            ; to activate shift alternate keys (-= 0x80u).
            .shift_active
            ld   a, c
            sub  a, DUCK_IO_KEY_BASE
            ld   c, a

    .shift_check_done
    ; C has megaduck scancode as of here

    ; Remap for german keyboard if that model was detected
    ldh  a, [duck_detected_model]
    cp   a, MEGADUCK_LAPTOP_GERMAN
    jr   nz, .german_keyboard_remapping_done
        call megaduck_keyboard_german_to_spanish_keycode_remap
    .german_keyboard_remapping_done

    ; Index into the recode table based on the megaduck key scan code
    ld   hl, megaduck_to_workboy_keyboard_keycode_recode_table_spanish
    ld   b, 0
    add  hl, bc

    ; Load resulting workboy key
    ld   a, [hl]

    .key_in_a_processing_done_ready_for_return
    pop  bc
    pop  hl
    ret
