
; DEF TARGET_MEGADUCK EQU 1
; include "../inc/hardware.inc"
; include "../inc/megaduck_laptop_io.inc"


; This location doesn't seem to conflict with
; *currently known* workboy WRAM usage (aside
; from transitory tile, etc loading)
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
duck_io_keyboard_poll:

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

        ld   a, DUCK_IO_OK
        ret

    .key_read_failure
    ld   a, DUCK_IO_FAIL
    ret

