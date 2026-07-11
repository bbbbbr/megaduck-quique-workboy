SECTION "wram_c000", WRAM0[$C000]
shadow_oam_base__RAM_C000: db

SECTION "wram_c100", WRAM0[$C100]
vblank__frame_counter_maybe__RAM_C100: db

SECTION "wram_c102", WRAM0[$C102]
gfx__shadow_y_scroll__RAM_C102: db
gamepad_buttons__RAM_C103: db
_RAM_C104_: db
_RAM_C105_: db
_RAM_C106_: db
_RAM_C107_: db

SECTION "wram_c10a", WRAM0[$C10A]
serial_io__keyboard_detected_status__RAM_C10A: db
_RAM_C10B_: db
_RAM_C10C_: db
_RAM_C10D_: db
_RAM_C10E_: db
_RAM_C10F_: db
_RAM_C110_: db
main_menu__icon_cur_column__C111: db
main_menu__icon_cur_row__C112: db
_RAM_C113_: db
_RAM_C114_: db
main_menu__gamepad_polling_counter__C115: db
_RAM_C116_: db
_RAM_C117_: db
_RAM_C118_: db
_RAM_C119_: db
_RAM_C11A_: db
_RAM_C11B_: db

SECTION "wram_c12b", WRAM0[$C12B]
_RAM_C12B_: db
_RAM_C12C_: db
_RAM_C12D_: db

SECTION "wram_c130", WRAM0[$C130]
_RAM_C130_: db
_RAM_C131_: db
_RAM_C132_: db
gfx__dest_addr_lo__RAM_C133_maybe: db
gfx__dest_addr_hi__RAM_C134_maybe: db
gfx__src_addr_lo__RAM_C135_maybe: db
gfx__src_addr_hi__RAM_C136_maybe: db
_RAM_C137_: db
date__month__decimal__maybe__RAM_C138: db
date__days__decimal__maybe__RAM_C139: db
date__year__digit_decimal__maybe__RAM_C13A: db
_RAM_C13B_: db
_RAM_C13C_: db
_RAM_C13D_: db

SECTION "wram_c149", WRAM0[$C149]
_RAM_C149_: db
_RAM_C14A_: db

SECTION "wram_c14c", WRAM0[$C14C]
_RAM_C14C_: db

SECTION "wram_c152", WRAM0[$C152]
_RAM_C152_: db
maybe_date_related_to__dayofweek_0_to_6__RAM_C153: db
_RAM_C154_: db
_RAM_C155_: db
_RAM_C156_: db
_RAM_C157_: db
_RAM_C158_: db
_RAM_C159_: db
_RAM_C15A_: db

SECTION "wram_c16e", WRAM0[$C16E]
_RAM_C16E_: db

SECTION "wram_c181", WRAM0[$C181]
_RAM_C181_: db
_RAM_C182_: db

SECTION "wram_c196", WRAM0[$C196]
_RAM_C196_: db
_RAM_C197_: db
_RAM_C198_: db
_RAM_C199_: db
_RAM_C19A_: db
_RAM_C19B_: db
_RAM_C19C_: db

SECTION "wram_c232", WRAM0[$C232]
_RAM_C232_: db
_RAM_C233_: db
_RAM_C234_: db
_RAM_C235_: db

SECTION "wram_c237", WRAM0[$C237]
_RAM_C237_: db
_RAM_C238_: db
_RAM_C239_: db
_RAM_C23A_: db
_RAM_C23B_: db
_RAM_C23C_: db
_RAM_C23D_: db
_RAM_C23E_: db
_RAM_C23F_: db
_RAM_C240_: db
_RAM_C241_: db
_RAM_C242_: db
_RAM_C243_: db
_RAM_C244_: db
_RAM_C245_: db
_RAM_C246_: db
_RAM_C247_: db
_RAM_C248_: db
_RAM_C249_: db
_RAM_C24A_: db
_RAM_C24B_: db
_RAM_C24C_: db
_RAM_C24D_: db
_RAM_C24E_: db
_RAM_C24F_: db
_RAM_C250_: db
_RAM_C251_: db
_RAM_C252_: db
_RAM_C253_: db
_RAM_C254_: db
_RAM_C255_: db
_RAM_C256_: db
_RAM_C257_: db
_RAM_C258_: db
_RAM_C259_: db
_RAM_C25A_: db
_RAM_C25B_: db
_RAM_C25C_: db
_RAM_C25D_: db
_RAM_C25E_: db
_RAM_C25F_: db
_RAM_C260_: db
_RAM_C261_: db

SECTION "wram_c265", WRAM0[$C265]
_RAM_C265_: db

SECTION "wram_c267", WRAM0[$C267]
_RAM_C267_: db
_RAM_C268_: db

SECTION "wram_c276", WRAM0[$C276]
_RAM_C276_: db
_RAM_C277_: db
_RAM_C278_: db
_RAM_C279_: db
_RAM_C27A_: db
_RAM_C27B_: db
vblank__dispatch_select__RAM_C27C: db
gfx__rBGP_cache__RAM_C27D: db
_RAM_C27E_: db
_RAM_C27F_: db
keyboard_cur_mode__RAM_C280: db ; Might be double purposed for OAM things sometimes?
_RAM_C281_: db
_RAM_C282_: db
_RAM_C283_: db
_RAM_C284_: db

SECTION "wram_c288", WRAM0[$C288]
_RAM_C288_: db

SECTION "wram_c293", WRAM0[$C293]
_RAM_C293_: db
_RAM_C294_: db

SECTION "wram_c29f", WRAM0[$C29F]
_RAM_C29F_: db

SECTION "wram_c2a9", WRAM0[$C2A9]
serial__transfer_buffer_21_bytes__RAM_C2A9: db

    SECTION "wram_c2ae", WRAM0[$C2AE]
    serial__rtc_transfer_sub_buffer_16_bytes__RAM_C2AE: db

        SECTION "wram_c2b0", WRAM0[$C2B0]
        sioxfer_time__seconds__BCD__RAM_C2B0: db
        sioxfer_time__minutes__BCD__RAM_C2B1: db
        sioxfer_time__hours__BCD__RAM_C2B2:   db
        sioxfer_time__days__RAM_C2B3:  db
        sioxfer_time__month__RAM_C2B4: db

        SECTION "wram_c2b6", WRAM0[$C2B6]
        _RAM_C2B6_: db

        SECTION "wram_c2bd", WRAM0[$C2BD]
        sioxfer_time__year__RAM_C2BD: db

SECTION "wram_c304", WRAM0[$C304]
date__dayofweek_0_to_6_sun_to_mon__decimal__RAM_C304: db
_RAM_C305_: db
_RAM_C306_: db
_RAM_C307_: db
_RAM_C308_: db

SECTION "wram_c31d", WRAM0[$C31D]
_RAM_C31D_: db

SECTION "wram_c322", WRAM0[$C322]
_RAM_C322_: db

SECTION "wram_c327", WRAM0[$C327]
_RAM_C327_: db

SECTION "wram_c33c", WRAM0[$C33C]
_RAM_C33C_: db

SECTION "wram_c355", WRAM0[$C355]
_RAM_C355_: db
_RAM_C356_: db
_RAM_C357_: db
_RAM_C358_: db

SECTION "wram_c35b", WRAM0[$C35B]
_RAM_C35B_: db

SECTION "wram_c398", WRAM0[$C398]
_RAM_C398_: db
_RAM_C399_: db
_RAM_C39A_: db
time__hours__high_digit_ascii__RAM_C39B: db
time__hours__low_digit_ascii__RAM_C39C: db
time__minutes__high_digit_ascii__RAM_C39D: db
time__minutes__low_digit_ascii__RAM_C39E: db
time__seconds__high_digit_ascii__RAM_C39F: db
time__seconds__low_digit_ascii__RAM_C3A0: db
time__seconds__decimal__RAM_C3A1: db
time__minutes__decimal__RAM_C3A2: db
time__minutes__12_minus_min_mod_12_TODO__RAM_C3A3: db
time__hours__decimal_x_5_plus_min_div_12_NOT_DONE_TODO__RAM_C3A4: db
_RAM_C3A5_: db
_RAM_C3A6_: db
_RAM_C3A7_: db

SECTION "wram_c3a9", WRAM0[$C3A9]
_RAM_C3A9_: db
_RAM_C3AA_: db
_RAM_C3AB_: db
keycode_to_ascii_lut_ptr_lo__C3AC: db
keycode_to_ascii_lut_ptr_hi__C3AD: db

SECTION "wram_c3b0", WRAM0[$C3B0]
_RAM_C3B0_: db

SECTION "wram_c3b2", WRAM0[$C3B2]
_RAM_C3B2_: db
_RAM_C3B3_: db
_RAM_C3B4_: db
_RAM_C3B5_: db
_RAM_C3B6_: db
_RAM_C3B7_: db
_RAM_C3B8_: db
_RAM_C3B9_: db
_RAM_C3BA_: db
_RAM_C3BB_: db
_RAM_C3BC_: db
_RAM_C3BD_: db
_RAM_C3BE_: db
_RAM_C3BF_: db
_RAM_C3C0_: db
_RAM_C3C1_: db
_RAM_C3C2_: db
_RAM_C3C3_: db
_RAM_C3C4_: db
_RAM_C3C5_: db
_RAM_C3C6_: db
_RAM_C3C7_: db
_RAM_C3C8_: db
_RAM_C3C9_: db
_RAM_C3CA_: db
_RAM_C3CB_: db
_RAM_C3CC_: db
_RAM_C3CD_: db
_RAM_C3CE_: db
_RAM_C3CF_: db
_RAM_C3D0_: db
_RAM_C3D1_: db
_RAM_C3D2_: db
_RAM_C3D3_: db
_RAM_C3D4_: db
_RAM_C3D5_: db
_RAM_C3D6_: db
_RAM_C3D7_: db
_RAM_C3D8_: db
_RAM_C3D9_: db
_RAM_C3DA_: db
_RAM_C3DB_: db
_RAM_C3DC_: db
_RAM_C3DD_: db
_RAM_C3DE_: db
_RAM_C3DF_: db
_RAM_C3E0_: db
_RAM_C3E1_: db
_RAM_C3E2_: db
_RAM_C3E3_: db

SECTION "wram_c3ec", WRAM0[$C3EC]
_RAM_C3EC_: db

SECTION "wram_c3f8", WRAM0[$C3F8]
_RAM_C3F8_: db
_RAM_C3F9_: db
_RAM_C3FA_: db
_RAM_C3FB_: db

SECTION "wram_c402", WRAM0[$C402]
_RAM_C402_: db
_RAM_C403_: db

SECTION "wram_c409", WRAM0[$C409]
_RAM_C409_: db
_RAM_C40A_: db
_RAM_C40B_: db
_RAM_C40C_: db

SECTION "wram_c413", WRAM0[$C413]
_RAM_C413_: db
_RAM_C414_: db

SECTION "wram_c41a", WRAM0[$C41A]
_RAM_C41A_: db
_RAM_C41B_: db
_RAM_C41C_: db
_RAM_C41D_: db

SECTION "wram_c42b", WRAM0[$C42B]
_RAM_C42B_: db
_RAM_C42C_: db

SECTION "wram_c440", WRAM0[$C440]
_RAM_C440_: db

SECTION "wram_c44a", WRAM0[$C44A]
_RAM_C44A_: db
_RAM_C44B_: db
_RAM_C44C_: db
_RAM_C44D_: db
_RAM_C44E_: db
_RAM_C44F_: db
_RAM_C450_: db
_RAM_C451_: db
_RAM_C452_: db
_RAM_C453_: db
_RAM_C454_: db
_RAM_C455_: db

SECTION "wram_c464", WRAM0[$C464]
_RAM_C464_: db

SECTION "wram_c466", WRAM0[$C466]
_RAM_C466_: db
_RAM_C467_: db

SECTION "wram_c46f", WRAM0[$C46F]
_RAM_C46F_: db
_RAM_C470_: db
_RAM_C471_: db
_RAM_C472_: db
_RAM_C473_: db
_RAM_C474_: db
_RAM_C475_: db
keyboard__prob_current_key__RAM_C476: db
keyboard__prob_previous_key__RAM_C477: db
_RAM_C478_: db
_RAM_C479_: db
_RAM_C47A_: db
_RAM_C47B_: db
_RAM_C47C_: db
_RAM_C47D_: db

SECTION "wram_c486", WRAM0[$C486]
_RAM_C486_: db
_RAM_C487_: db

SECTION "wram_c490", WRAM0[$C490]
_RAM_C490_: db
_RAM_C491_: db

SECTION "wram_c49a", WRAM0[$C49A]
_RAM_C49A_: db

SECTION "wram_c4a4", WRAM0[$C4A4]
_RAM_C4A4_: db
_RAM_C4A5_: db
_RAM_C4A6_: db
_RAM_C4A7_: db

SECTION "wram_c56d", WRAM0[$C56D]
_RAM_C56D_: db

SECTION "wram_c58c", WRAM0[$C58C]
_RAM_C58C_: db
_RAM_C58D_: db
_RAM_C58E_: db
_RAM_C58F_: db
_RAM_C590_: db
_RAM_C591_: db
_RAM_C592_: db
_RAM_C593_: db
_RAM_C594_: db
_RAM_C595_: db
_RAM_C596_: db
_RAM_C597_: db

SECTION "wram_c59b", WRAM0[$C59B]
_RAM_C59B_: db
_RAM_C59C_: db

SECTION "wram_c5c4", WRAM0[$C5C4]
_RAM_C5C4_: db
_RAM_C5C5_: db
_RAM_C5C6_: db
_RAM_C5C7_: db
_RAM_C5C8_: db
_RAM_C5C9_: db
_RAM_C5CA_: db
_RAM_C5CB_: db
_RAM_C5CC_: db
_RAM_C5CD_: db

SECTION "wram_c5d1", WRAM0[$C5D1]
_RAM_C5D1_: db
_RAM_C5D2_: db
_RAM_C5D3_: db
_RAM_C5D4_: db
_RAM_C5D5_: db

SECTION "wram_c5df", WRAM0[$C5DF]
_RAM_C5DF_: db
_RAM_C5E0_: db

SECTION "wram_c5f2", WRAM0[$C5F2]
_RAM_C5F2_: db
_RAM_C5F3_: db
_RAM_C5F4_: db
_RAM_C5F5_: db

SECTION "wram_c700", WRAM0[$C700]
_RAM_C700_: db
_RAM_C701_: db
_RAM_C702_: db
_RAM_C703_: db
_RAM_C704_: db
_RAM_C705_: db
_RAM_C706_: db

SECTION "wram_c714", WRAM0[$C714]
_RAM_C714_: db

SECTION "wram_c764", WRAM0[$C764]
_RAM_C764_: db

SECTION "wram_c778", WRAM0[$C778]
_RAM_C778_: db

SECTION "wram_c78c", WRAM0[$C78C]
_RAM_C78C_: db

SECTION "wram_c7b4", WRAM0[$C7B4]
_RAM_C7B4_: db

SECTION "wram_c800", WRAM0[$C800]
_RAM_C800_: db

SECTION "wram_c900", WRAM0[$C900]
_RAM_C900_: db

SECTION "wram_cefe", WRAM0[$CEFE]
gfx__tilemap_string_addr_table__RAM_CEFE: db

SECTION "wram_cf00", WRAM0[$CF00]
_RAM_CF00_: db

SECTION "wram_cf04", WRAM0[$CF04]
_RAM_CF04_: db

SECTION "wram_cf16", WRAM0[$CF16]
_RAM_CF16_: db
_RAM_CF17_: db

SECTION "wram_cf1c", WRAM0[$CF1C]
_RAM_CF1C_: db

SECTION "wram_cf1e", WRAM0[$CF1E]
_RAM_CF1E_: db

SECTION "wram_cf20", WRAM0[$CF20]
_RAM_CF20_: db

SECTION "wram_cf2c", WRAM0[$CF2C]
_RAM_CF2C_: db
_RAM_CF2D_: db
_RAM_CF2E_: db

SECTION "wram_cf72", WRAM0[$CF72]
_RAM_CF72_: db

SECTION "wram_cfa4", WRAM0[$CFA4]
_RAM_CFA4_: db

SECTION "wram_cfa6", WRAM0[$CFA6]
_RAM_CFA6_: db

SECTION "wram_cfd8", WRAM0[$CFD8]
_RAM_CFD8_: db

SECTION "wram_cff0", WRAM0[$CFF0]
_RAM_CFF0_: db

SECTION "wram_d00c", WRAMX[$D00C]
_RAM_D00C_: db

SECTION "wram_d06c", WRAMX[$D06C]
_RAM_D06C_: db

SECTION "wram_d09e", WRAMX[$D09E]
_RAM_D09E_: db

SECTION "wram_d0d0", WRAMX[$D0D0]
_RAM_D0D0_: db

; WARNING 
;
; This area and beyond will get wiped at least two times
; if not more.
; Once at startup (clear wram), and another time when 
; lots of tiles get loaded into wram.
; So beware using this area for any variables that 
; need to persist.

; See:
;  SECTION "Duck Laptop IO WRAM",       WRAMX[$D100]
;  SECTION "Duck Laptop Keyboard WRAM", WRAMX[$D130] 
;  SECTION "Duck Laptop IO WRAM",       WRAMX[$D140]

IF DEF(BUILD_USE_DUCK_LAPTOP_HARDWARE)
    SECTION "wram__duck_laptop_rtc_sysrom_validate_key_start__dbfc", WRAMX[$DBFC]
    duck_laptop_rtc_sysrom_validate_key_start__RAM_DBFC: ds 4
ENDC
