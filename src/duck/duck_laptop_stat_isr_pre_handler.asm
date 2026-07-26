

; For duck laptop, try to handle a few things in 
; a STAT interrupt instead, to avoid the
; vblank bank switching problems in OEM code
; when polling the duck keyboard via banked code
duck_stat_isr__pre_handler_rom0:
    push af
    ldh  a, [rSTAT]
    and  STATF_LCD
    cp   STATF_VBL
    jr  nz, .not_vbl_continue_norm_stat_handling
        ; Copied from: vblank__cmd_default__25F7
        ld   a, [gfx__rBGP_cache__RAM_C27D]
        ldh  [rBGP], a
        ld   a, [lcd_isr__lyc_line_trigger__RAM_C399]
        ldh  [rLYC], a

        pop af
        reti
    .not_vbl_continue_norm_stat_handling
        pop af
        jp stat_interrupt__handler__2F64
