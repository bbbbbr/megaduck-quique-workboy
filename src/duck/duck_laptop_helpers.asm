
; All of these need to be in non-banked ROM0

; Currently patched into space freed up by
; the code unused in megaduck mode:
;    `serial_io__send_command_A_wait_reply_byte_result_in_A__3356`

duck_mbc_switch_bank_A_and_cache_banknum__and_save_current_first::
    push af
    ldh   a, [duck_mbc_last_written_rom_bank]
    ldh   [duck_mbc_saved_rom_bank], a
    pop  af
duck_mbc_switch_bank_A_and_cache_banknum::
    ldh   [duck_mbc_last_written_rom_bank], a
    ld   [rMBC1_ROMBANK], a  ; [$3FFF]
    ret


duck_mbc_restore_saved_bank::
    ldh   a, [duck_mbc_saved_rom_bank]
    ldh   [duck_mbc_last_written_rom_bank], a
    ld   [rMBC1_ROMBANK], a  ; [$3FFF]
    ret

duck_keyboard_safe_poll_update__vbl_handler:
    push af
    ldh  a, [duck_keyboard_safe_poll_interval_count_hram]
    ; If ready to read then leave alone and skip decrement
    cp   a, DUCK_IO_KEYBD_SAFE_POLL_COUNT_OK
    jr   z, .done
        ; otherwise decrement
        dec   a
        ldh  [duck_keyboard_safe_poll_interval_count_hram], a

    .done
    pop af
    ; ret
    ; Instead of returning, reduce overhead by jumping next to the actual handler
    jp   vblank__handler__25CC


duck_keyboard_read_wrapper_bank_0::
    ld   a, BANK(duck_io_keyboard_poll_and_translate)
    call duck_mbc_switch_bank_A_and_cache_banknum__and_save_current_first
    ; ld   [rMBC1_ROMBANK], BANK(duck_io_keyboard_poll)

    call duck_io_keyboard_poll_and_translate

    push af
    call duck_mbc_restore_saved_bank
    pop  af

    ret
