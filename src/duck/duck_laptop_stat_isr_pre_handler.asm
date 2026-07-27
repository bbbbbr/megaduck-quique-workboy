

; For duck laptop, try to handle a few things in 
; a STAT interrupt instead, to avoid the
; VBlank bank switching problems in OEM code
; when polling the duck keyboard via banked code
duck_stat_isr__pre_handler_rom0:
    push af
    ldh  a, [rSTAT]
    and  STATF_LCD
    cp   STATF_VBL
    jr  nz, .not_vbl_continue_norm_stat_handling

        ; Transplanted Time ~60hz tick VBlank update
        ; from time_date__increment_time__2FE6
        ld   a, [time__60hz_tick_count__RAM_C3A5]
        or   a
        ; Let the vblank time and date handler deal with rollover even
        ; though it might mean losing a 60th of second here or there
        jr  z, .no_60hz_dec_tick
            dec  a
        .no_60hz_dec_tick
        ld   [time__60hz_tick_count__RAM_C3A5], a

        ; Transplanted BGP / LYC effect VBlank cleanup
        ;
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
