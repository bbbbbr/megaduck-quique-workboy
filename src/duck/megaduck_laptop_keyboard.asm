
; DEF TARGET_MEGADUCK EQU 1
; include "../inc/hardware.inc"
; include "../inc/megaduck_laptop_io.inc"


SECTION "Duck Laptop Keyboard WRAM", WRAMX[$D130]
duck_key_scancode:: db
duck_key_flags:: db


; SECTION "Duck Laptop Keyboard", ROM0
;
; Leave section floating to be placed inside the removed
; Italian Translation section in Bank 4
SECTION "Duck Laptop Keyboard", ROMX, BANK[$4]

; Request Keyboard data and handle the response
;
; Returns: translated Workboy keycode data in A
;
; Regs: Does not preserve F
duck_io_keyboard_poll_and_translate:

    ; Have to wait 2 frames between polling to prevent
    ; duck laptop io controller from freezing up
    ldh  a, [duck_keyboard_safe_poll_interval_count_hram]
    cp   a, DUCK_IO_KEYBD_SAFE_POLL_COUNT_OK
    jr   nz, .key_read_hardware_not_ready_to_poll
    ;
    ; Ok to read, reload safe read counter for next time
    ld   a, DUCK_IO_KEYBD_SAFE_POLL_COUNT_RESET
    ldh  [duck_keyboard_safe_poll_interval_count_hram], a

    ; Poll the duck hardware keyboard
    ld   a, DUCK_IO_CMD_GET_KEYS
    call duck_io_send_cmd_and_receive_buffer

    cp   a, DUCK_IO_OK
    jr   nz, .key_read_failure

        .key_read_success
        ld   a, [duck_io_rx_buf_len]
        cp   a, DUCK_IO_LEN_KBD_GET
        jr   nz, .key_read_failure

        ; Scan Code and Flags
        ld  a,  [duck_io_rx_buf + DUCK_IO_KBD_FLAGS]
        ld  [duck_key_flags], a

        ld  a,  [duck_io_rx_buf + DUCK_IO_KBD_KEYCODE]
        ld  [duck_key_scancode], a

        call duck_io_keyboard_recode_duck_to_workboy
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


; TODO: SUPPORT GERMAN MODEL VIA SHORT TRANSLATE FUNCTION
;       if (megaduck_model == MEGADUCK_LAPTOP_GERMAN)
;
; TODO: ; Could megaduck code directly manipulate the shift/altmap recode table var?
;   call set_keycode_lut_ptr__altmap_OFF__026C
;   call set_keycode_lut_ptr__altmap_ON__002B
;
; TODO: // Handle caps/shift/etc for A-Z
; TODO: key repeat handling
;
;
; Returns: translated Workboy keycode data in A
duck_io_keyboard_recode_duck_to_workboy:

    ld   a, [duck_key_scancode]
    ld   c, a

    ; Check Shift and Caps Lock
    ld   a, [duck_key_flags]
    and  a, (DUCK_IO_KEY_FLAG_CAPSLOCK | DUCK_IO_KEY_FLAG_SHIFT)
    cp   a, (DUCK_IO_KEY_FLAG_CAPSLOCK | DUCK_IO_KEY_FLAG_SHIFT)
    jr   nz, .shift_check_done

        ; If only shift OR caps lock is enabled, use keycode translation
        ; to activate shift alternate keys (-= 0x80u).
        ; Otherwise they negate each other
        .only_shift_or_capslock
        ld   a, c
        sub  a, DUCK_IO_KEY_BASE
        ld   c, a

    .shift_check_done

    ; C has megaduck scancode as of here
    ; Index into the recode table based on the megaduck key scan code
    ld   hl, megaduck_to_workboy_keyboard_keycode_recode_table
    ld   b, 0
    add  hl, bc

    ; Load resulting workboy key
    ld  a, [hl]
    ret


; TODO: 
; Returns: translated Workboy keycode data in A
; duck_io_keyboard_remap_german_to_spanish:
;
; char duck_io_scancode_to_ascii(const uint8_t key_code, const uint8_t megaduck_model) {
;     char ascii_char = scancode_to_ascii_LUT_spanish[key_code];
;     // Handle alternate German keyboard layout
;     if (megaduck_model == MEGADUCK_LAPTOP_GERMAN)
;         switch (ascii_char) {
;             // Row 1
;             // case '·':  ascii_char = '§'; break;  // TODO: handling for these
;             case '\'': ascii_char = 'ß'; break;
;             // case '¿':  ascii_char = '`'; break;  // TODO: handling for these
;             // case '¡':  ascii_char = '\''; break; // TODO: handling for these
;             case '÷':  ascii_char = ':'; break;
;             // Row 2
;             case '[':  // maps to same char below
;             case '`':  ascii_char = 'Ü'; break;
;             case ']':  ascii_char = '·'; break;
;             case 'y':  ascii_char = 'z'; break;
;             case 'Y':  ascii_char = 'Z'; break;
;             // Row 3
;             // case 'ñ':  ascii_char = 'ö'; break; // TODO: handling for these
;             // case 'Ñ':  ascii_char = 'Ö'; break; // TODO: handling for these
;             // case 'ü':  ascii_char = 'ä'; break; // TODO: handling for these
;             // case 'Ü':  ascii_char = 'Ä'; break; // TODO: handling for these
;             // case 'ª':  ascii_char = '^'; break; // TODO: handling for these
;             // case 'º':  ascii_char = '#'; break; // TODO: handling for these
;             // Row 4
;             case 'z':  ascii_char = 'y'; break;
;             case 'Z':  ascii_char = 'Y'; break;
;             case '-':  ascii_char = '@'; break;
;         }

;     return ascii_char;
; }


