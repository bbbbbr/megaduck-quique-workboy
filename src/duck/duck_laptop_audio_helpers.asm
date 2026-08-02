
; All of these need to be in non-banked ROM0

; Audio helpers

duck_audio__rAUD1ENV_nibble_swap_from_hl_and_hl_inc:
    ; MegaDuck: rAUD1ENV: nybble swap
    ldi  a, [hl]
    swap a
    ldh  [rAUD1ENV], a
    ret


duck_audio__rAUD2ENV_nibble_swap_from_hl_and_hl_inc:
    ; MegaDuck: rAUD2ENV: nybble swap
    ldi  a, [hl]
    swap a
    ldh  [rAUD2ENV], a
    ret


duck_audio__rAUD3LEVEL_swizzle_from_hl_and_hl_inc:
    ; MegaDuck: rAUD3LEVEL: volume bit swizzle
    ; #MD NR32: Translate volume. New Volume = ((0x00 - Volume) & 0x60)
    ; GB: Bits:6..5 : 00 = mute, 01 = 100%, 10 = 50%, 11 = 25%
    ; MD: Bits:6..5 : 00 = mute, 11 = 100%, 10 = 50%, 01 = 25%        
    ldi  a, [hl]
    cpl
    add $20 ; start bit rollover at bit 5 to ignore possible values in lower bits (vs add 1)
    ldh  [rAUD3LEVEL], a
    ret


duck_audio__rAUD4ENV_rAUD4POLY_nibble_swap_from_hl_and_hl_inc:
    ; MegaDuck: rAUD4ENV & rAUD4POL: nybble swap
    ldi  a, [hl]      ; Handled in Caller
    swap a
    ldh  [rAUD4ENV], a
    ldi  a, [hl]
    swap a
    ldh  [rAUD4POLY], a ; Handled in Caller
    ret



duck_audio__serial_io__sound_trigger_handler:
    ; Copied from the end of: send_command_and_wait_reply__3361
        ld   a, [maybe__audio__serial_io__reply_byte__sound_trigger__RAM_C110]  ; TODO: What is this testing after a serial transfer? set to 4 on initial startup, then 1 on startup, and later 0 or 1 occasionally
        or   a
        ; jr   z, .return_serial_reply_byte_in_A__3388
        ret  z
        ld   a, $24
        ld   bc, $0211
        call audio__maybe_serial_io__sound_handler__33FC
    ret


; Preserves everything except flags
duck_audio__serial_io__sound_trigger_handler__keyboard:
    or   a
    jr   z, .done
    cp   WORKBOY_SCAN_KEY_NONE
    jr   z, .done
        push af
        push bc
        push de
        push hl
            ld   a, $24
            ld   bc, $0211
            call audio__maybe_serial_io__sound_handler__33FC
        pop  hl
        pop  de
        pop  bc
        pop  af
    .done
    ret