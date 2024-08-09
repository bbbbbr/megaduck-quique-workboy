
; Turn on to enable skipping some hardware specific code
; so that the QuiQue ROM will run the Main Menu on a GB
; def DEBUG_SKIP_WORKBOY_STARTUP_CHECK = 1

; Temp workaround while MBC1 isn't supported in Sameduck
def DEBUG_USE_DUCK_MBC = 1

; Temp workaround for lack of duck MBC SRAM
def DEBUG_USE_DUCK_MBC_NO_SRAM = 1

include "inc/hardware.inc"



; MBC Register defines
DEF rMBC1_RAM_ENABLE     EQU $00FF
; $0002 used once instead of $00FF for (?) SRAM enable
; TODO: WARNING! Writing to $0002 will clash with Zwenergy Pico Pi Mega Duck Flash cart : Cart Select Register address
DEF rMBC1_RAM_ENABLE_ALT EQU $0002
DEF rMBC1_MODE_SEL       EQU $7FFF

DEF MBC1_RAM_ON         EQU $0A
DEF MBC1_RAM_OFF        EQU $00
DEF MBC1_MODE_RAMBANKED EQU $01

; $4000 used once instead of $5FFF for SRAM bank switching
DEF rRAMB_ALT           EQU $5FFF

IF (DEF(DEBUG_USE_DUCK_MBC) && DEF(TARGET_MEGADUCK))
    DEF rMBC1_ROMBANK    EQU $0001
ELSE
    DEF rMBC1_ROMBANK    EQU $3FFF
ENDC

DEF SERIAL_XFER_OFF EQU $00

DEF GAMEPAD_B_DOWN    EQU 7
DEF GAMEPAD_B_UP      EQU 6
DEF GAMEPAD_B_LEFT    EQU 5
DEF GAMEPAD_B_RIGHT   EQU 4
DEF GAMEPAD_B_START   EQU 3
DEF GAMEPAD_B_SELECT  EQU 2
DEF GAMEPAD_B_B       EQU 1
DEF GAMEPAD_B_A       EQU 0



DEF WORKBOY_KEY_NONE  EQU  $FF

; These keys are likely after some kind of Key scan code -> Translated system key
; TODO: Maybe they need a different naming (check quique)
DEF WORKBOY_KEY_RETURN        EQU  $0D ; Matches ms vkey

DEF WORKBOY_KEY_ARROW_UP      EQU  $0F
DEF WORKBOY_KEY_ARROW_LEFT    EQU  $10
DEF WORKBOY_KEY_ARROW_RIGHT   EQU  $11
DEF WORKBOY_KEY_ARROW_DOWN    EQU  $12


; Commands sent to the Workboy peripheral over serial IO
DEF WORKBOY_CMD_READKEY  EQU "O" ; $4F 


DEF MAIN_MENU__GAMEPAD_POLLTIME_RESET  EQU  20 ; $14


; Queue-able VBL Commands
DEF VBL_CMD__DEFAULT__0x00 EQU $00
DEF VBL_CMD__COPY_TEXT__0x0F EQU $0f


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
_RAM_C10A_: db
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
_RAM_C138_: db
_RAM_C139_: db
_RAM_C13A_: db
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
_RAM_C153_: db
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
_RAM_C27D_: db
_RAM_C27E_: db
_RAM_C27F_: db
_RAM_C280_: db
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
_RAM_C2A9_: db

SECTION "wram_c2ae", WRAM0[$C2AE]
_RAM_C2AE_: db

SECTION "wram_c2b0", WRAM0[$C2B0]
_RAM_C2B0_: db
_RAM_C2B1_: db
_RAM_C2B2_: db
_RAM_C2B3_: db
_RAM_C2B4_: db

SECTION "wram_c2b6", WRAM0[$C2B6]
_RAM_C2B6_: db

SECTION "wram_c2bd", WRAM0[$C2BD]
_RAM_C2BD_: db

SECTION "wram_c304", WRAM0[$C304]
_RAM_C304_: db
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
_RAM_C39B_: db
_RAM_C39C_: db
_RAM_C39D_: db
_RAM_C39E_: db
_RAM_C39F_: db
_RAM_C3A0_: db
_RAM_C3A1_: db
_RAM_C3A2_: db
_RAM_C3A3_: db
_RAM_C3A4_: db
_RAM_C3A5_: db
_RAM_C3A6_: db
_RAM_C3A7_: db

SECTION "wram_c3a9", WRAM0[$C3A9]
_RAM_C3A9_: db
_RAM_C3AA_: db
_RAM_C3AB_: db
_RAM_C3AC_: db
_RAM_C3AD_: db

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
_RAM_C476_: db
_RAM_C477_: db
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

SECTION "hram_ff80", HRAM[$FF80]
gfx__oam_dma__RAM_FF80: db

SECTION "hram_ff8a", HRAM[$FF8A]
ie_reg_cache__RAM_FF8A: db

SECTION "hram_ff8c", HRAM[$FF8C]
_RAM_FF8C_: db

SECTION "hram_ffe1", HRAM[$FFE1]
_RAM_FFE1_: db

SECTION "sram_a000", SRAM[$A000]
_SRAM_0_: db
_SRAM_1_: db
_SRAM_2_: db

SECTION "sram_a006", SRAM[$A006]
_SRAM_6_: db

SECTION "sram_a02a", SRAM[$A02A]
_SRAM_2A_: db

SECTION "sram_a1f5", SRAM[$A1F5]
_SRAM_1F5_: db

SECTION "sram_a1f9", SRAM[$A1F9]
_SRAM_1F9_: db

SECTION "sram_a221", SRAM[$A221]
_SRAM_221_: db
_SRAM_222_: db
_SRAM_223_: db

SECTION "sram_a231", SRAM[$A231]
_SRAM_231_: db

SECTION "sram_a233", SRAM[$A233]
_SRAM_233_: db

SECTION "sram_a235", SRAM[$A235]
_SRAM_235_: db

SECTION "sram_a238", SRAM[$A238]
_SRAM_238_: db

SECTION "sram_a9ef", SRAM[$A9EF]
_SRAM_9EF_: db
_SRAM_9F0_: db

SECTION "sram_a9fa", SRAM[$A9FA]
_SRAM_9FA_: db

SECTION "sram_aa04", SRAM[$AA04]
_SRAM_A04_: db
_SRAM_A05_: db

SECTION "sram_aa08", SRAM[$AA08]
_SRAM_A08_: db

SECTION "sram_aa12", SRAM[$AA12]
_SRAM_A12_: db

SECTION "sram_aa25", SRAM[$AA25]
_SRAM_A25_: db

SECTION "sram_c000", SRAM[$A000], BANK[1]
_SRAM_2000_: db
_SRAM_2001_: db
_SRAM_2002_: db

SECTION "sram_dfff", SRAM[$BFFF], BANK[1]
_SRAM_3FFF_: db

SECTION "sram_e000", SRAM[$A000], BANK[2]
_SRAM_4000_: db

SECTION "sram_e002", SRAM[$A002], BANK[2]
_SRAM_4002_: db

SECTION "sram_e02a", SRAM[$A02A], BANK[2]
_SRAM_402A_: db

SECTION "sram_10000", SRAM[$A000], BANK[3]
_SRAM_6000_: db

SECTION "sram_10006", SRAM[$A006], BANK[3]
_SRAM_6006_: db

SECTION "sram_10015", SRAM[$A015], BANK[3]
_SRAM_6015_: db

SECTION "sram_1002a", SRAM[$A02A], BANK[3]
_SRAM_602A_: db
_SRAM_602B_: db
_SRAM_602C_: db

SECTION "sram_10100", SRAM[$A100], BANK[3]
_SRAM_6100_: db

; ; Ports
; rP1 EQU $00
; rSB EQU $01
; rSC EQU $02
; rIF EQU $0F
; rAUD1SWEEP EQU $10
; rAUD1LEN EQU $11
; rAUD1ENV EQU $12
; rAUD1LOW EQU $13
; rAUD1HIGH EQU $14
; rAUD2LEN EQU $16
; rAUD2ENV EQU $17
; rAUD2LOW EQU $18
; rAUD2HIGH EQU $19
; rAUD3ENA EQU $1A
; rAUD3LEVEL EQU $1C
; rAUD3LOW EQU $1D
; rAUD3HIGH EQU $1E
; rAUD4ENV EQU $21
; rAUD4POLY EQU $22
; rAUD4GO EQU $23
; rAUDVOL EQU $24
; rAUDTERM EQU $25
; rAUDENA EQU $26
; _AUD3WAVERAM EQU $30
; _PORT_31_ EQU $31
; rLCDC EQU $40
; rSTAT EQU $41
; rSCY EQU $42
; rSCX EQU $43
; rLY EQU $44
; rLYC EQU $45
; rDMA EQU $46
; rBGP EQU $47
; rOBP0 EQU $48
; rOBP1 EQU $49
; rIE EQU $FF

SECTION "rom0", ROM0
_LABEL_0_:
	jp   startup_init__0150

; Data from 3 to 6 (4 bytes)
_DATA_3_:
db $25, $0C, $00, $2D

; Data from 7 to 7 (1 bytes)
_DATA_7_:
db $25


; Polls the keyboard for input
; - Resulting key returned in A
; - If no key or error will be WORKBOY_KEY_NONE (0xFF)
SERIAL_POLL_KEYBOARD__RST_8:
	jp   serial_io__poll_keyboard__3278

; Data from B to F (5 bytes)
db $25, $06, $00, $D5, $25

_LABEL_10_:
	jp   _LABEL_1D0D_

; Data from 13 to 17 (5 bytes)
_DATA_13_:
db $25, $04, $00, $F4, $25

VSYNC__RST_18:
	jp   gfx__vsync__2548

; Data from 1B to 1F (5 bytes)
db $25, $04, $00, $F4, $25

_LABEL_20_:
	jp   _LABEL_FEE_

; Data from 23 to 27 (5 bytes)
db $25, $0E, $00, $F5, $25

; _RST_28:
COPY_STRING_VRAM__RST_28:
	jp   gfx__copy_string_to_vram_centered__1019

_LABEL_2B_:
	ld   a, $5D
	ld   [_RAM_C3AC_], a
	ld   a, $31
	ld   [_RAM_C3AD_], a
	ret

; Data from 36 to 3F (10 bytes)
db $06, $26, $06, $00, $06, $26, $06, $00, $06, $26

INT_VBL__RST_40:
	jp   vblank__handler__25CC

; Data from 43 to 47 (5 bytes)
db $26, $0E, $00, $12, $26

_LABEL_48_:
	jp   _LABEL_2F64_

; Data from 4B to 83 (57 bytes)
db $26, $0E, $00, $12, $26, $ED, $4D, $12, $26, $0E, $00, $12, $26, $ED, $4D, $12
db $26, $0E, $00, $12, $26, $ED, $4D, $02, $02, $01, $00, $01, $40, $01, $80, $01
db $C0, $02, $02, $02, $00, $02, $40, $02, $80, $02, $C0, $02, $02, $03, $00, $03
db $40, $03, $80, $03, $C0, $02, $02, $04, $00

; Data from 84 to 9B (24 bytes)
_DATA_84_:
db $04, $40, $04, $80, $04, $C0, $02, $02, $05, $00, $05, $40, $05, $80, $05, $C0
db $02, $02, $06, $00, $06, $40, $06, $80

; Data from 9C to EF (84 bytes)
_DATA_9C_:
db $06, $C0, $02, $02, $07, $00, $07, $40, $07, $80, $07, $C0, $02, $02, $01, $00
db $02, $00, $03, $00, $04, $00, $03, $04, $00, $00, $01, $00, $00, $00, $02, $00
db $03, $00, $04, $00, $05, $00, $06, $00, $07, $00, $08, $00, $09, $00, $00, $00
db $03, $04, $00, $00, $0A, $00, $00, $00, $0B, $00, $0C, $00, $0D, $00, $0E, $00
db $0F, $00, $10, $00, $11, $00, $12, $00, $00, $00, $02, $02, $13, $00, $14, $00
db $15, $00, $16, $00

_LABEL_F0_:
	ld   b, $26
_LABEL_F2_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_F2_
	ret

; Data from F9 to FF (7 bytes)
db $00, $4C, $27, $0E, $00, $84, $27

gb_entry_point__0100:
	nop
	jp   startup_init__0150

GBcartridgeHeader:
; Nintendo Logo: OK
db $CE, $ED, $66, $66, $CC, $0D, $00, $0B, $03, $73, $00, $83, $00, $0C, $00, $0D
db $00, $08, $11, $1F, $88, $89, $00, $0E, $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99
db $BB, $BB, $67, $63, $6E, $0E, $EC, $CC, $DD, $DC, $99, $9F, $BB, $B9, $33, $3E

db "WORKBOY", $00, $00, $00, $00 ; Title
db $00, $00, $00, $00 ; Manufacturer Code / End of Title
db $00      ; CGB Flag: Game does not support CGB functions.
db $00, $00 ; New Licensee Code
db $00      ; SGB Flag: No SGB functions (Normal Gameboy or CGB only game)
db $03      ; Cartridge Type: MBC1+RAM+BATTERY
db $02      ; ROM Size: 128 KByte 	8 banks
db $03      ; RAM Size: 32 KBytes (4 banks of 8KBytes each)
db $01      ; Destination Code: Non-Japanese
db $48      ; Old Licensee Code
db $00      ; Mask ROM Version number
db $69      ; Header Checksum: OK
dw $DC17    ; Global Checksum: OK

startup_init__0150:
	di
	ld   hl, $FFFE
	ld   sp, hl
	call gfx__copy_oam_dma_to_RAM__2743

    ; Clear WRAM
	ld   hl, _RAM
	ld   bc, $2000
    .startup__clear_wram_loop__015E:
    	xor  a
    	ldi  [hl], a
    	dec  bc
    	ld   a, b
    	or   c
    	jr   nz, .startup__clear_wram_loop__015E

	ld   a, $04
	ldh  [rSTAT], a
	ld   [_RAM_C110_], a
	ld   a, $1B
	ldh  [rBGP], a
	ld   [_RAM_C27D_], a
	ld   a, $D2
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	ld   a, (LCDCF_ON | LCDCF_OBJON | LCDCF_BGON) ; $83
	ldh  [rLCDC], a
	ld   a, $01
	ldh  [rIE], a
	ldh  [_RAM_FF8C_], a
	call gfx__clear_shadow_oam__275B
	ld   hl, _RAM_C19C_
	ld   a, $1E
	ld   de, $0005

    .LABEL_018E:
    	ld   [hl], $FF
    	add  hl, de
    	dec  a
    	jr   nz, .LABEL_018E
	ei
	xor  a
	ldh  [rSCX], a
	ldh  [rSCY], a
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	ld   a, [_DATA_3_ - 2]
	ld   [_RAM_C10E_], a
	call _LABEL_2F41_

    ; Maybe startup delay for the keyboard accessory hardware
    ; Calls vsync() 75 times in a row, ~1250 msec
    ;
	ld   b, 75 ; Wait ~75 frames $4B
    .startup_wait_loop__01A8:
    	rst  $18	; Call VSYNC__RST_18
    	dec  b
    	jr   nz, .startup_wait_loop__01A8

	xor  a
	ld   [_RAM_C10E_], a
	ld   a, $02
	ld   [_RAM_C10A_], a
    IF (DEF(DEBUG_SKIP_WORKBOY_STARTUP_CHECK))
        nop
        nop
        nop
    ELSE
    	call _LABEL_2854_
    ENDC
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	ld   a, $FF
	ld   [_RAM_C3B2_], a
	ld   [_RAM_C3BC_], a
	ld   [_RAM_C3C6_], a
	ld   [_RAM_C3D0_], a
	call _LABEL_380D_
	halt
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	halt
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	halt
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	halt
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	halt
	call mbc_sram_ON_rombank_1_srambank_0__0AFD
	halt
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_E42E_
	ld   a, $01
	ld   [_RAM_C10F_], a
	ld   a, [_RAM_C304_]
	push af
	call _LABEL_2B7D_
	pop  af
	ld   [_RAM_C304_], a
	call _LABEL_D58_
	xor  a
	ld   [_RAM_C10F_], a
_LABEL_200_:
	ld   a, $03
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   hl, _RAM_C700_
	ld   de, _SRAM_6006_
	call _LABEL_F0_
	xor  a
	ld   [_RAM_C5F3_], a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   hl, _SRAM_6_
	ld   de, _RAM_C700_
	call _LABEL_F0_
	call _LABEL_380D_
	call gfx__clear_shadow_oam__275B
	ld   a, $01
	ld   [_RAM_C110_], a
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	xor  a
	ld   [_RAM_C595_], a
	ld   [_RAM_C19A_], a
	ld   [_RAM_C23F_], a
	ld   [_RAM_C117_], a
	ld   [_RAM_C260_], a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ldh  [rSCX], a
	call _LABEL_26C_
	di
	ld   a, $04
	ldh  [rSTAT], a
	ld   a, $01
	ldh  [rIE], a
	ei
	ld   hl, $FFFE
	ld   sp, hl
	ld   a, $1B
	ldh  [rBGP], a
	ld   [_RAM_C27D_], a
	ld   a, [_RAM_C10A_]
	or   a
	jp   z, _LABEL_10C3_
	ld   a, $D2
	ldh  [rOBP0], a
	call _LABEL_277_
	jr   _LABEL_200_

_LABEL_26C_:
	ld   a, $28
	ld   [_RAM_C3AC_], a
	ld   a, $31
	ld   [_RAM_C3AD_], a
	ret

_LABEL_277_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call gfx__turn_off_screen_2827
	ld   hl, (_TILEDATA8000 + $10)
	ld   a, $FF
	ld   b, $10
_LABEL_285_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_285_
	ld   a, $07
	call _LABEL_3918_
    ; Zero-init some vars
	xor  a
	ld   [main_menu__gamepad_polling_counter__C115], a
	ld   [_RAM_C113_], a
	ld   a, $0A
	ld   [_RAM_C114_], a

main_menu__loop_start__029A:
	rst  $18	; Call VSYNC__RST_18
	call gfx__clear_shadow_oam__275B

    ; Check to see if a cursor move update is Queued
	ld   a, [_RAM_C113_]
	or   a
	jr   z, _LABEL_2C2_

    ; Main Menu Icon Current Row range: 0 - 2
    ;
    ; ((ROW x 64) - (ROW x 8)) - 20 == (ROW x 56) - 20
    ; So: 0 -> 20, 1 -> 36, 2 -> 92
	ld   a, [main_menu__icon_cur_column__C111]
	add  a
	add  a
	add  a
	ld   c, a
	add  a
	add  a
	add  a
	sub  c
	add  20 ; $14
	ld   c, a
    ; (Column x 32) + 28
    ; So: 0 -> 28, 1 -> 60, 2 -> 92, 3 -> 124
	ld   a, [main_menu__icon_cur_row__C112]
	add  a
	add  a
	add  a
	add  a
	add  a
	add  28 ; $1C
	ld   b, a
	ld   e, $00
    ; B: (Column x 32) + 28
    ; C: (Row    x 56) - 20
    ; E: 0x00
	call _LABEL_1504_

    _LABEL_2C2_:
        ; TODO: Decrements C114 until 0, then: wraps it around to 0x19, and inverts C113 (which iirc usually set to 0 or 1)
    	ld   a, [_RAM_C114_]
    	dec  a
    	jr   nz, _LABEL_2D2_
    	ld   a, [_RAM_C113_]
    	xor  $01
    	ld   [_RAM_C113_], a
    	ld   a, $19

    _LABEL_2D2_:
    	ld   [_RAM_C114_], a
    	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
    	cp   WORKBOY_KEY_NONE  ; $FF
    	jp   nz, main_menu__keyboard_handle_result__034F

        ; Check whether it's time to poll the Gamepad for input
    	ld   a, [main_menu__gamepad_polling_counter__C115]
    	or   a
    	jr   z, main_menu__gamepad_check__02E7
        ; If not, decrement the counter and continue to main loop
    	dec  a
    	ld   [main_menu__gamepad_polling_counter__C115], a
    	jr   main_menu__loop_start__029A

    main_menu__gamepad_check__02E7:
    	ld   a, [gamepad_buttons__RAM_C103]
    	or   a
    	jr   z, main_menu__loop_start__029A

        ; Skip to next if not pressed
    	bit  GAMEPAD_B_LEFT, a  ; 5
    	jr   z, main_menu__gamepad_test_right__030A

        ; Triggered by Gamepad LEFT or Keyboard LEFT
        main_menu__nav_col_left__02F1:
            ; Move icon highlight cursor LEFT
        	ld   a, [main_menu__icon_cur_column__C111]
        	dec  a
            ; Handle < 0 wraparound, reset to 0x02 (right-most column)
        	cp   $FF
        	jr   nz, mainmenu__nav_col_update__02FB__MAYBE
        	ld   a, $02

    mainmenu__nav_col_update__02FB__MAYBE:
        ; Save updated column position
    	ld   [main_menu__icon_cur_column__C111], a
    	ld   a, $01
    	ld   [_RAM_C113_], a  ; TODO: is this enqueuing an update? (it gets toggled every other frame on no activity though?)
    	ld   a, MAIN_MENU__GAMEPAD_POLLTIME_RESET  ; $14
    	ld   [main_menu__gamepad_polling_counter__C115], a
    	jr   main_menu__loop_start__029A

    main_menu__gamepad_test_right__030A:
        ; Skip to next if not pressed
    	bit  GAMEPAD_B_RIGHT, a  ; 4
    	jr   z, main_menu__gamepad_test_down__0319

        ; Triggered by Gamepad RIGHT or Keyboard RIGHT
        main_menu__nav_col_right__030E:
            ; Move icon highlight cursor RIGHT
        	ld   a, [main_menu__icon_cur_column__C111]
        	inc  a
            ; Handle > 2 wraparound, reset to 0x00 (left-most column)
        	cp   $03
        	jr   nz, mainmenu__nav_col_update__02FB__MAYBE
        	xor  a
        	jr   mainmenu__nav_col_update__02FB__MAYBE


    main_menu__gamepad_test_down__0319:
        ; Skip to next if not pressed
    	bit  GAMEPAD_B_DOWN, a  ; 7
    	jr   z, main_menu__gamepad_test_up__0333

        ; Triggered by Gamepad DOWN or Keyboard DOWN
        main_menu__nav_row_down_031D:
        	ld   a, [main_menu__icon_cur_row__C112]
        	inc  a

    mainmenu__nav_row_update__0321:
        ; Handle < 0 and > 3 wraparound, clamp to 0 - 3
    	and  $03
    	ld   [main_menu__icon_cur_row__C112], a
    	ld   a, $01
    	ld   [_RAM_C113_], a
    	ld   a, MAIN_MENU__GAMEPAD_POLLTIME_RESET  ; $14
    	ld   [main_menu__gamepad_polling_counter__C115], a
    	jp   main_menu__loop_start__029A


    main_menu__gamepad_test_up__0333:
        ; Skip to next if not pressed
    	bit  GAMEPAD_B_UP, a  ; 6
    	jr   z, main_menu__gamepad_test_select__033D

        ; Triggered by Gamepad UP or Keyboard UP
        main_menu__nav_row_up__0337:
        	ld   a, [main_menu__icon_cur_row__C112]
        	dec  a
        	jr   mainmenu__nav_row_update__0321


    main_menu__gamepad_test_select__033D:
        ; Restart main menu loop if not pressed
    	bit  GAMEPAD_B_SELECT, a  ; 2
    	jp   z, main_menu__loop_start__029A

        ; Triggered by Gamepad SELECT or Keyboard ENTER
        main_menu__nav_do_launch__0342:
            ; Calculate linear index from menu row and column
            ; TODO : then launch program (?)
        	ld   a, [main_menu__icon_cur_row__C112]
        	ld   c, a
        	add  a
        	add  c
        	ld   c, a
        	ld   a, [main_menu__icon_cur_column__C111]
        	add  c
            ; C has: (row x 3) + column
        	jr   _LABEL_376_ ; TODO: Maybe this launches program?

    main_menu__keyboard_handle_result__034F:
    	cp   WORKBOY_KEY_ARROW_UP  ; $0F
    	jr   z, main_menu__nav_row_up__0337

    	cp   WORKBOY_KEY_ARROW_DOWN  ; $12
    	jr   z, main_menu__nav_row_down_031D

    	cp   WORKBOY_KEY_ARROW_LEFT  ; $10
    	jr   z, main_menu__nav_col_left__02F1

    	cp   WORKBOY_KEY_ARROW_RIGHT  ; $11
    	jr   z, main_menu__nav_col_right__030E

    	cp   WORKBOY_KEY_RETURN  ; $0D
    	jr   z, main_menu__nav_do_launch__0342

    	or   a
    	jp   z, main_menu__loop_start__029A

    	cp   $0A
    	jp   nc, main_menu__loop_start__029A

    	ld   hl, _DATA_399_ - 1
    	ld   d, $00
    	ld   e, a
    	add  hl, de
    	ld   a, [hl]
    	jr   _LABEL_376_

    _LABEL_376_:
    	push af
    	ld   b, $00
    _LABEL_379_:
    	cp   $03
    	jr   c, _LABEL_382_
    	sub  $03
    	inc  b
    	jr   _LABEL_379_

    _LABEL_382_:
    	ld   [main_menu__icon_cur_column__C111], a
    	ld   a, b
    	ld   [main_menu__icon_cur_row__C112], a
    	call gfx__clear_shadow_oam__275B
    	pop  af
    	add  a
    	ld   hl, _DATA_3A2_
    	ld   d, $00
    	ld   e, a
    	add  hl, de
    	ldi  a, [hl]
    	ld   h, [hl]
    	ld   l, a
    	jp   hl

; Data from 399 to 3A1 (9 bytes)
_DATA_399_:
db $00, $06, $09, $01, $04, $07, $02, $05, $0B

; Jump Table from 3A2 to 3B9 (12 entries, indexed by main_menu__icon_cur_column__C111)
_DATA_3A2_:
dw _LABEL_2F8E_, _LABEL_338A_, _LABEL_CA0_, _LABEL_2209_, _LABEL_819_, _LABEL_1572_, _LABEL_2B3B_, _LABEL_1598_
dw _LABEL_AF1_, _LABEL_2845_, _LABEL_D49_, _LABEL_BA2_

_LABEL_3BA_:
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00E6
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $00E7
	call _LABEL_1D2D_
	ld   bc, $0A09
	call _LABEL_BC3_
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	call _LABEL_206D_
	cp   $01
	jp   z, _LABEL_2845_
	jp   _LABEL_AF1_

_LABEL_3EF_:
	ld   a, $65
	ld   [_RAM_C198_], a
	ld   a, $66
	ld   [_RAM_C199_], a
	ld   a, $1B
	ldh  [rBGP], a
	ld   [_RAM_C27D_], a
	call gfx__turn_off_screen_2827
	ld   bc, $1008
	call _LABEL_27DD_
	call _LABEL_450_

	ld   a, BANK(gfx__tile_patterns_256_font_clock_etc__4000) ; $01
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   hl, _TILEDATA9000
	ld   bc, gfx__tile_patterns_256_font_clock_etc__4000
	xor  a ; Copy 256 tiles
	jp   gfx__copy_tile_patterns__1437

_LABEL_41B_:
	call _LABEL_424_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

_LABEL_424_:
	ld   a, $6A
	ld   [_RAM_C198_], a
	ld   a, $6B
	ld   [_RAM_C199_], a
	ld   a, $1B
	ldh  [rBGP], a
	ld   [_RAM_C27D_], a
	call gfx__turn_off_screen_2827
	ld   bc, $1008
	call _LABEL_27DD_
	call _LABEL_450_

    ld   a, BANK(gfx__tile_patterns_250_font_thermometer_etc__5000) ; $01
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   hl, _TILEDATA9000
	ld   bc, gfx__tile_patterns_250_font_thermometer_etc__5000
	xor  a ; Copy 256 tiles
	jp   gfx__copy_tile_patterns__1437

_LABEL_450_:
	ld   a, $07
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, $8420
	ld   de, _DATA_1CE92_
	ld   bc, _DATA_1CE9A_
	ld   a, 60; $3C ; Copy 60 tiles
	jp   gfx__interleave_copy_tile_patterns__144C

_LABEL_463_:
	ld   a, $07
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, $8420
	ld   de, _DATA_1FD5A_
	ld   bc, _DATA_1FD62_
	ld   a, 18 ; $12 ; Copy 18 tiles
	call gfx__interleave_copy_tile_patterns__144C

	ld   hl, $8540
	ld   bc, _DATA_1FE76_
	ld   a, $04 ; Copy 4 tiles
	jp   gfx__copy_tile_patterns__1437

_LABEL_481_:
	xor  a
	ld   [_RAM_C116_], a
	ld   a, $07
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, $8420
	ld   de, _DATA_1FEB1_
	ld   bc, _DATA_1FEB9_
	ld   a, 8 ; $08 ; Copy 8 tiles
	jp   gfx__interleave_copy_tile_patterns__144C

_LABEL_498_:
	ld   a, $02
	ld   [_RAM_C5F3_], a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	xor  a
	ld   [_RAM_C11B_], a
	ld   [_RAM_C23B_], a
	ld   a, $F2
	ldh  [rOBP0], a
	ld   a, $01
	ld   [_RAM_C117_], a
	call _LABEL_3EF_
	call _LABEL_2722_
	call _LABEL_64E_
	ld   bc, $FFE4
	ld   e, $70
	call _LABEL_1CF6_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_E4D0_

_LABEL_4C9_:
	xor  a
	ld   [_RAM_C474_], a
	ld   a, [_RAM_C281_]
	push af
	ld   a, [_RAM_C282_]
	push af
	ld   a, $88
	ld   [_RAM_C282_], a
	ld   a, $88
	ld   [_RAM_C281_], a
	ld   hl, _RAM_C118_
	ld   a, $20
	ldi  [hl], a
	ldi  [hl], a
	ldi  [hl], a
	ld   a, $03
	ld   [_RAM_C280_], a
	call _LABEL_2B_
	ld   a, $09
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_4F4_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_4F4_
	or   a
	jr   nz, _LABEL_509_
	pop  af
	ld   [_RAM_C282_], a
	pop  af
	ld   [_RAM_C281_], a
	ret

_LABEL_509_:
	cp   $80
	jr   nz, _LABEL_52A_
	ld   a, [_RAM_C474_]
	or   a
	jr   z, _LABEL_4F4_
	dec  a
	ld   [_RAM_C474_], a
	ld   hl, $C118
	ld   e, a
	ld   d, $00
	add  hl, de
	ld   [hl], $20
	ld   a, [_RAM_C281_]
	sub  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_4F4_

_LABEL_52A_:
	cp   $0D
	jr   z, _LABEL_554_
	cp   $30
	jr   c, _LABEL_4F4_
	cp   $3A
	jr   nc, _LABEL_4F4_
	ld   c, a
	ld   a, [_RAM_C474_]
	cp   $03
	jr   z, _LABEL_4F4_
	ld   hl, $C118
	ld   d, $00
	ld   e, a
	add  hl, de
	ld   [hl], c
	ld   hl, _RAM_C474_
	inc  [hl]
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_4F4_

_LABEL_554_:
	ld   a, [_RAM_C5F3_]
	or   a
	call nz, $667B	; Possibly invalid
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	pop  af
	ld   [_RAM_C282_], a
	pop  af
	ld   [_RAM_C281_], a
	ld   a, [_RAM_C474_]
	or   a
	ret  z
	cp   $03
	jp   z, _LABEL_596_
	cp   $02
	jr   nz, _LABEL_588_
	ld   a, [_RAM_C119_]
	ld   [_RAM_C11A_], a
	ld   a, [_RAM_C118_]
	ld   [_RAM_C119_], a
	ld   a, $30
	ld   [_RAM_C118_], a
	jr   _LABEL_596_

_LABEL_588_:
	ld   a, [_RAM_C118_]
	ld   [_RAM_C11A_], a
	ld   a, $30
	ld   [_RAM_C118_], a
	ld   [_RAM_C119_], a
_LABEL_596_:
	ld   bc, $0064
	ld   hl, $0000
	ld   a, [_RAM_C118_]
	sub  $30
_LABEL_5A1_:
	or   a
	jr   z, _LABEL_5A8_
	add  hl, bc
	dec  a
	jr   nz, _LABEL_5A1_
_LABEL_5A8_:
	ld   c, $0A
	ld   a, [_RAM_C119_]
	sub  $30
_LABEL_5AF_:
	or   a
	jr   z, _LABEL_5B6_
	add  hl, bc
	dec  a
	jr   nz, _LABEL_5AF_
_LABEL_5B6_:
	ld   a, [_RAM_C11A_]
	sub  $30
_LABEL_5BB_:
	or   a
	jr   z, _LABEL_5C2_
	inc  hl
	dec  a
	jr   nz, _LABEL_5BB_
_LABEL_5C2_:
	ld   a, h
	or   a
	ret  nz
	ld   a, [_RAM_C19A_]
	or   a
	jr   z, _LABEL_5D5_
	ld   a, [_SRAM_1_]
	cp   l
	ret  c
	ld   a, l
	ld   [_RAM_C10C_], a
	ret

_LABEL_5D5_:
	ld   a, [_RAM_C260_]
	or   a
	jr   z, _LABEL_5E9_
	ld   a, [_SRAM_231_]
	cp   l
	ret  c
	ld   a, l
	or   a
	ret  z
	ld   [_RAM_C10B_], a
	jp   _LABEL_B765_

_LABEL_5E9_:
	ld   a, [_SRAM_0_]
	cp   l
	ret  c
	ld   a, l
	or   a
	ret  z
	ld   [_RAM_C10D_], a
	call _LABEL_680_
	call _LABEL_6D0_
	ld   a, $08
	ld   [_RAM_C281_], a
	add  a
	ld   [_RAM_C282_], a
	ret

; 10th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_604_:
	ld   de, _RAM_C118_
	ld   hl, $99F0
	ld   b, $03
_LABEL_60C_:
	ld   a, [de]
	sub  $20
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_60C_
	jp   vblank__cmd_default__25F7

; Data from 617 to 62B (21 bytes)
_DATA_617_:
ds 20, $2A
db $00

_LABEL_62C_:
	ld   de, $0617
	ld   hl, $99C0
	rst  $20	; _LABEL_20_
	ld   de, $0001
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0004
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $0005
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	ld   a, [_RAM_C10C_]
	jp   _LABEL_7B6_

_LABEL_64E_:
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
_LABEL_654_:
	call _LABEL_65D_
	call _LABEL_680_
	jp   _LABEL_6D0_

_LABEL_65D_:
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $0003
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
_LABEL_667_:
	call gfx__turn_on_screen_bg_obj__2540
	ld   hl, $99C0
	ld   de, $0617
	rst  $20	; _LABEL_20_
	ld   hl, $9A00
	ld   de, $0004
	rst  $20	; _LABEL_20_
	ld   hl, $9A20
	ld   de, $0005
	rst  $20	; _LABEL_20_
	ret

_LABEL_680_:
	ld   a, [_RAM_C10D_]
	or   a
	ret  z
	call _LABEL_7B3_
	ld   hl, _SRAM_4002_
	ld   a, [_RAM_C10D_]
	ld   b, a
_LABEL_68F_:
	dec  b
	jr   z, _LABEL_699_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	dec  hl
	add  hl, de
	jr   _LABEL_68F_

_LABEL_699_:
	inc  hl
	inc  hl
	ld   de, _RAM_C700_
	ld   b, $0E
_LABEL_6A0_:
	push bc
	ld   b, $14
_LABEL_6A3_:
	ldi  a, [hl]
	cp   $0D
	jr   z, _LABEL_6C4_
	bit  7, a
	jr   z, _LABEL_6BD_
	and  $7F
	ld   c, a
	ld   a, $20
_LABEL_6B1_:
	ld   [de], a
	inc  de
	dec  b
	dec  c
	jr   nz, _LABEL_6B1_
	ld   a, b
	or   a
	jr   nz, _LABEL_6A3_
	jr   _LABEL_6CB_

_LABEL_6BD_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_6A3_
	jr   _LABEL_6CB_

_LABEL_6C4_:
	ld   a, $20
_LABEL_6C6_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_6C6_
_LABEL_6CB_:
	pop  bc
	dec  b
	jr   nz, _LABEL_6A0_
	ret

_LABEL_6D0_:
	ld   a, [_RAM_C10D_]
	or   a
	ret  z
	call _LABEL_7B3_
	rst  $18	; Call VSYNC__RST_18
	ld   de, _TILEMAP0
	ld   hl, _RAM_C700_
	ld   b, $0E
	ld   a, $05
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_6E6_:
	push bc
	push de
	push hl
	ld   a, e
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, d
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, l
	ld   [gfx__src_addr_lo__RAM_C135_maybe], a
	ld   a, h
	ld   [gfx__src_addr_hi__RAM_C136_maybe], a
	rst  $18	; Call VSYNC__RST_18
	pop  hl
	ld   bc, $0014
	add  hl, bc
	pop  de
	ld   a, $20
	add  e
	ld   e, a
	ld   a, d
	adc  $00
	ld   d, a
	pop  bc
	dec  b
	jr   nz, _LABEL_6E6_
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

_LABEL_711_:
	push af
	ld   a, [_RAM_C282_]
	ld   hl, $C700
	ld   bc, $0014
	sub  $10
	jr   z, _LABEL_724_
_LABEL_71F_:
	add  hl, bc
	sub  $08
	jr   nz, _LABEL_71F_
_LABEL_724_:
	ld   a, [_RAM_C281_]
	sub  $08
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	pop  af
	ld   [hl], a
_LABEL_73A_:
	push af
	ld   hl, _TILEMAP0
	ld   a, [_RAM_C282_]
	ld   bc, $0020
	sub  $10
	jr   z, _LABEL_74D_
_LABEL_748_:
	add  hl, bc
	sub  $08
	jr   nz, _LABEL_748_
_LABEL_74D_:
	ld   a, [_RAM_C281_]
	sub  $08
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	add  l
	ld   [_RAM_C131_], a
	ld   a, h
	adc  $00
	ld   [_RAM_C132_], a
	pop  af
	ld   [_RAM_C130_], a
	ret

_LABEL_76A_:
	push af
	ld   a, [_RAM_C281_]
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   d, $00
	ld   e, a
	ld   hl, $C119
	add  hl, de
	pop  af
	ld   [hl], a
	jr   _LABEL_73A_

_LABEL_782_:
	push af
	ld   a, [_RAM_C281_]
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   d, $00
	ld   e, a
	ld   hl, $C11A
	add  hl, de
	pop  af
	ld   [hl], a
	jr   _LABEL_73A_

; 8th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_79A_:
	ld   a, [_RAM_C130_]
	or   a
	jr   z, _LABEL_7B0_
	sub  $20
	ld   c, a
	ld   a, [_RAM_C131_]
	ld   l, a
	ld   a, [_RAM_C132_]
	ld   h, a
	ld   [hl], c
	xor  a
	ld   [_RAM_C130_], a
_LABEL_7B0_:
	jp   vblank__cmd_default__25F7

_LABEL_7B3_:
	ld   a, [_RAM_C10D_]
_LABEL_7B6_:
	or   a
	ret  z
	ld   bc, $0000
_LABEL_7BB_:
	cp   $64
	jr   c, _LABEL_7C4_
	sub  $64
	inc  b
	jr   _LABEL_7BB_

_LABEL_7C4_:
	cp   $0A
	jr   c, _LABEL_7CD_
	sub  $0A
	inc  c
	jr   _LABEL_7C4_

_LABEL_7CD_:
	add  $30
	ld   [gfx__src_addr_lo__RAM_C135_maybe], a
	ld   a, b
	add  $30
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, c
	add  $30
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, $06
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

; 7th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_7E9_:
	ld   hl, $99F0
	ld   de, gfx__dest_addr_lo__RAM_C133_maybe
	ld   b, $03
_LABEL_7F1_:
	ld   a, [de]
	sub  $20
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_7F1_
	jp   vblank__cmd_default__25F7

; 6th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_7FC_:
	ld   a, [gfx__dest_addr_lo__RAM_C133_maybe]
	ld   e, a
	ld   a, [gfx__dest_addr_hi__RAM_C134_maybe]
	ld   d, a
	ld   a, [gfx__src_addr_lo__RAM_C135_maybe]
	ld   l, a
	ld   a, [gfx__src_addr_hi__RAM_C136_maybe]
	ld   h, a
	ld   b, $14
_LABEL_80E_:
	ldi  a, [hl]
	sub  $20
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_80E_
	jp   vblank__cmd_default__25F7

; 5th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_819_:
	ld   a, $FE
	ldh  [rOBP0], a
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_RAM_C139_]
	ld   [_RAM_C152_], a
	ld   a, [_RAM_C138_]
	ld   [_RAM_C154_], a
	ld   a, [_RAM_C13A_]
	ld   [_RAM_C155_], a
	ld   a, [_RAM_C137_]
	ld   [_RAM_C153_], a
_LABEL_839_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, [_RAM_C152_]
	push af
	ld   a, $01
	ld   [_RAM_C152_], a
	call _LABEL_1273_
	pop  af
	ld   [_RAM_C152_], a
	di
	ld   a, $04
	ldh  [rSTAT], a
	ld   a, $01
	ldh  [rIE], a
	ei
	ld   a, $0A
	ld   [_RAM_C27E_], a
	xor  a
	ld   [_RAM_C27F_], a
	call gfx__turn_off_screen_2827

	ld   a, BANK(gfx__tile_patterns_256_font_clock_etc__4000) ; $01
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   bc, gfx__tile_patterns_256_font_clock_etc__4000
	ld   hl, _TILEDATA9000
	xor  a ; Copy 256 tiles
	call gfx__copy_tile_patterns__1437

	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   de, _DATA_9E17_
	ld   hl, _TILEMAP0
	ld   b, $12
_LABEL_87F_:
	push bc
	ld   b, $14
_LABEL_882_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_882_
	ld   c, $0C
	add  hl, bc
	pop  bc
	dec  b
	jr   nz, _LABEL_87F_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_C831_

_LABEL_897_:
	ld   a, $F2
	ldh  [rOBP0], a
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   [_RAM_C23E_], a
	call gfx__turn_off_screen_2827
	call _LABEL_27DD_
	call _LABEL_481_
	call _LABEL_B45_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_8C5_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_C154_

_LABEL_8BC_:
	call _LABEL_8E3_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

_LABEL_8C5_:
	ld   a, [$0000]
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, $03
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, $05
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   hl, $4E5C
	ld   de, _SRAM_6100_
	call _LABEL_17CAD_
	ld   a, $03
	jp   mbc_sram_ON_set_srambank_to_A__0BB1

_LABEL_8E3_:
	ld   a, $D2
	ldh  [rOBP0], a
	call gfx__turn_off_screen_2827
	call _LABEL_27DD_
	call _LABEL_481_
	ld   a, $C8
	ld   [_RAM_C399_], a
	call _LABEL_B45_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_8C5_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_C047_

; Data from 906 to 913 (14 bytes)
db $2A, $EA, $52, $C1, $2A, $EA, $54, $C1, $2A, $EA, $55, $C1, $18, $18

_LABEL_914_:
	ld   a, [_RAM_C304_]
	ld   [_RAM_C153_], a
	ld   a, [_RAM_C139_]
	ld   [_RAM_C152_], a
	ld   a, [_RAM_C138_]
	ld   [_RAM_C154_], a
	ld   a, [_RAM_C13A_]
	ld   [_RAM_C155_], a
_LABEL_92C_:
	ld   a, [_RAM_C153_]
	ld   c, a
	add  a
	add  c
	ld   hl, _RAM_D09E_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	add  e
	ld   e, a
	ld   a, d
	adc  $00
	ld   d, a
	ld   hl, _RAM_C13D_
	ld   b, $03
_LABEL_943_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_943_
	ld   a, [_SRAM_2A_]
	or   a
	jr   z, _LABEL_966_
	ld   a, [_RAM_C154_]
	call _LABEL_974_
	ld   a, $2F
	ldi  [hl], a
	ld   a, [_RAM_C152_]
_LABEL_95B_:
	call _LABEL_974_
	ld   a, $2F
	ldi  [hl], a
	ld   a, [_RAM_C155_]
	jr   _LABEL_974_

_LABEL_966_:
	ld   a, [_RAM_C152_]
	call _LABEL_974_
	ld   a, $2F
	ldi  [hl], a
	ld   a, [_RAM_C154_]
	jr   _LABEL_95B_

_LABEL_974_:
	ld   b, $00
_LABEL_976_:
	cp   $0A
	jr   c, _LABEL_97F_
	sub  $0A
	inc  b
	jr   _LABEL_976_

_LABEL_97F_:
	ld   c, a
	ld   a, b
	add  $30
_LABEL_983_:
	cp   $3A
	jr   c, _LABEL_98B_
	sub  $0A
	jr   _LABEL_983_

_LABEL_98B_:
	ldi  [hl], a
	ld   a, c
	add  $30
	ldi  [hl], a
	ret

_LABEL_991_:
	ld   de, _RAM_C39B_
	ld   hl, _RAM_C149_
	ldi  a, [hl]
	ld   [de], a
	inc  de
	ldi  a, [hl]
	ld   [de], a
	inc  de
	inc  hl
	ldi  a, [hl]
	ld   [de], a
	inc  de
	ldi  a, [hl]
	ld   [de], a
	ld   a, [_RAM_C152_]
	ld   [_RAM_C139_], a
	ld   a, [_RAM_C153_]
	ld   [_RAM_C304_], a
	ld   a, [_RAM_C154_]
	ld   [_RAM_C138_], a
	ld   de, $2150
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0006
	ld   hl, $99E3
	rst  $28	; COPY_STRING_VRAM__RST_28
_LABEL_9C3_:
	call _LABEL_E6C_
	or   a
	jr   z, _LABEL_9C3_
	cp   $FF
	jr   z, _LABEL_9C3_
	ret

_LABEL_9CE_:
	ld   a, [_RAM_C139_]
	ld   [_RAM_C152_], a
	ld   a, [_RAM_C304_]
	ld   [_RAM_C153_], a
	ld   a, [_RAM_C138_]
	ld   [_RAM_C154_], a
	ld   a, [_RAM_C13A_]
	ld   [_RAM_C155_], a
	ld   hl, _RAM_C13D_
	ld   a, $20
	ld   b, $14
_LABEL_9ED_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_9ED_
	ld   de, _RAM_C39B_
	ld   hl, _RAM_C149_
	ld   b, $03
_LABEL_9F9_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	ld   a, [de]
	inc  de
	ldi  [hl], a
	ld   a, $3A
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_9F9_
	call _LABEL_A1C_
	ld   a, [_RAM_C305_]
	push af
	ld   a, [_SRAM_602C_]
	xor  $80
	ld   [_RAM_C305_], a
	call _LABEL_A1C_
	pop  af
	ld   [_RAM_C305_], a
	ret

_LABEL_A1C_:
	xor  a
	ld   [_RAM_C3A7_], a
	ld   a, [_RAM_C305_]
	bit  7, a
	jr   z, _LABEL_A84_
	ld   c, $00
	bit  6, a
	jr   z, _LABEL_A3D_
	ld   a, [_RAM_C14C_]
	sub  $03
	cp   $30
	jr   nc, _LABEL_A3A_
	add  $06
	ld   c, $01
_LABEL_A3A_:
	ld   [_RAM_C14C_], a
_LABEL_A3D_:
	ld   a, [_RAM_C305_]
	and  $1F
	add  c
	ld   c, a
	ld   a, [_RAM_C149_]
	sub  $30
	add  a
	ld   e, a
	add  a
	add  a
	add  e
	ld   e, a
	ld   d, $00
	ld   a, [_RAM_C14A_]
	sub  $30
	add  e
	sub  c
	jr   nc, _LABEL_A5E_
	add  $18
	ld   d, $01
_LABEL_A5E_:
	ld   b, $00
_LABEL_A60_:
	cp   $0A
	jr   c, _LABEL_A69_
	sub  $0A
	inc  b
	jr   _LABEL_A60_

_LABEL_A69_:
	add  $30
	ld   [_RAM_C14A_], a
	ld   a, b
	add  $30
	ld   [_RAM_C149_], a
	dec  d
	ret  nz
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_AF93_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

_LABEL_A84_:
	ld   c, $00
	bit  6, a
	jr   z, _LABEL_A9A_
	ld   a, [_RAM_C14C_]
	add  $03
	cp   $36
	jr   c, _LABEL_A97_
	sub  $06
	ld   c, $01
_LABEL_A97_:
	ld   [_RAM_C14C_], a
_LABEL_A9A_:
	ld   a, [_RAM_C305_]
	and  $1F
	add  c
	ld   c, a
	ld   a, [_RAM_C149_]
	sub  $30
	add  a
	ld   e, a
	add  a
	add  a
	add  e
	ld   e, a
	ld   d, $00
	ld   a, [_RAM_C14A_]
	sub  $30
	add  e
	add  c
	cp   $18
	jr   c, _LABEL_ABD_
	sub  $18
	ld   d, $01
_LABEL_ABD_:
	ld   b, $00
_LABEL_ABF_:
	cp   $0A
	jr   c, _LABEL_AC8_
	sub  $0A
	inc  b
	jr   _LABEL_ABF_

_LABEL_AC8_:
	add  $30
	ld   [_RAM_C14A_], a
	ld   a, b
	add  $30
	ld   [_RAM_C149_], a
	dec  d
	ret  nz
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_AF32_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

_LABEL_AE3_:
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_AF32_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

; 9th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_AF1_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_DDD9_


; Sets MBC1 to the following
; - Enable SRAM
; - Upper ROM Bank = 1
; -      SRAM Bank = 0
mbc_sram_ON_rombank_1_srambank_0__0AFD:
    ; Writing 1 to ROM bank select
    ; Select SRAM Bank switch mode and then
    ; write 0 to the SRAM Bank select
	ld   a, MBC1_RAM_ON          ; $0A
	ld   [rMBC1_RAM_ENABLE], a   ; [$00FF]

	ld   a, $01
	ld   [rMBC1_ROMBANK], a      ; [$3FFF]

	ld   a, MBC1_MODE_RAMBANKED  ; $01
	ld   [rMBC1_MODE_SEL], a     ; [$7FFF]

	xor  a
	ld   [rRAMB_ALT], a          ; [$5FFF]
	ret


; Sends byte in A over Serial IO and waits ~3msec, then turns Serial RX OFF
;
; Preserves AF
serial_io__send_byte_and_wait_3msec__0B11:
	ldh  [rSB], a
	push af
	ld   a, (SERIAL_XFER_ENABLE | SERIAL_CLOCK_INT) ; $81
	ldh  [rSC], a
	call delay_2_94msec__334A
	ld   a, ( SERIAL_XFER_OFF ) ; $00
	ldh  [rSC], a
	pop  af
	ret


_LABEL_B21_:
	ld   a, $03
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, $01
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_7D28_
_LABEL_B2E_:
	push af
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	pop  af
	ret

_LABEL_B36_:
	ld   a, $03
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, $05
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_2A05_
	jr   _LABEL_B2E_

_LABEL_B45_:
	call gfx__turn_off_screen_2827

	ld   bc, _DATA_15B4C_
	ld   hl, _TILEDATA9000
	ld   a, $05
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	xor  a ; Copy 256 tiles
	call gfx__copy_tile_patterns__1437
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_2735_
	ld   de, _DATA_A524_
	ld   hl, (_TILEMAP0 + $60)
	ld   b, $0C
	call _LABEL_396E_
	jr   _LABEL_B2E_

_LABEL_B6C_:
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_B160_
	jr   _LABEL_B2E_

; Data from B76 to B98 (35 bytes)
db $04, $02, $01, $FC, $02, $01, $04, $02, $01, $FC, $02, $01, $04, $02, $01, $FC
db $02, $01, $04, $02, $01, $FC, $02, $01, $04, $02, $01, $FC, $02, $01, $63, $00
db $01, $0A, $63

_LABEL_B99_:
	call _LABEL_3EF_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

; 12th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_BA2_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call _LABEL_3EF_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_E7EC_


; Sets MBC1 SRAM bank:
; - Enable SRAM
; - SRAM Bank = value in reg A
mbc_sram_ON_set_srambank_to_A__0BB1:
    ; Enable SRAM
    ; Select SRAM Bank switch mode and then
    ; write value in C to SRAM Bank select
	push bc
	ld   c, a
	ld   a, MBC1_RAM_ON          ; $0A
	ld   [rMBC1_RAM_ENABLE], a   ; [$00FF]

	ld   a, MBC1_MODE_RAMBANKED  ; $01$01
	ld   [rMBC1_MODE_SEL], a     ; [$7FFF]

	ld   a, c
	ld   [rRAMB_ALT], a          ; [$5FFF]
	pop  bc
	ret


_LABEL_BC3_:
	ld   [_RAM_C156_], a
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, e
	ld   [_RAM_C196_], a
	ld   a, d
	ld   [_RAM_C197_], a
	ld   a, c
	ld   [_RAM_C157_], a
	ld   a, b
	ld   [_RAM_C158_], a
	add  a
	add  a
	ld   h, $00
	ld   l, a
	add  hl, hl
	add  hl, hl
	add  hl, hl
	ld   de, _TILEMAP0
	add  hl, de
	ld   a, l
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, h
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, $02
	ld   [_RAM_C159_], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $16
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_BFA_:
	ld   hl, _RAM_C15A_
	ld   a, $FF
	ld   b, $14
_LABEL_C01_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C01_
	ld   hl, _RAM_C182_
	ld   a, $FF
	ld   b, $14
_LABEL_C0C_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C0C_
	ld   hl, _RAM_C16E_
	ld   a, [_RAM_C196_]
	ld   e, a
	ld   a, [_RAM_C197_]
	ld   d, a
	ld   b, $14
_LABEL_C1D_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C1D_
	ld   hl, $C15A
	ld   a, [_RAM_C157_]
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   de, $0014
	push hl
	ld   [hl], $5F
	add  hl, de
	ld   a, [_RAM_C198_]
	ld   [hl], a
	add  hl, de
	ld   [hl], $62
	pop  hl
	inc  hl
	ld   a, [_RAM_C159_]
	sub  $02
_LABEL_C46_:
	or   a
	jr   z, _LABEL_C55_
	push hl
	ld   [hl], $60
	add  hl, de
	add  hl, de
	ld   [hl], $63
	pop  hl
	inc  hl
	dec  a
	jr   _LABEL_C46_

_LABEL_C55_:
	ld   [hl], $61
	add  hl, de
	ld   a, [_RAM_C199_]
	ld   [hl], a
	add  hl, de
	ld   [hl], $64
	ld   hl, _RAM_C16E_
	ld   a, [_RAM_C198_]
	ld   c, a
_LABEL_C66_:
	ld   a, [hl]
	cp   c
	jr   z, _LABEL_C6F_
	ld   [hl], $FF
	inc  hl
	jr   _LABEL_C66_

_LABEL_C6F_:
	ld   hl, _RAM_C181_
	ld   a, [_RAM_C199_]
	ld   c, a
_LABEL_C76_:
	ld   a, [hl]
	cp   c
	jr   z, _LABEL_C7F_
	ld   [hl], $FF
	dec  hl
	jr   _LABEL_C76_

_LABEL_C7F_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C156_]
	ld   c, a
	ld   a, [_RAM_C159_]
	cp   c
	jr   z, _LABEL_C9A_
	inc  a
	ld   [_RAM_C159_], a
	bit  0, a
	jp   z, _LABEL_BFA_
	ld   hl, _RAM_C157_
	dec  [hl]
	jp   _LABEL_BFA_

_LABEL_C9A_:
	rst  $18	; Call VSYNC__RST_18
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

; 3rd entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_CA0_:
	ld   a, $02
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_SRAM_4000_]
	or   a
	jr   z, _LABEL_CAD_
	ld   a, $01
_LABEL_CAD_:
	ld   [_RAM_C10D_], a
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call _LABEL_26C_
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_1D5B_
	call _LABEL_206D_
	cp   $01
	jp   z, _LABEL_498_
	jp   _LABEL_CDA_

_LABEL_CDA_:
	ld   a, $F2
	ldh  [rOBP0], a
	ld   a, $01
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   [_RAM_C19A_], a
	ld   a, [_SRAM_2001_]
	or   a
	jr   z, _LABEL_CEE_
	ld   a, $01
_LABEL_CEE_:
	ld   [_RAM_C10C_], a
	call _LABEL_3EF_
	call _LABEL_2722_
	call _LABEL_62C_
	ld   bc, $FFE4
	ld   e, $70
	call _LABEL_1CF6_
	call _LABEL_1563_
	xor  a
	ld   [_RAM_C11B_], a
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_CA9F_

_LABEL_D11_:
	ld   a, $03
	ld   [_RAM_C479_], a
_LABEL_D16_:
	ld   a, [_RAM_C479_]
	push af
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   de, _RAM_C3E0_
	ld   hl, _RAM_C3F9_
	call _LABEL_AAA8_
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	call _LABEL_AAA8_
	pop  af
	ld   [_RAM_C479_], a
	call _LABEL_BD22_
	call _LABEL_AB74_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ret

; Data from D41 to D48 (8 bytes)
db $3E, $03, $EA, $FF, $3F, $C3, $3E, $59

; 11th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_D49_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call gfx__clear_shadow_oam__275B
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_D714_

_LABEL_D58_:
	xor  a
	ld   [_RAM_C19B_], a
	ld   hl, _RAM_C19C_
	ld   b, $1E
	ld   de, $0005
	ld   a, $FF
_LABEL_D66_:
	ld   [hl], a
	add  hl, de
	dec  b
	jr   nz, _LABEL_D66_
	ld   hl, $A233
	ld   a, [_SRAM_231_]
	or   a
	ret  z
_LABEL_D73_:
	push af
	push hl
	ld   a, [_RAM_C139_]
	cp   [hl]
	jr   nz, _LABEL_D97_
	inc  hl
	ld   a, [_RAM_C138_]
	cp   [hl]
	jr   nz, _LABEL_D97_
	inc  hl
	ld   a, [_RAM_C13A_]
	cp   [hl]
	jr   nz, _LABEL_D97_
	inc  hl
	ld   a, [hl]
	cp   $63
	jr   z, _LABEL_D97_
	ld   d, a
	inc  hl
	ld   e, [hl]
	inc  hl
	ld   a, [hl]
	call _LABEL_DA1_
_LABEL_D97_:
	ld   de, $0042
	pop  hl
	add  hl, de
	pop  af
	dec  a
	jr   nz, _LABEL_D73_
	ret

_LABEL_DA1_:
	cp   $04
	jr   nz, _LABEL_DA7_
	ld   a, $01
_LABEL_DA7_:
	push af
	ld   hl, _RAM_C19B_
	inc  [hl]
	ld   hl, _RAM_C19C_
	ld   bc, $0005
_LABEL_DB2_:
	ld   a, [hl]
	inc  a
	jr   z, _LABEL_DB9_
	add  hl, bc
	jr   _LABEL_DB2_

_LABEL_DB9_:
	ld   b, $00
	ld   a, d
_LABEL_DBC_:
	cp   $0A
	jr   c, _LABEL_DC5_
	sub  $0A
	inc  b
	jr   _LABEL_DBC_

_LABEL_DC5_:
	add  $30
	ld   c, a
	ld   a, b
	add  $30
	ldi  [hl], a
	ld   [hl], c
	inc  hl
	ld   a, e
	ld   b, $00
_LABEL_DD1_:
	cp   $0A
	jr   c, _LABEL_DDA_
	sub  $0A
	inc  b
	jr   _LABEL_DD1_

_LABEL_DDA_:
	add  $30
	ld   c, a
	ld   a, b
	add  $30
	ldi  [hl], a
	ld   [hl], c
	inc  hl
	pop  af
	ld   [hl], a
	ret

_LABEL_DE6_:
	call _LABEL_288F_
	ld   de, $0006
	ld   hl, $98A3
	rst  $20	; _LABEL_20_
	call _LABEL_E05_
_LABEL_DF3_:
	call _LABEL_E6C_
	or   a
	jr   z, _LABEL_DF3_
	cp   $FF
	jr   z, _LABEL_DF3_
	ld   de, $2150
	ld   hl, $98A0
	rst  $20	; _LABEL_20_
	ret

_LABEL_E05_:
	ld   hl, _RAM_C2B6_
	ld   [hl], $B0
	inc  hl
	ld   [hl], $00
	inc  hl
	ld   [hl], $00
	inc  hl
	ld   a, [_RAM_C704_]
	call _LABEL_E5A_
	ldi  [hl], a
	ld   a, [_RAM_C703_]
	call _LABEL_E5A_
	ldi  [hl], a
	ld   a, [_RAM_C702_]
	and  $03
	call _LABEL_F2C_
	add  a
	add  a
	ld   c, a
	ld   a, [_RAM_C700_]
	ld   b, $00
_LABEL_E2F_:
	cp   $0A
	jr   c, _LABEL_E38_
	sub  $0A
	inc  b
	jr   _LABEL_E2F_

_LABEL_E38_:
	add  c
	ld   c, a
	ld   a, b
	call _LABEL_F2C_
	add  c
	ldi  [hl], a
	ld   a, [_RAM_C304_]
	inc  a
	call _LABEL_F2C_
	add  a
	ld   c, a
	ld   a, [_RAM_C701_]
	ld   b, $00
	cp   $0A
	jr   c, _LABEL_E56_
	sub  $0A
	ld   b, $10
_LABEL_E56_:
	add  c
	add  b
	ldi  [hl], a
	ret

_LABEL_E5A_:
	ld   b, $00
_LABEL_E5C_:
	cp   $0A
	jr   c, _LABEL_E65_
	sub  $0A
	inc  b
	jr   _LABEL_E5C_

_LABEL_E65_:
	ld   c, a
	ld   a, b
	call _LABEL_F2C_
	add  c
	ret

_LABEL_E6C_:
	ld   a, $57
	call serial_io__send_command_wait_reply_byte__3356
	or   a
	ret  z
	cp   $FF
	ret  z
_LABEL_E76_:
	ld   a, $00
	call serial_io__send_command_wait_reply_byte__3356
	or   a
	jr   z, _LABEL_E76_
	cp   $FF
	jr   z, _LABEL_E76_
	ld   a, [_DATA_84_]
	ld   [_RAM_C2AE_], a
	call _LABEL_EB1_
	ld   de, _RAM_C2A9_
	ld   c, $15
_LABEL_E90_:
	ld   a, [de]
	inc  de
	call serial_io__send_byte_and_wait_3msec__0B11
	call delay_2_94msec__334A
	dec  c
	jr   nz, _LABEL_E90_
_LABEL_E9B_:
	call serial_io__send_command_wait_reply_byte__3356
	or   a
	jr   z, _LABEL_E9B_
	cp   $FF
	jr   z, _LABEL_E9B_
	call _LABEL_2916_
	call _LABEL_2942_
	call _LABEL_296E_
	ld   a, $01
	ret

_LABEL_EB1_:
	ld   hl, _RAM_C2AE_
	ld   [hl], $04
	inc  hl
	ld   [hl], $00
	inc  hl
	ld   a, [_RAM_C3A0_]
	sub  $30
	ld   c, a
	ld   a, [_RAM_C39F_]
	sub  $30
	call _LABEL_F2C_
	add  c
	ldi  [hl], a
	ld   a, [_RAM_C39E_]
	sub  $30
	ld   c, a
	ld   a, [_RAM_C39D_]
	sub  $30
	call _LABEL_F2C_
	add  c
	ldi  [hl], a
	ld   a, [_RAM_C39C_]
	sub  $30
	ld   c, a
	ld   a, [_RAM_C39B_]
	sub  $30
	call _LABEL_F2C_
	add  c
	ldi  [hl], a
	ld   a, [_RAM_C13A_]
	and  $03
	call _LABEL_F2C_
	add  a
	add  a
	ld   c, a
	ld   a, [_RAM_C139_]
	ld   b, $00
_LABEL_EFA_:
	cp   $0A
	jr   c, _LABEL_F03_
	sub  $0A
	inc  b
	jr   _LABEL_EFA_

_LABEL_F03_:
	add  c
	ld   c, a
	ld   a, b
	call _LABEL_F2C_
	add  c
	ldi  [hl], a
	ld   a, [_RAM_C304_]
	call _LABEL_F2C_
	add  a
	ld   c, a
	ld   a, [_RAM_C138_]
	ld   b, $00
	cp   $0A
	jr   c, _LABEL_F20_
	sub  $0A
	ld   b, $10
_LABEL_F20_:
	add  c
	add  b
	ldi  [hl], a
	ld   a, [_RAM_C13A_]
	and  $FC
	ld   [_RAM_C2BD_], a
	ret

_LABEL_F2C_:
	add  a
	add  a
	add  a
	add  a
	ret

; Data from F31 to F31 (1 bytes)
_DATA_F31_:
db $02

; Pointer Table from F32 to F33 (1 entries, indexed by unknown)
dw $4000

; Data from F34 to F49 (22 bytes)
db $1E, $0E, $05, $00, $40, $5C, $0E, $07, $00, $40, $92, $0E, $02, $1E, $4E, $91
db $0E, $04, $00, $40, $9E, $0E

; Data from F4A to F4C (3 bytes)
_DATA_F4A_:
db $05, $9B, $7D

; Pointer Table from F4D to F4E (1 entries, indexed by unknown)
_DATA_F4D_:
dw $4001

; Data from F4F to F67 (25 bytes)
db $7C, $05, $83, $7E, $03, $EE, $7E, $03, $06, $7E, $4E, $50, $51, $56, $5A, $45
db $53, $50, $4F, $50, $41, $53, $50, $52, $55

_LABEL_F68_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_SRAM_1F9_]
	cp   $05
	jr   c, _LABEL_F77_
	xor  a
	ld   [_SRAM_1F9_], a
_LABEL_F77_:
	ld   [_RAM_C232_], a
	ld   e, a
	add  a
	add  e
	ld   d, $00
	ld   e, a
	ld   hl, _DATA_F4A_
	add  hl, de
	ldi  a, [hl]
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	ld   de, _RAM_CF00_
	ld   b, $D0
	ld   a, $E8
_LABEL_F92_:
	push af
	ldi  a, [hl]
	ld   c, a
	ld   [de], a
	inc  de
	ld   a, b
	ld   [de], a
	inc  de
	ld   a, c
	cp   [hl]
	jr   c, _LABEL_FA1_
	jr   z, _LABEL_FA1_
	inc  b
_LABEL_FA1_:
	pop  af
	dec  a
	jr   nz, _LABEL_F92_
    ; The Duck MBC emulation doesn't support SRAM at the moment
    ; so force the read to return "0" (expected result in normal ROM)
    IF (DEF(DEBUG_USE_DUCK_MBC_NO_SRAM) && DEF(TARGET_MEGADUCK))
        nop
        ld   a, 0
    ELSE
	   ld   a, [_SRAM_1F9_]  ; Megaduck gets stuck here because it's MBC has no SRAM
    ENDC
	ld   e, a
	add  a
	add  a
	add  e
	ld   d, $00
	ld   e, a
	ld   hl, _DATA_F31_
	add  hl, de
	ldi  a, [hl]
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	ld   hl, _RAM_D0D0_ ; TODO: Label : gfx__temp_tilemap__RAM_D0D0
    ; Loads a bunch of tile map data from ROM to RAM
    ._LABEL_0FC1:
    	ld   a, [de]
    	inc  de
    	ldi  [hl], a
    	dec  bc
    	ld   a, b
    	or   c
    	jr   nz, ._LABEL_0FC1

    ; Search for start of displayed version text
    ; Load RAM Address to start search
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   a, [_RAM_CF16_]
	ld   l, a
	ld   a, [_RAM_CF17_]
	ld   h, a
    ;  a byte in RAM with value 0x35 ("5")
    ._LABEL_0FD6:
    	ld   a, [hl]
    	cp   $35
    	jr   z, _LABEL_FDE_
    	inc  hl
    	jr   ._LABEL_0FD6

    ; Overwrite "Version 5.74" with "Version 8.87"
    _LABEL_FDE_:
	ld   de, _DATA_FEA_
	ld   b, $04
    .overwrite_version_loop__0FE3:
    	ld   a, [de]
    	inc  de
    	ldi  [hl], a
    	dec  b
    	jr   nz, .overwrite_version_loop__0FE3
	ret

; Data from FEA to FED (4 bytes)
_DATA_FEA_:
db $38, $2E, $38, $37

_LABEL_FEE_:
	ld   a, d
	or   a
	jr   nz, _LABEL_FFE_
	push hl
	ld   h, a
	ld   l, e
	add  hl, hl
	ld   de, gfx__tilemap_string_addr_table__RAM_CEFE
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl
_LABEL_FFE_:
	ld   a, l
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, h
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, e
	ld   [gfx__src_addr_lo__RAM_C135_maybe], a
	ld   a, d
	ld   [gfx__src_addr_hi__RAM_C136_maybe], a
	ld   a, $0F
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret


; Source address : DE (If MSB empty, E has index into pointer table to load source address instead)
; Dest   address : HL
gfx__copy_string_to_vram_centered__1019:
    ; Check if MSByte of source address is populated
	ld   a, d
	or   a
	jr   nz, .use_raw_source_addr__skip_load_from_pointer_table__1029

    ; If source addr MSB empty, it means load source addr from pointer table instead
    ; pointer address =  0xCEFE + (LOW(Source Address) x 2)
	push hl
	ld   h, a
	ld   l, e
	add  hl, hl
	ld   de, gfx__tilemap_string_addr_table__RAM_CEFE ; $CEFE
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl

    .use_raw_source_addr__skip_load_from_pointer_table__1029:
    ; Find the number of bytes to copy (0 terminated)
	push de
	ld   b, $00
    .find_length_loop__102C:
    	ld   a, [de]
    	inc  de
    	or   a
    	jr   z, .length_count_done__1034
    	inc  b
    	jr   .find_length_loop__102C

    .length_count_done__1034:
    ; Calc to center the text on the tilemap Row ((20 - length) / 2)
	ld   a, _TILEMAP_SCREEN_WIDTH ; $14
	sub  b
	or   a
	rr   a

    ; Add it to Dest Address and save that to RAM (TODO)
    ; Dest  : RAM_C134,RAM_C133 (HL)
    ; Source: RAM_C135,RAM_C136 (DE)
	add  l
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, h
	adc  $00
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	pop  de
	ld   a, e
	ld   [gfx__src_addr_lo__RAM_C135_maybe], a
	ld   a, d
	ld   [gfx__src_addr_hi__RAM_C136_maybe], a
    ; Select copy command and wait until the next frame for it to execute
	ld   a, VBL_CMD__COPY_TEXT__0x0F; $0F
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

; Data from 1058 to 1070 (25 bytes)
db $4E, $45, $56, $41, $53, $4F, $50, $53, $50, $55, $4E, $50, $45, $56, $5A, $41
db $53, $50, $4F, $50, $52, $53, $50, $52, $55

; Data from 1071 to 1075 (5 bytes)
_DATA_1071_:
db $59, $4A, $4F, $53, $53

_LABEL_1076_:
	ld   de, gfx__tilemap_string_addr_table__RAM_CEFE ; $CEFE
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	push de
	ld   d, $00
	ld   a, [_RAM_C232_]
	ld   e, a
	ld   hl, $1071
	add  hl, de
	pop  de
_LABEL_1089_:
	ld   a, [de]
	cp   [hl]
	jr   z, _LABEL_1090_
	inc  de
	jr   _LABEL_1089_

_LABEL_1090_:
	ld   a, $41
	ld   [de], a
	ret

_LABEL_1094_:
	push af
	ld   hl, $70FA
	ld   b, $19
_LABEL_109A_:
	cp   [hl]
	jr   z, _LABEL_10A3_
	inc  hl
	dec  b
	jr   nz, _LABEL_109A_
	pop  af
	ret

_LABEL_10A3_:
	ld   a, $19
	sub  b
	add  a
	ld   hl, _DATA_B113_
	ld   d, $00
	ld   e, a
	add  hl, de
	ldi  a, [hl]
	ld   [_RAM_C593_], a
	ldi  a, [hl]
	ld   [_RAM_C594_], a
	ld   a, $05
	ld   [_RAM_C595_], a
	pop  af
	ret

; Data from 10BD to 10C2 (6 bytes)
_DATA_10BD_:
db $49, $54, $43, $4D, $52, $54

_LABEL_10C3_:
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   a, [_RAM_C233_]
	or   a
	jr   z, _LABEL_10DF_
	ld   hl, _DATA_DB31_
	jr   _LABEL_10E2_

_LABEL_10DF_:
	ld   hl, _DATA_DB37_
_LABEL_10E2_:
	call _LABEL_2003_
	ld   de, $00DA
	call _LABEL_1D2D_
	ld   bc, $0009
	call _LABEL_BC3_
	ld   de, $00DB
	call _LABEL_1D2D_
	ld   bc, $0309
	call _LABEL_BC3_
	ld   de, $00DC
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $00DD
	call _LABEL_1D2D_
	ld   bc, $0909
	call _LABEL_BC3_
	ld   de, $00DE
	call _LABEL_1D2D_
	ld   bc, $0C09
	call _LABEL_BC3_
	ld   a, [_RAM_C233_]
	or   a
	jr   z, _LABEL_1133_
	ld   de, $00D7
	call _LABEL_1D2D_
	ld   bc, $0F09
	call _LABEL_BC3_
_LABEL_1133_:
	call _LABEL_206D_
	cp   $05
	jp   z, _LABEL_2DA7_
	cp   $03
	jp   z, _LABEL_338A_
	push af
	cp   $04
	jr   nz, _LABEL_1153_
	ld   a, $02
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_SRAM_4000_]
	or   a
	jr   nz, _LABEL_1174_
	jp   _LABEL_DCC7_

_LABEL_1153_:
	cp   $01
	jr   nz, _LABEL_1163_
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_SRAM_1_]
	or   a
	jr   nz, _LABEL_1174_
	jp   _LABEL_DCC7_

_LABEL_1163_:
	cp   $02
	jr   nz, _LABEL_1174_
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_SRAM_231_]
	or   a
	jp   z, _LABEL_DCC7_
	jr   _LABEL_11B2_

_LABEL_1174_:
	call _LABEL_1210_
	ld   bc, $570C
	call _LABEL_2044_
	ld   bc, $2808
	call _LABEL_27DD_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_DB40_
	push af
	push bc
	push de
	push hl
	ld   hl, $C11B
	ld   de, _DATA_10BD_
	ld   b, $06
_LABEL_1197_:
	ld   a, [de]
	cp   [hl]
	jr   nz, _LABEL_11A5_
	inc  hl
	inc  de
	dec  b
	jr   nz, _LABEL_1197_
	ld   a, $01
	ld   [_RAM_C233_], a
_LABEL_11A5_:
	pop  hl
	pop  de
	pop  bc
	pop  af
	pop  af
	cp   $01
	jp   z, _LABEL_DD5A_
	jp   _LABEL_DCE7_

_LABEL_11B2_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call _LABEL_2722_
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	dec  a
	ld   [_RAM_C10B_], a
	call _LABEL_B765_
	ld   de, $0002
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $00D1
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $00D2
	ld   hl, $9A22
	rst  $20	; _LABEL_20_
_LABEL_11DA_:
	ld   a, [_RAM_C592_]
	or   a
	jr   z, _LABEL_11DA_
	bit  2, a
	jr   z, _LABEL_11F7_
	ld   a, [_RAM_C10B_]
	cp   $02
	jr   c, _LABEL_11DA_
	ld   a, [_RAM_C10B_]
	dec  a
_LABEL_11EF_:
	ld   [_RAM_C10B_], a
	call _LABEL_B765_
	jr   _LABEL_11DA_

_LABEL_11F7_:
	bit  0, a
	jp   nz, _LABEL_200_
	bit  1, a
	jr   z, _LABEL_11DA_
	ld   a, [_SRAM_231_]
	ld   c, a
	ld   a, [_RAM_C10B_]
	cp   c
	jr   z, _LABEL_11DA_
	ld   a, [_RAM_C10B_]
	inc  a
	jr   _LABEL_11EF_

_LABEL_1210_:
	xor  a
	ld   [_RAM_C234_], a
	call gfx__turn_off_screen_2827
	ld   a, $07
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, _TILEDATA9000
	ld   bc, _DATA_1DDCA_
	xor  a ; Copy 256 tiles
	call gfx__copy_tile_patterns__1437
	ld   a, $05
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   de, _DATA_178FC_
	call _LABEL_3969_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $0010
	ld   hl, (_TILEMAP0 + $40)
	rst  $20	; _LABEL_20_
	ret

_LABEL_1241_:
	ld   a, $01
	ld   [_RAM_C234_], a
	call gfx__turn_off_screen_2827
	ld   a, $07
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, _TILEDATA9000
	ld   bc, _DATA_1ED6A_
	xor  a ; Copy 256 tiles
	call gfx__copy_tile_patterns__1437
	ld   a, $05
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   de, _DATA_17A64_
	call _LABEL_3969_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $0010
	ld   hl, (_TILEMAP0 + $40)
	rst  $20	; _LABEL_20_
	ret

_LABEL_1273_:
	ld   a, [_RAM_C154_]
	or   a
	ret  z
	ld   a, $02
	ld   [_RAM_C153_], a
	ld   a, [_RAM_C155_]
	cp   $5B
	jr   z, _LABEL_12DC_
	jr   nc, _LABEL_12B1_
	ld   c, $02
	ld   a, [_RAM_C155_]
	ld   b, $5B
_LABEL_128D_:
	dec  b
	ld   a, b
	and  $03
	jr   z, _LABEL_129D_
	ld   a, c
	dec  a
	cp   $FF
	jr   nz, _LABEL_12A4_
	ld   a, $06
	jr   _LABEL_12A4_

_LABEL_129D_:
	ld   a, c
	sub  $02
	jr   nc, _LABEL_12A4_
	add  $07
_LABEL_12A4_:
	ld   c, a
	ld   a, [_RAM_C155_]
	cp   b
	jr   nz, _LABEL_128D_
	ld   a, c
	ld   [_RAM_C153_], a
	jr   _LABEL_12DC_

_LABEL_12B1_:
	ld   c, $02
	ld   a, [_RAM_C155_]
	ld   b, $5B
_LABEL_12B8_:
	inc  b
	ld   a, b
	dec  a
	and  $03
	jr   z, _LABEL_12C8_
	ld   a, c
	inc  a
	cp   $07
	jr   nz, _LABEL_12D1_
	xor  a
	jr   _LABEL_12D1_

_LABEL_12C8_:
	ld   a, c
	add  $02
	cp   $07
	jr   c, _LABEL_12D1_
	sub  $07
_LABEL_12D1_:
	ld   c, a
	ld   a, [_RAM_C155_]
	cp   b
	jr   nz, _LABEL_12B8_
	ld   a, c
	ld   [_RAM_C153_], a
_LABEL_12DC_:
	ld   a, [_RAM_C154_]
	ld   [_RAM_C5C5_], a
	ld   a, [_RAM_C152_]
	ld   [_RAM_C5C6_], a
	ld   a, $01
	ld   [_RAM_C154_], a
	ld   [_RAM_C152_], a
_LABEL_12F0_:
	call _LABEL_12F9_
	ret  z
	call _LABEL_AE3_
	jr   _LABEL_12F0_

_LABEL_12F9_:
	ld   a, [_RAM_C5C5_]
	ld   c, a
	ld   a, [_RAM_C154_]
	cp   c
	ret  nz
	ld   a, [_RAM_C5C6_]
	ld   c, a
	ld   a, [_RAM_C152_]
	cp   c
	ret

; Data from 130B to 132A (32 bytes)
_DATA_130B_:
db $FF, $3C, $FF, $66, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $66, $FF, $3C, $FF, $00
db $FF, $C6, $FF, $E6, $FF, $D6, $FF, $CE, $FF, $C6, $FF, $C6, $FF, $C6, $FF, $00

_LABEL_132B_:
	ld   de, $00D4
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $00D5
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	ld   a, [_RAM_C232_]
	ld   d, $00
	ld   e, a
	ld   hl, $1071
	add  hl, de
_LABEL_1343_:
	push hl
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	pop  hl
	cp   $FF
	jr   z, _LABEL_1343_
	cp   [hl]
	jr   z, _LABEL_134F_
	xor  a
	ret

_LABEL_134F_:
	ld   a, $63
	ret

_LABEL_1352_:
	ld   a, [_SRAM_2A_]
	or   a
	ret  z
	ld   a, [_RAM_C700_]
	push af
	ld   a, [_RAM_C701_]
	ld   [_RAM_C700_], a
	pop  af
	ld   [_RAM_C701_], a
	ret

; 12th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_1366_:
	ld   hl, $99E0
	ld   b, $14
	xor  a
_LABEL_136C_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_136C_
	ld   c, $0C
	add  hl, bc
	push hl
	ld   hl, _RAM_CF1E_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl
	ld   b, $14
_LABEL_137D_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_137D_
	jp   _LABEL_1410_

; 14th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_1388_:
	ld   hl, $99E1
	ld   de, _RAM_C13D_
	ld   b, $03
	call _LABEL_13A6_
	inc  hl
	ld   b, $08
	call _LABEL_13A6_
	inc  hl
	ld   b, $05
	inc  de
	call _LABEL_13A6_
	call _LABEL_13AF_
	jp   vblank__cmd_default__25F7

_LABEL_13A6_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_13A6_
	ret

_LABEL_13AF_:
	inc  de
	inc  de
	ld   a, [de]
	and  $01
	ret  nz
	ld   [$99F0], a
	ret

; Data from 13B9 to 13BB (3 bytes)
db $C3, $F7, $25

; 13th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_13BC_:
	ld   hl, _RAM_CF20_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, $9A00
	ld   b, $14
_LABEL_13C7_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_13C7_
	ld   c, $0C
	add  hl, bc
	ld   b, $14
_LABEL_13D4_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_13D4_
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   vblank__cmd_default__25F7

; 22nd entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_13E2_:
	ld   hl, $9A01
	ld   b, $12
	ld   de, _RAM_C11B_
_LABEL_13EA_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_13F5_
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_13EA_
_LABEL_13F5_:
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   vblank__cmd_default__25F7

; 9th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_13FD_:
	ld   hl, _RAM_CF1C_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, $9A00
	ld   b, $14
_LABEL_1408_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_1408_
_LABEL_1410_:
	ld   c, $0C
	add  hl, bc
	xor  a
	ld   b, $12
	ld   de, _RAM_C11B_
_LABEL_1419_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_1424_
	sub  $20
	ldi  [hl], a
	dec  b
	jr   _LABEL_1419_

_LABEL_1424_:
	ld   a, $12
	sub  b
	ld   [_RAM_C23B_], a
	xor  a
_LABEL_142B_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_142B_
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   vblank__cmd_default__25F7


; Copies N tiles worth of pattern data (16 bytes per tile)
; Wraps around from 0x9800 to 0x8800 if needed
;
; Source    : BC
; Dest      : HL
; Num Tiles : A  (if 0, will copy 256)
gfx__copy_tile_patterns__1437:
	push af
	ld   d, 16 ; $10 ; 16 bytes is one tile pattern
    .copy_tile_16_bytes_loop__143A:
    	ld   a, [bc]
    	inc  bc
    	ldi  [hl], a
    	dec  d
    	jr   nz, .copy_tile_16_bytes_loop__143A
    ; Handle wraparound to $8800 if write address reached end of _TILEDATA9000
	ld   a, h
	cp   HIGH(_TILEDATA9000 + $800) ; $98
	jr   nz, .skip_tiledata_8800_wraparound__1447
       ; Wrap around to tile data at 0x8800
	   ld   h, HIGH(_TILEDATA8800) ; $88
    .skip_tiledata_8800_wraparound__1447:
	pop  af
	dec  a
    ; Done copying when A is 0 after decrement
	jr   nz, gfx__copy_tile_patterns__1437
	ret


; Interleave Copies N tiles worth of pattern data (8 bytes + 8 bytes)
;
; Merges two separate 1bpp tiles into a single 2bpp tile
; From  DE: 01234567
;       BC: ABCDEFGH
; TO -> HL: 0A 1B 2C 3D 4E 5F 6G 7H
;
; Wraps around from 0x9800 to 0x8800 if needed
;
; Source    : DE (LS bpp bytes)
; Source    : BC (MS bpp bytes)
; Dest      : HL
; Num Tiles : A  (if 0, will copy 256)
gfx__interleave_copy_tile_patterns__144C:
	push af
	ld   a, $08
    .copy_interleaved_tile_16_bytes_loop__144F:
    	push af

    	ld   a, [de]
    	inc  de
    	ldi  [hl], a

    	ld   a, [bc]
    	inc  bc
    	ldi  [hl], a

    	pop  af
    	dec  a
    	jp   nz, .copy_interleaved_tile_16_bytes_loop__144F
    ; BC += 8
    REPT 8
    	inc  bc
    ENDR
    ; DE += 8
    REPT 8
	   inc  de
    ENDR
    ; Handle wraparound to $8800 if write address reached end of _TILEDATA9000
    ld   a, h
    cp   HIGH(_TILEDATA9000 + $800) ; $98
    jr   nz, .skip_tiledata_8800_wraparound__1472
       ; Wrap around to tile data at 0x8800
       ld   h, HIGH(_TILEDATA8800) ; $88

    .skip_tiledata_8800_wraparound__1472:
	pop  af
	dec  a
    ; Done copying when A is 0 after decrement
	jp   nz, gfx__interleave_copy_tile_patterns__144C
	ret


; Pointer Table from 1478 to 1479 (1 entries, indexed by _RAM_C251_)
_DATA_1478_:
dw _DATA_14F0_

; Pointer Table from 147A to 1499 (16 entries, indexed by _RAM_C3A2_)
dw _DATA_EA8C_, _DATA_EAAE_, _DATA_EAD0_, _DATA_EAF2_, _DATA_EB14_, _DATA_EB36_, _DATA_EB58_, _DATA_EB7A_
dw _DATA_EB9C_, _DATA_EBBE_, _DATA_EBE0_, _DATA_EC02_, _DATA_EC24_, _DATA_EC46_, _DATA_EC68_, _DATA_EC8A_

; Data from 149A to 14EF (86 bytes)
db $AC, $6C, $CE, $6C, $F0, $6C, $12, $6D, $34, $6D, $56, $6D, $78, $6D, $9A, $6D
db $BC, $6D, $DE, $6D, $00, $6E, $22, $6E, $44, $6E, $66, $6E, $88, $6E, $AA, $6E
db $30, $69, $A8, $00, $AB, $2E, $B5, $2E, $BF, $2E, $C9, $2E, $D3, $2E, $DD, $2E
db $E7, $2E, $F1, $2E, $FB, $2E, $05, $2F, $0F, $2F, $19, $2F, $23, $2F, $2D, $2F
db $37, $2F, $62, $00, $6C, $00, $76, $00, $80, $00, $8A, $00, $94, $00, $9E, $00
db $B2, $00, $CC, $00, $E6, $00

; 1st entry of Pointer Table from 1478 (indexed by _RAM_C251_)
; Data from 14F0 to 1503 (20 bytes)
_DATA_14F0_:
db $03, $03, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
db $01, $00, $01, $00

_LABEL_1504_:
	ld   h, $00
	ld   l, e
	add  hl, hl
	ld   de, _DATA_1478_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   h, $C0
	ld   a, [_RAM_C107_]
	ld   l, a
	ld   a, [de]
	inc  de
	ld   [_RAM_C23D_], a
	ld   a, [de]
	inc  de
_LABEL_151C_:
	push af
	push bc
	ld   a, [_RAM_C23D_]
_LABEL_1521_:
	push af
	ld   a, b
	cp   $A0
	jr   c, _LABEL_152B_
	inc  de
	inc  de
	jr   _LABEL_154D_

_LABEL_152B_:
	ld   [hl], b
	inc  hl
	ld   [hl], c
	inc  hl
	ld   a, [de]
	or   a
	jr   nz, _LABEL_1539_
	inc  de
	inc  de
	dec  hl
	dec  hl
	jr   _LABEL_154D_

_LABEL_1539_:
	ld   [hl], a
	ld   a, [_RAM_C23F_]
	add  [hl]
	inc  de
	ldi  [hl], a
	ld   a, [de]
	inc  de
	and  $C0
	rrca
	push de
	ld   e, a
	ld   a, [_RAM_C23E_]
	or   e
	pop  de
	ldi  [hl], a
_LABEL_154D_:
	ld   a, c
	add  $08
	ld   c, a
	pop  af
	dec  a
	jr   nz, _LABEL_1521_
	pop  bc
	ld   a, b
	add  $08
	ld   b, a
	pop  af
	dec  a
	jr   nz, _LABEL_151C_
	ld   a, l
	ld   [_RAM_C107_], a
	ret

_LABEL_1563_:
	ld   a, [_RAM_C24F_]
	ld   c, a
	ld   a, [_RAM_C27D_]
	ld   [_RAM_C24F_], a
	ld   a, c
	ld   [_RAM_C27D_], a
	ret

; 6th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_1572_:
	call _LABEL_26C_
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_1D88_
	call _LABEL_206D_
	cp   $01
	jp   z, _LABEL_160B_
	jp   _LABEL_897_

; 8th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_1598_:
	call _LABEL_27DD_
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_1DDC_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_D105_

_LABEL_15BE_:
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_1E06_
	call _LABEL_206D_
	cp   $01
	jp   z, _LABEL_2209_
	jp   _LABEL_819_

_LABEL_15E1_:
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_1DB2_
	call _LABEL_206D_
	push af
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	pop  af
	cp   $01
	jp   z, _LABEL_E7EF_
	jp   _LABEL_E95A_

_LABEL_160B_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, $C8
	ld   [_RAM_C399_], a
	call _LABEL_27DD_
	ld   a, $F2
	ldh  [rOBP0], a
	ldh  [rOBP1], a
	xor  a
	ld   [_RAM_C11B_], a
	ld   [_RAM_C23E_], a
	call gfx__clear_shadow_oam__275B
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_424_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_1E34_
	call _LABEL_206D_
	cp   $01
	jp   z, _LABEL_1A6A_
	cp   $03
	jp   z, _LABEL_200_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	ld   hl, _RAM_CFA6_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, (_TILEMAP0 + $40)
	ld   a, $0E
_LABEL_1662_:
	push af
	ld   b, $14
_LABEL_1665_:
	ld   a, [de]
	sub  $20
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_1665_
	ld   c, $0C
	add  hl, bc
	pop  af
	dec  a
	jr   nz, _LABEL_1662_
	call gfx__turn_on_screen_bg_obj__2540
	ld   a, $64
	ld   [_RAM_C240_], a
	ld   bc, $09E0
	ld   e, $0E
	call _LABEL_1CF6_
_LABEL_1684_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_169C_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [gamepad_buttons__RAM_C103]
	and  $C4
	jr   nz, _LABEL_16BF_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_16BF_

_LABEL_169C_:
	ld   a, [gamepad_buttons__RAM_C103]
	and  $C4
	jr   z, _LABEL_16BF_
	ld   e, a
	ld   a, $19
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_16D4_
	bit  7, a
	jr   nz, _LABEL_16E4_
	bit  2, a
	jr   z, _LABEL_16BF_
_LABEL_16B6_:
	ld   a, [gamepad_buttons__RAM_C103]
	bit  2, a
	jr   nz, _LABEL_16B6_
	jr   _LABEL_16F5_

_LABEL_16BF_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_1684_
	or   a
	jp   z, _LABEL_160B_
	cp   $0D
	jr   z, _LABEL_16F5_
	cp   $12
	jr   z, _LABEL_16E4_
	cp   $0F
	jr   nz, _LABEL_1684_
_LABEL_16D4_:
	ld   a, [_RAM_C399_]
	cp   $0E
	jr   nz, _LABEL_16DD_
	ld   a, $7E
_LABEL_16DD_:
	sub  $08
	ld   [_RAM_C399_], a
	jr   _LABEL_1684_

_LABEL_16E4_:
	ld   a, [_RAM_C399_]
	cp   $76
	jr   nz, _LABEL_16ED_
	ld   a, $06
_LABEL_16ED_:
	add  $08
	ld   [_RAM_C399_], a
	jp   _LABEL_1684_

_LABEL_16F5_:
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	ld   a, [_RAM_C399_]
	sub  $0E
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   hl, _DATA_2165_
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	add  a
	add  a
	ld   l, a
	ld   h, $40
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   e, [hl]
	inc  l
	ld   d, [hl]
	inc  l
	ldi  a, [hl]
	ld   c, [hl]
	push af
	push bc
	push de
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_F790_
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	pop  de
	pop  bc
	pop  af
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   a, $00
	ld   [gfx__src_addr_lo__RAM_C135_maybe], a
	ld   a, $C7
	ld   [gfx__src_addr_hi__RAM_C136_maybe], a
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   [_RAM_C399_], a
	inc  a
	ld   [_RAM_C249_], a
	ld   [_RAM_C241_], a
	ld   a, c
	ld   [_RAM_C242_], a
	ld   hl, _TILEMAP0
	ld   a, [_RAM_C5F5_]
	or   a
	call nz, _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C243_], a
	ld   [_RAM_C247_], a
	ld   a, d
	ld   [_RAM_C244_], a
	ld   [_RAM_C248_], a
	ld   b, $12
_LABEL_1770_:
	push hl
_LABEL_1771_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_1787_
	cp   $30
	jr   c, _LABEL_1782_
	cp   $3A
	jr   nc, _LABEL_1782_
	add  $93
	jr   _LABEL_1784_

_LABEL_1782_:
	sub  $20
_LABEL_1784_:
	ldi  [hl], a
	jr   _LABEL_1771_

_LABEL_1787_:
	ld   a, $04
	call _LABEL_1A4F_
	pop  hl
	push bc
	ld   bc, $0020
	add  hl, bc
	pop  bc
	dec  c
	jr   z, _LABEL_1799_
	dec  b
	jr   nz, _LABEL_1770_
_LABEL_1799_:
	ld   a, e
	ld   [_RAM_C245_], a
	ld   a, d
	ld   [_RAM_C246_], a
	call gfx__turn_on_screen_bg_obj__2540
_LABEL_17A4_:
	ld   a, [_RAM_C399_]
	or   a
	jr   nz, _LABEL_17AE_
	ld   a, $07
	jr   _LABEL_17B0_

_LABEL_17AE_:
	ld   a, $09
_LABEL_17B0_:
	ld   [_RAM_C39A_], a
	rst  $18	; Call VSYNC__RST_18
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_17CF_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [gamepad_buttons__RAM_C103]
	and  $C4
	jr   nz, _LABEL_17F4_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_17F4_

_LABEL_17CF_:
	ld   a, [gamepad_buttons__RAM_C103]
	and  $C4
	jr   z, _LABEL_17F4_
	ld   e, a
	ld   a, $05
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_180D_
	bit  7, a
	jp   nz, _LABEL_18B4_
	bit  2, a
	jr   z, _LABEL_17F4_
_LABEL_17EA_:
	ld   a, [gamepad_buttons__RAM_C103]
	bit  2, a
	jr   nz, _LABEL_17EA_
	jp   _LABEL_1963_

_LABEL_17F4_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_17A4_
	or   a
	jp   z, _LABEL_160B_
	cp   $0D
	jp   z, _LABEL_1963_
	cp   $0F
	jr   z, _LABEL_180D_
	cp   $12
	jp   z, _LABEL_18B4_
	jr   _LABEL_17A4_

_LABEL_180D_:
	ld   a, [_RAM_C241_]
	cp   $01
	jr   z, _LABEL_17A4_
	ld   a, [_RAM_C247_]
	ld   e, a
	ld   a, [_RAM_C248_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A5B_
	ld   a, e
	ld   [_RAM_C247_], a
	ld   a, d
	ld   [_RAM_C248_], a
	ld   a, [_RAM_C399_]
	or   a
	jr   z, _LABEL_1840_
	sub  $08
	cp   $FE
	jr   nz, _LABEL_1836_
	xor  a
_LABEL_1836_:
	ld   [_RAM_C399_], a
	ld   hl, _RAM_C241_
	dec  [hl]
	jp   _LABEL_17A4_

_LABEL_1840_:
	ld   hl, _RAM_C241_
	dec  [hl]
	ld   a, [gfx__shadow_y_scroll__RAM_C102]
	sub  $08
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   h, $00
	ld   l, a
	add  hl, hl
	add  hl, hl
	ld   de, _TILEMAP0
	add  hl, de
	ld   a, l
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, h
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, [_RAM_C243_]
	ld   e, a
	ld   a, [_RAM_C244_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A5B_
	ld   a, e
	ld   l, a
	ld   [_RAM_C243_], a
	ld   a, d
	ld   h, a
	ld   [_RAM_C244_], a
	push hl
	ld   a, [_RAM_C245_]
	ld   e, a
	ld   a, [_RAM_C246_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A5B_
	ld   a, e
	ld   [_RAM_C245_], a
	ld   a, d
	ld   [_RAM_C246_], a
	pop  hl
	ld   de, _RAM_C700_
	ld   b, $14
_LABEL_1890_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_18AB_
	cp   $30
	jr   c, _LABEL_189E_
	cp   $3A
	jr   nc, _LABEL_189E_
	add  $B3
_LABEL_189E_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_1890_
_LABEL_18A3_:
	ld   a, $05
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   _LABEL_17A4_

_LABEL_18AB_:
	ld   a, $20
_LABEL_18AD_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_18AD_
	jr   _LABEL_18A3_

_LABEL_18B4_:
	ld   a, [_RAM_C241_]
	ld   e, a
	ld   a, [_RAM_C242_]
	cp   e
	jp   z, _LABEL_17A4_
	ld   a, [_RAM_C247_]
	ld   e, a
	ld   a, [_RAM_C248_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C247_], a
	ld   a, d
	ld   [_RAM_C248_], a
	ld   a, [_RAM_C399_]
	cp   $86
	jr   z, _LABEL_18ED_
	add  $08
	cp   $08
	jr   nz, _LABEL_18E3_
	dec  a
	dec  a
_LABEL_18E3_:
	ld   [_RAM_C399_], a
	ld   hl, _RAM_C241_
	inc  [hl]
	jp   _LABEL_17A4_

_LABEL_18ED_:
	ld   hl, _RAM_C241_
	inc  [hl]
	ld   a, [gfx__shadow_y_scroll__RAM_C102]
	add  $08
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	add  $88
	ld   h, $00
	ld   l, a
	add  hl, hl
	add  hl, hl
	ld   de, _TILEMAP0
	add  hl, de
	ld   a, l
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, h
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, [_RAM_C245_]
	ld   l, a
	ld   a, [_RAM_C246_]
	ld   h, a
	push hl
	push hl
	pop  de
	ld   a, $05
	call _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C245_], a
	ld   a, d
	ld   [_RAM_C246_], a
	ld   a, [_RAM_C243_]
	ld   e, a
	ld   a, [_RAM_C244_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C243_], a
	ld   a, d
	ld   [_RAM_C244_], a
	pop  hl
	ld   de, _RAM_C700_
	ld   b, $14
_LABEL_193F_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_195A_
	cp   $30
	jr   c, _LABEL_194D_
	cp   $3A
	jr   nc, _LABEL_194D_
	add  $B3
_LABEL_194D_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_193F_
_LABEL_1952_:
	ld   a, $05
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   _LABEL_17A4_

_LABEL_195A_:
	ld   a, $20
_LABEL_195C_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_195C_
	jr   _LABEL_1952_

_LABEL_1963_:
	ld   a, [_RAM_C5F5_]
	or   a
	jr   z, _LABEL_197F_
	ld   a, [_RAM_C247_]
	ld   e, a
	ld   a, [_RAM_C248_]
	ld   d, a
	ld   a, [_RAM_C5F5_]
	call _LABEL_1A5B_
	ld   a, e
	ld   [_RAM_C247_], a
	ld   a, d
	ld   [_RAM_C248_], a
_LABEL_197F_:
	call _LABEL_19A9_
_LABEL_1982_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_198F_
	dec  a
	ld   [_RAM_C240_], a
	jr   _LABEL_199D_

_LABEL_198F_:
	ld   a, [gamepad_buttons__RAM_C103]
	or   a
	jr   z, _LABEL_199D_
	ld   a, $32
	ld   [_RAM_C240_], a
	jp   _LABEL_160B_

_LABEL_199D_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_1982_
	or   a
	jp   z, _LABEL_200_
	jp   _LABEL_160B_

_LABEL_19A9_:
	xor  a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $32
	ld   [_RAM_C240_], a
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	ld   a, $C8
	ld   [_RAM_C399_], a
	ld   c, $05
	ld   de, _DATA_1A0E_
	ld   hl, _TILEMAP0
_LABEL_19C5_:
	push bc
	ld   b, $0D
_LABEL_19C8_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_19C8_
	ld   b, $07
	ld   a, $8F
_LABEL_19D2_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_19D2_
	ld   c, $4C
	add  hl, bc
	pop  bc
	dec  c
	jr   nz, _LABEL_19C5_
	ld   hl, (_TILEMAP0 + $20)
	ld   c, $05
	ld   a, [_RAM_C247_]
	ld   e, a
	ld   a, [_RAM_C248_]
	ld   d, a
_LABEL_19EA_:
	push bc
	push hl
_LABEL_19EC_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_1A02_
	cp   $30
	jr   c, _LABEL_19FD_
	cp   $3A
	jr   nc, _LABEL_19FD_
	add  $93
	jr   _LABEL_19FF_

_LABEL_19FD_:
	sub  $20
_LABEL_19FF_:
	ldi  [hl], a
	jr   _LABEL_19EC_

_LABEL_1A02_:
	ld   bc, $0060
	pop  hl
	add  hl, bc
	pop  bc
	dec  c
	jr   nz, _LABEL_19EA_
	jp   gfx__turn_on_screen_bg_obj__2540

; Data from 1A0E to 1A4E (65 bytes)
_DATA_1A0E_:
db $8F, $8F, $8F, $8F, $8F, $8F, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $8F, $8F, $8F
db $8F, $8F, $8F, $D5, $D3, $DC, $DD, $DB, $D4, $8F, $8F, $8F, $8F, $8F, $8F, $8F
db $DE, $DC, $D3, $D4, $E2, $D9, $8F, $8F, $8F, $8F, $8F, $8F, $8F, $D8, $E1, $DB
db $D4, $D7, $D8, $D9, $8F, $8F, $8F, $8F, $8F, $8F, $D7, $E0, $DB, $D6, $D7, $DB
db $D4

_LABEL_1A4F_:
	push bc
	ld   b, a
_LABEL_1A51_:
	ld   a, [de]
	inc  de
	or   a
	jr   nz, _LABEL_1A51_
	dec  b
	jr   nz, _LABEL_1A51_
	pop  bc
	ret

_LABEL_1A5B_:
	push bc
	inc  a
	ld   b, a
_LABEL_1A5E_:
	ld   a, [de]
	dec  de
	or   a
	jr   nz, _LABEL_1A5E_
	dec  b
	jr   nz, _LABEL_1A5E_
	inc  de
	inc  de
	pop  bc
	ret

_LABEL_1A6A_:
	xor  a
	ld   [_RAM_C11B_], a
	ld   [_RAM_C23B_], a
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_F790_
	call _LABEL_F74D_
	ld   a, $F2
	ldh  [rOBP0], a
	call gfx__turn_off_screen_2827
	ld   a, $C8
	ld   [_RAM_C399_], a
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $0012
	call _LABEL_1D2D_
	ld   bc, $0509
	call _LABEL_BC3_
	ld   de, _DATA_2150_
	ld   bc, $0F09
	ld   a, $14
	call _LABEL_BC3_
	xor  a
	ld   [_RAM_C130_], a
	ld   [_RAM_C11B_], a
	ld   [_RAM_C239_], a
	ld   a, [_RAM_C281_]
	ld   [_RAM_C237_], a
	ld   a, [_RAM_C282_]
	ld   [_RAM_C238_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, [_RAM_C23B_]
	add  a
	add  a
	add  a
	add  $10
	ld   [_RAM_C281_], a
	ld   a, $90
	ld   [_RAM_C282_], a
_LABEL_1AD9_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_1AD9_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_1B47_
	cp   $0B
	jr   nz, _LABEL_1AF8_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_1AD9_

_LABEL_1AF8_:
	cp   $0C
	jr   nz, _LABEL_1B06_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jr   _LABEL_1AD9_

_LABEL_1B06_:
	cp   $80
	jr   nz, _LABEL_1B1D_
	ld   a, [_RAM_C281_]
	cp   $10
	jr   z, _LABEL_1AD9_
	sub  $08
	ld   [_RAM_C281_], a
	ld   a, $20
	call _LABEL_76A_
	jr   _LABEL_1AD9_

_LABEL_1B1D_:
	cp   $7E
	jr   z, _LABEL_1B31_
	cp   $2D
	jr   z, _LABEL_1B31_
	cp   $20
	jr   z, _LABEL_1B31_
	cp   $41
	jr   c, _LABEL_1AD9_
	cp   $5B
	jr   nc, _LABEL_1AD9_
_LABEL_1B31_:
	ld   c, a
	ld   a, [_RAM_C281_]
	cp   $80
	jr   z, _LABEL_1AD9_
	ld   a, c
	call _LABEL_76A_
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_1AD9_

_LABEL_1B47_:
	ld   a, [_RAM_C281_]
	sub  $10
	jp   z, _LABEL_160B_
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   [_RAM_C23B_], a
	ld   d, $00
	ld   e, a
	ld   hl, $C11B
	add  hl, de
	xor  a
	ld   [hl], a
	call gfx__clear_shadow_oam__275B
	ld   a, $01
	ld   [_RAM_C24B_], a
	call _LABEL_1CC6_
_LABEL_1B6F_:
	ld   a, [_RAM_C24A_]
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_1C3D_
	or   a
	jp   z, _LABEL_1C17_
	ld   a, [_RAM_C5F5_]
	or   a
	jr   z, _LABEL_1BAE_
	ld   c, a
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
	ld   a, c
	call _LABEL_1A5B_
	ld   a, e
	ld   [_RAM_C247_], a
	ld   a, d
	ld   [_RAM_C248_], a
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	jr   _LABEL_1BC9_

_LABEL_1BAE_:
	ld   a, [_RAM_C24C_]
	ld   [_RAM_C247_], a
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   [_RAM_C248_], a
	ld   d, a
	ld   a, $05
	call _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
_LABEL_1BC9_:
	ld   hl, _RAM_C24E_
	dec  [hl]
	ld   a, [_RAM_C24A_]
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_19A9_
	ld   a, $00
	ld   [gfx__dest_addr_lo__RAM_C133_maybe], a
	ld   a, $9A
	ld   [gfx__dest_addr_hi__RAM_C134_maybe], a
	ld   a, [_RAM_CF2C_]
	ld   [gfx__src_addr_lo__RAM_C135_maybe], a
	ld   a, [_RAM_CF2D_]
	ld   [gfx__src_addr_hi__RAM_C136_maybe], a
	ld   a, $05
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_1BF6_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_1BF6_
	or   a
	jp   z, _LABEL_160B_
	push af
	ld   a, [_RAM_C232_]
	add  a
	ld   hl, $1058
	ld   d, $00
	ld   e, a
	add  hl, de
	pop  af
	cp   [hl]
	jp   z, _LABEL_1B6F_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_160B_
	jr   _LABEL_1BF6_

_LABEL_1C17_:
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	ld   de, $0014
	ld   hl, $98A0
	rst  $10	; _LABEL_10_
	ld   de, $0015
	ld   hl, $98C0
	rst  $10	; _LABEL_10_
	ld   de, $0016
	ld   hl, $9940
	rst  $10	; _LABEL_10_
	call gfx__turn_on_screen_bg_obj__2540
_LABEL_1C35_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_1C35_
	jp   _LABEL_160B_

_LABEL_1C3D_:
	ld   a, [_RAM_C24E_]
	or   a
	jr   nz, _LABEL_1C53_
	ld   a, [_RAM_C24B_]
	inc  a
	ld   [_RAM_C24B_], a
	cp   $0F
	jr   nz, _LABEL_1C50_
	xor  a
	ret

_LABEL_1C50_:
	call _LABEL_1CC6_
_LABEL_1C53_:
	ld   a, [_RAM_C24C_]
	ld   l, a
	ld   a, [_RAM_C24D_]
	ld   h, a
_LABEL_1C5B_:
	push hl
	ld   de, _RAM_C11B_
_LABEL_1C5F_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_1CB4_
	cp   [hl]
	jr   nz, _LABEL_1C73_
	inc  hl
	ld   a, [hl]
	or   a
	jr   nz, _LABEL_1C5F_
	ld   a, [de]
	or   a
	jr   z, _LABEL_1CB4_
	pop  hl
	jr   _LABEL_1C8C_

_LABEL_1C73_:
	ld   a, [_RAM_C5F4_]
	or   a
	jr   z, _LABEL_1C86_
	pop  hl
_LABEL_1C7A_:
	inc  hl
	ld   a, [hl]
	or   a
	jr   z, _LABEL_1C8C_
	cp   $20
	jr   nz, _LABEL_1C7A_
	inc  hl
	jr   _LABEL_1C5B_

_LABEL_1C86_:
	pop  hl
	inc  hl
	ld   a, [hl]
	or   a
	jr   nz, _LABEL_1C5B_
_LABEL_1C8C_:
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
	ld   a, $05
	call _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	ld   a, [_RAM_C24E_]
	ld   l, a
	ld   a, [_RAM_C24F_]
	ld   h, a
	dec  hl
	ld   a, l
	ld   [_RAM_C24E_], a
	ld   a, h
	ld   [_RAM_C24F_], a
	jr   _LABEL_1C3D_

_LABEL_1CB4_:
	ld   a, [_RAM_C5F4_]
	or   a
	jr   z, _LABEL_1CC2_
	ld   a, [hl]
	or   a
	jr   z, _LABEL_1CC2_
	cp   $20
	jr   nz, _LABEL_1C73_
_LABEL_1CC2_:
	pop  hl
	ld   a, $01
	ret

_LABEL_1CC6_:
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   a, [_RAM_C24B_]
	dec  a
	add  a
	add  a
	ld   l, a
	ld   h, $40
	ldi  a, [hl]
	ld   e, a
	ldi  a, [hl]
	ld   d, a
	ldi  a, [hl]
	ld   [_RAM_C24A_], a
	ld   a, [hl]
	ld   [_RAM_C24E_], a
	ld   a, [_RAM_C24A_]
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   a, [_RAM_C5F5_]
	or   a
	call nz, _LABEL_1A4F_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	ret

_LABEL_1CF6_:
	ld   a, e
	ld   [_RAM_C399_], a
	ld   a, b
	ld   [_RAM_C39A_], a
	ld   a, c
	ld   [_RAM_C24F_], a
	di
	ld   a, $44
	ldh  [rSTAT], a
	ld   a, $03
	ldh  [rIE], a
	ei
	ret

_LABEL_1D0D_:
	ld   a, d
	or   a
	jr   nz, _LABEL_1D1D_
	push hl
	ld   h, a
	ld   l, e
	add  hl, hl
	ld   de, gfx__tilemap_string_addr_table__RAM_CEFE
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl
_LABEL_1D1D_:
	ld   a, [de]
	inc  de
	or   a
	ret  z
	sub  $20
	ldi  [hl], a
	jr   _LABEL_1D0D_

_LABEL_1D26_:
	ld   a, [de]
	inc  de
	or   a
	ret  z
	ldi  [hl], a
	jr   _LABEL_1D26_

_LABEL_1D2D_:
	ld   h, d
	ld   l, e
	add  hl, hl
	ld   de, $CF00
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	push de
	ld   h, d
	ld   l, e
	ld   bc, _DATA_13_
	add  hl, bc
	ld   b, $00
_LABEL_1D40_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   nz, _LABEL_1D49_
	inc  b
	jr   _LABEL_1D40_

_LABEL_1D49_:
	ldd  a, [hl]
	cp   $20
	jr   nz, _LABEL_1D51_
	inc  b
	jr   _LABEL_1D49_

_LABEL_1D51_:
	ld   a, $16
	sub  b
	pop  de
	cp   $15
	ret  c
	ld   a, $14
	ret

_LABEL_1D5B_:
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	ld   de, $0028
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $0029
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $002A
	call _LABEL_1D2D_
	ld   bc, $0A09
	jp   _LABEL_BC3_

; Data from 1D85 to 1D87 (3 bytes)
_DATA_1D85_:
db $02, $06, $0A

_LABEL_1D88_:
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	ld   de, $001C
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $001D
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $001E
	call _LABEL_1D2D_
	ld   bc, $0A09
	jp   _LABEL_BC3_

_LABEL_1DB2_:
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	ld   de, $0022
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $0023
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $0024
	call _LABEL_1D2D_
	ld   bc, $0A09
	jp   _LABEL_BC3_

_LABEL_1DDC_:
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	ld   de, $0025
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $0026
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $0027
	call _LABEL_1D2D_
	ld   bc, $0A09
	jp   _LABEL_BC3_

_LABEL_1E06_:
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	ld   de, $001F
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $0020
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $0021
	call _LABEL_1D2D_
	ld   bc, $0A09
	jp   _LABEL_BC3_

; Data from 1E30 to 1E33 (4 bytes)
_DATA_1E30_:
db $03, $06, $0A, $0E

_LABEL_1E34_:
	ld   hl, _DATA_1E30_
	call _LABEL_2003_
	ld   de, $0018
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $0019
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $001A
	call _LABEL_1D2D_
	ld   bc, $0A09
	call _LABEL_BC3_
	ld   de, $001B
	call _LABEL_1D2D_
	ld   bc, $0E09
	jp   _LABEL_BC3_

_LABEL_1E6A_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call gfx__clear_shadow_oam__275B
	call _LABEL_424_
	call _LABEL_2735_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_C4C3_

_LABEL_1E7F_:
	call _LABEL_1E88_
	jp   z, _LABEL_C521_
	jp   _LABEL_1E6A_

_LABEL_1E88_:
	xor  a
	ld   [_RAM_C3AA_], a
	ld   a, [_RAM_C59C_]
	or   a
	ret  z
	ld   hl, _RAM_C59B_
	dec  [hl]
	xor  a
	ld   [_RAM_C59C_], a
	inc  a
	ret

; Data from 1E9B to 2002 (360 bytes)
_DATA_1E9B_:
db $5F
ds 18, $60
db $61, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $6A
ds 18, $6C
db $6B, $62
ds 18, $63
db $64

_LABEL_2003_:
	ld   a, $0A
	ld   [_RAM_C25B_], a
	ld   a, $96
	ld   [_RAM_C25C_], a
	ld   a, l
	ld   [_RAM_C254_], a
	ld   a, h
	ld   [_RAM_C255_], a
	ldi  a, [hl]
	ld   [_RAM_C256_], a
	xor  a
	ld   [_RAM_C23E_], a
	inc  a
	ld   [_RAM_C257_], a
	ld   a, $1B
	ldh  [rOBP0], a
	ld   a, $05
	ld   [_RAM_C253_], a
	ld   a, $41
	ld   [_RAM_C23F_], a
	ldi  a, [hl]
	add  $02
	add  a
	add  a
	add  a
	add  $04
	ld   [_RAM_C250_], a
	xor  a
	ld   [_RAM_C251_], a
	ld   a, $08
	ld   [_RAM_C252_], a
	ret

_LABEL_2044_:
	ld   a, c
	ld   [_RAM_C258_], a
	ld   a, b
	ld   [_RAM_C259_], a
	call gfx__turn_off_screen_2827
	call _LABEL_463_
	call gfx__turn_on_screen_bg_obj__2540
	xor  a
	ld   [_RAM_C23E_], a
	ld   a, $39
	ld   [_RAM_C25A_], a
	ld   a, $1B
	ldh  [rOBP0], a
	ld   a, $05
	ld   [_RAM_C253_], a
	ld   a, $41
	ld   [_RAM_C23F_], a
	ret

_LABEL_206D_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C25B_]
	ld   c, a
	ld   a, [_RAM_C250_]
	ld   b, a
	ld   a, [_RAM_C251_]
	inc  a
	and  $0F
	ld   e, a
	ld   a, [_RAM_C253_]
	cp   $05
	jr   nz, _LABEL_2088_
	ld   a, e
	ld   [_RAM_C251_], a
_LABEL_2088_:
	ld   a, e
	add  $22
	ld   e, a
	call _LABEL_1504_
	ld   a, [_RAM_C25C_]
	ld   c, a
	ld   a, [_RAM_C250_]
	ld   b, a
	ld   a, [_RAM_C252_]
	inc  a
	and  $0F
	ld   e, a
	ld   a, [_RAM_C253_]
	cp   $05
	jr   nz, _LABEL_20A9_
	ld   a, e
	ld   [_RAM_C252_], a
_LABEL_20A9_:
	ld   a, e
	add  $22
	ld   e, a
	call _LABEL_1504_
	ld   a, [_RAM_C253_]
	dec  a
	jr   nz, _LABEL_20B8_
	ld   a, $05
_LABEL_20B8_:
	ld   [_RAM_C253_], a
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_20D2_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [gamepad_buttons__RAM_C103]
	and  $C4
	jr   nz, _LABEL_20F5_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_20F5_

_LABEL_20D2_:
	ld   a, [gamepad_buttons__RAM_C103]
	and  $C4
	jr   z, _LABEL_20F5_
	ld   e, a
	ld   a, $19
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_213A_
	bit  7, a
	jr   nz, _LABEL_210C_
	bit  2, a
	jr   z, _LABEL_20F5_
_LABEL_20EC_:
	ld   a, [gamepad_buttons__RAM_C103]
	bit  2, a
	jr   nz, _LABEL_20EC_
	jr   _LABEL_2145_

_LABEL_20F5_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jp   z, _LABEL_206D_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_2145_
	cp   $0F
	jr   z, _LABEL_213A_
	cp   $12
	jp   nz, _LABEL_206D_
_LABEL_210C_:
	ld   a, [_RAM_C256_]
	ld   c, a
	ld   a, [_RAM_C257_]
	cp   c
	jr   nz, _LABEL_2117_
	xor  a
_LABEL_2117_:
	inc  a
_LABEL_2118_:
	ld   [_RAM_C257_], a
	ld   a, [_RAM_C254_]
	ld   l, a
	ld   a, [_RAM_C255_]
	ld   h, a
	ld   a, [_RAM_C257_]
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	add  $02
	add  a
	add  a
	add  a
	add  $04
	ld   [_RAM_C250_], a
	jp   _LABEL_206D_

_LABEL_213A_:
	ld   a, [_RAM_C257_]
	dec  a
	jr   nz, _LABEL_2118_
	ld   a, [_RAM_C256_]
	jr   _LABEL_2118_

_LABEL_2145_:
	xor  a
	ld   [_RAM_C23F_], a
	call gfx__clear_shadow_oam__275B
	ld   a, [_RAM_C257_]
	ret

; Data from 2150 to 2164 (21 bytes)
_DATA_2150_:
ds 20, $20
db $00

; Data from 2165 to 2172 (14 bytes)
_DATA_2165_:
db $0A, $06, $08, $05, $01, $0C, $00, $03, $09, $04, $07, $0B, $0D, $02

_LABEL_2173_:
	ld   a, c
	cp   $13
	ret  z
	ld   [_RAM_C25D_], a
	push de
	push hl
	ld   a, b
	ld   [_RAM_C25E_], a
	add  a
	add  a
	ld   b, a
	add  a
	add  a
	ld   d, $00
	ld   e, a
	ld   h, $00
	ld   l, b
	add  hl, de
	ld   c, l
	ld   b, h
	pop  hl
	pop  de
	add  hl, bc
	push hl
	ld   a, [_RAM_C25E_]
	ld   h, $00
	ld   l, a
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, de
	ld   d, h
	ld   e, l
	pop  hl
	push de
	push hl
	ld   de, $0013
	add  hl, de
	ld   d, h
	ld   e, l
	dec  de
	ld   a, [_RAM_C25D_]
	ld   c, a
	ld   a, $13
	sub  c
	ld   c, a
_LABEL_21B2_:
	ld   a, [de]
	dec  de
	ldd  [hl], a
	dec  c
	jr   nz, _LABEL_21B2_
	ld   a, $20
	ld   [hl], a
	pop  hl
	ld   de, _RAM_C261_
	ld   b, $14
_LABEL_21C1_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_21C1_
	xor  a
	ld   [de], a
	pop  hl
	ld   de, $C261
	ld   a, [vblank__dispatch_select__RAM_C27C]
	push af
	rst  $20	; _LABEL_20_
	pop  af
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

_LABEL_21D7_:
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ret

; Data from 21E1 to 2208 (40 bytes)
db $52, $4D, $43, $45, $4E, $50, $51, $69, $4E, $53, $4C, $44, $56, $52, $45, $67
db $4E, $46, $45, $44, $53, $50, $51, $6F, $4E, $48, $42, $45, $50, $41, $53, $72
db $4E, $46, $43, $52, $50, $45, $55, $21

; 4th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_2209_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_SRAM_231_]
	or   a
	jr   z, _LABEL_2215_
	ld   a, $01
_LABEL_2215_:
	ld   [_RAM_C10B_], a
_LABEL_2218_:
	ld   a, $F2
	ldh  [rOBP0], a
	call gfx__clear_shadow_oam__275B
	ld   a, $01
	ld   [_RAM_C260_], a
	di
	ld   a, $04
	ldh  [rSTAT], a
	ld   a, $01
	ldh  [rIE], a
	ei
	call _LABEL_3EF_
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_B75C_
	ld   bc, $FFE4
	ld   e, $70
	call _LABEL_1CF6_
_LABEL_2241_:
	call _LABEL_1563_
_LABEL_2244_:
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
_LABEL_224C_:
	ld   a, $01
	ld   [_RAM_C280_], a
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_224C_
	or   a
	jp   z, _LABEL_200_
	push af
	ld   a, [_RAM_C232_]
	add  a
	add  a
	add  a
	ld   d, $00
	ld   e, a
	ld   hl, $21E1
	add  hl, de
	pop  af
	cp   [hl]
	jr   nz, _LABEL_2286_
	ld   a, [_RAM_C10D_]
	push af
	ld   a, [_RAM_C10B_]
	ld   [_RAM_C10D_], a
	call _LABEL_4C9_
	call gfx__clear_shadow_oam__275B
	call _LABEL_B7F7_
	pop  af
	ld   [_RAM_C10D_], a
	jp   _LABEL_2244_

_LABEL_2286_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_229E_
	ld   a, [_SRAM_231_]
	cp   $1E
	jr   z, _LABEL_224C_
	xor  a
	ld   [_RAM_C596_], a
	call _LABEL_B1CA_
	call _LABEL_D58_
	jp   _LABEL_2241_

_LABEL_229E_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_22B2_
	call _LABEL_132B_
	push af
	call _LABEL_B743_
	pop  af
	or   a
	jr   z, _LABEL_224C_
	call _LABEL_2300_
	jr   _LABEL_224C_

_LABEL_22B2_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_22CA_
	ld   a, [_RAM_C10B_]
	or   a
	jr   z, _LABEL_224C_
	ld   a, $01
	ld   [_RAM_C596_], a
	call _LABEL_B1F7_
	call _LABEL_D58_
	jp   _LABEL_2241_

_LABEL_22CA_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_22DF_
	ld   a, [_SRAM_231_]
	ld   c, a
	ld   a, [_RAM_C10B_]
	cp   c
	jp   z, _LABEL_224C_
	ld   a, [_RAM_C10B_]
	inc  a
	jr   _LABEL_22EF_

_LABEL_22DF_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_22F8_
	ld   a, [_RAM_C10B_]
	cp   $02
	jp   c, _LABEL_224C_
	ld   a, [_RAM_C10B_]
	dec  a
_LABEL_22EF_:
	ld   [_RAM_C10B_], a
	call _LABEL_B765_
	jp   _LABEL_224C_

_LABEL_22F8_:
	inc  hl
	cp   [hl]
	jp   z, _LABEL_200_
	jp   _LABEL_224C_

_LABEL_2300_:
	call _LABEL_24D5_
	ld   a, [_RAM_C10B_]
	or   a
	ret  z
	dec  a
	add  a
	ld   e, a
	ld   d, $00
	ld   h, d
	ld   l, a
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, de
	ld   de, $A233
	add  hl, de
	ld   a, [_RAM_C10B_]
	ld   c, a
	ld   a, $1E
	sub  c
	jr   z, _LABEL_2340_
	push hl
	ld   de, $0042
	ld   hl, $0000
_LABEL_2329_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_2329_
	ld   b, h
	ld   c, l
	pop  hl
	push hl
	ld   de, $0042
	add  hl, de
	ld   d, h
	ld   e, l
	pop  hl
_LABEL_2338_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_2338_
_LABEL_2340_:
	ld   a, [_SRAM_231_]
	dec  a
	ld   [_SRAM_231_], a
	ld   c, a
	ld   a, [_RAM_C10B_]
	cp   c
	jr   c, _LABEL_2354_
	jr   z, _LABEL_2354_
	dec  a
	ld   [_RAM_C10B_], a
_LABEL_2354_:
	call _LABEL_B75C_
	jp   _LABEL_224C_

_LABEL_235A_:
	or   a
	ret  z
	ld   b, a
_LABEL_235D_:
	push bc
	call _LABEL_2366_
	pop  bc
	dec  b
	jr   nz, _LABEL_235D_
	ret

_LABEL_2366_:
	ld   hl, _RAM_C268_
_LABEL_2369_:
	inc  [hl]
	ld   a, [hl]
	cp   $3A
	ret  nz
	ld   [hl], $30
	dec  hl
	jr   _LABEL_2369_

; Data from 2373 to 2384 (18 bytes)
db $30, $38, $48, $50, $60, $68, $70, $78, $38, $40, $50, $58, $68, $70, $68, $70
db $80, $88

; 20th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_2385_:
	call _LABEL_30A1_
	ld   b, $02
	ld   hl, $99AC
	jr   _LABEL_23B8_

; 25th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_238F_:
	ld   b, $03
	ld   hl, (_TILEMAP0 + $85)
	ld   de, _RAM_C261_
_LABEL_2397_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	inc  hl
	dec  b
	jr   nz, _LABEL_2397_
	dec  hl
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	jp   vblank__cmd_default__25F7

; 19th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_23B3_:
	ld   b, $03
	ld   hl, $99E6
_LABEL_23B8_:
	ld   de, _RAM_C261_
_LABEL_23BB_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	inc  hl
	dec  b
	jr   nz, _LABEL_23BB_
	jp   vblank__cmd_default__25F7

; 17th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_23CC_:
	ld   hl, (_TILEMAP0 + $05)
	ld   a, [_RAM_C260_]
	or   a
	jr   nz, _LABEL_23D8_
	ld   hl, $99E5
_LABEL_23D8_:
	ld   de, _RAM_C261_
	ld   b, $03
_LABEL_23DD_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	inc  hl
	dec  b
	jr   nz, _LABEL_23DD_
	dec  hl
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	sub  $20
	ldi  [hl], a
	jp   vblank__cmd_default__25F7

; 18th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_23F8_:
	ld   de, _RAM_C261_
	ld   hl, (_TILEMAP0 + $25)
	ld   b, $02
_LABEL_2400_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	inc  hl
	dec  b
	jr   nz, _LABEL_2400_
	jp   vblank__cmd_default__25F7

_LABEL_2411_:
	call _LABEL_241A_
	push af
	call gfx__clear_shadow_oam__275B
	pop  af
	ret

_LABEL_241A_:
	ld   [_RAM_C282_], a
	ld   a, c
	ld   [_RAM_C27B_], a
	ld   a, b
	ld   [_RAM_C27A_], a
	ld   a, e
	ld   [_RAM_C276_], a
	ld   a, d
	ld   [_RAM_C277_], a
	ld   a, l
	ld   [_RAM_C278_], a
	ld   a, h
	ld   [_RAM_C279_], a
_LABEL_2435_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C276_]
	ld   l, a
	ld   a, [_RAM_C277_]
	ld   h, a
	ld   a, [_RAM_C27B_]
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	ld   [_RAM_C281_], a
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_2435_
	or   a
	jr   nz, _LABEL_246F_
	ld   a, [_RAM_C260_]
	cp   $C7
	jr   nz, _LABEL_2468_
	xor  a
	ld   [_RAM_C260_], a
	ld   hl, $FFFE
	ld   sp, hl
	jp   _LABEL_AF1_

_LABEL_2468_:
	or   a
	jp   nz, _LABEL_2218_
	ld   a, $FF
	ret

_LABEL_246F_:
	cp   $0D
	ret  z
	cp   $10
	jr   z, _LABEL_24A9_
	cp   $11
	jr   z, _LABEL_2495_
	cp   $30
	jr   c, _LABEL_2435_
	cp   $3A
	jr   nc, _LABEL_2435_
	ld   c, a
	ld   a, [_RAM_C278_]
	ld   l, a
	ld   a, [_RAM_C279_]
	ld   h, a
	ld   a, [_RAM_C27B_]
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], c
_LABEL_2495_:
	ld   a, [_RAM_C27B_]
	ld   c, a
	ld   a, [_RAM_C27A_]
	cp   c
	jr   nz, _LABEL_24A2_
	xor  a
	jr   _LABEL_24A4_

_LABEL_24A2_:
	ld   a, c
	inc  a
_LABEL_24A4_:
	ld   [_RAM_C27B_], a
	jr   _LABEL_2435_

_LABEL_24A9_:
	ld   a, [_RAM_C27B_]
	dec  a
	cp   $FF
	jr   nz, _LABEL_24B4_
	ld   a, [_RAM_C27A_]
_LABEL_24B4_:
	ld   [_RAM_C27B_], a
	jp   _LABEL_2435_


; 16th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
vblank__cmd_copy_text__24BA:
    ; Dest  : RAM_C134,RAM_C133 (DE)
    ; Source: RAM_C135,RAM_C136 (HL)
	ld   a, [gfx__dest_addr_lo__RAM_C133_maybe]
	ld   e, a
	ld   a, [gfx__dest_addr_hi__RAM_C134_maybe]
	ld   d, a

	ld   a, [gfx__src_addr_lo__RAM_C135_maybe]
	ld   l, a
	ld   a, [gfx__src_addr_hi__RAM_C136_maybe]
	ld   h, a
    ; Copies bytes from Source (HL) to DE
    ; subtracting 32 from each byte before writing it (adjust to start of font tiles)
    .copy_loop__24CA:
    	ldi  a, [hl]
    	or   a
        ; Jump back to vblank handler when done
    	jp   z, vblank__cmd_default__25F7
    	sub  32 ; $20
    	ld   [de], a
    	inc  de
    	jr   .copy_loop__24CA


_LABEL_24D5_:
	ld   hl, _TILEMAP0
	ld   b, $07
_LABEL_24DA_:
	ld   a, l
	ld   [_RAM_C105_], a
	ld   a, h
	ld   [_RAM_C106_], a
	ld   a, $0E
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   de, $0040
	add  hl, de
	dec  b
	jr   nz, _LABEL_24DA_
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

input_read_gamepad_buttons__ROM_24F4:
	ld   a, $20
	ldh  [rP1], a
	ldh  a, [rP1]
	ldh  a, [rP1]
	cpl
	and  $0F
	rlca
	rlca
	rlca
	rlca
	ld   b, a
	ld   a, $10
	ldh  [rP1], a
	ldh  a, [rP1]
	ldh  a, [rP1]
	ldh  a, [rP1]
	ldh  a, [rP1]
	ldh  a, [rP1]
	ldh  a, [rP1]
	cpl
	and  $0F
	or   b
	ld   c, a
	ld   a, [gamepad_buttons__RAM_C103]
	xor  c
	and  c
	ld   [_RAM_C104_], a  ; TODO: label: maybe buttons changed?
	ld   a, c
	ld   [gamepad_buttons__RAM_C103], a
	ld   a, [$0030]
	ldh  [rP1], a
	ld   a, [gamepad_buttons__RAM_C103]
	and  $0F
	xor  $0F
	add  a
	add  a
	add  a
	add  a
	add  $0F
	ld   e, a
	ld   a, [gamepad_buttons__RAM_C103]
	and  e
	ld   [gamepad_buttons__RAM_C103], a
	ret


gfx__turn_on_screen_bg_obj__2540:
	ld   a, (LCDCF_ON | LCDCF_OBJON | LCDCF_BGON) ; $83
	ld   [_RAM_C23C_], a ; TODO: VAR: Some cache of LCDC settings?
	ldh  [rLCDC], a
	ret


gfx__vsync__2548:
	push af
	push hl
	ld   a, [vblank__frame_counter_maybe__RAM_C100]
	ld   hl, vblank__frame_counter_maybe__RAM_C100 ; $C100
	halt
    ; Wait for frame counter to change
    .wait_new_frame_loop__2551_:
    	cp   [hl]
    	jr   z, .wait_new_frame_loop__2551_
	pop  hl
	pop  af
	ret

; Jump Table from 2557 to 2588 (25 entries, indexed by vblank__dispatch_select__RAM_C27C)
vblank__dispatch_table__2557:
    dw vblank__cmd_default__25F7  ; VBL_CMD__DEFAULT__0x00
    dw _LABEL_B973_  ; VBL_COMMAND__0x01
    dw _LABEL_26C6_  ; VBL_COMMAND__0x02
    dw $2694         ; VBL_COMMAND__0x03
    dw _LABEL_2667_  ; VBL_COMMAND__0x04
    dw _LABEL_7FC_   ; VBL_COMMAND__0x05
    dw _LABEL_7E9_   ; VBL_COMMAND__0x06
    dw _LABEL_79A_   ; VBL_COMMAND__0x07
    dw _LABEL_13FD_  ; VBL_COMMAND__0x08
    dw _LABEL_604_   ; VBL_COMMAND__0x09
    dw _LABEL_309B_  ; VBL_COMMAND__0x0A
    dw _LABEL_1366_  ; VBL_COMMAND__0x0B
    dw _LABEL_13BC_  ; VBL_COMMAND__0x0C
    dw _LABEL_1388_  ; VBL_COMMAND__0x0D
    dw _LABEL_25AE_  ; VBL_COMMAND__0x0E
    dw vblank__cmd_copy_text__24BA  ; VBL_CMD__COPY_TEXT__0x0F
    dw _LABEL_23CC_  ; VBL_COMMAND__0x10
    dw _LABEL_23F8_  ; VBL_COMMAND__0x11
    dw _LABEL_23B3_  ; VBL_COMMAND__0x12
    dw _LABEL_2385_  ; VBL_COMMAND__0x13
    dw _LABEL_2591_  ; VBL_COMMAND__0x14
    dw _LABEL_13E2_  ; VBL_COMMAND__0x15
    dw _LABEL_2BCF_  ; VBL_COMMAND__0x16
    dw $4C44         ; VBL_COMMAND__0x17
    dw _LABEL_238F_  ; VBL_COMMAND__0x18


; Data from 2589 to 2590 (8 bytes)
db $57, $4C, $B1, $2C, $92, $79, $AF, $79

; 21st entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_2591_:
	ld   hl, (_TILEMAP0 + $44)
	ld   de, _RAM_C13D_
	ld   b, $03
	call _LABEL_25A5_
	inc  hl
	ld   b, $08
	call _LABEL_25A5_
	jp   _LABEL_309B_

_LABEL_25A5_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_25A5_
	ret

; 15th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_25AE_:
	ld   a, [_RAM_C105_]
	ld   l, a
	ld   a, [_RAM_C106_]
	ld   h, a
	ld   b, $34
	xor  a
_LABEL_25B9_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_25B9_
	jp   vblank__cmd_default__25F7

; Data from 25C0 to 25CB (12 bytes)
db $CD, $F4, $24, $FA, $03, $C1, $B7, $20, $F7, $C3, $00, $00

vblank__handler__25CC:
	push af
	push bc
	push de
	push hl

    ; TODO: maybe testing whether to load gamepad input vs keyboard input?
	ld   a, [_RAM_C10E_]
	or   a
	jr   nz, .todo_skip_something__25E0
    	ld   a, [gamepad_buttons__RAM_C103]
    	ld   [_RAM_C592_], a
    	and  $0F
    	xor  $0F
    .todo_skip_something__25E0:

	call gfx__oam_dma__RAM_FF80	; Code is loaded from gfx__oam_dma_in_ROM__2751
    ; Update Y scroll
	ld   a, [gfx__shadow_y_scroll__RAM_C102]
	ldh  [rSCY], a

    ; Load and jump to currently selected vblank sub-routine
	ld   a, [vblank__dispatch_select__RAM_C27C]
	add  a
	ld   d, $00
	ld   e, a
	ld   hl, vblank__dispatch_table__2557
	add  hl, de
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	jp   hl

    ; 1st entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
    vblank__cmd_default__25F7:
    	ld   a, [_RAM_C27D_]
    	ldh  [rBGP], a
    	ld   a, [_RAM_C399_]
    	ldh  [rLYC], a
    	call input_read_gamepad_buttons__ROM_24F4
        ; MAYBE: Increment frame counter
    	ld   hl, vblank__frame_counter_maybe__RAM_C100
    	inc  [hl]

    	call _LABEL_2FE6_
    	call _LABEL_357E_
    	ld   a, [_RAM_C3AA_]
    	or   a
    	jr   z, _LABEL_2659_
    	ld   a, [gamepad_buttons__RAM_C103]
    	bit  0, a
    	jr   z, _LABEL_2628_
    	call _LABEL_1E88_
    	ld   a, [_RAM_C3DE_]
    	cp   $0D
    	call nc, _LABEL_380D_
    	jr   _LABEL_2659_

    _LABEL_2628_:
    	ld   a, [_RAM_C3DE_]
    	cp   $0D
    	jr   z, _LABEL_2659_
    	cp   $0E
    	jr   z, _LABEL_2659_
    	ld   a, [_RAM_C3AB_]
    	dec  a
    	jr   z, _LABEL_263E_

    	ld   [_RAM_C3AB_], a
    	jr   _LABEL_2659_

    _LABEL_263E_:
    	ld   hl, _RAM_C3AA_
    	dec  [hl]
    	xor  a
    	cp   [hl]
    	jr   nz, _LABEL_264B_

    	call _LABEL_1E88_
    	jr   _LABEL_2659_

    _LABEL_264B_:
    	ld   b, $04
    	ld   a, $2C
    	ld   c, $11
    	call _LABEL_33FC_
    	ld   a, $3C
    	ld   [_RAM_C3AB_], a
    _LABEL_2659_:
    	ld   a, [_RAM_C3DF_]
    	or   a
    	jr   z, _LABEL_2662_

    	call _LABEL_379C_

    _LABEL_2662_:
    	pop  hl
    	pop  de
    	pop  bc
    	pop  af
    	reti

; 5th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_2667_:
	ld   de, _RAM_C283_
	ld   hl, $98EA
	ld   b, $07
_LABEL_266F_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_266F_
	ld   hl, $994A
	ld   b, $07
_LABEL_267C_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_267C_
	ld   hl, $99A3
	ld   b, $0E
_LABEL_2689_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_2689_
	jp   vblank__cmd_default__25F7

; Data from 2694 to 26C5 (50 bytes)
db $FA, $7E, $C2, $3D, $28, $06, $EA, $7E, $C2, $C3, $F7, $25, $3E, $14, $EA, $7E
db $C2, $FA, $3B, $C1, $6F, $FA, $3C, $C1, $67, $FA, $7F, $C2, $EE, $01, $EA, $7F
db $C2, $28, $08, $FA, $52, $C1, $CD, $90, $49, $18, $DE, $AF, $22, $3E, $C2, $77
db $18, $D7

; 3rd entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_26C6_:
	xor  a
	ld   [$99EB], a
	ld   hl, $99EC
	ld   a, [_RAM_C47C_]
	or   a
	jr   z, _LABEL_26E5_
	ld   a, [_RAM_C355_]
	cp   $F6
	jr   nz, _LABEL_26E0_
	dec  hl
	ld   [hl], $0D
	inc  hl
	jr   _LABEL_26E5_

_LABEL_26E0_:
	ld   a, $2D
	ld   [_RAM_C356_], a
_LABEL_26E5_:
	ld   a, [_RAM_C356_]
	cp   $3A
	jr   c, _LABEL_26F4_
	sub  $0A
	push af
	ld   a, $11
	dec  hl
	ldi  [hl], a
	pop  af
_LABEL_26F4_:
	sub  $20
	ldi  [hl], a
	ld   a, [_RAM_C357_]
	sub  $20
	ldi  [hl], a
	ld   de, _RAM_C358_
	ld   hl, $99E4
	ld   a, [_RAM_C355_]
	bit  7, a
	jr   nz, _LABEL_270E_
	cp   $26
	jr   nc, _LABEL_2711_
_LABEL_270E_:
	ld   [hl], $00
	inc  hl
_LABEL_2711_:
	ld   a, [de]
	or   a
	jr   z, _LABEL_271B_
	sub  $20
	ldi  [hl], a
	inc  de
	jr   _LABEL_2711_

_LABEL_271B_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   vblank__cmd_default__25F7

_LABEL_2722_:
	call gfx__turn_off_screen_2827
	ld   hl, _TILEMAP0
	ld   bc, $0400
_LABEL_272B_:
	xor  a
	ldi  [hl], a
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_272B_
	jp   gfx__turn_on_screen_bg_obj__2540

_LABEL_2735_:
	ld   hl, _TILEMAP0
	ld   bc, $0240
_LABEL_273B_:
	xor  a
	ldi  [hl], a
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_273B_
	ret

gfx__copy_oam_dma_to_RAM__2743:
    ; Destination Address
    ; Num Bytes to copy
    ; Source Address
	ld   c, LOW(gfx__oam_dma__RAM_FF80)
	ld   b, (gfx__oam_dma_in_ROM_end__275B - gfx__oam_dma_in_ROM__2751) ; $0A
	ld   hl, gfx__oam_dma_in_ROM__2751	; Loading Code into RAM
    .oam_dma_copy_loop__274A:
    	ldi  a, [hl]
    	ldh  [c], a
    	inc  c
    	dec  b
    	jr   nz, .oam_dma_copy_loop__274A
    ret

; Executed in RAM at ff80
gfx__oam_dma_in_ROM__2751:
	ld   a, $C0
	ldh  [rDMA], a
	ld   a, $28
    ; Executed in RAM at ff86
    .oam_dma_wait_loop__2757:
    	dec  a
    	jr   nz, .oam_dma_wait_loop__2757
    ret
    gfx__oam_dma_in_ROM_end__275B:


gfx__clear_shadow_oam__275B:
	ld   hl, shadow_oam_base__RAM_C000
	ld   b, 160 ; $A0
	xor  a
    .shadow_oam_clear_loop__2761:
    	ldi  [hl], a
    	dec  b
    	jr   nz, .shadow_oam_clear_loop__2761
    	ld   [_RAM_C107_], a
	ret


_LABEL_2769_:
	call gfx__clear_shadow_oam__275B
	ld   a, [_RAM_C280_]
	cp   $04
	jr   z, _LABEL_27A7_
	ld   a, [_RAM_C114_]
	dec  a
	jr   z, _LABEL_277E_
	ld   [_RAM_C114_], a
	jr   _LABEL_278B_

_LABEL_277E_:
	ld   a, $1E
	ld   [_RAM_C114_], a
	ld   a, [_RAM_C113_]
	xor  $01
	ld   [_RAM_C113_], a
_LABEL_278B_:
	ld   a, [_RAM_C113_]
	or   a
	ret  z
	ld   hl, shadow_oam_base__RAM_C000
	ld   a, [_RAM_C282_]
	ldi  [hl], a
	ld   a, [_RAM_C281_]
	ldi  [hl], a
	ld   a, [_RAM_C280_]
	ldi  [hl], a
	xor  a
	ldi  [hl], a
	ld   a, $04
	ld   [_RAM_C107_], a
	ret

_LABEL_27A7_:
	ld   a, $41
	ld   [_RAM_C23F_], a
	ld   a, [_RAM_C116_]
	add  $32
	ld   e, a
	ld   a, [_RAM_C281_]
	sub  $05
	ld   c, a
	ld   a, [_RAM_C282_]
	sub  $05
	ld   b, a
	call _LABEL_1504_
	ld   a, [_RAM_C114_]
	dec  a
	jr   z, _LABEL_27CB_
	ld   [_RAM_C114_], a
	ret

_LABEL_27CB_:
	ld   a, $05
	ld   [_RAM_C114_], a
	ld   a, [_RAM_C116_]
	inc  a
	cp   $07
	jr   nz, _LABEL_27D9_
	xor  a
_LABEL_27D9_:
	ld   [_RAM_C116_], a
	ret

_LABEL_27DD_:
	ld   a, c
	ld   [_RAM_C281_], a
	ld   a, b
	ld   [_RAM_C282_], a
	ld   hl, (_TILEDATA8000 + $10)
	ld   a, $01
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	ld   de, _DATA_130B_
	ld   b, $20
_LABEL_27F2_:
	ld   a, [de]
	xor  $FF
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_27F2_
	xor  a
	ldi  [hl], a
	ldi  [hl], a
	ld   a, $2A
	ld   b, $06
_LABEL_2801_:
	ld   [hl], $7E
	inc  hl
	ldi  [hl], a
	xor  $7E
	dec  b
	jr   nz, _LABEL_2801_
	xor  a
	ldi  [hl], a
	ldi  [hl], a

	ld   de, (gfx__tile_patterns_250_font_thermometer_etc__5000 + (56 * $10)) ; _DATA_5380_ ; Source: 56th tile from start
	ld   b, $10 ; One tile pattern of bytes
    .copy_invert_color_loop__2812:
    	ld   a, [de]
    	xor  $FF
    	inc  de
    	ldi  [hl], a
    	dec  b
    	jr   nz, .copy_invert_color_loop__2812
	ld   [_RAM_C113_], a
	inc  a
	ld   [_RAM_C280_], a
	ld   a, $05
	ld   [_RAM_C114_], a
	ret


gfx__turn_off_screen_2827:
    ; Check if Screen is already OFF, if it is then return immediately
	ldh  a, [rLCDC]
	bit  LCDCF_B_ON, a ; 7, a
	ret  z

    ; Save IE state and turn OFF VBlank interrupt
	ldh  a, [rIE]
	ldh  [ie_reg_cache__RAM_FF8A], a
	and  ~IEF_VBLANK ; $FE
	ldh  [rIE], a

    ; Wait until start of VBlank (scanline 145)
    .ly_wait_loop__2834:
    	ldh  a, [rLY]
    	cp   145 ; $91
    	jr   nz, .ly_wait_loop__2834

    ; Turn Screen OFF
	ldh  a, [rLCDC]
	and  ~LCDCF_ON ; $7F
	ldh  [rLCDC], a

    ; Restore Previous IE state
	ldh  a, [ie_reg_cache__RAM_FF8A]
	ldh  [rIE], a
	ret


; 10th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_2845_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call _LABEL_424_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_D459_

_LABEL_2854_:
	ld   a, [_RAM_C10A_]
	cp   $02
	jr   nz, _LABEL_2866_
	ld   a, [gamepad_buttons__RAM_C103]
	or   a
	jr   z, _LABEL_2866_
	xor  a
	ld   [_RAM_C10A_], a
	ret

_LABEL_2866_:
	ld   a, $52
	call serial_io__send_command_wait_reply_byte__3356
	cp   $44
	jr   nz, _LABEL_2854_
	ld   a, $01
	ld   [_RAM_C10A_], a
	ld   de, _RAM_C2AE_
	ld   c, $15
_LABEL_2879_:
	ld   a, $00
	call _LABEL_29E3_
	ld   [de], a
	inc  de
	dec  c
	jr   nz, _LABEL_2879_
	call _LABEL_2916_
	call _LABEL_2942_
	call _LABEL_296E_
	call _LABEL_2CED_
_LABEL_288F_:
	ld   a, [_RAM_C2B3_]
	or   a
	rl   a
	rl   a
	rl   a
	and  $03
	ld   c, a
	ld   a, [_RAM_C2BD_]
	add  c
	ld   [_RAM_C13A_], a
	ld   a, [_RAM_C2B3_]
	and  $30
	call _LABEL_2909_
	add  a
	ld   e, a
	add  a
	add  a
	add  e
	ld   e, a
	ld   a, [_RAM_C2B3_]
	and  $0F
	add  e
	ld   [_RAM_C139_], a
	ld   a, [_RAM_C2B4_]
	ld   e, a
	and  $0F
	bit  4, e
	jr   z, _LABEL_28C6_
	add  $0A
_LABEL_28C6_:
	ld   [_RAM_C138_], a
	ld   a, [_RAM_C2B4_]
	and  $E0
	or   a
	rr   a
	call _LABEL_2909_
	ld   [_RAM_C137_], a
	ld   [_RAM_C304_], a
	ld   a, [_RAM_C139_]
	ld   e, a
	ld   a, [_RAM_C137_]
_LABEL_28E1_:
	dec  e
	jr   z, _LABEL_28ED_
	dec  a
	cp   $FF
	jr   nz, _LABEL_28E1_
	ld   a, $06
	jr   _LABEL_28E1_

_LABEL_28ED_:
	ld   [_RAM_C137_], a
	ld   a, [_RAM_C139_]
	or   a
	jp   z, _LABEL_2D4E_
	cp   $20
	jp   nc, _LABEL_2D4E_
	ld   a, [_RAM_C138_]
	or   a
	jp   z, _LABEL_2D4E_
	cp   $0D
	jp   nc, _LABEL_2D4E_
	ret

_LABEL_2909_:
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ret

_LABEL_2916_:
	ld   a, [_RAM_C2B0_]
	and  $F0
	call _LABEL_2909_
	ld   b, a
	ld   e, a
	or   a
	jr   z, _LABEL_292A_
	ld   a, $00
_LABEL_2925_:
	add  $0A
	dec  e
	jr   nz, _LABEL_2925_
_LABEL_292A_:
	ld   c, a
	ld   a, b
	add  $30
	ld   [_RAM_C39F_], a
	ld   a, [_RAM_C2B0_]
	and  $0F
	ld   b, a
	add  c
	ld   [_RAM_C3A1_], a
	ld   a, b
	add  $30
	ld   [_RAM_C3A0_], a
	ret

_LABEL_2942_:
	ld   a, [_RAM_C2B1_]
	and  $F0
	call _LABEL_2909_
	ld   b, a
	ld   e, a
	or   a
	jr   z, _LABEL_2956_
	ld   a, $00
_LABEL_2951_:
	add  $0A
	dec  e
	jr   nz, _LABEL_2951_
_LABEL_2956_:
	ld   c, a
	ld   a, b
	add  $30
	ld   [_RAM_C39D_], a
	ld   a, [_RAM_C2B1_]
	and  $0F
	ld   b, a
	add  c
	ld   [_RAM_C3A2_], a
	ld   a, b
	add  $30
	ld   [_RAM_C39E_], a
	ret

_LABEL_296E_:
	ld   a, [_RAM_C2B2_]
	and  $30
	call _LABEL_2909_
	ld   b, a
	ld   e, a
	or   a
	jr   z, _LABEL_2982_
	ld   a, $00
_LABEL_297D_:
	add  $0A
	dec  e
	jr   nz, _LABEL_297D_
_LABEL_2982_:
	ld   c, a
	ld   a, b
	add  $30
	ld   [_RAM_C39B_], a
	ld   a, [_RAM_C2B2_]
	and  $0F
	ld   b, a
	add  c
	ld   c, a
	add  a
	add  a
	add  c
	ld   [_RAM_C3A4_], a
	ld   a, b
	add  $30
	ld   [_RAM_C39C_], a
	ld   a, [_RAM_C3A2_]
	ld   c, $00
_LABEL_29A2_:
	cp   $0C
	jr   c, _LABEL_29AB_
	sub  $0C
	inc  c
	jr   _LABEL_29A2_

_LABEL_29AB_:
	ld   b, a
	ld   a, [_RAM_C3A4_]
	add  c
	ld   [_RAM_C3A4_], a
	cp   $3C
	jr   c, _LABEL_29BC_
	sub  $3C
	ld   [_RAM_C3A4_], a
_LABEL_29BC_:
	ld   a, $0C
	sub  b
	ld   [_RAM_C3A3_], a
	ret



; Sends out 0x00 and waits for non-0x00 and non-0xFF response
;
; Details:
; - Waits ~3msec
; - Turns on Serial xfer + driving clock
; - Puts byte 0x00 in Serial TX (should maybe be before turning on serial?)
; - Waits ~3msec
; - Saves resulting Serial RX Byte in A
; - ?? Turns RAM off?
; - Keeps send/wait/receiving until a non-0x00 and non-0xFF serial response
;
; Trashes A
;
; Returns RX byte in A
serial_io__maybe__send_00_wait_3msec_receive_byte_in_A__29C3:
	call delay_2_94msec__334A
    ; ? Start a transfer without loading data in rSB first ?
    ; Maybe it's just a mistake and they load rSB after instead of before?
	ld   a, (SERIAL_XFER_ENABLE | SERIAL_CLOCK_INT) ; $81
	ldh  [rSC], a
	ld   a, $00
	ldh  [rSB], a
	call delay_2_94msec__334A
	ldh  a, [rSB]
	push af
    ; TODO: ? Is this doing something non-Standard for MBC1 instead of turning of SRAM enable
	ld   a, MBC1_RAM_OFF  ; $00
	ld   [rMBC1_RAM_ENABLE_ALT], a  ; $0002
	pop  af
    ; Loop until a non-0x00 and non-0xFF serial response
	cp   $00  ; TODO: Maybe GB_WORKBOY_EMPTY? 0x00?
	jr   z, serial_io__maybe__send_00_wait_3msec_receive_byte_in_A__29C3
	cp   $FF  ; TODO: Maybe GB_WORKBOY_NONE 0xFF
	jr   z, serial_io__maybe__send_00_wait_3msec_receive_byte_in_A__29C3
	ret


_LABEL_29E3_:
	call serial_io__maybe__send_00_wait_3msec_receive_byte_in_A__29C3
	call _LABEL_29FC_
	sla  a
	sla  a
	sla  a
	sla  a
	push af
	call serial_io__maybe__send_00_wait_3msec_receive_byte_in_A__29C3
	call _LABEL_29FC_
	ld   b, a
	pop  af
	or   b
	ret

_LABEL_29FC_:
	sub  $30
	cp   $11
	jr   c, _LABEL_2A04_
	sub  $07
_LABEL_2A04_:
	ret

_LABEL_2A05_:
	xor  a
	ld   [_RAM_C306_], a
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
	ld   a, [de]
	cp   $2A
	jr   nz, _LABEL_2A27_
	inc  de
	ld   a, [de]
	cp   $2A
	jr   nz, _LABEL_2A22_
	pop  de
	ld   [_RAM_C307_], a
	xor  a
	ret

_LABEL_2A22_:
	ld   a, $01
	ld   [_RAM_C306_], a
_LABEL_2A27_:
	ld   a, [_RAM_C306_]
	or   a
	jr   z, _LABEL_2A77_
	ld   hl, _RAM_C308_
_LABEL_2A30_:
	ld   a, [de]
	cp   $20
	jr   z, _LABEL_2A39_
	cp   $41
	jr   c, _LABEL_2A3D_
_LABEL_2A39_:
	ldi  [hl], a
	inc  de
	jr   _LABEL_2A30_

_LABEL_2A3D_:
	ld   [hl], $00
	call _LABEL_2AEB_
	ld   a, [de]
	inc  de
	sub  $41
	ld   [_RAM_C25F_], a
	call _LABEL_2AB5_
	ld   hl, _SRAM_6006_
	push de
_LABEL_2A50_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	or   a
	jr   nz, _LABEL_2A50_
	pop  de
	ld   a, [_RAM_C25F_]
	cp   $03
	jr   z, _LABEL_2A62_
	ld   b, $02
	jr   _LABEL_2A64_

_LABEL_2A62_:
	ld   b, $01
_LABEL_2A64_:
	ld   a, [de]
	inc  de
	or   a
	jr   nz, _LABEL_2A64_
	dec  b
	jr   nz, _LABEL_2A64_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	ld   a, $01
	ret

_LABEL_2A77_:
	ld   hl, _RAM_C327_
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
_LABEL_2A82_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   z, _LABEL_2A90_
	cp   $2E
	jr   z, _LABEL_2A90_
	cp   $41
	jr   c, _LABEL_2A93_
_LABEL_2A90_:
	ldi  [hl], a
	jr   _LABEL_2A82_

_LABEL_2A93_:
	xor  a
	ld   [hl], a
	dec  de
	ld   hl, _RAM_C33C_
_LABEL_2A99_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   z, _LABEL_2AA2_
	ldi  [hl], a
	jr   _LABEL_2A99_

_LABEL_2AA2_:
	xor  a
	ld   [hl], a
	call _LABEL_2AEB_
	call _LABEL_2AB5_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	ld   a, $01
	ret

_LABEL_2AB5_:
	ld   b, $00
	ld   a, [de]
	inc  de
	cp   $2D
	jr   nz, _LABEL_2AC1_
	ld   b, $80
	ld   a, [de]
	inc  de
_LABEL_2AC1_:
	sub  $30
	ld   c, a
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_2ADC_
	cp   $78
	jr   z, _LABEL_2AE2_
	ld   a, c
	add  a
	ld   c, a
	add  a
	add  a
	add  c
	ld   c, a
	dec  de
	ld   a, [de]
	inc  de
	inc  de
	sub  $30
	add  c
	ld   c, a
_LABEL_2ADC_:
	ld   a, c
	add  b
	ld   [_RAM_C305_], a
	ret

_LABEL_2AE2_:
	inc  de
	ld   a, b
	add  $40
	add  c
	ld   [_RAM_C305_], a
	ret

_LABEL_2AEB_:
	call _LABEL_2AFC_
	add  $04
	ld   [_RAM_C281_], a
	call _LABEL_2AFC_
	add  $0C
	ld   [_RAM_C282_], a
	ret

_LABEL_2AFC_:
	ld   a, [de]
	inc  de
	sub  $2F
	ld   c, a
	ld   a, $92
_LABEL_2B03_:
	add  $64
	dec  c
	jr   nz, _LABEL_2B03_
	ld   b, a
	ld   a, [de]
	inc  de
	sub  $2F
	ld   c, a
	ld   a, b
_LABEL_2B0F_:
	add  $0A
	dec  c
	jr   nz, _LABEL_2B0F_
	ld   b, a
	ld   a, [de]
	inc  de
	sub  $30
	add  b
	ret

; Data from 2B1B to 2B3A (32 bytes)
_DATA_2B1B_:
db $78, $00, $78, $00, $78, $00, $78, $00, $78, $00, $78, $00, $78, $00, $78, $00
db $78, $00, $78, $00, $78, $00, $78, $00, $78, $00, $78, $00, $78, $00, $78, $00

; 7th entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_2B3B_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call gfx__turn_off_screen_2827
	ld   hl, (_TILEDATA8000 + $10)
	ld   c, $08
	ld   b, $0E
_LABEL_2B49_:
	push bc
	ld   a, b
	or   a
	jr   z, _LABEL_2B53_
	xor  a
_LABEL_2B4F_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_2B4F_
_LABEL_2B53_:
	pop  bc
	push bc
	ld   a, $10
	sub  b
	ld   b, a
	ld   de, _DATA_2B1B_
_LABEL_2B5C_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_2B5C_
	pop  bc
	dec  b
	dec  b
	dec  c
	jr   nz, _LABEL_2B49_
	ld   a, $20
	ld   [_RAM_C355_], a
	ld   [main_menu__gamepad_polling_counter__C115], a
	ld   a, $0B
	call _LABEL_3918_
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_BE47_

_LABEL_2B7D_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   a, [_RAM_C10A_]
	or   a
	ret  z
	ld   a, [_SRAM_231_]
	or   a
	ret  z
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	call _LABEL_ADDA_
	ld   a, [_RAM_C58C_]
	or   a
	ret  z
	call _LABEL_3EF_
	call _LABEL_2735_
	call gfx__turn_on_screen_bg_obj__2540
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_ACA0_

_LABEL_2BA9_:
	ld   a, [de]
	inc  de
	sub  $30
	add  a
	ld   c, a
	add  a
	add  a
	add  c
	ld   c, a
	ld   a, [de]
	inc  de
	sub  $30
	add  c
	ldi  [hl], a
	ret

_LABEL_2BBA_:
	ld   b, $00
_LABEL_2BBC_:
	cp   $0A
	jr   c, _LABEL_2BC5_
	sub  $0A
	inc  b
	jr   _LABEL_2BBC_

_LABEL_2BC5_:
	ld   c, a
	ld   a, b
	add  $30
	ldi  [hl], a
	ld   a, c
	add  $30
	ldi  [hl], a
	ret

; 23rd entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_2BCF_:
	ld   a, [gfx__dest_addr_lo__RAM_C133_maybe]
	ld   l, a
	ld   a, [gfx__dest_addr_hi__RAM_C134_maybe]
	ld   h, a
	ld   de, _RAM_C15A_
	ld   b, $03
_LABEL_2BDC_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2BE5_
	inc  hl
	jr   _LABEL_2BE6_

_LABEL_2BE5_:
	ldi  [hl], a
_LABEL_2BE6_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2BEF_
	inc  hl
	jr   _LABEL_2BF0_

_LABEL_2BEF_:
	ldi  [hl], a
_LABEL_2BF0_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2BF9_
	inc  hl
	jr   _LABEL_2BFA_

_LABEL_2BF9_:
	ldi  [hl], a
_LABEL_2BFA_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C03_
	inc  hl
	jr   _LABEL_2C04_

_LABEL_2C03_:
	ldi  [hl], a
_LABEL_2C04_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C0D_
	inc  hl
	jr   _LABEL_2C0E_

_LABEL_2C0D_:
	ldi  [hl], a
_LABEL_2C0E_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C17_
	inc  hl
	jr   _LABEL_2C18_

_LABEL_2C17_:
	ldi  [hl], a
_LABEL_2C18_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C21_
	inc  hl
	jr   _LABEL_2C22_

_LABEL_2C21_:
	ldi  [hl], a
_LABEL_2C22_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C2B_
	inc  hl
	jr   _LABEL_2C2C_

_LABEL_2C2B_:
	ldi  [hl], a
_LABEL_2C2C_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C35_
	inc  hl
	jr   _LABEL_2C36_

_LABEL_2C35_:
	ldi  [hl], a
_LABEL_2C36_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C3F_
	inc  hl
	jr   _LABEL_2C40_

_LABEL_2C3F_:
	ldi  [hl], a
_LABEL_2C40_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C49_
	inc  hl
	jr   _LABEL_2C4A_

_LABEL_2C49_:
	ldi  [hl], a
_LABEL_2C4A_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C53_
	inc  hl
	jr   _LABEL_2C54_

_LABEL_2C53_:
	ldi  [hl], a
_LABEL_2C54_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C5D_
	inc  hl
	jr   _LABEL_2C5E_

_LABEL_2C5D_:
	ldi  [hl], a
_LABEL_2C5E_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C67_
	inc  hl
	jr   _LABEL_2C68_

_LABEL_2C67_:
	ldi  [hl], a
_LABEL_2C68_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C71_
	inc  hl
	jr   _LABEL_2C72_

_LABEL_2C71_:
	ldi  [hl], a
_LABEL_2C72_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C7B_
	inc  hl
	jr   _LABEL_2C7C_

_LABEL_2C7B_:
	ldi  [hl], a
_LABEL_2C7C_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C85_
	inc  hl
	jr   _LABEL_2C86_

_LABEL_2C85_:
	ldi  [hl], a
_LABEL_2C86_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C8F_
	inc  hl
	jr   _LABEL_2C90_

_LABEL_2C8F_:
	ldi  [hl], a
_LABEL_2C90_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2C99_
	inc  hl
	jr   _LABEL_2C9A_

_LABEL_2C99_:
	ldi  [hl], a
_LABEL_2C9A_:
	ld   a, [de]
	inc  de
	cp   $FF
	jr   nz, _LABEL_2CA3_
	inc  hl
	jr   _LABEL_2CA4_

_LABEL_2CA3_:
	ldi  [hl], a
_LABEL_2CA4_:
	ld   a, b
	ld   bc, $000C
	add  hl, bc
	ld   b, a
	dec  b
	jp   nz, _LABEL_2BDC_
	jp   vblank__cmd_default__25F7

; Data from 2CB1 to 2CEC (60 bytes)
db $FA, $98, $C3, $B7, $20, $1B, $21, $A0, $98, $11, $5C, $C3, $06, $03, $C5, $06
db $14, $2A, $12, $13, $05, $20, $FA, $0E, $0C, $09, $C1, $05, $20, $F0, $C3, $F7
db $25, $21, $A0, $98, $11, $5C, $C3, $06, $03, $C5, $06, $14, $1A, $13, $22, $05
db $20, $FA, $0E, $0C, $09, $C1, $05, $20, $F0, $C3, $F7, $25

_LABEL_2CED_:
	ld   a, [_RAM_C39B_]
	cp   $30
	jr   c, _LABEL_2D4E_
	cp   $33
	jr   nc, _LABEL_2D4E_
	cp   $32
	jr   nz, _LABEL_2D03_
	ld   a, [_RAM_C39C_]
	cp   $35
	jr   nc, _LABEL_2D4E_
_LABEL_2D03_:
	ld   a, [_RAM_C39C_]
	cp   $30
	jr   c, _LABEL_2D4E_
	cp   $3A
	jr   nc, _LABEL_2D4E_
	ld   b, $02
	ld   hl, _RAM_C39D_
_LABEL_2D13_:
	ldi  a, [hl]
	cp   $30
	jr   c, _LABEL_2D4E_
	cp   $36
	jr   nc, _LABEL_2D4E_
	ldi  a, [hl]
	cp   $30
	jr   c, _LABEL_2D4E_
	cp   $3A
	jr   nc, _LABEL_2D4E_
	dec  b
	jr   nz, _LABEL_2D13_
	ret

; Data from 2D29 to 2D47 (31 bytes)
db $54, $69, $6D, $65, $2F, $44, $61, $74, $65, $20, $57, $72, $6F, $6E, $67, $00
db $42, $61, $74, $74, $65, $72, $69, $65, $73, $20, $6C, $6F, $77, $3F, $00

; Data from 2D48 to 2D4D (6 bytes)
_DATA_2D48_:
db $31, $32, $30, $30, $30, $30

_LABEL_2D4E_:
	ld   hl, _DATA_2D48_
	ld   de, _RAM_C39B_
	ld   b, $06
_LABEL_2D56_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_2D56_
	ld   a, $0C
	ld   [_RAM_C3A4_], a
	xor  a
	ld   [_RAM_C3A2_], a
	ld   [_RAM_C3A1_], a
	ld   a, $5C
	ld   [_RAM_C13A_], a
	ld   a, $01
	ld   [_RAM_C138_], a
	ld   [_RAM_C139_], a
	ld   a, $03
	ld   [_RAM_C137_], a
	call _LABEL_EB1_
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   hl, $A1F5
	ld   de, _DATA_E42A_
	ld   b, $04
_LABEL_2D89_:
	ld   a, [de]
	inc  de
	cp   [hl]
	ret  z
	inc  hl
	dec  b
	jr   nz, _LABEL_2D89_
	call _LABEL_2722_
	ld   de, $2D29
	ld   hl, (_TILEMAP0 + $60)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   de, $2D39
	ld   hl, (_TILEMAP0 + $80)
	rst  $28	; COPY_STRING_VRAM__RST_28
_LABEL_2DA2_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	inc  a
	jr   z, _LABEL_2DA2_
	ret

_LABEL_2DA7_:
	ld   a, [gamepad_buttons__RAM_C103]
	or   a
	jr   nz, _LABEL_2DA7_
	call _LABEL_380D_
	call _LABEL_2722_
	ld   hl, $0148
	call _LABEL_1076_
	push de
	ld   de, $00A4
	ld   hl, $98A0
	rst  $20	; _LABEL_20_
	ld   de, $00A5
	ld   hl, $98E0
	rst  $20	; _LABEL_20_
_LABEL_2DC8_:
	ld   a, [gamepad_buttons__RAM_C103]
	or   a
	jr   z, _LABEL_2DC8_
	pop  de
	push af
	push de
	ld   a, [_RAM_C232_]
	ld   d, $00
	ld   e, a
	ld   hl, _DATA_1071_
	add  hl, de
	ld   a, [hl]
	pop  de
	ld   [de], a
	pop  af
	bit  0, a
	jr   nz, _LABEL_2DEA_
	ld   hl, $FFFE
	ld   sp, hl
	jp   _LABEL_10C3_

_LABEL_2DEA_:
	call _LABEL_2722_
	di
_LABEL_2DEE_:
	call serial_io__receive_byte_in_A_with_int__2E84
	cp   $53
	jr   nz, _LABEL_2DFB_
	call _LABEL_2E0C_
	jp   _LABEL_0_

_LABEL_2DFB_:
	cp   $52
	jr   nz, _LABEL_2E05_
	call _LABEL_2E2B_
	jp   _LABEL_0_

_LABEL_2E05_:
	xor  a
	call serial_io__send_byte_with_int_receive_byte_in_A__2E74
	jp   _LABEL_2DEE_

_LABEL_2E0C_:
	ld   a, $53
	call serial_io__send_byte_with_int_receive_byte_in_A__2E74
	call _LABEL_2E69_
	call _LABEL_2E69_
	xor  a
	call _LABEL_2E55_
	ld   a, $01
	call _LABEL_2E55_
	ld   a, $02
	call _LABEL_2E55_
	ld   a, $03
	call _LABEL_2E55_
	ret

_LABEL_2E2B_:
	ld   a, $57
	call serial_io__send_byte_with_int_receive_byte_in_A__2E74
	xor  a
	call _LABEL_2E44_
	ld   a, $01
	call _LABEL_2E44_
	ld   a, $02
	call _LABEL_2E44_
	ld   a, $03
	call _LABEL_2E44_
	ret

_LABEL_2E44_:
	call mbc_sram_ON_set_srambank_to_A__2E9B
	ld   de, _SRAM_0_
_LABEL_2E4A_:
	call serial_io__receive_byte_in_A_with_int__2E84
	ld   [de], a
	inc  de
	ld   a, d
	cp   $C0
	jr   nz, _LABEL_2E4A_
	ret

_LABEL_2E55_:
	call mbc_sram_ON_set_srambank_to_A__2E9B
	ld   de, _SRAM_0_
_LABEL_2E5B_:
	ld   a, [de]
	call serial_io__send_byte_with_int_receive_byte_in_A__2E74
	call _LABEL_2E69_
	inc  de
	ld   a, d
	cp   $C0
	jr   nz, _LABEL_2E5B_
	ret

_LABEL_2E69_:
	push bc
	ld   bc, $01FF
_LABEL_2E6D_:
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_2E6D_
	pop  bc
	ret


; Sends byte in A over Serial IO and waits for reply via interrupt
;
; Returns RX byte in A
serial_io__send_byte_with_int_receive_byte_in_A__2E74:
    ; Load serial byte to send from A
    ; Clear all pending interrupts
	ldh  [rSB], a
	xor  a
	ldh  [rIF], a
    ; Enable Serial Interrupt and start a transfer
	ld   a, IEF_SERIAL ; $08
	ldh  [rIE], a
	ld   a, (SERIAL_XFER_ENABLE | SERIAL_CLOCK_INT) ; $81
	ldh  [rSC], a
	jp   serial_io__wait_interrupt__2E92


; Receive a byte over Serial IO and waits via interrupt
;
; Returns RX byte in A
serial_io__receive_byte_in_A_with_int__2E84:
    ; Put 0x00 in outgoing Serial RX
    ; Clear all pending interrupts
	ld   a, $00
	ldh  [rSB], a
	ldh  [rIF], a
    ; Enable Serial Interrupt and wait for a transfer
	ld   a, IEF_SERIAL ; $08
	ldh  [rIE], a
	ld   a, (SERIAL_XFER_ENABLE | SERIAL_CLOCK_EXT) ; $80
	ldh  [rSC], a

    ; Wait for a serial interrupt
    serial_io__wait_interrupt__2E92:
    	ldh  a, [rIF]
    	and  IEF_SERIAL ; $08
    	jr   z, serial_io__wait_interrupt__2E92
    ; Return resulting byte in A
	ldh  a, [rSB]
	ret


; Sets MBC1 SRAM bank:
; - Enable SRAM
; - SRAM Bank = value in reg A
; - Trashes BC
;
; The same as "mbc_sram_ON_set_srambank_to_A__0BB1:"
; except it trashes BC and uses $4000 instead of $5FFF
mbc_sram_ON_set_srambank_to_A__2E9B:
    ; Enable SRAM
    ; Select SRAM Bank switch mode and then
    ; write value in C to SRAM Bank select
	ld   c, a
	ld   a, MBC1_RAM_ON          ; $0A
	ld   [rMBC1_RAM_ENABLE], a   ; [$00FF]

	ld   a, MBC1_MODE_RAMBANKED  ; $01
	ld   [rMBC1_MODE_SEL], a     ; [$7FFF]

	ld   a, c
	ld   [rRAMB], a              ; [$4000]
	ret


; Data from 2EAB to 2F40 (150 bytes)
db $02, $02, $05, $00, $06, $00, $07, $00, $08, $00, $02, $02, $09, $00, $0A, $00
db $0B, $00, $0C, $00, $02, $02, $0D, $00, $0E, $00, $0F, $00, $10, $00, $02, $02
db $11, $00, $12, $00, $11, $80, $13, $00, $02, $02, $14, $00, $15, $00, $16, $00
db $15, $80, $02, $02, $17, $00, $18, $00, $19, $00, $1A, $00, $02, $02, $1B, $00
db $1C, $00, $1D, $00, $1E, $00, $02, $02, $1F, $00, $20, $00, $21, $00, $22, $00
db $02, $02, $23, $00, $24, $00, $25, $00, $26, $00, $02, $02, $27, $00, $28, $00
db $29, $00, $2A, $00, $02, $02, $2B, $00, $2C, $00, $2D, $00, $2E, $00, $02, $02
db $2F, $00, $30, $00, $31, $00, $30, $80, $02, $02, $32, $00, $33, $00, $34, $00
db $33, $80, $02, $02, $35, $00, $36, $00, $37, $00, $38, $00, $02, $02, $39, $00
db $3A, $00, $3B, $00, $3C, $00

_LABEL_2F41_:
	call gfx__turn_off_screen_2827
	ld   a, $07
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, _TILEDATA9000
	ld   bc, _DATA_1D252_
	xor  a ; Copy 256 tiles
	call gfx__copy_tile_patterns__1437
	ld   de, _DATA_1DC62_
	call _LABEL_3969_
	call _LABEL_F68_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
    ; Copies rows of text from RAM to hardware tile map
    ; Source is RAM because it copies there in order to patch the displayed version text
	jp   gfx__title_screen_copy_text_D6D6_

_LABEL_2F64_:
	push af
	push bc
	ldh  a, [rLYC]
	ld   c, a
	ld   a, [_RAM_C399_]
	cp   c
	jr   z, _LABEL_2F7B_
	ld   a, [_RAM_C27D_]
	ld   b, $07
_LABEL_2F74_:
	dec  b
	jr   nz, _LABEL_2F74_
	ldh  [rBGP], a
	jr   _LABEL_2F8B_

_LABEL_2F7B_:
	ld   a, [_RAM_C39A_]
	add  c
	ldh  [rLYC], a
	ld   b, $05
_LABEL_2F83_:
	dec  b
	jr   nz, _LABEL_2F83_
	ld   a, [_RAM_C24F_]
	ldh  [rBGP], a
_LABEL_2F8B_:
	pop  bc
	pop  af
	reti

; 1st entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_2F8E_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	di
	ld   a, $04
	ldh  [rSTAT], a
	ld   a, $01
	ldh  [rIE], a
	ei
	ld   hl, $FFFE
	ld   sp, hl
	call gfx__turn_off_screen_2827
	ld   a, $FF
	ldh  [rOBP0], a
	ld   a, $AA
	ldh  [rOBP1], a
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]

	ld   hl, _TILEDATA8000
	ld   de, _DATA_EECC_
	ld   bc, _DATA_EED4_
	ld   a, 84 ; $54 ; Copy 84 tiles
	call gfx__interleave_copy_tile_patterns__144C
	ld   a, $04
	call _LABEL_3918_
	ld   a, $03
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_F69E_

; Data from 2FCB to 2FE5 (27 bytes)
db $FA, $03, $C1, $B7, $20, $FA, $CF, $FE, $FF, $C2, $00, $02, $FA, $03, $C1, $B7
db $28, $F4, $FA, $03, $C1, $B7, $20, $FA, $C3, $00, $02

_LABEL_2FE6_:
	ld   a, [_RAM_C3A6_]
	dec  a
	ld   [_RAM_C3A6_], a
	jr   nz, _LABEL_2FF7_
	ld   a, $DB
	ld   [_RAM_C3A6_], a
	call _LABEL_2FF7_
_LABEL_2FF7_:
	ld   a, [_RAM_C3A5_]
	dec  a
	ld   [_RAM_C3A5_], a
	ret  nz
	ld   a, $3C
	ld   [_RAM_C3A5_], a
	call _LABEL_303F_
	ld   a, [_RAM_C3A1_]
	inc  a
	cp   $3C
	jr   nz, _LABEL_303B_
	ld   a, $01
	ld   [_RAM_C3A9_], a
	ld   a, [_RAM_C3A2_]
	inc  a
	cp   $3C
	jr   nz, _LABEL_301D_
	xor  a
_LABEL_301D_:
	ld   [_RAM_C3A2_], a
	ld   a, [_RAM_C3A3_]
	dec  a
	ld   [_RAM_C3A3_], a
	jr   nz, _LABEL_303A_
	ld   a, $0C
	ld   [_RAM_C3A3_], a
	ld   a, [_RAM_C3A4_]
	inc  a
	cp   $3C
	jr   nz, _LABEL_3037_
	xor  a
_LABEL_3037_:
	ld   [_RAM_C3A4_], a
_LABEL_303A_:
	xor  a
_LABEL_303B_:
	ld   [_RAM_C3A1_], a
	ret

_LABEL_303F_:
	ld   a, $01
	ld   [_RAM_C3A7_], a
	ld   hl, _RAM_C3A0_
	ld   a, [hl]
	inc  a
	cp   $3A
	jr   z, _LABEL_304F_
	ld   [hl], a
	ret

_LABEL_304F_:
	ld   a, $30
	ldd  [hl], a
	ld   a, [hl]
	inc  a
	cp   $36
	jr   z, _LABEL_305A_
	ld   [hl], a
	ret

_LABEL_305A_:
	ld   a, $30
	ldd  [hl], a
	ld   a, [hl]
	inc  a
	cp   $3A
	jr   z, _LABEL_3065_
	ld   [hl], a
	ret

_LABEL_3065_:
	ld   a, $30
	ldd  [hl], a
	ld   a, [hl]
	inc  a
	cp   $36
	jr   z, _LABEL_3070_
	ld   [hl], a
	ret

_LABEL_3070_:
	ld   a, $30
	ldd  [hl], a
	ld   a, [hl]
	inc  a
	cp   $34
	jr   nz, _LABEL_3090_
	dec  hl
	ld   a, [hl]
	cp   $32
	jr   nz, _LABEL_308C_
	ld   [hl], $30
	inc  hl
	ld   [hl], $30
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_AED1_

_LABEL_308C_:
	inc  hl
	ld   [hl], $34
	ret

_LABEL_3090_:
	cp   $3A
	jr   z, _LABEL_3096_
	ld   [hl], a
	ret

_LABEL_3096_:
	ld   [hl], $30
	dec  hl
	inc  [hl]
	ret

; 11th entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_309B_:
	call _LABEL_30A1_
	jp   vblank__cmd_default__25F7

_LABEL_30A1_:
	ld   de, _RAM_C39B_
	ld   hl, $99E6
	ld   b, $03
_LABEL_30A9_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	inc  hl
	dec  b
	jr   nz, _LABEL_30A9_
	ret

_LABEL_30B8_:
	ld   c, $58
	ld   b, $48
	inc  a
	cp   $11
	jr   c, _LABEL_30D7_
	cp   $1F
	jr   c, _LABEL_30DD_
	cp   $2F
	jr   c, _LABEL_30E7_
	ld   e, a
	ld   a, $3E
	sub  e
	add  $10
	ld   e, a
	ld   a, c
	sub  $1E
	ld   c, a
	jp   _LABEL_F574_

_LABEL_30D7_:
	add  $10
	ld   e, a
	jp   _LABEL_1504_

_LABEL_30DD_:
	ld   e, a
	ld   a, $20
	sub  e
	add  $10
	ld   e, a
	jp   _LABEL_F5D6_

_LABEL_30E7_:
	sub  $1E
	add  $10
	ld   e, a
	ld   a, c
	sub  $1E
	ld   c, a
	jp   _LABEL_F636_

; Data from 30F3 to 3191 (159 bytes)
_DATA_30F3_:
db $0A, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0B, $0C, $11, $12, $13, $14
db $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24
db $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $36, $31, $32, $33
db $34, $35, $0D, $37, $38, $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $80
db $C7, $51, $57, $45, $52, $54, $59, $55, $49, $4F, $50, $24, $41, $53, $44, $46
db $47, $48, $4A, $4B, $4C, $3B, $0D, $0B, $5A, $58, $43, $56, $42, $4E, $4D, $2C
db $2E, $0F, $2F, $0C, $22, $20, $27, $10, $12, $11, $00, $01, $02, $03, $04, $05
db $06, $07, $08, $09, $80, $C7, $31, $32, $33, $72, $74, $79, $75, $21, $7E, $2A
db $23, $34, $35, $36, $2B, $2D, $68, $6A, $28, $29, $3A, $0D, $0B, $37, $38, $39
db $2E, $25, $3D, $7F, $3C, $3E, $0F, $3F, $0C, $30, $20, $40, $10, $12, $11

_LABEL_3192_:
	ld   a, [_RAM_C19B_]
	or   a
	ret  z
	ld   hl, _RAM_C19C_
_LABEL_319A_:
	push af
	push hl
_LABEL_319C_:
	ld   a, [hl]
	inc  a
	jr   nz, _LABEL_31A8_
	pop  hl
	ld   de, $0005
	add  hl, de
	push hl
	jr   _LABEL_319C_

_LABEL_31A8_:
	ld   de, _RAM_C39B_
	ld   b, $04
_LABEL_31AD_:
	ld   a, [de]
	cp   [hl]
	jr   nz, _LABEL_31E0_
	inc  de
	inc  hl
	dec  b
	jr   nz, _LABEL_31AD_
	ld   a, [hl]
	ld   c, a
	pop  hl
	pop  af
	ld   [hl], $FF
	ld   hl, _RAM_C19B_
	dec  [hl]
	ld   a, c
	cp   $01
	jr   nz, _LABEL_31D1_
	ld   a, $3C
	ld   [_RAM_C3AA_], a
	ld   a, $01
	ld   [_RAM_C3AB_], a
	jr   _LABEL_31EA_

_LABEL_31D1_:
	add  $0B
	call _LABEL_376C_
	ld   a, $01
	ld   [_RAM_C3AB_], a
	ld   [_RAM_C3AA_], a
	jr   _LABEL_31EA_

_LABEL_31E0_:
	pop  hl
	ld   de, $0005
	add  hl, de
	pop  af
	dec  a
	jr   nz, _LABEL_319A_
	ret

_LABEL_31EA_:
	ld   a, [vblank__dispatch_select__RAM_C27C]
	push af
	call gfx__clear_shadow_oam__275B
	xor  a
	ld   [_RAM_C398_], a
	ld   a, $1A
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   de, _DATA_617_
	ld   hl, $98A0
	rst  $20	; _LABEL_20_
	ld   de, $00D6
	ld   hl, $98C0
	rst  $20	; _LABEL_20_
	ld   de, $0617
	ld   hl, $98E0
	rst  $20	; _LABEL_20_
	ld   b, $06
_LABEL_3212_:
	push bc
	ld   a, $14
_LABEL_3215_:
	rst  $18	; Call VSYNC__RST_18
	dec  a
	jr   nz, _LABEL_3215_
	ld   de, $2152
	ld   hl, $98C1
	rst  $20	; _LABEL_20_
	ld   a, $14
_LABEL_3222_:
	rst  $18	; Call VSYNC__RST_18
	dec  a
	jr   nz, _LABEL_3222_
	ld   de, $00D6
	ld   hl, $98C0
	rst  $20	; _LABEL_20_
	pop  bc
	dec  b
	jr   nz, _LABEL_3212_
	ld   a, $01
	ld   [_RAM_C398_], a
	ld   a, $1A
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	pop  af
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

_LABEL_3241_:
	xor  a
	ld   [_RAM_C3A9_], a
	call _LABEL_3192_
	ld   a, [_RAM_C59B_]
	or   a
	ret  z
	ld   hl, $C59C
	ld   b, a
_LABEL_3251_:
	push bc
	push hl
	ld   b, $04
	ld   de, _RAM_C39B_
_LABEL_3258_:
	ld   a, [de]
	inc  de
	cp   [hl]
	jr   nz, _LABEL_326E_
	inc  hl
	dec  b
	jr   nz, _LABEL_3258_
	pop  hl
	pop  bc
	ld   a, $3C
	ld   [_RAM_C3AA_], a
	ld   a, $01
	ld   [_RAM_C3AB_], a
	ret

_LABEL_326E_:
	pop  hl
	pop  bc
	inc  hl
	inc  hl
	inc  hl
	inc  hl
	dec  b
	jr   nz, _LABEL_3251_
	ret


; Polls the keyboard for input
; - Resulting key returned in A
; - If no key or error will be WORKBOY_KEY_NONE (0xFF)
serial_io__poll_keyboard__3278:
    ; TODO: Check for something and skip serial keyboard poll request if set
	ld   a, [_RAM_C3A9_]
	or   a
	call nz, _LABEL_3241_
    ; Load keyboard key request and send it
	ld   a, WORKBOY_CMD_READKEY  ; $4F
	call serial_io__send_command_wait_reply_byte__3356
    ; Check returned Key value, return if blank/unset
	cp   WORKBOY_KEY_NONE  ; $FF
	ret  z
    ; Also make sure it's not zero
	or   a
	jr   nz, serial_io__maybe_process_returned_key__328C
	dec  a ; Wraps 0 around to WORKBOY_KEY_NONE/$FF
	ret

    serial_io__maybe_process_returned_key__328C:
    	ld   hl, _DATA_30F3_
    	ld   c, $00
    	ld   b, a
    _LABEL_3292_:
    	ldi  a, [hl]
    	cp   b
    	jr   z, _LABEL_3299_
    	inc  c
    	jr   _LABEL_3292_

    _LABEL_3299_:
    	ld   a, [_RAM_C3AC_]
    	ld   l, a
    	ld   a, [_RAM_C3AD_]
    	ld   h, a
    	ld   b, $00
    	add  hl, bc
    	ld   a, [hl]
    	ld   c, a
    	ld   a, [_RAM_C476_]
    	ld   [_RAM_C477_], a
    	ld   a, c
    	ld   [_RAM_C476_], a
    	or   a
    	ret  z
    	cp   $0A
    	ret  nc
    	push af
    	call _LABEL_380D_
    	pop  af
    	cp   $09
    	jr   nz, _LABEL_32C7_
    	push af
    	ld   a, [_RAM_C19A_]
    	or   a
    	jr   z, _LABEL_32C8_
    	pop  af
    	ret

    _LABEL_32C7_:
    	push af
    _LABEL_32C8_:
    	xor  a
    	ld   [_RAM_C19A_], a
    	ld   [_RAM_C23F_], a
    	ld   a, [_RAM_C10F_]
    	or   a
    	jr   z, _LABEL_32D7_
    	pop  af
    	ret

    _LABEL_32D7_:
    	ld   a, $01
    	ld   [_RAM_C110_], a
    	ld   a, [_RAM_C117_]
    	or   a
    	call nz, _LABEL_E67B_
    	pop  af
    	ld   c, a
    	xor  a
    	ld   [_RAM_C117_], a
    	ld   [_RAM_C260_], a
    	ld   [_RAM_C5F3_], a
    	ld   [vblank__dispatch_select__RAM_C27C], a
    	ld   [gfx__shadow_y_scroll__RAM_C102], a
    	di
    	ld   a, $04
    	ldh  [rSTAT], a
    	ld   a, $01
    	ldh  [rIE], a
    	ei
    	ld   hl, $FFFE
    	ld   sp, hl
    	ld   a, $1B
    	ldh  [rBGP], a
    	ld   [_RAM_C27D_], a
    	ld   a, $D2
    	ldh  [rOBP0], a
    	ld   a, c
    	ld   hl, _DATA_399_ - 1
    	add  l
    	ld   l, a
    	ld   a, h
    	adc  $00
    	ld   h, a
    	ld   a, [hl]
    	jr   _LABEL_331B_

    _LABEL_331B_:
    	push af
    	ld   b, $00
    _LABEL_331E_:
    	cp   $03
    	jr   c, _LABEL_3327_
    	sub  $03
    	inc  b
    	jr   _LABEL_331E_

    _LABEL_3327_:
    	ld   [main_menu__icon_cur_column__C111], a
    	ld   a, b
    	ld   [main_menu__icon_cur_row__C112], a
    	call gfx__clear_shadow_oam__275B
    	pop  af
    	cp   $09
    	jp   z, _LABEL_3BA_
    	cp   $04
    	jp   z, _LABEL_15BE_
    	add  a
    	ld   hl, _DATA_3A2_
    	add  l
    	ld   l, a
    	ld   a, h
    	adc  $00
    	ld   h, a
    	ldi  a, [hl]
    	ld   h, [hl]
    	ld   l, a
    	jp   hl


; Delay approx: ~2.94 msec, ~27 scanlines
; (1000 msec / 59.7275 GB FPS) * (12344 T-States delay / 70224 T-States per frame)
delay_2_94msec__334A:
	push bc
	ld   bc, $03FF
    .delay_loop__334E:
    	dec  c
    	jr   nz, .delay_loop__334E
    	dec  b
    	jr   nz, .delay_loop__334E
	pop  bc
	ret


; Polls the keyboard for input
; - Resulting key returned in A
; - If no key or error will be WORKBOY_KEY_NONE (0xFF) or null value 0x00
serial_io__send_command_wait_reply_byte__3356:
	push bc
	ld   c, a
    ; TODO: Check for something and skip serial keyboard poll request if NOT set
	ld   a, [_RAM_C10A_]
	or   a
	jr   nz, .send_command_and_wait_reply__3361
	dec  a
	pop  bc
	ret

    ; C: Serial command byte to send is in C
    .send_command_and_wait_reply__3361:
        ; Send the serial command and wait for response
    	ld   a, c
    	ldh  [rSB], a
    	ld   a, (SERIAL_XFER_ENABLE | SERIAL_CLOCK_INT) ; $81
    	ldh  [rSC], a
    	call delay_2_94msec__334A
        ; Load serial reply
    	ldh  a, [rSB]
    	pop  bc
    	push af
        ; Turn off serial IO
    	ld   a, ( SERIAL_XFER_OFF ) ; $00
    	ldh  [rSC], a

        ; Check returned serial byte, return if zero
        ; also return if blank/unset (0xFF)
    	pop  af
    	or   a
    	ret  z
    	cp   WORKBOY_KEY_NONE  ;  $FF
    	ret  z

    	push af
    	ld   a, [_RAM_C110_]  ; TODO: What is this testing after a serial transfer? set to 4 on initial startup, then 1 on startup, and later 0 or 1 occasionally
    	or   a
    	jr   z, .return_serial_reply_byte_in_A__3388
    	ld   a, $24
    	ld   bc, $0211
    	call _LABEL_33FC_

    .return_serial_reply_byte_in_A__3388:
    	pop  af
    	ret


; 2nd entry of Jump Table from 3A2 (indexed by main_menu__icon_cur_column__C111)
_LABEL_338A_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call gfx__clear_shadow_oam__275B
	call _LABEL_2B_
	ld   a, $02
	call _LABEL_3918_
	ld   bc, $5830
	call _LABEL_2044_
	ld   a, [_RAM_C10A_]
	or   a
	jr   z, _LABEL_33A9_
	ld   a, $FF
	ldh  [rOBP0], a
_LABEL_33A9_:
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	jp   _LABEL_B9F0_

; Data from 33B1 to 33C8 (24 bytes)
db $00, $01, $FF, $63, $00, $03, $01, $63, $88, $88, $FF, $FF, $00, $00, $44, $44
db $88, $88, $FF, $FF, $00, $00, $44, $44

; Pointer Table from 33C9 to 33D6 (7 entries, indexed by _RAM_C3DD_)
_DATA_33C9_:
dw _DATA_33D7_, _DATA_33DC_, _DATA_33E1_, _DATA_33E7_, _DATA_33EC_, _DATA_33F2_, _DATA_33F7_

; 1st entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33D7 to 33DB (5 bytes)
_DATA_33D7_:
db $01, $40, $F0, $B1, $33

; 2nd entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33DC to 33E0 (5 bytes)
_DATA_33DC_:
db $01, $40, $F0, $76, $0B

; 3rd entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33E1 to 33E6 (6 bytes)
_DATA_33E1_:
db $03, $20, $B5, $33, $B9, $33

; 4th entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33E7 to 33EB (5 bytes)
_DATA_33E7_:
db $02, $80, $F0, $B1, $33

; 5th entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33EC to 33F1 (6 bytes)
_DATA_33EC_:
db $03, $20, $76, $0B, $B9, $33

; 6th entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33F2 to 33F6 (5 bytes)
_DATA_33F2_:
db $01, $40, $F0, $95, $0B

; 7th entry of Pointer Table from 33C9 (indexed by _RAM_C3DD_)
; Data from 33F7 to 33FB (5 bytes)
_DATA_33F7_:
db $02, $80, $F0, $95, $0B

_LABEL_33FC_:
	push af
	ld   a, c
	ld   [_RAM_C3D2_], a
	pop  af
	cp   $D0
	jr   nz, _LABEL_340B_
	ld   a, $FF
	ld   de, $0000
_LABEL_340B_:
	cp   $FF
	jr   z, _LABEL_341A_
	add  a
	ld   h, $00
	ld   l, a
	ld   de, _DATA_382D_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
_LABEL_341A_:
	ld   a, e
	ld   [_RAM_C3D3_], a
	ld   a, d
	and  $07
	ld   [_RAM_C3D4_], a
	ld   a, $FF
	ldh  [rAUDVOL], a
	ld   h, $00
	ld   l, b
	add  hl, hl
	ld   de, _DATA_33C9_
	add  hl, de
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	ldi  a, [hl]
	cp   $02
	jp   z, _LABEL_349C_
	jr   c, _LABEL_3443_
	cp   $04
	jp   z, _LABEL_3556_
	jp   _LABEL_34F3_

_LABEL_3443_:
	ld   a, [_RAM_C3D5_]
	ld   [_RAM_C3BB_], a
	xor  a
	ld   [_RAM_C3B2_], a
	ld   a, [_RAM_C3D6_]
	or   a
	ret  z
	ldi  a, [hl]
	ldh  [rAUD1LEN], a
	ldi  a, [hl]
	ldh  [rAUD1ENV], a
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3B5_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3B6_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3B7_], a
	ld   [_RAM_C3B8_], a
	ld   a, c
	ld   [_RAM_C3B3_], a
	ld   a, b
	ld   [_RAM_C3B4_], a
	xor  a
	ldh  [rAUD1SWEEP], a
	ld   a, [_RAM_C3D3_]
	ldh  [rAUD1LOW], a
	ld   [_RAM_C3B9_], a
	ld   a, [_RAM_C3D2_]
	ld   c, a
	ldh  a, [rAUDTERM]
	and  $EE
	or   c
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	or   $81
	ldh  [rAUDENA], a
	ld   a, [_RAM_C3D4_]
	ld   [_RAM_C3BA_], a
	or   $80
	ldh  [rAUD1HIGH], a
	ret

_LABEL_349C_:
	ld   a, [_RAM_C3D5_]
	ld   [_RAM_C3C5_], a
	xor  a
	ld   [_RAM_C3BC_], a
	ld   a, [_RAM_C3D7_]
	or   a
	ret  z
	ldi  a, [hl]
	ldh  [rAUD2LEN], a
	ldi  a, [hl]
	ldh  [rAUD2ENV], a
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3BF_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3C0_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3C1_], a
	ld   [_RAM_C3C2_], a
	ld   a, c
	ld   [_RAM_C3BD_], a
	ld   a, b
	ld   [_RAM_C3BE_], a
	ld   a, [_RAM_C3D3_]
	ldh  [rAUD2LOW], a
	ld   [_RAM_C3C3_], a
	ld   a, [_RAM_C3D2_]
	add  a
	ld   c, a
	ldh  a, [rAUDTERM]
	and  $DD
	or   c
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	or   $82
	ldh  [rAUDENA], a
	ld   a, [_RAM_C3D4_]
	ld   [_RAM_C3C4_], a
	or   $80
	ldh  [rAUD2HIGH], a
	ret

_LABEL_34F3_:
	ld   a, [_RAM_C3D5_]
	ld   [_RAM_C3CF_], a
	ldi  a, [hl]
	ldh  [rAUD3LEVEL], a
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	inc  hl
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	push bc
	ld   bc, $1000 | LOW(_AUD3WAVERAM)
_LABEL_3507_:
	ldi  a, [hl]
	ldh  [c], a
	inc  c
	dec  b
	jr   nz, _LABEL_3507_
	pop  bc
	xor  a
	ld   [_RAM_C3C6_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3C9_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3CA_], a
	ld   a, [bc]
	inc  bc
	ld   [_RAM_C3CB_], a
	ld   [_RAM_C3CC_], a
	ld   a, c
	ld   [_RAM_C3C7_], a
	ld   a, b
	ld   [_RAM_C3C8_], a
	ld   a, $80
	ldh  [rAUD3ENA], a
	ld   a, [_RAM_C3D3_]
	ld   [_RAM_C3CD_], a
	ldh  [rAUD3LOW], a
	ld   a, [_RAM_C3D2_]
	add  a
	add  a
	ld   c, a
	ldh  a, [rAUDTERM]
	and  $BB
	or   c
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	or   $84
	ldh  [rAUDENA], a
	ld   a, [_RAM_C3D4_]
	ld   [_RAM_C3CE_], a
	or   $80
	ldh  [rAUD3HIGH], a
	ret

_LABEL_3556_:
	ld   a, [_RAM_C3D5_]
	ld   [_RAM_C3D1_], a
	ldi  a, [hl]
	ldh  [rAUD4ENV], a
	ldi  a, [hl]
	ldh  [rAUD4POLY], a
	ld   a, [_RAM_C3D2_]
	add  a
	add  a
	add  a
	ld   c, a
	ldh  a, [rAUDTERM]
	and  $77
	or   c
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	or   $88
	ldh  [rAUDENA], a
	ld   a, $80
	ldh  [rAUD4GO], a
	ld   [_RAM_C3D0_], a
	ret

_LABEL_357E_:
	ld   a, [_RAM_C3B2_]
	inc  a
	jp   z, _LABEL_3626_
	ld   a, [_RAM_C3BB_]
	dec  a
	ld   [_RAM_C3BB_], a
	jp   z, _LABEL_3615_
	ld   a, [_RAM_C3D6_]
	or   a
	jr   nz, _LABEL_35A4_
	ldh  a, [rAUDTERM]
	and  $EE
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $FE
	ldh  [rAUDENA], a
	jp   _LABEL_3626_

_LABEL_35A4_:
	ld   a, [_RAM_C3B8_]
	dec  a
	jr   z, _LABEL_35AF_
	ld   [_RAM_C3B8_], a
	jr   _LABEL_3626_

_LABEL_35AF_:
	ld   a, [_RAM_C3B7_]
	ld   [_RAM_C3B8_], a
	ld   a, [_RAM_C3B5_]
	ld   c, a
	bit  7, a
	jr   z, _LABEL_35D2_
	ld   a, [_RAM_C3B9_]
	add  c
	ld   [_RAM_C3B9_], a
	ldh  [rAUD1LOW], a
	ld   a, [_RAM_C3BA_]
	sbc  $FF
	ld   [_RAM_C3BA_], a
	ldh  [rAUD1HIGH], a
	jr   _LABEL_35E5_

_LABEL_35D2_:
	ld   a, [_RAM_C3B9_]
	add  c
	ld   [_RAM_C3B9_], a
	ldh  [rAUD1LOW], a
	ld   a, [_RAM_C3BA_]
	adc  $00
	ld   [_RAM_C3BA_], a
	ldh  [rAUD1HIGH], a
_LABEL_35E5_:
	ld   a, [_RAM_C3B6_]
	dec  a
	jr   z, _LABEL_35F0_
	ld   [_RAM_C3B6_], a
	jr   _LABEL_3626_

_LABEL_35F0_:
	ld   a, [_RAM_C3B3_]
	ld   l, a
	ld   a, [_RAM_C3B4_]
	ld   h, a
	ldi  a, [hl]
	cp   $63
	jr   z, _LABEL_3615_
	ld   [_RAM_C3B5_], a
	ldi  a, [hl]
	ld   [_RAM_C3B6_], a
	ldi  a, [hl]
	ld   [_RAM_C3B7_], a
	ld   [_RAM_C3B8_], a
	ld   a, l
	ld   [_RAM_C3B3_], a
	ld   a, h
	ld   [_RAM_C3B4_], a
	jr   _LABEL_3626_

_LABEL_3615_:
	ldh  a, [rAUDTERM]
	and  $EE
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $FE
	ldh  [rAUDENA], a
	ld   a, $FF
	ld   [_RAM_C3B2_], a
_LABEL_3626_:
	ld   a, [_RAM_C3BC_]
	inc  a
	jp   z, _LABEL_36C2_
	ld   a, [_RAM_C3C5_]
	dec  a
	ld   [_RAM_C3C5_], a
	jp   z, _LABEL_36B1_
	ld   a, [_RAM_C3D7_]
	or   a
	jr   nz, _LABEL_3640_
	jp   _LABEL_36C2_

_LABEL_3640_:
	ld   a, [_RAM_C3C2_]
	dec  a
	jr   z, _LABEL_364B_
	ld   [_RAM_C3C2_], a
	jr   _LABEL_36C2_

_LABEL_364B_:
	ld   a, [_RAM_C3C1_]
	ld   [_RAM_C3C2_], a
	ld   a, [_RAM_C3BF_]
	ld   c, a
	bit  7, a
	jr   z, _LABEL_366E_
	ld   a, [_RAM_C3C3_]
	add  c
	ld   [_RAM_C3C3_], a
	ldh  [rAUD2LOW], a
	ld   a, [_RAM_C3C4_]
	sbc  $FF
	ld   [_RAM_C3C4_], a
	ldh  [rAUD2HIGH], a
	jr   _LABEL_3681_

_LABEL_366E_:
	ld   a, [_RAM_C3C3_]
	add  c
	ld   [_RAM_C3C3_], a
	ldh  [rAUD2LOW], a
	ld   a, [_RAM_C3C4_]
	adc  $00
	ld   [_RAM_C3C4_], a
	ldh  [rAUD2HIGH], a
_LABEL_3681_:
	ld   a, [_RAM_C3C0_]
	dec  a
	jr   z, _LABEL_368C_
	ld   [_RAM_C3C0_], a
	jr   _LABEL_36C2_

_LABEL_368C_:
	ld   a, [_RAM_C3BD_]
	ld   l, a
	ld   a, [_RAM_C3BE_]
	ld   h, a
	ldi  a, [hl]
	cp   $63
	jr   z, _LABEL_36B1_
	ld   [_RAM_C3BF_], a
	ldi  a, [hl]
	ld   [_RAM_C3C0_], a
	ldi  a, [hl]
	ld   [_RAM_C3C1_], a
	ld   [_RAM_C3C2_], a
	ld   a, l
	ld   [_RAM_C3BD_], a
	ld   a, h
	ld   [_RAM_C3BE_], a
	jr   _LABEL_36C2_

_LABEL_36B1_:
	ldh  a, [rAUDTERM]
	and  $DD
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $FD
	ldh  [rAUDENA], a
	ld   a, $FF
	ld   [_RAM_C3BC_], a
_LABEL_36C2_:
	ld   a, [_RAM_C3CC_]
	dec  a
	jr   z, _LABEL_36CE_
	ld   [_RAM_C3CC_], a
	jp   _LABEL_374E_

_LABEL_36CE_:
	ld   a, [_RAM_C3CF_]
	dec  a
	ld   [_RAM_C3CF_], a
	jr   z, _LABEL_373D_
	ld   a, [_RAM_C3CB_]
	ld   [_RAM_C3CC_], a
	ld   a, [_RAM_C3C9_]
	ld   c, a
	bit  7, a
	jr   z, _LABEL_36FA_
	ld   a, [_RAM_C3CD_]
	add  c
	ld   [_RAM_C3CD_], a
	ldh  [rAUD3LOW], a
	ld   a, [_RAM_C3CE_]
	sbc  $FF
	ld   [_RAM_C3CE_], a
	ldh  [rAUD3HIGH], a
	jr   _LABEL_370D_

_LABEL_36FA_:
	ld   a, [_RAM_C3CD_]
	add  c
	ld   [_RAM_C3CD_], a
	ldh  [rAUD3LOW], a
	ld   a, [_RAM_C3CE_]
	adc  $00
	ld   [_RAM_C3CE_], a
	ldh  [rAUD3HIGH], a
_LABEL_370D_:
	ld   a, [_RAM_C3CA_]
	dec  a
	jr   z, _LABEL_3718_
	ld   [_RAM_C3CA_], a
	jr   _LABEL_374E_

_LABEL_3718_:
	ld   a, [_RAM_C3C7_]
	ld   l, a
	ld   a, [_RAM_C3C8_]
	ld   h, a
	ldi  a, [hl]
	cp   $63
	jr   z, _LABEL_373D_
	ld   [_RAM_C3C9_], a
	ldi  a, [hl]
	ld   [_RAM_C3CA_], a
	ldi  a, [hl]
	ld   [_RAM_C3CB_], a
	ld   [_RAM_C3CC_], a
	ld   a, l
	ld   [_RAM_C3C7_], a
	ld   a, h
	ld   [_RAM_C3C8_], a
	jr   _LABEL_374E_

_LABEL_373D_:
	ldh  a, [rAUDTERM]
	and  $BB
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $FB
	ldh  [rAUDENA], a
	ld   a, $FF
	ld   [_RAM_C3C6_], a
_LABEL_374E_:
	ld   a, [_RAM_C3D0_]
	inc  a
	ret  z
	ld   a, [_RAM_C3D1_]
	dec  a
	ld   [_RAM_C3D1_], a
	ret  nz
	dec  a
	ld   [_RAM_C3D0_], a
	ldh  a, [rAUDTERM]
	and  $77
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $F7
	ldh  [rAUDENA], a
	ret

_LABEL_376C_:
	ld   [_RAM_C3DE_], a
	push af
	call _LABEL_380D_
	xor  a
	ld   [_RAM_C3DC_], a
	ld   a, $03
	ld   [_RAM_C3DD_], a
	pop  af
	add  a
	add  a
	ld   e, a
	ld   d, $00
	ld   hl, _DATA_388D_
	add  hl, de
	ldi  a, [hl]
	ld   [_RAM_C3DA_], a
	ldi  a, [hl]
	ld   [_RAM_C3DB_], a
	ldi  a, [hl]
	ld   [_RAM_C3D8_], a
	ldi  a, [hl]
	ld   [_RAM_C3D9_], a
	ld   a, $01
	ld   [_RAM_C3DF_], a
	ret

_LABEL_379C_:
	ld   a, [_RAM_C3B2_]
	inc  a
	jr   nz, _LABEL_37D4_
	ld   a, [_RAM_C3D8_]
	ld   l, a
	ld   a, [_RAM_C3D9_]
	ld   h, a
_LABEL_37AA_:
	ldi  a, [hl]
	cp   $FF
	jp   z, _LABEL_380D_
	cp   $F0
	jr   c, _LABEL_37B8_
	and  $0F
	jr   _LABEL_37AA_

_LABEL_37B8_:
	ld   [_RAM_C3D6_], a
	sub  $30
	ld   c, a
	ldi  a, [hl]
	ld   [_RAM_C3D5_], a
	ld   a, l
	ld   [_RAM_C3D8_], a
	ld   a, h
	ld   [_RAM_C3D9_], a
	ld   a, [_RAM_C3DC_]
	ld   b, a
	ld   a, c
	ld   c, $11
	call _LABEL_33FC_
_LABEL_37D4_:
	ld   a, [_RAM_C3BC_]
	inc  a
	jr   nz, _LABEL_380C_
	ld   a, [_RAM_C3DA_]
	ld   l, a
	ld   a, [_RAM_C3DB_]
	ld   h, a
_LABEL_37E2_:
	ldi  a, [hl]
	cp   $FF
	jp   z, _LABEL_380D_
	cp   $F0
	jr   c, _LABEL_37F0_
	and  $0F
	jr   _LABEL_37E2_

_LABEL_37F0_:
	ld   [_RAM_C3D7_], a
	sub  $30
	ld   c, a
	ldi  a, [hl]
	ld   [_RAM_C3D5_], a
	ld   a, l
	ld   [_RAM_C3DA_], a
	ld   a, h
	ld   [_RAM_C3DB_], a
	ld   a, [_RAM_C3DD_]
	ld   b, a
	ld   a, c
	ld   c, $11
	call _LABEL_33FC_
_LABEL_380C_:
	ret

_LABEL_380D_:
	ld   a, $FF
	ld   [_RAM_C3DE_], a
	ldh  a, [rAUDTERM]
	xor  a
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $FE
	ldh  [rAUDENA], a
	ldh  a, [rAUDTERM]
	xor  a
	ldh  [rAUDTERM], a
	ldh  a, [rAUDENA]
	and  $FD
	ldh  [rAUDENA], a
	xor  a
	ld   [_RAM_C3DF_], a
	ret

; Data from 382D to 388C (96 bytes)
_DATA_382D_:
db $2C, $00, $9D, $00, $07, $01, $6B, $01, $CA, $01, $23, $02, $77, $02, $C7, $02
db $12, $03, $59, $03, $9B, $03, $DA, $03, $16, $04, $4E, $04, $83, $04, $B6, $04
db $E5, $04, $11, $05, $3C, $05, $63, $05, $89, $05, $AC, $05, $CF, $05, $ED, $05
db $0B, $06, $27, $06, $42, $06, $5B, $06, $72, $06, $89, $06, $9E, $06, $B1, $06
db $C4, $06, $D6, $06, $E7, $06, $F6, $06, $05, $07, $14, $07, $21, $07, $2D, $07
db $39, $07, $44, $07, $4F, $07, $59, $07, $62, $07, $6B, $07, $73, $07, $7B, $07

; Pointer Table from 388D to 388E (1 entries, indexed by _RAM_C19D_)
_DATA_388D_:
dw _DATA_398E_

; Pointer Table from 388F to 38CC (31 entries, indexed by _RAM_C19D_)
dw _DATA_39B5_, _DATA_39E8_, _DATA_3A0D_, _DATA_3A3A_, _DATA_3A82_, _DATA_3AE1_, _DATA_3B00_, _DATA_3B2B_
dw _DATA_3B50_, _DATA_3B75_, _DATA_3B98_, _DATA_3BBB_, _DATA_3BFE_, _DATA_3C51_, _DATA_3C76_, _DATA_3CA3_
dw _DATA_3CC0_, _DATA_3CF7_, _DATA_3D14_, _DATA_3D43_, _DATA_3D5C_, _DATA_3D7F_, _DATA_3DAC_, _DATA_3DDD_
dw _DATA_3E02_, _DATA_3E3B_, _DATA_3E6A_, _DATA_3E99_, _DATA_3F3E_, _DATA_861E_, _DATA_86C8_

; Data from 38CD to 3917 (75 bytes)
db $00, $00, $00, $40, $01, $AF, $5C, $0C, $69, $05, $AF, $5C, $E0, $6C, $01, $17
db $5E, $00, $40, $01, $7F, $5F, $00, $40, $01, $00, $00, $00, $40, $01, $00, $00
db $00, $40, $01, $E7, $60, $A0, $5F, $01, $00, $00, $00, $40, $01, $00, $00, $00
db $50, $01, $BC, $63, $00, $40, $01, $4F, $62, $00, $50, $01, $24, $65, $4C, $5B
db $05, $14, $66, $00, $40, $01, $0C, $74, $00, $40, $01

_LABEL_3918_:
	push af
	push af
	call gfx__turn_off_screen_2827
	pop  af
	ld   e, a
	add  a
	add  a
	add  e
	ld   d, $00
	ld   e, a
	ld   hl, $38CD
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	inc  hl
	ld   a, [hl]
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	pop  af
	push de
	ld   hl, _TILEDATA9000
	cp   $07
	jr   nz, _LABEL_3959_

	ld   a, $3B ; Copy 59 tiles
	ld   bc, gfx__tile_patterns_59_font__5FA0
	ld   hl, _TILEDATA9000
	call gfx__copy_tile_patterns__1437

	ld   a, 153 ; $99 ; Copy 153 tiles
	ld   de, _DATA_6350_
	ld   bc, _DATA_6358_
	ld   hl, $93B0
	call gfx__interleave_copy_tile_patterns__144C
	jr   _LABEL_395D_

_LABEL_3959_:
	xor  a ; Copy 256 tiles
	call gfx__copy_tile_patterns__1437
_LABEL_395D_:
	ld   a, $02
	ld   [rMBC1_ROMBANK], a  ; [$3FFF]
	pop  de
	call _LABEL_3969_
	jp   gfx__turn_on_screen_bg_obj__2540

_LABEL_3969_:
	ld   hl, _TILEMAP0
	ld   b, $12
_LABEL_396E_:
	push bc
	ld   b, $14
_LABEL_3971_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_3971_
	ld   c, $0C
	add  hl, bc
	pop  bc
	dec  b
	jr   nz, _LABEL_396E_
	ret

; Data from 397F to 398D (15 bytes)
db $DF, $FA, $B0, $C3, $B7, $28, $F9, $C9, $FA, $B0, $C3, $B7, $20, $FA, $C9

; 1st entry of Pointer Table from 388D (indexed by _RAM_C19D_)
; Data from 398E to 39B4 (39 bytes)
_DATA_398E_:
db $00, $18, $F0, $3D, $18, $49, $18, $44, $18, $48, $18, $46, $18, $49, $18, $42
db $18, $46, $18, $3D, $18, $44, $18, $3D, $18, $4B, $0C, $49, $0C, $48, $18, $48
db $0C, $48, $0C, $3D, $18, $FF, $01

; 1st entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 39B5 to 39E7 (51 bytes)
_DATA_39B5_:
db $F0, $49, $0C, $4B, $0C, $4D, $18, $4D, $0C, $4D, $0C, $4B, $18, $4B, $18, $49
db $0C, $4B, $0C, $4D, $0C, $49, $0C, $46, $0C, $48, $0C, $49, $18, $44, $18, $49
db $0C, $4D, $0C, $50, $18, $4E, $0C, $4D, $0C, $4B, $18, $4B, $0C, $4B, $0C, $49
db $18, $FF, $01

; 2nd entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 39E8 to 3A0C (37 bytes)
_DATA_39E8_:
db $F0, $40, $30, $3F, $30, $3D, $48, $3B, $18, $40, $18, $42, $18, $44, $18, $45
db $18, $47, $30, $3B, $30, $40, $30, $3F, $30, $44, $48, $42, $18, $40, $30, $42
db $30, $3B, $60, $FF, $01

; 3rd entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3A0D to 3A39 (45 bytes)
_DATA_3A0D_:
db $F0, $50, $30, $53, $24, $53, $0C, $4C, $48, $4E, $18, $50, $18, $51, $18, $53
db $18, $55, $18, $4E, $30, $4E, $30, $50, $30, $52, $24, $52, $0C, $53, $48, $55
db $18, $57, $18, $57, $18, $55, $18, $55, $18, $53, $60, $FF, $01

; 4th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3A3A to 3A81 (72 bytes)
_DATA_3A3A_:
db $F0, $49, $18, $46, $30, $42, $18, $46, $0C, $46, $0C, $49, $24, $49, $0C, $49
db $18, $50, $18, $4E, $30, $4D, $30, $46, $60, $4E, $30, $4D, $30, $49, $24, $49
db $0C, $49, $18, $49, $18, $49, $18, $49, $18, $44, $18, $49, $48, $49, $18, $49
db $18, $49, $0C, $49, $0C, $49, $18, $49, $18, $49, $18, $49, $0C, $49, $0C, $49
db $18, $49, $18, $49, $30, $44, $30, $3D

; 5th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3A82 to 3AE0 (95 bytes)
_DATA_3A82_:
db $F0, $4D, $18, $4E, $18, $42, $18, $46, $18, $49, $0C, $49, $0C, $4E, $24, $50
db $0C, $52, $18, $53, $18, $52, $30, $50, $30, $4E, $48, $52, $18, $52, $0C, $50
db $0C, $4E, $0C, $4D, $0C, $50, $0C, $4E, $0C, $4D, $0C, $4B, $0C, $4D, $24, $4E
db $0C, $50, $18, $55, $18, $50, $18, $4D, $18, $49, $18, $50, $24, $44, $0C, $44
db $18, $55, $18, $55, $18, $54, $0C, $52, $0C, $50, $18, $52, $18, $52, $18, $50
db $0C, $4E, $0C, $4D, $18, $4E, $18, $4D, $30, $4B, $30, $49, $30, $FF, $01

; 6th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3AE1 to 3AFF (31 bytes)
_DATA_3AE1_:
db $00, $30, $F0, $40, $18, $40, $18, $3F, $18, $3F, $18, $40, $28, $40, $08, $40
db $18, $40, $18, $45, $18, $42, $28, $42, $08, $47, $18, $40, $30, $FF, $01

; 7th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3B00 to 3B2A (43 bytes)
_DATA_3B00_:
db $00, $10, $F0, $47, $08, $47, $10, $47, $08, $4C, $18, $4C, $18, $4E, $18, $4E
db $18, $53, $28, $50, $08, $4C, $10, $4C, $08, $50, $10, $4C, $08, $49, $18, $51
db $28, $51, $08, $4E, $10, $4B, $08, $4C, $30, $FF, $01

; 8th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3B2B to 3B4F (37 bytes)
_DATA_3B2B_:
db $F0, $43, $24, $47, $0C, $48, $18, $47, $18, $4A, $18, $48, $18, $47, $0C, $43
db $0C, $43, $18, $4D, $18, $4C, $18, $4A, $18, $48, $18, $47, $18, $48, $0C, $45
db $0C, $43, $30, $FF, $01

; 9th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3B50 to 3B74 (37 bytes)
_DATA_3B50_:
db $F0, $48, $24, $4A, $0C, $4C, $18, $4A, $18, $4D, $18, $4C, $18, $4A, $0C, $47
db $0C, $48, $18, $51, $18, $4F, $18, $4D, $18, $4C, $18, $4A, $18, $4C, $0C, $48
db $0C, $4F, $30, $FF, $01

; 10th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3B75 to 3B97 (35 bytes)
_DATA_3B75_:
db $F0, $45, $18, $45, $10, $45, $08, $45, $30, $4D, $18, $4D, $10, $4D, $08, $4D
db $30, $4D, $18, $4D, $10, $4D, $08, $4D, $30, $48, $18, $48, $10, $48, $08, $45
db $30, $FF, $01

; 11th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3B98 to 3BBA (35 bytes)
_DATA_3B98_:
db $F0, $48, $18, $48, $10, $4A, $08, $48, $30, $51, $18, $51, $10, $52, $08, $51
db $30, $51, $18, $54, $10, $52, $08, $51, $30, $4F, $18, $51, $10, $4F, $08, $4D
db $30, $FF, $01

; 12th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3BBB to 3BFD (67 bytes)
_DATA_3BBB_:
db $00, $80, $00, $40, $F0, $41, $18, $45, $18, $46, $30, $47, $18, $48, $30, $45
db $18, $41, $18, $45, $18, $3E, $30, $43, $18, $41, $18, $43, $30, $41, $18, $45
db $18, $46, $18, $45, $18, $41, $24, $45, $0C, $3C, $30, $46, $18, $46, $18, $46
db $30, $3E, $18, $3E, $18, $3E, $18, $3C, $18, $3E, $18, $3C, $0C, $39, $0C, $37
db $30, $FF, $01

; 13th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3BFE to 3C50 (83 bytes)
_DATA_3BFE_:
db $F0, $45, $18, $43, $18, $45, $18, $48, $18, $4A, $18, $45, $18, $43, $30, $45
db $18, $48, $18, $4A, $18, $48, $0C, $4A, $0C, $4F, $18, $4C, $18, $4A, $18, $48
db $18, $45, $18, $48, $18, $4A, $30, $4F, $18, $4D, $18, $4F, $30, $45, $18, $48
db $18, $4A, $18, $48, $18, $45, $24, $48, $0C, $43, $30, $4A, $18, $4D, $18, $4F
db $30, $4D, $18, $4F, $18, $4A, $18, $48, $18, $4A, $18, $48, $0C, $45, $0C, $43
db $30, $FF, $01

; 14th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3C51 to 3C75 (37 bytes)
_DATA_3C51_:
db $00, $18, $F0, $42, $18, $3D, $18, $42, $18, $46, $08, $46, $08, $46, $08, $42
db $18, $3D, $18, $42, $18, $3D, $18, $3D, $18, $38, $18, $3D, $18, $46, $10, $46
db $08, $42, $48, $FF, $01

; 15th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3C76 to 3CA2 (45 bytes)
_DATA_3C76_:
db $F0, $42, $10, $46, $08, $49, $18, $49, $18, $49, $18, $49, $08, $4B, $08, $4D
db $08, $4E, $18, $4E, $18, $49, $18, $46, $10, $46, $08, $44, $18, $46, $18, $47
db $18, $49, $10, $49, $08, $46, $10, $44, $08, $42, $30, $FF, $01

; 16th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3CA3 to 3CBF (29 bytes)
_DATA_3CA3_:
db $00, $80, $00, $28, $F0, $45, $18, $3E, $24, $40, $0C, $42, $18, $45, $18, $43
db $80, $00, $A0, $47, $30, $48, $18, $4A, $18, $43, $60, $FF, $01

; 17th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3CC0 to 3CF6 (55 bytes)
_DATA_3CC0_:
db $F0, $4A, $24, $48, $0C, $47, $18, $45, $18, $43, $18, $45, $18, $47, $18, $48
db $18, $4A, $24, $4C, $0C, $4A, $18, $48, $18, $47, $60, $4C, $24, $4A, $0C, $48
db $18, $47, $18, $45, $18, $47, $18, $48, $18, $4A, $18, $4A, $24, $4C, $0C, $4C
db $18, $4E, $18, $4F, $60, $FF, $01

; 18th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3CF7 to 3D13 (29 bytes)
_DATA_3CF7_:
db $F0, $41, $18, $41, $18, $41, $30, $41, $18, $45, $18, $48, $30, $41, $18, $40
db $18, $3E, $18, $4A, $18, $3A, $18, $46, $18, $3C, $30, $FF, $01

; 19th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3D14 to 3D42 (47 bytes)
_DATA_3D14_:
db $F0, $4D, $18, $48, $18, $51, $18, $4D, $0C, $54, $0C, $52, $0C, $51, $0C, $4F
db $0C, $4D, $0C, $4D, $0C, $4C, $0C, $4A, $0C, $48, $0C, $4D, $18, $4F, $18, $51
db $24, $54, $0C, $52, $0C, $51, $0C, $4F, $0C, $4D, $0C, $54, $30, $FF, $01

; 20th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3D43 to 3D5B (25 bytes)
_DATA_3D43_:
db $00, $30, $F0, $4B, $18, $47, $30, $4B, $48, $4E, $18, $4C, $30, $49, $18, $45
db $18, $47, $18, $42, $18, $40, $48, $FF, $01

; 21st entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3D5C to 3D7E (35 bytes)
_DATA_3D5C_:
db $F0, $4C, $18, $4C, $18, $4E, $18, $4B, $24, $4C, $0C, $4E, $18, $50, $18, $50
db $18, $51, $18, $50, $24, $4E, $0C, $4C, $18, $4E, $18, $4C, $18, $4B, $18, $4C
db $48, $FF, $01

; 22nd entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3D7F to 3DAB (45 bytes)
_DATA_3D7F_:
db $00, $18, $F0, $3A, $18, $46, $18, $45, $18, $43, $30, $4D, $10, $4B, $08, $4A
db $18, $46, $18, $48, $18, $45, $48, $46, $24, $4D, $0C, $4A, $18, $48, $30, $46
db $0C, $48, $0C, $4A, $18, $46, $18, $48, $18, $45, $30, $FF, $01

; 23rd entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3DAC to 3DDC (49 bytes)
_DATA_3DAC_:
db $F0, $4D, $10, $4A, $08, $46, $18, $4A, $18, $4D, $18, $52, $30, $56, $10, $54
db $08, $52, $18, $4A, $18, $4C, $18, $4D, $30, $4D, $18, $56, $24, $54, $0C, $52
db $18, $51, $30, $4F, $0C, $51, $0C, $52, $18, $4A, $18, $4C, $18, $4D, $30, $FF
db $01

; 24th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3DDD to 3E01 (37 bytes)
_DATA_3DDD_:
db $00, $80, $00, $40, $F0, $45, $24, $45, $0C, $48, $0C, $48, $0C, $48, $18, $46
db $30, $46, $24, $46, $0C, $48, $24, $48, $0C, $48, $0C, $46, $0C, $45, $12, $43
db $06, $41, $60, $FF, $01

; 25th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3E02 to 3E3A (57 bytes)
_DATA_3E02_:
db $F0, $4D, $24, $48, $0C, $4D, $0C, $48, $0C, $4D, $0C, $51, $0C, $54, $18, $52
db $18, $51, $18, $4F, $0C, $48, $0C, $4D, $24, $4C, $0C, $4F, $0C, $4D, $0C, $48
db $0C, $45, $0C, $4A, $30, $41, $24, $4D, $0C, $4F, $24, $4D, $0C, $4C, $0C, $4A
db $0C, $48, $12, $46, $06, $45, $60, $FF, $01

; 26th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3E3B to 3E69 (47 bytes)
_DATA_3E3B_:
db $F0, $54, $24, $4F, $24, $58, $18, $56, $48, $4F, $18, $56, $24, $4F, $24, $59
db $18, $58, $48, $54, $18, $60, $24, $5B, $24, $58, $18, $5D, $24, $59, $24, $56
db $18, $59, $24, $56, $24, $53, $18, $54, $30, $54, $18, $4C, $18, $FF, $01

; 27th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3E6A to 3E98 (47 bytes)
_DATA_3E6A_:
db $F0, $3C, $18, $48, $0C, $3C, $0C, $4C, $0C, $3C, $0C, $4F, $0C, $4C, $0C, $37
db $18, $43, $0C, $37, $0C, $47, $0C, $37, $0C, $4A, $0C, $47, $0C, $37, $18, $43
db $0C, $37, $0C, $47, $0C, $37, $0C, $4A, $0C, $47, $0C, $3C, $18, $48, $0C

; 28th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3E99 to 3F3D (165 bytes)
_DATA_3E99_:
db $00, $18, $F0, $3C, $0C, $48, $0C, $4C, $0C, $4F, $0C, $54, $0C, $4F, $0C, $35
db $0C, $41, $0C, $45, $0C, $48, $0C, $4D, $0C, $48, $0C, $3E, $0C, $4A, $0C, $4D
db $0C, $51, $0C, $56, $0C, $51, $0C, $37, $0C, $43, $0C, $47, $0C, $4A, $0C, $4F
db $0C, $4A, $0C, $40, $0C, $4C, $0C, $4F, $0C, $53, $0C, $58, $0C, $53, $0C, $39
db $0C, $45, $0C, $48, $0C, $4C, $0C, $4C, $0C, $4C, $0C, $4D, $18, $53, $18, $4F
db $18, $3C, $48, $3C, $0C, $48, $0C, $4C, $0C, $4F, $0C, $54, $0C, $4F, $0C, $37
db $0C, $43, $0C, $47, $0C, $4A, $0C, $4F, $0C, $4A, $0C, $3C, $0C, $48, $0C, $4C
db $0C, $4F, $0C, $54, $0C, $4F, $0C, $37, $0C, $43, $0C, $47, $0C, $4A, $0C, $4F
db $0C, $4A, $0C, $3C, $0C, $48, $0C, $4C, $0C, $4F, $0C, $54, $0C, $4F, $0C, $37
db $0C, $43, $0C, $47, $0C, $4A, $0C, $4C, $0C, $4C, $0C, $4D, $18, $53, $18, $4F
db $18, $3C, $30, $FF, $01

; 29th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 3F3E to 3FFF (194 bytes)
_DATA_3F3E_:
db $F0, $4F, $18, $54, $18, $54, $0C, $56, $0C, $54, $0C, $53, $0C, $51, $18, $4D
db $18, $4D, $18, $56, $18, $56, $0C, $58, $0C, $56, $0C, $54, $0C, $53, $18, $4F
db $18, $4F, $18, $58, $18, $58, $0C, $59, $0C, $58, $0C, $56, $0C, $54, $18, $51
db $18, $4F, $0C, $4F, $0C, $51, $18, $56, $18, $53, $18, $54, $30, $4F, $18, $54
db $18, $54, $18, $54, $18, $53, $30, $53, $18, $54, $18, $53, $18, $51, $18, $4F
db $30, $56, $18, $58, $18, $56, $0C, $56, $0C, $54, $0C, $54, $0C, $5B, $18, $4F
db $18, $4F, $0C, $4F, $0C, $51, $18, $56, $18, $53, $18, $54, $30, $FF, $01, $E9
db $DB, $00, $77, $09, $26, $39, $4F, $27, $77, $03, $E9, $D0, $00, $3B, $C1, $75
db $04, $3B, $D6, $74, $16, $26, $8B, $47, $19, $99, $52, $50, $9A, $00, $00, $00
db $00, $89, $46, $FC, $89, $56, $FE, $0B, $D0, $75, $03, $E9, $AF, $00, $C4, $5E
db $0E, $26, $FF, $77, $19, $06, $53, $FF, $76, $0C, $FF, $76, $0A, $9A, $00, $00
db $00, $00, $52, $50, $FF, $76, $FE, $FF, $76, $FC, $9A, $00, $00, $00, $00, $83
db $C4, $0A

SECTION "rom1", ROMX, BANK[$1]
; GFX: Start of font + clock + ? tile pattern data
;  95 chars + (256 - 95) clock/etc ... x 16 bytes = 0x1000, -> end ~0x4FFF
;
; 1st entry of Pointer Table from F32 (indexed by unknown)
; Data from 4000 to 4000 (1 bytes)
gfx__tile_patterns_256_font_clock_etc__4000:
INCBIN "res/tiles_256_0x4000_bank_1_4096_bytes_font_clock_etc.2bpp"
;
; ; 1st entry of Pointer Table from F4D (indexed by unknown)
; ; Data from 4001 to 4EDF (3807 bytes)
; _DATA_4001_:
; ...
; ; Data from 4EE0 to 4FFF (288 bytes)
; _DATA_4EE0_:


; GFX: Start of font + thermometer + ? tile pattern data
;  95 chars + (250 - 95) thermometer/etc ... x 16 bytes = 0x1000, -> end ~5F9F
;
; Note: One of the loads that calls this reads a 256 tiles instead of 250
; so 6 of which are from the tile pattern data after this (unclear if intentional)
;
; Data from 5000 to 537F (896 bytes)
; Data from 5380 to 5F9F (3104 bytes)
; _DATA_5380_: 1 x Tile worth of pattern data here accessed from ~0x2805
gfx__tile_patterns_250_font_thermometer_etc__5000:
INCBIN "res/tiles_250_0x5000_bank_1_4000_bytes_font_thermometer_etc.2bpp"


; GFX: Start of font tile pattern data
;  59 chars x 16 bytes = 0x3B0, -> end 634F
;
; Data from 5FA0 to 634F (944 bytes)
gfx__tile_patterns_59_font__5FA0:
INCBIN "res/tiles_59_0x5FA0_bank_1_944_bytes_font.2bpp"

; Data from 6350 to 6357 (8 bytes)
_DATA_6350_:
db $00, $00, $00, $00, $00, $00, $00, $00

; Data from 6358 to 7D27 (6608 bytes)
_DATA_6358_:
db $00, $00, $00, $00, $00, $00, $00, $00, $C0, $80, $00, $00, $0F, $0F, $0F, $0F
db $C0, $BF, $7F, $60, $6F, $6F, $6F, $6F, $00, $00, $00, $00, $FF, $FF, $FF, $FF
db $00, $FF, $FF, $00, $FF, $FF, $FF, $FF, $03, $01, $00, $00, $F0, $F0, $F0, $F0
db $03, $FD, $FE, $06, $F6, $F6, $F6, $F6, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
db $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $40, $80, $00, $00, $0F, $0F, $0F, $0F
db $C0, $BF, $7F, $60, $6F, $6F, $6F, $6F, $00, $00, $00, $00, $FF, $FF, $F8, $E4
db $00, $FF, $FF, $00, $FF, $FF, $F8, $E7, $00, $00, $00, $00, $FF, $FF, $1F, $07
db $00, $FF, $FF, $00, $FF, $FF, $1F, $E7, $7F, $EF, $DF, $7F, $37, $3F, $3D, $3F
db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $EF, $DF, $BF, $F7, $FF, $FD
ds 9, $FF
db $40, $80, $00, $00, $0F, $0F, $0F, $0E, $C0, $BF, $7F, $60, $6F, $6F, $6F, $6E
db $00, $00, $00, $00, $FF, $FF, $07, $FB, $00, $FF, $FF, $00, $FF, $FF, $07, $FB
db $00, $00, $00, $00, $FF, $FF, $E0, $DF, $00, $FF, $FF, $00, $FF, $FF, $E0, $DF
db $00, $00, $00, $00, $F0, $F0, $F0, $70, $03, $FD, $FE, $06, $F6, $F6, $F6, $76
db $F0, $F0, $F0, $70, $30, $30, $30, $30, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F6
db $0F, $0F, $0F, $0E, $0E, $0D, $0D, $0D, $6F, $6F, $6F, $6E, $6E, $6D, $6D, $6D
db $D0, $A3, $4E, $9B, $BE, $2E, $7E, $5E, $DC, $B3, $6E, $DB, $BE, $AE, $7E, $5E
db $03, $C1, $70, $D8, $7C, $74, $7E, $7A, $3B, $CD, $76, $DB, $7D, $75, $7E, $7A
db $F0, $F0, $F0, $70, $30, $30, $10, $10, $F6, $F6, $F6, $76, $76, $B6, $B6, $B6
db $BF, $2F, $1F, $7F, $37, $3F, $3D, $3F, $7F, $FF, $FF, $BF, $FF, $FF, $FF, $FF
db $0C, $0C, $0C, $0C, $0C, $0E, $0F, $0F, $6D, $6D, $6D, $6D, $6D, $6E, $6F, $6F
db $D9, $D8, $00, $D8, $D8, $F8, $01, $83, $DD, $DD, $05, $DD, $DD, $FB, $07, $FF
db $9F, $9F, $80, $9F, $9F, $DF, $E0, $F0, $BF, $BF, $A0, $BF, $BF, $DF, $E0, $FF
db $30, $10, $10, $10, $10, $10, $30, $70, $B6, $B6, $B6, $B6, $B6, $76, $F6, $F6
db $0F, $0C, $08, $08, $08, $08, $08, $08, $6F, $6C, $6B, $6B, $6B, $6B, $6B, $6B
db $0F, $30, $3D, $3C, $7D, $7C, $7D, $7C, $0F, $F0, $FD, $FC, $FD, $FC, $FD, $FC
db $FF, $00, $BF, $29, $BF, $09, $BF, $20, $FF, $00, $BF, $3F, $BF, $3F, $BF, $3F
db $F0, $10, $D0, $80, $C0, $80, $C0, $40, $F6, $16, $D6, $D6, $D6, $D6, $D6, $D6
db $30, $30, $30, $30, $30, $30, $30, $30, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F6
db $0D, $0D, $0D, $0E, $0E, $0F, $0F, $0F, $6D, $6D, $6D, $6E, $6E, $6F, $6F, $6F
db $50, $7F, $2F, $BF, $9B, $4E, $A3, $D0, $50, $7F, $AF, $BF, $DB, $6E, $B3, $DC
db $7A, $FE, $F4, $FC, $D8, $70, $C0, $00, $7A, $FE, $F5, $FD, $DB, $76, $CD, $3B
db $10, $10, $10, $10, $30, $30, $70, $F0, $B6, $B6, $B6, $76, $76, $F6, $F6, $F6
db $0F, $0E, $0C, $0C, $0C, $0C, $0C, $0E, $6F, $6E, $6D, $6D, $6D, $6D, $6D, $6E
db $07, $FB, $21, $88, $D8, $88, $20, $F8, $07, $FB, $25, $8D, $DD, $8D, $25, $FB
db $E0, $DF, $9B, $9F, $80, $9F, $9B, $DF, $E0, $DF, $BB, $BF, $A0, $BF, $BB, $DF
db $F0, $70, $30, $10, $10, $10, $10, $10, $F6, $76, $B6, $B6, $B6, $B6, $B6, $76
db $08, $08, $08, $08, $08, $08, $0E, $0E, $6B, $6B, $6B, $6B, $6B, $68, $6F, $6F
db $7D, $FC, $FD, $FC, $0D, $00, $00, $3C, $FD, $FC, $FD, $FC, $0D, $F0, $FF, $FF
db $BF, $39, $BF, $0D, $BF, $00, $00, $00, $BF, $3F, $BF, $3F, $BF, $00, $FF, $FF
db $C0, $80, $C0, $C0, $C0, $00, $00, $00, $D6, $D6, $D6, $D6, $D6, $16, $F6, $F6
db $0F, $0F, $0F, $0F, $00, $00, $80, $C0, $6F, $6F, $6F, $6F, $60, $7F, $BF, $C0
db $E4, $F0, $FC, $FF, $00, $00, $00, $00, $E7, $F8, $FF, $FF, $00, $FF, $FF, $00
db $01, $03, $0F, $FF, $00, $00, $00, $00, $E7, $1F, $FF, $FF, $00, $FF, $FF, $00
db $F0, $F0, $F0, $F0, $00, $00, $00, $00, $F6, $F6, $F6, $F6, $06, $FE, $FD, $03
db $01, $83, $FF, $FF, $00, $00, $00, $00, $07, $FF, $FF, $FF, $00, $FF, $FF, $00
db $E0, $F0, $FF, $FF, $00, $00, $00, $00, $E0, $FF, $FF, $FF, $00, $FF, $FF, $00
db $30, $70, $F0, $F0, $00, $00, $00, $00, $F6, $F6, $F6, $F6, $06, $FE, $FD, $03
db $FF, $FF, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00
db $00, $00, $00, $00, $FF, $C0, $B5, $00, $00, $FF, $FF, $00, $FF, $C0, $9F, $00
db $00, $00, $00, $00, $FF, $00, $54, $02, $00, $FF, $FF, $00, $FF, $00, $FE, $02
db $00, $00, $00, $00, $F0, $F0, $F0, $30, $03, $FD, $FE, $06, $F6, $F6, $F6, $F6
db $00, $00, $00, $00, $FF, $FF, $FF, $F8, $00, $FF, $FF, $00, $FF, $FF, $FF, $F8
db $00, $00, $00, $00, $FF, $FF, $FF, $1F, $00, $FF, $FF, $00, $FF, $FF, $FF, $1F
db $00, $00, $00, $00, $F0, $F0, $F0, $F0, $03, $FD, $FE, $06, $F6, $F6, $F6, $F6
db $70, $F0, $F0, $70, $30, $30, $30, $30, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F6
db $3F, $5F, $40, $40, $40, $4A, $4B, $4B, $7F, $7F, $7F, $7F, $60, $73, $73, $73
db $F0, $EA, $08, $0A, $C8, $AA, $58, $5A, $FA, $FA, $FA, $FA, $7A, $3A, $9A, $9A
db $0C, $0D, $0C, $0C, $0C, $0C, $0C, $0C, $6C, $6D, $6C, $6D, $6D, $6D, $6D, $6D
db $00, $FF, $00, $00, $FF, $9A, $7F, $1A, $00, $FF, $00, $FF, $FF, $9A, $7F, $1A
db $00, $FF, $00, $00, $FF, $AA, $FF, $AA, $00, $FF, $00, $FF, $FF, $AA, $FF, $AA
db $30, $B0, $00, $00, $80, $80, $80, $80, $36, $B6, $36, $B6, $B6, $B6, $B6, $B6
db $0F, $0F, $0F, $0F, $0F, $0E, $0E, $0E, $6F, $6F, $6F, $6F, $6F, $6E, $6E, $6E
db $E2, $DE, $B6, $00, $7E, $EE, $EE, $00, $E6, $DE, $B6, $00, $7E, $EE, $EE, $00
db $27, $1B, $0D, $00, $0E, $07, $07, $00, $47, $63, $61, $00, $70, $70, $70, $00
db $F0, $F0, $F0, $F0, $70, $30, $30, $10, $F6, $F6, $F6, $F6, $F6, $76, $76, $76
db $4B, $4A, $40, $40, $40, $40, $5F, $3F, $73, $73, $60, $7F, $7F, $7F, $7F, $7F
db $58, $AA, $C8, $0A, $08, $0A, $E8, $F0, $9A, $3A, $7A, $FA, $FA, $FA, $FA, $F9
db $0C, $0C, $0C, $0E, $0F, $0F, $0F, $0F, $6D, $6D, $6D, $6E, $6F, $6F, $6F, $6F
db $6F, $9A, $FF, $1F, $0F, $8F, $F0, $F8, $6F, $9A, $FF, $1F, $EF, $EF, $F0, $FF
db $FF, $AA, $FF, $FF, $FF, $FF, $00, $00, $FF, $AA, $FF, $FF, $FF, $FF, $00, $FF
db $80, $80, $80, $80, $80, $80, $00, $00, $B6, $B6, $B6, $B6, $B6, $B6, $36, $F6
db $0E, $0E, $0F, $0F, $0F, $0F, $0F, $0F, $6E, $6E, $6F, $6F, $6F, $6F, $6F, $6F
db $EE, $EE, $6E, $00, $B0, $D0, $E4, $F0, $EE, $EE, $6E, $00, $B6, $D6, $E2, $F8
db $07, $07, $06, $00, $0C, $08, $00, $00, $70, $70, $70, $00, $61, $63, $47, $1F
db $10, $10, $10, $10, $30, $30, $70, $F0, $76, $76, $F6, $F6, $F6, $F6, $F6, $F6
db $00, $C0, $C0, $FF, $00, $00, $00, $00, $00, $FF, $FF, $FF, $00, $FF, $FF, $00
db $00, $00, $00, $FF, $00, $00, $00, $00, $03, $FF, $FF, $FF, $00, $FF, $FF, $00
db $FC, $FF, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00
db $00, $FF, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00
db $00, $F0, $F0, $F0, $00, $00, $00, $00, $F6, $F6, $F6, $F6, $06, $FE, $FD, $03
db $F8, $FE, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00
db $01, $07, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00
db $00, $00, $00, $00, $FF, $00, $7F, $60, $00, $FF, $FF, $00, $FF, $80, $7F, $7F
db $00, $00, $00, $00, $FF, $01, $FC, $02, $00, $FF, $FF, $00, $FF, $01, $FE, $FC
db $00, $00, $00, $00, $FF, $FF, $FE, $FD, $00, $FF, $FF, $00, $FF, $FF, $FE, $FD
db $00, $00, $00, $00, $FF, $FF, $7F, $3F, $00, $FF, $FF, $00, $FF, $FF, $7F, $BF
db $00, $00, $00, $00, $FF, $FF, $80, $00, $00, $FF, $FF, $00, $FF, $FF, $80, $7F
db $00, $00, $00, $00, $FF, $FF, $01, $00, $00, $FF, $FF, $00, $FF, $FF, $01, $FE
db $62, $64, $74, $64, $64, $65, $75, $65, $4E, $7D, $6D, $7D, $4D, $7D, $6D, $7D
db $8E, $46, $56, $46, $4E, $46, $56, $46, $60, $38, $28, $38, $20, $38, $28, $38
db $0F, $0E, $0E, $0F, $0F, $0F, $0F, $0F, $6F, $6E, $6E, $6F, $6F, $6F, $6F, $6F
db $00, $FF, $00, $21, $84, $84, $A5, $65, $00, $FF, $00, $0C, $AD, $AD, $AD, $75
db $00, $00, $00, $04, $90, $90, $14, $0C, $00, $FF, $00, $31, $35, $35, $B5, $AE
db $F0, $70, $30, $70, $F0, $F0, $F0, $F0, $F6, $76, $F6, $F6, $F6, $F6, $F6, $F6
db $3F, $3C, $38, $38, $38, $38, $3C, $3E, $7F, $7C, $79, $79, $79, $79, $7C, $7F
db $FC, $3C, $1C, $CC, $FC, $9C, $0C, $1C, $FE, $3E, $9E, $FE, $FE, $9E, $3E, $FE
db $70, $30, $30, $30, $30, $30, $30, $30, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F6
db $65, $65, $75, $6B, $6B, $6B, $54, $40, $4D, $7D, $6C, $79, $7B, $79, $4C, $7F
db $4E, $46, $56, $A6, $A6, $A6, $4E, $06, $20, $38, $28, $18, $98, $18, $20, $F8
db $0E, $0C, $0E, $0F, $0F, $0F, $0F, $0F, $6E, $6D, $6E, $6F, $6F, $6F, $6F, $6F
db $01, $75, $29, $01, $85, $F8, $87, $7F, $01, $F9, $F1, $05, $FD, $F8, $87, $7F
db $00, $0E, $05, $00, $30, $1F, $81, $00, $80, $BF, $9E, $A0, $BF, $1F, $E1, $FE
db $70, $B0, $10, $30, $70, $F0, $F0, $F0, $76, $36, $76, $F6, $F6, $F6, $F6, $F6
db $3F, $3F, $3F, $26, $33, $29, $34, $00, $7F, $7F, $7F, $66, $7F, $69, $7F, $7F
db $FC, $FC, $FC, $64, $30, $24, $90, $00, $FE, $FE, $FE, $66, $FE, $26, $FE, $FE
db $BF, $80, $E0, $E0, $00, $00, $00, $00, $80, $80, $FF, $FF, $00, $FF, $FF, $00
db $FE
ds 9, $00
db $FF, $FF, $00, $FF, $FF, $00, $30, $30, $30, $30, $00, $00, $00, $00, $F6, $F6
db $F6, $F6, $06, $FE, $FD, $03, $00, $80, $FF, $FF, $00, $00, $00, $00, $00, $FF
db $FF, $FF, $00, $FF, $FF, $00, $00, $00, $FF, $FF, $00, $00, $00, $00, $00, $FF
db $FF, $FF, $00, $FF, $FF, $00, $70, $70, $F0, $F0, $00, $00, $00, $00, $F6, $F6
db $F6, $F6, $06, $FE, $FD, $03, $80, $C0, $E0, $FF, $00, $00, $00, $00, $80, $FF
db $FF, $FF, $00, $FF, $FF, $00, $00, $00, $00, $FF, $00, $00, $00, $00, $01, $FF
db $FF, $FF, $00, $FF, $FF, $00, $30, $30, $70, $F0, $00, $00, $00, $00, $F6, $F6
db $F6, $F6, $06, $FE, $FD, $03, $40, $80, $00, $00, $0F, $0E, $0E, $08, $C0, $BF
db $7F, $60, $6F, $6E, $6E, $68, $00, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF
db $FF, $00, $FF, $00, $FF, $00, $00, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF
db $FF, $00, $FF, $00, $FF, $01, $00, $00, $00, $00, $F0, $70, $70, $10, $03, $FD
db $FE, $06, $F6, $76, $76, $76, $00, $00, $00, $00, $FF, $FF, $F8, $E7, $00, $FF
db $FF, $00, $FF, $FF, $F8, $E7, $00, $00, $00, $00, $FF, $FF, $1F, $E1, $00, $FF
db $FF, $00, $FF, $FF, $1F, $E1, $0B, $0B, $0A, $0A, $0A, $0B, $0A, $0A, $6B, $6B
db $6B, $6B, $6B, $6B, $6A, $6A, $FF, $FF, $71, $E0, $88, $7F, $FF, $E3, $FF, $FF
db $FF, $F7, $88, $7F, $FF, $E3, $FC, $F8, $C8, $E8, $C8, $68, $B8, $80, $FD, $FD
db $FD, $FD, $FD, $7D, $BD, $BC, $10, $10, $10, $10, $10, $10, $10, $10, $76, $76
db $76, $76, $76, $76, $76, $76, $D8, $A1, $A2, $44, $A3, $B0, $CC, $E3, $DF, $BF
db $BE, $7C, $BF, $BF, $CF, $E3, $1C, $E4, $1C, $00, $00, $C0, $33, $0D, $FC, $FC
db $1C, $00, $20, $CF, $F3, $FD, $F0, $70, $70, $70, $70, $70, $F0, $F0, $F6, $F6
db $F6, $F6, $F6, $F6, $F6, $F6
ds 17, $FF
db $C0, $BF, $76, $70, $06, $98, $D0, $FF, $C0, $BF, $77, $78, $07, $9C, $DB, $FF
db $03, $F9, $00, $10, $00, $00, $44, $FF, $03, $FD, $EE, $1E, $E0, $38, $D9, $F0
db $F0, $F0, $F0, $70, $30, $10, $10, $F6, $F6, $F6, $F6, $76, $76, $76, $F6, $08
db $0E, $0F, $0F, $0E, $0E, $0F, $0F, $68, $6E, $6F, $6F, $6E, $6E, $6F, $6F, $E8
db $FF, $7F, $03, $EB, $FF, $7F, $88, $E8, $FF, $7F, $03, $EB, $FF, $7F, $88, $00
db $06, $8F, $8C, $83, $87, $07, $0B, $01, $76, $AF, $AC, $B3, $B7, $77, $FB, $10
db $10, $70, $30, $10, $90, $90, $00, $F6, $F6, $76, $76, $76, $B6, $B6, $76, $F0
db $FC, $87, $B8, $A7, $B8, $87, $C0, $F8, $FE, $87, $B8, $BF, $BF, $87, $C0, $C4
db $22, $22, $44, $84, $18, $E0, $00, $FC, $3E, $BE, $7C, $FC, $F8, $E1, $03, $F0
db $70, $70, $30, $30, $70, $70, $F0, $F6, $F6, $76, $76, $F6, $F6, $F6, $F6, $B0
db $A0, $00, $7F, $60, $80, $C0, $E0, $BC, $BF, $00, $7F, $7F, $80, $C0, $FF, $00
db $00, $00, $FC, $00, $00, $00, $00, $3D, $FC, $00, $FE, $FE, $00, $00, $FF, $10
db $70, $70, $30, $30, $10, $10, $10, $F6, $F6, $F6, $76, $76, $76, $F6, $F6, $C0
db $E0, $FD, $FF, $00, $00, $00, $00, $F7, $FF, $FF, $FF, $00, $FF, $FF, $00, $1C
db $3E, $FF, $FF, $00, $00, $00, $00, $FC, $FF, $FF, $FF, $00, $FF, $FF, $00, $00
db $10, $30, $F0, $00, $00, $00, $00, $F6, $F6, $F6, $F6, $06, $FE, $FD, $03, $E0
db $FE, $FF, $FF, $00, $00, $00, $00, $FC, $FF, $FF, $FF, $00, $FF, $FF, $00, $01
db $07, $FF, $FF, $00, $00, $00, $00, $0F, $FF, $FF, $FF, $00, $FF, $FF, $00, $F0
db $FF, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $30
db $F0, $F0, $F0, $00, $00, $00, $00, $F6, $F6, $F6, $F6, $06, $FE, $FD, $03, $E0
db $F0, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $00
db $00, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $7F
db $FF, $FF, $FF, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $00, $FF, $FF, $00, $F0
db $F0, $F0, $F0, $00, $00, $01, $03, $F6, $F6, $F6, $F6, $06, $FE, $FD, $03
ds 16, $FF
db $E7, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $E7, $E7, $F3, $FF
db $99, $99, $88, $99, $CC
ds 11, $FF
db $93, $93, $01, $01, $80, $93, $81, $93, $81, $93, $01, $01, $80, $93, $C9, $FF
db $EF, $EF, $C3, $C3, $81, $9F, $C7, $C7, $E3, $F3, $81, $87, $C3, $EF, $F7, $FF
db $FF, $FF, $39, $39, $10, $33, $81, $E7, $C3, $CF, $81, $99, $08, $39, $9C, $FF
db $C7, $C7, $83, $93, $C1, $C7, $83, $8F, $01, $21, $10, $33, $89, $89, $C4, $FF
db $E7, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $C3, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $E7, $E7, $F3, $FF
db $E7, $E7, $F3, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $E1, $E7, $F3, $FF
db $FF, $FF, $93, $93, $C1, $C7, $01, $01, $80, $C7, $83, $93, $C9, $FF, $FF, $FF
db $FF, $FF, $E7, $E7, $E3, $E7, $81, $81, $C0, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $81, $81
db $C0
ds 17, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $F9, $F9, $F0, $F3, $E1, $E7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $87, $87, $03, $33, $11, $33, $91, $B7, $13, $33
db $11, $33, $81, $87, $C3, $FF, $F7, $F7, $F3, $F3, $F1, $F3, $F1, $F7, $F3, $F3
db $F1, $F3, $F1, $F7, $FB, $FF, $87, $87, $C3, $F3, $F1, $F3, $81, $87, $03, $3F
db $1F, $3F, $87, $87, $C3, $FF, $87, $87, $C3, $F3, $F1, $F3, $81, $87, $C3, $F3
db $F1, $F3, $81, $87, $C3, $FF, $B7, $B7, $13, $33, $11, $33, $81, $87, $C3, $F3
db $F1, $F3, $F1, $F7, $FB, $FF, $87, $87, $03, $3F, $1F, $3F, $87, $87, $C3, $F3
db $F1, $F3, $81, $87, $C3, $FF, $87, $87, $03, $3F, $1F, $3F, $87, $87, $03, $33
db $11, $33, $81, $87, $C3, $FF, $87, $87, $C3, $F3, $F1, $F3, $F1, $F7, $F3, $F3
db $F1, $F3, $F1, $F7, $FB, $FF, $87, $87, $03, $33, $11, $33, $81, $87, $03, $33
db $11, $33, $81, $87, $C3, $FF, $87, $87, $03, $33, $11, $33, $81, $87, $C3, $F3
db $F1, $F3, $F1, $F7, $FB, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $E7, $E7
db $E3, $E7, $C3, $CF, $E7, $FF, $E7, $E7, $C3, $CF, $87, $9F, $0F, $3F, $9F, $9F
db $CF, $CF, $E7, $E7, $F3, $FF, $FF, $FF, $FF, $FF, $81, $81, $C0, $FF, $81, $81
db $C0, $FF, $FF, $FF, $FF, $FF, $CF, $CF, $E7, $E7, $F3, $F3, $F9, $F9, $F0, $F3
db $E1, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $99, $C8, $F9, $F0, $F3, $E1, $E7
db $F3, $FF, $E7, $E7, $F3, $FF, $83, $83, $01, $3D, $00, $21, $00, $2D, $02, $23
db $11, $3F, $81, $81, $C0, $FF, $C7, $C7, $83, $93, $09, $39, $00, $01, $00, $39
db $18, $39, $10, $11, $88, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $00, $03, $81, $FF, $C3, $C3, $81, $99, $0C, $3F, $1F, $3F, $1F, $3F
db $99, $99, $C0, $C3, $E1, $FF, $07, $07, $83, $93, $89, $99, $88, $99, $88, $99
db $80, $93, $01, $07, $83, $FF, $87, $87, $03, $3F, $1F, $3F, $87, $87, $03, $3F
db $1F, $3F, $87, $87, $C3, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $8B, $9F, $0F, $0F, $87, $FF, $C3, $C3, $81, $99, $0C, $3F, $11, $31, $18, $39
db $98, $99, $C0, $C3, $E1, $FF, $39, $39, $18, $39, $18, $39, $00, $01, $00, $39
db $18, $39, $18, $39, $9C, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $83, $8F, $C7, $FF, $19, $19, $88, $99, $80, $93, $81, $87, $83, $93
db $89, $99, $08, $19, $8C, $FF, $1F, $1F, $8F, $9F, $8F, $9F, $8F, $9F, $8F, $9F
db $89, $99, $00, $01, $80, $FF, $BB, $BB, $10, $11, $00, $01, $00, $29, $10, $39
db $18, $39, $98, $BB, $DD, $FF, $31, $31, $18, $19, $08, $29, $10, $31, $18, $39
db $18, $39, $18, $19, $8C, $FF, $87, $87, $03, $33, $11, $33, $11, $33, $11, $33
db $11, $33, $81, $87, $C3, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F
db $8F, $9F, $0F, $0F, $87, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $1C, $3D
db $92, $93, $C9, $C9, $E4, $FF, $07, $07, $03, $33, $11, $33, $01, $07, $03, $33
db $11, $33, $11, $33, $99, $FF, $83, $83, $01, $39, $1C, $3F, $83, $83, $C1, $F9
db $38, $39, $80, $83, $C1, $FF, $81, $81, $80, $A5, $C2, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $C3, $C3, $E1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $90, $93
db $C1, $C7, $E3, $EF, $F7, $FF, $39, $39, $18, $39, $18, $39, $18, $39, $08, $29
db $10, $11, $08, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $83, $93
db $09, $39, $18, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $81, $81, $00, $39, $90, $F3, $E1, $E7, $C3, $CF
db $81, $99, $00, $03, $81, $FF, $C3, $C3, $C1, $CF, $C7, $CF, $C7, $CF, $C7, $CF
db $C7, $CF, $C3, $C3, $E1, $FF, $FF, $FF, $3F, $3F, $9F, $9F, $CF, $CF, $E7, $E7
db $F3, $F3, $F9, $F9, $FC, $FF, $C3, $C3, $E1, $F3, $F1, $F3, $F1, $F3, $F1, $F3
db $F1, $F3, $C1, $C3, $E1, $FF, $E7, $E7, $C3, $C3, $81, $81, $80, $A5, $C2, $E7
db $E3, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $CF, $CF, $87, $9F, $01, $01, $00, $01
db $80, $9F, $CF, $CF, $E7, $FF, $E7, $E7, $E3, $E7, $F3, $F3, $F9
ds 13, $FF
db $87, $87, $C3, $F3, $81, $83, $01, $33, $81, $81, $C0, $FF, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $00, $03, $81, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $8C, $9F, $89, $99, $C0, $C3, $E1, $FF, $F1, $F1, $F0, $F3
db $81, $83, $01, $33, $11, $33, $11, $33, $81, $81, $C0, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $80, $83, $81, $9F, $C3, $C3, $E1, $FF, $E3, $E3, $C1, $CF
db $87, $87, $C3, $CF, $C7, $CF, $C7, $CF, $87, $87, $C3, $FF, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $01, $07, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $CF, $1F, $1F, $8F, $9F
db $89, $99, $80, $93, $81, $87, $83, $93, $09, $19, $8C, $FF, $C7, $C7, $E3, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $13, $13, $01, $01, $00, $29, $10, $39, $18, $39, $9C, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $88, $99, $88, $99, $C0, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F, $0F, $0F, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $E1, $E1, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $8C, $9F, $8F, $9F, $0F, $0F, $87, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $80, $9F, $C3, $C3, $E1, $F9, $80, $83, $C1, $FF, $E7, $E7, $E3, $E7
db $C3, $C3, $E1, $E7, $E3, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $88, $99, $C0, $C1, $E0, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $C8, $DB, $E5, $E7, $F3, $FF, $83, $FF, $FF, $FF
db $11, $11, $08, $39, $08, $29, $00, $01, $00, $13, $89, $FF, $FF, $FF, $7F, $FF
db $19, $99, $40, $C3, $61, $E7, $43, $C3, $01, $99, $CC, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $CF, $87, $9F, $CF, $FF, $E7, $FF, $FF, $FF
db $C1, $C1, $A0, $B3, $C1, $E7, $C1, $CD, $82, $83, $C1, $FF, $F3, $F3, $E1, $E7
db $E3, $E7, $C3, $CF, $E7, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $E7, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $CF, $CF, $E7, $E7
db $E3, $E7, $F3, $F3, $E1, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $9D
db $8E, $9F, $07, $07, $83, $9F, $8F, $9F, $01, $01, $80, $FF, $DF, $C0, $B0, $8F
db $66, $1F, $66, $1F, $66, $1F, $66, $1F, $66, $1F, $66, $1F, $1F, $00, $E0, $1F
db $00, $EF, $27, $CF, $A7, $C8, $A3, $CF, $A3, $CF, $A3, $CE, $FF, $00, $00, $FF
db $00, $FF, $FF, $FF, $FF, $00, $BA, $FF, $AB, $FF, $BB, $7F, $FF, $00, $00, $FF
db $00, $FF, $FF, $FF, $FF, $00, $B7, $FF, $A6, $FF, $B7, $FD, $FF, $00, $00, $FF
db $00, $FF, $FF, $FF, $FF, $7F, $7F, $BF, $3F, $FF, $3F, $FF, $FF, $00, $00, $FF
db $00
ds 11, $FF
db $F8, $00, $07, $F8, $08, $FF, $E9, $FE, $ED, $FE, $ED, $FE, $ED, $FE, $ED, $FE
db $03, $FF, $01, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $C0
ds 15, $FF
db $00
ds 15, $FF
db $FB, $00, $0D, $F0, $26, $78, $26, $78, $26, $78, $26, $78, $26, $78, $26, $78
db $7F, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $70, $0F, $E0, $0F, $D0, $0F, $B0, $0F, $F8, $07, $F0, $0F, $F2, $0D, $F0, $0F
ds 16, $00
db $66, $1F, $66, $1F, $24, $1F, $24, $1F, $24, $1F, $7B, $04, $40, $3F, $4F, $3F
db $A2, $CD, $A7, $CF, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF
db $3B, $C4, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF
db $B5, $4A, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF
db $7F, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF
db $ED, $FE, $ED, $FE, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF
db $26, $78, $26, $78, $24, $F8, $24, $F8, $24, $F8, $DE, $20, $02, $FC, $F2, $FC
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $FF
ds 68, $00
db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
ds 16, $00
db $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4C, $3F, $48, $3C, $48, $3D, $48, $3D
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $FF, $FF, $FF
db $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $12, $FC, $52, $3C, $52, $3C, $52, $3C
db $48, $3D, $48, $3D, $48, $3D, $48, $3D, $48, $3D, $48, $3D, $48, $3D, $48, $3D
db $52, $3C, $52, $3C, $52, $3C, $52, $3C, $52, $3C, $52, $3C, $52, $3C, $52, $3C
db $4C, $38, $48, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F
db $00, $00, $00, $FF, $FF, $FF, $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE
db $00, $00, $FF, $00, $00, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $00, $00, $00, $FF, $FF, $FF, $70, $0F, $70, $0F, $70, $0F, $70, $0F, $70, $0F
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
ds 38, $00
db $52, $3C, $12, $FC, $92, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC
ds 48, $00
db $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F
db $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE, $1C, $FE
db $70, $0F, $70, $0F, $70, $0F, $70, $0F, $70, $0F, $70, $0F, $70, $0F, $70, $0F
db $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC
db $00, $00, $00, $FF, $FF, $FF, $00, $00, $40, $60, $11, $51, $1B, $5B, $55, $15
db $00, $00, $00, $FF, $FF, $FF, $01, $01, $02, $01, $7A, $79, $62, $61, $62, $61
db $00, $00, $00, $FF, $FF, $FF, $00, $00, $4C, $70, $23, $43, $06, $46, $46, $06
db $00, $00, $00, $FF, $FF, $FF, $01, $01, $02, $01, $C2, $C1, $62, $61, $02, $01
db $00, $00, $00, $FF, $FF, $FF, $00, $00, $48, $70, $26, $46, $06, $46, $40, $00
db $00, $00, $00, $FF, $FF, $FF, $01, $01, $02, $01, $22, $21, $42, $41, $82, $81
db $00, $00, $00, $FF, $FF, $FF, $00, $00, $4C, $70, $20, $40, $00, $40, $40, $00
db $00, $00, $00, $FF, $FF, $FF, $01, $01, $02, $01, $02, $01, $02, $01, $02, $01
db $00, $00, $00, $FF, $FF, $FF, $00, $00, $4C, $70, $21, $41, $00, $40, $47, $07
db $00, $00, $00, $FF, $FF, $FF, $01, $01, $02, $01, $82, $81, $02, $01, $E2, $E1
db $51, $11, $11, $11, $11, $11, $00, $00, $00, $00, $FF, $00, $00, $00, $80, $FF
db $62, $61, $62, $61, $7A, $79, $02, $01, $02, $01, $FE, $01, $00, $01, $00, $FF
db $46, $06, $06, $06, $03, $03, $00, $00, $00, $00, $FF, $00, $00, $00, $00, $FF
db $02, $01, $6A, $61, $CA, $C1, $1A, $01, $02, $01, $FE, $01, $00, $01, $00, $FF
db $41, $01, $02, $02, $04, $04, $00, $00, $00, $00, $FF, $00, $00, $00, $00, $FF
db $02, $01, $6A, $61, $6A, $61, $1A, $01, $02, $01, $FE, $01, $00, $01, $00, $FF
db $40
ds 9, $00
db $FF, $00, $00, $00, $00, $FF, $02, $01, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $40, $00, $01, $01, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $02, $01, $8A, $81, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $C0, $FF, $FF, $FF, $FF, $FF, $00, $00, $50, $60
db $28, $48, $0D, $4D, $4A, $0A, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $82, $81, $82, $81, $BA, $B9, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $48, $70
db $27, $47, $00, $40, $40, $00, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $E2, $E1, $62, $61, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $23, $43, $06, $46, $43, $03, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $62, $61, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $23, $43, $06, $46, $43, $03, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $62, $61, $E2, $E1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $48, $70
db $26, $46, $03, $43, $41, $01, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $62, $61, $C2, $C1, $82, $81, $48, $08, $08, $08, $08, $08, $00, $00, $00, $00
db $FF, $00, $00, $00, $80, $FF, $82, $81, $8A, $81, $8A, $81, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $41, $01, $03, $03, $06, $06, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $82, $81, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $46, $06, $06, $06, $03, $03, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $62, $61, $6A, $61, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $40, $00, $06, $06, $03, $03, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $62, $61, $6A, $61, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $43, $03, $06, $06, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $C2, $C1, $6A, $61, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $C0, $FF, $FF, $FF, $FF, $FF, $00, $00, $50, $60
db $28, $48, $0D, $4D, $4A, $0A, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $82, $81, $92, $91, $BA, $B9, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $21, $41, $02, $42, $46, $06, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $C2, $C1, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $48, $70
db $27, $47, $06, $46, $47, $07, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $E2, $E1, $02, $01, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $23, $43, $06, $46, $47, $07, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $02, $01, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $20, $40, $00, $40, $47, $07, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $02, $01, $02, $01, $C2, $C1, $48, $08, $08, $08, $08, $08, $00, $00, $00, $00
db $FF, $00, $00, $00, $80, $FF, $92, $91, $8A, $81, $8A, $81, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $47, $07, $00, $00, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $E2, $E1, $CA, $C1, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $40, $00, $00, $00, $07, $07, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $62, $61, $6A, $61, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $46, $06, $06, $06, $03, $03, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $62, $61, $6A, $61, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $40
ds 9, $00
db $FF, $00, $00, $00, $00, $FF, $02, $01, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $C0, $FF, $FF, $FF, $FF, $FF, $00, $00, $40, $60
db $11, $51, $1B, $5B, $55, $15, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $72, $71, $6A, $69, $6A, $69, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $21, $41, $03, $43, $41, $01, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $82, $81, $82, $81, $82, $81, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $48, $70
db $27, $47, $00, $40, $43, $03, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $62, $61, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $23, $43, $04, $44, $41, $01, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $62, $61, $C2, $C1, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $21, $41, $01, $41, $47, $07, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $82, $81, $82, $81, $E2, $E1, $51, $11, $11, $11, $11, $11, $00, $00, $00, $00
db $FF, $00, $00, $00, $80, $FF, $72, $71, $6A, $69, $6A, $69, $02, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $41, $01, $01, $01, $07, $07, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $82, $81, $8A, $81, $EA, $E1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $46, $06, $06, $06, $07, $07, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $02, $01, $0A, $01, $EA, $E1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $40, $00, $04, $04, $03, $03, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $62, $61, $6A, $61, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $41, $01, $01, $01, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $82, $81, $8A, $81, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $00, $00, $00, $FF, $FF, $FF, $00, $00, $50, $60
db $2F, $4F, $0C, $4C, $4C, $0C, $00, $00, $00, $FF, $FF, $FF, $01, $01, $02, $01
db $7A, $79, $62, $61, $72, $71, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $23, $43, $06, $46, $46, $06, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $C2, $C1, $62, $61, $62, $61, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $20, $40, $00, $40, $41, $01, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $02, $01, $02, $01, $82, $81, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $20, $40, $00, $40, $40, $00, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $02, $01, $02, $01, $02, $01, $40, $FF, $FF, $FF, $FF, $FF, $00, $00, $4C, $70
db $20, $40, $07, $47, $40, $00, $00, $FF, $FF, $FF, $FF, $FF, $01, $01, $02, $01
db $02, $01, $C2, $C1, $02, $01, $4C, $0C, $0C, $0C, $0F, $0F, $00, $00, $00, $00
db $FF, $00, $00, $00, $80, $FF, $62, $61, $62, $61, $7A, $79, $02, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $46, $06, $06, $06, $03, $03, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $62, $61, $6A, $61, $CA, $C1, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $41, $01, $00, $00, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $82, $81, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $40
ds 9, $00
db $FF, $00, $00, $00, $00, $FF, $02, $01, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $47, $07, $00, $00, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $C2, $C1, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F
db $4D, $3F, $4D, $3F, $40, $3F, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC
db $B2, $FC, $B2, $FC, $02, $FC, $D0, $E5, $F5, $0A, $1F, $34, $48, $51, $62, $6D
db $7B, $8C, $99, $AA, $B3, $C7, $DB, $EF, $04, $18, $2D, $42, $56, $6B, $76, $8A
db $9E, $B2, $C6, $DA, $EE, $02, $16, $2A, $3E, $52, $66, $7A, $8E, $A2, $B6, $CA
db $DE, $F2, $FE, $0D, $16, $25, $3B, $4B, $58, $66, $73, $80, $92, $92, $A5, $B9
db $C0, $C8, $CE, $D4, $D8, $DD, $E2, $E9, $F3, $FB, $04, $0D, $0F, $11, $13, $15
db $24, $2F, $35, $3A, $46, $55, $68, $7A, $8D, $98, $AC, $C0, $D4, $E8, $FC, $10
db $24, $38, $4C, $60, $74, $88, $9C, $B0, $C5, $D1, $E1, $F2, $01, $06, $10, $24
db $38, $4C, $5F, $6A, $77, $85, $99, $A8, $BD, $CC, $E0, $F1, $FF, $12, $27, $32
db $3F, $4D, $61, $70, $85, $94, $A8, $B9, $C7, $DA, $EF, $04, $19, $2A, $33, $3B
db $42, $4B, $53, $59, $6E, $83, $98, $AD, $C2, $D7, $EC, $FB, $03, $0A, $10, $18
db $1F, $24, $32, $3F, $53, $67, $78, $8C, $A0, $B4, $C6, $D9, $ED, $01, $15, $29
db $39, $49, $5C, $70, $75, $86, $97, $AB, $C0, $C5, $CE, $DF, $F2, $04, $15, $23
db $37, $4B, $5D, $71, $84, $8D, $95, $A2, $AB, $B7, $C1, $CB, $D5, $DF, $E9, $F3
db $FD, $07, $11, $1B, $25, $2F, $47, $5C, $71, $86, $9B, $B0, $C5, $D9, $ED, $01
db $15, $29, $3D, $51, $65, $79, $8E, $A3, $B7, $CB, $DF, $F1, $04, $18

_LABEL_7D28_:
	xor  a
	ld   [_RAM_C306_], a
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
_LABEL_7D34_:
	ld   hl, $C11B
	push de
	ld   a, [de]
	cp   $2A
	jr   nz, _LABEL_7DA2_
	inc  de
	ld   a, [de]
	cp   $2A
	jr   nz, _LABEL_7D49_
	pop  de
	ld   [_RAM_C307_], a
	xor  a
	ret

_LABEL_7D49_:
	push de
	ld   hl, _RAM_C308_
_LABEL_7D4D_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   z, _LABEL_7D57_
	cp   $41
	jr   c, _LABEL_7D5A_
_LABEL_7D57_:
	ldi  [hl], a
	jr   _LABEL_7D4D_

_LABEL_7D5A_:
	xor  a
	ld   [hl], a
_LABEL_7D5C_:
	ld   a, [de]
	inc  de
	cp   $41
	jr   c, _LABEL_7D6B_
	cp   $5B
	jr   nc, _LABEL_7D6B_
	sub  $41
	ld   [_RAM_C25F_], a
_LABEL_7D6B_:
	or   a
	jr   nz, _LABEL_7D5C_
	ld   hl, _RAM_C31D_
_LABEL_7D71_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_7D71_
	push de
	ld   hl, _RAM_C31D_
	ld   de, _SRAM_6006_
_LABEL_7D7E_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_7D7E_
	pop  de
	ld   hl, _RAM_C322_
	ld   a, [_RAM_C25F_]
	cp   $03
	jr   nz, _LABEL_7D93_
	xor  a
	ldi  [hl], a
	jr   _LABEL_7D99_

_LABEL_7D93_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_7D93_
_LABEL_7D99_:
	pop  de
	ld   a, $01
	ld   [_RAM_C306_], a
	ld   hl, $C11B
_LABEL_7DA2_:
	ld   a, [de]
	cp   $20
	jr   z, _LABEL_7DAE_
	cp   $41
	jr   nc, _LABEL_7DAE_
	inc  de
	jr   _LABEL_7DA2_

_LABEL_7DAE_:
	cp   [hl]
	jr   nz, _LABEL_7DB9_
	inc  hl
	ld   a, [hl]
	or   a
	jr   z, _LABEL_7DF9_
	inc  de
	jr   _LABEL_7DA2_

_LABEL_7DB9_:
	pop  de
	inc  de
	ld   a, [de]
	cp   $20
	jr   z, _LABEL_7DC5_
	cp   $41
	jr   c, _LABEL_7DD2_
_LABEL_7DC4_:
	inc  de
_LABEL_7DC5_:
	ld   a, [de]
	cp   $20
	jr   nz, _LABEL_7DCE_
	inc  de
	jp   _LABEL_7D34_

_LABEL_7DCE_:
	cp   $41
	jr   nc, _LABEL_7DC4_
_LABEL_7DD2_:
	ld   b, $01
	ld   a, [_RAM_C306_]
	or   a
	jr   z, _LABEL_7DE6_
	ld   a, [_RAM_C322_]
	or   a
	jr   nz, _LABEL_7DE4_
	ld   b, $02
	jr   _LABEL_7DE6_

_LABEL_7DE4_:
	ld   b, $03
_LABEL_7DE6_:
	ld   a, [de]
	inc  de
	or   a
	jr   nz, _LABEL_7DE6_
	dec  b
	jr   nz, _LABEL_7DE6_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	jp   _LABEL_7D28_

_LABEL_7DF9_:
	pop  af
	ld   a, [_RAM_C306_]
	or   a
	jr   z, _LABEL_7E2B_
_LABEL_7E00_:
	ld   a, [de]
	cp   $20
	jr   z, _LABEL_7E09_
	cp   $41
	jr   c, _LABEL_7E0C_
_LABEL_7E09_:
	inc  de
	jr   _LABEL_7E00_

_LABEL_7E0C_:
	call _LABEL_2AEB_
	ld   a, [de]
	inc  de
	call _LABEL_2AB5_
_LABEL_7E14_:
	ld   a, [de]
	cp   $2A
	jr   z, _LABEL_7E20_
	cp   $41
	jr   nc, _LABEL_7E20_
	inc  de
	jr   _LABEL_7E14_

_LABEL_7E20_:
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	ld   a, $01
	ret

_LABEL_7E2B_:
	ld   hl, _RAM_C327_
	ld   a, [_RAM_C24C_]
	ld   e, a
	ld   a, [_RAM_C24D_]
	ld   d, a
_LABEL_7E36_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   z, _LABEL_7E44_
	cp   $2E
	jr   z, _LABEL_7E44_
	cp   $41
	jr   c, _LABEL_7E47_
_LABEL_7E44_:
	ldi  [hl], a
	jr   _LABEL_7E36_

_LABEL_7E47_:
	xor  a
	ld   [hl], a
	dec  de
	ld   hl, _RAM_C33C_
_LABEL_7E4D_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   z, _LABEL_7E56_
	ldi  [hl], a
	jr   _LABEL_7E4D_

_LABEL_7E56_:
	xor  a
	ld   [hl], a
	call _LABEL_2AEB_
	call _LABEL_2AB5_
	ld   a, e
	ld   [_RAM_C24C_], a
	ld   a, d
	ld   [_RAM_C24D_], a
	ld   a, $01
	ret

; Data from 7E69 to 7FFF (407 bytes)
db $00, $00, $B8, $01, $00, $5E, $5F, $8B, $E5, $5D, $CA, $12, $00, $80, $3E, $00
db $00, $00, $75, $15, $9A, $00, $00, $00, $00, $9A, $00, $00, $00, $00, $9A, $00
db $00, $00, $00, $E8, $A1, $04, $EB, $05, $90, $0E, $E8, $36, $04, $C6, $06, $00
db $00, $00, $2B, $C0, $CB, $80, $3E, $00, $00, $00, $75, $05, $9A, $00, $00, $00
db $00, $0E, $E8, $1E, $04, $9A, $00, $00, $00, $00, $9A, $00, $00, $00, $00, $2B
db $C0, $CB, $90, $55, $8B, $EC, $83, $EC, $20, $57, $56, $8E, $06, $00, $00, $26
db $A1, $02, $00, $26, $0B, $06, $00, $00, $74, $05, $2B, $C0, $E9, $EB, $03, $2B
db $C0, $89, $46, $E6, $89, $46, $E4, $99, $8B, $F0, $89, $56, $E2, $89, $46, $F0
db $89, $46, $FE, $39, $46, $08, $75, $03, $E9, $EE, $00, $8B, $7E, $08, $83, $7E
db $FE, $00, $74, $03, $E9, $E2, $00, $83, $FF, $FF, $74, $1D, $8B, $C7, $2B, $D2
db $D1, $E0, $D1, $D2, $D1, $E0, $D1, $D2, $D1, $E0, $D1, $D2, $D1, $E0, $D1, $D2
db $89, $46, $E8, $89, $56, $EA, $EB, $0B, $90, $C7, $46, $E8, $FF, $FF, $C7, $46
db $EA, $FF, $FF, $8D, $46, $E8, $16, $50, $8D, $46, $EC, $16, $50, $9A, $00, $00
db $00, $00, $89, $46, $FE, $0B, $C0, $75, $B5, $39, $46, $EA, $75, $21, $83, $7E
db $E8, $30, $73, $1B, $8B, $46, $EA, $0B, $46, $E8, $74, $0B, $FF, $76, $EE, $FF
db $76, $EC, $9A, $00, $00, $00, $00, $C7, $46, $FE, $FF, $FF, $EB, $90, $90, $B8
db $10, $00, $50, $2B, $C0, $50, $FF, $76, $EE, $FF, $76, $EC, $9A, $00, $00, $00
db $00, $83, $C4, $08, $8B, $46, $E6, $0B, $46, $E4, $75, $0C, $8B, $46, $EC, $8B
db $56, $EE, $89, $46, $E4, $89, $56, $E6, $C4, $5E, $EC, $26, $C7, $07, $50, $44
db $C4, $5E, $EC, $26, $C6, $47, $0F, $FF, $8B, $46, $E8, $8B, $56, $EA, $D1, $EA
db $D1, $D8, $D1, $EA, $D1, $D8, $D1, $EA, $D1, $D8, $D1, $EA, $D1, $D8, $C4, $5E
db $EC, $26, $89, $47, $02, $8B, $46, $E2, $0B, $C6, $74, $0A, $8B, $46, $EE, $8E
db $46, $E2, $26, $89, $44, $06, $8B, $46, $EC, $8B, $56, $EE, $8B, $F0, $89, $56
db $E2, $83, $FF, $FF, $75, $03, $E9, $15, $FF, $83, $7E, $FE, $07, $75, $06, $B8
db $F9, $FF, $E9, $D5, $02, $89, $76, $E0, $8B, $46, $E6, $0B, $46, $E4, $75, $05
db $C7, $46, $F0, $01, $00, $80, $7E

SECTION "rom2", ROMX, BANK[$2]
; Data from 8000 to 861D (1566 bytes)
db $41, $64, $64, $72, $65, $73, $73, $20, $4E, $75, $6D, $62, $65, $72, $3A, $20
db $20, $20, $20, $20, $00, $41, $70, $70, $6F, $69, $6E, $74, $6D, $65, $6E, $74
db $20, $4E, $6F, $3A, $00, $52, $65, $63, $6F, $72, $64, $20, $6E, $75, $6D, $62
db $65, $72, $20, $3A, $20, $20, $20, $20, $20, $00, $46, $69, $6E, $64, $20, $4D
db $61, $6B, $65, $20, $43, $6C, $65, $61, $72, $20, $45, $64, $69, $74, $00, $4E
db $65, $78, $74, $20, $20, $50, $72, $65, $76, $69, $6F, $75, $73, $20, $20, $51
db $75, $69, $74, $00, $50, $52, $45, $53, $53, $20, $41, $4E, $59, $20, $4B, $45
db $59, $00, $28, $63, $29, $20, $31, $39, $39, $32, $00, $4D, $6F, $6E, $74, $61
db $67, $75, $65, $2D, $57, $65, $73, $74, $6F, $6E, $2E, $00, $4C, $69, $63, $65
db $6E, $73, $65, $64, $00, $65, $78, $63, $6C, $75, $73, $69, $76, $65, $6C, $79
db $20, $20, $74, $6F, $00, $20, $20, $46, $61, $62, $74, $65, $6B, $2C, $20, $49
db $6E, $63, $2E, $20, $20, $00, $56, $65, $72, $73, $69, $6F, $6E, $20, $35, $2E
db $37, $34, $00, $4C, $69, $63, $65, $6E, $73, $65, $64, $20, $62, $79, $00, $4E
db $69, $6E, $74, $65, $6E, $64, $6F, $00, $45, $6E, $74, $65, $72, $20, $73, $65
db $61, $72, $63, $68, $20, $73, $74, $72, $69, $6E, $67, $2E, $45, $4E, $54, $45
db $52, $20, $53, $45, $41, $52, $43, $48, $20, $53, $54, $52, $49, $4E, $47, $2E
db $20, $20, $53, $45, $41, $52, $43, $48, $45, $44, $20, $54, $4F, $20, $45, $4E
db $44, $20, $20, $20, $20, $20, $20, $50, $52, $45, $53, $53, $20, $41, $4E, $59
db $20, $4B, $45, $59, $20, $20, $20, $20, $00, $20, $20, $4C, $61, $6E, $67, $75
db $61, $67, $65, $20, $20, $53, $65, $61, $72, $63, $68, $20, $20, $53, $65, $61
db $72, $63, $68, $65, $64, $20, $74, $6F, $20, $65, $6E, $64, $20, $6F, $66, $00
db $74, $68, $65, $20, $64, $61, $74, $61, $2E, $4E, $6F, $74, $20, $66, $6F, $75
db $6E, $64, $2E, $00, $50, $72, $65, $73, $73, $20, $41, $6E, $79, $20, $4B, $65
db $79, $00, $20, $20, $20, $20, $4E, $65, $78, $74, $20, $20, $20, $20, $45, $78
db $69, $74, $20, $20, $20, $20, $00, $4E, $45, $58, $54, $20, $20, $20, $20, $45
db $58, $49, $54, $20, $20, $20, $4D, $49, $4E, $49, $54, $52, $41, $4E, $53, $4C
db $41, $54, $4F, $52, $20, $20, $20, $20, $20, $20, $20, $20, $46, $69, $6E, $64
db $20, $20, $57, $6F, $72, $64, $20, $20, $20, $20, $20, $20, $20, $20, $56, $69
db $65, $77, $20, $20, $48, $65, $61, $64, $69, $6E, $67, $73
ds 11, $20
db $45, $78, $69, $74
ds 10, $20
db $57, $4F, $52, $4C, $44, $20, $20, $46, $55, $4E, $43, $54, $49, $4F, $4E, $53
db $20, $20, $20, $20, $20, $4D, $69, $6E, $69, $54, $72, $61, $6E, $73, $6C, $61
db $74, $6F, $72, $20, $20, $20, $20, $20, $20, $20, $20, $57, $6F, $72, $6C, $64
db $20, $4D, $61, $70
ds 9, $20
db $44, $41, $54, $45, $20, $46, $55, $4E, $43, $54, $49, $4F, $4E, $53, $20, $20
db $20, $20, $20, $20, $20, $41, $70, $70, $6F, $69, $6E, $74, $6D, $65, $6E, $74
db $73
ds 10, $20
db $43, $61, $6C, $65, $6E, $64, $61, $72
ds 9, $20
db $50, $48, $4F, $4E, $45, $20, $20, $4F, $50, $54, $49, $4F, $4E, $53, $20, $20
db $20, $20, $20, $45, $64, $69, $74, $61, $62, $6C, $65, $20, $20, $4E, $75, $6D
db $62, $65, $72, $20, $20, $20, $20, $20, $20, $20, $20, $54, $6F, $75, $63, $68
db $70, $61, $64
ds 11, $20
db $43, $4F, $4E, $56, $45, $52, $53, $49, $4F, $4E
ds 10, $20
db $54, $6F, $20, $20, $4D, $65, $74, $72, $69, $63
ds 9, $20
db $46, $72, $6F, $6D, $20, $20, $4D, $65, $74, $72, $69, $63, $20, $20, $20, $20
db $20, $20, $20, $52, $45, $43, $4F, $52, $44, $20, $4F, $50, $54, $49, $4F, $4E
db $53
ds 9, $20
db $44, $61, $74, $61, $62, $61, $73, $65
ds 11, $20
db $50, $68, $6F, $6E, $65, $20, $42, $6F, $6F, $6B, $20, $20, $20, $20, $20, $44
db $61, $74, $65, $20, $20, $20, $2F, $20, $20, $2F, $00, $54, $69, $6D, $65, $64
db $20, $41, $70, $70, $6F, $69, $6E, $74, $6D, $65, $6E, $74, $3F, $59, $4E, $00
db $54, $69, $6D, $65, $20, $20, $20, $3A, $00, $4D, $75, $73, $69, $63, $61, $6C
db $3F, $59, $4E, $00, $50, $72, $65, $73, $73, $20, $31, $20, $32, $20, $33, $20
db $6F, $72, $20, $34, $00, $31, $20, $42, $65, $65, $70, $65, $72, $20, $41, $6C
db $61, $72, $6D, $00, $32, $20, $42, $69, $72, $74, $68, $64, $61, $79, $00, $33
db $20, $43, $68, $72, $69, $73, $74, $6D, $61, $73, $00, $34, $20, $50, $72, $69
db $6F, $72, $69, $74, $79, $00, $43, $6F, $75, $6E, $74, $64, $6F, $77, $6E, $3F
db $59, $4E, $00, $4E, $75, $6D, $62, $65, $72, $20, $6F, $66, $20, $64, $61, $79
db $73, $3F, $28, $31, $2D, $37, $29, $00, $43, $6C, $65, $61, $72, $20, $61, $70
db $70, $6F, $69, $6E, $74, $6D, $65, $6E, $74, $3F, $59, $4E, $00, $4E, $65, $78
db $74, $20, $50, $72, $65, $76, $69, $6F, $75, $73, $20, $45, $78, $69, $74, $00
db $4A, $61, $6E, $75, $61, $72, $79, $00, $46, $65, $62, $72, $75, $61, $72, $79
db $00, $4D, $61, $72, $63, $68, $00, $41, $70, $72, $69, $6C, $00, $4D, $61, $79
db $00, $4A, $75, $6E, $65, $00, $4A, $75, $6C, $79, $00, $41, $75, $67, $75, $73
db $74, $00, $53, $65, $70, $74, $65, $6D, $62, $65, $72, $00, $4F, $63, $74, $6F
db $62, $65, $72, $00, $4E, $6F, $76, $65, $6D, $62, $65, $72, $00, $44, $65, $63
db $65, $6D, $62, $65, $72, $00, $73, $74, $6E, $64, $72, $64, $74, $68, $4E, $6F
db $20, $63, $6F, $75, $6E, $74, $64, $6F, $77, $6E, $2E, $00, $43, $6F, $75, $6E
db $74, $64, $6F, $77, $6E, $3A, $00, $31, $20, $64, $61, $79, $00, $64, $61, $79
db $73, $00, $4E, $6F, $20, $41, $6C, $61, $72, $6D, $2E, $20, $00, $42, $65, $65
db $70, $65, $72, $20, $41, $6C, $61, $72, $6D, $2E, $00, $42, $69, $72, $74, $68
db $64, $61, $79, $20, $41, $6C, $61, $72, $6D, $2E, $00, $43, $68, $72, $69, $73
db $74, $6D, $61, $73, $20, $41, $6C, $61, $72, $6D, $2E, $00, $50, $72, $69, $6F
db $72, $69, $74, $79, $20, $41, $6C, $61, $72, $6D, $2E, $00, $20, $20, $20, $45
db $52, $52, $4F, $52, $20, $20, $20, $20, $20, $20, $20, $41, $75, $74, $6F, $6D
db $6F, $74, $69, $76, $65, $20, $20, $20, $20, $20, $20, $20, $20, $42, $61, $6E
db $6B, $69, $6E, $67, $2F, $46, $69, $6E, $61, $6E, $63, $65, $20, $20, $20, $20
db $42, $65, $61, $75, $74, $79, $2F, $48, $65, $61, $6C, $74, $68, $63, $61, $72
db $65, $20, $20, $20, $20, $20, $43, $6F, $6D, $6D, $75, $6E, $69, $63, $61, $74
db $69, $6F, $6E, $20, $20, $20, $20, $20, $20, $20, $44, $61, $74, $65, $73, $2F
db $57, $65, $61, $74, $68, $65, $72, $20, $20, $20, $20, $20, $20, $20, $45, $6E
db $74, $65, $72, $74, $61, $69, $6E, $6D, $65, $6E, $74, $20, $20, $20, $20, $20
db $47, $65, $6E, $65, $72, $61, $6C, $2F, $47, $72, $65, $65, $74, $69, $6E, $67
db $73, $20, $20, $20, $20, $20, $20, $20, $20, $48, $6F, $74, $65, $6C
ds 10, $20
db $4D, $65, $64, $69, $63, $61, $6C, $2F, $45, $6D, $65, $72, $67, $65, $6E, $63
db $79, $20, $20, $20, $20, $52, $65, $73, $74, $61, $75, $72, $61, $6E, $74, $73
db $2F, $46, $6F, $6F, $64, $20, $20, $20, $53, $68, $6F, $70, $70, $69, $6E, $67
db $2F, $50, $65, $72, $73, $6F, $6E, $61, $6C, $20, $20, $20, $20, $20, $20, $53
db $69, $67, $68, $74, $73, $65, $65, $69, $6E, $67
ds 11, $20
db $53, $70, $6F, $72, $74, $73
ds 14, $20
db $54, $72, $61, $76, $65, $6C, $20, $20, $20, $20, $20, $20, $20, $20, $4E, $45
db $58, $54, $20, $50, $52, $45, $56, $49, $4F, $55, $53, $20, $53, $45, $4C, $45
db $43, $54, $00, $56, $69, $65, $77, $20, $43, $6C, $6F, $63, $6B, $00, $53, $65
db $74, $20, $54, $69, $6D, $65, $00, $53, $65, $74, $20, $41, $6C, $61, $72, $6D
db $00, $43, $6C, $65, $61, $72, $20, $41, $6C, $61, $72, $6D, $00, $3A, $20, $20
db $3A, $00, $41, $6C, $61, $72, $6D, $20, $20, $20, $3A, $00, $20, $20, $20, $20
db $20, $56, $69, $65, $77, $20, $20, $64, $61, $74, $65, $20, $20

; 30th entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 861E to 86C7 (170 bytes)
_DATA_861E_:
db $20, $20, $20, $20, $53, $65, $74, $20, $64, $61, $74, $65
ds 10, $20
db $45, $4E, $54, $45, $52, $20, $41, $4D, $4F, $55, $4E, $54, $20, $20, $20, $20
db $50, $52, $45, $53, $53, $20, $41, $20, $20, $4B, $45, $59, $00, $49, $6E, $63
db $68, $65, $73, $20, $74, $6F, $20, $43, $6D, $00, $46, $65, $65, $74, $20, $74
db $6F, $20, $4D, $65, $74, $65, $72, $73, $00, $59, $61, $72, $64, $73, $20, $74
db $6F, $20, $4D, $65, $74, $65, $72, $73, $00, $4D, $69, $6C, $65, $73, $20, $74
db $6F, $20, $4B, $69, $6C, $6F, $6D, $65, $74, $65, $72, $73, $00, $41, $63, $72
db $65, $73, $20, $74, $6F, $20, $48, $65, $63, $74, $61, $72, $65, $73, $00, $46
db $6C, $75, $69, $64, $20, $4F, $7A, $20, $74, $6F, $20, $4C, $69, $74, $65, $72
db $73, $00, $51, $75, $61, $72, $74, $73, $20, $74, $6F, $20, $4C, $69, $74, $65
db $72, $73, $00, $55

; 31st entry of Pointer Table from 388F (indexed by _RAM_C19D_)
; Data from 86C8 to 9A37 (4976 bytes)
_DATA_86C8_:
db $53, $20, $47, $61, $6C, $6C, $6F, $6E, $73, $20, $74, $6F, $20, $4C, $69, $74
db $65, $72, $73, $00, $47, $61, $6C, $6C, $6F, $6E, $73, $20, $74, $6F, $20, $4C
db $69, $74, $65, $72, $73, $00, $4F, $75, $6E, $63, $65, $73, $20, $74, $6F, $20
db $47, $72, $61, $6D, $73, $00, $50, $6F, $75, $6E, $64, $73, $20, $74, $6F, $20
db $4B, $69, $6C, $6F, $67, $72, $61, $6D, $73, $00, $54, $6F, $6E, $73, $20, $74
db $6F, $20, $54, $6F, $6E, $6E, $65, $73, $00, $43, $6D, $20, $74, $6F, $20, $49
db $6E, $63, $68, $65, $73, $00, $4D, $65, $74, $65, $72, $73, $20, $74, $6F, $20
db $46, $65, $65, $74, $00, $4D, $65, $74, $65, $72, $73, $20, $74, $6F, $20, $59
db $61, $72, $64, $73, $00, $4B, $69, $6C, $6F, $6D, $65, $74, $65, $72, $73, $20
db $74, $6F, $20, $4D, $69, $6C, $65, $73, $00, $48, $65, $63, $74, $61, $72, $65
db $73, $20, $74, $6F, $20, $41, $63, $72, $65, $73, $00, $4C, $69, $74, $65, $72
db $73, $20, $74, $6F, $20, $46, $6C, $75, $69, $64, $20, $4F, $7A, $00, $4C, $69
db $74, $65, $72, $73, $20, $74, $6F, $20, $51, $75, $61, $72, $74, $73, $00, $4C
db $69, $74, $65, $72, $73, $20, $74, $6F, $20, $55, $53, $20, $47, $61, $6C, $6C
db $6F, $6E, $73, $00, $4C, $69, $74, $65, $72, $73, $20, $74, $6F, $20, $47, $61
db $6C, $6C, $6F, $6E, $73, $00, $47, $72, $61, $6D, $73, $20, $74, $6F, $20, $4F
db $75, $6E, $63, $65, $73, $00, $4B, $69, $6C, $6F, $67, $72, $61, $6D, $73, $20
db $74, $6F, $20, $50, $6F, $75, $6E, $64, $73, $00, $54, $6F, $6E, $6E, $65, $73
db $20, $74, $6F, $20, $54, $6F, $6E, $73, $00, $20, $20, $4E, $6F, $20, $6D, $61
db $74, $63, $68, $20, $66, $6F, $75, $6E, $64, $2E, $20, $20, $20, $00, $41, $6E
db $79, $20, $6B, $65, $79, $20, $74, $6F, $20, $63, $6F, $6E, $74, $69, $6E, $75
db $65, $2E, $00, $84, $98, $44, $65, $75, $74, $73, $63, $68, $6D, $61, $72, $6B
db $73, $00, $C6, $98, $44, $6F, $6C, $6C, $61, $72, $73, $00, $07, $99, $46, $72
db $61, $6E, $63, $73, $00, $48, $99, $4C, $69, $72, $61, $00, $86, $99, $50, $65
db $73, $65, $74, $61, $73, $00, $C7, $99, $50, $6F, $75, $6E, $64, $73, $00, $08
db $9A, $59, $65, $6E, $00, $0E, $20, $20, $20, $20, $44, $65, $75, $74, $73, $63
db $68, $6D, $61, $72, $6B, $73, $20, $20, $20, $20, $09, $20, $20, $20, $20, $20
db $20, $44, $6F, $6C, $6C, $61, $72, $73, $20, $20, $20, $20, $20, $20, $20, $08
db $20, $20, $20, $20, $20, $20, $20, $46, $72, $61, $6E, $63, $73, $20, $20, $20
db $20, $20, $20, $20, $06, $20, $20, $20, $20, $20, $20, $20, $20, $4C, $69, $72
db $61, $20, $20, $20, $20, $20, $20, $20, $20, $09, $20, $20, $20, $20, $20, $20
db $50, $65, $73, $65, $74, $61, $73, $20, $20, $20, $20, $20, $20, $20, $08, $20
db $20, $20, $20, $20, $20, $20, $50, $6F, $75, $6E, $64, $73, $20, $20, $20, $20
db $20, $20, $20, $05, $20, $20, $20, $20, $20, $20, $20, $20, $59, $65, $6E
ds 9, $20
db $04, $44, $65, $75, $74, $73, $63, $68, $6D, $61, $72, $6B, $73, $00, $06, $44
db $6F, $6C, $6C, $61, $72, $73, $00, $07, $46, $72, $61, $6E, $63, $73, $00, $08
db $4C, $69, $72, $61, $00, $06, $50, $65, $73, $65, $74, $61, $73, $00, $07, $50
db $6F, $75, $6E, $64, $73, $00, $08, $59, $65, $6E, $00, $43, $4F, $4E, $56, $45
db $52, $54, $20, $46, $52, $4F, $4D, $00, $20, $43, $4F, $4E, $56, $45, $52, $54
db $20, $54, $4F, $20, $00, $20, $20, $20, $20, $45, $4E, $54, $45, $52, $20, $41
db $4D, $4F, $55, $4E, $54, $20, $20, $20, $20, $20, $20, $20, $45, $4E, $54, $45
db $52, $20, $54, $48, $45, $20, $52, $41, $54, $45, $20, $20, $20, $20, $20, $41
db $4D, $4F, $55, $4E, $54, $20, $20, $47, $49, $56, $45, $4E, $20, $49, $4E, $20
db $20, $20, $20, $20, $20, $43, $4F, $4E, $54, $52, $4F, $4C, $20, $4D, $45, $4E
db $55, $20, $20, $20, $20, $20, $43, $4C, $45, $41, $52, $20, $20, $41, $4C, $4C
db $20, $52, $45, $43, $4F, $52, $44, $53, $20, $20, $20, $20, $20, $20, $20, $53
db $45, $54, $20, $48, $4F, $4D, $45, $20, $20, $20, $20, $20, $20, $50, $52, $45
db $53, $53, $20, $59, $20, $54, $4F, $20, $43, $4F, $4E, $46, $49, $52, $4D, $00
db $41, $4E, $59, $20, $4F, $54, $48, $45, $52, $20, $4B, $45, $59, $20, $41, $42
db $4F, $52, $54, $53, $00, $20, $20, $20, $20, $47, $49, $56, $45, $20, $42, $41
db $4C, $41, $4E, $43, $45, $20, $20, $20, $20, $20, $20, $43, $55, $52, $52, $45
db $4E, $54, $20, $20, $42, $41, $4C, $41, $4E, $43, $45, $20, $20, $20, $20, $20
db $20, $56, $49, $45, $57, $20, $52, $45, $43, $4F, $52, $44, $53, $20, $20, $20
db $20, $20, $20, $20, $20, $45, $4E, $54, $45, $52, $20, $52, $45, $43, $4F, $52
db $44, $20, $20, $20, $20, $20, $4E, $4F, $20, $52, $45, $43, $4F, $52, $44, $53
db $20, $00
ds 12, $20
db $00, $56, $49, $45, $57, $20, $52, $45, $43, $4F, $52, $44, $53, $00, $20, $50
db $4C, $45, $41, $53, $45, $20, $20, $45, $4E, $54, $45, $52, $20, $44, $41, $54
db $45, $20, $2F, $20, $20, $2F, $00, $20, $45, $4E, $54, $45, $52, $20, $54, $48
db $45, $20, $41, $4D, $4F, $55, $4E, $54, $20, $00, $20, $43, $52, $45, $44, $49
db $54, $20, $4F, $52, $20, $20, $44, $45, $42, $49, $54, $20, $00, $20, $20, $20
db $20, $20, $20, $20, $43, $52, $45, $44, $49, $54, $20, $20, $20, $20, $20, $20
db $20, $44, $45, $42, $49, $54, $20, $20, $20, $20, $20, $20, $20, $20, $44, $45
db $42, $49, $54, $20, $00, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $00, $45, $4E
db $54, $45, $52, $20, $20, $44, $45, $53, $43, $52, $49, $50, $54, $49, $4F, $4E
db $00, $4E, $65, $78, $74, $8C, $50, $72, $65, $76, $69, $6F, $75, $73, $8C, $51
db $75, $69, $74, $00, $20, $20, $52, $65, $63, $6F, $72, $64, $20, $6E, $75, $6D
db $62, $65, $72, $20, $78, $78, $20, $20, $4E, $61, $6D, $65, $20, $61, $6E, $64
db $20, $41, $64, $64, $72, $65, $73, $73, $00, $54, $65, $6C, $65, $70, $68, $6F
db $6E, $65, $20, $4E, $75, $6D, $62, $65, $72, $00, $45, $6E, $74, $65, $72, $20
db $6E, $75, $6D, $62, $65, $72, $20, $74, $6F, $20, $64, $69, $61, $6C, $00, $20
db $50, $6C, $65, $61, $73, $65, $20, $74, $79, $70, $65, $20, $6E, $75, $6D, $62
db $65, $72, $20, $4E, $6F, $77, $20, $64, $69, $61, $6C, $69, $6E, $67, $20, $6E
db $75, $6D, $62, $65, $72, $00, $20, $20, $20, $45, $53, $43, $41, $50, $45, $20
db $54, $4F, $20, $45, $58, $49, $54, $20, $20, $20, $20, $20, $20, $50, $52, $45
db $53, $53, $20, $41, $4E, $59, $20, $4B, $45, $59, $20, $20, $00, $45, $6E, $67
db $6C, $69, $73, $68, $00, $47, $65, $72, $6D, $61, $6E, $00, $46, $72, $65, $6E
db $63, $68, $00, $53, $70, $61, $6E, $69, $73, $68, $00, $49, $74, $61, $6C, $69
db $61, $6E, $00, $20, $4A, $41, $4E, $55, $41, $52, $59, $20, $1F, $20, $46, $45
db $42, $52, $55, $41, $52, $59, $1C, $20, $20, $4D, $41, $52, $43, $48, $20, $20
db $1F, $20, $20, $41, $50, $52, $49, $4C, $20, $20, $1E, $20, $20, $20, $4D, $41
db $59, $20, $20, $20, $1F, $20, $20, $20, $4A, $55, $4E, $45, $20, $20, $1E, $20
db $20, $20, $4A, $55, $4C, $59, $20, $20, $1F, $20, $20, $41, $55, $47, $55, $53
db $54, $20, $1F, $53, $45, $50, $54, $45, $4D, $42, $45, $52, $1E, $20, $4F, $43
db $54, $4F, $42, $45, $52, $20, $1F, $20, $4E, $4F, $56, $45, $4D, $42, $45, $52
db $1E, $20, $44, $45, $43, $45, $4D, $42, $45, $52, $1F, $53, $55, $4E, $4D, $4F
db $4E, $54, $55, $45, $57, $45, $44, $54, $48, $55, $46, $52, $49, $53, $41, $54
db $53, $55, $4E, $20, $20, $20, $42, $3D, $4E, $65, $78, $74, $20, $20, $41, $3D
db $45, $78, $69, $74, $20, $20, $20, $00, $53, $65, $6C, $65, $63, $74, $3D, $50
db $72, $65, $76, $69, $6F, $75, $73, $00, $4D, $61, $6B, $65, $20, $20, $20, $20
db $43, $6C, $65, $61, $72, $20, $20, $20, $45, $64, $69, $74, $00, $20, $50, $52
db $45, $53, $53, $20, $59, $20, $54, $4F, $20, $43, $4F, $4E, $46, $49, $52, $4D
db $20, $00, $41, $4E, $59, $20, $4F, $54, $48, $45, $52, $20, $4B, $45, $59, $20
db $41, $42, $4F, $52, $54, $53, $00, $2A, $43, $48, $45, $43, $4B, $20, $41, $50
db $50, $4F, $49, $4E, $54, $4D, $45, $4E, $54, $53, $2A, $00, $20, $20, $43, $48
db $4F, $4F, $53, $45, $20, $20, $4C, $41, $4E, $47, $55, $41, $47, $45, $20, $20
db $20, $20, $20, $42, $41, $43, $4B, $55, $50, $20, $4F, $50, $54, $49, $4F, $4E
db $53, $20, $20, $20, $20, $20, $20, $44, $4F, $57, $4E, $4C, $4F, $41, $44, $20
db $54, $4F, $20, $50, $43, $20, $20, $20, $20, $20, $20, $55, $50, $4C, $4F, $41
db $44, $20, $46, $52, $4F, $4D, $20, $50, $43, $20, $20, $20, $20, $20, $20, $20
db $43, $4F, $4E, $54, $52, $4F, $4C, $20, $4D, $45, $4E, $55
ds 9, $20
db $50, $48, $4F, $4E, $45, $20, $42, $4F, $4F, $4B
ds 9, $20
db $41, $50, $50, $4F, $49, $4E, $54, $4D, $45, $4E, $54, $53
ds 9, $20
db $43, $41, $4C, $43, $55, $4C, $41, $54, $4F, $52
ds 11, $20
db $44, $41, $54, $41, $42, $41, $53, $45, $20, $20, $20, $20, $20, $20, $20, $53
db $65, $61, $72, $63, $68, $65, $64, $20, $74, $6F, $20, $65, $6E, $64, $20, $6F
db $66, $20, $00, $20, $64, $61, $74, $61, $20, $50, $72, $65, $73, $73, $20, $61
db $6E, $79, $20, $6B, $65, $79, $20, $00, $20, $20, $20, $53, $45, $41, $52, $43
db $48, $20, $4F, $50, $54, $49, $4F, $4E, $53, $20, $20, $20, $00, $20, $20, $20
db $47, $6C, $6F, $62, $61, $6C, $20, $20, $53, $65, $61, $72, $63, $68, $20, $20
db $20, $00, $20, $20, $53, $70, $65, $63, $69, $66, $69, $63, $20, $20, $53, $65
db $61, $72, $63, $68, $20, $20, $00, $54, $69, $6D, $65, $2F, $44, $61, $74, $65
db $20, $57, $72, $6F, $6E, $67, $00, $42, $61, $74, $74, $65, $72, $69, $65, $73
db $20, $6C, $6F, $77, $3F, $00, $20, $20, $20, $20, $20, $20, $43, $55, $52, $52
db $45, $4E, $43, $59
ds 11, $20
db $43, $48, $45, $43, $4B, $42, $4F, $4F, $4B, $20, $20, $20, $20, $20, $20, $4E
db $6F, $20, $64, $65, $20, $64, $69, $72, $65, $63, $63, $2E, $20, $3A, $20, $20
db $20, $20, $20, $00, $4E, $6F, $20, $64, $65, $20, $63, $69, $74, $61, $20, $20
db $20, $20, $3A, $20, $20, $20, $20, $20, $00, $4E, $6F, $20, $64, $65, $20, $72
db $65, $67, $2E, $20, $20, $20, $20, $3A, $20, $20, $20, $20, $20, $00, $68, $61
db $4C, $6C, $61, $20, $48, $61, $63, $65, $20, $42, $6F, $72, $72, $20, $45, $64
db $69, $74, $00, $50, $72, $6F, $78, $20, $41, $6E, $74, $65, $72, $69, $6F, $72
db $20, $20, $53, $61, $6C, $69, $72, $00, $50, $55, $4C, $53, $41, $52, $20, $43
db $55, $41, $4C, $51, $20, $54, $45, $43, $4C, $41, $00, $28, $63, $29, $20, $31
db $39, $39, $32, $00, $4D, $6F, $6E, $74, $61, $67, $75, $65, $2D, $57, $65, $73
db $74, $6F, $6E, $2E, $00, $43, $6F, $6E, $20, $6C, $69, $63, $65, $6E, $63, $69
db $61, $00, $65, $78, $63, $6C, $75, $73, $69, $76, $61, $6D, $65, $6E, $74, $65
db $20, $61, $00, $20, $20, $46, $61, $62, $74, $65, $6B, $2C, $20, $49, $6E, $63
db $2E, $20, $20, $00, $56, $65, $72, $73, $69, $6F, $6E, $20, $35, $2E, $37, $34
db $00, $4C, $69, $63, $65, $6E, $63, $69, $61, $20, $64, $61, $64, $61, $00, $70
db $6F, $72, $20, $4E, $69, $6E, $74, $65, $6E, $64, $6F, $00, $49, $6E, $67, $72
db $20, $63, $61, $64, $65, $6E, $61, $20, $64, $65, $20, $62, $75, $73, $71, $49
db $4E, $47, $52, $20, $43, $41, $44, $45, $4E, $41, $20, $44, $45, $20, $42, $55
db $53, $51, $20, $20, $42, $55, $53, $51, $55, $45, $44, $41, $20, $20, $41, $4C
db $20, $46, $49, $4E, $20, $20, $20, $50, $55, $4C, $53, $41, $52, $20, $43, $55
db $41, $4C, $51, $20, $54, $45, $43, $4C, $41, $20, $00, $20, $20, $20, $42, $75
db $73, $63, $61, $20, $4C, $65, $6E, $67, $75, $61, $6A, $65, $20, $20, $20, $42
db $75, $73, $63, $61, $20, $68, $61, $73, $74, $61, $20, $66, $69, $6E, $20, $64
db $65, $00, $6C, $6F, $73, $20, $64, $61, $74, $6F, $73, $2E, $4E, $6F, $20, $68
db $61, $6C, $6C, $61, $2E, $00, $50, $75, $6C, $73, $61, $72, $20, $63, $75, $61
db $6C, $71, $20, $74, $65, $63, $6C, $61, $00, $20, $20, $50, $72, $6F, $78, $69
db $6D, $61, $20, $20, $20, $53, $61, $6C, $69, $64, $61, $20, $20, $00, $20, $20
db $50, $52, $4F, $58, $49, $4D, $41, $20, $20, $20, $53, $41, $4C, $49, $44, $41
db $20, $20, $00, $20, $20, $20, $4D, $49, $4E, $49, $54, $52, $41, $44, $55, $43
db $54, $4F, $52, $20, $20, $20, $20, $20, $20, $20, $48, $61, $6C, $6C, $61, $20
db $20, $70, $61, $6C, $61, $62, $72, $61, $20, $20, $20, $20, $20, $20, $20, $56
db $65, $72, $20, $20, $74, $69, $74, $75, $6C, $6F, $73
ds 11, $20
db $53, $61, $6C, $69, $64, $61
ds 10, $20
db $46, $55, $4E, $43, $20, $4D, $55, $4E, $44, $49, $41, $4C, $45, $53, $20, $20
db $20, $20, $20, $20, $4D, $69, $6E, $69, $74, $72, $61, $64, $75, $63, $74, $6F
db $72, $20, $20, $20, $20, $20, $20, $20, $4D, $61, $70, $61, $20, $64, $65, $6C
db $20, $6D, $75, $6E, $64, $6F, $20, $20, $20, $20, $20, $46, $55, $4E, $43, $49
db $4F, $4E, $45, $53, $20, $20, $46, $45, $43, $48, $41
ds 9, $20
db $43, $69, $74, $61, $73
ds 13, $20
db $43, $61, $6C, $65, $6E, $64, $61, $72, $69, $6F, $20, $20, $20, $20, $20, $20
db $4F, $50, $43, $49, $4F, $4E, $45, $53, $20, $20, $54, $45, $4C, $45, $46, $4F
db $4E, $4F, $20, $20, $20, $4E, $75, $6D, $65, $72, $6F, $20, $20, $65, $64, $69
db $74, $61, $62, $6C, $65, $20, $20, $20, $50, $61, $6E, $65, $6C, $20, $64, $65
db $20, $70, $75, $6C, $73, $61, $63, $69, $6F, $6E, $20, $20, $20, $20, $20, $20
db $43, $4F, $4E, $56, $45, $52, $53, $49, $4F, $4E
ds 10, $20
db $41, $20, $20, $6D, $65, $74, $72, $69, $63, $6F
ds 10, $20
db $44, $65, $20, $6D, $65, $74, $72, $69, $63, $6F, $20, $20, $20, $20, $20, $20
db $20, $4F, $50, $43, $49, $4F, $4E, $45, $53, $20, $20, $44, $45, $20, $52, $45
db $47, $20, $20, $20, $20, $20, $42, $61, $73, $65, $20, $20, $64, $65, $20, $64
db $61, $74, $6F, $73, $20, $20, $20, $20, $20, $4C, $69, $62, $72, $6F, $20, $20
db $64, $65, $20, $64, $69, $72, $65, $63, $63, $20, $20, $46, $65, $63, $68, $61
db $20, $20, $2F, $20, $20, $2F, $00, $43, $69, $74, $61, $20, $63, $6F, $6E, $63
db $65, $72, $74, $61, $64, $61, $3F, $53, $4E, $00, $48, $6F, $72, $61, $20, $20
db $20, $3A, $00, $4D, $75, $73, $69, $63, $61, $6C, $3F, $53, $4E, $00, $50, $75
db $6C, $73, $61, $72, $20, $31, $20, $32, $20, $33, $20, $6F, $20, $34, $00, $31
db $20, $41, $6C, $61, $72, $6D, $61, $20, $61, $76, $69, $73, $61, $64, $6F, $72
db $00, $32, $20, $43, $75, $6D, $70, $6C, $65, $61, $6E, $6F, $73, $00, $33, $20
db $4E, $61, $76, $69, $64, $61, $64, $00, $34, $20, $50, $72, $69, $6F, $72, $69
db $64, $61, $64, $00, $43, $75, $65, $6E, $74, $61, $20, $61, $74, $72, $61, $73
db $3F, $53, $4E, $00, $4E, $75, $6D, $65, $72, $6F, $20, $64, $65, $20, $64, $69
db $61, $73, $3F, $28, $31, $2D, $37, $29, $00, $42, $6F, $72, $72, $61, $72, $20
db $63, $69, $74, $61, $3F, $53, $4E, $00, $50, $72, $6F, $78, $20, $53, $61, $6C
db $69, $64, $61, $20, $50, $72, $65, $76, $69, $61, $00, $45, $6E, $65, $72, $6F
db $00, $46, $65, $62, $72, $65, $72, $6F, $00, $4D, $61, $72, $7A, $6F, $00, $41
db $70, $72, $69, $6C, $00, $4D, $61, $79, $6F, $00, $4A, $75, $6E, $69, $6F, $00
db $4A, $75, $6C, $69, $6F, $00, $41, $67, $6F, $73, $74, $6F, $00, $53, $65, $70
db $74, $69, $65, $6D, $62, $72, $65, $00, $4F, $63, $74, $75, $62, $72, $65, $00
db $4E, $6F, $76, $69, $65, $6D, $62, $72, $65, $00, $44, $69, $63, $69, $65, $6D
db $62, $72, $65, $00, $6F, $20, $6F, $20, $6F, $20, $6F, $20, $4E, $6F, $20, $63
db $75, $65, $6E, $74, $61, $20, $61, $74, $72, $61, $73, $00, $43, $75, $65, $6E
db $74, $61, $20, $61, $74, $72, $61, $73, $20, $00, $31, $20, $64, $69, $61, $00
db $64, $69, $61, $73, $00, $53, $69, $6E, $20, $61, $6C, $61, $72, $6D, $61, $2E
db $00, $41, $6C, $61, $72, $6D, $61, $20, $61, $76, $69, $73, $61, $64, $6F, $72
db $2E, $00, $41, $6C, $61, $72, $6D, $61, $20, $63, $75, $6D, $70, $6C, $65, $61
db $6E, $6F, $73, $2E, $00, $41, $6C, $61, $72, $6D, $61, $20, $6E, $61, $76, $69
db $64, $61, $64, $2E, $00, $41, $6C, $61, $72, $6D, $61, $20, $70, $72, $69, $6F
db $72, $69, $64, $61, $64, $2E, $00, $20, $20, $20, $45, $52, $52, $4F, $52, $20
db $20, $20, $20, $20, $20, $20, $20, $41, $75, $74, $6F, $6D, $6F, $74, $6F, $72
ds 9, $20
db $42, $61, $6E, $63, $6F, $73, $2F, $46, $69, $6E, $61, $6E, $7A, $61, $73, $20
db $20, $20, $20, $20, $20, $42, $65, $6C, $6C, $65, $7A, $61, $2F, $53, $61, $6C
db $75, $64, $20, $20, $20, $20, $20, $20, $20, $43, $6F, $6D, $75, $6E, $69, $63
db $61, $63, $69, $6F, $6E, $20, $20, $20, $20, $20, $20, $20, $20, $46, $65, $63
db $68, $61, $73, $2F, $54, $69, $65, $6D, $70, $6F, $20, $20, $20, $20, $20, $20
db $45, $6E, $74, $72, $65, $74, $65, $6E, $69, $6D, $69, $65, $6E, $74, $6F, $20
db $20, $20, $20, $20, $47, $65, $6E, $65, $72, $61, $6C, $2F, $53, $61, $6C, $75
db $64, $6F, $73, $20, $20, $20, $20, $20, $20, $20, $20, $48, $6F, $74, $65, $6C
ds 11, $20
db $4D, $65, $64, $69, $63, $6F, $2F, $45, $6D, $65, $72, $67, $65, $6E, $63, $69
db $61, $20, $52, $65, $73, $74, $61, $75, $72, $61, $6E, $74, $65, $73, $2F, $43
db $6F, $6D, $69, $64, $61, $73, $20, $20, $43, $6F, $6D, $70, $72, $61, $73, $2F
db $50, $65, $72, $73, $6F, $6E, $61, $6C, $20, $20, $20, $4C, $75, $67, $61, $72
db $65, $73, $20, $64, $65, $20, $69, $6E, $74, $65, $72, $65, $73, $20, $20, $20
db $20, $20, $20, $20, $44, $65, $70, $6F, $72, $74, $65, $73
ds 13, $20
db $56, $69, $61, $6A, $65, $73, $20, $20, $20, $20, $20, $20, $20, $50, $52, $4F
db $58, $20, $41, $4E, $54, $45, $53, $20, $20, $53, $45, $4C, $45, $43, $49, $4F
db $4E, $00, $56, $65, $72, $20, $72, $65, $6C, $6F, $6A, $00, $50, $6F, $6E, $65
db $72, $20, $6C, $61, $20, $68, $6F, $72, $61, $00, $50, $6F, $6E, $65, $72, $20
db $6C, $61, $20, $61, $6C, $61, $72, $6D, $61, $00, $42, $6F, $72, $72, $61, $72
db $20, $6C, $61, $20, $61, $6C, $61, $72, $6D, $61, $00, $3A, $20, $20, $3A, $00
db $41, $6C, $61, $72, $6D, $61, $20, $20, $3A, $00, $20, $20, $20, $20, $20, $56
db $65, $72, $20, $20, $66, $65, $63, $68, $61, $20, $20, $20, $20, $20, $20, $20
db $20, $44, $69, $73, $70, $6F, $6E, $65, $72, $20, $66, $65, $63, $68, $61, $20
db $20, $20, $20, $49, $4E, $47, $52, $45, $53, $41, $52, $20, $20, $43, $41, $4E
db $54, $49, $44, $41, $44, $20, $20, $50, $55, $4C, $53, $41, $52, $20, $55, $4E
db $41, $20, $54, $45, $43, $4C, $41, $20, $00, $50, $75, $6C, $67, $61, $64, $61
db $73, $20, $61, $20, $63, $6D, $00, $50, $69, $65, $73, $20, $61, $20, $6D, $65
db $74, $72, $6F, $73, $00, $59, $61, $72, $64, $61, $73, $20, $61, $20, $6D, $65
db $74, $72, $6F, $73, $00, $4D, $69, $6C, $6C, $61, $73, $20, $61, $20, $6B, $69
db $6C, $6F, $6D, $65, $74, $72, $6F, $73, $00, $41, $63, $72, $65, $73, $20, $61
db $20, $68, $65, $63, $74, $61, $72, $65, $61, $73, $00, $4F, $6E, $7A, $61, $73
db $20, $6C, $69, $71, $20, $61, $20, $6C, $69, $74, $72, $6F, $73, $00, $43, $75
db $61, $72, $74, $6F, $20, $67, $61, $6C, $6E, $20, $61, $20, $6C, $69, $74, $72
db $6F, $73, $00, $47, $61, $6C, $6F, $6E, $20, $45, $45, $20, $55, $55, $20, $61
db $20, $6C, $69, $74, $72, $6F, $73, $00, $47, $61, $6C, $6F, $6E, $65, $73, $20
db $61, $20, $6C, $69, $74, $72, $6F, $73, $00, $4F, $6E, $7A, $61, $73, $20, $61
db $20, $67, $72, $61, $6D, $6F, $73, $00, $4C, $69, $62, $72, $61, $73, $20, $61
db $20, $6B, $69, $6C, $6F, $67, $72, $61, $6D, $6F, $73, $00, $54, $6F, $6E, $20
db $62, $72, $69, $74, $20, $61, $20, $6D, $65, $74, $72, $69, $63, $61, $73, $00
db $43, $6D, $20, $61, $20, $70, $75, $6C, $67, $61, $64, $61, $73, $00, $4D, $65
db $74, $72, $6F, $73, $20, $61, $20, $70, $69, $65, $73, $00, $4D, $65, $74, $72
db $6F, $73, $20, $61, $20, $79, $61, $72, $64, $61, $73, $00, $4B, $69, $6C, $6F
db $6D, $65, $74, $72, $6F, $73, $20, $61, $20, $6D, $69, $6C, $6C, $61, $73, $00
db $48, $65, $63, $74, $61, $72, $65, $61, $73, $20, $61, $20, $61, $63, $72, $65
db $73, $00, $4C, $69, $74, $72, $6F, $73, $20, $61, $20, $6F, $6E, $7A, $61, $73
db $20, $6C, $69, $71, $00, $4C, $69, $74, $72, $6F, $73, $20, $61, $20, $63, $75
db $61, $72, $74, $20, $67, $61, $6C, $6F, $6E, $00, $4C, $69, $74, $72, $6F, $73
db $20, $61, $20, $67, $61, $6C, $6F, $6E, $20, $45, $45, $20, $55, $55, $00, $4C
db $69, $74, $72, $6F, $73, $20, $61, $20, $67, $61, $6C, $6F, $6E, $65, $73, $00
db $47, $72, $61, $6D, $6F, $73, $20, $61, $20, $6F, $6E, $7A, $61, $73, $00, $4B
db $69, $6C, $6F, $67, $72, $61, $6D, $6F, $73, $20, $61, $20, $6C, $69, $62, $72
db $61, $73, $00, $54, $6F, $6E, $20, $6D, $65, $74, $72, $69, $63, $61, $73, $20
db $61, $20, $62, $72, $69, $74, $00, $4E, $6F, $20, $68, $61, $6C, $6C, $61, $20
db $63, $6F, $6E, $63, $6F, $72, $64, $61, $6E, $74, $65, $00, $43, $75, $61, $6C
db $71, $20, $74, $65, $63, $6C, $61, $20, $63, $6F, $6E, $74, $69, $6E, $75, $61
db $72, $00, $84, $98, $4D, $61, $72, $63, $6F, $73, $20, $41, $6C, $65, $6D, $61
db $6E, $65, $73, $00, $C6, $98, $44, $6F, $6C, $61, $72, $65, $73, $00, $07, $99
db $46, $72, $61, $6E, $63, $6F, $73, $00, $48, $99, $4C, $69, $72, $61, $00, $86
db $99, $50, $65, $73, $65, $74, $61, $73, $00, $C7, $99, $4C, $69, $62, $72, $61
db $73, $00, $08, $9A, $59, $65, $6E, $00, $12, $20, $20, $4D, $61, $72, $63, $6F
db $73, $20, $20, $41, $6C, $65, $6D, $61, $6E, $65, $73, $20, $20, $09, $20, $20
db $20, $20, $20, $20, $44, $6F, $6C, $61, $72, $65, $73, $20, $20, $20, $20, $20
db $20, $20, $09, $20, $20, $20, $20, $20, $20, $46, $72, $61, $6E, $63, $6F, $73
db $20, $20, $20, $20, $20, $20, $20, $06, $20, $20, $20, $20, $20, $20, $20, $20
db $4C, $69, $72, $61, $20, $20, $20, $20, $20, $20, $20, $20, $09, $20, $20, $20
db $20, $20, $20, $50, $65, $73, $65, $74, $61, $73, $20, $20, $20, $20, $20, $20
db $20, $08, $20, $20, $20, $20, $20, $20, $20, $4C, $69, $62, $72, $61, $73, $20
db $20, $20, $20, $20, $20, $20, $05, $20, $20, $20, $20, $20, $20, $20, $20, $59
db $65, $6E
ds 9, $20
db $04, $4D, $61, $72, $63, $6F, $73, $20, $41, $6C, $65, $6D, $61, $6E, $65, $73
db $00, $06, $44, $6F, $6C, $61, $72, $65, $73, $00, $07, $46, $72, $61, $6E, $63
db $6F, $73, $00, $08, $4C, $69, $72, $61, $00, $06, $50, $65, $73, $65, $74, $61
db $73, $00, $07, $4C, $69, $62, $72, $61, $73, $00, $08, $59, $65, $6E, $00, $43
db $4F, $4E, $56, $45, $52, $54, $49, $52, $20, $44, $45, $00, $43, $4F, $4E, $56
db $45, $52, $54, $49, $52, $20, $41, $00, $20, $49, $4E, $47, $52, $45, $53, $41
db $52, $20, $20, $43, $41, $4E, $54, $49, $44, $41, $44, $20, $20, $49, $4E, $47
db $52, $20, $54, $49, $50, $20, $44, $45, $20, $43, $41, $4D, $42, $49, $4F, $20
db $20, $43, $41, $4E, $54, $49, $44, $41, $44, $20, $45, $4E, $54, $52, $45, $47
db $41, $44, $41, $20, $20, $20, $20, $20, $4D, $45, $4E, $55, $20, $43, $4F, $4E
db $54, $52, $4F, $4C, $20, $20, $20, $20, $20, $42, $4F, $52, $52, $41, $52, $20
db $54, $4F, $44, $4F, $20, $52, $45, $47, $49, $53, $54, $20, $20, $20, $50, $4F
db $4E, $45, $52, $20, $20, $41, $4C, $20, $49, $4E, $49, $43, $49, $4F, $20, $20
db $50, $55, $4C, $53, $45, $20, $59, $20, $50, $41, $52, $41, $20, $43, $4F, $4E
db $46, $49, $52, $4D, $00, $54, $45, $43, $4C, $41, $20, $44, $49, $46, $45, $52
db $20, $41, $42, $41, $4E, $44, $4F, $4E, $41, $00, $20, $20, $20, $20, $44, $41
db $52, $20, $20, $42, $41, $4C, $41, $4E, $43, $45, $20, $20, $20, $20, $20, $20
db $20, $42, $41, $4C, $41, $4E, $43, $45, $20, $41, $43, $54, $55, $41, $4C, $20
db $20, $20, $20, $20, $20, $56, $45, $52, $20, $20, $52, $45, $47, $49, $53, $54
db $52, $4F, $53, $20, $20, $20, $20, $49, $4E, $47, $52, $45, $53, $41, $52, $20
db $52, $45, $47, $49, $53, $54, $52, $4F, $53, $20, $4E, $4F, $20, $52, $45, $47
db $49, $53, $54, $52, $4F, $53, $00
ds 12, $20
db $00, $56, $45, $52, $20, $20, $52, $45, $47, $49, $53, $54, $52, $4F, $53, $00
db $20, $20, $20, $49, $4E, $47, $52, $45, $53, $41, $52, $20, $46, $45, $43, $48
db $41, $20, $20, $20, $2F, $20, $20, $2F, $00, $49, $4E, $47, $52, $45, $53, $41
db $52, $20, $43, $41, $4E, $54, $49, $44, $41, $44, $00, $48, $41, $42, $45, $52
db $20, $4F, $20, $44, $45, $42, $45, $20, $20, $20, $20, $20, $00, $20, $20, $20
db $20, $20, $20, $20, $48, $41, $42, $45, $52
ds 16, $20
db $44, $45, $42, $45, $20, $20, $20, $20, $20, $20, $20, $20, $44, $45, $42, $45
db $00, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $00, $49, $4E, $47, $52, $45, $53
db $41, $52, $20, $44, $45, $53, $43, $52, $49, $50, $2E, $00, $8C, $50, $72, $6F
db $78, $8C, $41, $6E, $74, $65, $73, $8C, $53, $61, $6C, $69, $72, $8C, $00, $20
db $20, $4E, $75, $6D, $65, $72, $6F, $20, $64, $65, $20, $72, $65, $67, $20, $78
db $78, $20, $20, $4E, $6F, $6D, $62, $72, $65, $20, $79, $20, $64, $69, $72, $65
db $63, $63, $69, $6F, $6E, $00, $4E, $75, $6D, $65, $72, $6F, $20, $64, $65, $20
db $74, $65, $6C, $65, $66, $6F, $6E, $6F, $00, $49, $6E, $67, $72, $20, $6E, $75
db $6D, $65, $72, $6F, $20, $70, $20, $6D, $61, $72, $63, $61, $72, $00, $20, $20
db $20, $54, $65, $63, $6C, $65, $61, $72, $20, $6E, $75, $6D, $65, $72, $6F, $20
db $20, $20, $41, $68, $6F, $72, $61, $20, $6D, $61, $72, $63, $61, $72, $20, $65
db $6C, $20, $4E, $6F, $00, $20, $20, $45, $53, $43, $41, $50, $41, $52, $20, $41
db $20, $53, $41, $4C, $49, $44, $41, $20, $20, $50, $55, $4C, $53, $41, $52, $20
db $43, $55, $41, $4C, $51, $20, $54, $45, $43, $4C, $41, $00, $49, $6E, $67, $6C
db $65, $73, $00, $41, $6C, $65, $6D, $61, $6E, $00, $46, $72, $61, $6E, $63, $65
db $73, $00, $45, $73, $70, $61, $6E, $6F, $6C, $00, $49, $74, $61, $6C, $69, $61
db $6E

	ld   l, a
	nop
	jr   nz, _LABEL_9A5C_
	ld   b, l
	ld   l, [hl]
	ld   h, l
	ld   [hl], d
	ld   l, a
	jr   nz, _LABEL_9A63_
	rra
	jr   nz, _LABEL_9A8C_
	ld   h, l
	ld   h, d
	ld   [hl], d
	ld   h, l
	ld   [hl], d
	ld   l, a
	jr   nz, _LABEL_9A6A_
	jr   nz, _LABEL_9A70_
	ld   c, l
	ld   h, c
	ld   [hl], d
	ld   a, d
	ld   l, a
	jr   nz, _LABEL_9A77_
	rra
	jr   nz, _LABEL_9A7A_
	ld   b, c
	ld   h, d
_LABEL_9A5C_:
	ld   [hl], d
	ld   l, c
	ld   l, h
	jr   nz, @ + 34
	ld   e, $20
_LABEL_9A63_:
	jr   nz, _LABEL_9AB2_
	ld   h, c
	ld   a, c
	ld   l, a
	jr   nz, _LABEL_9A8A_
_LABEL_9A6A_:
	jr   nz, _LABEL_9A8B_
	jr   nz, _LABEL_9A8E_
	ld   c, d
	ld   [hl], l
_LABEL_9A70_:
	ld   l, [hl]
	ld   l, c
	ld   l, a
	jr   nz, _LABEL_9A95_
	ld   e, $20
_LABEL_9A77_:
	jr   nz, _LABEL_9AC3_
	ld   [hl], l
_LABEL_9A7A_:
	ld   l, h
	ld   l, c
	ld   l, a
	jr   nz, _LABEL_9A9F_
	rra
	jr   nz, _LABEL_9AC3_
	ld   h, a
	ld   l, a
	ld   [hl], e
	ld   [hl], h
	ld   l, a
	jr   nz, _LABEL_9AA9_
	rra
_LABEL_9A8A_:
	ld   d, e
_LABEL_9A8B_:
	ld   h, l
_LABEL_9A8C_:
	ld   [hl], b
	ld   [hl], h
_LABEL_9A8E_:
	daa
	ld   l, l
	ld   h, d
	ld   [hl], d
	ld   h, l
	ld   e, $20
_LABEL_9A95_:
	ld   c, a
	ld   h, e
	ld   [hl], h
	ld   [hl], l
	ld   h, d
	ld   [hl], d
	ld   h, l
	jr   nz, _LABEL_9ABD_
	ld   c, [hl]
_LABEL_9A9F_:
	ld   l, a
	halt
	ld   l, c
	ld   h, l
	ld   l, l
	ld   h, d
	ld   [hl], d
	ld   h, l
	ld   e, $44
_LABEL_9AA9_:
	ld   l, c
	ld   h, e
	ld   l, c
	ld   h, l
	ld   l, l
	ld   h, d
	ld   [hl], d
	ld   h, l
	rra
_LABEL_9AB2_:
	ld   b, h
	ld   c, a
	ld   c, l
	ld   c, h
	ld   d, l
	ld   c, [hl]
	ld   c, l
	ld   b, c
	ld   d, d
	ld   c, l
	ld   c, c
_LABEL_9ABD_:
	ld   b, l
	ld   c, d
	ld   d, l
	ld   b, l
	ld   d, [hl]
	ld   c, c
_LABEL_9AC3_:
	ld   b, l
	ld   d, e
	ld   b, c
	ld   b, d
	ld   b, h
	ld   c, a
	ld   c, l
	jr   nz, _LABEL_9AEC_
	ld   b, d
	dec  a
	ld   d, b
	ld   [hl], d
	ld   l, a
	ld   a, b
	jr   nz, _LABEL_9AF4_
	ld   b, c
	dec  a
	ld   d, e
	ld   h, c
	ld   l, h
	ld   l, c
	ld   h, h
	ld   h, c
	jr   nz, _LABEL_9AFE_
	nop
	jr   nz, @ + 34
	ld   d, e
	ld   h, l
	ld   l, h
	ld   h, l
	ld   h, e
	ld   [hl], h
	dec  a
	ld   b, c
	ld   l, [hl]
	ld   [hl], h
	ld   h, l
_LABEL_9AEC_:
	ld   [hl], d
	ld   l, c
	ld   l, a
	ld   [hl], d
	jr   nz, _LABEL_9B12_
	jr   nz, _LABEL_9AF4_
_LABEL_9AF4_:
	ld   c, b
	ld   h, c
	ld   h, e
	ld   h, l
	ld   [hl], d
	jr   nz, _LABEL_9B3D_
	ld   l, a
	ld   [hl], d
	ld   [hl], d
_LABEL_9AFE_:
	ld   h, c
	ld   [hl], d
	jr   nz, _LABEL_9B22_
	ld   b, l
	ld   h, h
	ld   l, c
	ld   [hl], h
	ld   h, c
	ld   [hl], d
	nop
	ld   d, b
	ld   d, l
	ld   c, h
	ld   d, e
	ld   b, l
	jr   nz, _LABEL_9B63_
	jr   nz, _LABEL_9B62_
_LABEL_9B12_:
	ld   b, c
	ld   d, d
	ld   b, c
	jr   nz, @ + 69
	ld   c, a
	ld   c, [hl]
	ld   b, [hl]
	ld   c, c
	ld   d, d
	ld   c, l
	nop
	ld   c, a
	ld   d, h
	ld   d, d
	ld   b, c
_LABEL_9B22_:
	jr   nz, _LABEL_9B78_
	ld   b, l
	ld   b, e
	ld   c, h
	ld   b, c
	jr   nz, _LABEL_9B6B_
	ld   b, d
	ld   b, c
	ld   c, [hl]
	ld   b, h
	ld   c, a
	ld   c, [hl]
	ld   b, c
	jr   nz, _LABEL_9B33_
_LABEL_9B33_:
	ldi  a, [hl]
	jr   nz, _LABEL_9B8C_
	ld   b, l
	ld   d, d
	ld   c, c
	ld   b, [hl]
	ld   c, c
	ld   b, e
	ld   b, c
_LABEL_9B3D_:
	ld   d, d
	jr   nz, _LABEL_9B60_
	ld   b, e
	ld   c, c
	ld   d, h
	ld   b, c
	ld   d, e
	jr   nz, @ + 44
	nop
	jr   nz, _LABEL_9B6A_
	jr   nz, @ + 71
	ld   d, e
	ld   b, e
	ld   b, c
	ld   c, d
	ld   b, l
	jr   nz, _LABEL_9B73_
	ld   c, c
	ld   b, h
	ld   c, c
	ld   c, a
	ld   c, l
	ld   b, c
	jr   nz, _LABEL_9B7B_
	jr   nz, @ + 34
	jr   nz, _LABEL_9BAE_
	ld   d, b
_LABEL_9B60_:
	ld   b, e
	ld   c, c
_LABEL_9B62_:
	ld   c, a
_LABEL_9B63_:
	ld   c, [hl]
	ld   b, l
	ld   d, e
	jr   nz, _LABEL_9BBA_
	ld   b, l
	ld   d, e
_LABEL_9B6A_:
	ld   b, l
_LABEL_9B6B_:
	ld   d, d
	ld   d, [hl]
	ld   b, c
	jr   nz, _LABEL_9B90_
	jr   nz, _LABEL_9B92_
	ld   d, h
_LABEL_9B73_:
	ld   d, d
	ld   b, c
	ld   c, [hl]
	ld   d, e
	ld   b, [hl]
_LABEL_9B78_:
	ld   b, l
	ld   d, d
	ld   c, c
_LABEL_9B7B_:
	ld   d, d
	jr   nz, _LABEL_9BBF_
	ld   c, h
	jr   nz, @ + 82
	ld   b, e
	jr   nz, _LABEL_9BA4_
	jr   nz, _LABEL_9BA6_
	ld   d, h
	ld   b, l
	ld   c, h
	ld   b, l
	ld   b, e
	ld   b, c
_LABEL_9B8C_:
	ld   d, d
	ld   b, a
	ld   b, c
	ld   d, d
_LABEL_9B90_:
	jr   nz, @ + 67
_LABEL_9B92_:
	ld   c, h
	jr   nz, _LABEL_9BE5_
	ld   b, e
	jr   nz, _LABEL_9BB8_
	jr   nz, _LABEL_9BBA_
	jr   nz, @ + 34
	ld   c, l
	ld   b, l
	ld   c, [hl]
	ld   d, l
	jr   nz, _LABEL_9BE5_
	ld   c, a
	ld   c, [hl]
_LABEL_9BA4_:
	ld   d, h
	ld   d, d
_LABEL_9BA6_:
	ld   c, a
	ld   c, h
	jr   nz, _LABEL_9BCA_
	jr   nz, _LABEL_9BCC_
	jr   nz, _LABEL_9BCE_
_LABEL_9BAE_:
	jr   nz, _LABEL_9BD0_
	ld   b, h
	ld   c, c
	ld   d, d
	ld   b, l
	ld   b, e
	ld   b, e
	ld   c, c
	ld   c, a
_LABEL_9BB8_:
	ld   c, [hl]
	ld   b, l
_LABEL_9BBA_:
	ld   d, e
	jr   nz, _LABEL_9BDD_
	jr   nz, _LABEL_9BDF_
_LABEL_9BBF_:
	jr   nz, _LABEL_9BE1_
	jr   nz, _LABEL_9BE3_
	jr   nz, _LABEL_9BE5_
	jr   nz, _LABEL_9BE7_
	ld   b, e
	ld   c, c
	ld   d, h
_LABEL_9BCA_:
	ld   b, c
	ld   d, e
_LABEL_9BCC_:
	jr   nz, _LABEL_9BEE_
_LABEL_9BCE_:
	jr   nz, @ + 34
_LABEL_9BD0_:
	jr   nz, _LABEL_9BF2_
	jr   nz, @ + 34
	jr   nz, _LABEL_9BF6_
	jr   nz, _LABEL_9BF8_
	ld   b, e
	ld   b, c
	ld   c, h
	ld   b, e
	ld   d, l
_LABEL_9BDD_:
	ld   c, h
	ld   b, c
_LABEL_9BDF_:
	ld   b, h
	ld   c, a
_LABEL_9BE1_:
	ld   d, d
	ld   b, c
_LABEL_9BE3_:
	jr   nz, _LABEL_9C05_
_LABEL_9BE5_:
	jr   nz, _LABEL_9C07_
_LABEL_9BE7_:
	jr   nz, _LABEL_9C09_
	jr   nz, @ + 34
	ld   b, d
	ld   b, c
	ld   d, e
_LABEL_9BEE_:
	ld   b, l
	jr   nz, _LABEL_9C11_
	ld   b, h
_LABEL_9BF2_:
	ld   b, l
	jr   nz, _LABEL_9C39_
	ld   b, c
_LABEL_9BF6_:
	ld   d, h
	ld   c, a
_LABEL_9BF8_:
	ld   d, e
	jr   nz, _LABEL_9C1B_
	jr   nz, _LABEL_9C3F_
	ld   d, l
	ld   d, e
	ld   b, e
	ld   b, c
	jr   nz, @ + 67
	jr   nz, @ + 72
_LABEL_9C05_:
	ld   c, c
	ld   c, [hl]
_LABEL_9C07_:
	jr   nz, @ + 70
_LABEL_9C09_:
	ld   b, l
	jr   nz, _LABEL_9C50_
	ld   b, c
	ld   d, h
	ld   c, a
	ld   d, e
	nop
_LABEL_9C11_:
	jr   nz, _LABEL_9C63_
	ld   d, l
	ld   c, h
	ld   d, e
	ld   b, c
	jr   nz, _LABEL_9C39_
	ld   b, e
	ld   d, l
_LABEL_9C1B_:
	ld   b, c
	ld   c, h
	ld   d, c
	jr   nz, _LABEL_9C74_
	ld   b, l
	ld   b, e
	ld   c, h
	ld   b, c
	jr   nz, _LABEL_9C26_
_LABEL_9C26_:
	jr   nz, _LABEL_9C77_
	ld   d, b
	ld   b, e
	ld   c, c
	ld   c, a
	ld   c, [hl]
	ld   b, l
	ld   d, e
	jr   nz, _LABEL_9C51_
	ld   b, d
	ld   d, l
	ld   d, e
	ld   d, c
	ld   d, l
	ld   b, l
	ld   b, h
	ld   b, c
_LABEL_9C39_:
	jr   nz, _LABEL_9C5B_
	jr   nz, _LABEL_9C5D_
	jr   nz, _LABEL_9C81_
_LABEL_9C3F_:
	ld   d, l
	ld   d, e
	ld   b, e
	ld   b, c
	jr   nz, @ + 73
	ld   c, h
	ld   c, a
	ld   b, d
	ld   b, c
	ld   c, h
	jr   nz, _LABEL_9C6C_
	jr   nz, _LABEL_9C6E_
	jr   nz, _LABEL_9C70_
_LABEL_9C50_:
	ld   b, d
_LABEL_9C51_:
	ld   d, l
	ld   d, e
	ld   b, e
	ld   b, c
	jr   nz, _LABEL_9C9C_
	ld   d, e
	ld   d, b
	ld   b, l
	ld   b, e
_LABEL_9C5B_:
	ld   c, c
	ld   b, [hl]
_LABEL_9C5D_:
	ld   c, c
	ld   b, e
	ld   b, c
	jr   nz, _LABEL_9C82_
	ld   d, h
_LABEL_9C63_:
	ld   l, c
	ld   h, l
	ld   l, l
	ld   [hl], b
	ld   l, a
	cpl
	ld   b, [hl]
	ld   h, l
	ld   h, e
_LABEL_9C6C_:
	ld   l, b
	ld   h, c
_LABEL_9C6E_:
	jr   nz, _LABEL_9CD5_
_LABEL_9C70_:
	ld   [hl], d
	ld   [hl], d
	ld   l, a
	ld   l, [hl]
_LABEL_9C74_:
	ld   h, l
	ld   h, c
	nop
_LABEL_9C77_:
	ld   b, d
	ld   h, c
	ld   [hl], h
	ld   h, l
	ld   [hl], d
	ld   l, c
	ld   h, c
	ld   [hl], e
	jr   nz, _LABEL_9CE3_
_LABEL_9C81_:
	ld   h, c
_LABEL_9C82_:
	ld   l, d
	ld   h, c
	ld   [hl], e
	ccf
	nop
	jr   nz, _LABEL_9CA9_
	jr   nz, _LABEL_9CAB_
	jr   nz, _LABEL_9CAD_
	jr   nz, _LABEL_9CDC_
	ld   c, a
	ld   c, [hl]
	ld   b, l
	ld   b, h
	ld   b, c
	jr   nz, _LABEL_9CB6_
	jr   nz, _LABEL_9CB8_
	jr   nz, _LABEL_9CBA_
	jr   nz, _LABEL_9CBC_
_LABEL_9C9C_:
	jr   nz, _LABEL_9CBE_
	jr   nz, _LABEL_9CC0_
	ld   d, h
	ld   b, c
	ld   c, h
	ld   c, a
	ld   c, [hl]
	ld   b, c
	ld   d, d
	ld   c, c
	ld   c, a
_LABEL_9CA9_:
	jr   nz, _LABEL_9CCB_
_LABEL_9CAB_:
	jr   nz, _LABEL_9CCD_
_LABEL_9CAD_:
	jr   nz, _LABEL_9CCF_
	ld   l, d
	ld   l, d
	ld   l, d
	ld   e, a
	ld   h, b
	ld   h, c
	ld   h, d
_LABEL_9CB6_:
	ld   h, e
	ld   h, h
_LABEL_9CB8_:
	ld   h, h
	ld   h, h
_LABEL_9CBA_:
	ld   h, h
	ld   h, h
_LABEL_9CBC_:
	ld   h, h
	ld   h, h
_LABEL_9CBE_:
	ld   h, l
	ld   l, c
_LABEL_9CC0_:
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, l
	ld   l, [hl]
	ld   l, a
	ld   [hl], b
	ld   [hl], c
_LABEL_9CCB_:
	ld   [hl], d
	ld   [hl], d
_LABEL_9CCD_:
	ld   [hl], d
	ld   [hl], d
_LABEL_9CCF_:
	ld   [hl], d
	ld   [hl], d
	ld   [hl], d
	ld   [hl], e
	ld   [hl], h
	ld   l, e
_LABEL_9CD5_:
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   a, h
	ld   a, l
_LABEL_9CDC_:
	ld   a, l
	ld   a, l
	ld   a, l
	ld   a, l
	ld   a, l
	ld   a, l
	ld   a, l
_LABEL_9CE3_:
	ld   a, l
	ld   a, l
	ld   a, l
	ld   a, l
	ld   a, [hl]
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   a, a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add  b
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   a, a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add  b
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   a, a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add  b
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   a, a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add  b
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   a, a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add  b
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	add  c
	add  d
	sub  b
	sub  c
	sub  d
	sub  e
	sub  h
	sub  l
	sbc  a, b
	sbc  a, c
	ldh  [_RAM_FFE1_], a
	add  h
	adc  b
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	adc  h
	adc  l
	sbc  a, d
	sbc  a, e
	sbc  a, h
	sbc  a, l
	sbc  a, [hl]
	sbc  a, a
	and  d
	and  e
	ld   [$8EEB], a
	adc  a
	ld   l, e
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	ld   l, d
	adc  h
	adc  l
	and  h
	and  l
	adc  $CF
	ret  nc
	pop  de
	jp   nc, $ACD3	; Possibly invalid
; Data from 9D85 to 9E16 (146 bytes)
db $AD, $8E, $8F, $6B, $6A, $6A, $6A, $6A, $6A, $8C, $8D, $AE, $AF, $D8, $D9, $DA
db $DB, $B4, $B5, $B6, $B7, $8E, $8F, $6B, $6A, $6A, $6A, $6A, $6A, $8C, $8D, $B8
db $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $8E, $8F, $6B, $6A, $6A, $6A, $6A
db $6A, $8C, $8D, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $8E, $8F, $6B
db $6A, $6A, $6A, $6A, $6A, $8C, $8D, $CC, $CD, $A6, $A7, $A8, $A9, $AA, $AB, $D4
db $D5, $8E, $8F, $6B, $6A, $6A, $6A, $6A, $6A, $8C, $8D, $D6, $D7, $B0, $B1, $EC
db $ED, $B4, $B5, $DE, $DF, $8E, $8F, $6B, $6A, $6A, $6A, $6A, $6A, $8C, $8D, $67
db $68, $E4, $E5, $E2, $E3, $E8, $E9, $67, $68, $8E, $8F, $6B, $6A, $6A, $6A, $6A
db $6A, $F4, $8D, $00, $00, $EE, $EF, $EC, $ED, $F2, $F3, $00, $00, $8E, $F5, $6B
db $6A, $6A

; Data from 9E17 to A429 (1555 bytes)
_DATA_9E17_:
db $5F
ds 18, $60
db $61, $65, $67, $5F
ds 14, $60
db $61, $79, $66, $65, $67, $65, $00, $00, $00, $23, $21, $2C, $25, $2E, $24, $21
db $32, $00, $00, $00, $66, $7B, $66, $65, $67, $65
ds 14, $00
db $66, $7B, $66, $65, $67, $65
ds 14, $00
db $66, $7B, $66, $65, $67, $65, $33, $BA, $2D, $B4, $34, $BA, $37, $B6, $34, $B7
db $26, $B8, $33, $B9, $66, $7B, $66, $65, $67, $65, $BE, $BF, $BE, $BF, $BE, $BF
db $BE, $BF, $BE, $BF, $BE, $BF, $BE, $BF, $66, $7B, $66, $65, $67, $65, $C0, $C1
db $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $66, $7B, $66, $65
db $67, $65, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1
db $66, $7B, $66, $65, $67, $65, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1
db $C0, $C1, $C0, $C1, $66, $7B, $66, $65, $67, $65, $C0, $C1, $C0, $C1, $C0, $C1
db $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $66, $7B, $66, $65, $67, $65, $C0, $C1
db $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $66, $7B, $66, $65
db $67, $65, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1
db $66, $7B, $66, $65, $67, $65
ds 14, $0D
db $66, $7B, $66, $65, $67, $65
ds 14, $00
db $66, $7B, $66, $65, $67, $65
ds 14, $00
db $66, $7B, $66, $65, $67, $62
ds 14, $63
db $64, $7B, $66, $62, $63, $F9
ds 15, $FA
db $FB, $B0, $5F
ds 18, $60
db $61, $65, $67, $5F
ds 14, $60
db $61, $79, $66, $65, $67, $65, $67, $67, $67, $67, $67, $34, $29, $2D, $25, $67
db $67, $67, $67, $67, $66, $7B, $66, $65, $67, $65
ds 14, $67
db $66, $7B, $66, $65, $67, $65, $67, $67, $67, $67, $69, $6D, $6E, $72, $73, $74
db $67, $67, $67, $67, $66, $7B, $66, $65, $67, $65, $67, $67, $67, $75, $78, $7C
db $7D, $81, $82, $83, $84, $67, $67, $67, $66, $7B, $66, $65, $67, $65, $67, $67
db $88, $8C, $00, $00, $00, $00, $00, $00, $8E, $8F, $67, $67, $66, $7B, $66, $65
db $67, $65, $67, $67, $90, $91, $00, $00, $00, $00, $00, $00, $92, $93, $67, $67
db $66, $7B, $66, $65, $67, $65, $67, $67, $94, $95, $00, $00, $00, $00, $00, $00
db $96, $97, $67, $67, $66, $7B, $66, $65, $67, $65, $67, $67, $98, $99, $00, $00
db $00, $00, $00, $00, $9A, $9B, $67, $67, $66, $7B, $66, $65, $67, $65, $67, $67
db $9E, $9F, $00, $00, $00, $00, $00, $00, $A0, $A1, $67, $67, $66, $7B, $66, $65
db $67, $65, $67, $67, $A2, $A3, $00, $00, $00, $00, $00, $00, $A4, $A5, $67, $67
db $66, $7B, $66, $65, $67, $65, $67, $67, $67, $A6, $A7, $A8, $A9, $AA, $AB, $AC
db $AD, $67, $67, $67, $66, $7B, $66, $65, $67, $65, $67, $67, $67, $67, $DE, $DF
db $E0, $E1, $E2, $E3, $E4, $67, $67, $67, $66, $7B, $66, $65, $67, $65
ds 14, $67
db $66, $7B, $66, $65, $67, $65, $67, $67, $67, $10, $10, $1A, $10, $10, $1A, $10
db $10, $67, $67, $67, $66, $7B, $66, $65, $67, $62
ds 14, $63
db $64, $7B, $66, $62, $63, $F9
ds 15, $FA
db $FB, $64, $3C
ds 18, $3D
db $3E, $3F, $40, $41, $42, $3E, $43, $44, $44, $45, $46, $47, $48, $43, $44, $44
db $40, $3D, $3D, $3E, $49, $3F, $4A, $4B, $4C, $4D, $4E, $44, $44, $4F, $50, $51
db $52, $4E, $44, $44, $53, $54, $55, $56, $57, $3F, $58, $59, $5A, $5B, $4E, $44
db $44, $5C, $5D, $5E, $5F, $4E, $44, $44, $60, $61, $62, $63, $57, $3F, $64, $65
db $66, $67, $4E, $44, $44, $64, $68, $69, $6A, $4E, $44, $44, $64, $6B, $6B, $67
db $57, $3F, $40, $6C, $6D, $6E, $43, $44, $44, $40, $3D, $3D, $3E, $43, $44, $44
db $40, $6F, $70, $71, $72, $3F, $3F, $73, $74, $57, $4E, $44, $44, $75, $76, $77
db $78, $4E, $44, $44, $79, $7A, $7B, $7C, $57, $3F, $3F, $7D, $7E, $57, $4E, $44
db $44, $7F, $80, $81, $82, $4E, $44, $44, $83, $84, $85, $86, $57, $3F, $64, $87
db $88, $6A, $4E, $44, $44, $64, $89, $8A, $8B, $4E, $44, $44, $64, $8C, $8D, $67
db $57, $3F, $40, $8E, $8F, $6E, $43, $44, $44, $40, $90, $91, $71, $43, $44, $44
db $40, $92, $93, $71, $72, $3F, $3F, $94, $95, $57, $4E, $44, $44, $96, $97, $98
db $99, $4E, $44, $44, $3F, $9A, $9B, $9C, $57, $3F, $3F, $9D, $9E, $57, $4E, $44
db $44, $9F, $A0, $A1, $A2, $4E, $44, $44, $3F, $A3, $A4, $57, $57, $3F, $64, $A5
db $A6, $A7, $4E, $44, $44, $64, $A8, $A9, $AA, $4E, $44, $44, $64, $AB, $AC, $AD
db $57, $3F, $AE, $AF, $B0, $B1, $43, $44, $44, $40, $B2, $B3, $71, $43, $44, $44
db $40, $3D, $3D, $71, $72, $3F, $B4, $B5, $B6, $B7, $4E, $44, $44, $3F, $B8, $B9
db $BA, $4E, $BB, $44, $3F, $BC, $BD, $BE, $57, $3F, $BF, $C0, $C1, $C2, $4E, $44
db $44, $3F, $C3, $C4, $C5, $4E, $44, $44, $3F, $C6, $C7, $C8, $57, $3F, $64, $C9
db $CA, $CB, $4E, $44, $44, $64, $CC, $CD, $67, $4E, $44, $44, $64, $CE, $8A, $CF
db $57, $64, $D0, $D1, $D1, $D1, $D2, $6B, $6B, $D0, $D1, $D1, $D1, $D2, $6B, $6B
db $D0, $D1, $D1, $D1, $D3, $5F
ds 18, $60
db $61, $6A, $6C, $6C, $5F
ds 12, $60
db $61, $79, $6C, $6B, $6A, $6C, $6C, $6A, $34, $25, $2D, $30, $25, $32, $21, $34
db $35, $32, $25, $0D, $6B, $7B, $6C, $6B, $6A, $5F, $60, $61, $74, $00, $00, $00
db $00, $9D, $9E, $00, $00, $00, $00, $00, $5F, $60, $61, $66, $6A, $6A, $26, $6B
db $65, $00, $00, $00, $C0, $BA, $BB, $C1, $F3, $EE, $00, $00, $6A, $00, $6B, $67
db $6A, $6A, $21, $6B, $65, $E5, $E6, $E4, $C0, $BA, $BB, $C1, $F6, $F6, $F6, $00
db $6A, $23, $6B, $67, $6A, $6A, $28, $6B, $65, $E5, $E5, $E4, $C0, $BA, $BB, $C1
db $F2, $EE, $00, $00, $6A, $25, $6B, $67, $6A, $6A, $32, $6B, $65, $E5, $E4, $E4
db $C0, $BA, $BB, $C1, $F5, $F5, $F5, $00, $6A, $2C, $6B, $67, $6A, $6A, $25, $6B
db $65, $E3, $ED, $E4, $C0, $BA, $BB, $C1, $F1, $EE, $00, $00, $6A, $33, $6B, $67
db $6A, $6A, $2E, $6B, $65, $E3, $EC, $E4, $C0, $BA, $BB, $C1, $F4, $F4, $F4, $00
db $6A, $29, $6B, $67, $6A, $6A, $28, $6B, $65, $E3, $EB, $E4, $C0, $BA, $BB, $C1
db $F0, $EE, $00, $00, $6A, $35, $6B, $67, $6A, $6A, $25, $6B, $65, $E3, $EA, $E4
db $C0, $BA, $BB, $C1, $F4, $F4, $F4, $00, $6A, $33, $6B, $67, $6A, $6A, $29, $6B
db $65, $E3, $E9, $E4, $C0, $BA, $BB, $C1, $E5, $E4, $E3, $00, $6A, $00, $6B, $67
db $6A, $6A, $34, $6B, $65, $E3, $E8, $E4, $C0, $BA, $BB, $C1, $E3, $E3, $E3, $00
db $6A, $00, $6B, $67, $6A, $62, $63, $64, $65, $00, $00, $00, $00, $7F, $80, $00
db $00, $00, $00, $00, $62, $63, $64, $67, $6A, $89, $8A, $78, $84, $00, $00, $BF
db $00, $9F, $A0, $00, $00, $00, $BE, $00, $85, $87, $8A, $68, $6A, $6C, $6C, $62
ds 12, $63
db $64, $7B, $6C, $6B, $62, $63, $63, $77
ds 13, $76
db $86, $63, $8D, $79, $6A, $7E, $35, $35, $66
ds 18, $67
db $68, $76, $6A, $AE, $AF, $AF, $AF, $AF, $AF, $AF, $AF, $AF, $B0, $AE, $AF, $AF
db $AF, $AF, $B0, $6C, $77, $76, $79, $6F, $25, $38, $23, $28, $21, $2E, $27, $25
db $71, $6F, $32, $21, $34, $25, $71, $7B, $77, $76, $79, $7E, $7F, $7F, $7F, $7F
db $7F, $7F, $7F, $7F, $80, $7E, $7F, $7F, $7F, $7F, $80, $7B, $77, $76, $79, $5F
ds 14, $60
db $61, $7B, $77, $76, $79, $6F, $04, $00, $00, $D2, $D3, $D4, $00

; Data from A42A to A523 (250 bytes)
_DATA_A42A_:
db $D8, $00, $00, $D5, $D6, $D7, $00, $71, $7B, $77, $76, $79, $62
ds 14, $63
db $64, $7B, $77, $76, $79, $6F, $25, $2E, $34, $25, $32, $00, $04, $00, $14, $18
db $14, $0E, $10, $10, $71, $7B, $77, $76, $79, $6F, $21, $2D, $2F, $35, $2E, $34
db $00, $00, $00, $00, $00, $00, $00, $00, $71, $7B, $77, $76, $79, $62
ds 14, $63
db $64, $7B, $77, $76, $79, $6F, $25, $2E, $34, $25, $32, $00, $00, $11, $0E, $17
db $11, $00, $00, $00, $71, $7B, $77, $76, $79, $6F, $32, $21, $34, $25
ds 10, $00
db $71, $7B, $77, $76, $79, $62
ds 14, $63
db $64, $7B, $77, $76, $79, $6F, $00, $1D, $00, $D8, $00, $12, $18, $13, $0E, $10
db $14, $00, $00, $00, $71, $7B, $77, $76, $79, $7E
ds 14, $7F
db $80, $7B, $77, $76, $79
ds 16, $7A
db $7B, $77, $76, $89
ds 16, $8A
db $8B, $77, $85
ds 18, $86
db $87

; Data from A524 to A613 (240 bytes)
_DATA_A524_:
db $41, $42, $42, $43, $44, $45, $46, $47, $42, $42, $42, $48, $49, $4A, $4B, $42
db $42, $42, $42, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58
db $59, $5A, $5B, $5C, $5D, $5E, $CB, $5F, $4D, $60, $61, $62, $63, $64, $65, $66
db $67, $68, $69, $6A, $6A, $6A, $6A, $6B, $6C, $6D, $CB, $5F, $4D, $6E, $6F, $6A
db $70, $71, $CB, $CB, $72, $73, $74, $75, $6A, $6A, $6A, $76, $77, $CB, $CB, $5F
db $4D, $CB, $78, $79, $7A, $7B, $CB, $7C, $7D, $7E, $7F, $80, $81, $6A, $6A, $82
db $83, $CB, $CB, $5F, $4D, $CA, $84, $85, $86, $87, $CB, $88, $89, $6A, $8A, $8B
db $8C, $8D, $8E, $8F, $CB, $CB, $CB, $5F, $4D, $CB, $CB, $90, $91, $92, $93, $94
db $95, $96, $6A, $97, $98, $99, $9A, $9B, $9C, $CB, $CB, $5F, $4D, $CB, $CC, $CD
db $9D, $6A, $9E, $9F, $CB, $A0, $A1, $A2, $CB, $A3, $A4, $A5, $A6, $A7, $CB, $5F
db $CE, $CF, $D0, $D1, $A8, $A9, $AA, $AB, $CB, $AC, $AD, $AE, $CB, $CB, $CB, $AF
db $B0, $B1, $CB, $5F, $4D, $D2, $D3, $D4, $D5, $B2, $B3, $B4, $CB, $B5, $B6, $B7
db $CB, $CB, $CB, $B8, $B9, $BA, $CB, $5F, $4D, $CB, $D6, $D7, $BB, $BC, $BD, $CB
db $CB, $BE, $BF, $CB, $CB, $CB, $CB, $C0, $C1, $C2, $C3, $C4, $DA, $DB, $D8, $D9
db $DB, $C5, $C6
ds 10, $DB
db $C7, $C8, $C9

_LABEL_A614_:
	ld   a, $0A
	ld   [_RAM_C478_], a
_LABEL_A619_:
	ld   hl, _RAM_C3FA_
	ld   a, [hl]
	or   a
	jr   nz, _LABEL_A637_
	ld   de, _RAM_C3FB_
	ld   b, $09
_LABEL_A625_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_A625_
	ld   a, b
	dec  de
	ld   [de], a
	ld   a, [_RAM_C478_]
	dec  a
	ld   [_RAM_C478_], a
	jr   nz, _LABEL_A619_
_LABEL_A637_:
	ld   a, $0A
	ld   [_RAM_C478_], a
_LABEL_A63C_:
	ld   hl, _RAM_C40B_
	ld   a, [hl]
	or   a
	jr   nz, _LABEL_A65A_
	ld   de, _RAM_C40C_
	ld   b, $09
_LABEL_A648_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_A648_
	ld   a, b
	dec  de
	ld   [de], a
	ld   a, [_RAM_C478_]
	dec  a
	ld   [_RAM_C478_], a
	jr   nz, _LABEL_A63C_
_LABEL_A65A_:
	ld   a, [_RAM_C40A_]
	ld   [_RAM_C41B_], a
	ld   c, a
	ld   a, [_RAM_C3F9_]
	sub  c
	jr   z, _LABEL_A69B_
	bit  7, a
	jr   nz, _LABEL_A67A_
	ld   c, a
	ld   a, [_RAM_C3F9_]
	ld   [_RAM_C41B_], a
	ld   hl, _RAM_C414_
	ld   de, _RAM_C413_
	jr   _LABEL_A68A_

_LABEL_A67A_:
	ld   hl, _RAM_C403_
	ld   de, _RAM_C402_
	ld   c, a
	ld   a, [_RAM_C40A_]
	ld   [_RAM_C41B_], a
	xor  a
	sub  c
	ld   c, a
_LABEL_A68A_:
	ld   b, $09
	push hl
	push de
_LABEL_A68E_:
	ld   a, [de]
	ldd  [hl], a
	dec  de
	dec  b
	jr   nz, _LABEL_A68E_
	ld   a, b
	ld   [hl], a
	pop  de
	pop  hl
	dec  c
	jr   nz, _LABEL_A68A_
_LABEL_A69B_:
	ret

; 1st entry of Jump Table from BD1E (indexed by unknown)
_LABEL_A69C_:
	call _LABEL_A7CF_
	ld   hl, _RAM_C40B_
	ld   b, $0A
_LABEL_A6A4_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_A6AE_
	dec  b
	jr   nz, _LABEL_A6A4_
	jp   _LABEL_BDF0_

_LABEL_A6AE_:
	ld   hl, _RAM_C42B_
	ld   b, $20
	xor  a
_LABEL_A6B4_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_A6B4_
	ld   b, $50
_LABEL_A6BA_:
	push bc
	call _LABEL_A73E_
	call _LABEL_A757_
	call _LABEL_A779_
	pop  bc
	dec  b
	jr   nz, _LABEL_A6BA_
	ld   hl, _RAM_C3F9_
	call _LABEL_A72C_
	push bc
	ld   hl, _RAM_C40A_
	call _LABEL_A72C_
	ld   a, b
	pop  bc
	sub  b
	ld   b, a
	xor  a
	sub  b
	add  $16
	ld   b, a
	ld   hl, _RAM_C42B_
	ld   c, $20
_LABEL_A6E3_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_A6F7_
	dec  b
	dec  c
	jr   nz, _LABEL_A6E3_
	ld   a, c
	ld   [_RAM_C41B_], a
	ld   [_RAM_C41A_], a
	ld   hl, _RAM_C42B_
	jr   _LABEL_A719_

_LABEL_A6F7_:
	ld   a, b
	ld   [_RAM_C41B_], a
	push bc
	ld   a, [_RAM_C3F8_]
	ld   c, a
	ld   a, [_RAM_C409_]
	add  c
	or   a
	jr   z, _LABEL_A70C_
	cp   $FF
	jr   z, _LABEL_A70C_
	xor  a
_LABEL_A70C_:
	ld   [_RAM_C41A_], a
	dec  hl
	pop  bc
	ld   a, c
	cp   $0B
	jr   nc, _LABEL_A719_
	ld   hl, _RAM_C440_
_LABEL_A719_:
	ld   de, _RAM_C41C_
	ld   b, $0B
_LABEL_A71E_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_A71E_
	ld   a, b
	ld   b, $05
_LABEL_A727_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_A727_
	ret

_LABEL_A72C_:
	ld   bc, $0A0A
	ld   e, [hl]
	inc  hl
_LABEL_A731_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_A73A_
	dec  b
	dec  c
	jr   nz, _LABEL_A731_
	ret

_LABEL_A73A_:
	ld   a, e
	sub  b
	ld   b, a
	ret

_LABEL_A73E_:
	ld   hl, _RAM_C44A_
	ld   bc, $2000
_LABEL_A744_:
	ld   a, [hl]
	add  a
	add  c
	ld   c, $00
_LABEL_A749_:
	cp   $0A
	jr   c, _LABEL_A752_
	sub  $0A
	inc  c
	jr   _LABEL_A749_

_LABEL_A752_:
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_A744_
	ret

_LABEL_A757_:
	ld   hl, _RAM_C486_
	ld   b, $0A
	or   a
_LABEL_A75D_:
	rl   [hl]
	dec  hl
	push af
	dec  b
	jr   z, _LABEL_A767_
	pop  af
	jr   _LABEL_A75D_

_LABEL_A767_:
	pop  af
	ld   b, $0A
	ld   hl, _RAM_C490_
_LABEL_A76D_:
	rl   [hl]
	dec  hl
	push af
	dec  b
	jr   z, _LABEL_A777_
	pop  af
	jr   _LABEL_A76D_

_LABEL_A777_:
	pop  af
	ret

_LABEL_A779_:
	ld   hl, _RAM_C487_
	ld   de, _RAM_C491_
	ld   b, $0A
_LABEL_A781_:
	ld   a, [de]
	inc  de
	ld   c, a
	ldi  a, [hl]
	cp   c
	jr   z, _LABEL_A78B_
	ret  c
	jr   _LABEL_A78E_

_LABEL_A78B_:
	dec  b
	jr   nz, _LABEL_A781_
_LABEL_A78E_:
	ld   hl, _RAM_C490_
	ld   de, _RAM_C49A_
	ld   b, $0A
	or   a
_LABEL_A797_:
	ld   a, [de]
	dec  de
	ld   c, a
	ld   a, [hl]
	sbc  a, c
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A7A4_
	pop  af
	jr   _LABEL_A797_

_LABEL_A7A4_:
	pop  af
	ld   hl, _RAM_C486_
	scf
	ld   b, $0A
_LABEL_A7AB_:
	ld   a, [hl]
	adc  $00
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A7B6_
	pop  af
	jr   _LABEL_A7AB_

_LABEL_A7B6_:
	pop  af
	ld   hl, _RAM_C44A_
	ld   bc, $2001
_LABEL_A7BD_:
	ld   a, [hl]
	add  c
	ld   c, $00
_LABEL_A7C1_:
	cp   $0A
	jr   c, _LABEL_A7CA_
	sub  $0A
	inc  c
	jr   _LABEL_A7C1_

_LABEL_A7CA_:
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_A7BD_
	ret

_LABEL_A7CF_:
	ld   hl, _RAM_C47D_
	xor  a
	ld   b, $28
_LABEL_A7D5_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_A7D5_
	ld   de, _RAM_C486_
	ld   hl, _RAM_C3FA_
	call _LABEL_A7F5_
	ld   b, $0A
_LABEL_A7E4_:
	push bc
	call _LABEL_A80C_
	pop  bc
	dec  b
	jr   nz, _LABEL_A7E4_
	ld   de, _RAM_C49A_
	ld   hl, _RAM_C40B_
	jp   _LABEL_A7F5_

_LABEL_A7F5_:
	ld   a, e
	ld   [_RAM_C4A5_], a
	ld   a, d
	ld   [_RAM_C4A6_], a
	ld   b, $0A
_LABEL_A7FF_:
	push bc
	push hl
	ldi  a, [hl]
	call _LABEL_A80C_
	pop  hl
	pop  bc
	inc  hl
	dec  b
	jr   nz, _LABEL_A7FF_
	ret

_LABEL_A80C_:
	ld   c, a
	call _LABEL_A85D_
	ld   a, [_RAM_C4A5_]
	ld   l, a
	ld   a, [_RAM_C4A6_]
	ld   h, a
	ld   de, _RAM_C4A4_
	ld   b, $0A
_LABEL_A81D_:
	ldd  a, [hl]
	ld   [de], a
	dec  de
	dec  b
	jr   nz, _LABEL_A81D_
	call _LABEL_A85D_
	call _LABEL_A85D_
	ld   a, [_RAM_C4A5_]
	ld   l, a
	ld   a, [_RAM_C4A6_]
	ld   h, a
	ld   de, _RAM_C4A4_
	ld   b, $0A
	or   a
_LABEL_A837_:
	ld   a, [de]
	dec  de
	adc  [hl]
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A842_
	pop  af
	jr   _LABEL_A837_

_LABEL_A842_:
	pop  af
	ld   a, [_RAM_C4A5_]
	ld   l, a
	ld   a, [_RAM_C4A6_]
	ld   h, a
	ld   b, $09
	ld   a, c
	add  [hl]
	ldd  [hl], a
_LABEL_A850_:
	ld   a, $00
	adc  [hl]
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A85B_
	pop  af
	jr   _LABEL_A850_

_LABEL_A85B_:
	pop  af
	ret

_LABEL_A85D_:
	ld   a, [_RAM_C4A5_]
	ld   l, a
	ld   a, [_RAM_C4A6_]
	ld   h, a
	ld   b, $0A
	or   a
_LABEL_A868_:
	rl   [hl]
	dec  hl
	push af
	dec  b
	jr   z, _LABEL_A872_
	pop  af
	jr   _LABEL_A868_

_LABEL_A872_:
	pop  af
	ret

; 1st entry of Jump Table from BD20 (indexed by unknown)
_LABEL_A874_:
	call _LABEL_A97F_
	ld   a, [_RAM_C3F8_]
	ld   c, a
	ld   a, [_RAM_C409_]
	add  c
	ld   [_RAM_C41A_], a
	ld   hl, _RAM_C42B_
	ld   b, $20
	xor  a
_LABEL_A888_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_A888_
	ld   b, $28
_LABEL_A88E_:
	push bc
	call _LABEL_A91E_
	call _LABEL_A932_
	jr   nc, _LABEL_A89A_
	call _LABEL_A944_
_LABEL_A89A_:
	pop  bc
	dec  b
	jr   nz, _LABEL_A88E_
	jp   _LABEL_A8A1_

_LABEL_A8A1_:
	ld   hl, _RAM_C3F9_
	call _LABEL_A8F9_
	push bc
	ld   hl, _RAM_C40A_
	call _LABEL_A8F9_
	ld   a, c
	pop  bc
	add  c
	ld   e, a
	ld   hl, _RAM_C42B_
	ld   c, $20
_LABEL_A8B7_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_A8BE_
	dec  c
	jr   nz, _LABEL_A8B7_
_LABEL_A8BE_:
	ld   a, c
	sub  e
	ld   c, a
	ld   a, [_RAM_C3F9_]
	bit  7, a
	jr   z, _LABEL_A8CA_
	add  c
	ld   c, a
_LABEL_A8CA_:
	ld   a, [_RAM_C40A_]
	bit  7, a
	jr   z, _LABEL_A8D3_
	add  c
	ld   c, a
_LABEL_A8D3_:
	ld   a, c
	ld   [_RAM_C42B_], a
	ld   hl, _RAM_C42C_
	ld   c, $1F
_LABEL_A8DC_:
	ld   a, [hl]
	or   a
	jr   nz, _LABEL_A8E7_
	inc  hl
	dec  c
	jr   nz, _LABEL_A8DC_
	ld   hl, _RAM_C42C_
_LABEL_A8E7_:
	ld   de, _RAM_C41C_
	ld   c, $0B
_LABEL_A8EC_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  c
	jr   nz, _LABEL_A8EC_
	ld   a, [_RAM_C42B_]
	ld   [_RAM_C41B_], a
	ret

_LABEL_A8F9_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_A915_
	bit  7, a
	jr   nz, _LABEL_A915_
	ld   c, $0A
	ld   b, a
_LABEL_A904_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_A90D_
	dec  c
	jr   nz, _LABEL_A904_
	jr   _LABEL_A91D_

_LABEL_A90D_:
	dec  c
	dec  b
	jr   z, _LABEL_A914_
	ldi  a, [hl]
	jr   _LABEL_A90D_

_LABEL_A914_:
	ret

_LABEL_A915_:
	ld   c, $0A
_LABEL_A917_:
	ldi  a, [hl]
	or   a
	ret  nz
	dec  c
	jr   nz, _LABEL_A917_
_LABEL_A91D_:
	ret

_LABEL_A91E_:
	ld   hl, _RAM_C44A_
	ld   b, $20
	or   a
_LABEL_A924_:
	ld   a, [hl]
	adc  a
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A92E_
	pop  af
	jr   _LABEL_A924_

_LABEL_A92E_:
	pop  af
	jp   _LABEL_A967_

_LABEL_A932_:
	or   a
	ld   hl, _RAM_C44F_
	ld   b, $05
_LABEL_A938_:
	ld   a, [hl]
	rla
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A942_
	pop  af
	jr   _LABEL_A938_

_LABEL_A942_:
	pop  af
	ret

_LABEL_A944_:
	ld   hl, _RAM_C44A_
	ld   de, _RAM_C414_
	ld   b, $0A
	or   a
_LABEL_A94D_:
	ld   a, [de]
	dec  de
	adc  [hl]
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A958_
	pop  af
	jr   _LABEL_A94D_

_LABEL_A958_:
	pop  af
	ld   b, $16
_LABEL_A95B_:
	ld   a, $00
	adc  [hl]
	ldd  [hl], a
	push af
	dec  b
	jr   z, _LABEL_A966_
	pop  af
	jr   _LABEL_A95B_

_LABEL_A966_:
	pop  af
_LABEL_A967_:
	ld   hl, _RAM_C44A_
	ld   bc, $1F00
_LABEL_A96D_:
	ld   a, [hl]
	add  c
	ld   c, $00
_LABEL_A971_:
	cp   $0A
	jr   c, _LABEL_A97A_
	sub  $0A
	inc  c
	jr   _LABEL_A971_

_LABEL_A97A_:
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_A96D_
	ret

_LABEL_A97F_:
	ld   hl, _RAM_C44B_
	xor  a
	ld   b, $0A
_LABEL_A985_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_A985_
	ld   b, $0A
	ld   hl, _RAM_C3FA_
_LABEL_A98E_:
	push bc
	push hl
	ldi  a, [hl]
	call _LABEL_A99B_
	pop  hl
	pop  bc
	inc  hl
	dec  b
	jr   nz, _LABEL_A98E_
	ret

_LABEL_A99B_:
	ld   c, a
	call _LABEL_AA12_
	ld   hl, _RAM_C44B_
	ld   de, _RAM_C450_
	ld   b, $05
_LABEL_A9A7_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_A9A7_
	call _LABEL_AA12_
	call _LABEL_AA12_
	ld   a, [_RAM_C44F_]
	ld   b, a
	ld   a, [_RAM_C454_]
	add  b
	ld   [_RAM_C44F_], a
	ld   a, [_RAM_C44E_]
	ld   b, a
	ld   a, [_RAM_C453_]
	adc  b
	ld   [_RAM_C44E_], a
	ld   a, [_RAM_C44D_]
	ld   b, a
	ld   a, [_RAM_C452_]
	adc  b
	ld   [_RAM_C44D_], a
	ld   a, [_RAM_C44C_]
	ld   b, a
	ld   a, [_RAM_C451_]
	adc  b
	ld   [_RAM_C44C_], a
	ld   a, [_RAM_C44B_]
	ld   b, a
	ld   a, [_RAM_C450_]
	adc  b
	ld   [_RAM_C44B_], a
	ld   a, [_RAM_C44F_]
	add  c
	ld   [_RAM_C44F_], a
	ld   a, [_RAM_C44E_]
	adc  $00
	ld   [_RAM_C44E_], a
	ld   a, [_RAM_C44D_]
	adc  $00
	ld   [_RAM_C44D_], a
	ld   a, [_RAM_C44C_]
	adc  $00
	ld   [_RAM_C44C_], a
	ld   a, [_RAM_C44B_]
	adc  $00
	ld   [_RAM_C44B_], a
	ret

_LABEL_AA12_:
	or   a
	ld   a, [_RAM_C44F_]
	rla
	ld   [_RAM_C44F_], a
	ld   a, [_RAM_C44E_]
	rla
	ld   [_RAM_C44E_], a
	ld   a, [_RAM_C44D_]
	rla
	ld   [_RAM_C44D_], a
	ld   a, [_RAM_C44C_]
	rla
	ld   [_RAM_C44C_], a
	ld   a, [_RAM_C44B_]
	rla
	ld   [_RAM_C44B_], a
	ret

; 1st entry of Jump Table from BD1A (indexed by unknown)
_LABEL_AA37_:
	call _LABEL_A614_
	ld   a, [_RAM_C3F8_]
	ld   c, a
	ld   a, [_RAM_C409_]
	add  c
	or   a
	jr   z, _LABEL_AA55_
	cp   $FE
	jr   z, _LABEL_AA54_
	ld   a, [_RAM_C409_]
	xor  $FF
	ld   [_RAM_C409_], a
	jp   _LABEL_BD31_

_LABEL_AA54_:
	inc  a
_LABEL_AA55_:
	ld   [_RAM_C41A_], a
_LABEL_AA58_:
	ld   hl, _RAM_C403_
	ld   de, _RAM_C414_
	ld   a, $26
	ld   [_RAM_C47A_], a
	ld   a, $C4
	ld   [_RAM_C47B_], a
	ld   bc, $0A00
_LABEL_AA6B_:
	ld   a, [de]
	add  [hl]
	add  c
	ld   c, $00
_LABEL_AA70_:
	cp   $0A
	jr   c, _LABEL_AA79_
	inc  c
	sub  $0A
	jr   _LABEL_AA70_

_LABEL_AA79_:
	push hl
	push af
	ld   a, [_RAM_C47A_]
	ld   l, a
	ld   a, [_RAM_C47B_]
	ld   h, a
	pop  af
	ld   [hl], a
	dec  hl
	ld   a, l
	ld   [_RAM_C47A_], a
	ld   a, h
	ld   [_RAM_C47B_], a
	pop  hl
	dec  de
	dec  hl
	dec  b
	jr   nz, _LABEL_AA6B_
	ld   a, [_RAM_C47A_]
	ld   l, a
	ld   a, [_RAM_C47B_]
	ld   h, a
	ld   [hl], c
	ld   a, c
	or   a
	ret  z
	ld   a, [_RAM_C41B_]
	inc  a
	ld   [_RAM_C41B_], a
	ret

_LABEL_AAA8_:
	xor  a
	ld   [_RAM_C475_], a
	push hl
	dec  hl
	ld   b, $0C
_LABEL_AAB0_:
	ld   [hl], $00
	inc  hl
	dec  b
	jr   nz, _LABEL_AAB0_
	pop  hl
	push hl
	inc  hl
	ld   bc, $0A00
_LABEL_AABC_:
	ld   a, [de]
	cp   $2D
	jr   nz, _LABEL_AACA_
	ld   a, $FF
	dec  hl
	dec  hl
	ldi  [hl], a
	inc  hl
	inc  de
	jr   _LABEL_AABC_

_LABEL_AACA_:
	or   a
	jr   z, _LABEL_AB0E_
	cp   $2E
	jr   z, _LABEL_AAF5_
	cp   $20
	jr   z, _LABEL_AAD9_
	cp   $30
	jr   nz, _LABEL_AADC_
_LABEL_AAD9_:
	inc  de
	jr   _LABEL_AABC_

_LABEL_AADC_:
	sub  $30
	dec  b
	ldi  [hl], a
	inc  c
	inc  de
	ld   a, [de]
	or   a
	jr   z, _LABEL_AB0E_
	cp   $2E
	jr   nz, _LABEL_AADC_
_LABEL_AAEA_:
	inc  de
	ld   a, [de]
	or   a
	jr   z, _LABEL_AB0E_
	sub  $30
	dec  b
	ldi  [hl], a
	jr   _LABEL_AAEA_

_LABEL_AAF5_:
	inc  de
	ld   a, [de]
	or   a
	jr   nz, _LABEL_AAFE_
	ld   c, $00
	jr   _LABEL_AB0E_

_LABEL_AAFE_:
	cp   $30
	jr   nz, _LABEL_AB05_
	dec  c
	jr   _LABEL_AAF5_

_LABEL_AB05_:
	sub  $30
	dec  b
	ldi  [hl], a
	inc  de
	ld   a, [de]
	or   a
	jr   nz, _LABEL_AB05_
_LABEL_AB0E_:
	pop  de
	ld   a, c
	ld   [de], a
	ld   a, b
	ld   a, b
	or   a
	ret  z
	cp   $0A
	ret  z
	ld   [_RAM_C478_], a
	ld   e, l
	ld   d, h
	ld   a, b
	add  e
	ld   e, a
	ld   a, $00
	adc  d
	ld   d, a
	ld   a, $0A
	sub  b
	ld   b, a
	dec  hl
	dec  de
	push de
_LABEL_AB2B_:
	ld   a, [hl]
	ld   [de], a
	xor  a
	ldd  [hl], a
	dec  de
	dec  b
	jr   nz, _LABEL_AB2B_
	ld   a, c
	or   a
	jr   z, _LABEL_AB3D_
	bit  7, a
	jr   nz, _LABEL_AB3D_
	jr   _LABEL_AB51_

_LABEL_AB3D_:
	pop  de
	ld   a, [de]
	or   a
	ret  nz
	push de
	ld   h, d
	ld   l, e
	dec  hl
	ld   b, $09
_LABEL_AB47_:
	ld   a, [hl]
	ld   [de], a
	dec  de
	xor  a
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_AB47_
	jr   _LABEL_AB3D_

_LABEL_AB51_:
	ld   a, [_RAM_C478_]
	ld   b, a
	ld   a, $0B
	sub  b
	sub  c
	jr   nz, _LABEL_AB5D_
	pop  de
	ret

_LABEL_AB5D_:
	ld   c, a
_LABEL_AB5E_:
	pop  de
	ld   a, [de]
	or   a
	ret  nz
	dec  c
	ret  z
	push de
	ld   h, d
	ld   l, e
	dec  hl
	ld   b, $09
_LABEL_AB6A_:
	ld   a, [hl]
	ld   [de], a
	dec  de
	xor  a
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_AB6A_
	jr   _LABEL_AB5E_

_LABEL_AB74_:
	ld   hl, _RAM_C41C_
	ld   c, $0B
_LABEL_AB79_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_AB83_
	dec  c
	jr   nz, _LABEL_AB79_
	ld   [_RAM_C41A_], a
_LABEL_AB83_:
	ld   a, [_RAM_C41B_]
	bit  7, a
	jr   nz, _LABEL_AB91_
	cp   $0B
	jr   c, _LABEL_AB9B_
	jp   _LABEL_BDF0_

_LABEL_AB91_:
	ld   c, a
	xor  a
	sub  c
	cp   $08
	jr   c, _LABEL_AB9B_
	jp   _LABEL_BDF0_

_LABEL_AB9B_:
	ld   hl, _RAM_C455_
	ld   b, $10
	ld   a, $30
_LABEL_ABA2_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_ABA2_
	ld   [hl], b
	ld   a, [_RAM_C41B_]
	or   a
	jr   z, _LABEL_ABDD_
	bit  7, a
	jr   nz, _LABEL_ABDD_
	ld   b, a
	ld   hl, _RAM_C455_
	ld   a, [_RAM_C41A_]
	inc  a
	jr   nz, _LABEL_ABBE_
	ld   [hl], $2D
	inc  hl
_LABEL_ABBE_:
	ld   de, _RAM_C41C_
	ld   c, $0B
_LABEL_ABC3_:
	ld   a, [de]
	or   a
	jr   nz, _LABEL_ABCD_
	inc  de
	dec  c
	jr   nz, _LABEL_ABC3_
	jr   _LABEL_AC12_

_LABEL_ABCD_:
	ld   a, [de]
	add  $30
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_ABD7_
	ld   [hl], $2E
	inc  hl
_LABEL_ABD7_:
	inc  de
	dec  c
	jr   nz, _LABEL_ABCD_
	jr   _LABEL_AC12_

_LABEL_ABDD_:
	ld   c, a
	ld   hl, _RAM_C455_
	ld   a, [_RAM_C41A_]
	inc  a
	jr   nz, _LABEL_ABEA_
	ld   [hl], $2D
	inc  hl
_LABEL_ABEA_:
	ld   [hl], $30
	inc  hl
	ld   [hl], $2E
	inc  hl
	xor  a
	sub  c
_LABEL_ABF2_:
	or   a
	jr   z, _LABEL_ABFB_
	ld   [hl], $30
	inc  hl
	dec  a
	jr   _LABEL_ABF2_

_LABEL_ABFB_:
	ld   de, _RAM_C41C_
	ld   b, $0B
_LABEL_AC00_:
	ld   a, [de]
	or   a
	jr   nz, _LABEL_AC0A_
	inc  de
	dec  b
	jr   nz, _LABEL_AC00_
	jr   _LABEL_AC12_

_LABEL_AC0A_:
	ld   a, [de]
	add  $30
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_AC0A_
_LABEL_AC12_:
	ld   hl, _RAM_C455_
	ld   b, $10
_LABEL_AC17_:
	ldi  a, [hl]
	cp   $2E
	jr   z, _LABEL_AC2E_
	dec  b
	jr   nz, _LABEL_AC17_
	ld   hl, _RAM_C455_
	ld   b, $10
_LABEL_AC24_:
	ldi  a, [hl]
	cp   $30
	jr   nz, _LABEL_AC45_
	dec  b
	jr   nz, _LABEL_AC24_
	jr   _LABEL_AC45_

_LABEL_AC2E_:
	ld   hl, _RAM_C464_
	ld   b, $10
_LABEL_AC33_:
	ld   a, [hl]
	cp   $2E
	jr   z, _LABEL_AC43_
	cp   $30
	jr   nz, _LABEL_AC42_
	dec  hl
	dec  b
	jr   nz, _LABEL_AC33_
	jr   _LABEL_AC45_

_LABEL_AC42_:
	inc  hl
_LABEL_AC43_:
	xor  a
	ld   [hl], a
_LABEL_AC45_:
	rst  $18	; Call VSYNC__RST_18
	ld   b, $00
	ld   hl, _RAM_C455_
_LABEL_AC4B_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_AC52_
	inc  b
	jr   _LABEL_AC4B_

_LABEL_AC52_:
	ld   a, b
	cp   $0C
	jr   c, _LABEL_AC59_
	ld   b, $0B
_LABEL_AC59_:
	ld   hl, _RAM_C466_
	ld   a, $0B
	sub  b
	jr   z, _LABEL_AC68_
	ld   c, a
	ld   a, $20
_LABEL_AC64_:
	ldi  [hl], a
	dec  c
	jr   nz, _LABEL_AC64_
_LABEL_AC68_:
	ld   de, _RAM_C455_
_LABEL_AC6B_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_AC6B_
	ld   a, [_RAM_C470_]
	cp   $2E
	jr   nz, _LABEL_AC89_
	ld   hl, _RAM_C470_
	ld   de, _RAM_C46F_
	ld   b, $0A
_LABEL_AC80_:
	ld   a, [de]
	ldd  [hl], a
	dec  de
	dec  b
	jr   nz, _LABEL_AC80_
	ld   a, $20
	ld   [hl], a
_LABEL_AC89_:
	ld   hl, _RAM_C455_
	ld   de, _RAM_C3E0_
	ld   b, $0B
_LABEL_AC91_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_AC91_
	ld   de, _RAM_C3E0_
	ld   hl, $C3F9
	jp   _LABEL_AAA8_

_LABEL_ACA0_:
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C58D_], a
_LABEL_ACA8_:
	ld   a, [_RAM_C58D_]
	ld   hl, _RAM_C56D_
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	push af
	and  $7F
	ld   [_RAM_C10B_], a
	call _LABEL_B765_
	pop  af
	bit  7, a
	jr   nz, _LABEL_AD13_
	dec  a
	call _LABEL_B4EB_
	ld   de, _SRAM_238_
	add  hl, de
	ld   a, [hl]
	call _LABEL_2909_
	or   a
	jr   nz, _LABEL_AD13_
	ld   de, $2150
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $2150
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	ld   de, $0037
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
_LABEL_ACE7_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_ACE7_
	or   a
	jp   z, _LABEL_AD6E_
	cp   $4E
	jr   z, _LABEL_AD13_
	push af
	ld   a, [_RAM_C232_]
	ld   d, $00
	ld   e, a
	ld   hl, $1071
	add  hl, de
	pop  af
	cp   [hl]
	jr   nz, _LABEL_ACE7_
	ld   a, [_RAM_C58D_]
	ld   hl, _RAM_C56D_
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	or   $80
	ld   [hl], a
_LABEL_AD13_:
	ld   de, $2150
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0002
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	call _LABEL_B7F7_
	ld   de, $0039
	ld   hl, $9A21
	rst  $20	; _LABEL_20_
_LABEL_AD2B_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_AD2B_
	or   a
	jr   z, _LABEL_AD6E_
	push af
	ld   a, [_RAM_C232_]
	ld   e, a
	add  a
	add  e
	ld   e, a
	ld   d, $00
	ld   hl, $1062
	add  hl, de
	pop  af
	cp   [hl]
	jr   z, _LABEL_AD4F_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_AD60_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_AD6E_
	jr   _LABEL_AD2B_

_LABEL_AD4F_:
	ld   a, [_RAM_C58C_]
	ld   c, a
	ld   a, [_RAM_C58D_]
	cp   c
	jr   z, _LABEL_AD2B_
	inc  a
	ld   [_RAM_C58D_], a
	jp   _LABEL_ACA8_

_LABEL_AD60_:
	ld   a, [_RAM_C58D_]
	cp   $01
	jr   z, _LABEL_AD2B_
	dec  a
	ld   [_RAM_C58D_], a
	jp   _LABEL_ACA8_

_LABEL_AD6E_:
	ld   hl, _RAM_C56D_
	ld   a, [_RAM_C58C_]
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [_RAM_C58C_]
_LABEL_AD7D_:
	push af
	ldd  a, [hl]
	bit  7, a
	jr   z, _LABEL_ADC6_
	push hl
	and  $7F
	ld   [_RAM_C10B_], a
	dec  a
	add  a
	ld   e, a
	ld   d, $00
	ld   h, d
	ld   l, a
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, de
	ld   de, $A233
	add  hl, de
	ld   a, [_RAM_C10B_]
	ld   c, a
	ld   a, $1E
	sub  c
	jr   z, _LABEL_ADC1_
	push hl
	ld   de, $0042
	ld   hl, $0000
_LABEL_ADAA_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_ADAA_
	ld   b, h
	ld   c, l
	pop  hl
	push hl
	ld   de, $0042
	add  hl, de
	ld   d, h
	ld   e, l
	pop  hl
_LABEL_ADB9_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_ADB9_
_LABEL_ADC1_:
	ld   hl, _SRAM_231_
	dec  [hl]
	pop  hl
_LABEL_ADC6_:
	pop  af
	dec  a
	jr   nz, _LABEL_AD7D_
	ld   a, [_SRAM_231_]
	or   a
	jr   nz, _LABEL_ADD4_
	ld   [_RAM_C10B_], a
	ret

_LABEL_ADD4_:
	ld   a, $01
	ld   [_RAM_C10B_], a
	ret

_LABEL_ADDA_:
	xor  a
	ld   [_RAM_C58F_], a
	ld   a, [_SRAM_231_]
	ld   hl, _SRAM_233_
_LABEL_ADE4_:
	push af
	push hl
	ld   a, [_RAM_C58F_]
	inc  a
	ld   [_RAM_C58F_], a
	ldi  a, [hl]
	ld   b, a
	ldi  a, [hl]
	ld   c, a
	ldi  a, [hl]
	ld   d, a
	inc  hl
	call _LABEL_AE77_
	or   a
	jr   nz, _LABEL_AE22_
	inc  hl
	ld   a, [hl]
	call _LABEL_2909_
	or   a
	jr   z, _LABEL_AE6C_
	push af
	xor  a
	ld   [_RAM_C58E_], a
	pop  af
	inc  a
_LABEL_AE09_:
	push af
	call _LABEL_AEAE_
	or   a
	jr   z, _LABEL_AE2C_
	ld   hl, _RAM_C58E_
	inc  [hl]
	push bc
	push de
	call _LABEL_AED1_
	pop  de
	pop  bc
	pop  af
	dec  a
	jr   nz, _LABEL_AE09_
	call _LABEL_AE5E_
_LABEL_AE22_:
	pop  hl
	pop  af
	ld   bc, $0042
	add  hl, bc
	dec  a
	jr   nz, _LABEL_ADE4_
	ret

_LABEL_AE2C_:
	call _LABEL_AE5E_
	pop  af
_LABEL_AE30_:
	pop  hl
	ld   a, [_RAM_C58E_]
	add  a
	add  a
	add  a
	add  a
	ld   bc, $0005
	add  hl, bc
	ld   c, a
	ld   a, [hl]
	and  $0F
	add  c
	ld   [hl], a
	ld   bc, $FFFB
	add  hl, bc
	ld   a, [_RAM_C58C_]
	inc  a
	ld   [_RAM_C58C_], a
	dec  a
	ld   de, $C56E
	add  e
	ld   e, a
	ld   a, $00
	adc  d
	ld   d, a
	ld   a, [_RAM_C58F_]
	ld   [de], a
	push hl
	jr   _LABEL_AE22_

_LABEL_AE5E_:
	ld   a, [_RAM_C58E_]
	or   a
	ret  z
_LABEL_AE63_:
	push af
	call _LABEL_AFDF_
	pop  af
	dec  a
	jr   nz, _LABEL_AE63_
	ret

_LABEL_AE6C_:
	call _LABEL_AEAE_
	or   a
	jr   nz, _LABEL_AE22_
	ld   [_RAM_C58E_], a
	jr   _LABEL_AE30_

_LABEL_AE77_:
	ld   a, [_RAM_C13A_]
	cp   d
	jr   c, _LABEL_AE8F_
	jr   nz, _LABEL_AE91_
	ld   a, [_RAM_C138_]
	cp   c
	jr   c, _LABEL_AE8F_
	jr   nz, _LABEL_AE91_
	ld   a, [_RAM_C139_]
	cp   b
	jr   z, _LABEL_AE8F_
	jr   nc, _LABEL_AE91_
_LABEL_AE8F_:
	xor  a
	ret

_LABEL_AE91_:
	inc  hl
	ld   a, [hl]
	and  $0F
	ld   [hl], a
	ld   a, [_RAM_C58C_]
	inc  a
	ld   [_RAM_C58C_], a
	dec  a
	ld   de, $C56E
	add  e
	ld   e, a
	ld   a, $00
	adc  d
	ld   d, a
	ld   a, [_RAM_C58F_]
	or   $80
	ld   [de], a
	ret

_LABEL_AEAE_:
	ld   a, [_RAM_C139_]
	cp   b
	jr   nz, _LABEL_AEC2_
	ld   a, [_RAM_C138_]
	cp   c
	jr   nz, _LABEL_AEC2_
	ld   a, [_RAM_C13A_]
	cp   d
	jr   nz, _LABEL_AEC2_
	xor  a
	ret

_LABEL_AEC2_:
	ld   a, $01
	ret

; Data from AEC5 to AED0 (12 bytes)
_DATA_AEC5_:
db $1F, $1C, $1F, $1E, $1F, $1E, $1F, $1F, $1E, $1F, $1E, $1F

_LABEL_AED1_:
	ld   a, [_RAM_C304_]
	inc  a
	cp   $07
	jr   nz, _LABEL_AEDA_
	xor  a
_LABEL_AEDA_:
	ld   [_RAM_C304_], a
	ld   a, [_RAM_C138_]
	ld   hl, _DATA_AEC5_ - 1
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	cp   $1C
	jr   z, _LABEL_AF15_
	ld   c, a
	ld   a, [_RAM_C139_]
	inc  a
	inc  c
	cp   c
	jr   z, _LABEL_AEFB_
	ld   [_RAM_C139_], a
	ret

_LABEL_AEFB_:
	ld   a, $01
	ld   [_RAM_C139_], a
	ld   a, [_RAM_C138_]
	inc  a
	cp   $0D
	jr   nz, _LABEL_AF11_
	ld   a, [_RAM_C13A_]
	inc  a
	ld   [_RAM_C13A_], a
	ld   a, $01
_LABEL_AF11_:
	ld   [_RAM_C138_], a
	ret

_LABEL_AF15_:
	ld   a, [_RAM_C139_]
	inc  a
	cp   $1E
	jr   z, _LABEL_AEFB_
	cp   $1D
	jr   z, _LABEL_AF25_
	ld   [_RAM_C139_], a
	ret

_LABEL_AF25_:
	ld   a, [_RAM_C13A_]
	and  $03
	jr   nz, _LABEL_AEFB_
	ld   a, $1D
	ld   [_RAM_C139_], a
	ret

_LABEL_AF32_:
	ld   a, [_RAM_C153_]
	inc  a
	cp   $07
	jr   nz, _LABEL_AF3B_
	xor  a
_LABEL_AF3B_:
	ld   [_RAM_C153_], a
	ld   a, [_RAM_C154_]
	ld   hl, _DATA_AEC5_ - 1
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	cp   $1C
	jr   z, _LABEL_AF76_
	ld   c, a
	ld   a, [_RAM_C152_]
	inc  a
	inc  c
	cp   c
	jr   z, _LABEL_AF5C_
	ld   [_RAM_C152_], a
	ret

_LABEL_AF5C_:
	ld   a, $01
	ld   [_RAM_C152_], a
	ld   a, [_RAM_C154_]
	inc  a
	cp   $0D
	jr   nz, _LABEL_AF72_
	ld   a, [_RAM_C155_]
	inc  a
	ld   [_RAM_C155_], a
	ld   a, $01
_LABEL_AF72_:
	ld   [_RAM_C154_], a
	ret

_LABEL_AF76_:
	ld   a, [_RAM_C152_]
	inc  a
	cp   $1E
	jr   z, _LABEL_AF5C_
	cp   $1D
	jr   z, _LABEL_AF86_
	ld   [_RAM_C152_], a
	ret

_LABEL_AF86_:
	ld   a, [_RAM_C155_]
	and  $03
	jr   nz, _LABEL_AF5C_
	ld   a, $1D
	ld   [_RAM_C152_], a
	ret

_LABEL_AF93_:
	ld   a, [_RAM_C153_]
	dec  a
	cp   $FF
	jr   nz, _LABEL_AF9D_
	ld   a, $06
_LABEL_AF9D_:
	ld   [_RAM_C153_], a
	ld   a, [_RAM_C152_]
	dec  a
	ld   [_RAM_C152_], a
	ret  nz
	ld   a, [_RAM_C154_]
	dec  a
	jr   nz, _LABEL_AFB7_
	ld   a, [_RAM_C155_]
	dec  a
	ld   [_RAM_C155_], a
	ld   a, $0C
_LABEL_AFB7_:
	ld   [_RAM_C154_], a
	ld   hl, _DATA_AEC5_ - 1
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	cp   $1C
	jr   z, _LABEL_AFCC_
	ld   [_RAM_C152_], a
	ret

_LABEL_AFCC_:
	ld   a, [_RAM_C155_]
	and  $03
	jr   z, _LABEL_AFD9_
	ld   a, $1C
	ld   [_RAM_C152_], a
	ret

_LABEL_AFD9_:
	ld   a, $1D
	ld   [_RAM_C152_], a
	ret

_LABEL_AFDF_:
	ld   a, [_RAM_C137_]
	dec  a
	cp   $FF
	jr   nz, _LABEL_AFE9_
	ld   a, $06
_LABEL_AFE9_:
	ld   a, [_RAM_C139_]
	dec  a
	ld   [_RAM_C139_], a
	ret  nz
	ld   a, [_RAM_C138_]
	dec  a
	jr   nz, _LABEL_B000_
	ld   a, [_RAM_C13A_]
	dec  a
	ld   [_RAM_C13A_], a
	ld   a, $0C
_LABEL_B000_:
	ld   [_RAM_C138_], a
	ld   hl, _DATA_AEC5_ - 1
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, [hl]
	cp   $1C
	jr   z, _LABEL_B015_
	ld   [_RAM_C139_], a
	ret

_LABEL_B015_:
	ld   a, [_RAM_C13A_]
	and  $03
	jr   z, _LABEL_B022_
	ld   a, $1C
	ld   [_RAM_C139_], a
	ret

_LABEL_B022_:
	ld   a, $1D
	ld   [_RAM_C139_], a
	ret

_LABEL_B028_:
	ld   de, _RAM_C261_
	ld   hl, _RAM_C703_
	call _LABEL_2BA9_
	call _LABEL_2BA9_
	dec  hl
	dec  hl
	ldi  a, [hl]
	cp   $18
	ret  nc
	ldi  a, [hl]
	cp   $3C
	ret  nc
	xor  a
	ret

_LABEL_B040_:
	ld   b, a
	and  $0C
	or   a
	jp   nz, _LABEL_200_
	ld   a, b
	and  $03
	or   a
	jr   z, _LABEL_B0B2_
	ld   a, [_RAM_C258_]
	cp   $28
	jr   c, _LABEL_B0B2_
	cp   $73
	jr   nc, _LABEL_B0B2_
	sub  $08
	and  $0F
	cp   $0B
	jr   nc, _LABEL_B0B2_
	ld   a, [_RAM_C259_]
	cp   $52
	jr   c, _LABEL_B0B2_
	cp   $9F
	jr   nc, _LABEL_B0B2_
	sub  $02
	and  $0F
	cp   $0B
	jr   nc, _LABEL_B0B2_
	ld   a, [_RAM_C259_]
	cp   $94
	jr   c, _LABEL_B085_
	ld   a, [_RAM_C258_]
	cp   $38
	jr   c, _LABEL_B0B2_
	cp   $63
	jr   nc, _LABEL_B0B2_
_LABEL_B085_:
	ld   a, [_RAM_C25A_]
	cp   $3A
	jr   nz, _LABEL_B08F_
	ld   a, $FF
	ret

_LABEL_B08F_:
	inc  a
	ld   [_RAM_C25A_], a
	ld   hl, _DATA_B0FA_
	ld   a, [_RAM_C259_]
	sub  $52
	call _LABEL_2909_
	ld   e, a
	add  a
	add  a
	add  e
	ld   e, a
	ld   d, $00
	ld   a, [_RAM_C258_]
	sub  $28
	call _LABEL_2909_
	add  e
	ld   e, a
	add  hl, de
	ld   a, [hl]
	ret

_LABEL_B0B2_:
	ld   a, $39
	ld   [_RAM_C25A_], a
	bit  7, b
	call nz, _LABEL_B0CE_
	bit  6, b
	call nz, _LABEL_B0D9_
	bit  5, b
	call nz, _LABEL_B0E4_
	bit  4, b
	call nz, _LABEL_B0EF_
	ld   a, $FF
	ret

_LABEL_B0CE_:
	ld   a, [_RAM_C259_]
	inc  a
	cp   $98
	ret  z
	ld   [_RAM_C259_], a
	ret

_LABEL_B0D9_:
	ld   a, [_RAM_C259_]
	dec  a
	cp   $50
	ret  z
	ld   [_RAM_C259_], a
	ret

_LABEL_B0E4_:
	ld   a, [_RAM_C258_]
	dec  a
	cp   $08
	ret  z
	ld   [_RAM_C258_], a
	ret

_LABEL_B0EF_:
	ld   a, [_RAM_C258_]
	inc  a
	cp   $88
	ret  z
	ld   [_RAM_C258_], a
	ret

; Data from B0FA to B112 (25 bytes)
_DATA_B0FA_:
db $75, $7F, $25, $6A, $7F, $74, $31, $32, $33, $68, $72, $34, $35, $36, $2D, $79
db $37, $38, $39, $2B, $21, $2E, $30, $3D, $21

; Data from B113 to B144 (50 bytes)
_DATA_B113_:
db $30, $50, $40, $50, $50, $50, $60, $50, $70, $50, $30, $60, $40, $60, $50, $60
db $60, $60, $70, $60, $30, $70, $40, $70, $50, $70, $60, $70, $70, $70, $30, $80
db $40, $80, $50, $80, $60, $80, $70, $80, $30, $90, $40, $90, $50, $90, $60, $90
db $70, $90

_LABEL_B145_:
	ld   a, [_RAM_C10A_]
	or   a
	ret  z
	ld   a, [_RAM_C595_]
	or   a
	ret  z
	ld   a, [_RAM_C593_]
	ld   c, a
	ld   a, [_RAM_C594_]
	ld   b, a
	ld   e, $3B
	ld   hl, _RAM_C595_
	dec  [hl]
	jp   _LABEL_1504_

_LABEL_B160_:
	ld   de, _RAM_C261_
	ld   hl, _RAM_C700_
	call _LABEL_2BA9_
	call _LABEL_2BA9_
	call _LABEL_2BA9_
	call _LABEL_2BA9_
	push hl
	call _LABEL_1352_
	pop  hl
	dec  hl
	dec  hl
	ld   a, [hl]
	cp   $13
	jr   z, _LABEL_B18C_
	ret  c
	cp   $14
	jr   z, _LABEL_B18C_
	cp   $15
	ret  nz
	inc  hl
	ld   a, [hl]
	cp   $38
	ret  nc
	dec  hl
_LABEL_B18C_:
	ldi  a, [hl]
	sub  $13
	or   a
	jr   z, _LABEL_B19B_
	ld   b, a
	ld   a, $00
	ld   c, $64
_LABEL_B197_:
	add  c
	dec  b
	jr   nz, _LABEL_B197_
_LABEL_B19B_:
	add  [hl]
	dec  hl
	ldd  [hl], a
	ld   c, a
	ldd  a, [hl]
	ld   b, a
	cp   $0D
	ret  nc
	or   a
	jr   nz, _LABEL_B1A9_
	inc  a
	ret

_LABEL_B1A9_:
	ld   de, _DATA_AEC5_ - 1
	add  e
	ld   e, a
	ld   a, d
	adc  $00
	ld   d, a
	ld   a, [de]
	ld   e, a
	ld   a, b
	cp   $01
	jr   nz, _LABEL_B1BF_
	ld   a, c
	and  $03
	jr   nz, _LABEL_B1BF_
	inc  e
_LABEL_B1BF_:
	ld   a, [hl]
	or   a
	jr   nz, _LABEL_B1C5_
	inc  a
	ret

_LABEL_B1C5_:
	inc  e
	cp   e
	ret  nc
	xor  a
	ret

_LABEL_B1CA_:
	ld   a, [_RAM_C10B_]
	push af
	ld   a, [_SRAM_231_]
	inc  a
	ld   [_RAM_C10B_], a
	call _LABEL_B7F7_
	pop  af
	ld   [_RAM_C10B_], a
	ld   hl, _RAM_C700_
	ld   a, [_RAM_C139_]
	ldi  [hl], a
	ld   a, [_RAM_C138_]
	ldi  [hl], a
	ld   a, [_RAM_C13A_]
	ldi  [hl], a
	xor  a
	ldi  [hl], a
	ldi  [hl], a
	ldi  [hl], a
	ld   a, $20
	ld   b, $3C
_LABEL_B1F3_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B1F3_
_LABEL_B1F7_:
	call _LABEL_24D5_
	call _LABEL_1563_
	call _LABEL_2B_
	ld   a, $03
	ld   [_RAM_C280_], a
	ld   hl, _TILEMAP0
	ld   de, $002C
	rst  $20	; _LABEL_20_
_LABEL_B20C_:
	ld   hl, _RAM_C700_
	ld   a, [_RAM_C139_]
	ldi  [hl], a
	ld   a, [_RAM_C138_]
	ldi  [hl], a
	ld   a, [_RAM_C13A_]
	ldi  [hl], a
	call _LABEL_1352_
	ld   a, [_RAM_C700_]
	ld   hl, $C261
	call _LABEL_2BBA_
	ld   a, [_RAM_C701_]
	ld   hl, $C263
	call _LABEL_2BBA_
	call _LABEL_1352_
	ld   hl, _RAM_C265_
	ld   [hl], $31
	inc  hl
	ld   [hl], $39
	inc  hl
	ld   [hl], $30
	inc  hl
	ld   [hl], $30
	ld   a, [_RAM_C702_]
	call _LABEL_235A_
	ld   a, $10
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $0700
	ld   de, $2373
	ld   hl, $C261
	ld   a, $10
	call _LABEL_2411_
	call _LABEL_B160_
	or   a
	jr   nz, _LABEL_B20C_
	ld   de, $2150
	ld   hl, _TILEMAP0
	rst  $20	; _LABEL_20_
	call _LABEL_B62F_
	ld   hl, (_TILEMAP0 + $20)
	ld   de, $002D
	rst  $20	; _LABEL_20_
_LABEL_B271_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_B271_
	or   a
	jp   z, _LABEL_2218_
	cp   $3D
	jr   z, _LABEL_B2BF_
	push af
	ld   a, [_RAM_C232_]
	ld   d, $00
	ld   e, a
	ld   hl, $63B7
	add  hl, de
	pop  af
	cp   [hl]
	jr   nz, _LABEL_B271_
_LABEL_B28D_:
	ld   hl, (_TILEMAP0 + $20)
	ld   de, $2150
	rst  $20	; _LABEL_20_
	ld   hl, (_TILEMAP0 + $20)
	ld   de, $002E
	rst  $20	; _LABEL_20_
	ld   hl, _RAM_C261_
	ld   a, $30
	ldi  [hl], a
	ldi  [hl], a
	ldi  [hl], a
	ldi  [hl], a
	ld   a, $11
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $0300
	ld   de, $2373
	ld   hl, $C261
	ld   a, $18
	call _LABEL_2411_
	call _LABEL_B028_
	or   a
	jr   nz, _LABEL_B28D_
	jr   _LABEL_B2CD_

_LABEL_B2BF_:
	ld   a, $63
	ld   [_RAM_C703_], a
	ld   de, $2150
	ld   hl, (_TILEMAP0 + $20)
	rst  $20	; _LABEL_20_
	jr   _LABEL_B31C_

_LABEL_B2CD_:
	ld   de, $0030
	ld   hl, (_TILEMAP0 + $40)
	rst  $20	; _LABEL_20_
	ld   de, $0031
	ld   hl, (_TILEMAP0 + $60)
	rst  $20	; _LABEL_20_
	ld   de, $0032
	ld   hl, (_TILEMAP0 + $80)
	rst  $20	; _LABEL_20_
	ld   de, $0033
	ld   hl, $98A0
	rst  $20	; _LABEL_20_
	ld   de, $0034
	ld   hl, $98C0
	rst  $20	; _LABEL_20_
_LABEL_B2F0_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_B2F0_
	or   a
	jp   z, _LABEL_2218_
	cp   $31
	jr   c, _LABEL_B2F0_
	cp   $35
	jr   nc, _LABEL_B2F0_
	sub  $30
	ld   [_RAM_C705_], a
	ld   hl, (_TILEMAP0 + $40)
	ld   b, $05
_LABEL_B30B_:
	push bc
	push hl
	ld   de, $2150
	rst  $20	; _LABEL_20_
	pop  hl
	ld   bc, $0020
	add  hl, bc
	pop  bc
	dec  b
	jr   nz, _LABEL_B30B_
	jr   _LABEL_B320_

_LABEL_B31C_:
	xor  a
	ld   [_RAM_C705_], a
_LABEL_B320_:
	call _LABEL_B4D4_
	ld   de, $0035
	ld   hl, (_TILEMAP0 + $60)
	rst  $20	; _LABEL_20_
_LABEL_B32A_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_B32A_
	or   a
	jp   z, _LABEL_2218_
	cp   $3D
	jr   z, _LABEL_B36E_
	push af
	ld   a, [_RAM_C232_]
	ld   d, $00
	ld   e, a
	ld   hl, $63B7
	add  hl, de
	pop  af
	cp   [hl]
	jr   nz, _LABEL_B32A_
	ld   de, $0036
	ld   hl, (_TILEMAP0 + $60)
	rst  $20	; _LABEL_20_
_LABEL_B34D_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_B34D_
	or   a
	jp   z, _LABEL_2218_
	cp   $31
	jr   c, _LABEL_B34D_
	cp   $38
	jr   nc, _LABEL_B34D_
	sub  $30
	add  a
	add  a
	add  a
	add  a
	ld   e, a
	ld   a, [_RAM_C705_]
	add  e
	ld   [_RAM_C705_], a
	jr   _LABEL_B375_

_LABEL_B36E_:
	ld   de, $2150
	ld   hl, (_TILEMAP0 + $60)
	rst  $20	; _LABEL_20_
_LABEL_B375_:
	call _LABEL_B6E0_
	call _LABEL_B4C5_
	call _LABEL_B7BA_
	call _LABEL_B4F8_
	call _LABEL_26C_
	call gfx__clear_shadow_oam__275B
	call _LABEL_B3C0_
	ld   a, [_RAM_C596_]
	or   a
	jr   z, _LABEL_B395_
	ld   a, [_RAM_C10B_]
	jr   _LABEL_B3E9_

_LABEL_B395_:
	ld   a, [_SRAM_231_]
	inc  a
	ld   [_SRAM_231_], a
	ld   [_RAM_C10B_], a
	call _LABEL_B3E9_
	jp   _LABEL_B7F7_

_LABEL_B3A5_:
	ld   hl, _RAM_C466_
	ld   de, _RAM_C467_
	ld   b, $0A
_LABEL_B3AD_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B3AD_
	ld   a, $25
	ld   [hl], a
	ld   a, $3D
	ld   [_RAM_C590_], a
	ret

; Data from B3BC to B3BF (4 bytes)
db $31, $30, $30, $00

_LABEL_B3C0_:
	ld   a, [_RAM_C705_]
	and  $0F
	cp   $04
	ret  nz
	call _LABEL_DE6_
	ld   a, [_SRAM_231_]
	or   a
	ret  z
	ld   b, a
	ld   hl, _SRAM_238_
_LABEL_B3D4_:
	ld   a, [hl]
	and  $0F
	cp   $04
	jr   nz, _LABEL_B3E1_
	ld   a, [hl]
	and  $F0
	add  $01
	ld   [hl], a
_LABEL_B3E1_:
	ld   de, $0042
	add  hl, de
	dec  b
	jr   nz, _LABEL_B3D4_
	ret

_LABEL_B3E9_:
	dec  a
	call _LABEL_B4EB_
	ld   de, $A233
	add  hl, de
	ld   de, _RAM_C700_
	ld   b, $42
_LABEL_B3F6_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B3F6_
	ld   a, [_SRAM_231_]
	cp   $01
	ret  z
	ld   hl, _RAM_C7B4_
	ld   b, $01
_LABEL_B407_:
	ld   [hl], b
	inc  hl
	inc  b
	dec  a
	jr   nz, _LABEL_B407_
	ld   a, [_SRAM_231_]
_LABEL_B410_:
	push af
	ld   a, [_SRAM_231_]
	dec  a
_LABEL_B415_:
	push af
	dec  a
	call _LABEL_B4EB_
	ld   de, _SRAM_235_
	add  hl, de
	pop  af
	push af
	push hl
	call _LABEL_B4EB_
	ld   de, $A235
	add  hl, de
	pop  de
	ld   a, [de]
	cp   [hl]
	jr   c, _LABEL_B4A4_
	jr   nz, _LABEL_B45D_
	dec  de
	dec  hl
	ld   a, [de]
	cp   [hl]
	jr   c, _LABEL_B4A4_
	jr   nz, _LABEL_B45D_
	dec  de
	dec  hl
	ld   a, [de]
	cp   [hl]
	jr   c, _LABEL_B4A4_
	jr   nz, _LABEL_B45D_
	inc  de
	inc  de
	inc  de
	inc  hl
	inc  hl
	inc  hl
	ld   a, [de]
	cp   $63
	jr   z, _LABEL_B4A4_
	ld   a, [hl]
	cp   $63
	jr   z, _LABEL_B45D_
	ld   a, [de]
	cp   [hl]
	jr   c, _LABEL_B4A4_
	jr   nz, _LABEL_B45D_
	inc  de
	inc  hl
	ld   a, [de]
	cp   [hl]
	jr   c, _LABEL_B4A4_
	jr   z, _LABEL_B4A4_
_LABEL_B45D_:
	pop  af
	push af
	dec  a
	ld   hl, _RAM_C7B4_
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ldi  a, [hl]
	ld   b, [hl]
	ldd  [hl], a
	ld   [hl], b
	pop  af
	push af
	dec  a
	call _LABEL_B4EB_
	ld   de, _SRAM_233_
	add  hl, de
	push hl
	ld   de, _RAM_C764_
	ld   b, $42
_LABEL_B47D_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_B47D_
	pop  hl
	pop  af
	push af
	push hl
	call _LABEL_B4EB_
	ld   de, _SRAM_233_
	add  hl, de
	pop  de
	push hl
	ld   b, $42
_LABEL_B492_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_B492_
	pop  de
	ld   hl, _RAM_C764_
	ld   b, $42
_LABEL_B49E_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_B49E_
_LABEL_B4A4_:
	pop  af
	dec  a
	jp   nz, _LABEL_B415_
	pop  af
	dec  a
	jp   nz, _LABEL_B410_
	ld   a, [_RAM_C10B_]
	ld   b, a
	ld   hl, _RAM_C7B4_
	ld   c, $01
_LABEL_B4B7_:
	ldi  a, [hl]
	cp   b
	jr   z, _LABEL_B4BE_
	inc  c
	jr   _LABEL_B4B7_

_LABEL_B4BE_:
	ld   a, c
	ld   [_RAM_C10B_], a
	jp   _LABEL_B7F7_

_LABEL_B4C5_:
	ld   hl, $98C0
	ld   de, $761A
	rst  $20	; _LABEL_20_
	ld   hl, $9940
	ld   de, $761A
	rst  $20	; _LABEL_20_
	ret

_LABEL_B4D4_:
	ld   a, [_RAM_C705_]
	and  $0F
	add  $4D
	ld   h, $00
	ld   l, a
	add  hl, hl
	ld   de, _RAM_CF00_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, (_TILEMAP0 + $40)
	rst  $20	; _LABEL_20_
	ret

_LABEL_B4EB_:
	add  a
	ld   h, $00
	ld   l, a
	ld   d, h
	ld   e, l
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, hl
	add  hl, de
	ret

_LABEL_B4F8_:
	ld   a, $08
	ld   [_RAM_C281_], a
	ld   a, $48
	ld   [_RAM_C282_], a
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	xor  a
	ld   [_RAM_C130_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_B513_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_B513_
	or   a
	ret  z
	cp   $0B
	jr   nz, _LABEL_B52C_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_B513_

_LABEL_B52C_:
	cp   $C7
	jr   nz, _LABEL_B54D_
	ld   a, [_RAM_C281_]
	sub  $08
	call _LABEL_21D7_
	ld   c, a
	ld   a, [_RAM_C282_]
	sub  $48
	call _LABEL_21D7_
	ld   b, a
	ld   hl, _RAM_C706_
	ld   de, $98E0
	call _LABEL_2173_
	jr   _LABEL_B513_

_LABEL_B54D_:
	cp   $0C
	jr   nz, _LABEL_B55B_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jr   _LABEL_B513_

_LABEL_B55B_:
	cp   $0F
	jr   c, _LABEL_B583_
	cp   $13
	jr   nc, _LABEL_B583_
	cp   $0F
	jr   z, _LABEL_B574_
	cp   $10
	jr   z, _LABEL_B579_
	cp   $11
	jr   z, _LABEL_B57E_
_LABEL_B56F_:
	call _LABEL_B5B0_
	jr   _LABEL_B513_

_LABEL_B574_:
	call _LABEL_B5BF_
	jr   _LABEL_B513_

_LABEL_B579_:
	call _LABEL_B5CC_
	jr   _LABEL_B513_

_LABEL_B57E_:
	call _LABEL_B5DE_
	jr   _LABEL_B513_

_LABEL_B583_:
	cp   $80
	jr   nz, _LABEL_B592_
	call _LABEL_B5CC_
	ld   a, $20
	call _LABEL_B5EE_
	jp   _LABEL_B513_

_LABEL_B592_:
	cp   $7E
	jr   z, _LABEL_B5A6_
	cp   $61
	jp   nc, _LABEL_B513_
	cp   $0D
	jr   nz, _LABEL_B5A6_
	ld   a, $08
	ld   [_RAM_C281_], a
	jr   _LABEL_B56F_

_LABEL_B5A6_:
	cp   $20
	jp   c, _LABEL_B513_
	call _LABEL_B5EE_
	jr   _LABEL_B57E_

_LABEL_B5B0_:
	ld   a, [_RAM_C282_]
	add  $08
	cp   $60
	jr   nz, _LABEL_B5BB_
	ld   a, $48
_LABEL_B5BB_:
	ld   [_RAM_C282_], a
	ret

_LABEL_B5BF_:
	ld   a, [_RAM_C282_]
	sub  $08
	cp   $40
	jr   nz, _LABEL_B5BB_
	ld   a, $58
	jr   _LABEL_B5BB_

_LABEL_B5CC_:
	ld   a, [_RAM_C281_]
	sub  $08
	jr   nz, _LABEL_B5DA_
	ld   a, $A0
	ld   [_RAM_C281_], a
	jr   _LABEL_B5BF_

_LABEL_B5DA_:
	ld   [_RAM_C281_], a
	ret

_LABEL_B5DE_:
	ld   a, [_RAM_C281_]
	add  $08
	cp   $A8
	jr   nz, _LABEL_B5DA_
	ld   a, $08
	ld   [_RAM_C281_], a
	jr   _LABEL_B5B0_

_LABEL_B5EE_:
	push af
	ld   a, [_RAM_C282_]
	ld   hl, $C706
	ld   bc, $0014
	sub  $48
	jr   z, _LABEL_B601_
_LABEL_B5FC_:
	add  hl, bc
	sub  $08
	jr   nz, _LABEL_B5FC_
_LABEL_B601_:
	ld   a, [_RAM_C281_]
	sub  $08
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	pop  af
	ld   [hl], a
	jp   _LABEL_73A_

; Data from B61A to B62E (21 bytes)
ds 20, $2D
db $00

_LABEL_B62F_:
	ld   hl, _RAM_C265_
	ld   [hl], $31
	inc  hl
	ld   [hl], $39
	inc  hl
	ld   [hl], $30
	inc  hl
	ld   [hl], $30
	ld   a, [_RAM_C702_]
	call _LABEL_235A_
	ld   hl, _RAM_C265_
	ld   de, _RAM_C597_
	ld   b, $04
_LABEL_B64B_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_B64B_
	ld   hl, _RAM_C261_
	ld   a, [_RAM_C700_]
	call _LABEL_B6CD_
	ld   a, b
	cp   $30
	jr   z, _LABEL_B660_
	ldi  [hl], a
_LABEL_B660_:
	ld   a, c
	ld   [hl], a
	dec  hl
	ld   a, [hl]
	inc  hl
	inc  hl
	cp   $31
	jr   z, _LABEL_B686_
	ld   a, c
	cp   $31
	jr   nz, _LABEL_B674_
	ld   de, $0046
	jr   _LABEL_B689_

_LABEL_B674_:
	cp   $32
	jr   nz, _LABEL_B67D_
	ld   de, $0047
	jr   _LABEL_B689_

_LABEL_B67D_:
	cp   $33
	jr   nz, _LABEL_B686_
	ld   de, $0048
	jr   _LABEL_B689_

_LABEL_B686_:
	ld   de, $0049
_LABEL_B689_:
	push hl
	ld   h, d
	ld   l, e
	add  hl, hl
	ld   de, gfx__tilemap_string_addr_table__RAM_CEFE ; $CEFE
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl
	ld   a, [de]
	inc  de
	ldi  [hl], a
	ld   a, [de]
	ldi  [hl], a
	ld   a, $20
	ldi  [hl], a
	push hl
	ld   a, [_RAM_C701_]
	ld   h, $00
	dec  a
	ld   l, a
	add  hl, hl
	ld   de, _RAM_CF72_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl
_LABEL_B6AE_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_B6B6_
	ldi  [hl], a
	jr   _LABEL_B6AE_

_LABEL_B6B6_:
	ld   [hl], $20
	inc  hl
	ld   de, _RAM_C597_
	ld   b, $04
_LABEL_B6BE_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B6BE_
	ld   [hl], b
	ld   hl, _TILEMAP0
	ld   de, $C261
	rst  $20	; _LABEL_20_
	ret

_LABEL_B6CD_:
	ld   b, $00
_LABEL_B6CF_:
	cp   $0A
	jr   c, _LABEL_B6D8_
	sub  $0A
	inc  b
	jr   _LABEL_B6CF_

_LABEL_B6D8_:
	add  $30
	ld   c, a
	ld   a, b
	add  $30
	ld   b, a
	ret

_LABEL_B6E0_:
	ld   hl, (_TILEMAP0 + $60)
	ld   de, $2150
	rst  $20	; _LABEL_20_
	ld   hl, _RAM_C261_
	ld   a, $20
	ld   b, $14
_LABEL_B6EE_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B6EE_
	ld   a, [_RAM_C705_]
	call _LABEL_2909_
	or   a
	jr   nz, _LABEL_B706_
	ld   de, $0049
	ld   hl, _RAM_C261_
	call _LABEL_B730_
	jr   _LABEL_B728_

_LABEL_B706_:
	push af
	ld   de, $004A
	ld   hl, _RAM_C261_
	call _LABEL_B730_
	pop  af
	dec  hl
	cp   $01
	jr   nz, _LABEL_B71E_
	ld   de, $004B
	call _LABEL_B730_
	jr   _LABEL_B728_

_LABEL_B71E_:
	add  $30
	ldi  [hl], a
	inc  hl
	ld   de, $004C
	call _LABEL_B730_
_LABEL_B728_:
	ld   de, $C261
	ld   hl, (_TILEMAP0 + $60)
	rst  $20	; _LABEL_20_
	ret

_LABEL_B730_:
	push hl
	ld   h, d
	ld   l, e
	add  hl, hl
	ld   de, $CF00
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	pop  hl
_LABEL_B73C_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_B73C_
	ret

_LABEL_B743_:
	call gfx__turn_on_screen_bg_obj__2540
	ld   hl, $99C0
	ld   de, $0617
	rst  $20	; _LABEL_20_
	ld   hl, $9A00
	ld   de, $00D3
	rst  $20	; _LABEL_20_
	ld   hl, $9A20
	ld   de, $0005
	rst  $20	; _LABEL_20_
	ret

_LABEL_B75C_:
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	call _LABEL_B809_
_LABEL_B765_:
	ld   a, [_RAM_C10B_]
	or   a
	jp   z, _LABEL_24D5_
	call _LABEL_B7F7_
	ld   a, [_RAM_C10B_]
	dec  a
	call _LABEL_B4EB_
	ld   de, _SRAM_233_
	add  hl, de
	ld   de, _RAM_C700_
	ld   b, $42
_LABEL_B77F_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_B77F_
	call _LABEL_24D5_
	call _LABEL_B62F_
	ld   a, [_RAM_C703_]
	cp   $63
	jr   z, _LABEL_B7B1_
	ld   hl, _RAM_C261_
	call _LABEL_B7E2_
	ld   [hl], $3A
	inc  hl
	ld   a, [_RAM_C704_]
	call _LABEL_B7E2_
	ld   [hl], $00
	ld   de, $002E
	ld   hl, (_TILEMAP0 + $20)
	rst  $20	; _LABEL_20_
	ld   de, $C261
	ld   hl, (_TILEMAP0 + $25)
	rst  $20	; _LABEL_20_
_LABEL_B7B1_:
	call _LABEL_B4D4_
	call _LABEL_B6E0_
	call _LABEL_B4C5_
_LABEL_B7BA_:
	ld   de, _RAM_C706_
	ld   hl, $98E0
	ld   b, $03
_LABEL_B7C2_:
	push bc
	push hl
	ld   hl, _RAM_C261_
	ld   b, $14
_LABEL_B7C9_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B7C9_
	ld   [hl], b
	pop  hl
	push hl
	push de
	ld   de, $C261
	rst  $20	; _LABEL_20_
	pop  de
	pop  hl
	ld   bc, $0020
	add  hl, bc
	pop  bc
	dec  b
	jr   nz, _LABEL_B7C2_
	ret

_LABEL_B7E2_:
	ld   b, $00
_LABEL_B7E4_:
	cp   $0A
	jr   c, _LABEL_B7ED_
	inc  b
	sub  $0A
	jr   _LABEL_B7E4_

_LABEL_B7ED_:
	add  $30
	ld   c, a
	ld   a, b
	add  $30
	ldi  [hl], a
	ld   [hl], c
	inc  hl
	ret

_LABEL_B7F7_:
	ld   a, [_RAM_C10D_]
	push af
	ld   a, [_RAM_C10B_]
	ld   [_RAM_C10D_], a
	call _LABEL_7B3_
	pop  af
	ld   [_RAM_C10D_], a
	ret

_LABEL_B809_:
	ld   hl, _RAM_CF04_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, $99E0
_LABEL_B812_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_B81C_
	sub  $20
	ldi  [hl], a
	jr   _LABEL_B812_

_LABEL_B81C_:
	jp   _LABEL_B743_

; Data from B81F to B845 (39 bytes)
db $FA, $77, $C4, $FE, $7F, $C8, $FA, $74, $C4, $B7, $20, $1A, $FA, $73, $C4, $B7
db $28, $14, $3D, $EA, $72, $C4, $3E, $1C, $EA, $7C, $C2, $DF, $3E, $20, $EA, $90
db $C5, $3E, $01, $EA, $7C, $C2, $C9

_LABEL_B846_:
	ld   a, [_RAM_C474_]
	or   a
	jr   nz, _LABEL_B866_
	ld   a, [_RAM_C473_]
	or   a
	jr   z, _LABEL_B856_
	dec  a
	ld   [_RAM_C472_], a
_LABEL_B856_:
	ld   a, $1C
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $20
	ld   [_RAM_C590_], a
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_B866_:
	ld   hl, _RAM_C466_
	ld   b, $0A
	ld   a, $20
_LABEL_B86D_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B86D_
	ld   hl, _SRAM_222_
	ld   b, $00
_LABEL_B876_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_B87D_
	inc  b
	jr   _LABEL_B876_

_LABEL_B87D_:
	ld   a, b
	ld   [_RAM_C474_], a
	inc  b
	ld   de, _RAM_C471_
	dec  hl
_LABEL_B886_:
	ldd  a, [hl]
	cp   $2E
	jr   nz, _LABEL_B88E_
	ld   [_RAM_C475_], a
_LABEL_B88E_:
	ld   [de], a
	dec  de
	dec  b
	jr   nz, _LABEL_B886_
	ret

_LABEL_B894_:
	call _LABEL_B955_
	ld   a, [_SRAM_221_]
	or   a
	jr   nz, _LABEL_B8AB_
	ld   a, $4D
	ld   [_SRAM_221_], a
	ld   a, $30
	ld   [_SRAM_222_], a
	xor  a
	ld   [_SRAM_223_], a
_LABEL_B8AB_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_B948_
	call _LABEL_B937_
	call _LABEL_B8CE_
	xor  a
	ld   [_RAM_C479_], a
	call _LABEL_BD22_
	call _LABEL_AB74_
	call _LABEL_B91B_
	call _LABEL_B964_
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

_LABEL_B8CE_:
	ld   de, _RAM_C3E0_
	ld   hl, $C3F9
	call _LABEL_AAA8_
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	jp   _LABEL_AAA8_

_LABEL_B8E0_:
	call _LABEL_B955_
	ld   a, [_SRAM_221_]
	or   a
	jr   nz, _LABEL_B8F7_
	ld   a, $4D
	ld   [_SRAM_221_], a
	ld   a, $30
	ld   [_SRAM_222_], a
	xor  a
	ld   [_SRAM_223_], a
_LABEL_B8F7_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_B948_
	call _LABEL_B937_
	call _LABEL_B8CE_
	ld   a, $01
	ld   [_RAM_C479_], a
	call _LABEL_BD22_
	call _LABEL_AB74_
	call _LABEL_B91B_
	call _LABEL_B964_
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

_LABEL_B91B_:
	ld   hl, _RAM_C455_
	ld   de, _SRAM_222_
_LABEL_B921_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	or   a
	jr   nz, _LABEL_B921_
	ld   a, [_SRAM_223_]
	or   a
	ret  nz
	ld   a, [_SRAM_222_]
	cp   $30
	ret  nz
	xor  a
	ld   [_SRAM_221_], a
	ret

_LABEL_B937_:
	ld   hl, _RAM_C3EC_
	ld   de, _RAM_C466_
_LABEL_B93D_:
	ld   a, [de]
	inc  de
	cp   $20
	jr   z, _LABEL_B93D_
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_B93D_
	ret

_LABEL_B948_:
	ld   hl, _RAM_C3E0_
	ld   de, _SRAM_222_
_LABEL_B94E_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_B94E_
	ret

_LABEL_B955_:
	ld   hl, _RAM_C3E0_
	ld   de, _RAM_C4A7_
	ld   b, $C7
_LABEL_B95D_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_B95D_
	ret

_LABEL_B964_:
	ld   hl, _RAM_C3E0_
	ld   de, _RAM_C4A7_
	ld   b, $C7
_LABEL_B96C_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_B96C_
	ret

; 2nd entry of Jump Table from 2557 (indexed by vblank__dispatch_select__RAM_C27C)
_LABEL_B973_:
	ld   a, [_SRAM_221_]
	ld   [(_TILEMAP0 + $65)], a
	ld   de, _RAM_C466_
	ld   hl, $98E4
	ld   b, $0B
_LABEL_B981_:
	ld   a, [de]
	sub  $20
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_B981_
	ld   a, [_RAM_C590_]
	sub  $20
	ldi  [hl], a
	jp   vblank__cmd_default__25F7

; Data from B992 to B9EF (94 bytes)
db $21, $84, $98, $CD, $A7, $79, $21, $A4, $98, $CD, $A7, $79, $21, $C4, $98, $CD
db $A7, $79, $C3, $F7, $25, $06, $0C, $AF, $22, $05, $20, $FC, $C9, $FA, $91, $C5
db $B7, $28, $14, $FA, $90, $C5, $FE, $20, $28, $06, $AF, $EA, $91, $C5, $18, $07
db $AF, $EA, $91, $C5, $C3, $F7, $25, $21, $A4, $98, $11, $84, $98, $CD, $E7, $79
db $21, $C4, $98, $11, $A4, $98, $CD, $E7, $79, $21, $E4, $98, $11, $C4, $98, $CD
db $E7, $79, $C3, $F7, $25, $06, $0C, $2A, $12, $13, $05, $20, $FA, $C9

_LABEL_B9F0_:
	ld   a, $20
	ld   [_RAM_C591_], a
	ld   [_RAM_C590_], a
	ld   a, $1B
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   hl, _RAM_C466_
	ld   b, $0A
	ld   a, $20
_LABEL_BA05_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BA05_
	ld   [hl], $30
	inc  hl
	ld   [hl], $00
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	dec  a
	ld   [_RAM_C472_], a
	ld   [_RAM_C475_], a
	ld   [_RAM_C473_], a
	ld   [_RAM_C474_], a
	ld   [_RAM_C476_], a
	ld   [_RAM_C477_], a
_LABEL_BA26_:
	call gfx__clear_shadow_oam__275B
	call _LABEL_B145_
	ld   a, [_RAM_C10A_]
	or   a
	jr   nz, _LABEL_BA41_
	ld   a, [_RAM_C258_]
	ld   c, a
	ld   a, [_RAM_C259_]
	ld   b, a
	ld   a, [_RAM_C25A_]
	ld   e, a
	call _LABEL_1504_
_LABEL_BA41_:
	rst  $18	; Call VSYNC__RST_18
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	push af
	ld   a, [_RAM_C10A_]
	or   a
	jr   nz, _LABEL_BA56_
	ld   a, [_RAM_C592_]
	or   a
	jr   z, _LABEL_BA56_
	call _LABEL_B040_
	pop  bc
	jr   _LABEL_BA5C_

_LABEL_BA56_:
	ld   a, $39
	ld   [_RAM_C25A_], a
	pop  af
_LABEL_BA5C_:
	cp   $FF
	jr   z, _LABEL_BA26_
	or   a
	jp   z, _LABEL_200_
	call _LABEL_1094_
	cp   $7F
	jr   z, _LABEL_B9F0_
	cp   $75
	jr   nz, _LABEL_BA75_
	xor  a
	ld   [_SRAM_221_], a
	jr   _LABEL_BA26_

_LABEL_BA75_:
	cp   $79
	jr   nz, _LABEL_BA84_
	ld   a, [_SRAM_221_]
	or   a
	jr   z, _LABEL_BA26_
	call _LABEL_B846_
	jr   _LABEL_BA26_

_LABEL_BA84_:
	cp   $72
	jr   nz, _LABEL_BA8D_
	call _LABEL_B894_
	jr   _LABEL_BA26_

_LABEL_BA8D_:
	cp   $74
	jr   nz, _LABEL_BA97_
	call _LABEL_B8E0_
	jp   _LABEL_BA26_

_LABEL_BA97_:
	cp   $30
	jr   c, _LABEL_BAFF_
	cp   $3A
	jr   nc, _LABEL_BAFF_
_LABEL_BA9F_:
	ld   c, a
	ld   a, [_RAM_C474_]
	or   a
	jr   nz, _LABEL_BAE3_
	ld   a, [_RAM_C473_]
	or   a
	jr   z, _LABEL_BAB0_
	dec  a
	ld   [_RAM_C472_], a
_LABEL_BAB0_:
	ld   a, $1C
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, $20
	ld   [_RAM_C590_], a
	ld   a, c
	ld   hl, _RAM_C466_
	ld   b, $0A
	ld   a, $20
_LABEL_BAC8_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BAC8_
	ld   [hl], $30
	ld   a, c
	cp   $30
	jr   nz, _LABEL_BAD9_
	ld   [_RAM_C591_], a
	jp   _LABEL_BA26_

_LABEL_BAD9_:
	ld   a, $01
	ld   [_RAM_C474_], a
	ld   hl, _RAM_C470_
	jr   _LABEL_BAFB_

_LABEL_BAE3_:
	cp   $09
	jp   z, _LABEL_BA26_
	inc  a
	ld   [_RAM_C474_], a
	rst  $18	; Call VSYNC__RST_18
	ld   hl, _RAM_C466_
	ld   de, _RAM_C467_
	ld   b, $0A
_LABEL_BAF5_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BAF5_
_LABEL_BAFB_:
	ld   [hl], c
	jp   _LABEL_BA26_

_LABEL_BAFF_:
	cp   $2E
	jr   nz, _LABEL_BB11_
	ld   a, [_RAM_C475_]
	or   a
	jp   nz, _LABEL_BA26_
	ld   a, $2E
	ld   [_RAM_C475_], a
	jr   _LABEL_BA9F_

_LABEL_BB11_:
	cp   $0A
	jp   z, _LABEL_B9F0_
	cp   $3D
	jr   nz, _LABEL_BB5E_
	ld   a, [_RAM_C472_]
	or   a
	jp   z, _LABEL_BA26_
	ld   a, [_RAM_C473_]
	or   a
	jp   nz, _LABEL_BA26_
	ld   a, $3D
	ld   [_RAM_C590_], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $1C
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $20
	ld   [_RAM_C590_], a
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_BB4C_
	ld   a, $01
	ld   [_RAM_C473_], a
	call _LABEL_BBC5_
	jp   _LABEL_BA26_

_LABEL_BB4C_:
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	call _LABEL_BD08_
	ld   a, [_RAM_C479_]
	call _LABEL_BD22_
	jp   _LABEL_AB74_

_LABEL_BB5E_:
	cp   $25
	jr   nz, _LABEL_BB68_
	call _LABEL_BC2D_
	jp   _LABEL_BA26_

_LABEL_BB68_:
	cp   $6A
	jr   nz, _LABEL_BBCE_
	ld   a, $2F
	ld   [_RAM_C590_], a
	ld   a, [_RAM_C473_]
	or   a
	jr   z, _LABEL_BB7E_
	xor  a
	ld   [_RAM_C473_], a
	ld   [_RAM_C472_], a
_LABEL_BB7E_:
	call _LABEL_BB89_
	ld   a, $02
	ld   [_RAM_C479_], a
	jp   _LABEL_BA26_

_LABEL_BB89_:
	ld   a, [_RAM_C477_]
	cp   $6A
	ret  z
	cp   $68
	ret  z
	cp   $2D
	ret  z
	cp   $2B
	ret  z
	ld   a, [_RAM_C472_]
	or   a
	jr   z, _LABEL_BBBC_
	ld   a, [_RAM_C590_]
	push af
	ld   a, $3D
	ld   [_RAM_C590_], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $1C
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	pop  af
	ld   [_RAM_C590_], a
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_BB4C_
	jr   _LABEL_BBC5_

_LABEL_BBBC_:
	ld   de, _RAM_C3E0_
	ld   hl, _RAM_C3F9_
	call _LABEL_BD08_
_LABEL_BBC5_:
	xor  a
	ld   [_RAM_C474_], a
	inc  a
	ld   [_RAM_C472_], a
	ret

_LABEL_BBCE_:
	cp   $68
	jr   nz, _LABEL_BBEF_
	ld   a, $58
	ld   [_RAM_C590_], a
	ld   a, [_RAM_C473_]
	or   a
	jr   z, _LABEL_BBE4_
	xor  a
	ld   [_RAM_C473_], a
	ld   [_RAM_C472_], a
_LABEL_BBE4_:
	call _LABEL_BB89_
	ld   a, $03
	ld   [_RAM_C479_], a
	jp   _LABEL_BA26_

_LABEL_BBEF_:
	cp   $2D
	jr   nz, _LABEL_BC0E_
	ld   [_RAM_C590_], a
	ld   a, [_RAM_C473_]
	or   a
	jr   z, _LABEL_BC03_
	xor  a
	ld   [_RAM_C473_], a
	ld   [_RAM_C472_], a
_LABEL_BC03_:
	call _LABEL_BB89_
	ld   a, $01
	ld   [_RAM_C479_], a
	jp   _LABEL_BA26_

_LABEL_BC0E_:
	cp   $2B
	jp   nz, _LABEL_BA26_
	ld   [_RAM_C590_], a
	ld   a, [_RAM_C473_]
	or   a
	jr   z, _LABEL_BC23_
	xor  a
	ld   [_RAM_C473_], a
	ld   [_RAM_C472_], a
_LABEL_BC23_:
	call _LABEL_BB89_
	xor  a
	ld   [_RAM_C479_], a
	jp   _LABEL_BA26_

_LABEL_BC2D_:
	ld   a, [_RAM_C477_]
	cp   $6A
	ret  z
	cp   $68
	ret  z
	cp   $2D
	ret  z
	cp   $2B
	ret  z
	ld   a, [_RAM_C473_]
	or   a
	jr   nz, _LABEL_BC48_
	ld   a, [_RAM_C472_]
	or   a
	jr   nz, _LABEL_BC85_
_LABEL_BC48_:
	ld   de, _RAM_C3E0_
	ld   hl, $C3F9
	call _LABEL_BD08_
	call _LABEL_B3A5_
	ld   de, $73BC
	ld   hl, $C40A
	call _LABEL_BD08_
	ld   a, $02
	ld   [_RAM_C479_], a
_LABEL_BC62_:
	call _LABEL_BD22_
	ld   a, $1C
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $20
	ld   [_RAM_C590_], a
	ld   a, $01
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_AB74_
	ld   a, $01
	ld   [_RAM_C473_], a
	dec  a
	ld   [_RAM_C472_], a
	ld   [_RAM_C474_], a
	ret

_LABEL_BC85_:
	ld   de, _RAM_C3E0_
	ld   hl, _RAM_C900_
	ld   b, $0B
_LABEL_BC8D_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BC8D_
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	call _LABEL_BD08_
	call _LABEL_B3A5_
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C479_]
	cp   $02
	jr   c, _LABEL_BCB4_
	ld   a, [_RAM_C40A_]
	sub  $02
	ld   [_RAM_C40A_], a
	ld   a, [_RAM_C479_]
	jr   _LABEL_BC62_

_LABEL_BCB4_:
	ld   de, $73BC
	ld   hl, $C3F9
	call _LABEL_BD08_
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, [_RAM_C479_]
	call _LABEL_BD22_
	call _LABEL_AB74_
	ld   de, _RAM_C455_
	ld   hl, _RAM_C3E0_
	ld   b, $0B
_LABEL_BCD2_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BCD2_
	ld   de, _RAM_C900_
	ld   hl, _RAM_C3EC_
	ld   b, $0B
_LABEL_BCE0_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BCE0_
	ld   de, _RAM_C3E0_
	ld   hl, $C3F9
	call _LABEL_AAA8_
	ld   a, [_RAM_C3F9_]
	sub  $02
	ld   [_RAM_C3F9_], a
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	call _LABEL_AAA8_
	ld   a, $03
	ld   [_RAM_C479_], a
	jp   _LABEL_BC62_

_LABEL_BD08_:
	push hl
	push de
	ld   hl, _RAM_C466_
	ld   b, $0C
_LABEL_BD0F_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_BD0F_
	pop  de
	pop  hl
	jp   _LABEL_AAA8_

; Jump Table from BD1A to BD1B (1 entries, indexed by unknown)
_DATA_BD1A_:
dw _LABEL_AA37_

; Jump Table from BD1C to BD1D (1 entries, indexed by unknown)
dw _LABEL_BD2E_

; Jump Table from BD1E to BD1F (1 entries, indexed by unknown)
dw _LABEL_A69C_

; Jump Table from BD20 to BD21 (1 entries, indexed by unknown)
dw _LABEL_A874_

_LABEL_BD22_:
	ld   h, $00
	add  a
	ld   l, a
	ld   de, _DATA_BD1A_
	add  hl, de
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	jp   hl

; 1st entry of Jump Table from BD1C (indexed by unknown)
_LABEL_BD2E_:
	call _LABEL_A614_
_LABEL_BD31_:
	ld   a, [_RAM_C3F8_]
	ld   c, a
	ld   a, [_RAM_C409_]
	add  c
	cp   $FF
	jr   nz, _LABEL_BD49_
	ld   a, [_RAM_C3F8_]
	ld   [_RAM_C409_], a
	ld   [_RAM_C41A_], a
	jp   _LABEL_AA58_

_LABEL_BD49_:
	ld   hl, _RAM_C3FA_
	ld   de, _RAM_C40B_
	ld   b, $0A
_LABEL_BD51_:
	ld   a, [de]
	inc  de
	ld   c, a
	ldi  a, [hl]
	cp   c
	jr   z, _LABEL_BD5C_
	jr   c, _LABEL_BD61_
	jr   _LABEL_BD7B_

_LABEL_BD5C_:
	dec  c
	jr   nz, _LABEL_BD51_
	jr   _LABEL_BD7B_

_LABEL_BD61_:
	ld   b, $0B
	ld   hl, _RAM_C3F9_
	ld   de, _RAM_C40A_
_LABEL_BD69_:
	ld   a, [hl]
	ld   c, a
	ld   a, [de]
	ldi  [hl], a
	ld   a, c
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_BD69_
	ld   a, [_RAM_C3F8_]
	xor  $FF
	ld   [_RAM_C3F8_], a
_LABEL_BD7B_:
	ld   bc, $0A00
	ld   a, $26
	ld   [_RAM_C4A5_], a
	ld   a, $C4
	ld   [_RAM_C4A6_], a
	ld   hl, _RAM_C414_
	ld   de, _RAM_C403_
_LABEL_BD8E_:
	ld   a, [de]
	dec  de
	sub  [hl]
	dec  hl
	sub  c
	ld   c, $00
_LABEL_BD95_:
	bit  7, a
	jr   z, _LABEL_BD9E_
	add  $0A
	inc  c
	jr   _LABEL_BD95_

_LABEL_BD9E_:
	push hl
	push af
	ld   a, [_RAM_C4A5_]
	ld   l, a
	ld   a, [_RAM_C4A6_]
	ld   h, a
	pop  af
	ldd  [hl], a
	ld   a, l
	ld   [_RAM_C4A5_], a
	ld   a, h
	ld   [_RAM_C4A6_], a
	pop  hl
	dec  b
	jr   nz, _LABEL_BD8E_
	ld   a, [_RAM_C3F9_]
	ld   hl, _RAM_C41D_
	ld   c, $0A
	ld   b, a
_LABEL_BDBF_:
	ldi  a, [hl]
	or   a
	jr   nz, _LABEL_BDC9_
	dec  b
	dec  c
	jr   nz, _LABEL_BDBF_
	ld   b, $00
_LABEL_BDC9_:
	ld   a, b
	ld   [_RAM_C41B_], a
	xor  a
	ld   [_RAM_C41C_], a
	ld   a, [_RAM_C3F8_]
	ld   [_RAM_C41A_], a
	ret

; Data from BDD8 to BDEF (24 bytes)
db $21, $64, $00, $01, $0A, $08, $55, $B7, $CB, $12, $CB, $14, $7C, $B9, $38, $03
db $91, $67, $14, $05, $20, $F1, $5C, $C9

_LABEL_BDF0_:
	ld   hl, _RAM_CFA4_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, _RAM_C466_
	ld   b, $0B
_LABEL_BDFB_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_BDFB_
	pop  hl
_LABEL_BE02_:
	call gfx__clear_shadow_oam__275B
	call _LABEL_B145_
	ld   a, [_RAM_C10A_]
	or   a
	jr   nz, _LABEL_BE1D_
	ld   a, [_RAM_C258_]
	ld   c, a
	ld   a, [_RAM_C259_]
	ld   b, a
	ld   a, [_RAM_C25A_]
	ld   e, a
	call _LABEL_1504_
_LABEL_BE1D_:
	rst  $18	; Call VSYNC__RST_18
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	push af
	ld   a, [_RAM_C10A_]
	or   a
	jr   nz, _LABEL_BE32_
	ld   a, [_RAM_C592_]
	or   a
	jr   z, _LABEL_BE32_
	call _LABEL_B040_
	pop  bc
	jr   _LABEL_BE38_

_LABEL_BE32_:
	ld   a, $39
	ld   [_RAM_C25A_], a
	pop  af
_LABEL_BE38_:
	cp   $FF
	jr   z, _LABEL_BE02_
	or   a
	jp   z, _LABEL_200_
	cp   $7F
	jr   nz, _LABEL_BE02_
	jp   _LABEL_B9F0_

_LABEL_BE47_:
	xor  a
	ld   [_RAM_C47C_], a
	ld   a, [_RAM_C355_]
	bit  7, a
	jr   z, _LABEL_BE58_
	ld   c, a
	ld   [_RAM_C47C_], a
	xor  a
	sub  c
_LABEL_BE58_:
	ld   b, $00
_LABEL_BE5A_:
	cp   $0A
	jr   c, _LABEL_BE63_
	inc  b
	sub  $0A
	jr   _LABEL_BE5A_

_LABEL_BE63_:
	add  $30
	ld   c, a
	ld   a, b
	add  $30
	cp   $30
	jr   nz, _LABEL_BE6F_
	ld   a, $20
_LABEL_BE6F_:
	ld   b, a
	ld   a, c
	ld   [_RAM_C3E1_], a
	ld   [_RAM_C357_], a
	ld   a, b
	ld   [_RAM_C3E0_], a
	ld   [_RAM_C356_], a
	xor  a
	ld   [_RAM_C35B_], a
	ld   [_RAM_C3E2_], a
	ld   a, [_RAM_C47C_]
	or   a
	jr   z, _LABEL_BEA5_
	ld   a, [_RAM_C355_]
	cp   $F6
	jr   nz, _LABEL_BEA0_
	ld   hl, _RAM_C3E3_
	ld   de, _RAM_C3E2_
	ld   b, $03
_LABEL_BE9A_:
	ld   a, [de]
	dec  de
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_BE9A_
_LABEL_BEA0_:
	ld   a, $2D
	ld   [_RAM_C3E0_], a
_LABEL_BEA5_:
	ld   hl, _RAM_C3EC_
	ld   a, $31
	ldi  [hl], a
	ld   a, $2E
	ldi  [hl], a
	ld   a, $38
	ldi  [hl], a
	xor  a
	ldi  [hl], a
	ld   de, _RAM_C3E0_
	ld   hl, $C3F9
	call _LABEL_AAA8_
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	call _LABEL_AAA8_
	ld   a, $03
	ld   [_RAM_C479_], a
	call _LABEL_BD22_
	call _LABEL_AB74_
	ld   hl, _RAM_C3EC_
	ld   a, $33
	ldi  [hl], a
	ld   a, $32
	ldi  [hl], a
	ld   a, $2E
	ldi  [hl], a
	ld   a, $35
	ldi  [hl], a
	xor  a
	ldi  [hl], a
	ld   de, _RAM_C3EC_
	ld   hl, $C40A
	call _LABEL_AAA8_
	xor  a
	ld   [_RAM_C479_], a
	call _LABEL_BD22_
	call _LABEL_AB74_
	ld   hl, _RAM_C455_
	ld   de, _RAM_C358_
_LABEL_BEFA_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_BF06_
	cp   $2E
	jr   z, _LABEL_BF06_
	ld   [de], a
	inc  de
	jr   _LABEL_BEFA_

_LABEL_BF06_:
	xor  a
	ld   [de], a
	ld   a, $02
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_BF46_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	or   a
	jp   z, _LABEL_200_
	cp   $0F
	jr   z, _LABEL_BF24_
	cp   $12
	jr   z, _LABEL_BF3B_
	ld   a, [_RAM_C3B0_]
	bit  6, a
	jr   z, _LABEL_BF33_
_LABEL_BF24_:
	ld   a, [_RAM_C355_]
	inc  a
	cp   $79
	jp   z, _LABEL_BE47_
_LABEL_BF2D_:
	ld   [_RAM_C355_], a
	jp   _LABEL_BE47_

_LABEL_BF33_:
	ld   a, [_RAM_C3B0_]
	bit  7, a
	jp   z, _LABEL_BE47_
_LABEL_BF3B_:
	ld   a, [_RAM_C355_]
	dec  a
	cp   $F5
	jp   z, _LABEL_BE47_
	jr   _LABEL_BF2D_

_LABEL_BF46_:
	rst  $18	; Call VSYNC__RST_18
	call gfx__clear_shadow_oam__275B
	ld   a, [_RAM_C355_]
	bit  7, a
	jr   z, _LABEL_BF54_
	xor  a
	jr   _LABEL_BF5A_

_LABEL_BF54_:
	cp   $36
	jr   c, _LABEL_BF5A_
	ld   a, $35
_LABEL_BF5A_:
	add  a
	add  a
	ld   b, $00
_LABEL_BF5E_:
	cp   $05
	jr   c, _LABEL_BF67_
	sub  $05
	inc  b
	jr   _LABEL_BF5E_

_LABEL_BF67_:
	ld   c, a
	ld   a, b
	add  a
	inc  a
	ld   e, a
	ld   a, c
	cp   $03
	jr   c, _LABEL_BF72_
	inc  e
_LABEL_BF72_:
	ld   b, $78
	ld   hl, shadow_oam_base__RAM_C000
_LABEL_BF77_:
	ld   a, e
	cp   $08
	jr   c, _LABEL_BF91_
	ld   [hl], b
	ld   a, b
	sub  $08
	ld   b, a
	inc  hl
	ld   [hl], $55
	inc  hl
	ld   [hl], $08
	inc  hl
	ld   [hl], $00
	inc  hl
	ld   a, e
	sub  $08
	ld   e, a
	jr   _LABEL_BF77_

_LABEL_BF91_:
	ld   [hl], b
	inc  hl
	ld   [hl], $55
	inc  hl
	ld   [hl], e
	inc  hl
	ld   [hl], $00
	ret

; Data from BF9B to BFFF (101 bytes)
db $F8, $B8, $00, $00, $BA, $00, $00, $52, $50, $E8, $E2, $00, $2B, $C0, $5E, $5F
db $8B, $E5, $5D, $C2, $08, $00, $55, $8B, $EC, $83, $EC, $0C, $57, $56, $8B, $7E
db $06, $8B, $46, $04, $2B, $D2, $D1, $E0, $D1, $D2, $D1, $E0, $D1, $D2, $D1, $E0
db $D1, $D2, $D1, $E0, $D1, $D2, $89, $46, $F8, $89, $56, $FA, $8B, $46, $08, $8B
db $56, $0A, $24, $FC, $89, $46, $F4, $89, $56, $F6, $0B, $FF, $74, $6E, $2B, $C0
db $50, $52, $FF, $76, $F4, $FF, $36, $00, $00, $9A, $00, $00, $00, $00, $83, $C4
db $08, $8B, $46, $F8, $8B

SECTION "rom3", ROMX, BANK[$3]
; Pointer Table from C000 to C001 (1 entries, indexed by unknown)
dw $4EE0

; Data from C002 to C046 (69 bytes)
db $06, $0D, $DD, $50, $06, $3E, $5D, $59, $06, $1B, $B8, $5E, $06, $0D, $89, $61
db $06, $A7, $4B, $78, $03, $0F, $CD, $7B, $03, $0B, $9F, $4E, $04, $A1, $B9, $6E
db $04, $08, $64, $42, $06, $42, $4B, $70, $04, $25, $73, $77, $04, $12, $01, $40
db $06, $0E, $6D, $7B, $04, $19, $4E, $50, $53, $56, $5A, $57, $53, $50, $43, $50
db $41, $53, $55, $50, $53

_LABEL_C047_:
	call _LABEL_26C_
_LABEL_C04A_:
	ld   a, [_SRAM_602B_]
	ld   b, a
	ld   a, $00
	ld   [_RAM_C24C_], a
	ld   a, $A1
	ld   [_RAM_C24D_], a
	ld   a, $04
	ld   [_RAM_C280_], a
_LABEL_C05D_:
	push bc
	call _LABEL_B36_
	pop  bc
	dec  b
	jr   nz, _LABEL_C05D_
	ld   de, $2150
	ld   hl, _TILEMAP0
	rst  $20	; _LABEL_20_
	ld   hl, _RAM_C308_
	ld   c, $00
_LABEL_C071_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_C078_
	inc  c
	jr   _LABEL_C071_

_LABEL_C078_:
	ld   a, $14
	sub  c
	or   a
	rr   a
	ld   h, $98
	ld   l, a
	ld   de, $C308
	rst  $20	; _LABEL_20_
	ld   de, $2150
	ld   hl, (_TILEMAP0 + $20)
	rst  $20	; _LABEL_20_
	ld   a, [_RAM_C306_]
	or   a
	jr   nz, _LABEL_C0AD_
	ld   hl, _RAM_C327_
	ld   c, $00
_LABEL_C097_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_C09E_
	inc  c
	jr   _LABEL_C097_

_LABEL_C09E_:
	ld   a, $14
	sub  c
	or   a
	rr   a
	ld   h, $98
	add  $20
	ld   l, a
	ld   de, $C327
	rst  $20	; _LABEL_20_
_LABEL_C0AD_:
	ld   de, $0062
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
_LABEL_C0B4_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_C0B4_
	cp   $12
	jr   z, _LABEL_C132_
	cp   $0F
	jr   z, _LABEL_C142_
	push af
	ld   hl, $4038
	ld   d, $00
	ld   a, [_RAM_C232_]
	ld   e, a
	add  a
	add  e
	ld   e, a
	add  hl, de
	pop  af
	cp   [hl]
	jr   z, _LABEL_C132_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_C142_
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_C0B4_
	ld   a, [_SRAM_602C_]
	push af
	ld   a, [_RAM_C305_]
	ld   [_SRAM_602C_], a
	pop  af
	ld   [_RAM_C305_], a
	ld   a, [_SRAM_602C_]
	push af
	ld   e, a
	ld   a, [_RAM_C305_]
	ld   [_SRAM_602C_], a
	ld   a, e
	ld   [_RAM_C305_], a
	call _LABEL_9CE_
	call _LABEL_991_
	pop  af
	ld   [_SRAM_602C_], a
	ld   hl, _RAM_C308_
	ld   de, _SRAM_6015_
	ld   b, $14
_LABEL_C10E_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	or   a
	jr   z, _LABEL_C117_
	dec  b
	jr   nz, _LABEL_C10E_
_LABEL_C117_:
	ld   hl, $C308
	ld   de, _DATA_C150_
	ld   b, $04
_LABEL_C11F_:
	ld   a, [de]
	cp   [hl]
	jr   nz, _LABEL_C12D_
	inc  de
	inc  hl
	dec  b
	jr   nz, _LABEL_C11F_
	inc  a
	ld   [_SRAM_602A_], a
	ret

_LABEL_C12D_:
	xor  a
	ld   [_SRAM_602A_], a
	ret

_LABEL_C132_:
	ld   a, [_SRAM_602B_]
	inc  a
	cp   $F4
	jr   nz, _LABEL_C13C_
	ld   a, $01
_LABEL_C13C_:
	ld   [_SRAM_602B_], a
	jp   _LABEL_C04A_

_LABEL_C142_:
	ld   a, [_SRAM_602B_]
	dec  a
	jr   nz, _LABEL_C14A_
	ld   a, $F3
_LABEL_C14A_:
	ld   [_SRAM_602B_], a
	jp   _LABEL_C04A_

; Data from C150 to C153 (4 bytes)
_DATA_C150_:
db $55, $53, $41, $00

_LABEL_C154_:
	xor  a
	ld   [_RAM_C305_], a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   [_RAM_C130_], a
	ld   [_RAM_C23B_], a
	ld   [_RAM_C11B_], a
	ld   [_RAM_C239_], a
	ld   a, [_RAM_C281_]
	ld   [_RAM_C237_], a
	ld   a, [_RAM_C282_]
	ld   [_RAM_C238_], a
	ld   a, $0B
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	xor  a
	ld   [_RAM_C23B_], a
	ld   a, $08
	ld   [_RAM_C281_], a
	ld   a, $98
	ld   [_RAM_C282_], a
	ld   a, $01
	ld   [_RAM_C280_], a
_LABEL_C18C_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_C18C_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_C1DA_
	cp   $80
	jr   nz, _LABEL_C1B4_
	ld   a, [_RAM_C281_]
	cp   $08
	jr   z, _LABEL_C18C_
	sub  $08
	ld   [_RAM_C281_], a
	ld   a, $20
	call _LABEL_782_
	jr   _LABEL_C18C_

_LABEL_C1B4_:
	cp   $2D
	jr   z, _LABEL_C1C4_
	cp   $20
	jr   z, _LABEL_C1C4_
	cp   $41
	jr   c, _LABEL_C18C_
	cp   $5B
	jr   nc, _LABEL_C18C_
_LABEL_C1C4_:
	ld   c, a
	ld   a, [_RAM_C281_]
	cp   $80
	jr   z, _LABEL_C18C_
	ld   a, c
	call _LABEL_782_
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_C18C_

_LABEL_C1DA_:
	ld   a, [_RAM_C281_]
	sub  $08
	jp   z, _LABEL_897_
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   [_RAM_C23B_], a
	ld   d, $00
	ld   e, a
	ld   hl, $C11B
	add  hl, de
	xor  a
	ld   [hl], a
	ld   [_RAM_C307_], a
	call gfx__clear_shadow_oam__275B
	ld   a, $00
	ld   [_RAM_C24C_], a
	ld   a, $A1
	ld   [_RAM_C24D_], a
_LABEL_C207_:
	call _LABEL_B21_
	or   a
	jp   z, _LABEL_C335_
	ld   a, [_RAM_C3DE_]
	ld   c, a
	ld   a, [_RAM_C25F_]
	cp   c
	jr   z, _LABEL_C226_
	cp   $19
	jr   nz, _LABEL_C21E_
	ld   a, $0F
_LABEL_C21E_:
	call _LABEL_376C_
	jr   _LABEL_C226_

; Data from C223 to C225 (3 bytes)
db $CD, $0D, $38

_LABEL_C226_:
	ld   a, $1B
	ldh  [rOBP0], a
	call gfx__turn_off_screen_2827
	call _LABEL_B45_
	ld   hl, _TILEMAP0
	ld   de, $99E0
	ld   b, $60
	xor  a
_LABEL_C239_:
	ldi  [hl], a
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_C239_
	ld   hl, _RAM_C308_
	ld   c, $00
_LABEL_C244_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_C24B_
	inc  c
	jr   _LABEL_C244_

_LABEL_C24B_:
	ld   a, $14
	sub  c
	or   a
	rr   a
	ld   h, $98
	ld   l, a
	ld   de, $C308
	rst  $10	; _LABEL_10_
	ld   a, [_RAM_C306_]
	or   a
	jr   nz, _LABEL_C272_
	ld   hl, $A015
	ld   de, _RAM_C308_
_LABEL_C264_:
	ld   a, [de]
	cp   [hl]
	jr   nz, _LABEL_C272_
	inc  hl
	inc  de
	or   a
	jr   nz, _LABEL_C264_
	ld   hl, _RAM_C700_
	jr   _LABEL_C2A6_

_LABEL_C272_:
	ld   hl, _RAM_C700_
	ld   de, _RAM_C31D_
	call _LABEL_1D26_
	ld   a, $20
	ldi  [hl], a
	ld   de, _RAM_C322_
	ld   a, [de]
	or   a
	jr   z, _LABEL_C28B_
	call _LABEL_1D26_
	ld   a, $20
	ldi  [hl], a
_LABEL_C28B_:
	ld   a, [_RAM_C306_]
	or   a
	jr   z, _LABEL_C2A6_
	ld   a, [_RAM_C322_]
	or   a
	jr   nz, _LABEL_C2A2_
	ld   a, $33
	ldi  [hl], a
	ldi  [hl], a
	ld   a, $20
	ldi  [hl], a
	ld   [hl], $00
	jr   _LABEL_C2C9_

_LABEL_C2A2_:
	xor  a
	ld   [hl], a
	jr   _LABEL_C2C9_

_LABEL_C2A6_:
	ld   de, _RAM_C33C_
	call _LABEL_1D26_
	xor  a
	ld   [hl], a
	ld   hl, _RAM_C327_
	ld   c, $00
_LABEL_C2B3_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_C2BA_
	inc  c
	jr   _LABEL_C2B3_

_LABEL_C2BA_:
	ld   a, $14
	sub  c
	or   a
	rr   a
	ld   h, $98
	add  $20
	ld   l, a
	ld   de, $C327
	rst  $10	; _LABEL_10_
_LABEL_C2C9_:
	ld   hl, _RAM_C700_
	ld   c, $00
_LABEL_C2CE_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_C2D5_
	inc  c
	jr   _LABEL_C2CE_

_LABEL_C2D5_:
	ld   a, $14
	sub  c
	or   a
	rr   a
	ld   h, $98
	add  $40
	ld   l, a
	ld   de, $C700
	rst  $10	; _LABEL_10_
	ld   hl, _RAM_CF2E_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, $9A24
	ld   b, $0C
_LABEL_C2EF_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C2EF_
	call _LABEL_9CE_
	call _LABEL_92C_
	ld   a, $04
	ld   [_RAM_C280_], a
	call gfx__turn_on_screen_bg_obj__2540
	ld   a, $0D
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_C30A_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_9CE_
	call _LABEL_92C_
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_C30A_
	or   a
	jp   z, _LABEL_200_
	push af
	ld   a, [_RAM_C232_]
	add  a
	ld   d, $00
	ld   e, a
	ld   hl, $1058
	add  hl, de
	pop  af
	cp   [hl]
	jp   z, _LABEL_C207_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_897_
	jr   _LABEL_C30A_

_LABEL_C335_:
	ld   a, $0C
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $0D
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, [_RAM_C280_]
	cp   $04
	call nz, gfx__clear_shadow_oam__275B
_LABEL_C348_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_9CE_
	call _LABEL_92C_
	ld   a, [_RAM_C280_]
	cp   $04
	call z, _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_C348_
	or   a
	jp   z, _LABEL_200_
	jp   _LABEL_897_

_LABEL_C363_:
	ld   hl, _RAM_C11B_
	ld   b, $12
	ld   a, $20
_LABEL_C36A_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C36A_
	ld   [hl], b
	ld   a, $14
	ld   de, _DATA_2150_
	ld   bc, $0F09
	call _LABEL_BC3_
	xor  a
	ld   [_RAM_C130_], a
	ld   [_RAM_C239_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	ld   a, $10
	ld   [_RAM_C281_], a
	ld   a, $90
	ld   [_RAM_C282_], a
_LABEL_C391_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_C391_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jp   z, _LABEL_C44F_
	cp   $0B
	jr   nz, _LABEL_C3B1_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_C391_

_LABEL_C3B1_:
	cp   $0C
	jr   nz, _LABEL_C3BF_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jr   _LABEL_C391_

_LABEL_C3BF_:
	cp   $10
	jr   nz, _LABEL_C3D1_
	ld   a, [_RAM_C281_]
	cp   $10
	jr   z, _LABEL_C391_
	sub  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_C391_

_LABEL_C3D1_:
	cp   $11
	jr   nz, _LABEL_C3E3_
	ld   a, [_RAM_C281_]
	cp   $98
	jr   z, _LABEL_C391_
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_C391_

_LABEL_C3E3_:
	cp   $C7
	jr   nz, _LABEL_C410_
	ld   a, [_RAM_C281_]
	ld   b, a
	ld   a, $98
	sub  b
	jr   z, _LABEL_C391_
	call _LABEL_21D7_
	ld   b, a
	ld   hl, _RAM_C12C_
	ld   de, _RAM_C12B_
_LABEL_C3FA_:
	ld   a, [de]
	dec  de
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_C3FA_
	ld   [hl], $20
	ld   de, $C11B
	ld   hl, $9A01
	rst  $20	; _LABEL_20_
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	jr   _LABEL_C391_

_LABEL_C410_:
	cp   $80
	jr   nz, _LABEL_C429_
	ld   a, [_RAM_C281_]
	cp   $10
	jp   z, _LABEL_C391_
	sub  $08
	ld   [_RAM_C281_], a
	ld   a, $20
	call _LABEL_76A_
	jp   _LABEL_C391_

_LABEL_C429_:
	cp   $7E
	jr   z, _LABEL_C437_
	cp   $61
	jp   nc, _LABEL_C391_
	cp   $20
	jp   c, _LABEL_C391_
_LABEL_C437_:
	ld   c, a
	ld   a, [_RAM_C281_]
	cp   $98
	jp   z, _LABEL_C391_
	ld   a, c
	call _LABEL_76A_
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jp   _LABEL_C391_

_LABEL_C44F_:
	ld   a, [_RAM_C281_]
	ld   b, $12
	ld   hl, _RAM_C12C_
_LABEL_C457_:
	ld   a, [hl]
	cp   $20
	jr   nz, _LABEL_C463_
	dec  hl
	dec  b
	jr   nz, _LABEL_C457_
	jp   _LABEL_C391_

_LABEL_C463_:
	inc  hl
	ld   [hl], $00
	call gfx__clear_shadow_oam__275B
	ld   a, b
	ld   [_RAM_C23B_], a
	ret

_LABEL_C46E_:
	ld   a, [_RAM_C10D_]
	push af
_LABEL_C472_:
	ld   hl, _RAM_C23A_
	inc  [hl]
	ld   a, [hl]
	ld   c, a
	ld   a, [_SRAM_4000_]
	inc  a
	cp   c
	jr   z, _LABEL_C4BD_
	ld   a, [hl]
	ld   [_RAM_C10D_], a
	ld   de, $0003
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	call _LABEL_680_
	ld   a, [_RAM_C23B_]
	ld   c, a
	ld   a, $18
	sub  c
	ld   c, a
	ld   a, $01
	sbc  $00
	ld   b, a
	ld   de, $C11B
	ld   hl, $C700
_LABEL_C4A0_:
	push hl
	ld   de, _RAM_C11B_
_LABEL_C4A4_:
	ld   a, [de]
	or   a
	jr   z, _LABEL_C4B8_
	inc  de
	cp   [hl]
	jr   nz, _LABEL_C4AF_
	inc  hl
	jr   _LABEL_C4A4_

_LABEL_C4AF_:
	pop  hl
	inc  hl
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_C4A0_
	jr   _LABEL_C472_

_LABEL_C4B8_:
	pop  hl
	pop  af
	ld   a, $01
	ret

_LABEL_C4BD_:
	pop  af
	ld   [_RAM_C10D_], a
	xor  a
	ret

_LABEL_C4C3_:
	call gfx__turn_on_screen_bg_obj__2540
	call _LABEL_26C_
	call gfx__turn_on_screen_bg_obj__2540
	ld   a, [_RAM_C59C_]
	or   a
	jr   z, _LABEL_C4F1_
	ld   hl, $99A6
	ld   de, $0068
	rst  $20	; _LABEL_20_
	ld   hl, _RAM_C59C_
	ld   de, _RAM_C261_
	ld   b, $04
_LABEL_C4E1_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_C4E1_
	ld   a, $13
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_C4F1_:
	ld   hl, $99E8
	ld   de, $0067
	rst  $20	; _LABEL_20_
	ld   de, $0063
	ld   hl, (_TILEMAP0 + $20)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   de, $0064
	ld   hl, (_TILEMAP0 + $80)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   de, $0065
	ld   hl, $98E0
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   de, $0066
	ld   hl, $9940
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   a, $0A
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $09E0
	ld   e, $06
	call _LABEL_1CF6_
_LABEL_C521_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_C539_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   nz, _LABEL_C55C_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_C55C_

_LABEL_C539_:
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   z, _LABEL_C55C_
	ld   e, a
	ld   a, $19
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_C571_
	bit  7, a
	jr   nz, _LABEL_C581_
	bit  2, a
	jr   z, _LABEL_C55C_
_LABEL_C553_:
	ld   a, [_RAM_C3B0_]
	bit  2, a
	jr   nz, _LABEL_C553_
	jr   _LABEL_C592_

_LABEL_C55C_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_C521_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_C592_
	cp   $12
	jr   z, _LABEL_C581_
	cp   $0F
	jr   nz, _LABEL_C521_
_LABEL_C571_:
	ld   a, [_RAM_C399_]
	cp   $06
	jr   nz, _LABEL_C57A_
	ld   a, $66
_LABEL_C57A_:
	sub  $18
	ld   [_RAM_C399_], a
	jr   _LABEL_C521_

_LABEL_C581_:
	ld   a, [_RAM_C399_]
	cp   $4E
	jr   nz, _LABEL_C58A_
	ld   a, $EE
_LABEL_C58A_:
	add  $18
	ld   [_RAM_C399_], a
	jp   _LABEL_C521_

_LABEL_C592_:
	ld   a, [_RAM_C399_]
	cp   $06
	jp   z, _LABEL_2F8E_
	cp   $36
	jp   z, _LABEL_C7C2_
	cp   $4E
	jp   z, _LABEL_1E7F_
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2B_
	ld   a, $03
	ld   [_RAM_C280_], a
_LABEL_C5AD_:
	ld   hl, $99E0
	ld   de, $002E
	rst  $20	; _LABEL_20_
	ld   hl, _RAM_C261_
	ld   de, _RAM_C39B_
	ld   b, $06
_LABEL_C5BC_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C5BC_
	ld   a, $12
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $0500
	ld   de, $237B
	ld   hl, $C261
	ld   a, $88
	call _LABEL_2411_
	inc  a
	jp   z, _LABEL_1E6A_
	call _LABEL_C7A2_
	or   a
	jr   nz, _LABEL_C5AD_
	ld   hl, _RAM_C261_
	ld   de, _RAM_C39B_
	ld   b, $06
_LABEL_C5E7_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_C5E7_
	call _LABEL_C5F3_
	jp   _LABEL_C4C3_

_LABEL_C5F3_:
	ld   de, $2150
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0016
	ld   hl, $99E1
	rst  $20	; _LABEL_20_
_LABEL_C601_:
	call _LABEL_E6C_
	or   a
	jr   z, _LABEL_C601_
	cp   $FF
	jr   z, _LABEL_C601_
	call gfx__turn_off_screen_2827
	jp   _LABEL_2722_

_LABEL_C611_:
	ld   b, $0A
_LABEL_C613_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   z, _LABEL_C61D_
	dec  b
	jr   nz, _LABEL_C613_
	ld   [hl], b
_LABEL_C61D_:
	ret

; Data from C61E to C7A1 (388 bytes)
db $3D, $18, $42, $18, $4E, $0C, $50, $0C, $52, $18, $3D, $18, $42, $18, $4E, $0C
db $4D, $0C, $4E, $18, $3D, $18, $42, $18, $46, $0C, $47, $0C, $49, $18, $38, $18
db $3D, $18, $4D, $0C, $4E, $0C, $50, $18, $38, $18, $3D, $18, $4D, $0C, $4E, $0C
db $50, $18, $38, $18, $3D, $18, $4D, $0C, $4E, $0C, $50, $18, $38, $18, $4E, $18
db $50, $0C, $52, $0C, $4D, $18, $4E, $0C, $50, $0C, $4B, $18, $4D, $0C, $4E, $0C
db $49, $0C, $4E, $0C, $49, $0C, $4E, $0C, $47, $18, $49, $0C, $4B, $0C, $46, $0C
db $4E, $0C, $46, $0C, $4E, $0C, $44, $18, $46, $0C, $47, $0C, $46, $18, $47, $18
db $49, $18, $4B, $18, $4D, $18, $4E, $18, $50, $18, $52, $18, $53, $18, $55, $18
db $57, $18, $59, $18, $4E, $18, $50, $0C, $52, $0C, $4D, $18, $50, $0C, $52, $0C
db $4B, $18, $4D, $0C, $4E, $0C, $49, $18, $4B, $0C, $4D, $0C, $47, $18, $49, $0C
db $4B, $0C, $49, $18, $49, $18, $42, $48, $FF, $01, $5A, $0C, $59, $0C, $5A, $18
db $55, $0C, $53, $0C, $55, $18, $5A, $0C, $59, $0C, $5A, $18, $52, $0C, $50, $0C
db $52, $18, $5A, $0C, $59, $0C, $5A, $18, $4E, $0C, $50, $0C, $52, $18, $54, $18
db $55, $0C, $57, $0C, $55, $0C, $54, $0C, $55, $0C, $59, $0C, $55, $0C, $59, $0C
db $55, $0C, $57, $0C, $55, $0C, $54, $0C, $55, $0C, $5A, $0C, $55, $0C, $5A, $0C
db $55, $0C, $57, $0C, $55, $0C, $54, $0C, $55, $0C, $5C, $0C, $55, $0C, $5C, $0C
db $5E, $18, $5C, $0C, $5A, $0C, $5C, $18, $5A, $0C, $59, $0C, $5A, $18, $59, $0C
db $57, $0C, $55, $0C, $5A, $0C, $55, $0C, $5A, $0C, $57, $18, $55, $0C, $53, $0C
db $52, $0C, $5A, $0C, $52, $0C, $5A, $0C, $53, $18, $52, $0C, $50, $0C, $42, $0C
db $4E, $0C, $44, $0C, $50, $0C, $46, $0C, $52, $0C, $48, $0C, $54, $0C, $49, $0C
db $55, $0C, $4B, $0C, $57, $0C, $4D, $0C, $59, $0C, $4E, $0C, $5A, $0C, $50, $0C
db $5C, $0C, $52, $0C, $5E, $0C, $53, $0C, $5F, $0C, $55, $0C, $61, $0C, $5E, $18
db $5C, $0C, $5A, $0C, $55, $18, $59, $18, $5A, $18, $59, $0C, $57, $0C, $55, $0C
db $53, $0C, $52, $0C, $50, $0C, $52, $18, $50, $0C, $4E, $0C, $55, $18, $55, $18
db $4E, $48, $FF, $01

_LABEL_C7A2_:
	ld   de, _RAM_C261_
	ld   hl, _RAM_C267_
	call _LABEL_2BA9_
	call _LABEL_2BA9_
	call _LABEL_2BA9_
	ld   hl, _RAM_C267_
	ldi  a, [hl]
	cp   $18
	ret  nc
	ldi  a, [hl]
	cp   $3C
	ret  nc
	ldi  a, [hl]
	cp   $3C
	ret  nc
	xor  a
	ret

_LABEL_C7C2_:
	call _LABEL_2B_
	ld   a, $03
	ld   [_RAM_C280_], a
_LABEL_C7CA_:
	ld   hl, $99A6
	ld   de, $0068
	rst  $20	; _LABEL_20_
	ld   hl, _RAM_C261_
	ld   de, _RAM_C39B_
	ld   b, $06
_LABEL_C7D9_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C7D9_
	ld   a, $13
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $0300
	ld   de, $2381
	ld   hl, $C261
	ld   a, $78
	call _LABEL_2411_
	inc  a
	jp   z, _LABEL_1E6A_
	call _LABEL_C7A2_
	or   a
	jr   nz, _LABEL_C7CA_
	ld   de, _RAM_C261_
	call _LABEL_C805_
	jp   _LABEL_1E6A_

_LABEL_C805_:
	ld   hl, _RAM_C59C_
	xor  a
	cp   [hl]
	jr   nz, _LABEL_C813_
	ld   a, [_RAM_C59B_]
	inc  a
	ld   [_RAM_C59B_], a
_LABEL_C813_:
	ld   b, $04
_LABEL_C815_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C815_
	ret

; Data from C81C to C830 (21 bytes)
ds 20, $2D
db $00

_LABEL_C831_:
	ld   hl, $00C2
	ld   d, h
	ld   e, l
	ld   a, [_RAM_C154_]
	add  l
	ld   l, a
	ld   e, a
	add  hl, hl
	ld   de, $CF00
	add  hl, de
	ld   a, [hl]
	inc  hl
	ld   h, [hl]
	ld   l, a
	ld   de, $99C5
	ld   b, $09
_LABEL_C84A_:
	ldi  a, [hl]
	sub  $20
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_C84A_
	ld   a, [hl]
	cp   $1C
	jr   nz, _LABEL_C862_
	ld   a, [_RAM_C155_]
	and  $03
	jr   nz, _LABEL_C862_
	ld   a, $1D
	jr   _LABEL_C863_

_LABEL_C862_:
	ld   a, [hl]
_LABEL_C863_:
	inc  a
	push af
	ld   hl, _RAM_C265_
	ld   [hl], $31
	inc  hl
	ld   [hl], $39
	inc  hl
	ld   a, $30
	ldi  [hl], a
	ldi  [hl], a
	ld   a, [_RAM_C155_]
	call _LABEL_235A_
	ld   de, _RAM_C265_
	ld   b, $04
	ld   hl, $99E8
_LABEL_C880_:
	ld   a, [de]
	inc  de
	sub  $20
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_C880_
	pop  af
	ld   c, a
	ld   a, [_RAM_C153_]
	ld   e, a
	ld   hl, $98E3
	add  a
	add  l
	ld   l, a
	ld   a, [_RAM_C152_]
	ld   d, a
	ld   a, $01
_LABEL_C89A_:
	push af
	push bc
	push de
	push hl
	cp   d
	jr   nz, _LABEL_C8AB_
	push af
	ld   a, l
	ld   [_RAM_C13B_], a
	ld   a, h
	ld   [_RAM_C13C_], a
	pop  af
_LABEL_C8AB_:
	call _LABEL_C990_
	pop  hl
	inc  hl
	inc  hl
	pop  de
	inc  e
	ld   a, e
	cp   $07
	jr   nz, _LABEL_C8BE_
	ld   e, $00
	ld   bc, $0012
	add  hl, bc
_LABEL_C8BE_:
	pop  bc
	pop  af
	inc  a
	cp   c
	jr   nz, _LABEL_C89A_
	call gfx__turn_on_screen_bg_obj__2540
	ld   a, $03
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_C8CC_:
	call serial_io__poll_keyboard__3278
	or   a
	jp   z, _LABEL_200_
	cp   $FF
	jr   z, _LABEL_C8CC_
	cp   $0F
	jr   z, _LABEL_C8FD_
	cp   $12
	jr   nz, _LABEL_C91B_
	ld   a, [_RAM_C154_]
	dec  a
	jr   nz, _LABEL_C8F2_
	ld   a, [_RAM_C155_]
	dec  a
	cp   $FF
	jr   z, _LABEL_C8CC_
	ld   [_RAM_C155_], a
	ld   a, $0C
_LABEL_C8F2_:
	ld   [_RAM_C154_], a
	ld   a, $01
	ld   [_RAM_C152_], a
	jp   _LABEL_839_

_LABEL_C8FD_:
	ld   a, [_RAM_C154_]
	inc  a
	cp   $0D
	jr   nz, _LABEL_C910_
	ld   a, [_RAM_C155_]
	inc  a
	jr   z, _LABEL_C8CC_
	ld   [_RAM_C155_], a
	ld   a, $01
_LABEL_C910_:
	ld   [_RAM_C154_], a
	ld   a, $01
	ld   [_RAM_C152_], a
	jp   _LABEL_839_

_LABEL_C91B_:
	ld   a, $F0
	ldh  [rOBP0], a
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   [gfx__shadow_y_scroll__RAM_C102], a
	ld   a, $64
	ld   [_RAM_C240_], a
	call _LABEL_41B_
	call _LABEL_2735_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $0068
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $0069
	call _LABEL_1D2D_
	ld   bc, $0A09
	call _LABEL_BC3_
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	call _LABEL_206D_
	cp   $01
	jp   z, _LABEL_C95D_
	jp   _LABEL_C9A7_

_LABEL_C95D_:
	ld   a, [_RAM_C152_]
	ld   [_RAM_C5C6_], a
	ld   a, [_RAM_C154_]
	ld   [_RAM_C5C5_], a
	ld   a, [_RAM_C155_]
	ld   [_RAM_C5C4_], a
	call _LABEL_CA12_
	ld   a, [_RAM_C700_]
	ld   [_RAM_C152_], a
	ld   a, [_RAM_C701_]
	ld   [_RAM_C154_], a
	ld   a, [_RAM_C702_]
	ld   [_RAM_C155_], a
	call _LABEL_1273_
	ld   a, [_RAM_C153_]
	call _LABEL_C9FB_
	jp   _LABEL_839_

_LABEL_C990_:
	ld   b, $00
_LABEL_C992_:
	cp   $0A
	jr   c, _LABEL_C99B_
	inc  b
	sub  $0A
	jr   _LABEL_C992_

_LABEL_C99B_:
	add  $C6
	ld   c, a
	ld   a, b
	or   a
	jr   z, _LABEL_C9A4_
	add  $C2
_LABEL_C9A4_:
	ldi  [hl], a
	ld   [hl], c
	ret

_LABEL_C9A7_:
	ld   a, [_RAM_C139_]
	ld   [_RAM_C5C6_], a
	ld   a, [_RAM_C13A_]
	ld   [_RAM_C5C4_], a
	ld   a, [_RAM_C138_]
	ld   [_RAM_C5C5_], a
	call _LABEL_CA12_
	ld   a, [_RAM_C700_]
	ld   [_RAM_C139_], a
	ld   [_RAM_C152_], a
	ld   a, [_RAM_C701_]
	ld   [_RAM_C154_], a
	ld   [_RAM_C138_], a
	ld   a, [_RAM_C702_]
	ld   [_RAM_C155_], a
	ld   [_RAM_C13A_], a
	call _LABEL_1273_
	ld   a, [_RAM_C153_]
	ld   [_RAM_C304_], a
	ld   a, [_RAM_C152_]
	ld   [_RAM_C139_], a
	ld   a, [_RAM_C155_]
	ld   [_RAM_C13A_], a
	ld   a, [_RAM_C154_]
	ld   [_RAM_C138_], a
	call _LABEL_C5F3_
	call _LABEL_288F_
	jp   _LABEL_C91B_

_LABEL_C9FB_:
	ld   a, [_RAM_C152_]
	ld   e, a
	ld   a, [_RAM_C153_]
_LABEL_CA02_:
	dec  e
	jr   z, _LABEL_CA0E_
	dec  a
	cp   $FF
	jr   nz, _LABEL_CA02_
	ld   a, $06
	jr   _LABEL_CA02_

_LABEL_CA0E_:
	ld   [_RAM_C153_], a
	ret

_LABEL_CA12_:
	ld   hl, _RAM_C700_
	ld   a, [_RAM_C5C6_]
	ldi  [hl], a
	ld   a, [_RAM_C5C5_]
	ldi  [hl], a
	ld   a, [_RAM_C5C4_]
	ldi  [hl], a
	call _LABEL_1352_
	call _LABEL_2B_
	ld   a, $03
	ld   [_RAM_C280_], a
	ld   hl, $99E0
	ld   de, $002C
	rst  $20	; _LABEL_20_
	ld   a, [_RAM_C700_]
	ld   hl, $C261
	call _LABEL_2BBA_
	ld   a, [_RAM_C701_]
	ld   hl, $C263
	call _LABEL_2BBA_
	ld   hl, _RAM_C265_
	ld   [hl], $31
	inc  hl
	ld   [hl], $39
	inc  hl
	ld   [hl], $30
	inc  hl
	ld   [hl], $30
	ld   a, [_RAM_C702_]
	call _LABEL_235A_
	ld   a, $10
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $0700
	ld   de, $2373
	ld   hl, $C261
	ld   a, $88
	call _LABEL_2411_
	inc  a
	jp   z, _LABEL_C91B_
	call _LABEL_B6C_
	or   a
	jr   nz, _LABEL_CA12_
	ret

; Data from CA77 to CA9E (40 bytes)
db $41, $46, $4D, $43, $45, $4E, $50, $51, $4E, $53, $41, $4C, $44, $56, $52, $45
db $4E, $54, $46, $45, $44, $53, $50, $51, $4E, $4C, $48, $42, $45, $50, $41, $53
db $4E, $54, $46, $43, $52, $50, $45, $55

_LABEL_CA9F_:
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	ld   a, [_RAM_C10C_]
	or   a
	jr   z, _LABEL_CAC0_
	ld   hl, $9F76
	ld   de, $008C
_LABEL_CAB3_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_CAB3_
	ld   bc, _RAM_C700_
_LABEL_CABA_:
	ldi  a, [hl]
	ld   [bc], a
	inc  bc
	dec  e
	jr   nz, _LABEL_CABA_
_LABEL_CAC0_:
	call _LABEL_E3A3_
_LABEL_CAC3_:
	call gfx__clear_shadow_oam__275B
_LABEL_CAC6_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_CAC6_
	or   a
	jp   z, _LABEL_200_
	push af
	ld   hl, $4A77
	ld   a, [_RAM_C232_]
	add  a
	add  a
	add  a
	ld   d, $00
	ld   e, a
	add  hl, de
	pop  af
	cp   [hl]
	jr   z, _LABEL_CB15_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_CB85_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_CE1F_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_CB36_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_CB2B_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_CDE1_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_CE10_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_200_
	cp   $09
	jr   nz, _LABEL_CAC6_
	ld   a, [_RAM_C10C_]
	or   a
	jr   z, _LABEL_CAC3_
	ld   hl, _RAM_C778_
	call _LABEL_EA22_
	jp   _LABEL_CAC3_

_LABEL_CB15_:
	ld   a, [_SRAM_2001_]
	or   a
	jp   z, _LABEL_CAC3_
	call _LABEL_4C9_
	call gfx__clear_shadow_oam__275B
	ld   a, [_RAM_C10C_]
	call _LABEL_7B6_
	jp   _LABEL_CA9F_

_LABEL_CB2B_:
	ld   a, [_RAM_C10C_]
	or   a
	jr   z, _LABEL_CAC3_
	ld   a, $01
	jp   _LABEL_CE33_

_LABEL_CB36_:
	ld   a, [_RAM_C10C_]
	or   a
	jp   z, _LABEL_CAC3_
	call _LABEL_132B_
	push af
	call _LABEL_62C_
	pop  af
	or   a
	jp   z, _LABEL_CAC3_
	ld   a, [_RAM_C10C_]
	ld   c, a
	ld   a, [_SRAM_2001_]
	cp   c
	jr   nz, _LABEL_CB5D_
	dec  a
	ld   [_SRAM_2001_], a
	ld   [_RAM_C10C_], a
	jp   _LABEL_CA9F_

_LABEL_CB5D_:
	dec  a
	ld   [_SRAM_2001_], a
	sub  c
	inc  a
	push af
	ld   a, [_RAM_C10C_]
	ld   de, $008C
	ld   hl, $9F76
_LABEL_CB6D_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_CB6D_
	ld   b, h
	ld   c, l
	add  hl, de
	pop  af
_LABEL_CB75_:
	push af
	ld   e, $8C
_LABEL_CB78_:
	ldi  a, [hl]
	ld   [bc], a
	inc  bc
	dec  e
	jr   nz, _LABEL_CB78_
	pop  af
	dec  a
	jr   nz, _LABEL_CB75_
	jp   _LABEL_CA9F_

_LABEL_CB85_:
	ld   a, [_SRAM_2001_]
	or   a
	jp   z, _LABEL_CAC3_
	ld   de, _DATA_2150_
	ld   bc, $0F09
	ld   a, $14
	call _LABEL_BC3_
_LABEL_CB97_:
	xor  a
	ld   [_RAM_C11B_], a
	ld   a, $15
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, $90
	call _LABEL_CCBD_
	ld   a, [_RAM_C281_]
	cp   $10
	jr   z, _LABEL_CB97_
	sub  $10
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   [_RAM_C23B_], a
	xor  a
	ld   [_RAM_C5C7_], a
_LABEL_CBBE_:
	call _LABEL_CC76_
	push af
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	pop  af
	or   a
	jr   z, _LABEL_CC24_
	ld   de, $0001
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0017
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $2150
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	ld   a, [_RAM_C5C7_]
	ld   [_RAM_C10C_], a
	call _LABEL_7B6_
	ld   a, [_RAM_C5C7_]
	ld   hl, $9F76
	ld   de, $008C
_LABEL_CBF5_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_CBF5_
	ld   bc, _RAM_C700_
_LABEL_CBFC_:
	ldi  a, [hl]
	ld   [bc], a
	inc  bc
	dec  e
	jr   nz, _LABEL_CBFC_
	call _LABEL_E3A3_
_LABEL_CC05_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_CC05_
	or   a
	jp   z, _LABEL_CA9F_
	push af
	ld   hl, $1058
	ld   a, [_RAM_C232_]
	add  a
	ld   e, a
	ld   d, $00
	add  hl, de
	pop  af
	cp   [hl]
	jr   z, _LABEL_CBBE_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_CC3E_
	jr   _LABEL_CC05_

_LABEL_CC24_:
	ld   de, $2150
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0085
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $0086
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
_LABEL_CC39_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_CC39_
_LABEL_CC3E_:
	call _LABEL_62C_
	jp   _LABEL_CA9F_

; Data from CC44 to CC75 (50 bytes)
db $11, $83, $C2, $21, $05, $9A, $06, $0A, $1A, $13, $D6, $20, $22, $05, $20, $F8
db $C3, $F7, $25, $11, $05, $98, $FA, $F2, $C5, $87, $26, $00, $6F, $29, $29, $29
db $29, $19, $11, $83, $C2, $06, $0A, $1A, $13, $D6, $20, $22, $05, $20, $F8, $C3
db $F7, $25

_LABEL_CC76_:
	ld   a, [_SRAM_2001_]
	ld   c, a
	ld   a, [_RAM_C5C7_]
	cp   c
	jr   z, _LABEL_CCBB_
	inc  a
	ld   [_RAM_C5C7_], a
	ld   hl, $9F76
	ld   de, $008C
_LABEL_CC8A_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_CC8A_
	ld   a, [_RAM_C23B_]
	ld   d, a
	ld   a, $14
	sub  d
	ld   b, a
_LABEL_CC96_:
	push bc
	push hl
	ld   de, _RAM_C11B_
	ld   a, [_RAM_C23B_]
	ld   b, a
_LABEL_CC9F_:
	ld   a, [de]
	inc  de
	cp   [hl]
	jr   nz, _LABEL_CCAA_
	inc  hl
	dec  b
	jr   nz, _LABEL_CC9F_
	jr   _LABEL_CCB6_

_LABEL_CCAA_:
	pop  hl
	pop  bc
_LABEL_CCAC_:
	ldi  a, [hl]
	dec  b
	jr   z, _LABEL_CC76_
	cp   $20
	jr   nz, _LABEL_CCAC_
	jr   _LABEL_CC96_

_LABEL_CCB6_:
	pop  hl
	pop  bc
	ld   a, $01
	ret

_LABEL_CCBB_:
	xor  a
	ret

_LABEL_CCBD_:
	push af
	xor  a
	ld   [_RAM_C130_], a
	ld   [_RAM_C239_], a
	ld   a, [_RAM_C281_]
	ld   [_RAM_C237_], a
	ld   a, [_RAM_C282_]
	ld   [_RAM_C238_], a
	rst  $18	; Call VSYNC__RST_18
	ld   hl, _RAM_C11B_
	ld   b, $12
	ld   a, $20
_LABEL_CCD9_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_CCD9_
	ld   [hl], b
	ld   a, $10
	ld   [_RAM_C281_], a
	pop  af
	ld   [_RAM_C282_], a
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
_LABEL_CCEF_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_CCEF_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jp   z, _LABEL_CDB9_
	cp   $0B
	jr   nz, _LABEL_CD0F_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_CCEF_

_LABEL_CD0F_:
	cp   $0C
	jr   nz, _LABEL_CD1D_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jr   _LABEL_CCEF_

_LABEL_CD1D_:
	cp   $10
	jr   nz, _LABEL_CD2F_
	ld   a, [_RAM_C281_]
	cp   $10
	jr   z, _LABEL_CCEF_
	sub  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_CCEF_

_LABEL_CD2F_:
	cp   $11
	jr   nz, _LABEL_CD41_
	ld   a, [_RAM_C281_]
	cp   $98
	jr   z, _LABEL_CCEF_
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_CCEF_

_LABEL_CD41_:
	cp   $C7
	jr   nz, _LABEL_CD7A_
	ld   a, [_RAM_C281_]
	ld   b, a
	ld   a, $98
	sub  b
	jr   z, _LABEL_CCEF_
	call _LABEL_21D7_
	ld   b, a
	ld   hl, _RAM_C12C_
	ld   de, _RAM_C12B_
_LABEL_CD58_:
	ld   a, [de]
	ldd  [hl], a
	dec  de
	dec  b
	jr   nz, _LABEL_CD58_
	ld   [hl], $20
	ld   a, [_RAM_C282_]
	sub  $10
	ld   h, $00
	ld   l, a
	add  hl, hl
	add  hl, hl
	ld   de, (_TILEMAP0 + $01)
	add  hl, de
	ld   de, $C11B
	rst  $20	; _LABEL_20_
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   _LABEL_CCEF_

_LABEL_CD7A_:
	cp   $80
	jr   nz, _LABEL_CD93_
	ld   a, [_RAM_C281_]
	cp   $10
	jp   z, _LABEL_CCEF_
	sub  $08
	ld   [_RAM_C281_], a
	ld   a, $20
	call _LABEL_76A_
	jp   _LABEL_CCEF_

_LABEL_CD93_:
	cp   $7E
	jr   z, _LABEL_CDA1_
	cp   $20
	jp   c, _LABEL_CCEF_
	cp   $61
	jp   nc, _LABEL_CCEF_
_LABEL_CDA1_:
	ld   c, a
	ld   a, [_RAM_C281_]
	cp   $98
	jp   z, _LABEL_CCEF_
	ld   a, c
	call _LABEL_76A_
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jp   _LABEL_CCEF_

_LABEL_CDB9_:
	ld   b, $12
	ld   hl, _RAM_C12C_
_LABEL_CDBE_:
	ld   a, [hl]
	cp   $20
	jr   nz, _LABEL_CDC7_
	dec  hl
	dec  b
	jr   nz, _LABEL_CDBE_
_LABEL_CDC7_:
	ld   a, b
	add  a
	add  a
	add  a
	add  $10
	ld   [_RAM_C281_], a
	call _LABEL_21D7_
	ld   hl, $C119
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $00
	jp   gfx__clear_shadow_oam__275B

_LABEL_CDE1_:
	ld   a, [_SRAM_2001_]
	ld   c, a
	ld   a, [_RAM_C10C_]
	cp   c
	jp   z, _LABEL_CAC3_
	inc  a
_LABEL_CDED_:
	ld   [_RAM_C10C_], a
	ld   hl, $9F76
	ld   de, $008C
_LABEL_CDF6_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_CDF6_
	ld   b, e
	ld   de, _RAM_C700_
_LABEL_CDFE_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_CDFE_
	call _LABEL_E3A3_
	ld   a, [_RAM_C10C_]
	call _LABEL_7B6_
	jp   _LABEL_CAC3_

_LABEL_CE10_:
	ld   a, [_RAM_C10C_]
	or   a
	jp   z, _LABEL_CAC3_
	cp   $01
	jp   z, _LABEL_CAC3_
	dec  a
	jr   _LABEL_CDED_

_LABEL_CE1F_:
	ld   a, [_SRAM_2001_]
	cp   $3A
	jp   z, _LABEL_CAC3_
	ld   hl, _RAM_C700_
	ld   b, $8C
	ld   a, $20
_LABEL_CE2E_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_CE2E_
	xor  a
_LABEL_CE33_:
	ld   [_RAM_C5C8_], a
	or   a
	jr   nz, _LABEL_CE43_
	call _LABEL_E3C3_
	ld   a, [_SRAM_2001_]
	inc  a
	call _LABEL_7B6_
_LABEL_CE43_:
	call _LABEL_1563_
	call _LABEL_CE9C_
	ld   hl, $C700
	ld   b, $78
	ld   a, $20
_LABEL_CE50_:
	cp   [hl]
	jr   nz, _LABEL_CE60_
	inc  hl
	dec  b
	jr   nz, _LABEL_CE50_
	call _LABEL_1563_
	call _LABEL_E3A3_
	jp   _LABEL_CAC3_

_LABEL_CE60_:
	call _LABEL_CFB6_
	ld   a, [_RAM_C5C8_]
	or   a
	jr   nz, _LABEL_CE73_
	ld   a, [_SRAM_2001_]
	inc  a
	ld   [_SRAM_2001_], a
	ld   [_RAM_C10C_], a
_LABEL_CE73_:
	ld   hl, _SRAM_2002_
	ld   a, [_RAM_C10C_]
	dec  a
	jr   z, _LABEL_CE83_
	ld   de, $008C
_LABEL_CE7F_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_CE7F_
_LABEL_CE83_:
	ld   de, _RAM_C700_
	ld   b, $8C
_LABEL_CE88_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_CE88_
	call _LABEL_1563_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jp   _LABEL_CAC3_

_LABEL_CE9C_:
	ld   a, $08
	ld   [_RAM_C281_], a
	ld   a, $20
	ld   [_RAM_C282_], a
	xor  a
	ld   [_RAM_C130_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_CEAF_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_CEAF_
	or   a
	ret  z
	cp   $0B
	jr   nz, _LABEL_CEC8_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_CEAF_

_LABEL_CEC8_:
	cp   $C7
	jr   nz, _LABEL_CEE9_
	ld   a, [_RAM_C281_]
	sub  $08
	call _LABEL_21D7_
	ld   c, a
	ld   a, [_RAM_C282_]
	sub  $20
	call _LABEL_21D7_
	ld   b, a
	ld   hl, _RAM_C700_
	ld   de, (_TILEMAP0 + $40)
	call _LABEL_2173_
	jr   _LABEL_CEAF_

_LABEL_CEE9_:
	cp   $0C
	jr   nz, _LABEL_CEF7_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jr   _LABEL_CEAF_

_LABEL_CEF7_:
	cp   $0F
	jr   c, _LABEL_CF1F_
	cp   $13
	jr   nc, _LABEL_CF1F_
	cp   $0F
	jr   z, _LABEL_CF10_
	cp   $10
	jr   z, _LABEL_CF15_
	cp   $11
	jr   z, _LABEL_CF1A_
_LABEL_CF0B_:
	call _LABEL_CF4C_
	jr   _LABEL_CEAF_

_LABEL_CF10_:
	call _LABEL_CF5B_
	jr   _LABEL_CEAF_

_LABEL_CF15_:
	call _LABEL_CF68_
	jr   _LABEL_CEAF_

_LABEL_CF1A_:
	call _LABEL_CF7A_
	jr   _LABEL_CEAF_

_LABEL_CF1F_:
	cp   $80
	jr   nz, _LABEL_CF2E_
	call _LABEL_CF68_
	ld   a, $20
	call _LABEL_CF8A_
	jp   _LABEL_CEAF_

_LABEL_CF2E_:
	cp   $7E
	jr   z, _LABEL_CF42_
	cp   $61
	jp   nc, _LABEL_CEAF_
	cp   $0D
	jr   nz, _LABEL_CF42_
	ld   a, $08
	ld   [_RAM_C281_], a
	jr   _LABEL_CF0B_

_LABEL_CF42_:
	cp   $20
	jp   c, _LABEL_CEAF_
	call _LABEL_CF8A_
	jr   _LABEL_CF1A_

_LABEL_CF4C_:
	ld   a, [_RAM_C282_]
	add  $08
	cp   $50
	jr   nz, _LABEL_CF57_
	ld   a, $20
_LABEL_CF57_:
	ld   [_RAM_C282_], a
	ret

_LABEL_CF5B_:
	ld   a, [_RAM_C282_]
	sub  $08
	cp   $18
	jr   nz, _LABEL_CF57_
	ld   a, $48
	jr   _LABEL_CF57_

_LABEL_CF68_:
	ld   a, [_RAM_C281_]
	sub  $08
	jr   nz, _LABEL_CF76_
	ld   a, $A0
	ld   [_RAM_C281_], a
	jr   _LABEL_CF5B_

_LABEL_CF76_:
	ld   [_RAM_C281_], a
	ret

_LABEL_CF7A_:
	ld   a, [_RAM_C281_]
	add  $08
	cp   $A8
	jr   nz, _LABEL_CF76_
	ld   a, $08
	ld   [_RAM_C281_], a
	jr   _LABEL_CF4C_

_LABEL_CF8A_:
	push af
	ld   a, [_RAM_C282_]
	ld   hl, $C700
	ld   bc, $0014
	sub  $20
	jr   z, _LABEL_CF9D_
_LABEL_CF98_:
	add  hl, bc
	sub  $08
	jr   nz, _LABEL_CF98_
_LABEL_CF9D_:
	ld   a, [_RAM_C281_]
	sub  $08
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	pop  af
	ld   [hl], a
	jp   _LABEL_73A_

_LABEL_CFB6_:
	ld   a, $08
	ld   [_RAM_C281_], a
	ld   a, $78
	ld   [_RAM_C282_], a
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	xor  a
	ld   [_RAM_C130_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_CFD1_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_CFD1_
	or   a
	ret  z
	cp   $10
	jr   c, _LABEL_CFF2_
	cp   $12
	jr   nc, _LABEL_CFF2_
	cp   $11
	jr   z, _LABEL_CFED_
	call _LABEL_D019_
	jr   _LABEL_CFD1_

_LABEL_CFED_:
	call _LABEL_D026_
	jr   _LABEL_CFD1_

_LABEL_CFF2_:
	cp   $80
	jr   nz, _LABEL_D001_
	call _LABEL_D019_
	ld   a, $20
	call _LABEL_D035_
	jp   _LABEL_CFD1_

_LABEL_D001_:
	cp   $0D
	ret  z
	cp   $20
	jr   z, _LABEL_D014_
	cp   $2D
	jr   z, _LABEL_D014_
	cp   $30
	jr   c, _LABEL_CFD1_
	cp   $3A
	jr   nc, _LABEL_CFD1_
_LABEL_D014_:
	call _LABEL_D035_
	jr   _LABEL_CFED_

_LABEL_D019_:
	ld   a, [_RAM_C281_]
	sub  $08
	jr   nz, _LABEL_D022_
	ld   a, $A0
_LABEL_D022_:
	ld   [_RAM_C281_], a
	ret

_LABEL_D026_:
	ld   a, [_RAM_C281_]
	add  $08
	cp   $A8
	jr   nz, _LABEL_D031_
	ld   a, $08
_LABEL_D031_:
	ld   [_RAM_C281_], a
	ret

_LABEL_D035_:
	push af
	ld   hl, $C778
	ld   a, [_RAM_C281_]
	sub  $08
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	pop  af
	ld   [hl], a
	jp   _LABEL_73A_

; Pointer Table from D052 to D081 (24 entries, indexed by _RAM_C5C9_)
_DATA_D052_:
dw _DATA_D082_, _DATA_D087_, _DATA_D08C_, _DATA_D091_, _DATA_D097_, _DATA_D09C_, _DATA_D0A0_, _DATA_D0A5_
dw _DATA_D0AB_, _DATA_D0B1_, _DATA_D0B7_, _DATA_D0BD_, _DATA_D0C2_, _DATA_D0C7_, _DATA_D0CD_, _DATA_D0D3_
dw _DATA_D0D8_, _DATA_D0DE_, _DATA_D0E5_, _DATA_D0EB_, _DATA_D0F0_, _DATA_D0F4_, _DATA_D0F9_, _DATA_D0FF_

; 1st entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D082 to D086 (5 bytes)
_DATA_D082_:
db $32, $2E, $35, $34, $00

; 2nd entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D087 to D08B (5 bytes)
_DATA_D087_:
db $2E, $33, $30, $35, $00

; 3rd entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D08C to D090 (5 bytes)
_DATA_D08C_:
db $2E, $39, $31, $34, $00

; 4th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D091 to D096 (6 bytes)
_DATA_D091_:
db $31, $2E, $36, $30, $39, $00

; 5th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D097 to D09B (5 bytes)
_DATA_D097_:
db $2E, $34, $30, $35, $00

; 6th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D09C to D09F (4 bytes)
_DATA_D09C_:
db $2E, $30, $33, $00

; 7th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0A0 to D0A4 (5 bytes)
_DATA_D0A0_:
db $2E, $39, $34, $36, $00

; 8th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0A5 to D0AA (6 bytes)
_DATA_D0A5_:
db $33, $2E, $37, $38, $35, $00

; 9th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0AB to D0B0 (6 bytes)
_DATA_D0AB_:
db $34, $2E, $35, $34, $36, $00

; 10th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0B1 to D0B6 (6 bytes)
_DATA_D0B1_:
db $32, $38, $2E, $33, $35, $00

; 11th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0B7 to D0BC (6 bytes)
_DATA_D0B7_:
db $30, $2E, $34, $35, $34, $00

; 12th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0BD to D0C1 (5 bytes)
_DATA_D0BD_:
db $2E, $39, $30, $37, $00

; 13th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0C2 to D0C6 (5 bytes)
_DATA_D0C2_:
db $2E, $33, $39, $34, $00

; 14th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0C7 to D0CC (6 bytes)
_DATA_D0C7_:
db $33, $2E, $32, $38, $31, $00

; 15th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0CD to D0D2 (6 bytes)
_DATA_D0CD_:
db $31, $2E, $30, $39, $34, $00

; 16th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0D3 to D0D7 (5 bytes)
_DATA_D0D3_:
db $2E, $36, $32, $31, $00

; 17th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0D8 to D0DD (6 bytes)
_DATA_D0D8_:
db $32, $2E, $34, $37, $31, $00

; 18th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0DE to D0E4 (7 bytes)
_DATA_D0DE_:
db $33, $33, $2E, $38, $31, $34, $00

; 19th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0E5 to D0EA (6 bytes)
_DATA_D0E5_:
db $31, $2E, $30, $35, $37, $00

; 20th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0EB to D0EF (5 bytes)
_DATA_D0EB_:
db $2E, $32, $36, $34, $00

; 21st entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0F0 to D0F3 (4 bytes)
_DATA_D0F0_:
db $2E, $32, $32, $00

; 22nd entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0F4 to D0F8 (5 bytes)
_DATA_D0F4_:
db $2E, $30, $33, $35, $00

; 23rd entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0F9 to D0FE (6 bytes)
_DATA_D0F9_:
db $32, $2E, $32, $30, $35, $00

; 24th entry of Pointer Table from D052 (indexed by _RAM_C5C9_)
; Data from D0FF to D104 (6 bytes)
_DATA_D0FF_:
db $31, $2E, $31, $30, $32, $00

_LABEL_D105_:
	call _LABEL_206D_
	cp   $01
	jr   z, _LABEL_D113_
	ld   a, $0C
	ld   [_RAM_C5C9_], a
	jr   _LABEL_D117_

_LABEL_D113_:
	xor  a
	ld   [_RAM_C5C9_], a
_LABEL_D117_:
	call gfx__turn_off_screen_2827
	call _LABEL_2735_
	ld   a, [_RAM_C5C9_]
	or   a
	jr   z, _LABEL_D128_
	ld   hl, _RAM_CFF0_
	jr   _LABEL_D12B_

_LABEL_D128_:
	ld   hl, _RAM_CFD8_
_LABEL_D12B_:
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, (_TILEMAP0 + $60)
	ld   a, $0C
_LABEL_D133_:
	push af
	push hl
	rst  $10	; _LABEL_10_
	pop  hl
	ld   bc, $0020
	add  hl, bc
	pop  af
	dec  a
	jr   nz, _LABEL_D133_
	ld   bc, $09E0
	ld   e, $16
	call _LABEL_1CF6_
	call gfx__turn_on_screen_bg_obj__2540
_LABEL_D14A_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_D162_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   nz, _LABEL_D185_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_D185_

_LABEL_D162_:
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   z, _LABEL_D185_
	ld   e, a
	ld   a, $19
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_D19A_
	bit  7, a
	jr   nz, _LABEL_D1AA_
	bit  2, a
	jr   z, _LABEL_D185_
_LABEL_D17C_:
	ld   a, [_RAM_C3B0_]
	bit  2, a
	jr   nz, _LABEL_D17C_
	jr   _LABEL_D1BB_

_LABEL_D185_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_D14A_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_D1BB_
	cp   $12
	jr   z, _LABEL_D1AA_
	cp   $0F
	jr   nz, _LABEL_D14A_
_LABEL_D19A_:
	ld   a, [_RAM_C399_]
	cp   $16
	jr   nz, _LABEL_D1A3_
	ld   a, $76
_LABEL_D1A3_:
	sub  $08
	ld   [_RAM_C399_], a
	jr   _LABEL_D14A_

_LABEL_D1AA_:
	ld   a, [_RAM_C399_]
	cp   $6E
	jr   nz, _LABEL_D1B3_
	ld   a, $0E
_LABEL_D1B3_:
	add  $08
	ld   [_RAM_C399_], a
	jp   _LABEL_D14A_

_LABEL_D1BB_:
	ld   a, [_RAM_C399_]
	sub  $16
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   c, a
	ld   a, [_RAM_C5C9_]
	add  c
	ld   [_RAM_C5C9_], a
	ld   de, $006A
	call _LABEL_1D2D_
	ld   a, $14
	ld   bc, $0009
	call _LABEL_BC3_
	ld   a, $0C
	ld   de, _DATA_2150_
	ld   bc, $0F09
	call _LABEL_BC3_
	ld   a, $30
	ld   [_RAM_C281_], a
	ld   a, $03
	ld   [_RAM_C280_], a
	ld   a, $90
	ld   [_RAM_C282_], a
	ld   hl, _RAM_C283_
	ld   b, $1C
	ld   a, $20
_LABEL_D200_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_D200_
	call _LABEL_2B_
	ld   a, $17
	ld   [vblank__dispatch_select__RAM_C27C], a
	xor  a
	ld   [_RAM_C474_], a
	ld   [_RAM_C475_], a
_LABEL_D213_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_D213_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jp   z, _LABEL_D2B5_
	cp   $80
	jr   z, _LABEL_D263_
	cp   $0A
	jr   z, _LABEL_D29B_
	cp   $2E
	jr   z, _LABEL_D283_
	cp   $30
	jr   c, _LABEL_D213_
	cp   $3A
	jr   nc, _LABEL_D213_
	ld   c, a
	ld   a, [_RAM_C474_]
	cp   $09
	jr   z, _LABEL_D213_
	or   a
	jr   nz, _LABEL_D24A_
	ld   a, c
	cp   $30
	jr   z, _LABEL_D213_
	xor  a
_LABEL_D24A_:
	inc  a
	ld   [_RAM_C474_], a
	ld   hl, $C283
	dec  a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], c
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_D213_

_LABEL_D263_:
	ld   a, [_RAM_C474_]
	or   a
	jr   z, _LABEL_D213_
	ld   hl, $C283
	dec  a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $20
	ld   hl, _RAM_C474_
	dec  [hl]
	ld   a, [_RAM_C281_]
	sub  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_D213_

_LABEL_D283_:
	ld   a, [_RAM_C474_]
	cp   $08
	jr   nc, _LABEL_D213_
	ld   a, [_RAM_C475_]
	or   a
	jr   nz, _LABEL_D213_
	inc  a
	ld   [_RAM_C475_], a
	ld   c, $2E
	ld   a, [_RAM_C474_]
	jr   _LABEL_D24A_

_LABEL_D29B_:
	ld   b, $14
	ld   hl, _RAM_C283_
	ld   a, $20
_LABEL_D2A2_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_D2A2_
	xor  a
	ld   [_RAM_C475_], a
	ld   [_RAM_C474_], a
	ld   a, $30
	ld   [_RAM_C281_], a
	jp   _LABEL_D213_

_LABEL_D2B5_:
	ld   a, [_RAM_C474_]
	or   a
	jp   z, _LABEL_D213_
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   hl, $C283
	ld   a, [_RAM_C474_]
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $00
	ld   de, _RAM_C283_
	ld   hl, _RAM_C3E0_
	ld   b, $0A
_LABEL_D2D6_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_D2D6_
	ld   a, [_RAM_C5C9_]
	add  a
	ld   d, $00
	ld   e, a
	ld   hl, _DATA_D052_
	add  hl, de
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	ld   de, _RAM_C3EC_
_LABEL_D2ED_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	or   a
	jr   nz, _LABEL_D2ED_
	call _LABEL_D11_
	call gfx__clear_shadow_oam__275B
	ld   b, $0A
	ld   hl, _RAM_C283_
	ld   a, $20
_LABEL_D300_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_D300_
	ld   hl, _RAM_C455_
	ld   de, _RAM_C283_
	ld   b, $09
_LABEL_D30C_:
	ldi  a, [hl]
	or   a
	jr   z, _LABEL_D315_
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_D30C_
_LABEL_D315_:
	ld   de, $006C
	ld   hl, (_TILEMAP0 + $20)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   a, $17
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_D321_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_D321_
	or   a
	jp   z, _LABEL_200_
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, $C8
	ld   [_RAM_C399_], a
	jp   _LABEL_1598_

_LABEL_D337_:
	ld   hl, (_TILEMAP0 + $24)
	ld   de, _DATA_9C_
	rst  $10	; _LABEL_10_
	ld   b, $07
	ld   hl, _RAM_D00C_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
_LABEL_D346_:
	push bc
	ld   a, [de]
	inc  de
	ld   l, a
	ld   a, [de]
	inc  de
	ld   h, a
	rst  $10	; _LABEL_10_
	pop  bc
	dec  b
	jr   nz, _LABEL_D346_
	call gfx__turn_on_screen_bg_obj__2540
	jp   _LABEL_D56A_

_LABEL_D358_:
	ld   a, [_RAM_C399_]
	ld   [_RAM_C5CC_], a
	ld   de, $009D
	ld   hl, (_TILEMAP0 + $24)
	rst  $20	; _LABEL_20_
	call _LABEL_D56A_
	ld   a, [_RAM_C5CC_]
	sub  $1E
	call _LABEL_2909_
	ld   [_RAM_C5CA_], a
	ld   a, [_RAM_C399_]
	sub  $1E
	call _LABEL_2909_
	ld   [_RAM_C5CB_], a
	ld   a, $C8
	ld   [_RAM_C399_], a
	jp   gfx__turn_off_screen_2827

_LABEL_D386_:
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $009D
	call _LABEL_1D2D_
	ld   bc, $0309
	call _LABEL_BC3_
	ld   a, $0C
	call _LABEL_E25B_
	ld   hl, _RAM_C283_
	ld   de, _RAM_C3E0_
	ld   bc, _RAM_C29F_
	ld   a, $0A
_LABEL_D3AB_:
	push af
	ldi  a, [hl]
	ld   [de], a
	ld   [bc], a
	inc  bc
	inc  de
	or   a
	jr   z, _LABEL_D3BB_
	pop  af
	dec  a
	jr   nz, _LABEL_D3AB_
	ld   [bc], a
	ld   [de], a
	push af
_LABEL_D3BB_:
	pop  af
	jp   gfx__clear_shadow_oam__275B

_LABEL_D3BF_:
	push hl
	add  $94
	ld   l, a
	ld   h, $00
	add  hl, hl
	ld   de, _RAM_CF00_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   a, [de]
	inc  de
	pop  hl
	rst  $28	; COPY_STRING_VRAM__RST_28
	ret

_LABEL_D3D2_:
	add  $94
	ld   l, a
	ld   h, $00
	add  hl, hl
	ld   de, _RAM_CF00_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   a, [de]
	inc  de
	ret

; Data from D3E2 to D3E8 (7 bytes)
db $3D, $00, $52, $61, $74, $65, $00

_LABEL_D3E9_:
	ld   de, $53E4
	ld   hl, _TILEMAP0
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   hl, _RAM_C700_
	ld   [hl], $31
	inc  hl
	ld   [hl], $20
	inc  hl
	push hl
	ld   a, [_RAM_C5CA_]
	call _LABEL_D3D2_
	pop  hl
_LABEL_D401_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_D401_
	dec  hl
	dec  hl
	ld   a, [hl]
	cp   $73
	jr   nz, _LABEL_D410_
	ld   [hl], $00
_LABEL_D410_:
	ld   de, $C700
	ld   hl, (_TILEMAP0 + $20)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   de, $53E2
	ld   hl, (_TILEMAP0 + $40)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   de, _RAM_C283_
	ld   hl, _RAM_C700_
_LABEL_D424_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_D42C_
	ldi  [hl], a
	jr   _LABEL_D424_

_LABEL_D42C_:
	ld   [hl], $20
	inc  hl
	push hl
	ld   a, [_RAM_C5CB_]
	call _LABEL_D3D2_
	pop  hl
_LABEL_D437_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_D437_
	ld   de, $C700
	ld   hl, (_TILEMAP0 + $60)
	rst  $28	; COPY_STRING_VRAM__RST_28
	ret

_LABEL_D445_:
	ld   hl, _RAM_C455_
_LABEL_D448_:
	ldi  a, [hl]
	or   a
	ret  z
	cp   $2E
	jr   nz, _LABEL_D448_
	ld   c, $03
_LABEL_D451_:
	ldi  a, [hl]
	or   a
	ret  z
	dec  c
	jr   nz, _LABEL_D451_
	ld   [hl], c
	ret

_LABEL_D459_:
	call _LABEL_D386_
	call gfx__turn_off_screen_2827
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $009E
	call _LABEL_1D2D_
	ld   bc, $0309
	call _LABEL_BC3_
	ld   a, $0C
	call _LABEL_E25B_
	ld   hl, _RAM_C283_
	ld   de, _RAM_C3EC_
	ld   b, $0A
_LABEL_D481_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	or   a
	jr   z, _LABEL_D48C_
	dec  b
	jr   nz, _LABEL_D481_
	xor  a
	ld   [de], a
_LABEL_D48C_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call gfx__clear_shadow_oam__275B
	call gfx__turn_off_screen_2827
	xor  a
	ld   [_RAM_C5CC_], a
	call _LABEL_2735_
	call _LABEL_D337_
	call _LABEL_D358_
	call gfx__clear_shadow_oam__275B
_LABEL_D4A6_:
	call _LABEL_2722_
	call _LABEL_D3E9_
	ld   a, $03
	ld   [_RAM_C479_], a
	call _LABEL_D16_
	ld   de, $C29F
	ld   hl, $98C0
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   a, [_RAM_C5CA_]
	ld   hl, $98E0
	call _LABEL_D3BF_
	ld   de, $53E2
	ld   hl, $9900
	rst  $28	; COPY_STRING_VRAM__RST_28
	call _LABEL_D445_
	ld   de, $C455
	ld   hl, $9920
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   a, [_RAM_C5CB_]
	ld   hl, $9940
	call _LABEL_D3BF_
	ld   de, _RAM_C283_
	ld   hl, _RAM_C3EC_
	call _LABEL_C611_
	ld   de, _RAM_C29F_
	ld   hl, _RAM_C3E0_
	call _LABEL_C611_
	ld   a, $02
	ld   [_RAM_C479_], a
	call _LABEL_D16_
	ld   de, $C29F
	ld   hl, $99A0
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   a, [_RAM_C5CB_]
	ld   hl, $99C0
	call _LABEL_D3BF_
	ld   de, $53E2
	ld   hl, $99E0
	rst  $28	; COPY_STRING_VRAM__RST_28
	call _LABEL_D445_
	ld   de, $C455
	ld   hl, $9A00
	rst  $28	; COPY_STRING_VRAM__RST_28
	ld   a, [_RAM_C5CA_]
	ld   hl, $9A20
	call _LABEL_D3BF_
_LABEL_D522_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	inc  a
	jr   z, _LABEL_D522_
	ld   hl, _RAM_C283_
	ld   de, _RAM_C800_
	ld   b, $0A
_LABEL_D52E_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_D52E_
	call gfx__turn_off_screen_2827
	call _LABEL_D386_
	ld   de, _RAM_C283_
	ld   hl, _RAM_C800_
	ld   b, $0A
_LABEL_D542_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_D542_
	jp   _LABEL_D4A6_

; Data from D54B to D569 (31 bytes)
db $02, $07, $0C, $F5, $21, $1A, $D0, $2A, $66, $6F, $F1, $5F, $87, $87, $57, $83
db $5F, $7A, $87, $87, $83, $16, $00, $5F, $19, $2A, $5D, $54, $C3, $C3, $0B

_LABEL_D56A_:
	ld   a, $64
	ld   [_RAM_C240_], a
	ld   bc, $09E0
	ld   e, $1E
	ld   a, [_RAM_C5CC_]
	cp   e
	jr   nz, _LABEL_D57C_
	ld   e, $2E
_LABEL_D57C_:
	call _LABEL_1CF6_
_LABEL_D57F_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_D597_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   nz, _LABEL_D5BA_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_D5BA_

_LABEL_D597_:
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   z, _LABEL_D5BA_
	ld   e, a
	ld   a, $19
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_D5CF_
	bit  7, a
	jr   nz, _LABEL_D5E6_
	bit  2, a
	jr   z, _LABEL_D5BA_
_LABEL_D5B1_:
	ld   a, [_RAM_C3B0_]
	bit  2, a
	jr   nz, _LABEL_D5B1_
	jr   _LABEL_D5FE_

_LABEL_D5BA_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_D57F_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_D5FE_
	cp   $12
	jr   z, _LABEL_D5E6_
	cp   $0F
	jr   nz, _LABEL_D57F_
_LABEL_D5CF_:
	ld   a, [_RAM_C399_]
	cp   $1E
	jr   nz, _LABEL_D5D8_
	ld   a, $8E
_LABEL_D5D8_:
	sub  $10
	ld   [_RAM_C399_], a
	ld   e, a
	ld   a, [_RAM_C5CC_]
	cp   e
	jr   z, _LABEL_D5CF_
	jr   _LABEL_D57F_

_LABEL_D5E6_:
	ld   a, [_RAM_C399_]
	cp   $7E
	jr   nz, _LABEL_D5EF_
	ld   a, $0E
_LABEL_D5EF_:
	add  $10
	ld   [_RAM_C399_], a
	ld   e, a
	ld   a, [_RAM_C5CC_]
	cp   e
	jr   z, _LABEL_D5E6_
	jp   _LABEL_D57F_

_LABEL_D5FE_:
	ret

; Pointer Table from D5FF to D608 (5 entries, indexed by _RAM_C259_)
_DATA_D5FF_:
dw _DATA_D609_, _DATA_D622_, _DATA_D641_, _DATA_D65D_, _DATA_D676_

; 1st entry of Pointer Table from D5FF (indexed by _RAM_C259_)
; Data from D609 to D621 (25 bytes)
_DATA_D609_:
db $04, $12, $00, $18, $2A, $01, $30, $3A, $02, $40, $4A, $03, $50, $5A, $04, $60
db $6A, $05, $70, $82, $06, $88, $95, $07, $FF

; 2nd entry of Pointer Table from D5FF (indexed by _RAM_C259_)
; Data from D622 to D640 (31 bytes)
_DATA_D622_:
db $00, $0A, $08, $10, $1A, $09, $20, $2A, $0A, $30, $3A, $0B, $40, $4A, $0C, $50
db $5A, $0D, $60, $6A, $0E, $70, $7A, $0F, $80, $8A, $10, $90, $9A, $11, $FF

; 3rd entry of Pointer Table from D5FF (indexed by _RAM_C259_)
; Data from D641 to D65C (28 bytes)
_DATA_D641_:
db $09, $13, $12, $19, $23, $13, $29, $33, $14, $39, $43, $15, $49, $53, $16, $59
db $63, $17, $69, $73, $18, $79, $83, $19, $89, $93, $1A, $FF

; 4th entry of Pointer Table from D5FF (indexed by _RAM_C259_)
; Data from D65D to D675 (25 bytes)
_DATA_D65D_:
db $10, $1A, $1B, $20, $2A, $1C, $30, $3A, $1D, $40, $4A, $1E, $50, $5A, $1F, $60
db $6A, $20, $70, $7A, $21, $80, $92, $22, $FF

; 5th entry of Pointer Table from D5FF (indexed by _RAM_C259_)
; Data from D676 to D685 (16 bytes)
_DATA_D676_:
db $04, $12, $23, $19, $23, $24, $2A, $78, $25, $82, $8A, $26, $91, $95, $27, $FF

; Data from D686 to D6AD (40 bytes)
_DATA_D686_:
db $00, $0B, $2C, $2E, $24, $2F, $80, $0A, $51, $57, $45, $52, $54, $59, $55, $49
db $4F, $50, $41, $53, $44, $46, $47, $48, $4A, $4B, $4C, $5A, $58, $43, $56, $42
db $4E, $4D, $0D, $0C, $22, $20, $3B, $27

; Data from D6AE to D6D5 (40 bytes)
_DATA_D6AE_:
db $00, $0B, $3C, $3E, $23, $3F, $80, $0A, $31, $32, $33, $72, $74, $79, $75, $21
db $7E, $2A, $34, $35, $36, $2B, $2D, $68, $6A, $28, $29, $37, $38, $39, $2E, $25
db $3D, $7F, $0D, $0C, $30, $20, $3A, $40

; Copies rows of text from RAM to hardware tile map
; Source is RAM because it copies there in order to patch the displayed version text
gfx__title_screen_copy_text_D6D6_:
	call gfx__turn_on_screen_bg_obj__2540
    ; Load tilemap data for title screen background borders with text "(c) 1992"
	ld   de, _DATA_7_
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 8)) ; $9900 ; Row 8
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "Montague-Weston."
	ld   de, $0008
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 9)) ; $9920 ; Row 9
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "Licensed"
	ld   de, $0009
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 10)) ; $9940 ; Row 10
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "exclusively to"
	ld   de, $000A
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 11)) ; $9960 ; Row 11
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "Fabtek, Inc."
	ld   de, $000B
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 12)) ; $9980 ; Row 12
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "Version 8.87" - RAM Patched from "Version 5.74
	ld   de, $000C
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 13)) ; $99A0 ; Row 13
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "Licensed by"
	ld   de, $000D
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 14)) ; $99C0 ; Row 14
	rst  $28	; COPY_STRING_VRAM__RST_28

    ; Load tilemap data text "Nintendo"
	ld   de, $000E
	ld   hl, (_TILEMAP0 + (_TILEMAP_WIDTH * 15)) ; $992E ; Row 15
	rst  $28	; COPY_STRING_VRAM__RST_28
	jp   gfx__turn_on_screen_bg_obj__2540

_LABEL_D714_:
	call _LABEL_41B_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00A0
	call _LABEL_1D2D_
	ld   bc, $0009
	call _LABEL_BC3_
	ld   de, $00A1
	call _LABEL_1D2D_
	ld   bc, $0409
	call _LABEL_BC3_
	ld   de, $00A2
	call _LABEL_1D2D_
	ld   bc, $0809
	call _LABEL_BC3_
	ld   de, $00D6
	call _LABEL_1D2D_
	ld   bc, $0C09
	call _LABEL_BC3_
	ld   hl, _DATA_DB3C_
	call _LABEL_2003_
	ld   a, [_RAM_C25B_]
	sub  $06
	ld   [_RAM_C25B_], a
	ld   a, [_RAM_C25C_]
	add  $06
	ld   [_RAM_C25C_], a
	call _LABEL_206D_
	cp   $01
	jr   z, _LABEL_D78B_
	cp   $03
	jr   z, _LABEL_D777_
	call _LABEL_8BC_
	jp   _LABEL_D49_

_LABEL_D777_:
	call _LABEL_2722_
	call _LABEL_F790_
	ld   [_SRAM_1F9_], a
	ld   a, $C8
	ld   [_RAM_C399_], a
	call _LABEL_F68_
	jp   _LABEL_D49_

_LABEL_D78B_:
	call _LABEL_2722_
	ld   de, $00A4
	ld   hl, $98A0
	rst  $20	; _LABEL_20_
	ld   de, $00A5
	ld   hl, $98E0
	rst  $20	; _LABEL_20_
_LABEL_D79C_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_D79C_
	ld   hl, $1071
	push af
	ld   a, [_RAM_C232_]
	ld   e, a
	ld   d, $00
	add  hl, de
	pop  af
	cp   [hl]
	jp   nz, _LABEL_D49_
	xor  a
	ld   [_SRAM_221_], a
	ld   [_SRAM_1F9_], a
	ld   [_SRAM_231_], a
	ld   [_RAM_C10B_], a
	ld   [_SRAM_A04_], a
	ld   [_RAM_C5CD_], a
	inc  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	dec  a
	ld   [_RAM_C10C_], a
	ld   [_SRAM_2001_], a
	ld   a, $02
	call mbc_sram_ON_set_srambank_to_A__0BB1
	xor  a
	ld   [_RAM_C10D_], a
	ld   [_SRAM_4000_], a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	inc  a
	ld   [_SRAM_9EF_], a
	ld   hl, _SRAM_1F5_
	ld   de, _DATA_E42A_
	ld   b, $04
_LABEL_D7EA_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_D7EA_
	jp   _LABEL_D49_

; Data from D7F3 to D7F9 (7 bytes)
db $03, $05, $09, $0D, $02, $05, $09

; Data from D7FA to D7FC (3 bytes)
_DATA_D7FA_:
db $02, $01, $05

_LABEL_D7FD_:
	ld   a, $01
	ld   [_RAM_C19A_], a
	ld   a, $08
	ld   [_RAM_C281_], a
	ld   a, $10
	ld   [_RAM_C282_], a
	call _LABEL_1563_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	xor  a
	ld   [_RAM_C130_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_D820_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_D820_
	or   a
	jr   nz, _LABEL_D836_
	call _LABEL_E67B_
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	jp   gfx__clear_shadow_oam__275B

_LABEL_D836_:
	cp   $09
	jr   nz, _LABEL_D863_
	ld   a, [_RAM_C282_]
	sub  $10
	or   a
	rr   a
	ld   d, $00
	ld   e, a
	ld   h, d
	ld   l, a
	add  hl, hl
	add  hl, hl
	add  hl, de
	ld   de, _RAM_C700_
	add  hl, de
	ld   b, h
	ld   c, l
	ld   de, $0014
	add  hl, de
	ld   a, [hl]
	ld   [hl], $00
	push hl
	push af
	ld   h, b
	ld   l, c
	call _LABEL_EA22_
	pop  af
	pop  hl
	ld   [hl], a
	ld   a, $0D
_LABEL_D863_:
	cp   $0B
	jr   nz, _LABEL_D871_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_D820_

_LABEL_D871_:
	cp   $C7
	jr   nz, _LABEL_D892_
	ld   a, [_RAM_C281_]
	sub  $08
	call _LABEL_21D7_
	ld   c, a
	ld   a, [_RAM_C282_]
	sub  $10
	call _LABEL_21D7_
	ld   b, a
	ld   hl, _RAM_C700_
	ld   de, _TILEMAP0
	call _LABEL_2173_
	jr   _LABEL_D820_

_LABEL_D892_:
	cp   $0C
	jr   nz, _LABEL_D8A1_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jp   _LABEL_D820_

_LABEL_D8A1_:
	cp   $0F
	jr   c, _LABEL_D8CD_
	cp   $13
	jr   nc, _LABEL_D8CD_
	cp   $0F
	jr   z, _LABEL_D8BB_
	cp   $10
	jr   z, _LABEL_D8C1_
	cp   $11
	jr   z, _LABEL_D8C7_
_LABEL_D8B5_:
	call _LABEL_D8FA_
	jp   _LABEL_D820_

_LABEL_D8BB_:
	call _LABEL_D909_
	jp   _LABEL_D820_

_LABEL_D8C1_:
	call _LABEL_D916_
	jp   _LABEL_D820_

_LABEL_D8C7_:
	call _LABEL_D928_
	jp   _LABEL_D820_

_LABEL_D8CD_:
	cp   $80
	jr   nz, _LABEL_D8DC_
	call _LABEL_D916_
	ld   a, $20
	call _LABEL_711_
	jp   _LABEL_D820_

_LABEL_D8DC_:
	cp   $7E
	jr   z, _LABEL_D8F0_
	cp   $61
	jp   nc, _LABEL_D820_
	cp   $0D
	jr   nz, _LABEL_D8F0_
	ld   a, $08
	ld   [_RAM_C281_], a
	jr   _LABEL_D8B5_

_LABEL_D8F0_:
	cp   $20
	jp   c, _LABEL_D820_
	call _LABEL_711_
	jr   _LABEL_D8C7_

_LABEL_D8FA_:
	ld   a, [_RAM_C282_]
	add  $08
	cp   $80
	jr   nz, _LABEL_D905_
	ld   a, $10
_LABEL_D905_:
	ld   [_RAM_C282_], a
	ret

_LABEL_D909_:
	ld   a, [_RAM_C282_]
	sub  $08
	cp   $08
	jr   nz, _LABEL_D905_
	ld   a, $78
	jr   _LABEL_D905_

_LABEL_D916_:
	ld   a, [_RAM_C281_]
	sub  $08
	jr   nz, _LABEL_D924_
	ld   a, $A0
	ld   [_RAM_C281_], a
	jr   _LABEL_D909_

_LABEL_D924_:
	ld   [_RAM_C281_], a
	ret

_LABEL_D928_:
	ld   a, [_RAM_C281_]
	add  $08
	cp   $A8
	jr   nz, _LABEL_D924_
	ld   a, $08
	ld   [_RAM_C281_], a
	jr   _LABEL_D8FA_

; Data from D938 to DB30 (505 bytes)
db $42, $41, $4E, $4B, $20, $00, $CD, $1B, $04, $CD, $22, $27, $3E, $5D, $EA, $AC
db $C3, $3E, $31, $EA, $AD, $C3, $11, $38, $59, $21, $00, $98, $E7, $CF, $FE, $FF
db $28, $FB, $B7, $CA, $00, $00, $FE, $30, $38, $F3, $FE, $38, $30, $EF, $EA, $00
db $C7, $AF, $EA, $01, $C7, $11, $00, $C7, $21, $05, $98, $E7, $FA, $00, $C7, $D6
db $30, $EA, $D0, $C5, $3E, $03, $EA, $FF, $3F, $3E, $0F, $CD, $5B, $62, $21, $83
db $C2, $06, $00, $2A, $B7, $28, $03, $04, $18, $F9, $78, $B7, $28, $EB, $FE, $06
db $28, $E7, $21, $00, $00, $01, $83, $C2, $FE, $01, $28, $44, $FE, $02, $28, $32
db $FE, $03, $28, $20, $FE, $04, $28, $0E, $0A, $11, $10, $27, $03, $D6, $30, $B7
db $28, $04, $19, $3D, $18, $F9, $11, $E8, $03, $0A, $03, $D6, $30, $B7, $28, $04
db $19, $3D, $18, $F9, $11, $64, $00, $0A, $03, $D6, $30, $B7, $28, $04, $19, $3D
db $18, $F9, $11, $0A, $00, $0A, $03, $D6, $30, $B7, $28, $04, $19, $3D, $18, $F9
db $16, $00, $0A, $D6, $30, $16, $00, $5F, $19, $7D, $EA, $CE, $C5, $7C, $EA, $CF
db $C5, $E5, $CD, $5B, $27, $CD, $22, $27, $21, $80, $99, $11, $38, $59, $E7, $FA
db $D0, $C5, $C6, $30, $EA, $00, $C7, $AF, $EA, $01, $C7, $11, $00, $C7, $21, $85
db $99, $E7, $CD, $7C, $5A, $E1, $FA, $D0, $C5, $EA, $FF, $5F, $06, $04, $C5, $E5
db $CD, $BB, $5A, $E1, $11, $06, $00, $19, $C1, $05, $20, $F2, $CF, $FE, $FF, $28
db $FB, $B7, $CA, $00, $00, $F5, $FA, $CE, $C5, $6F, $FA, $CF, $C5, $67, $F1, $FE
db $75, $28, $13, $FE, $36, $28, $14, $FE, $0F, $28, $15, $FE, $12, $28, $16, $FE
db $20, $CA, $3E, $59, $18, $D6, $11, $E8, $FF, $18, $0D, $11, $18, $00, $18, $08
db $11, $FA, $FF, $18, $03, $11, $06, $00, $19, $7D, $EA, $CE, $C5, $7C, $EA, $CF
db $C5, $C3, $F9, $59, $11, $00, $C7, $FA, $CF, $C5, $CD, $09, $29, $CD, $22, $5B
db $FA, $CF, $C5, $E6, $0F, $CD, $22, $5B, $FA, $CE, $C5, $CD, $09, $29, $CD, $22
db $5B, $FA, $CE, $C5, $E6, $0F, $CD, $22, $5B, $AF, $12, $11, $00, $C7, $21, $A0
db $99, $E7, $C9, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $41, $42, $43
db $44, $45, $46, $C5, $E5, $11, $00, $C7, $0E, $06, $7E, $CD, $09, $29, $CD, $22
db $5B, $2A, $E6, $0F, $CD, $22, $5B, $3E, $20, $12, $13, $0D, $20, $EC, $AF, $12
db $E1, $C1, $C5, $E5, $2E, $00, $CD, $0A, $5B, $E1, $C1, $C5, $E5, $0E, $06, $11
db $00, $C7, $2A, $FE, $20, $38, $04, $FE, $7B, $38, $02, $3E, $2E, $12, $13, $3E
db $20, $12, $13, $12, $13, $0D, $20, $EA, $AF, $12, $2E, $20, $CD, $0A, $5B, $E1
db $C1, $C9, $11, $00, $C7, $3E, $04, $90, $87, $87, $87, $87, $87, $87, $26, $98
db $85, $6F, $7C, $CE, $00, $67, $7D, $81, $E7, $C9, $E5, $21, $AB, $5A, $85, $6F
db $7C, $CE, $00, $67, $7E, $12, $13, $E1, $C9

; Data from DB31 to DB36 (6 bytes)
_DATA_DB31_:
db $05, $03, $06, $09, $0C, $0F

; Data from DB37 to DB3B (5 bytes)
_DATA_DB37_:
db $04, $03, $06, $09, $0C

; Data from DB3C to DB3F (4 bytes)
_DATA_DB3C_:
db $03, $04, $08, $0C

_LABEL_DB40_:
	ld   a, $20
	ld   b, $14
	ld   hl, _RAM_C11B_
_LABEL_DB47_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_DB47_
	ld   [hl], b
_LABEL_DB4C_:
	ld   de, $C11B
	ld   hl, (_TILEMAP0 + $60)
	rst  $20	; _LABEL_20_
	call _LABEL_2769_
	ld   a, [_RAM_C258_]
	ld   c, a
	ld   a, [_RAM_C259_]
	ld   b, a
	ld   a, [_RAM_C25A_]
	ld   e, a
	call _LABEL_1504_
	ld   a, [_RAM_C592_]
	or   a
	jr   z, _LABEL_DB79_
	ld   b, a
	call _LABEL_DC0E_
	cp   $0A
	jr   z, _LABEL_DB4C_
	cp   $FF
	jr   nz, _LABEL_DB80_
	jr   _LABEL_DB4C_

_LABEL_DB79_:
	ld   a, $39
	ld   [_RAM_C25A_], a
	jr   _LABEL_DB4C_

_LABEL_DB80_:
	or   a
	jp   z, _LABEL_200_
	cp   $0B
	jr   nz, _LABEL_DB98_
	ld   a, [_RAM_C234_]
	dec  a
	jr   z, _LABEL_DB4C_
	ld   a, $02
	ld   [_RAM_C280_], a
	call _LABEL_1241_
	jr   _LABEL_DB4C_

_LABEL_DB98_:
	cp   $0C
	jr   nz, _LABEL_DBAC_
	ld   a, [_RAM_C234_]
	or   a
	jr   z, _LABEL_DB4C_
	ld   a, $01
	ld   [_RAM_C280_], a
	call _LABEL_1210_
	jr   _LABEL_DB4C_

_LABEL_DBAC_:
	cp   $80
	jr   nz, _LABEL_DBCC_
	ld   a, [_RAM_C281_]
	cp   $08
	jr   z, _LABEL_DB4C_
	sub  $08
	ld   [_RAM_C281_], a
	call _LABEL_21D7_
	ld   hl, $C11A
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $20
	jr   _LABEL_DB4C_

_LABEL_DBCC_:
	cp   $0D
	jr   nz, _LABEL_DBEB_
	ld   a, [_RAM_C281_]
	cp   $08
	jp   z, _LABEL_DB4C_
	call _LABEL_21D7_
	dec  a
	ld   [_RAM_C23B_], a
	ld   hl, $C11B
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $00
	ret

_LABEL_DBEB_:
	cp   $61
	jp   nc, _LABEL_DB4C_
	ld   e, a
	ld   a, [_RAM_C281_]
	cp   $A0
	jp   z, _LABEL_DB4C_
	add  $08
	ld   [_RAM_C281_], a
	call _LABEL_21D7_
	ld   hl, $C119
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], e
	jp   _LABEL_DB4C_

_LABEL_DC0E_:
	ld   b, a
	and  $03
	or   a
	jr   z, _LABEL_DC50_
	ld   a, [_RAM_C259_]
	cp   $52
	jr   c, _LABEL_DC50_
	sub  $52
	ld   c, a
	and  $0F
	cp   $0B
	jr   nc, _LABEL_DC50_
	ld   a, c
	call _LABEL_2909_
	add  a
	ld   hl, _DATA_D5FF_
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ldi  a, [hl]
	ld   h, [hl]
	ld   l, a
	call _LABEL_DC9C_
	ld   [_RAM_C5D1_], a
	cp   $FF
	jr   z, _LABEL_DC50_
	ld   e, a
	ld   a, [_RAM_C25A_]
	cp   $3A
	jr   nz, _LABEL_DC4A_
	ld   a, $FF
	ret

_LABEL_DC4A_:
	inc  a
	ld   [_RAM_C25A_], a
	ld   a, e
	ret

_LABEL_DC50_:
	ld   a, $39
	ld   [_RAM_C25A_], a
	ld   a, [_RAM_C592_]
	ld   b, a
	bit  7, b
	call nz, _LABEL_DC70_
	bit  6, b
	call nz, _LABEL_DC7B_
	bit  5, b
	call nz, _LABEL_DC86_
	bit  4, b
	call nz, _LABEL_DC91_
	ld   a, $FF
	ret

_LABEL_DC70_:
	ld   a, [_RAM_C259_]
	inc  a
	cp   $98
	ret  z
	ld   [_RAM_C259_], a
	ret

_LABEL_DC7B_:
	ld   a, [_RAM_C259_]
	dec  a
	cp   $51
	ret  z
	ld   [_RAM_C259_], a
	ret

_LABEL_DC86_:
	ld   a, [_RAM_C258_]
	dec  a
	cp   $03
	ret  z
	ld   [_RAM_C258_], a
	ret

_LABEL_DC91_:
	ld   a, [_RAM_C258_]
	inc  a
	cp   $96
	ret  z
	ld   [_RAM_C258_], a
	ret

_LABEL_DC9C_:
	ldi  a, [hl]
	cp   $FF
	ret  z
	ld   c, a
	ldi  a, [hl]
	ld   b, a
	inc  b
	ldi  a, [hl]
	ld   e, a
	ld   a, [_RAM_C258_]
	cp   c
	jr   c, _LABEL_DCC4_
	cp   b
	jr   nc, _LABEL_DC9C_
	ld   hl, _DATA_D686_
	ld   a, [_RAM_C234_]
	or   a
	jr   z, _LABEL_DCBB_
	ld   hl, _DATA_D6AE_
_LABEL_DCBB_:
	ld   a, e
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ldi  a, [hl]
	ret

_LABEL_DCC4_:
	ld   a, $FF
	ret

_LABEL_DCC7_:
	call _LABEL_2722_
	ld   de, $00AA
	ld   hl, $98E4
	rst  $20	; _LABEL_20_
	ld   de, $0006
	ld   hl, $9923
	rst  $20	; _LABEL_20_
_LABEL_DCD8_:
	ld   a, [_RAM_C592_]
	or   a
	jr   nz, _LABEL_DCD8_
_LABEL_DCDE_:
	ld   a, [_RAM_C592_]
	or   a
	jr   z, _LABEL_DCDE_
	jp   _LABEL_200_

_LABEL_DCE7_:
	ld   a, $02
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call gfx__clear_shadow_oam__275B
	call _LABEL_2722_
	ld   a, $01
	ld   [_RAM_C10D_], a
	call _LABEL_680_
	xor  a
	ld   [_RAM_C23A_], a
_LABEL_DCFE_:
	call _LABEL_C46E_
	or   a
	jr   nz, _LABEL_DD22_
	ld   de, $0003
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	call _LABEL_7B3_
	ld   de, $00E0
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $00E1
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	call _LABEL_DCD8_
	jp   _LABEL_200_

_LABEL_DD22_:
	ld   a, [_RAM_C23A_]
	ld   [_RAM_C10D_], a
	call _LABEL_6D0_
	ld   de, $0003
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	call _LABEL_7B3_
	ld   de, $00D1
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $2150
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
_LABEL_DD43_:
	ld   a, [_RAM_C592_]
	and  $03
	jr   z, _LABEL_DD43_
	bit  0, a
	jr   nz, _LABEL_DD54_
	bit  1, a
	jr   z, _LABEL_DD43_
	jr   _LABEL_DCFE_

_LABEL_DD54_:
	call _LABEL_667_
	jp   _LABEL_200_

_LABEL_DD5A_:
	ld   a, $01
	call mbc_sram_ON_set_srambank_to_A__0BB1
	call gfx__clear_shadow_oam__275B
	call _LABEL_2722_
	ld   a, [_SRAM_2001_]
	or   a
	jp   z, _LABEL_DCC7_
	xor  a
	ld   [_RAM_C5C7_], a
_LABEL_DD70_:
	call _LABEL_CC76_
	or   a
	jr   z, _LABEL_DDBE_
	ld   de, $0001
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $00D1
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $2150
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	ld   a, [_RAM_C5C7_]
	ld   [_RAM_C10C_], a
	call _LABEL_7B6_
	ld   a, [_RAM_C5C7_]
	ld   hl, $9F76
	ld   de, $008C
_LABEL_DD9D_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_DD9D_
	ld   bc, _RAM_C700_
_LABEL_DDA4_:
	ldi  a, [hl]
	ld   [bc], a
	inc  bc
	dec  e
	jr   nz, _LABEL_DDA4_
	call _LABEL_E3A3_
_LABEL_DDAD_:
	ld   a, [_RAM_C592_]
	and  $03
	jr   z, _LABEL_DDAD_
	bit  0, a
	jr   nz, _LABEL_DDD6_
	bit  1, a
	jr   z, _LABEL_DDAD_
	jr   _LABEL_DD70_

_LABEL_DDBE_:
	ld   de, $2150
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	ld   de, $0085
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $0086
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
	jp   _LABEL_DCD8_

_LABEL_DDD6_:
	jp   _LABEL_200_

_LABEL_DDD9_:
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	call gfx__clear_shadow_oam__275B
	ld   a, [_SRAM_9EF_]
	or   a
	jp   z, _LABEL_DE1C_
	call _LABEL_41B_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00A5
	call _LABEL_1D2D_
	ld   bc, $0309
	call _LABEL_BC3_
	ld   a, $0F
	call _LABEL_E25B_
	xor  a
	ld   [_SRAM_9EF_], a
	call gfx__clear_shadow_oam__275B
	ld   hl, _SRAM_9F0_
	ld   de, _RAM_C283_
	ld   bc, _SRAM_9FA_
_LABEL_DE14_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	ld   [bc], a
	inc  bc
	or   a
	jr   nz, _LABEL_DE14_
_LABEL_DE1C_:
	call _LABEL_41B_
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   hl, _RAM_C283_
	ld   b, $14
	ld   a, $20
_LABEL_DE2F_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_DE2F_
	ld   hl, _RAM_C288_
	ld   de, _SRAM_9FA_
_LABEL_DE39_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_DE41_
	ldi  [hl], a
	jr   _LABEL_DE39_

_LABEL_DE41_:
	ld   de, $00A7
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $00A8
	call _LABEL_1D2D_
	ld   bc, $0509
	call _LABEL_BC3_
	ld   de, $00A6
	call _LABEL_1D2D_
	ld   bc, $0A09
	call _LABEL_BC3_
	ld   de, _RAM_C283_
	ld   bc, $0D09
	ld   a, $0C
	call _LABEL_BC3_
_LABEL_DE70_:
	ld   hl, _DATA_D7FA_
	call _LABEL_2003_
	call _LABEL_206D_
	cp   $02
	jp   z, _LABEL_E026_
	ld   a, [_SRAM_A04_]
	or   a
	jr   nz, _LABEL_DEB4_
	ld   a, [_SRAM_1F9_]
	or   a
	jr   nz, _LABEL_DE70_
	ld   b, $05
_LABEL_DE8C_:
	push bc
	ld   de, $00AA
	ld   hl, (_TILEMAP0 + $44)
	rst  $20	; _LABEL_20_
	ld   b, $0A
_LABEL_DE96_:
	rst  $18	; Call VSYNC__RST_18
	dec  b
	jr   nz, _LABEL_DE96_
	ld   de, $00AB
	ld   hl, (_TILEMAP0 + $44)
	rst  $20	; _LABEL_20_
	ld   b, $0A
_LABEL_DEA3_:
	rst  $18	; Call VSYNC__RST_18
	dec  b
	jr   nz, _LABEL_DEA3_
	pop  bc
	dec  b
	jr   nz, _LABEL_DE8C_
	ld   de, $00AC
	ld   hl, (_TILEMAP0 + $44)
	rst  $20	; _LABEL_20_
	jr   _LABEL_DE70_

_LABEL_DEB4_:
	ld   a, [_SRAM_A04_]
	ld   [_RAM_C5CD_], a
_LABEL_DEBA_:
	call gfx__turn_off_screen_2827
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   hl, _RAM_D06C_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   hl, _RAM_C283_
	ld   b, $14
_LABEL_DED1_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_DED1_
	ld   a, [_RAM_C5CD_]
	ld   b, $00
_LABEL_DEDC_:
	cp   $0A
	jr   c, _LABEL_DEE5_
	sub  $0A
	inc  b
	jr   _LABEL_DEDC_

_LABEL_DEE5_:
	add  $30
	ld   [_RAM_C294_], a
	ld   a, b
	add  $30
	ld   [_RAM_C293_], a
	ld   de, _RAM_C283_
	ld   bc, $0009
	ld   a, $12
	call _LABEL_BC3_
	ld   a, [_RAM_C5CD_]
	ld   hl, $A9E5
	ld   de, $0020
_LABEL_DF04_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_DF04_
	ld   bc, _RAM_C5D2_
_LABEL_DF0B_:
	ldi  a, [hl]
	ld   [bc], a
	inc  bc
	dec  e
	jr   nz, _LABEL_DF0B_
	call _LABEL_DFC0_
	ld   hl, _RAM_C283_
	ld   a, $20
	ld   b, $14
_LABEL_DF1B_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_DF1B_
	ld   hl, _RAM_C288_
	ld   de, _RAM_C5D5_
_LABEL_DF25_:
	ld   a, [de]
	or   a
	jr   z, _LABEL_DF2D_
	ldi  [hl], a
	inc  de
	jr   _LABEL_DF25_

_LABEL_DF2D_:
	ld   de, _RAM_C283_
	ld   bc, $0609
	ld   a, $0C
	call _LABEL_BC3_
	ld   a, [_RAM_C5DF_]
	or   a
	jr   nz, _LABEL_DF43_
	ld   de, $00B0
	jr   _LABEL_DF46_

_LABEL_DF43_:
	ld   de, $00B1
_LABEL_DF46_:
	call _LABEL_1D2D_
	ld   bc, $0909
	call _LABEL_BC3_
	ld   hl, _RAM_C283_
	ld   b, $14
	ld   a, $20
_LABEL_DF56_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_DF56_
	ld   de, _RAM_C5E0_
	ld   hl, _RAM_C284_
	ld   b, $12
_LABEL_DF62_:
	ld   a, [de]
	or   a
	jr   z, _LABEL_DF6B_
	ldi  [hl], a
	inc  de
	dec  b
	jr   nz, _LABEL_DF62_
_LABEL_DF6B_:
	ld   de, _RAM_C283_
	ld   bc, $0C09
	ld   a, $14
	call _LABEL_BC3_
	ld   de, $00B6
	ld   hl, $9A01
	rst  $20	; _LABEL_20_
_LABEL_DF7D_:
	ld   a, [_RAM_C232_]
	ld   e, a
	add  a
	add  e
	ld   e, a
	ld   d, $00
	ld   hl, $0F59
	add  hl, de
	push hl
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	pop  hl
	cp   $FF
	jr   z, _LABEL_DF7D_
	or   a
	jp   z, _LABEL_200_
	cp   [hl]
	jr   z, _LABEL_DFA3_
	inc  hl
	cp   [hl]
	jr   z, _LABEL_DFB4_
	inc  hl
	cp   [hl]
	jp   z, _LABEL_AF1_
	jr   _LABEL_DF7D_

_LABEL_DFA3_:
	ld   a, [_SRAM_A04_]
	ld   c, a
	ld   a, [_RAM_C5CD_]
	cp   c
	jr   z, _LABEL_DF7D_
	inc  a
	ld   [_RAM_C5CD_], a
	jp   _LABEL_DEBA_

_LABEL_DFB4_:
	ld   a, [_RAM_C5CD_]
	dec  a
	jr   z, _LABEL_DF7D_
	ld   [_RAM_C5CD_], a
	jp   _LABEL_DEBA_

_LABEL_DFC0_:
	ld   de, _DATA_2150_
	ld   bc, $0309
	ld   a, $0C
	call _LABEL_BC3_
	ld   hl, _RAM_C700_
	ld   a, [_RAM_C5D2_]
	ldi  [hl], a
	ld   a, [_RAM_C5D3_]
	ldi  [hl], a
	ld   a, [_RAM_C5D4_]
	ldi  [hl], a
	ld   a, [_SRAM_2A_]
	or   a
	jr   z, _LABEL_DFEE_
	ld   a, [_RAM_C700_]
	ld   c, a
	ld   a, [_RAM_C701_]
	ld   [_RAM_C700_], a
	ld   a, c
	ld   [_RAM_C701_], a
_LABEL_DFEE_:
	ld   a, [_RAM_C700_]
	ld   hl, $C261
	call _LABEL_2BBA_
	ld   a, [_RAM_C701_]
	ld   hl, $C263
	call _LABEL_2BBA_
	ld   hl, _RAM_C265_
	ld   [hl], $31
	inc  hl
	ld   [hl], $39
	inc  hl
	ld   [hl], $30
	inc  hl
	ld   [hl], $30
	ld   a, [_RAM_C702_]
	call _LABEL_235A_
	ld   de, $00AE
	ld   hl, (_TILEMAP0 + $87)
	rst  $20	; _LABEL_20_
	ld   a, $18
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
    ; Reset vblank command to default
	xor  a
	ld   [vblank__dispatch_select__RAM_C27C], a
	ret

_LABEL_E026_:
	call gfx__turn_off_screen_2827
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00AC
	call _LABEL_1D2D_
	ld   bc, $0009
	ld   a, $14
	call _LABEL_BC3_
	call _LABEL_E1CF_
	ld   de, _RAM_C700_
	ld   hl, _RAM_C5D2_
	ld   b, $03
_LABEL_E04B_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_E04B_
	ld   de, $00AF
	ld   hl, (_TILEMAP0 + $21)
	rst  $20	; _LABEL_20_
	ld   a, $06
	call _LABEL_E25B_
	ld   hl, _RAM_C5D5_
	ld   de, _RAM_C283_
_LABEL_E063_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_E063_
	ld   de, $00B0
	ld   hl, (_TILEMAP0 + $21)
	rst  $20	; _LABEL_20_
	ld   de, $00B0
	call _LABEL_1D2D_
	ld   bc, $0909
	call _LABEL_BC3_
	ld   de, $00B1
	call _LABEL_1D2D_
	ld   bc, $0C09
	call _LABEL_BC3_
	call gfx__clear_shadow_oam__275B
	ld   hl, _DATA_E1CC_
	call _LABEL_2003_
	call _LABEL_206D_
	push af
	cp   $01
	jr   z, _LABEL_E0A0_
	ld   de, $00B3
	ld   hl, $9947
	rst  $20	; _LABEL_20_
_LABEL_E0A0_:
	ld   de, $00B4
	ld   hl, $9986
	rst  $20	; _LABEL_20_
	ld   de, $00B4
	ld   hl, $99A6
	rst  $20	; _LABEL_20_
	ld   de, $00B4
	ld   hl, $99C6
	rst  $20	; _LABEL_20_
	pop  af
	dec  a
	ld   [_RAM_C5DF_], a
	ld   de, $00B5
	ld   hl, (_TILEMAP0 + $21)
	rst  $20	; _LABEL_20_
	ld   de, _DATA_2150_
	ld   bc, $0C09
	ld   a, $14
	call _LABEL_BC3_
	ld   a, $F2
	ldh  [rOBP0], a
_LABEL_E0D0_:
	xor  a
	ld   [_RAM_C11B_], a
	ld   a, $07
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   a, $10
	ld   [_RAM_C281_], a
	ld   a, $78
	call _LABEL_CCBD_
	ld   a, [_RAM_C281_]
	cp   $10
	jr   z, _LABEL_E0D0_
	sub  $10
	or   a
	rr   a
	or   a
	rr   a
	or   a
	rr   a
	ld   [_RAM_C23B_], a
	ld   hl, _RAM_C5E0_
	ld   a, $20
	ld   b, $12
_LABEL_E0FF_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_E0FF_
	ld   de, _RAM_C11B_
	ld   hl, _RAM_C5E0_
_LABEL_E109_:
	ld   a, [de]
	inc  de
	or   a
	jr   z, _LABEL_E111_
	ldi  [hl], a
	jr   _LABEL_E109_

_LABEL_E111_:
	ld   a, [_SRAM_A04_]
	cp   $32
	jr   nz, _LABEL_E15A_
	ld   de, _SRAM_9F0_
	ld   hl, _RAM_C3E0_
_LABEL_E11E_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_E11E_
	ld   de, _SRAM_A08_
	ld   hl, _RAM_C3EC_
_LABEL_E12A_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_E12A_
	ld   a, [_SRAM_A12_]
	ld   [_RAM_C479_], a
	call _LABEL_D16_
	ld   hl, _RAM_C455_
	ld   de, _SRAM_9F0_
_LABEL_E13F_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	or   a
	jr   nz, _LABEL_E13F_
	ld   hl, _SRAM_A05_
	ld   de, _SRAM_A25_
	ld   bc, $0620
_LABEL_E14E_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_E14E_
	ld   hl, _SRAM_A04_
	dec  [hl]
_LABEL_E15A_:
	ld   hl, _SRAM_A04_
	inc  [hl]
	ld   a, [hl]
	ld   hl, $A9E5
	ld   de, $0020
_LABEL_E165_:
	add  hl, de
	dec  a
	jr   nz, _LABEL_E165_
	ld   bc, _RAM_C5D2_
_LABEL_E16C_:
	ld   a, [bc]
	inc  bc
	ldi  [hl], a
	dec  e
	jr   nz, _LABEL_E16C_
	ld   a, [_SRAM_A04_]
	call _LABEL_E17B_
	jp   _LABEL_AF1_

_LABEL_E17B_:
	push af
	ld   de, _SRAM_9F0_
	ld   hl, _RAM_C455_
_LABEL_E182_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_E182_
	pop  af
	ld   hl, _SRAM_A05_
_LABEL_E18C_:
	push af
	ld   de, _RAM_C5D2_
	ld   b, $20
_LABEL_E192_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_E192_
	push hl
	ld   de, _RAM_C455_
	ld   hl, _RAM_C3E0_
_LABEL_E19F_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_E19F_
	ld   de, _RAM_C5D5_
	ld   hl, _RAM_C3EC_
_LABEL_E1AB_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	or   a
	jr   nz, _LABEL_E1AB_
	ld   a, [_RAM_C5DF_]
	ld   [_RAM_C479_], a
	call _LABEL_D16_
	pop  hl
	pop  af
	dec  a
	jr   nz, _LABEL_E18C_
	ld   hl, _RAM_C455_
	ld   de, _SRAM_9FA_
_LABEL_E1C5_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	or   a
	jr   nz, _LABEL_E1C5_
	ret

; Data from E1CC to E1CE (3 bytes)
_DATA_E1CC_:
db $02, $09, $0C

_LABEL_E1CF_:
	ld   de, _DATA_2150_
	ld   bc, $0309
	ld   a, $0C
	call _LABEL_BC3_
_LABEL_E1DA_:
	ld   hl, _RAM_C700_
	ld   a, [_RAM_C139_]
	ldi  [hl], a
	ld   a, [_RAM_C138_]
	ldi  [hl], a
	ld   a, [_RAM_C13A_]
	ldi  [hl], a
	ld   a, [_SRAM_2A_]
	or   a
	jr   z, _LABEL_E1FD_
	ld   a, [_RAM_C700_]
	ld   c, a
	ld   a, [_RAM_C701_]
	ld   [_RAM_C700_], a
	ld   a, c
	ld   [_RAM_C701_], a
_LABEL_E1FD_:
	call _LABEL_2B_
	ld   a, $03
	ld   [_RAM_C280_], a
	ld   a, [_RAM_C700_]
	ld   hl, _RAM_C261_
	call _LABEL_2BBA_
	ld   a, [_RAM_C701_]
	ld   hl, $C263
	call _LABEL_2BBA_
	ld   hl, _RAM_C265_
	ld   [hl], $31
	inc  hl
	ld   [hl], $39
	inc  hl
	ld   [hl], $30
	inc  hl
	ld   [hl], $30
	ld   a, [_RAM_C702_]
	call _LABEL_235A_
	ld   de, $00AE
	ld   hl, (_TILEMAP0 + $87)
	rst  $20	; _LABEL_20_
	ld   a, $18
	ld   [vblank__dispatch_select__RAM_C27C], a
	ld   bc, $0700
	ld   de, $2373
	ld   hl, $C261
	ld   a, $C7
	ld   [_RAM_C260_], a
	ld   a, $30
	call _LABEL_2411_
	push af
	xor  a
	ld   [_RAM_C260_], a
	pop  af
	inc  a
	jp   z, _LABEL_AF1_
	call _LABEL_B6C_
	or   a
	jr   nz, _LABEL_E1DA_
	ret

_LABEL_E25B_:
	ld   [_RAM_C5F2_], a
	ld   de, _DATA_2150_
	ld   c, $09
	ld   b, a
	inc  a
	ld   [_RAM_C5F2_], a
	ld   a, $0C
	call _LABEL_BC3_
	ld   a, $30
	ld   [_RAM_C281_], a
	ld   a, $03
	ld   [_RAM_C280_], a
	ld   a, [_RAM_C5F2_]
	add  a
	add  a
	add  a
	add  $10
	ld   [_RAM_C282_], a
	ld   hl, _RAM_C283_
	ld   b, $1C
	ld   a, $20
_LABEL_E289_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_E289_
	call _LABEL_2B_
	ld   a, $19
	ld   [vblank__dispatch_select__RAM_C27C], a
	xor  a
	ld   [_RAM_C474_], a
	ld   [_RAM_C475_], a
_LABEL_E29C_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_E29C_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jp   z, _LABEL_E362_
	cp   $80
	jr   z, _LABEL_E30D_
	cp   $2D
	jr   z, _LABEL_E2FD_
	cp   $0A
	jp   z, _LABEL_E348_
	cp   $2E
	jr   z, _LABEL_E32E_
	cp   $30
	jr   c, _LABEL_E29C_
	cp   $3A
	jr   nc, _LABEL_E29C_
_LABEL_E2C7_:
	ld   c, a
	ld   a, [_RAM_C474_]
	cp   $09
	jr   z, _LABEL_E29C_
	or   a
	jr   nz, _LABEL_E2D2_
_LABEL_E2D2_:
	cp   $01
	jr   nz, _LABEL_E2E4_
	ld   a, c
	cp   $30
	jr   nz, _LABEL_E2E2_
	ld   a, [_RAM_C283_]
	cp   $30
	jr   z, _LABEL_E29C_
_LABEL_E2E2_:
	ld   a, $01
_LABEL_E2E4_:
	inc  a
	ld   [_RAM_C474_], a
	ld   hl, $C283
	dec  a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], c
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jr   _LABEL_E29C_

_LABEL_E2FD_:
	ld   a, [_SRAM_9EF_]
	or   a
	jr   z, _LABEL_E29C_
	ld   a, [_RAM_C474_]
	or   a
	jr   nz, _LABEL_E29C_
	ld   a, $2D
	jr   _LABEL_E2C7_

_LABEL_E30D_:
	ld   a, [_RAM_C474_]
	or   a
	jr   z, _LABEL_E29C_
	ld   hl, $C283
	dec  a
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $20
	ld   hl, _RAM_C474_
	dec  [hl]
	ld   a, [_RAM_C281_]
	sub  $08
	ld   [_RAM_C281_], a
	jp   _LABEL_E29C_

_LABEL_E32E_:
	ld   a, [_RAM_C474_]
	cp   $08
	jp   nc, _LABEL_E29C_
	ld   a, [_RAM_C475_]
	or   a
	jp   nz, _LABEL_E29C_
	inc  a
	ld   [_RAM_C475_], a
	ld   c, $2E
	ld   a, [_RAM_C474_]
	jr   _LABEL_E2D2_

_LABEL_E348_:
	ld   b, $14
	ld   hl, _RAM_C283_
	ld   a, $20
_LABEL_E34F_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_E34F_
	xor  a
	ld   [_RAM_C475_], a
	ld   [_RAM_C474_], a
	ld   a, $30
	ld   [_RAM_C281_], a
	jp   _LABEL_E29C_

_LABEL_E362_:
	ld   a, [_RAM_C474_]
	or   a
	jp   z, _LABEL_E29C_
	ld   hl, $C283
	push af
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   [hl], $00
	pop  af
	ld   hl, _RAM_C283_
	ld   b, a
_LABEL_E37A_:
	ldi  a, [hl]
	cp   $30
	jr   c, _LABEL_E383_
	cp   $3A
	jr   c, _LABEL_E389_
_LABEL_E383_:
	dec  b
	jr   nz, _LABEL_E37A_
	jp   _LABEL_E29C_

_LABEL_E389_:
	ld   hl, _RAM_C283_
	ld   b, $09
_LABEL_E38E_:
	ldi  a, [hl]
	cp   $31
	jr   c, _LABEL_E396_
	cp   $3A
	ret  c
_LABEL_E396_:
	dec  b
	jr   nz, _LABEL_E38E_
	ld   a, $30
	ld   [_RAM_C283_], a
	xor  a
	ld   [_RAM_C284_], a
	ret

_LABEL_E3A3_:
	call gfx__clear_shadow_oam__275B
	ld   a, [_SRAM_2001_]
	or   a
	jr   nz, _LABEL_E3C3_
	ld   hl, _TILEMAP0
	ld   b, $0E
_LABEL_E3B1_:
	push bc
	push hl
	ld   de, $2150
	rst  $20	; _LABEL_20_
	pop  hl
	ld   de, $0020
	add  hl, de
	pop  bc
	dec  b
	jr   nz, _LABEL_E3B1_
	jp   _LABEL_62C_

_LABEL_E3C3_:
	call gfx__clear_shadow_oam__275B
	ld   de, $00B8
	ld   hl, _TILEMAP0
	rst  $20	; _LABEL_20_
	ld   de, $481C
	ld   hl, (_TILEMAP0 + $20)
	rst  $20	; _LABEL_20_
	ld   a, $06
	ld   de, $C700
	ld   bc, _RAM_C714_
	ld   hl, (_TILEMAP0 + $40)
_LABEL_E3DF_:
	push af
	push de
	push hl
	push bc
	ld   a, [bc]
	push af
	xor  a
	ld   [bc], a
	rst  $20	; _LABEL_20_
	pop  af
	pop  bc
	ld   [bc], a
	ld   a, c
	add  $14
	ld   c, a
	ld   a, b
	adc  $00
	ld   b, a
	pop  hl
	pop  de
	ld   a, l
	add  $20
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   a, e
	add  $14
	ld   e, a
	ld   a, d
	adc  $00
	ld   d, a
	pop  af
	dec  a
	jr   nz, _LABEL_E3DF_
	ld   de, $481C
	ld   hl, $9900
	rst  $20	; _LABEL_20_
	ld   de, $00B9
	ld   hl, $9960
	rst  $20	; _LABEL_20_
	ld   de, $481C
	ld   hl, $9980
	rst  $20	; _LABEL_20_
	xor  a
	ld   [_RAM_C78C_], a
	ld   de, $C778
	ld   hl, $99A0
	rst  $20	; _LABEL_20_
	ret

; Data from E42A to E42D (4 bytes)
_DATA_E42A_:
db $49, $47, $4F, $52

_LABEL_E42E_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   hl, $A1F5
	ld   de, _DATA_E42A_
	ld   b, $04
_LABEL_E43A_:
	ld   a, [de]
	inc  de
	cp   [hl]
	jr   nz, _LABEL_E444_
	inc  hl
	dec  b
	jr   nz, _LABEL_E43A_
	ret

_LABEL_E444_:
	ld   a, [_RAM_C10A_]
	or   a
	jr   z, _LABEL_E45C_
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	ld   hl, _SRAM_1F5_
	ld   de, _DATA_E42A_
	ld   b, $04
_LABEL_E456_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_E456_
_LABEL_E45C_:
	xor  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	xor  a
	ld   [_SRAM_231_], a
	ld   [_RAM_C10B_], a
	ld   [_SRAM_221_], a
	ld   [_SRAM_A04_], a
	ld   [_RAM_C5CD_], a
	inc  a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	dec  a
	ld   [_RAM_C10C_], a
	ld   [_SRAM_1_], a
	ld   a, $02
	call mbc_sram_ON_set_srambank_to_A__0BB1
	xor  a
	ld   [_RAM_C10D_], a
	ld   [_SRAM_4000_], a
	call mbc_sram_ON_set_srambank_to_A__0BB1
	inc  a
	ld   [_SRAM_9EF_], a
	ld   a, [_RAM_C10A_]
	or   a
	ret  z
	ld   a, $03
	call mbc_sram_ON_set_srambank_to_A__0BB1
	xor  a
	ld   [_SRAM_602C_], a
	ld   a, $47
	ld   [_SRAM_602B_], a
	call _LABEL_8BC_
	xor  a
	jp   mbc_sram_ON_set_srambank_to_A__0BB1

; Data from E4A8 to E4CF (40 bytes)
db $52, $46, $4D, $43, $45, $4E, $50, $51, $4E, $53, $41, $4C, $44, $56, $52, $45
db $4E, $54, $46, $45, $44, $53, $50, $51, $4E, $4C, $48, $42, $45, $50, $41, $53
db $4E, $54, $46, $43, $52, $50, $45, $55

_LABEL_E4D0_:
	call _LABEL_1563_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
_LABEL_E4DB_:
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_E4DB_
	or   a
	jr   nz, _LABEL_E4F1_
_LABEL_E4EB_:
	call _LABEL_E67B_
	jp   _LABEL_200_

_LABEL_E4F1_:
	push af
	ld   a, [_RAM_C232_]
	add  a
	add  a
	add  a
	ld   d, $00
	ld   e, a
	ld   hl, $64A8
	add  hl, de
	pop  af
	cp   [hl]
	jr   nz, _LABEL_E514_
	ld   a, [_SRAM_4000_]
	or   a
	jr   z, _LABEL_E4DB_
	call _LABEL_4C9_
	call gfx__clear_shadow_oam__275B
	call _LABEL_7B3_
	jr   _LABEL_E4DB_

_LABEL_E514_:
	inc  hl
	cp   [hl]
	jp   nz, _LABEL_E59E_
	ld   a, [_RAM_C10D_]
	or   a
	jr   z, _LABEL_E4DB_
	call _LABEL_E67B_
	call _LABEL_680_
	xor  a
	ld   [_RAM_C11B_], a
	ld   [_RAM_C23B_], a
	ld   [_RAM_C23A_], a
	call _LABEL_C363_
_LABEL_E532_:
	call _LABEL_C46E_
	or   a
	jr   nz, _LABEL_E55B_
	ld   de, $0003
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	call _LABEL_7B3_
	ld   de, $00E0
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $00E1
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
_LABEL_E550_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_E550_
	call _LABEL_654_
	jp   _LABEL_E4DB_

_LABEL_E55B_:
	ld   a, [_RAM_C23A_]
	ld   [_RAM_C10D_], a
	call _LABEL_6D0_
	ld   de, $0003
	ld   hl, $99E0
	rst  $20	; _LABEL_20_
	call _LABEL_7B3_
	ld   de, $0017
	ld   hl, $9A00
	rst  $20	; _LABEL_20_
	ld   de, $2150
	ld   hl, $9A20
	rst  $20	; _LABEL_20_
_LABEL_E57C_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_E57C_
	or   a
	jr   z, _LABEL_E598_
	push af
	ld   a, [_RAM_C232_]
	add  a
	ld   d, $00
	ld   e, a
	ld   hl, $1058
	add  hl, de
	pop  af
	cp   [hl]
	jr   z, _LABEL_E532_
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_E57C_
_LABEL_E598_:
	call _LABEL_667_
	jp   _LABEL_E4DB_

_LABEL_E59E_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_E5DB_
	ld   hl, _SRAM_4002_
	ld   a, [_SRAM_4000_]
	or   a
	jr   z, _LABEL_E5C2_
	ld   b, a
_LABEL_E5AC_:
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	dec  hl
	add  hl, de
	dec  b
	jr   nz, _LABEL_E5AC_
	ld   a, h
	cp   $BE
	jr   c, _LABEL_E5C2_
	jp   nz, _LABEL_E4DB_
	ld   a, l
	cp   $E3
	jp   nc, _LABEL_E4DB_
_LABEL_E5C2_:
	call _LABEL_E67B_
	ld   a, [_SRAM_4000_]
	inc  a
	jp   z, _LABEL_E4DB_
	ld   [_SRAM_4000_], a
	ld   [_RAM_C10D_], a
	call _LABEL_E661_
	call _LABEL_D7FD_
	jp   _LABEL_498_

_LABEL_E5DB_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_E5FB_
	ld   a, [_SRAM_4000_]
	or   a
	jp   z, _LABEL_E4DB_
	call _LABEL_132B_
	push af
	call _LABEL_667_
	pop  af
	or   a
	jp   z, _LABEL_E4DB_
	call _LABEL_E661_
	call _LABEL_E67B_
	jp   _LABEL_498_

_LABEL_E5FB_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_E60C_
	ld   a, [_RAM_C10D_]
	or   a
	jp   z, _LABEL_E4DB_
	call _LABEL_D7FD_
	jp   _LABEL_498_

_LABEL_E60C_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_E62D_
	ld   a, [_SRAM_4000_]
	ld   c, a
	ld   a, [_RAM_C10D_]
	cp   c
	jp   z, _LABEL_E4DB_
	ld   a, $08
	ld   [_RAM_C281_], a
	add  a
	ld   [_RAM_C282_], a
	call _LABEL_E67B_
	ld   a, [_RAM_C10D_]
	inc  a
	jr   _LABEL_E64D_

_LABEL_E62D_:
	inc  hl
	cp   [hl]
	jr   nz, _LABEL_E659_
	ld   a, [_RAM_C10D_]
	or   a
	jp   z, _LABEL_E4DB_
	cp   $01
	jp   z, _LABEL_E4DB_
	ld   a, $08
	ld   [_RAM_C281_], a
	add  a
	ld   [_RAM_C282_], a
	call _LABEL_E67B_
	ld   a, [_RAM_C10D_]
	dec  a
_LABEL_E64D_:
	ld   [_RAM_C10D_], a
	call _LABEL_680_
	call _LABEL_6D0_
	jp   _LABEL_E4DB_

_LABEL_E659_:
	inc  hl
	cp   [hl]
	jp   z, _LABEL_E4EB_
	jp   _LABEL_E4DB_

_LABEL_E661_:
	ld   hl, _RAM_C700_
	ld   bc, $0118
_LABEL_E667_:
	ld   [hl], $20
	inc  hl
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_E667_
	ld   a, $08
	ld   [_RAM_C281_], a
	add  a
	ld   [_RAM_C282_], a
	jp   _LABEL_6D0_

_LABEL_E67B_:
	ld   a, [_SRAM_2000_]
	or   a
	ret  z
	ld   a, [_RAM_C5F3_]
	or   a
	ret  z
	ld   hl, _RAM_C700_
	ld   de, _RAM_C700_
	ld   a, $0E
_LABEL_E68D_:
	push af
	ld   b, $14
_LABEL_E690_:
	ldi  a, [hl]
	cp   $20
	jr   z, _LABEL_E69C_
_LABEL_E695_:
	ld   [de], a
	inc  de
	dec  b
	jr   nz, _LABEL_E690_
	jr   _LABEL_E6B2_

_LABEL_E69C_:
	ld   c, $80
_LABEL_E69E_:
	inc  c
	dec  b
	jr   z, _LABEL_E6AE_
	ldi  a, [hl]
	cp   $20
	jr   z, _LABEL_E69E_
	push af
	ld   a, c
	ld   [de], a
	inc  de
	pop  af
	jr   _LABEL_E695_

_LABEL_E6AE_:
	ld   a, $0D
	ld   [de], a
	inc  de
_LABEL_E6B2_:
	pop  af
	dec  a
	jr   nz, _LABEL_E68D_
	ld   a, e
	sub  $00
	ld   l, a
	ld   a, d
	sbc  $C7
	ld   h, a
	inc  hl
	inc  hl
	ld   a, h
	or   a
	jr   nz, _LABEL_E715_
	ld   a, l
	cp   $10
	jr   nz, _LABEL_E715_
	ld   a, [_SRAM_2000_]
	cp   $01
	jr   nz, _LABEL_E6D8_
	dec  a
	ld   [_SRAM_2000_], a
	ld   [_RAM_C10D_], a
	ret

_LABEL_E6D8_:
	ld   c, a
	ld   a, [_RAM_C10D_]
	cp   c
	jr   nz, _LABEL_E6E8_
	dec  a
	ld   [_RAM_C10D_], a
	ld   hl, _SRAM_2000_
	dec  [hl]
	ret

_LABEL_E6E8_:
	ld   hl, _SRAM_2002_
	ld   a, [_RAM_C10D_]
	ld   b, a
_LABEL_E6EF_:
	dec  b
	jr   z, _LABEL_E6F9_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	dec  hl
	add  hl, de
	jr   _LABEL_E6EF_

_LABEL_E6F9_:
	push hl
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	dec  hl
	add  hl, de
	pop  de
	ld   a, $FF
	sub  l
	ld   c, a
	ld   a, $BF
	sbc  a, h
	ld   b, a
_LABEL_E708_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_E708_
	ld   hl, _SRAM_2000_
	dec  [hl]
	ret

_LABEL_E715_:
	push hl
	ld   a, l
	ld   [_RAM_C235_], a
	ld   a, [_RAM_C10D_]
	call _LABEL_7B3_
	ld   hl, _SRAM_2002_
	ld   a, [_RAM_C10D_]
	ld   b, a
_LABEL_E727_:
	dec  b
	jr   z, _LABEL_E731_
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	dec  hl
	add  hl, de
	jr   _LABEL_E727_

_LABEL_E731_:
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	dec  hl
	ld   a, [_RAM_C10D_]
	ld   c, a
	ld   a, [_SRAM_2000_]
	cp   c
	jr   nz, _LABEL_E742_
	pop  bc
	jr   _LABEL_E772_

_LABEL_E742_:
	pop  bc
	ld   a, b
	cp   d
	jr   z, _LABEL_E74B_
	jr   c, _LABEL_E751_
	jr   _LABEL_E784_

_LABEL_E74B_:
	ld   a, c
	cp   e
	jr   z, _LABEL_E772_
	jr   nc, _LABEL_E784_
_LABEL_E751_:
	push hl
	push bc
	ld   a, e
	sub  c
	ld   e, a
	ld   a, d
	sbc  a, b
	ld   d, a
	add  hl, bc
	push hl
	add  hl, de
	ld   e, l
	ld   d, h
	pop  hl
	ld   bc, $BFFF
	ld   a, c
	sub  e
	ld   c, a
	ld   a, b
	sbc  a, d
	ld   b, a
_LABEL_E768_:
	ld   a, [de]
	ldi  [hl], a
	inc  de
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_E768_
	pop  bc
	pop  hl
_LABEL_E772_:
	ld   [hl], c
	inc  hl
	ld   [hl], b
	inc  hl
	dec  bc
	dec  bc
	ld   de, _RAM_C700_
_LABEL_E77B_:
	ld   a, [de]
	inc  de
	ldi  [hl], a
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_E77B_
	ret

_LABEL_E784_:
	push bc
	push hl
	ld   a, c
	sub  e
	ld   c, a
	ld   a, b
	sbc  a, d
	ld   b, a
	ld   a, $FF
	sub  c
	ld   e, a
	ld   a, $BF
	sbc  a, b
	ld   d, a
	pop  hl
	push hl
	ld   a, e
	sub  l
	ld   c, a
	ld   a, d
	sbc  a, h
	ld   b, a
	ld   hl, _SRAM_3FFF_
_LABEL_E79F_:
	ld   a, [de]
	dec  de
	ldd  [hl], a
	dec  bc
	ld   a, b
	or   c
	jr   nz, _LABEL_E79F_
	pop  hl
	pop  bc
	jr   _LABEL_E772_

; Data from E7AB to E7AB (1 bytes)
db $C9

; Data from E7AC to E7EB (64 bytes)
_DATA_E7AC_:
db $75, $07, $9E, $07, $44, $07, $94, $07, $44, $07, $9E, $07, $44, $07, $A7, $07
db $56, $07, $94, $07, $56, $07, $9E, $07, $56, $07, $A7, $07, $66, $07, $94, $07
db $66, $07, $9E, $07, $66, $07, $A7, $07, $44, $07, $B0, $07, $56, $07, $B0, $07
db $66, $07, $B0, $07, $75, $07, $B0, $07, $75, $07, $94, $07, $75, $07, $A7, $07

_LABEL_E7EC_:
	call _LABEL_15E1_
_LABEL_E7EF_:
	di
	ld   a, $04
	ldh  [rSTAT], a
	ld   a, $01
	ldh  [rIE], a
	ei
	xor  a
	ld   [_RAM_C23E_], a
	ld   a, $F2
	ldh  [rOBP0], a
	call gfx__turn_off_screen_2827
	call _LABEL_B99_
	ld   de, _DATA_F40C_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00BA
	call _LABEL_1D2D_
	ld   bc, $0009
	ld   a, $14
	call _LABEL_BC3_
	ld   a, $14
	ld   bc, $0F09
	ld   de, _DATA_2150_
	call _LABEL_BC3_
	ld   hl, _RAM_C11B_
	ld   b, $12
	ld   a, $20
_LABEL_E830_:
	ldi  [hl], a
	dec  b
	jr   nz, _LABEL_E830_
	ld   [hl], b
	ld   a, $15
	ld   [vblank__dispatch_select__RAM_C27C], a
	call _LABEL_E843_
	call _LABEL_E9FC_
	jp   _LABEL_BA2_

_LABEL_E843_:
	xor  a
	ld   [_RAM_C130_], a
	ld   [_RAM_C239_], a
	ld   a, [_RAM_C281_]
	ld   [_RAM_C237_], a
	ld   a, [_RAM_C282_]
	ld   [_RAM_C238_], a
	rst  $18	; Call VSYNC__RST_18
	ld   [_RAM_C281_], a
	ld   a, $90
	ld   [_RAM_C282_], a
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
_LABEL_E867_:
	rst  $18	; Call VSYNC__RST_18
	call _LABEL_2769_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_E867_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jp   z, _LABEL_E92D_
	cp   $0B
	jr   nz, _LABEL_E887_
	call _LABEL_2B_
	ld   a, $02
	ld   [_RAM_C280_], a
	jr   _LABEL_E867_

_LABEL_E887_:
	cp   $0C
	jr   nz, _LABEL_E895_
	call _LABEL_26C_
	ld   a, $01
	ld   [_RAM_C280_], a
	jr   _LABEL_E867_

_LABEL_E895_:
	cp   $80
	jr   nz, _LABEL_E8AC_
	ld   a, [_RAM_C281_]
	cp   $10
	jr   z, _LABEL_E867_
	sub  $08
	ld   [_RAM_C281_], a
	ld   a, $20
	call _LABEL_76A_
	jr   _LABEL_E867_

_LABEL_E8AC_:
	cp   $C7
	jr   nz, _LABEL_E8D5_
	ld   a, [_RAM_C281_]
	cp   $98
	jr   z, _LABEL_E867_
	ld   c, a
	ld   a, $A0
	sub  c
	call _LABEL_21D7_
	ld   hl, _RAM_C12D_
	ld   de, _RAM_C12C_
	ld   b, a
_LABEL_E8C5_:
	ld   a, [de]
	dec  de
	ldd  [hl], a
	dec  b
	jr   nz, _LABEL_E8C5_
	ld   [hl], $20
	ld   a, $15
	ld   [vblank__dispatch_select__RAM_C27C], a
	rst  $18	; Call VSYNC__RST_18
	jr   _LABEL_E867_

_LABEL_E8D5_:
	cp   $10
	jr   nz, _LABEL_E8EE_
	ld   c, $F8
_LABEL_E8DB_:
	ld   a, [_RAM_C281_]
	add  c
	cp   $08
	jr   z, _LABEL_E867_
	cp   $A0
	jp   z, _LABEL_E867_
	ld   [_RAM_C281_], a
	jp   _LABEL_E867_

_LABEL_E8EE_:
	cp   $11
	jr   nz, _LABEL_E8F6_
	ld   c, $08
	jr   _LABEL_E8DB_

_LABEL_E8F6_:
	cp   $23
	jr   z, _LABEL_E915_
	cp   $20
	jr   z, _LABEL_E915_
	cp   $2A
	jr   z, _LABEL_E915_
	cp   $30
	jp   c, _LABEL_E867_
	cp   $3A
	jr   c, _LABEL_E915_
	cp   $41
	jp   c, _LABEL_E867_
	cp   $45
	jp   nc, _LABEL_E867_
_LABEL_E915_:
	ld   c, a
	ld   a, [_RAM_C281_]
	cp   $98
	jp   z, _LABEL_E867_
	ld   a, c
	call _LABEL_76A_
	ld   a, [_RAM_C281_]
	add  $08
	ld   [_RAM_C281_], a
	jp   _LABEL_E867_

_LABEL_E92D_:
	jp   gfx__clear_shadow_oam__275B

; Data from E930 to E959 (42 bytes)
db $02, $02, $FC, $00, $FD, $00, $FE, $00, $FF, $00, $50, $68, $38, $38, $50, $38
db $68, $38, $38, $48, $50, $48, $68, $48, $38, $58, $50, $58, $68, $58, $00, $00
db $00, $00, $00, $00, $00, $00, $38, $68, $68, $68

_LABEL_E95A_:
	xor  a
	ld   [_RAM_C23E_], a
	ldh  a, [rBGP]
	ldh  [rOBP0], a
	call _LABEL_2B_
	xor  a
	ld   [_RAM_C110_], a
	di
	ld   a, $04
	ldh  [rSTAT], a
	ld   a, $01
	ldh  [rIE], a
	ei
	call gfx__turn_off_screen_2827
	call _LABEL_B99_
	ld   de, _DATA_F40C_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00BC
	call _LABEL_1D2D_
	ld   bc, $0009
	call _LABEL_BC3_
_LABEL_E98E_:
	call serial_io__poll_keyboard__3278
	cp   $FF
	jr   z, _LABEL_E98E_
	or   a
	jp   z, _LABEL_200_
	cp   $23
	jr   nz, _LABEL_E9A1_
	ld   a, $0F
	jr   _LABEL_E9B3_

_LABEL_E9A1_:
	cp   $2A
	jr   nz, _LABEL_E9A9_
	ld   a, $0E
	jr   _LABEL_E9B3_

_LABEL_E9A9_:
	cp   $30
	jr   c, _LABEL_E98E_
	cp   $3A
	jr   nc, _LABEL_E98E_
	sub  $30
_LABEL_E9B3_:
	add  a
	push af
	ld   hl, $693A
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   c, [hl]
	inc  hl
	ld   b, [hl]
	ld   e, $21
	call _LABEL_1504_
	pop  af
	add  a
	ld   hl, $67AC
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	push de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	ld   a, $FF
	ld   [_RAM_C3D6_], a
	ld   [_RAM_C3D7_], a
	ld   bc, $0511
	call _LABEL_33FC_
	pop  de
	ld   a, $FF
	ld   bc, $0611
	call _LABEL_33FC_
	ld   b, $0A
_LABEL_E9F3_:
	rst  $18	; Call VSYNC__RST_18
	dec  b
	jr   nz, _LABEL_E9F3_
	call gfx__clear_shadow_oam__275B
	jr   _LABEL_E98E_

_LABEL_E9FC_:
	ld   hl, _RAM_C11B_
_LABEL_E9FF_:
	ldi  a, [hl]
	cp   $20
	jr   z, _LABEL_E9FF_
	or   a
	ret  z
	ld   de, $00BC
	ld   hl, (_TILEMAP0 + $21)
	rst  $20	; _LABEL_20_
	call _LABEL_EA1F_
	ld   de, $00BE
	ld   hl, (_TILEMAP0 + $21)
	rst  $20	; _LABEL_20_
_LABEL_EA17_:
	call serial_io__poll_keyboard__3278
	cp   $FF
	jr   z, _LABEL_EA17_
	ret

_LABEL_EA1F_:
	ld   hl, _RAM_C11B_
_LABEL_EA22_:
	ldi  a, [hl]
	cp   $20
	jr   z, _LABEL_EA22_
	cp   $2D
	jr   z, _LABEL_EA22_
	or   a
	jr   z, _LABEL_EA8B_
	cp   $23
	jr   nz, _LABEL_EA36_
	ld   a, $0F
	jr   _LABEL_EA56_

_LABEL_EA36_:
	cp   $2A
	jr   nz, _LABEL_EA3E_
	ld   a, $0E
	jr   _LABEL_EA56_

_LABEL_EA3E_:
	cp   $30
	jr   c, _LABEL_EA22_
	cp   $3A
	jr   c, _LABEL_EA50_
	cp   $41
	jr   c, _LABEL_EA22_
	cp   $45
	jr   nc, _LABEL_EA22_
	jr   _LABEL_EA54_

_LABEL_EA50_:
	sub  $30
	jr   _LABEL_EA56_

_LABEL_EA54_:
	sub  $37
_LABEL_EA56_:
	add  a
	add  a
	push hl
	ld   hl, _DATA_E7AC_
	add  l
	ld   l, a
	ld   a, h
	adc  $00
	ld   h, a
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	push de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	inc  hl
	ld   a, $FF
	ld   [_RAM_C3D6_], a
	ld   [_RAM_C3D7_], a
	ld   bc, $0511
	call _LABEL_33FC_
	pop  de
	ld   a, $FF
	ld   bc, $0611
	call _LABEL_33FC_
	ld   b, $0F
_LABEL_EA84_:
	rst  $18	; Call VSYNC__RST_18
	dec  b
	jr   nz, _LABEL_EA84_
	pop  hl
	jr   _LABEL_EA22_

_LABEL_EA8B_:
	ret

; 1st entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EA8C to EAAD (34 bytes)
_DATA_EA8C_:
db $04, $04, $01, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
db $00, $00, $01
ds 15, $00

; 2nd entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EAAE to EACF (34 bytes)
_DATA_EAAE_:
db $04, $04, $02, $00, $00, $00, $00, $00, $00, $00, $03, $00, $00, $00, $00, $00
db $00, $00, $04
ds 15, $00

; 3rd entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EAD0 to EAF1 (34 bytes)
_DATA_EAD0_:
db $04, $04, $05, $00, $00, $00, $00, $00, $00, $00, $06, $00, $00, $00, $00, $00
db $00, $00, $07
ds 15, $00

; 4th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EAF2 to EB13 (34 bytes)
_DATA_EAF2_:
db $04, $04, $08, $00, $09, $00, $00, $00, $00, $00, $0A, $00, $00, $00, $00, $00
db $00, $00, $0B
ds 15, $00

; 5th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EB14 to EB35 (34 bytes)
_DATA_EB14_:
db $04, $04, $0C, $00, $0D, $00, $00, $00, $00, $00, $0E, $00, $00, $00, $00, $00
db $00, $00, $0F
ds 15, $00

; 6th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EB36 to EB57 (34 bytes)
_DATA_EB36_:
db $04, $04, $00, $00, $10, $00, $00, $00, $00, $00, $11, $00, $12, $00, $00, $00
db $00, $00, $13
ds 15, $00

; 7th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EB58 to EB79 (34 bytes)
_DATA_EB58_:
db $04, $04, $00, $00, $14, $00, $00, $00, $00, $00, $15, $00, $16, $00, $00, $00
db $00, $00, $17
ds 15, $00

; 8th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EB7A to EB9B (34 bytes)
_DATA_EB7A_:
db $04, $04, $00, $00, $18, $00, $19, $00, $00, $00, $1A, $00, $1B, $00, $00, $00
db $00, $00, $1C
ds 15, $00

; 9th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EB9C to EBBD (34 bytes)
_DATA_EB9C_:
db $04, $04
ds 10, $00
db $1D, $00, $1E, $00, $00, $00, $1F, $00, $18, $C0, $00, $00, $00, $00, $1A, $C0
db $00, $00, $00, $00, $00, $00

; 10th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EBBE to EBDF (34 bytes)
_DATA_EBBE_:
db $04, $04
ds 10, $00
db $20, $00, $21, $00, $00, $00, $22, $00, $23, $00, $00, $00, $00, $00, $1A, $C0
db $00, $00, $00, $00, $00, $00

; 11th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EBE0 to EC01 (34 bytes)
_DATA_EBE0_:
db $04, $04
ds 10, $00
db $24, $00, $25, $00, $00, $00, $26, $00, $27, $00, $00, $00, $00, $00, $1A, $C0
db $00, $00, $00, $00, $00, $00

; 12th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EC02 to EC23 (34 bytes)
_DATA_EC02_:
db $04, $04
ds 12, $00
db $28, $00, $00, $00, $29, $00, $2A, $00, $2B, $00, $00, $00, $2C, $00, $00, $00
db $00, $00, $00, $00

; 13th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EC24 to EC45 (34 bytes)
_DATA_EC24_:
db $04, $04
ds 16, $00
db $2D, $00, $2E, $00, $2F, $00, $00, $00, $2C, $00, $00, $00, $00, $00, $00, $00

; 14th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EC46 to EC67 (34 bytes)
_DATA_EC46_:
db $04, $04
ds 16, $00
db $30, $00, $31, $00, $32, $00, $00, $00, $33, $00, $00, $00, $00, $00, $00, $00

; 15th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EC68 to EC89 (34 bytes)
_DATA_EC68_:
db $04, $04
ds 16, $00
db $34, $00, $35, $00, $36, $00, $00, $00, $37, $00, $00, $00, $00, $00, $00, $00

; 16th entry of Pointer Table from 147A (indexed by _RAM_C3A2_)
; Data from EC8A to EECB (578 bytes)
_DATA_EC8A_:
db $04, $04
ds 16, $00
db $38, $00, $38, $00, $38, $00, $00, $00, $38, $80, $38, $80, $38, $80, $00, $00
db $04, $04, $01, $00, $00, $00, $00, $00, $00, $00, $01
ds 23, $00
db $04, $04, $39, $00, $00, $00, $00, $00, $00, $00, $3A
ds 23, $00
db $04, $04, $3B, $00, $00, $00, $00, $00, $00, $00, $3C
ds 23, $00
db $04, $04, $3D, $00, $00, $00, $00, $00, $00, $00, $3E
ds 23, $00
db $04, $04, $3F, $00, $00, $00, $00, $00, $00, $00, $0F
ds 23, $00
db $04, $04, $12, $C0, $40, $00, $00, $00, $00, $00, $13
ds 23, $00
db $04, $04, $18, $00, $41, $00, $00, $00, $00, $00, $42
ds 23, $00
db $04, $04, $1A, $00, $43, $00, $00, $00, $00, $00, $44
ds 23, $00
db $04, $04, $00, $00, $45, $00, $00, $00, $00, $00, $46, $00, $18, $C0, $00, $00
db $00, $00, $1A, $C0
ds 14, $00
db $04, $04, $00, $00, $47, $00, $00, $00, $00, $00, $48, $00, $49, $00, $00, $00
db $00, $00, $1A, $C0
ds 14, $00
db $04, $04, $00, $00, $4A, $00, $00, $00, $00, $00, $26, $00, $4B, $00, $00, $00
db $00, $00, $1A, $C0
ds 14, $00
db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $29, $00, $4C, $00, $00, $00
db $00, $00, $2C
ds 15, $00
db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $4D, $00, $4E, $00, $00, $00
db $00, $00, $2C
ds 15, $00
db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $4F, $00, $50, $00, $00, $00
db $00, $00, $33
ds 15, $00
db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $51, $00, $52, $00, $00, $00
db $00, $00, $53
ds 15, $00
db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $38, $00, $38, $00, $00, $00
db $00, $00, $38, $80, $38, $80
ds 12, $00

; Data from EECC to EED3 (8 bytes)
_DATA_EECC_:
db $00, $00, $00, $00, $00, $00, $00, $00

; Data from EED4 to F40B (1336 bytes)
_DATA_EED4_:
db $00, $00, $00, $00, $00, $00, $00, $00, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
db $00, $00, $00, $00, $00, $00, $00, $00, $30, $30, $30, $30, $30, $30, $60, $60
db $00, $00, $00, $00, $00, $00, $00, $00, $60, $60, $60, $60, $60, $60, $60, $60
db $00, $00, $00, $00, $00, $00, $00, $00, $60, $60, $C0, $C0, $C0, $C0, $C0, $C0
ds 9, $00
db $06, $06, $06, $0C, $0C, $0C, $0C, $00, $00, $00, $00, $00, $00, $00, $00, $18
db $18, $18, $18, $18, $30, $30, $30, $00, $00, $00, $00, $00, $00, $00, $00, $30
db $60, $60, $60, $60, $C0, $C0, $C0
ds 9, $00
db $01, $01, $03, $03, $03, $06, $06
ds 9, $00
db $80, $80
ds 13, $00
db $06, $0C, $0C, $0C, $0C, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00
db $30, $30, $30, $60, $60, $60, $C0, $C0
ds 14, $00
db $01, $01
ds 10, $00
db $60, $60, $C0, $C0, $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $03, $03
db $03, $06, $06, $0C, $0C, $18, $00, $00, $00, $00, $00, $00, $00, $00, $18, $18
db $30, $30, $60, $60, $C0, $C0
ds 11, $00
db $0C, $18, $18, $30, $30
ds 11, $00
db $01, $01, $03, $06, $06, $00, $00, $00, $00, $00, $00, $00, $00, $60, $C0, $C0
db $80, $80
ds 11, $00
db $0C, $0C, $18, $30, $30, $60, $60, $C0
ds 12, $00
db $03, $06, $06, $0C
ds 13, $00
db $01, $01, $03, $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $30, $60, $C0
db $80, $80
ds 9, $00
db $06, $0C, $0C, $18, $30, $60, $60, $C0
ds 14, $00
db $01, $03
ds 14, $00
db $80
ds 16, $00
db $01, $00, $00, $00, $00, $00, $00, $00, $00, $06, $0C, $18, $18, $30, $60, $C0
db $80, $00, $00, $00, $00, $00, $00, $00, $00, $03, $06, $0C, $0C, $18, $30, $60
db $C0
ds 10, $00
db $01, $03, $0E, $1C, $30, $60, $00, $00, $00, $00, $00, $00, $00, $00, $40, $C0
db $80
ds 14, $00
db $01, $03, $0E, $1C, $30, $60, $C0
ds 12, $00
db $01, $07, $0E, $18
ds 9, $00
db $10, $70, $E0, $80
ds 13, $00
db $01, $07, $0E, $18, $70, $E0, $00, $00, $00, $00, $00, $00, $00, $00, $70, $E0
db $80
ds 19, $00
db $01, $07
ds 11, $00
db $08, $38, $F0, $C0
ds 12, $00
db $03, $07, $1C, $78, $E0, $00, $00, $00, $00, $00, $00, $00, $00, $1E, $38, $E0
db $C0
ds 18, $00
db $0C, $3C
ds 12, $00
db $03, $0F, $3C, $F0
ds 9, $00
db $07, $1F, $78, $E0, $80
ds 10, $00
db $F0, $C0
ds 14, $00
db $C0
ds 20, $00
db $07, $3F, $F8
ds 10, $00
db $01, $1F, $FE, $E0
ds 10, $00
db $06, $3E, $F8, $C0
ds 17, $00
db $01, $1F, $FE
ds 12, $00
db $1F, $FF, $E0
ds 11, $00
db $0E, $FE, $F0
ds 11, $00
db $E0
ds 21, $00
db $03, $FF
ds 14, $00
db $FF, $FF
ds 13, $00
db $3F, $FF, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $FC
ds 22, $00
db $FF, $00, $00, $00, $00, $00, $00, $00, $00, $30, $30, $30, $30, $60, $60, $60
db $60, $00, $00, $00, $00, $00, $00, $00, $00, $60, $60, $60, $60, $C0, $C0, $C0
db $C0, $00, $00, $00, $00, $00, $00, $00, $00, $18, $18, $18, $30, $30, $30, $30
db $30, $00, $00, $00, $00, $00, $00, $00, $00, $60, $60, $60, $60, $60, $C0, $C0
db $C0
ds 9, $00
db $06, $06, $0C, $0C, $0C, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $18
db $30, $30, $60, $60, $60, $C0, $C0
ds 9, $00
db $03, $03, $06, $06, $0C, $0C, $18
ds 10, $00
db $C0, $80, $80
ds 14, $00
db $60, $C0, $C0, $80
ds 9, $00
db $06, $06, $0C, $18, $30, $30, $60, $C0
ds 12, $00
db $30, $60, $C0, $80, $00, $00, $00, $00, $00, $00, $00, $00, $03, $06, $06, $0C
db $18, $30, $60, $C0
ds 13, $00
db $10, $30, $60
ds 9, $00
db $01, $07, $0E, $18, $30, $60, $C0
ds 14, $00
db $08, $38
ds 10, $00
db $03, $07, $0C, $38, $70, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $70, $C0
db $80
ds 20, $00
db $04, $00, $00, $00, $00, $00, $00, $00, $00, $1C, $78, $E0, $80
ds 13, $00
db $06, $1E, $78, $E0, $80
ds 14, $00
db $01, $07, $3E, $F8
ds 10, $00
db $06, $3E, $F8, $C0
ds 16, $00
db $1F, $FF
ds 12, $00
db $07, $FF, $F8
ds 15, $00
db $0F, $FF
ds 13, $00
db $0F, $FF, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $F0
ds 15, $00

; Data from F40C to F573 (360 bytes)
_DATA_F40C_:
db $5F
ds 18, $60
db $61, $65
ds 18, $67
db $66, $65
ds 18, $67
db $66, $65, $67, $67, $67, $5F
ds 10, $60
db $61, $79, $67, $67, $66, $65, $67, $67, $67, $65, $00, $0D, $0D, $0D, $0D, $0D
db $0D, $0D, $0D, $00, $66, $7B, $67, $67, $66, $65, $67, $67, $67, $65, $00, $D0
db $D1, $00, $D4, $D5, $00, $D8, $D9, $00, $66, $7B, $67, $67, $66, $65, $67, $67
db $67, $65, $00, $D2, $D3, $00, $D6, $D7, $00, $DA, $DB, $00, $66, $7B, $67, $67
db $66, $65, $67, $67, $67, $65, $00, $DC, $DD, $00, $E9, $EA, $00, $EB, $EC, $00
db $66, $7B, $67, $67, $66, $65, $67, $67, $67, $65, $00, $E7, $E8, $00, $DA, $DB
db $00, $ED, $DB, $00, $66, $7B, $67, $67, $66, $65, $67, $67, $67, $65, $00, $AF
db $B1, $00, $BB, $BC, $00, $EE, $EF, $00, $66, $7B, $67, $67, $66, $65, $67, $67
db $67, $65, $00, $B2, $B3, $00, $ED, $DB, $00, $ED, $DB, $00, $66, $7B, $67, $67
db $66, $65, $67, $67, $67, $65, $00, $BD, $F0, $00, $F3, $F4, $00, $F5, $F6, $00
db $66, $7B, $67, $67, $66, $65, $67, $67, $67, $65, $00, $F1, $F2, $00, $ED, $DB
db $00, $F7, $F8, $00, $66, $7B, $67, $67, $66, $65, $67, $67, $67, $65, $00, $0D
db $0D, $0D, $0D, $0D, $0D, $0D, $0D, $00, $66, $7B, $67, $67, $66, $65, $67, $67
db $67, $62
ds 10, $63
db $64, $7B, $67, $8B, $66, $65
ds 18, $67
db $66, $65
ds 18, $67
db $66, $62
ds 18, $63
db $64

_LABEL_F574_:
	ld   h, $00
	ld   l, e
	add  hl, hl
	ld   de, _DATA_1478_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   h, $C0
	ld   a, [_RAM_C107_]
	ld   l, a
	ld   a, [de]
	inc  de
	ld   [_RAM_C23D_], a
	dec  a
	add  a
	add  a
	add  a
	add  c
	ld   c, a
	ld   a, [de]
	inc  de
_LABEL_F592_:
	push af
	push bc
	ld   a, [_RAM_C23D_]
_LABEL_F597_:
	push af
	ld   a, b
	cp   $A0
	jr   c, _LABEL_F5A1_
	inc  de
	inc  de
	jr   _LABEL_F5C0_

_LABEL_F5A1_:
	ld   [hl], b
	inc  hl
	ld   [hl], c
	inc  hl
	ld   a, [de]
	or   a
	jr   nz, _LABEL_F5AF_
	inc  de
	inc  de
	dec  hl
	dec  hl
	jr   _LABEL_F5C0_

_LABEL_F5AF_:
	inc  de
	ldi  [hl], a
	ld   a, [de]
	and  $C0
	rrca
	push de
	ld   e, a
	ld   a, [_RAM_C23E_]
	or   e
	pop  de
	xor  $20
	inc  de
	ldi  [hl], a
_LABEL_F5C0_:
	ld   a, c
	sub  $08
	ld   c, a
	pop  af
	dec  a
	jr   nz, _LABEL_F597_
	pop  bc
	ld   a, b
	add  $08
	ld   b, a
	pop  af
	dec  a
	jr   nz, _LABEL_F592_
	ld   a, l
	ld   [_RAM_C107_], a
	ret

_LABEL_F5D6_:
	ld   a, b
	add  $18
	ld   b, a
	ld   h, $00
	ld   l, e
	add  hl, hl
	ld   de, $1478
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   h, $C0
	ld   a, [_RAM_C107_]
	ld   l, a
	ld   a, [de]
	inc  de
	ld   [_RAM_C23D_], a
	ld   a, [de]
	inc  de
_LABEL_F5F2_:
	push af
	push bc
	ld   a, [_RAM_C23D_]
_LABEL_F5F7_:
	push af
	ld   a, b
	cp   $A0
	jr   c, _LABEL_F601_
	inc  de
	inc  de
	jr   _LABEL_F620_

_LABEL_F601_:
	ld   [hl], b
	inc  hl
	ld   [hl], c
	inc  hl
	ld   a, [de]
	or   a
	jr   nz, _LABEL_F60F_
	inc  de
	inc  de
	dec  hl
	dec  hl
	jr   _LABEL_F620_

_LABEL_F60F_:
	inc  de
	ldi  [hl], a
	ld   a, [de]
	inc  de
	and  $C0
	rrca
	xor  $40
	push de
	ld   e, a
	ld   a, [_RAM_C23E_]
	or   e
	pop  de
	ldi  [hl], a
_LABEL_F620_:
	ld   a, c
	add  $08
	ld   c, a
	pop  af
	dec  a
	jr   nz, _LABEL_F5F7_
	pop  bc
	ld   a, b
	sub  $08
	ld   b, a
	pop  af
	dec  a
	jr   nz, _LABEL_F5F2_
	ld   a, l
	ld   [_RAM_C107_], a
	ret

_LABEL_F636_:
	ld   a, b
	add  $18
	ld   b, a
	ld   h, $00
	ld   l, e
	add  hl, hl
	ld   de, _DATA_1478_
	add  hl, de
	ld   e, [hl]
	inc  hl
	ld   d, [hl]
	ld   h, $C0
	ld   a, [_RAM_C107_]
	ld   l, a
	ld   a, [de]
	inc  de
	ld   [_RAM_C23D_], a
	dec  a
	add  a
	add  a
	add  a
	add  c
	ld   c, a
	ld   a, [de]
	inc  de
_LABEL_F658_:
	push af
	push bc
	ld   a, [_RAM_C23D_]
_LABEL_F65D_:
	push af
	ld   a, b
	cp   $A0
	jr   c, _LABEL_F667_
	inc  de
	inc  de
	jr   _LABEL_F688_

_LABEL_F667_:
	ld   [hl], b
	inc  hl
	ld   [hl], c
	inc  hl
	ld   a, [de]
	or   a
	jr   nz, _LABEL_F675_
	inc  de
	inc  de
	dec  hl
	dec  hl
	jr   _LABEL_F688_

_LABEL_F675_:
	inc  de
	ldi  [hl], a
	ld   a, [de]
	and  $C0
	rrca
	xor  $40
	push de
	ld   e, a
	ld   a, [_RAM_C23E_]
	or   e
	pop  de
	xor  $20
	inc  de
	ldi  [hl], a
_LABEL_F688_:
	ld   a, c
	sub  $08
	ld   c, a
	pop  af
	dec  a
	jr   nz, _LABEL_F65D_
	pop  bc
	ld   a, b
	sub  $08
	ld   b, a
	pop  af
	dec  a
	jr   nz, _LABEL_F658_
	ld   a, l
	ld   [_RAM_C107_], a
	ret

_LABEL_F69E_:
	call _LABEL_914_
	ld   a, $14
	ld   [vblank__dispatch_select__RAM_C27C], a
_LABEL_F6A6_:
	call _LABEL_914_
	rst  $18	; Call VSYNC__RST_18
	call gfx__clear_shadow_oam__275B
	call _LABEL_F6F7_
	ld   a, [_RAM_C3B0_]
	or   a
	jp   nz, _LABEL_200_
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	or   a
	jp   z, _LABEL_200_
	cp   $FF
	jr   z, _LABEL_F6A6_
	jp   _LABEL_1E6A_

; Data from F6C3 to F6F6 (52 bytes)
db $FA, $A4, $C3, $D6, $05, $30, $02, $C6, $3C, $EA, $A4, $C3, $FA, $9C, $C3, $3D
db $FE, $2F, $20, $1B, $FA, $9B, $C3, $FE, $30, $20, $0E, $3E, $32, $EA, $9B, $C3
db $3C, $EA, $9C, $C3, $CD, $93, $6F, $18, $BA, $3D, $EA, $9B, $C3, $3E, $39, $EA
db $9C, $C3, $18, $AF

_LABEL_F6F7_:
	xor  a
	ld   [_RAM_C23E_], a
	ld   a, [_RAM_C3A4_]
	call _LABEL_30B8_
	ld   a, [_RAM_C3A2_]
	call _LABEL_F712_
	ld   a, $10
	ld   [_RAM_C23E_], a
	ld   a, [_RAM_C3A1_]
	jp   _LABEL_F712_

_LABEL_F712_:
	ld   c, $58
	ld   b, $40
	inc  a
	cp   $11
	jr   c, _LABEL_F72F_
	cp   $1F
	jr   c, _LABEL_F733_
	cp   $2F
	jr   c, _LABEL_F73F_
	ld   e, a
	ld   a, $3E
	sub  e
	ld   e, a
	ld   a, c
	sub  $1E
	ld   c, a
	jp   _LABEL_F574_

_LABEL_F72F_:
	ld   e, a
	jp   _LABEL_1504_

_LABEL_F733_:
	ld   e, a
	ld   a, $20
	sub  e
	ld   e, a
	ld   a, b
	add  $10
	ld   b, a
	jp   _LABEL_F5D6_

_LABEL_F73F_:
	sub  $1E
	ld   e, a
	ld   a, c
	sub  $1E
	ld   c, a
	ld   a, b
	add  $10
	ld   b, a
	jp   _LABEL_F636_

_LABEL_F74D_:
	ld   a, $C8
	ld   [_RAM_C399_], a
	call gfx__turn_off_screen_2827
	ld   de, _DATA_1E9B_
	call _LABEL_3969_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00E1
	call _LABEL_1D2D_
	ld   bc, $0109
	call _LABEL_BC3_
	ld   de, $00E2
	call _LABEL_1D2D_
	ld   bc, $0609
	call _LABEL_BC3_
	ld   de, $00E3
	call _LABEL_1D2D_
	ld   bc, $0A09
	call _LABEL_BC3_
	ld   hl, _DATA_1D85_
	call _LABEL_2003_
	call _LABEL_206D_
	dec  a
	ld   [_RAM_C5F4_], a
	ret

_LABEL_F790_:
	call _LABEL_26C_
	call gfx__turn_on_screen_bg_obj__2540
	ld   de, $00BF
	ld   a, $09
	ld   hl, (_TILEMAP0 + $26)
	rst  $20	; _LABEL_20_
	ld   de, $00C0
	ld   hl, (_TILEMAP0 + $86)
	rst  $20	; _LABEL_20_
	ld   de, $00C1
	ld   hl, $98E6
	rst  $20	; _LABEL_20_
	ld   de, $00C2
	ld   hl, $9946
	rst  $20	; _LABEL_20_
	ld   de, $00C3
	ld   hl, $99A6
	rst  $20	; _LABEL_20_
	ld   bc, $09E0
	ld   e, $06
	call _LABEL_1CF6_
_LABEL_F7C3_:
	rst  $18	; Call VSYNC__RST_18
	ld   a, [_RAM_C240_]
	or   a
	jr   z, _LABEL_F7DB_
	dec  a
	ld   [_RAM_C240_], a
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   nz, _LABEL_F7FE_
	xor  a
	ld   [_RAM_C240_], a
	jr   _LABEL_F7FE_

_LABEL_F7DB_:
	ld   a, [_RAM_C3B0_]
	and  $C4
	jr   z, _LABEL_F7FE_
	ld   e, a
	ld   a, $19
	ld   [_RAM_C240_], a
	ld   a, e
	bit  6, a
	jr   nz, _LABEL_F814_
	bit  7, a
	jr   nz, _LABEL_F825_
	bit  2, a
	jr   z, _LABEL_F7FE_
_LABEL_F7F5_:
	ld   a, [_RAM_C3B0_]
	bit  2, a
	jr   nz, _LABEL_F7F5_
	jr   _LABEL_F836_

_LABEL_F7FE_:
	rst  $08	; SERIAL_POLL_KEYBOARD__RST_8
	cp   $FF
	jr   z, _LABEL_F7C3_
	or   a
	jp   z, _LABEL_200_
	cp   $0D
	jr   z, _LABEL_F836_
	cp   $12
	jr   z, _LABEL_F825_
	cp   $0F
	jp   nz, _LABEL_F7C3_
_LABEL_F814_:
	ld   a, [_RAM_C399_]
	cp   $06
	jr   nz, _LABEL_F81D_
	ld   a, $7E
_LABEL_F81D_:
	sub  $18
	ld   [_RAM_C399_], a
	jp   _LABEL_F7C3_

_LABEL_F825_:
	ld   a, [_RAM_C399_]
	cp   $66
	jr   nz, _LABEL_F82E_
	ld   a, $EE
_LABEL_F82E_:
	add  $18
	ld   [_RAM_C399_], a
	jp   _LABEL_F7C3_

_LABEL_F836_:
	ld   a, [_RAM_C399_]
	sub  $06
	ld   b, $00
_LABEL_F83D_:
	or   a
	jr   z, _LABEL_F845_
	inc  b
	sub  $18
	jr   _LABEL_F83D_

_LABEL_F845_:
	ld   a, b
	ld   [_RAM_C5F5_], a
	ret

; Data from F84A to FFFF (1974 bytes)
db $00, $50, $4F, $53, $54, $20, $4F, $46, $46, $49, $43, $45, $00, $50, $4F, $53
db $54, $41, $4D, $54, $00, $42, $55, $52, $45, $41, $55, $20, $44, $45, $20, $50
db $4F, $53, $54, $45, $00, $4F, $46, $49, $43, $49, $4E, $41, $20, $44, $45, $20
db $43, $4F, $52, $52, $45, $4F, $53, $00, $55, $46, $46, $49, $43, $49, $4F, $20
db $50, $4F, $53, $54, $41, $4C, $45, $00, $50, $4F, $53, $54, $20, $4F, $46, $46
db $49, $43, $45, $20, $42, $4F, $58, $00, $42, $52, $49, $45, $46, $4B, $41, $53
db $54, $45, $4E, $00, $42, $4F, $49, $54, $45, $20, $41, $55, $58, $20, $4C, $45
db $54, $54, $52, $45, $53, $00, $42, $55, $5A, $4F, $4E, $00, $42, $55, $43, $41
db $20, $50, $45, $52, $20, $4C, $45, $20, $4C, $45, $54, $54, $45, $52, $45, $00
db $53, $54, $41, $4D, $50, $00, $42, $52, $49, $45, $46, $4D, $41, $52, $4B, $45
db $00, $54, $49, $4D, $42, $52, $45, $00, $53, $45, $4C, $4C, $4F, $00, $46, $52
db $41, $4E, $43, $4F, $42, $4F, $4C, $4C, $4F, $00, $50, $4F, $53, $54, $41, $4C
db $20, $4F, $52, $44, $45, $52, $00, $50, $4F, $53, $54, $41, $4E, $57, $45, $49
db $53, $55, $4E, $47, $00, $4D, $41, $4E, $44, $41, $54, $20, $50, $4F, $53, $54
db $41, $4C, $00, $47, $49, $52, $4F, $20, $50, $4F, $53, $54, $41, $4C, $00, $56
db $41, $47, $4C, $49, $41, $20, $50, $4F, $53, $54, $41, $4C, $45, $00, $41, $44
db $44, $52, $45, $53, $53, $00, $41, $44, $52, $45, $53, $53, $45, $00, $41, $44
db $52, $45, $53, $53, $45, $00, $44, $49, $52, $45, $43, $43, $49, $4F, $4E, $00
db $49, $4E, $44, $49, $52, $49, $5A, $5A, $4F, $00, $50, $41, $43, $4B, $41, $47
db $45, $00, $50, $41, $4B, $45, $54, $00, $50, $41, $51, $55, $45, $54, $00, $50
db $41, $51, $55, $45, $54, $45, $00, $50, $41, $43, $43, $4F, $00, $4C, $45, $54
db $54, $45, $52, $00, $42, $52, $49, $45, $46, $00, $4C, $45, $54, $54, $52, $45
db $00, $43, $41, $52, $54, $41, $00, $4C, $45, $54, $54, $45, $52, $41, $00, $50
db $4F, $53, $54, $43, $41, $52, $44, $00, $50, $4F, $53, $54, $4B, $41, $52, $54
db $45, $00, $43, $41, $52, $54, $45, $20, $50, $4F, $53, $54, $41, $4C, $45, $00
db $54, $41, $52, $4A, $45, $54, $41, $20, $50, $4F, $53, $54, $41, $4C, $00, $43
db $41, $52, $54, $4F, $4C, $49, $4E, $41, $00, $50, $4F, $53, $54, $41, $47, $45
db $00, $50, $4F, $52, $54, $4F, $00, $41, $46, $46, $52, $41, $4E, $43, $48, $49
db $53, $53, $45, $4D, $45, $4E, $54, $00, $46, $52, $41, $4E, $51, $55, $45, $4F
db $00, $41, $46, $46, $52, $41, $4E, $43, $41, $54, $55, $52, $41, $00, $52, $45
db $47, $49, $53, $54, $45, $52, $45, $44, $00, $45, $49, $4E, $47, $45, $53, $43
db $48, $52, $49, $45, $42, $45, $4E, $00, $52, $45, $43, $4F, $4D, $4D, $41, $4E
db $44, $45, $00, $43, $45, $52, $54, $49, $46, $49, $43, $41, $44, $4F, $00, $52
db $41, $43, $43, $4F, $4D, $41, $4E, $44, $41, $54, $41, $00, $41, $49, $52, $4D
db $41, $49, $4C, $00, $4C, $55, $46, $54, $50, $4F, $53, $54, $00, $50, $41, $52
db $20, $41, $56, $49, $4F, $4E, $00, $43, $4F, $52, $52, $45, $4F, $20, $41, $45
db $52, $45, $4F, $00, $50, $4F, $53, $54, $41, $20, $41, $45, $52, $45, $41, $00
db $50, $55, $42, $4C, $49, $43, $20, $50, $48, $4F, $4E, $45, $20, $42, $4F, $4F
db $54, $48, $00, $4D, $37, $4E, $5A, $54, $45, $4C, $45, $46, $4F, $4E, $00, $54
db $45, $4C, $45, $50, $48, $4F, $4E, $45, $20, $41, $20, $50, $49, $45, $43, $45
db $53, $00, $54, $45, $4C, $45, $46, $4F, $4E, $4F, $20, $44, $45, $20, $4D, $4F
db $4E, $45, $44, $41, $00, $43, $41, $42, $49, $4E, $41, $20, $54, $45, $4C, $45
db $46, $4F, $4E, $49, $43, $41, $00, $43, $4F, $49, $4E, $20, $46, $4F, $52, $20
db $50, $41, $59, $50, $48, $4F, $4E, $45, $00, $54, $45, $4C, $45, $46, $4F, $4E
db $4D, $37, $4E, $5A, $45, $00, $4A, $45, $54, $4F, $4E, $20, $44, $45, $20, $54
db $45, $4C, $45, $50, $48, $4F, $4E, $45, $00, $46, $49, $43, $48, $41, $20, $54
db $45, $4C, $45, $46, $4F, $4E, $49, $43, $41, $00, $47, $45, $54, $54, $4F, $4E
db $45, $00, $53, $57, $49, $54, $43, $48, $42, $4F, $41, $52, $44, $00, $56, $45
db $52, $4D, $49, $54, $54, $4C, $55, $4E, $47, $53, $5A, $45, $4E, $54, $52, $41
db $4C, $45, $00, $53, $54, $41, $4E, $44, $41, $52, $44, $00, $43, $45, $4E, $54
db $52, $41, $4C, $20, $54, $45, $4C, $45, $46, $4F, $4E, $49, $43, $41, $00, $43
db $45, $4E, $54, $52, $41, $4C, $49, $4E, $4F, $00, $4D, $4F, $42, $49, $4C, $45
db $20, $50, $48, $4F, $4E, $45, $00, $41, $55, $54, $4F, $54, $45, $4C, $45, $46
db $4F, $4E, $00, $54, $45, $4C, $45, $50, $48, $4F, $4E, $45, $20, $4D, $4F, $42
db $49, $4C, $45, $00, $54, $45, $4C, $45, $46, $4F, $4E, $4F, $20, $4D, $4F, $56
db $49, $4C, $00, $54, $45, $4C, $45, $46, $4F, $4E, $4F, $20, $4D, $4F, $42, $49
db $4C, $45, $00, $42, $41, $4E, $4B, $20, $4D, $41, $4E, $41, $47, $45, $52, $00
db $42, $41, $4E, $4B, $44, $49, $52, $45, $4B, $54, $4F, $52, $00, $44, $49, $52
db $45, $43, $54, $45, $55, $52, $00, $47, $45, $52, $45, $4E, $54, $45, $00, $44
db $49, $52, $45, $54, $54, $4F, $52, $45, $00, $43, $41, $53, $48, $49, $45, $52
db $00, $4B, $41, $53, $53, $49, $45, $52, $45, $52, $00, $43, $41, $49, $53, $53
db $49, $45, $52, $00, $43, $41, $4A, $45, $52, $4F, $00, $43, $41, $53, $53, $49
db $45, $52, $45, $00, $53, $41, $46, $45, $54, $59, $2D, $44, $45, $50, $4F, $53
db $49, $54, $20, $42, $4F, $58, $00, $42, $41, $4E, $4B, $54, $52, $45, $53, $4F
db $52, $00, $43, $4F, $46, $46, $52, $45, $2D, $46, $4F, $52, $54, $00, $43, $41
db $4A, $41, $20, $44, $45, $20, $53, $45, $47, $55, $52, $49, $44, $41, $44, $00
db $43, $41, $53, $53, $41, $46, $4F, $52, $54, $45, $00, $43, $48, $45, $43, $4B
db $2F, $43, $48, $45, $51, $55, $45, $00, $53, $43, $48, $45, $43, $4B, $00, $43
db $48, $45, $51, $55, $45, $00, $43, $48, $45, $51, $55, $45, $00, $41, $53, $53
db $45, $47, $4E, $4F, $00, $54, $52, $41, $56, $45, $4C, $4C, $45, $52, $27, $53
db $20, $43, $48, $45, $51, $55, $45, $00, $52, $45, $49, $53, $45, $53, $43, $48
db $45, $43, $4B, $00, $43, $48, $45, $51, $55, $45, $20, $44, $45, $20, $56, $4F
db $59, $41, $47, $45, $00, $43, $48, $45, $51, $55, $45, $20, $44, $45, $20, $56
db $49, $41, $4A, $45, $52, $4F, $53, $00, $54, $52, $41, $56, $45, $4C, $45, $52
db $53, $20, $43, $48, $45, $51, $55, $45, $53, $00, $43, $48, $41, $52, $47, $45
db $20, $41, $43, $43, $4F, $55, $4E, $54, $00, $4B, $4F, $4E, $54, $4F, $00, $43
db $4F, $4D, $50, $54, $45, $00, $43, $55, $45, $4E, $54, $41, $00, $43, $4F, $4E
db $54, $4F, $00, $45, $58, $43, $48, $41, $4E, $47, $45, $20, $52, $41, $54, $45
db $00, $4B, $55, $52, $53, $00, $54, $41, $55, $58, $20, $44, $45, $20, $43, $48
db $41, $4E, $47, $45, $00, $43, $41, $4D, $42, $49, $4F, $00, $43, $41, $4D, $42
db $49, $4F, $00, $4D, $4F, $4E, $45, $59, $00, $47, $45, $4C, $44, $00, $41, $52
db $47, $45, $4E, $54, $00, $44, $49, $4E, $45, $52, $4F, $00, $44, $45, $4E, $41
db $52, $4F, $00, $42, $41, $4E, $4B, $20, $4E, $4F, $54, $45, $00, $42, $41, $4E
db $4B, $4E, $4F, $54, $45, $00, $42, $49, $4C, $4C, $45, $54, $20, $44, $45, $20
db $42, $41, $4E, $51, $55, $45, $00, $42, $49, $4C, $4C, $45, $54, $45, $00, $42
db $49, $47, $4C, $49, $45, $54, $54, $4F, $20, $44, $49, $20, $42, $41, $4E, $43
db $41, $00, $43, $4F, $49, $4E, $53, $00, $4D, $37, $4E, $5A, $45, $4E, $00, $50
db $49, $45, $43, $45, $53, $20, $44, $45, $20, $4D, $4F, $4E, $4E, $41, $49, $45
db $00, $4D, $4F, $4E, $45, $44, $41, $53, $00, $4D, $4F, $4E, $45, $54, $45, $00
db $43, $48, $41, $4E, $47, $45, $00, $4B, $4C, $45, $49, $4E, $47, $45, $4C, $44
db $00, $4D, $4F, $4E, $4E, $41, $49, $45, $00, $43, $41, $4D, $42, $49, $4F, $00
db $53, $50, $49, $43, $43, $49, $4F, $4C, $49, $00, $01, $00, $D0, $E5, $F6, $07
db $1C, $31, $45, $4E, $5F, $6A, $7B, $8C, $9A, $AB, $B4, $C8, $DC, $F0, $04, $18
db $2C, $3E, $52, $67, $76, $8A, $9E, $B2, $C6, $DA, $EE, $02, $16, $2A, $3E, $52
db $66, $7A, $8E, $A2, $B6, $CA, $DA, $EE, $FA, $08, $11, $1D, $2F, $42, $4F, $58
db $63, $77, $8B, $8B, $9E, $B3, $BB, $C4, $CA, $D1, $D8, $DF, $E6, $ED, $F7, $FF
db $08, $11, $13, $15, $17, $19, $2D, $3C, $45, $4C, $5B, $6F, $82, $91, $A5, $B1
db $C5, $D9, $ED, $01, $15, $29, $3D, $51, $65, $79, $8D, $A1, $B5, $C9, $DE, $F1
db $03, $17, $2B, $30, $3A, $4E, $62, $76, $89, $95, $A3, $B0, $C4, $D3, $E7, $F5
db $08, $18, $27, $3C, $4D, $57, $65, $72, $86, $95, $AA, $B8, $CB, $DB, $EA, $FF
db $10, $24, $39, $4B, $55, $5F, $66, $6F, $7A, $80, $95, $AA, $BF, $D4, $E9, $FE
db $13, $24, $2D, $36, $3C, $44, $4E, $53, $61, $6F, $83, $97, $AB, $BF, $D3, $E7
db $FB, $0F, $23, $37, $4B, $5F, $73, $86, $9A, $AE, $B3, $C6, $D9, $ED, $01, $0A
db $13, $26, $37, $4B, $5C, $6C, $7E, $92, $A5, $B9, $CC, $D4, $DC, $E5, $EE, $F7
db $01, $0B, $15, $1F, $29, $33, $3D, $47, $51, $5B, $65, $6F, $87, $9C, $B1, $C6
db $DB, $F0, $05, $19, $2D, $41, $55, $69, $7D, $91, $A5, $B9, $CE, $E3, $F7, $0B
db $1F, $2F, $40, $54, $D0, $E5, $FA, $0F, $24, $39, $4C, $55, $66, $73, $84, $95
db $A2, $B0, $BD, $D0, $E3, $F7, $0C, $20, $33, $47, $5A, $6F, $84, $98, $AC, $C0
db $D4, $E8, $FC, $10, $24, $38, $4C, $60, $74, $88, $9C, $B0, $C4, $D8, $EC, $00
db $0C, $1F, $28, $33, $44, $56, $63, $6D, $79, $89, $9E, $9E, $AD, $C0, $C6, $CE
db $D4, $DA, $DF, $E5, $EB, $F2, $FD, $05, $0F, $19, $1B, $1D, $1F, $21, $31, $3F
db $45, $4A, $56, $67, $7A, $8A, $9C, $A7, $BB, $CF, $E3, $F7, $0B, $1F, $33, $47
db $5B, $6F, $83, $97, $AB, $BF, $D4, $DE, $EC, $FC, $0D, $12, $1C, $30, $44, $58
db $6B, $79, $87, $97, $AB, $BD, $D0, $E5, $FA, $0B, $1A, $2E, $42, $50, $5E, $6E
db $82, $94, $A7, $BC, $D1, $E2, $F1, $05, $19, $2E, $44, $56, $60, $6A, $71, $7B
db $84, $8A, $9F, $B4, $C9, $DE, $F3, $08, $1D, $2E, $37, $40, $46, $4F, $57, $5C
db $69, $75, $89, $9D, $B1, $C5, $D9, $ED, $02, $17, $2B, $3F, $53, $67, $74, $81
db $90, $A4, $A9, $BB, $CD, $E1, $F5, $FA, $03, $15, $28, $3C, $4F, $62, $77, $8B
db $9E, $B2, $C5, $CC, $D3, $DB, $E3, $EC, $F6, $00, $0A, $14, $1E, $28, $32, $3C
db $46, $50, $5A, $64, $7C, $91, $A6, $BB, $D0, $E5, $FA, $0E, $22, $36, $4A, $5E
db $72, $86, $9A, $AE, $C3, $D8, $EC, $00, $14, $29, $39, $4D, $0A, $2F, $40, $2B
db $2B, $A3, $12, $82, $97, $27, $40, $05, $05, $85, $8D, $06, $83, $18, $80, $94
db $87, $41, $87, $1C, $84, $39, $87, $BF, $0F, $50, $41, $41, $02, $83, $06, $82
db $77, $0F, $50, $80, $B0, $80

SECTION "rom4", ROMX, BANK[$4]
; Data from 10000 to 13FFF (16384 bytes)
db $4E, $72, $2E, $20, $64, $27, $69, $6E, $64, $69, $72, $69, $7A, $7A, $6F, $3A
db $20, $20, $20, $20, $00, $4E, $72, $2E, $20, $61, $73, $73, $65, $67, $6E, $61
db $7A, $20, $20, $20, $3A, $00, $4E, $72, $2E, $20, $72, $65, $67, $69, $73, $74
db $72, $61, $7A, $20, $20, $3A, $00, $54, $72, $6F, $76, $20, $46, $61, $72, $65
db $20, $43, $61, $6E, $63, $20, $52, $65, $76, $69, $73, $00, $50, $72, $6F, $73
db $73, $20, $70, $72, $45, $63, $65, $64, $20, $20, $55, $73, $63, $69, $74, $61
db $00, $50, $52, $45, $4D, $45, $52, $45, $20, $51, $55, $41, $4C, $53, $20, $54
db $41, $53, $54, $4F, $00, $28, $63, $29, $20, $31, $39, $39, $32, $00, $4D, $6F
db $6E, $74, $61, $67, $75, $65, $2D, $57, $65, $73, $74, $6F, $6E, $2E, $00, $49
db $6E, $20, $4C, $69, $63, $65, $6E, $7A, $61, $00, $65, $73, $63, $6C, $75, $73
db $69, $76, $61, $6D, $65, $6E, $74, $65, $20, $61, $00, $20, $20, $46, $61, $62
db $74, $65, $6B, $2C, $20, $49, $6E, $63, $2E, $20, $20, $00, $56, $65, $72, $73
db $69, $6F, $6E, $65, $20, $35, $2E, $37, $34, $00, $53, $6F, $74, $74, $6F, $20
db $6C, $69, $63, $65, $6E, $7A, $61, $20, $64, $69, $00, $4E, $69, $6E, $74, $65
db $6E, $64, $6F, $00, $41, $7A, $69, $6F, $6E, $20, $63, $61, $74, $65, $6E, $61
db $20, $72, $69, $63, $65, $72, $63, $61, $41, $5A, $49, $4F, $4E, $20, $43, $41
db $54, $45, $4E, $41, $20, $52, $49, $43, $45, $52, $43, $41, $52, $49, $43, $45
db $52, $43, $41, $20, $46, $49, $4E, $4F, $20, $54, $45, $52, $4D, $49, $4E, $20
db $50, $52, $45, $4D, $45, $52, $45, $20, $51, $55, $41, $4C, $53, $20, $54, $41
db $53, $54, $4F, $20, $20, $20, $20, $52, $49, $43, $45, $52, $43, $41, $20, $4C
db $49, $4E, $47, $55, $41, $20, $20, $20, $52, $69, $63, $65, $72, $63, $61, $20
db $66, $69, $6E, $6F, $20, $61, $20, $66, $69, $6E, $65, $00, $64, $61, $74, $6F
db $2E, $4E, $6F, $6E, $20, $74, $72, $61, $76, $61, $74, $6F, $3F, $00, $50, $72
db $65, $6D, $65, $72, $65, $20, $51, $75, $61, $6C, $73, $20, $54, $61, $73, $74
db $6F, $00, $20, $50, $72, $6F, $73, $73, $69, $6D, $6F, $20, $20, $55, $73, $63
db $69, $74, $61, $20, $20, $20, $00, $50, $52, $4F, $53, $53, $49, $4D, $4F, $20
db $55, $53, $43, $49, $54, $41, $20, $20, $20, $4D, $49, $4E, $49, $54, $52, $41
db $44, $55, $54, $54, $4F, $52, $45, $20, $20, $20, $20, $54, $72, $6F, $76, $61
db $72, $65, $20, $20, $6C, $61, $20, $70, $61, $72, $6F, $6C, $61, $20, $20, $56
db $69, $73, $75, $61, $6C, $69, $7A, $7A, $20, $49, $6E, $74, $65, $73, $74, $61
db $7A, $20, $20, $20, $20, $20, $20, $20, $20, $55, $73, $63, $69, $74, $61, $20
db $20, $20, $20, $20, $20, $20, $20, $46, $55, $4E, $5A, $49, $4F, $4E, $49, $20
db $44, $45, $4C, $20, $4D, $4F, $4E, $44, $4F, $20, $20, $20, $20, $4D, $69, $6E
db $69, $74, $72, $61, $64, $75, $74, $74, $6F, $72, $65, $20, $20, $20, $20, $20
db $4D, $61, $70, $70, $61, $20, $20, $64, $65, $6C, $20, $4D, $6F, $6E, $64, $6F
db $20, $20, $20, $20, $20, $46, $55, $4E, $5A, $49, $4F, $4E, $49, $20, $20, $44
db $41, $54, $41, $20, $20, $20, $20, $20, $20, $20, $41, $73, $73, $65, $67, $6E
db $61, $7A, $69, $6F, $6E, $69
ds 9, $20
db $43, $61, $6C, $65, $6E, $64, $61, $72, $69, $6F, $20, $20, $20, $20, $20, $20
db $20, $4F, $50, $5A, $49, $4F, $4E, $49, $20, $54, $45, $4C, $45, $46, $4F, $4E
db $4F, $20, $20, $20, $4E, $75, $6D, $65, $72, $6F, $20, $43, $6F, $6D, $70, $6F
db $6E, $69, $62, $69, $6C, $65, $20, $20, $20, $54, $61, $73, $74, $69, $65, $72
db $61, $20, $61, $20, $54, $6F, $63, $63, $6F, $20, $20, $20, $20, $20, $20, $43
db $4F, $4E, $56, $45, $52, $53, $49, $4F, $4E, $45, $20, $20, $20, $20, $20, $20
db $41, $20, $4D, $69, $73, $75, $72, $65, $20, $20, $4D, $65, $74, $72, $69, $63
db $68, $65, $20, $20, $44, $61, $20, $4D, $69, $73, $75, $72, $65, $20, $4D, $65
db $74, $72, $69, $63, $68, $65, $20, $20, $4F, $50, $5A, $49, $4F, $4E, $49, $20
db $20, $52, $45, $47, $49, $53, $54, $52, $41, $5A, $20, $20, $20, $20, $20, $20
db $20, $44, $61, $74, $61, $62, $61, $73, $65, $20, $20, $20, $20, $20, $20, $49
db $6E, $64, $69, $72, $69, $7A, $7A, $61, $72, $69, $6F, $20, $20, $20, $20, $44
db $61, $74, $61, $20, $20, $20, $2F, $20, $20, $2F, $00, $41, $73, $73, $2E, $20
db $54, $65, $6D, $70, $6F, $3F, $53, $4E, $00, $54, $65, $6D, $70, $6F, $20, $20
db $3A, $00, $4D, $75, $73, $69, $63, $61, $6C, $65, $3F, $53, $4E, $00, $50, $72
db $65, $6D, $65, $72, $65, $20, $31, $20, $32, $20, $33, $20, $6F, $20, $34, $00
db $31, $20, $41, $6C, $6C, $61, $72, $6D, $65, $20, $61, $63, $75, $73, $74, $69
db $63, $6F, $00, $32, $20, $43, $6F, $6D, $70, $6C, $65, $61, $6E, $6E, $6F, $00
db $33, $20, $4E, $61, $74, $61, $6C, $65, $00, $34, $20, $50, $72, $69, $6F, $72
db $69, $74, $61, $00, $43, $6F, $6E, $74, $6F, $20, $61, $20, $52, $6F, $76, $65
db $73, $63, $69, $61, $3F, $53, $4E, $00, $4E, $75, $6D, $65, $72, $6F, $20, $67
db $69, $6F, $72, $6E, $69, $3F, $28, $31, $2D, $37, $29, $00, $50, $65, $72, $20
db $63, $61, $6E, $63, $20, $41, $73, $73, $65, $67, $6E, $3F, $53, $4E, $00, $50
db $72, $6F, $73, $73, $20, $70, $52, $65, $63, $65, $64, $20, $20, $55, $73, $63
db $69, $74, $61, $00, $47, $65, $6E, $6E, $61, $69, $6F, $00, $46, $65, $62, $62
db $72, $61, $69, $6F, $00, $4D, $61, $72, $7A, $6F, $00, $41, $70, $72, $69, $6C
db $65, $00, $4D, $61, $67, $67, $69, $6F, $00, $47, $69, $75, $67, $6E, $6F, $00
db $4C, $75, $67, $6C, $69, $6F, $00, $41, $67, $6F, $73, $74, $6F, $00, $53, $65
db $74, $74, $65, $6D, $62, $72, $65, $00, $4F, $74, $74, $6F, $62, $72, $65, $00
db $4E, $6F, $76, $65, $6D, $62, $72, $65, $00, $44, $69, $63, $65, $6D, $62, $72
db $65, $00, $73, $74, $6E, $64, $72, $64, $74, $68, $4E, $6F, $20, $63, $6F, $6E
db $74, $6F, $20, $61, $20, $72, $6F, $76, $65, $73, $63, $69, $61, $00, $43, $6F
db $6E, $74, $6F, $20, $61, $20, $72, $6F, $76, $65, $73, $3A, $00, $31, $20, $67
db $69, $6F, $72, $6E, $6F, $00, $67, $69, $6F, $72, $6E, $69, $00, $4E, $65, $73
db $73, $75, $6E, $20, $41, $6C, $6C, $61, $72, $6D, $65, $00, $41, $6C, $6C, $61
db $72, $20, $63, $6F, $6E, $20, $53, $65, $67, $6E, $20, $41, $63, $75, $73, $00
db $41, $6C, $6C, $61, $72, $6D, $65, $20, $43, $6F, $6D, $70, $6C, $65, $61, $6E
db $6E, $6F, $00, $41, $6C, $6C, $61, $72, $6D, $65, $20, $4E, $61, $74, $61, $6C
db $65, $00, $41, $6C, $6C, $61, $72, $6D, $65, $20, $64, $69, $20, $50, $72, $69
db $6F, $72, $69, $74, $61, $00, $20, $20, $20, $45, $52, $52, $4F, $52, $45, $20
db $20, $20, $20, $20, $20, $20, $20, $41, $75, $74, $6F, $6D, $6F, $62, $69, $6C
db $65, $20, $20, $20, $20, $20, $20, $20, $20, $42, $61, $6E, $63, $68, $65, $2F
db $46, $69, $6E, $61, $6E, $7A, $61, $20, $20, $20, $20, $20, $42, $65, $6C, $6C
db $65, $7A, $7A, $61, $2F, $53, $61, $6C, $75, $74, $65, $20, $20, $20, $20, $20
db $20, $43, $6F, $6D, $75, $6E, $69, $63, $61, $7A, $69, $6F, $6E, $65
ds 9, $20
db $44, $61, $74, $65, $2F, $54, $65, $6D, $70, $6F
ds 10, $20
db $53, $70, $65, $74, $74, $61, $63, $6F, $6C, $6F, $20, $20, $20, $20, $20, $47
db $65, $6E, $65, $72, $61, $6C, $65, $2F, $43, $6F, $6E, $76, $65, $6E, $65, $76
db $6F, $6C, $69, $20, $20, $20, $20, $20, $20, $41, $6C, $62, $65, $72, $67, $6F
ds 9, $20
db $53, $61, $6E, $69, $74, $61, $2F, $45, $6D, $65, $72, $67, $65, $6E, $7A, $61
db $20, $20, $20, $20, $52, $69, $73, $74, $6F, $72, $61, $6E, $74, $69, $2F, $43
db $69, $62, $6F, $20, $20, $20, $20, $20, $53, $70, $65, $73, $65, $2F, $50, $65
db $72, $73, $6F, $6E, $61, $6C, $65, $20, $20, $20, $20, $20, $56, $69, $73, $69
db $74, $61, $20, $54, $75, $72, $69, $73, $74, $69, $63, $61
ds 9, $20
db $53, $70, $6F, $72, $74
ds 14, $20
db $56, $69, $61, $67, $67, $69, $6F, $20, $20, $20, $20, $20, $20, $20, $53, $55
db $43, $43, $45, $53, $53, $20, $50, $52, $45, $43, $45, $44, $20, $53, $45, $4C
db $45, $5A, $00, $56, $69, $73, $75, $61, $6C, $69, $7A, $7A, $20, $4F, $72, $6F
db $6C, $6F, $67, $69, $6F, $00, $50, $65, $72, $20, $73, $65, $74, $74, $61, $72
db $65, $20, $74, $65, $6D, $70, $6F, $00, $50, $65, $72, $20, $73, $65, $74, $74
db $61, $72, $65, $20, $61, $6C, $6C, $61, $72, $6D, $65, $00, $50, $65, $72, $20
db $63, $61, $6E, $63, $65, $6C, $6C, $20, $61, $6C, $6C, $61, $72, $6D, $65, $00
db $3A, $20, $20, $3A, $00, $41, $6C, $6C, $61, $72, $6D, $65, $20, $3A, $00, $20
db $50, $65, $72, $20, $76, $69, $73, $75, $61, $6C, $69, $7A, $7A, $20, $64, $61
db $74, $61, $20, $20, $20, $50, $65, $72, $20, $73, $65, $74, $74, $61, $72, $65
db $20, $64, $61, $74, $61, $20, $20, $20, $49, $4D, $50, $4F, $53, $54, $2E, $20
db $20, $41, $4D, $4D, $4F, $4E, $54, $41, $52, $45, $20, $20, $50, $52, $45, $4D
db $45, $52, $45, $20, $55, $4E, $20, $54, $41, $53, $54, $4F, $20, $00, $49, $6E
db $63, $68, $65, $73, $20, $61, $20, $43, $6D, $00, $50, $69, $65, $64, $69, $20
db $61, $20, $4D, $65, $74, $72, $69, $00, $59, $61, $72, $64, $20, $61, $20, $4D
db $65, $74, $72, $69, $00, $4D, $69, $67, $6C, $69, $61, $20, $61, $20, $43, $68
db $69, $6C, $6F, $6D, $65, $74, $72, $69, $00, $41, $63, $72, $69, $20, $61, $64
db $20, $45, $74, $74, $61, $72, $69, $00, $4F, $6E, $63, $65, $20, $66, $6C, $75
db $69, $64, $65, $20, $61, $20, $4C, $69, $74, $72, $69, $00, $51, $75, $61, $72
db $74, $20, $61, $20, $4C, $69, $74, $72, $69, $00, $47, $61, $6C, $6C, $6F, $6E
db $69, $20, $55, $53, $20, $61, $20, $4C, $69, $74, $72, $69, $00, $47, $61, $6C
db $6C, $6F, $6E, $69, $20, $61, $20, $4C, $69, $74, $72, $69, $00, $4F, $6E, $63
db $65, $20, $61, $64, $20, $47, $72, $61, $6D, $6D, $69, $00, $4C, $69, $62, $62
db $72, $65, $20, $61, $20, $43, $68, $69, $6C, $6F, $67, $72, $61, $6D, $6D, $69
db $00, $54, $6F, $6E, $20, $61, $20, $54, $6F, $6E, $6E, $65, $6C, $6C, $61, $74
db $65, $00, $43, $6D, $20, $61, $20, $49, $6E, $63, $68, $00, $4D, $65, $74, $72
db $69, $20, $61, $20, $50, $69, $65, $64, $69, $00, $4D, $65, $74, $72, $69, $20
db $61, $20, $59, $61, $72, $64, $00, $43, $68, $69, $6C, $6F, $6D, $65, $74, $72
db $69, $20, $61, $20, $4D, $69, $67, $6C, $69, $61, $00, $45, $74, $74, $61, $72
db $69, $20, $61, $64, $20, $41, $63, $72, $69, $00, $4C, $69, $74, $72, $69, $20
db $61, $64, $20, $4F, $6E, $63, $65, $20, $46, $6C, $75, $69, $64, $65, $00, $4C
db $69, $74, $72, $69, $20, $61, $20, $51, $75, $61, $72, $74, $00, $4C, $69, $74
db $72, $69, $20, $61, $20, $47, $61, $6C, $6C, $6F, $6E, $69, $20, $55, $53, $00
db $4C, $69, $74, $72, $69, $20, $61, $20, $47, $61, $6C, $6C, $6F, $6E, $69, $00
db $47, $72, $61, $6D, $6D, $69, $20, $61, $64, $20, $4F, $6E, $63, $65, $00, $43
db $68, $69, $6C, $6F, $67, $72, $61, $6D, $6D, $69, $20, $61, $20, $4C, $69, $62
db $62, $72, $65, $00, $54, $6F, $6E, $6E, $65, $6C, $6C, $61, $74, $65, $20, $61
db $20, $54, $6F, $6E, $00, $43, $6F, $72, $72, $69, $73, $70, $20, $6E, $6F, $6E
db $20, $74, $72, $6F, $76, $61, $74, $6F, $00, $51, $75, $61, $6C, $73, $20, $74
db $61, $73, $74, $6F, $20, $70, $65, $72, $20, $63, $6F, $6E, $74, $00, $84, $98
db $4D, $61, $72, $63, $68, $69, $20, $54, $65, $64, $65, $73, $63, $68, $69, $00
db $C6, $98, $44, $6F, $6C, $6C, $61, $72, $69, $00, $07, $99, $46, $72, $61, $6E
db $63, $68, $69, $00, $48, $99, $4C, $69, $72, $65, $00, $86, $99, $50, $65, $73
db $65, $74, $61, $00, $C7, $99, $53, $74, $65, $72, $6C, $69, $6E, $65, $00, $08
db $9A, $59, $65, $6E, $00, $12, $20, $20, $4D, $61, $72, $63, $68, $69, $20, $20
db $54, $65, $64, $65, $73, $63, $68, $69, $20, $20, $09, $20, $20, $20, $20, $20
db $20, $44, $6F, $6C, $6C, $61, $72, $69, $20, $20, $20, $20, $20, $20, $20, $09
db $20, $20, $20, $20, $20, $20, $46, $72, $61, $6E, $63, $68, $69, $20, $20, $20
db $20, $20, $20, $20, $06, $20, $20, $20, $20, $20, $20, $20, $20, $4C, $69, $72
db $65, $20, $20, $20, $20, $20, $20, $20, $20, $08, $20, $20, $20, $20, $20, $20
db $20, $50, $65, $73, $65, $74, $61, $20, $20, $20, $20, $20, $20, $20, $0A, $20
db $20, $20, $20, $20, $20, $53, $74, $65, $72, $6C, $69, $6E, $65, $20, $20, $20
db $20, $20, $20, $05, $20, $20, $20, $20, $20, $20, $20, $20, $59, $65, $6E
ds 9, $20
db $04, $4D, $61, $72, $63, $68, $69, $20, $54, $65, $64, $65, $73, $63, $68, $69
db $00, $06, $44, $6F, $6C, $6C, $61, $72, $69, $00, $07, $46, $72, $61, $6E, $63
db $68, $69, $00, $08, $4C, $69, $72, $65, $00, $06, $50, $65, $73, $65, $74, $61
db $00, $07, $53, $74, $65, $72, $6C, $69, $6E, $65, $00, $08, $59, $65, $6E, $00
db $43, $4F, $4E, $56, $45, $52, $54, $49, $52, $45, $20, $44, $41, $00, $43, $4F
db $4E, $56, $45, $52, $54, $49, $52, $45, $20, $41, $20, $00, $20, $49, $4D, $50
db $4F, $53, $54, $2E, $20, $20, $41, $4D, $4D, $4F, $4E, $54, $41, $52, $45, $20
db $20, $20, $20, $49, $4D, $50, $4F, $53, $54, $41, $52, $45, $20, $44, $41, $54
db $41, $20, $20, $20, $20, $41, $4D, $4D, $4F, $4E, $54, $41, $52, $45, $20, $20
db $44, $41, $54, $4F, $20, $49, $4E, $20, $20, $20, $20, $20, $4D, $45, $4E, $55
db $20, $43, $4F, $4D, $41, $4E, $44, $49, $20, $20, $20, $20, $20, $50, $45, $52
db $20, $20, $43, $41, $4E, $43, $20, $4F, $47, $4E, $49, $20, $52, $45, $47, $20
db $20, $50, $45, $52, $20, $53, $45, $54, $54, $41, $52, $45, $20, $41, $20, $48
db $4F, $4D, $45, $20, $50, $52, $45, $4D, $20, $53, $20, $41, $20, $43, $4F, $4E
db $46, $45, $52, $4D, $41, $20, $00, $00, $51, $55, $41, $4C, $53, $20, $54, $41
db $53, $54, $4F, $20, $41, $4E, $4E, $55, $4C, $4C, $20, $00, $20, $50, $45, $52
db $20, $42, $49, $4C, $41, $4E, $43, $49, $4F, $2F, $53, $41, $4C, $44, $4F, $20
db $20, $42, $49, $4C, $41, $4E, $43, $49, $4F, $20, $20, $43, $4F, $52, $52, $45
db $4E, $54, $45, $20, $20, $56, $49, $53, $55, $41, $4C, $49, $5A, $5A, $20, $20
db $52, $45, $47, $49, $53, $54, $52, $20, $20, $49, $4D, $50, $4F, $53, $54, $41
db $52, $45, $20, $20, $52, $45, $47, $49, $53, $54, $52, $20, $20, $4E, $45, $53
db $53, $55, $4E, $41, $20, $20, $52, $45, $47, $49, $53, $54, $52, $41, $5A
ds 19, $20
db $00, $20, $56, $49, $53, $55, $41, $4C, $49, $5A, $5A, $20, $20, $52, $45, $47
db $49, $53, $54, $52, $20, $20, $20, $20, $44, $49, $47, $49, $54, $41, $52, $45
db $20, $44, $41, $54, $41, $20, $20, $20, $20, $2F, $20, $20, $2F, $00, $49, $4D
db $50, $4F, $53, $54, $41, $52, $45, $20, $41, $4D, $4F, $4E, $54, $41, $52, $45
db $00, $20, $50, $45, $52, $20, $41, $43, $43, $52, $45, $44, $2F, $41, $44, $44
db $45, $42, $20, $00, $20, $20, $20, $20, $20, $41, $43, $43, $52, $45, $44, $49
db $54, $4F
ds 12, $20
db $41, $44, $44, $45, $42, $49, $54, $4F, $20, $20, $20, $20, $20, $20, $41, $44
db $44, $45, $42, $49, $54, $4F, $00, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $00
db $20, $49, $4D, $50, $4F, $53, $54, $41, $52, $45, $20, $20, $44, $45, $53, $43
db $52, $20, $00, $8C, $8C, $50, $72, $6F, $73, $73, $8C, $70, $52, $65, $63, $8C
db $55, $73, $63, $00, $20, $20, $52, $65, $67, $69, $73, $74, $72, $20, $4E, $72
db $20, $20, $20, $20, $78, $78, $20, $20, $4E, $6F, $6D, $65, $20, $65, $20, $49
db $6E, $64, $69, $72, $69, $7A, $7A, $6F, $00, $4E, $75, $6D, $65, $72, $6F, $20
db $54, $65, $6C, $65, $66, $6F, $6E, $6F, $00, $49, $6D, $70, $6F, $73, $74, $20
db $6E, $72, $20, $64, $61, $20, $66, $61, $72, $65, $00, $20, $44, $69, $67, $69
db $74, $61, $72, $65, $20, $69, $6C, $20, $6E, $75, $6D, $65, $72, $6F, $20, $43
db $6F, $6D, $70, $6F, $73, $20, $6E, $72, $20, $61, $7A, $69, $6F, $6E, $61, $74
db $61, $00, $20, $45, $53, $43, $41, $50, $45, $20, $20, $50, $45, $52, $20, $55
db $53, $43, $49, $52, $45, $20, $20, $50, $52, $45, $4D, $20, $51, $55, $41, $4C
db $53, $20, $54, $41, $53, $54, $4F, $20, $00, $49, $6E, $67, $6C, $65, $73, $65
db $00, $54, $65, $64, $65, $73, $63, $6F, $00, $46, $72, $61, $6E, $63, $65, $73
db $65, $00, $53, $70, $61, $67, $6E, $6F, $6C, $6F, $00, $49, $74, $61, $6C, $69
db $61, $6E, $6F, $00, $20, $47, $45, $4E, $4E, $41, $49, $4F, $20, $1F, $46, $45
db $42, $42, $52, $41, $49, $4F, $20, $1C, $20, $20, $4D, $41, $52, $5A, $4F, $20
db $20, $1F, $20, $41, $50, $52, $49, $4C, $45, $20, $20, $1E, $20, $4D, $41, $47
db $47, $49, $4F, $20, $20, $1F, $20, $47, $49, $55, $47, $4E, $4F, $20, $20, $1E
db $20, $4C, $55, $47, $4C, $49, $4F, $20, $20, $1F, $20, $41, $47, $4F, $53, $54
db $4F, $20, $20, $1F, $53, $45, $54, $54, $45, $4D, $42, $52, $45, $1E, $20, $4F
db $54, $54, $4F, $42, $52, $45, $20, $1F, $20, $4E, $4F, $56, $45, $4D, $42, $52
db $45, $1E, $20, $44, $49, $43, $45, $4D, $42, $52, $45, $1F, $4C, $55, $4E, $4D
db $41, $52, $4D, $45, $52, $47, $49, $4F, $56, $45, $4E, $53, $41, $42, $44, $4F
db $4D, $4C, $55, $4E, $42, $3D, $50, $72, $6F, $73, $73, $69, $6D, $6F, $20, $20
db $41, $3D, $55, $73, $63, $69, $74, $61, $00, $20, $53, $65, $6C, $65, $63, $74
db $3D, $50, $72, $65, $63, $65, $64, $65, $6E, $74, $65, $20, $20, $00, $46, $61
db $72, $65, $2E, $20, $20, $43, $61, $6E, $63, $2E, $20, $20, $52, $65, $76, $69
db $73, $2E, $00, $50, $52, $45, $4D, $45, $52, $45, $20, $53, $20, $41, $20, $43
db $4F, $4E, $46, $45, $52, $4D, $41, $00, $41, $4C, $54, $52, $4F, $20, $54, $41
db $53, $54, $4F, $20, $46, $41, $4C, $4C, $49, $53, $43, $45, $00, $2A, $43, $4F
db $4E, $54, $52, $4F, $4C, $4C, $2E, $41, $50, $50, $55, $4E, $54, $41, $4D, $2E
db $2A, $00, $20, $20, $53, $43, $45, $47, $4C, $49, $45, $52, $45, $20, $4C, $49
db $4E, $47, $55, $41, $20, $20, $20, $20, $53, $43, $45, $4C, $54, $41, $20, $20
db $41, $50, $50, $4F, $47, $47, $49, $4F, $20, $20, $20, $20, $43, $41, $52, $49
db $43, $4F, $20, $20, $47, $49, $55, $20, $41, $20, $50, $43, $20, $20, $20, $20
db $43, $41, $52, $49, $43, $4F, $20, $20, $53, $55, $20, $44, $41, $20, $50, $43
db $20, $20, $20, $20, $20, $4D, $45, $4E, $55, $20, $43, $4F, $4E, $54, $52, $4F
db $4C, $4C, $4F, $20, $20, $20, $20, $20, $4C, $49, $42, $52, $4F, $20, $20, $49
db $4E, $44, $49, $52, $49, $5A, $5A, $49, $20, $20, $20, $20, $20, $20, $41, $50
db $50, $55, $4E, $54, $41, $4D, $45, $4E, $54, $49, $20, $20, $20, $20, $20, $20
db $20, $20, $43, $41, $4C, $43, $4F, $4C, $45, $52, $52, $49, $43, $41, $20, $20
db $20, $20, $20, $20, $20, $20, $42, $41, $53, $45, $20, $44, $49, $20, $44, $41
db $54, $49, $20, $20, $20, $20, $43, $61, $72, $63, $61, $72, $65, $20, $61, $6C
db $6C, $61, $20, $66, $69, $6E, $65, $20, $64, $69, $00, $44, $61, $74, $69, $20
db $70, $72, $6D, $2E, $71, $75, $61, $6C, $73, $2E, $74, $61, $73, $74, $6F, $00
db $20, $20, $20, $53, $43, $45, $4C, $54, $45, $20, $52, $49, $43, $45, $52, $43
db $41, $20, $20, $20, $20, $20, $52, $49, $43, $45, $52, $43, $41, $20, $20, $47
db $4C, $4F, $42, $41, $4C, $45, $20, $20, $20, $52, $49, $43, $45, $52, $43, $41
db $20, $20, $53, $50, $45, $43, $49, $46, $49, $43, $41, $20, $4F, $72, $61, $2F
db $44, $61, $74, $61, $20, $45, $72, $72, $61, $74, $61, $00, $42, $61, $74, $74
db $65, $72, $69, $65, $20, $44, $65, $62, $6F, $6C, $74, $3F, $00, $20, $20, $20
db $20, $43, $49, $52, $43, $4F, $4C, $41, $5A, $49, $4F, $4E, $45, $20, $20, $20
db $20, $20, $20, $4C, $49, $42, $52, $45, $54, $54, $4F, $20, $41, $53, $53, $45
db $47, $4E, $49, $20, $20, $00, $00, $00, $00, $00, $00, $00, $4D, $4F, $49, $53
db $54, $55, $52, $49, $5A, $45, $52, $00, $46, $45, $55, $43, $48, $54, $49, $47
db $4B, $45, $49, $54, $53, $43, $52, $45, $4D, $45, $00, $43, $52, $45, $4D, $45
db $20, $48, $59, $44, $52, $41, $54, $41, $4E, $54, $45, $00, $43, $52, $45, $4D
db $41, $20, $48, $49, $44, $52, $41, $54, $41, $4E, $54, $45, $00, $43, $52, $45
db $4D, $41, $20, $49, $44, $52, $41, $54, $41, $4E, $54, $45, $00, $4C, $49, $50
db $53, $54, $49, $43, $4B, $00, $4C, $49, $50, $50, $45, $4E, $53, $54, $49, $46
db $54, $00, $52, $4F, $55, $47, $45, $20, $41, $20, $4C, $45, $56, $52, $45, $53
db $00, $4C, $41, $50, $49, $5A, $20, $44, $45, $20, $4C, $41, $42, $49, $4F, $53
db $00, $52, $4F, $53, $53, $45, $54, $54, $4F, $00, $4D, $41, $53, $43, $41, $52
db $41, $00, $4D, $41, $53, $4B, $41, $52, $41, $00, $4D, $41, $53, $43, $41, $52
db $41, $00, $52, $49, $4D, $45, $4C, $00, $4D, $41, $53, $43, $41, $52, $41, $00
db $4E, $41, $49, $4C, $20, $50, $4F, $4C, $49, $53, $48, $00, $4E, $41, $47, $45
db $4C, $4C, $41, $43, $4B, $00, $56, $45, $52, $4E, $49, $20, $41, $20, $4F, $4E
db $47, $4C, $45, $53, $00, $45, $53, $4D, $41, $4C, $54, $45, $20, $50, $41, $52
db $41, $20, $55, $4E, $41, $53, $00, $53, $4D, $41, $4C, $54, $4F, $20, $50, $45
db $52, $20, $55, $4E, $47, $48, $49, $45, $00, $4E, $41, $49, $4C, $20, $46, $49
db $4C, $45, $00, $4E, $41, $47, $45, $4C, $46, $45, $49, $4C, $45, $00, $4C, $49
db $4D, $45, $20, $41, $20, $4F, $4E, $47, $4C, $45, $53, $00, $4C, $49, $4D, $41
db $20, $50, $41, $52, $41, $20, $55, $4E, $41, $53, $00, $4C, $49, $4D, $45, $54
db $54, $41, $00, $48, $41, $49, $52, $20, $53, $50, $52, $41, $59, $00, $48, $41
db $41, $52, $53, $50, $52, $41, $59, $00, $4C, $41, $51, $55, $45, $00, $4C, $41
db $43, $41, $20, $50, $41, $52, $41, $20, $45, $4C, $20, $50, $45, $4C, $4F, $00
db $4C, $41, $43, $43, $41, $00, $44, $45, $4F, $44, $4F, $52, $41, $4E, $54, $00
db $44, $45, $4F, $00, $44, $45, $4F, $44, $4F, $52, $41, $4E, $54, $00, $44, $45
db $53, $4F, $44, $4F, $52, $41, $4E, $54, $45, $00, $44, $45, $4F, $44, $4F, $52
db $41, $4E, $54, $45, $00, $53, $48, $41, $56, $49, $4E, $47, $20, $43, $52, $45
db $41, $4D, $00, $52, $41, $53, $49, $45, $52, $43, $52, $45, $4D, $45, $00, $43
db $52, $45, $4D, $45, $20, $41, $20, $52, $41, $53, $45, $52, $00, $43, $52, $45
db $4D, $41, $20, $44, $45, $20, $41, $46, $45, $49, $54, $41, $52, $00, $53, $43
db $48, $49, $55, $4D, $41, $20, $44, $41, $20, $42, $41, $52, $42, $41, $00, $52
db $41, $5A, $4F, $52, $20, $42, $4C, $41, $44, $45, $00, $52, $41, $53, $49, $45
db $52, $4B, $4C, $49, $4E, $47, $45, $00, $4C, $41, $4D, $45, $20, $44, $45, $20
db $52, $41, $53, $4F, $49, $52, $00, $48, $4F, $4A, $41, $20, $44, $45, $20, $41
db $46, $45, $49, $54, $41, $52, $00, $4C, $41, $4D, $45, $54, $54, $41, $20, $44
db $41, $20, $42, $41, $52, $42, $41, $00, $48, $41, $49, $52, $20, $47, $45, $4C
db $00, $48, $41, $41, $52, $2D, $47, $45, $4C, $00, $47, $45, $4C, $20, $50, $4F
db $55, $52, $20, $4C, $45, $53, $20, $43, $48, $45, $56, $45, $55, $58, $00, $47
db $45, $4C, $20, $50, $41, $52, $41, $20, $45, $4C, $20, $50, $45, $4C, $4F, $00
db $47, $45, $4C, $20, $50, $45, $52, $20, $43, $41, $50, $45, $4C, $4C, $49, $00
db $54, $4F, $4F, $54, $48, $42, $52, $55, $53, $48, $00, $5A, $41, $48, $4E, $42
db $37, $52, $53, $54, $45, $00, $42, $52, $4F, $53, $53, $45, $20, $41, $20, $44
db $45, $4E, $54, $53, $00, $43, $45, $50, $49, $4C, $4C, $4F, $20, $44, $45, $20
db $44, $49, $45, $4E, $54, $45, $53, $00, $53, $50, $41, $5A, $5A, $4F, $4C, $49
db $4E, $4F, $20, $44, $41, $20, $44, $45, $4E, $54, $49, $00, $54, $4F, $4F, $54
db $48, $50, $41, $53, $54, $45, $00, $5A, $41, $48, $4E, $50, $41, $53, $54, $41
db $00, $50, $41, $54, $45, $20, $44, $45, $4E, $54, $49, $46, $52, $49, $43, $45
db $00, $44, $45, $4E, $54, $49, $46, $52, $49, $43, $4F, $00, $44, $45, $4E, $54
db $49, $46, $52, $49, $43, $49, $4F, $00, $43, $4F, $4D, $42, $00, $4B, $41, $4D
db $4D, $00, $50, $45, $49, $47, $4E, $45, $00, $50, $45, $49, $4E, $45, $00, $50
db $45, $54, $54, $49, $4E, $45, $00, $42, $52, $55, $53, $48, $00, $42, $37, $52
db $53, $54, $45, $00, $42, $52, $4F, $53, $53, $45, $00, $43, $45, $50, $49, $4C
db $4C, $4F, $00, $53, $50, $41, $5A, $5A, $4F, $4C, $41, $00, $53, $4F, $41, $50
db $00, $53, $45, $49, $46, $45, $00, $53, $41, $56, $4F, $4E, $00, $4A, $41, $42
db $4F, $4E, $00, $53, $41, $50, $4F, $4E, $45, $00, $53, $48, $41, $4D, $50, $4F
db $4F, $00, $53, $48, $41, $4D, $50, $4F, $4F, $00, $53, $48, $41, $4D, $50, $4F
db $49, $4E, $47, $00, $43, $48, $41, $4D, $50, $55, $00, $53, $48, $41, $4D, $50
db $4F, $4F, $00, $54, $57, $45, $45, $5A, $45, $52, $53, $00, $50, $49, $4E, $5A
db $45, $54, $54, $45, $00, $50, $49, $4E, $43, $45, $20, $41, $20, $45, $50, $49
db $4C, $45, $52, $00, $50, $49, $4E, $5A, $41, $00, $50, $49, $4E, $5A, $45, $54
db $54, $45, $00, $50, $4C, $41, $53, $54, $45, $52, $00, $48, $45, $46, $54, $50
db $46, $4C, $41, $53, $54, $45, $52, $00, $53, $50, $41, $52, $41, $44, $52, $41
db $50, $00, $45, $53, $50, $41, $52, $41, $44, $52, $41, $50, $4F, $00, $43, $45
db $52, $4F, $54, $54, $4F, $00, $44, $52, $59, $20, $43, $4C, $45, $41, $4E, $45
db $52, $53, $00, $52, $45, $49, $4E, $49, $47, $55, $4E, $47, $00, $4E, $45, $54
db $54, $4F, $59, $41, $47, $45, $20, $41, $20, $53, $45, $43, $00, $4C, $41, $56
db $41, $44, $4F, $20, $45, $4E, $20, $53, $45, $43, $4F, $00, $4C, $41, $56, $41
db $47, $47, $49, $4F, $20, $41, $20, $53, $45, $43, $43, $4F, $00, $50, $52, $45
db $53, $53, $49, $4E, $47, $00, $50, $52, $45, $53, $53, $45, $4E, $00, $50, $52
db $45, $53, $53, $49, $4E, $47, $00, $50, $52, $45, $4E, $53, $41, $44, $4F, $00
db $53, $54, $49, $52, $41, $54, $55, $52, $41, $00, $55, $4E, $44, $45, $52, $57
db $45, $41, $52, $00, $55, $4E, $54, $45, $52, $57, $32, $53, $43, $48, $45, $00
db $53, $4F, $55, $53, $2D, $56, $45, $54, $45, $4D, $45, $4E, $54, $00, $52, $4F
db $50, $41, $20, $49, $4E, $54, $45, $52, $49, $4F, $52, $00, $42, $49, $41, $4E
db $43, $48, $45, $52, $49, $41, $20, $49, $4E, $54, $49, $4D, $41, $00, $53, $4F
db $43, $4B, $53, $00, $53, $4F, $43, $4B, $45, $4E, $00, $43, $48, $41, $55, $53
db $53, $45, $54, $54, $45, $53, $00, $43, $41, $4C, $43, $45, $54, $49, $4E, $45
db $53, $00, $43, $41, $4C, $5A, $49, $4E, $49, $00, $42, $41, $42, $59, $20, $43
db $4C, $4F, $54, $48, $45, $53, $00, $42, $41, $42, $59, $4B, $4C, $45, $49, $44
db $55, $4E, $47, $00, $56, $45, $54, $45, $4D, $45, $4E, $54, $53, $20, $50, $4F
db $55, $52, $20, $42, $45, $42, $45, $53, $00, $52, $4F, $50, $41, $20, $44, $45
db $20, $42, $45, $42, $45, $00, $56, $45, $53, $54, $49, $54, $49, $20, $50, $45
db $52, $20, $42, $41, $4D, $42, $49, $4E, $49, $00, $43, $4F, $41, $54, $00, $4D
db $41, $4E, $54, $45, $4C, $00, $4D, $41, $4E, $54, $45, $41, $55, $00, $41, $42
db $52, $49, $47, $4F, $00, $43, $41, $50, $50, $4F, $54, $54, $4F, $00, $4A, $41
db $43, $4B, $45, $54, $00, $4A, $41, $43, $4B, $45, $00, $56, $45, $53, $54, $45
db $00, $43, $48, $41, $51, $55, $45, $54, $41, $00, $47, $49, $41, $43, $43, $41
db $00, $44, $52, $45, $53, $53, $00, $4B, $4C, $45, $49, $44, $00, $52, $4F, $42
db $45, $00, $56, $45, $53, $54, $49, $44, $4F, $00, $56, $45, $53, $54, $49, $54
db $4F, $00, $45, $56, $45, $4E, $49, $4E, $47, $20, $47, $4F, $57, $4E, $00, $41
db $42, $45, $4E, $44, $4B, $4C, $45, $49, $44, $00, $52, $4F, $42, $45, $20, $44
db $55, $20, $53, $4F, $49, $52, $00, $56, $45, $53, $54, $49, $44, $4F, $20, $44
db $45, $20, $4E, $4F, $43, $48, $45, $00, $41, $42, $49, $54, $4F, $20, $44, $41
db $20, $53, $45, $52, $41, $00, $53, $4B, $49, $52, $54, $00, $52, $4F, $43, $4B
db $00, $4A, $55, $50, $45, $00, $46, $41, $4C, $44, $41, $00, $47, $4F, $4E, $4E
db $41, $00, $42, $4C, $4F, $55, $53, $45, $00, $42, $4C, $55, $53, $45, $00, $43
db $48, $45, $4D, $49, $53, $45, $52, $00, $42, $4C, $55, $53, $41, $00, $42, $4C
db $55, $53, $41, $00, $53, $48, $49, $52, $54, $00, $48, $45, $4D, $44, $42, $4C
db $55, $53, $45, $00, $43, $48, $45, $4D, $49, $53, $45, $00, $43, $41, $4D, $49
db $53, $41, $00, $43, $41, $4D, $49, $43, $49, $41, $00, $53, $57, $45, $41, $54
db $45, $52, $00, $4A, $55, $4D, $50, $45, $52, $00, $50, $55, $4C, $4C, $2D, $4F
db $56, $45, $52, $00, $53, $55, $45, $54, $45, $52, $00, $47, $4F, $4C, $46, $00
db $4A, $45, $41, $4E, $53, $00, $4A, $45, $41, $4E, $53, $00, $4A, $45, $41, $4E
db $00, $50, $41, $4E, $54, $41, $4C, $4F, $4E, $45, $53, $20, $56, $41, $51, $55
db $45, $52, $4F, $53, $00, $4A, $45, $41, $4E, $53, $00, $53, $4B, $49, $20, $4F
db $55, $54, $46, $49, $54, $00, $53, $43, $48, $49, $41, $4E, $5A, $55, $47, $00
db $45, $4E, $53, $45, $4D, $42, $4C, $45, $20, $44, $45, $20, $53, $4B, $49, $00
db $52, $4F, $50, $41, $20, $50, $41, $52, $41, $20, $45, $53, $51, $55, $49, $41
db $52, $00, $54, $55, $54, $41, $20, $44, $41, $20, $53, $43, $49, $00, $53, $57
db $49, $4D, $53, $55, $49, $54, $00, $42, $41, $44, $45, $41, $4E, $5A, $55, $47
db $00, $4D, $41, $49, $4C, $4C, $4F, $54, $20, $44, $45, $20, $42, $41, $49, $4E
db $00, $54, $52, $41, $4A, $45, $20, $44, $45, $20, $42, $41, $4E, $4F, $00, $43
db $4F, $53, $54, $55, $4D, $45, $20, $44, $41, $20, $42, $41, $47, $4E, $4F, $00
db $53, $54, $4F, $43, $4B, $49, $4E, $47, $53, $00, $53, $54, $52, $37, $4D, $50
db $46, $45, $00, $42, $41, $53, $00, $4D, $45, $44, $49, $41, $53, $00, $43, $41
db $4C, $5A, $45, $00, $54, $49, $47, $48, $54, $53, $00, $53, $54, $52, $55, $4D
db $50, $46, $48, $4F, $53, $45, $00, $43, $4F, $4C, $4C, $41, $4E, $54, $00, $4C
db $45, $4F, $54, $41, $52, $44, $4F, $53, $00, $43, $4F, $4C, $4C, $41, $4E, $54
db $00, $48, $41, $54, $00, $48, $55, $54, $00, $43, $48, $41, $50, $45, $41, $55
db $00, $53, $4F, $4D, $42, $52, $45, $52, $4F, $00, $43, $41, $50, $50, $45, $4C
db $4C, $4F, $00, $48, $41, $4E, $44, $4B, $45, $52, $43, $48, $49, $45, $46, $53
db $00, $54, $41, $53, $43, $48, $45, $4E, $54, $38, $43, $48, $45, $52, $00, $4D
db $4F, $55, $43, $48, $4F, $49, $52, $53, $00, $50, $41, $4E, $55, $45, $4C, $4F
db $53, $00, $46, $41, $5A, $5A, $4F, $4C, $45, $54, $54, $49, $00, $47, $4C, $4F
db $56, $45, $53, $00, $48, $41, $4E, $44, $53, $43, $48, $55, $48, $45, $00, $47
db $41, $4E, $54, $53, $00, $47, $55, $41, $4E, $54, $45, $53, $00, $47, $55, $41
db $4E, $54, $49, $00, $53, $49, $5A, $45, $00, $47, $52, $4F, $33, $45, $00, $54
db $41, $49, $4C, $4C, $45, $00, $54, $41, $4D, $41, $4E, $4F, $00, $54, $41, $47
db $4C, $49, $41, $00, $4C, $45, $4E, $47, $54, $48, $00, $4C, $32, $4E, $47, $45
db $00, $4C, $4F, $4E, $47, $55, $45, $55, $52, $00, $4C, $41, $52, $47, $4F, $00
db $4C, $55, $4E, $47, $48, $45, $5A, $5A, $41, $00, $57, $49, $44, $54, $48, $00
db $57, $45, $49, $54, $45, $00, $4C, $41, $52, $47, $45, $55, $52, $00, $41, $4E
db $43, $48, $4F, $00, $4C, $41, $52, $47, $48, $45, $5A, $5A, $41, $00, $42, $45
db $4C, $54, $00, $47, $38, $52, $54, $45, $4C, $00, $43, $45, $49, $4E, $54, $55
db $52, $45, $00, $43, $49, $4E, $54, $55, $52, $4F, $4E, $00, $43, $49, $4E, $54
db $55, $52, $41, $00, $5A, $49, $50, $50, $45, $52, $00, $52, $45, $49, $33, $56
db $45, $52, $53, $43, $48, $4C, $55, $33, $00, $46, $45, $52, $4D, $45, $54, $55
db $52, $45, $20, $45, $43, $4C, $41, $49, $52, $00, $43, $52, $45, $4D, $41, $4C
db $4C, $45, $52, $41, $00, $43, $48, $49, $55, $53, $55, $52, $41, $20, $4C, $41
db $4D, $50, $4F, $00, $4E, $45, $45, $44, $4C, $45, $00, $4E, $32, $48, $4E, $41
db $44, $45, $4C, $00, $41, $49, $47, $55, $49, $4C, $4C, $45, $00, $41, $47, $55
db $4A, $41, $00, $41, $47, $4F, $00, $53, $55, $49, $54, $00, $41, $4E, $5A, $55
db $47, $00, $43, $4F, $4D, $50, $4C, $45, $54, $00, $54, $52, $41, $4A, $45, $00
db $41, $42, $49, $54, $4F, $00, $54, $52, $4F, $55, $53, $45, $52, $53, $00, $48
db $4F, $53, $45, $00, $50, $41, $4E, $54, $41, $4C, $4F, $4E, $00, $50, $41, $4E
db $54, $41, $4C, $4F, $4E, $45, $53, $00, $43, $41, $4C, $5A, $4F, $4E, $49, $00
db $44, $49, $4E, $4E, $45, $52, $20, $4A, $41, $43, $4B, $45, $54, $00, $53, $4D
db $4F, $4B, $49, $4E, $47, $00, $53, $4D, $4F, $4B, $49, $4E, $47, $00, $45, $53
db $4D, $4F, $4B, $49, $4E, $47, $00, $53, $4D, $4F, $4B, $49, $4E, $47, $00, $54
db $49, $45, $00, $4B, $52, $41, $57, $41, $54, $54, $45, $00, $43, $52, $41, $56
db $41, $54, $45, $00, $43, $4F, $52, $42, $41, $54, $41, $00, $43, $52, $41, $56
db $41, $54, $54, $41, $00, $42, $4F, $57, $54, $49, $45, $00, $46, $4C, $49, $45
db $47, $45, $00, $4E, $4F, $45, $55, $44, $20, $50, $41, $50, $49, $4C, $4C, $4F
db $4E, $00, $43, $4F, $52, $42, $41, $54, $49, $4E, $00, $43, $52, $41, $56, $41
db $54, $54, $49, $4E, $4F, $2F, $50, $41, $50, $49, $4C, $4C, $4F, $4E, $00, $55
db $4D, $42, $52, $45, $4C, $4C, $41, $00, $52, $45, $47, $45, $4E, $53, $43, $48
db $49, $52, $4D, $00, $50, $41, $52, $41, $50, $4C, $55, $49, $45, $00, $50, $41
db $52, $41, $47, $55, $41, $53, $00, $4F, $4D, $42, $52, $45, $4C, $4C, $4F, $00
db $53, $57, $49, $4D, $4D, $49, $4E, $47, $20, $54, $52, $55, $4E, $4B, $53, $00
db $42, $41, $44, $45, $48, $4F, $53, $45, $00, $4D, $41, $49, $4C, $4C, $4F, $54
db $20, $44, $45, $20, $42, $41, $49, $4E, $00, $50, $41, $4E, $54, $41, $4C, $4F
db $4E, $20, $44, $45, $20, $42, $41, $4E, $4F, $00, $43, $41, $4C, $5A, $4F, $4E
db $43, $49, $4E, $49, $20, $44, $41, $20, $42, $41, $47, $4E, $4F, $00, $53, $48
db $4F, $52, $54, $53, $00, $53, $48, $4F, $52, $54, $53, $00, $53, $48, $4F, $52
db $54, $53, $00, $50, $41, $4E, $54, $41, $4C, $4F, $4E, $45, $53, $20, $43, $4F
db $52, $54, $4F, $53, $00, $50, $41, $4E, $54, $41, $4C, $4F, $4E, $49, $20, $43
db $4F, $52, $54, $49, $00, $53, $57, $49, $4D, $4D, $49, $4E, $47, $20, $43, $41
db $50, $00, $42, $41, $44, $45, $48, $41, $55, $42, $45, $00, $42, $4F, $4E, $4E
db $45, $54, $20, $44, $45, $20, $42, $41, $49, $4E, $00, $47, $4F, $52, $52, $4F
db $20, $50, $41, $52, $41, $20, $4E, $41, $44, $41, $52, $00, $43, $55, $46, $46
db $49, $41, $20, $44, $41, $20, $42, $41, $47, $4E, $4F, $00, $54, $48, $52, $45
db $41, $44, $00, $5A, $57, $49, $52, $4E, $00, $46, $49, $4C, $00, $48, $49, $4C
db $4F, $00, $46, $49, $4C, $4F, $00, $53, $43, $49, $53, $53, $4F, $52, $53, $00
db $53, $43, $48, $45, $52, $45, $00, $43, $49, $53, $45, $41, $55, $58, $00, $54
db $49, $4A, $45, $52, $41, $53, $00, $46, $4F, $52, $42, $49, $43, $45, $00, $43
db $48, $45, $41, $50, $45, $52, $00, $42, $49, $4C, $4C, $49, $47, $45, $52, $00
db $4D, $4F, $49, $4E, $53, $20, $43, $48, $45, $52, $00, $4D, $41, $53, $20, $42
db $41, $52, $41, $54, $4F, $00, $50, $49, $55, $20, $45, $43, $4F, $4E, $4F, $4D
db $49, $43, $4F, $00, $42, $49, $47, $47, $45, $52, $00, $47, $52, $30, $33, $45
db $52, $00, $50, $4C, $55, $53, $20, $47, $52, $41, $4E, $44, $00, $4D, $41, $53
db $20, $47, $52, $41, $4E, $44, $45, $00, $50, $49, $55, $20, $47, $52, $41, $4E
db $44, $45, $00, $53, $4D, $41, $4C, $4C, $45, $52, $00, $4B, $4C, $45, $49, $4E
db $45, $52, $00, $50, $4C, $55, $53, $20, $50, $45, $54, $49, $54, $00, $4D, $41
db $53, $20, $50, $45, $51, $55, $45, $4E, $4F, $00, $50, $49, $55, $20, $50, $49
db $43, $43, $4F, $4C, $4F, $00, $54, $4F, $4F, $20, $53, $4D, $41, $4C, $4C, $00
db $5A, $55, $20, $4B, $4C, $45, $49, $4E, $00, $54, $52, $4F, $50, $20, $50, $45
db $54, $49, $54, $00, $44, $45, $4D, $41, $53, $49, $41, $44, $4F, $20, $50, $45
db $51, $55, $45, $4E, $4F, $00, $54, $52, $4F, $50, $50, $4F, $20, $50, $49, $43
db $43, $4F, $4C, $4F, $00, $54, $4F, $4F, $20, $42, $49, $47, $00, $5A, $55, $20
db $47, $52, $4F, $33, $00, $54, $52, $4F, $50, $20, $47, $52, $41, $4E, $44, $00
db $44, $45, $4D, $41, $53, $49, $41, $44, $4F, $20, $47, $52, $41, $4E, $44, $45
db $00, $54, $52, $4F, $50, $50, $4F, $20, $47, $52, $41, $4E, $44, $45, $00, $54
db $4F, $4F, $20, $45, $58, $50, $45, $4E, $53, $49, $56, $45, $00, $5A, $55, $20
db $54, $45, $55, $45, $52, $00, $54, $52, $4F, $50, $20, $43, $48, $45, $52, $00
db $44, $45, $4D, $41, $53, $49, $41, $44, $4F, $20, $43, $41, $52, $4F, $00, $54
db $52, $4F, $50, $50, $4F, $20, $43, $41, $52, $4F, $00, $53, $48, $4F, $52, $54
db $45, $52, $00, $4B, $38, $52, $5A, $45, $52, $00, $50, $4C, $55, $53, $20, $43
db $4F, $55, $52, $54, $00, $4D, $41, $53, $20, $43, $4F, $52, $54, $4F, $00, $50
db $49, $55, $20, $43, $4F, $52, $54, $4F, $00, $4C, $4F, $4E, $47, $45, $52, $00
db $4C, $32, $4E, $47, $45, $52, $00, $50, $4C, $55, $53, $20, $4C, $4F, $4E, $47
db $00, $4D, $41, $53, $20, $4C, $41, $52, $47, $4F, $00, $50, $49, $55, $20, $4C
db $55, $4E, $47, $4F, $00, $4C, $49, $47, $48, $54, $45, $52, $00, $48, $45, $4C
db $4C, $45, $52, $00, $50, $4C, $55, $53, $20, $43, $4C, $41, $49, $52, $00, $4D
db $41, $53, $20, $43, $4C, $41, $52, $4F, $00, $50, $49, $55, $20, $43, $48, $49
db $41, $52, $4F, $00, $44, $41, $52, $4B, $45, $52, $00, $44, $55, $4E, $4B, $4C
db $45, $52, $00, $50, $4C, $55, $53, $20, $46, $4F, $4E, $43, $45, $00, $4D, $41
db $53, $20, $4F, $53, $43, $55, $52, $4F, $00, $50, $49, $55, $20, $53, $43, $55
db $52, $4F, $00, $53, $48, $4F, $45, $53, $00, $53, $43, $48, $55, $48, $45, $00
db $43, $48, $41, $55, $53, $53, $55, $52, $45, $53, $00, $5A, $41, $50, $41, $54
db $4F, $53, $00, $53, $43, $41, $52, $50, $45, $00, $42, $4F, $4F, $54, $53, $00
db $53, $54, $49, $45, $46, $45, $4C, $00, $42, $4F, $54, $54, $45, $53, $00, $42
db $4F, $54, $41, $53, $00, $53, $54, $49, $56, $41, $4C, $49, $00, $57, $41, $4C
db $4B, $49, $4E, $47, $20, $53, $48, $4F, $45, $53, $00, $57, $41, $4E, $44, $45
db $52, $53, $43, $48, $55, $48, $45, $00, $43, $48, $41, $55, $53, $53, $55, $52
db $45, $53, $20, $44, $45, $20, $4D, $41, $52, $43, $48, $45, $00, $5A, $41, $50
db $41, $54, $4F, $53, $20, $44, $45, $20, $50, $41, $53, $45, $4F, $00, $53, $43
db $41, $52, $50, $45, $20, $44, $41, $20, $50, $41, $53, $53, $45, $47, $47, $49
db $4F, $00, $53, $41, $4E, $44, $41, $4C, $53, $00, $53, $41, $4E, $44, $41, $4C
db $45, $4E, $00, $53, $41, $4E, $44, $41, $4C, $45, $53, $00, $53, $41, $4E, $44
db $41, $4C, $49, $41, $53, $00, $53, $41, $4E, $44, $41, $4C, $49, $00, $53, $48
db $4F, $45, $4C, $41, $43, $45, $53, $00, $53, $43, $48, $4E, $38, $52, $53, $45
db $4E, $4B, $45, $4C, $00, $4C, $41, $43, $45, $54, $53, $00, $43, $4F, $52, $44
db $4F, $4E, $45, $53, $00, $53, $54, $52, $49, $4E, $47, $48, $45, $00, $53, $48
db $4F, $45, $20, $50, $4F, $4C, $49, $53, $48, $00, $53, $43, $48, $55, $48, $43
db $52, $45, $4D, $45, $00, $43, $49, $52, $41, $47, $45, $00, $42, $4F, $4C, $41
db $00, $4C, $55, $43, $49, $44, $4F, $20, $44, $41, $20, $53, $43, $41, $52, $50
db $45, $00, $43, $4F, $42, $42, $4C, $45, $52, $00, $53, $43, $48, $55, $53, $54
db $45, $52, $00, $43, $4F, $52, $44, $4F, $4E, $4E, $49, $45, $52, $00, $5A, $41
db $50, $41, $54, $45, $52, $4F, $00, $43, $41, $4C, $5A, $4F, $4C, $41, $49, $4F
db $00, $53, $55, $49, $54, $43, $41, $53, $45, $00, $48, $41, $4E, $44, $4B, $4F
db $46, $46, $45, $52, $00, $56, $41, $4C, $49, $53, $45, $00, $4D, $41, $4C, $45
db $54, $41, $20, $44, $45, $20, $4D, $41, $4E, $4F, $00, $56, $41, $4C, $49, $47
db $49, $41, $00, $42, $52, $49, $45, $46, $43, $41, $53, $45, $00, $41, $4B, $54
db $45, $4E, $54, $41, $53, $43, $48, $45, $00, $53, $45, $52, $56, $49, $45, $54
db $54, $45, $00, $43, $41, $52, $54, $45, $52, $41, $00, $43, $41, $52, $54, $45
db $4C, $4C, $41, $00, $4C, $41, $44, $49, $45, $53, $20, $48, $41, $4E, $44, $42
db $41, $47, $00, $44, $41, $4D, $45, $4E, $48, $41, $4E, $44, $54, $41, $53, $43
db $48, $45, $00, $53, $41, $43, $20, $50, $4F, $55, $52, $20, $44, $41, $4D, $45
db $53, $00, $42, $4F, $4C, $53, $41, $20, $44, $45, $20, $53, $45, $4E, $4F, $52
db $41, $00, $42, $4F, $52, $53, $45, $54, $54, $41, $00, $52, $55, $43, $4B, $53
db $41, $43, $4B, $00, $52, $55, $43, $4B, $53, $41, $43, $4B, $00, $53, $41, $43
db $20, $41, $20, $44, $4F, $53, $00, $4D, $4F, $43, $48, $49, $4C, $41, $00, $5A
db $41, $49, $4E, $4F, $00, $57, $41, $4C, $4C, $45, $54, $00, $42, $52, $49, $45
db $46, $54, $41, $53, $43, $48, $45, $00, $50, $4F, $52, $54, $45, $46, $45, $55
db $49, $4C, $4C, $45, $00, $42, $49, $4C, $4C, $45, $54, $45, $52, $41, $00, $50
db $4F, $52, $54, $41, $46, $4F, $47, $4C, $49, $4F, $00, $50, $55, $52, $53, $45
db $00, $50, $4F, $52, $54, $45, $4D, $4F, $4E, $4E, $41, $49, $45, $00, $50, $4F
db $52, $54, $45, $2D, $4D, $4F, $4E, $4E, $41, $49, $45, $00, $4D, $4F, $4E, $45
db $44, $45, $52, $4F, $00, $50, $4F, $52, $54, $41, $4D, $4F, $4E, $45, $54, $45
db $00, $43, $41, $4D, $45, $52, $41, $00, $46, $4F, $54, $4F, $41, $50, $50, $41
db $52, $41, $54, $00, $41, $50, $50, $41, $52, $45, $49, $4C, $20, $50, $48, $4F
db $54, $4F, $00, $43, $41, $4D, $41, $52, $41, $20, $46, $4F, $54, $4F, $47, $52
db $41, $46, $49, $43, $41, $00, $4D, $41, $43, $43, $48, $49, $4E, $41, $20, $46
db $4F, $54, $4F, $47, $52, $41, $46, $49, $43, $41, $00, $52, $4F, $4C, $4C, $20
db $4F, $46, $20, $46, $49, $4C, $4D, $00, $46, $49, $4C, $4D, $52, $4F, $4C, $4C
db $45, $00, $50, $45, $4C, $4C, $49, $43, $55, $4C, $45, $00, $52, $4F, $4C, $4C
db $4F, $20, $44, $45, $20, $50, $45, $4C, $49, $43, $55, $4C, $41, $00, $50, $45
db $4C, $4C, $49, $43, $4F, $4C, $41, $00, $44, $45, $56, $45, $4C, $4F, $50, $4D
db $45, $4E, $54, $00, $45, $4E, $54, $57, $49, $43, $4B, $4C, $55, $4E, $47, $00
db $44, $45, $56, $45, $4C, $4F, $50, $50, $45, $4D, $45, $4E, $54, $00, $52, $45
db $56, $45, $4C, $41, $44, $4F, $00, $53, $56, $49, $4C, $55, $50, $50, $4F, $00
db $47, $4C, $41, $53, $53, $45, $53, $00, $42, $52, $49, $4C, $4C, $45, $00, $4C
db $55, $4E, $45, $54, $54, $45, $53, $00, $47, $41, $46, $41, $53, $00, $4F, $43
db $43, $48, $49, $41, $4C, $49, $00, $53, $55, $4E, $47, $4C, $41, $53, $53, $45
db $53, $00, $53, $4F, $4E, $4E, $45, $4E, $42, $52, $49, $4C, $4C, $45, $00, $4C
db $55, $4E, $45, $54, $54, $45, $53, $20, $44, $45, $20, $53, $4F, $4C, $45, $49
db $4C, $00, $47, $41, $46, $41, $53, $20, $44, $45, $20, $53, $4F, $4C, $00, $4F
db $43, $43, $48, $49, $41, $4C, $49, $20, $44, $41, $20, $53, $4F, $4C, $45, $00
db $47, $4F, $4C, $44, $00, $47, $4F, $4C, $44, $00, $4F, $52, $00, $4F, $52, $4F
db $00, $4F, $52, $4F, $00, $47, $4F, $4C, $44, $50, $4C, $41, $54, $45, $00, $44
db $4F, $55, $42, $4C, $45, $00, $50, $4C, $41, $51, $55, $45, $20, $4F, $52, $00
db $43, $48, $41, $50, $41, $44, $4F, $20, $44, $45, $20, $4F, $52, $4F, $00, $50
db $4C, $41, $43, $43, $41, $54, $4F, $20, $4F, $52, $4F, $00, $53, $54, $45, $52
db $4C, $49, $4E, $47, $20, $53, $49, $4C, $56, $45, $52, $00, $53, $54, $45, $52
db $4C, $49, $4E, $47, $53, $49, $4C, $42, $45, $52, $00, $41, $52, $47, $45, $4E
db $54, $20, $46, $49, $4E, $00, $50, $4C, $41, $54, $41, $20, $44, $45, $20, $4C
db $45, $59, $00, $41, $52, $47, $45, $4E, $54, $4F, $20, $50, $55, $52, $4F, $00
db $53, $49, $4C, $56, $45, $52, $20, $50, $4C, $41, $54, $45, $00, $53, $49, $4C
db $42, $45, $52, $4C, $45, $47, $49, $45, $52, $54, $00, $50, $4C, $41, $51, $55
db $45, $20, $41, $52, $47, $45, $4E, $54, $00, $43, $48, $41, $50, $41, $44, $4F
db $20, $44, $45, $20, $50, $4C, $41, $54, $41, $00, $50, $4C, $41, $43, $43, $41
db $54, $4F, $20, $41, $52, $47, $45, $4E, $54, $4F, $00, $47, $45, $4E, $55, $49
db $4E, $45, $00, $45, $43, $48, $54, $00, $56, $45, $52, $49, $54, $41, $42, $4C
db $45, $00, $41, $55, $54, $45, $4E, $54, $49, $43, $4F, $00, $41, $55, $54, $45
db $4E, $54, $49, $43, $4F, $00, $49, $4D, $49, $54, $41, $54, $49, $4F, $4E, $00
db $55, $4E, $45, $43, $48, $54, $00, $49, $4D, $49, $54, $41, $54, $49, $4F, $4E
db $00, $49, $4D, $49, $54, $41, $43, $49, $4F, $4E, $00, $49, $4D, $49, $54, $41
db $5A, $49, $4F, $4E, $45, $00, $48, $41, $4E, $44, $4D, $41, $44, $45, $00, $48
db $41, $4E, $44, $41, $52, $42, $45, $49, $54, $00, $46, $41, $49, $54, $20, $41
db $20, $4C, $41, $20, $4D, $41, $49, $4E, $00, $48, $45, $43, $48, $4F, $20, $41
db $20, $4D, $41, $4E, $4F, $00, $46, $41, $54, $54, $4F, $20, $41, $20, $4D, $41
db $4E, $4F, $00, $43, $52, $59, $53, $54, $41, $4C, $00, $4B, $52, $49, $53, $54
db $41, $4C, $4C, $00, $43, $52, $49, $53, $54, $41, $4C, $00, $43, $52, $49, $53
db $54, $41, $4C, $00, $43, $52, $49, $53, $54, $41, $4C, $4C, $4F, $00, $42, $4F
db $4F, $4B, $20, $53, $48, $4F, $50, $00, $42, $55, $43, $48, $48, $41, $4E, $44
db $4C, $55, $4E, $47, $00, $4C, $49, $42, $52, $41, $49, $52, $49, $45, $00, $4C
db $49, $42, $52, $45, $52, $49, $41, $00, $4C, $49, $42, $52, $45, $52, $49, $41
db $00, $44, $49, $43, $54, $49, $4F, $4E, $41, $52, $59, $00, $57, $39, $52, $54
db $45, $52, $42, $55, $43, $48, $00, $44, $49, $43, $54, $49, $4F, $4E, $4E, $41
db $49, $52, $45, $00, $44, $49, $43, $43, $49, $4F, $4E, $41, $52, $49, $4F, $00
db $44, $49, $5A, $49, $4F, $4E, $41, $52, $49, $4F, $00, $4D, $41, $50, $00, $4C
db $41, $4E, $44, $4B, $41, $52, $54, $45, $00, $43, $41, $52, $54, $45, $00, $4D
db $41, $50, $41, $00, $43, $41, $52, $54, $41, $20, $47, $45, $4F, $47, $52, $41
db $46, $49, $43, $41, $00, $4E, $45, $57, $53, $50, $41, $50, $45, $52, $53, $00
db $5A, $45, $49, $54, $55, $4E, $47, $45, $4E, $00, $4A, $4F, $55, $52, $4E, $41
db $55, $58, $00, $50, $45, $52, $49, $4F, $44, $49, $43, $4F, $53, $00, $47, $49
db $4F, $52, $4E, $41, $4C, $49, $00, $45, $4E, $56, $45, $4C, $4F, $50, $45, $00
db $55, $4D, $53, $43, $48, $4C, $41, $47, $00, $45, $4E, $56, $45, $4C, $4F, $50
db $50, $45, $00, $53, $4F, $42, $52, $45, $00, $42, $55, $53, $54, $41, $00, $50
db $45, $4E, $43, $49, $4C, $00, $42, $4C, $45, $49, $53, $54, $49, $46, $54, $00
db $43, $52, $41, $59, $4F, $4E, $00, $4C, $41, $50, $49, $5A, $00, $4D, $41, $54
db $49, $54, $41, $00, $50, $45, $4E, $00, $4B, $55, $47, $45, $4C, $53, $43, $48
db $52, $45, $49, $42, $45, $52, $00, $53, $54, $59, $4C, $4F, $20, $41, $20, $42
db $49, $4C, $4C, $45, $00, $42, $4F, $4C, $49, $47, $52, $41, $46, $4F, $00, $50
db $45, $4E, $4E, $41, $20, $42, $49, $52, $4F, $00, $4E, $4F, $54, $45, $42, $4F
db $4F, $4B, $00, $4E, $4F, $54, $49, $5A, $42, $4C, $4F, $43, $4B, $00, $43, $41
db $52, $4E, $45, $54, $00, $4C, $49, $42, $52, $45, $54, $41, $00, $54, $41, $43
db $43, $55, $49, $4E, $4F, $00, $50, $4F, $53, $54, $43, $41, $52, $44, $00, $50
db $4F, $53, $54, $4B, $41, $52, $54, $45, $00, $43, $41, $52, $54, $45, $2D, $4C
db $45, $54, $54, $52, $45, $00, $43, $41, $52, $54, $41, $20, $50, $4F, $53, $54
db $41, $4C, $00, $43, $41, $52, $54, $4F, $4C, $49, $4E, $41, $00, $50, $48, $4F
db $54, $4F, $20, $41, $4C, $42, $55, $4D, $00, $46, $4F, $54, $4F, $41, $4C, $42
db $55, $4D, $00, $41, $4C, $42, $55, $4D, $20, $44, $45, $20, $50, $48, $4F, $54
db $4F, $53, $00, $41, $4C, $42, $55, $4D, $20, $44, $45, $20, $46, $4F, $54, $4F
db $53, $00, $41, $4C, $42, $55, $4D, $20, $44, $49, $20, $46, $4F, $54, $4F, $00
db $43, $41, $4C, $45, $4E, $44, $41, $52, $00, $4B, $41, $4C, $45, $4E, $44, $45
db $52, $00, $43, $41, $4C, $45, $4E, $44, $52, $49, $45, $52, $00, $43, $41, $4C
db $45, $4E, $44, $41, $52, $49, $4F, $00, $43, $41, $4C, $45, $4E, $44, $41, $52
db $49, $4F, $00, $54, $4F, $42, $41, $43, $43, $4F, $20, $53, $48, $4F, $50, $00
db $54, $41, $42, $41, $4B, $48, $41, $4E, $44, $4C, $55, $4E, $47, $00, $42, $55
db $52, $45, $41, $55, $20, $44, $45, $20, $54, $41, $42, $41, $43, $00, $45, $53
db $54, $41, $4E, $43, $4F, $00, $54, $41, $42, $41, $43, $43, $48, $45, $52, $49
db $41, $00, $43, $49, $47, $41, $52, $00, $5A, $49, $47, $41, $52, $52, $45, $00
db $43, $49, $47, $41, $52, $45, $00, $50, $55, $52, $4F, $00, $53, $49, $47, $41
db $52, $4F, $00, $43, $49, $47, $41, $52, $45, $54, $54, $45, $53, $00, $5A, $49
db $47, $41, $52, $45, $54, $54, $45, $4E, $00, $43, $49, $47, $41, $52, $45, $54
db $54, $45, $53, $00, $43, $49, $47, $41, $52, $52, $4F, $53, $00, $53, $49, $47
db $41, $52, $45, $54, $54, $45, $00, $4D, $41, $54, $43, $48, $45, $53, $00, $5A
db $37, $4E, $44, $48, $4F, $4C, $5A, $45, $52, $00, $41, $4C, $4C, $55, $4D, $45
db $54, $54, $45, $53, $00, $43, $45, $52, $49, $4C, $4C, $41, $53, $00, $46, $49
db $41, $4D, $4D, $49, $46, $45, $52, $49, $00, $4C, $49, $47, $48, $54, $45, $52
db $00, $46, $45, $55, $45, $52, $5A, $45, $55, $47, $00, $42, $52, $49, $51, $55
db $45, $54, $00, $45, $4E, $43, $45, $4E, $44, $45, $44, $4F, $52, $00, $41, $43
db $43, $45, $4E, $44, $49, $4E, $4F, $00, $43, $4F, $4D, $50, $55, $54, $45, $52
db $53, $00, $43, $4F, $4D, $50, $55, $54, $45, $52, $00, $4F, $52, $44, $49, $4E
db $41, $54, $45, $55, $52, $53, $00, $43, $4F, $4D, $50, $55, $54, $41, $44, $4F
db $52, $41, $53, $00, $43, $4F, $4D, $50, $55, $54, $45, $52, $00, $57, $49, $4E
db $45, $20, $53, $48, $4F, $50, $00, $57, $45, $49, $4E, $48, $41, $4E, $44, $4C
db $55, $4E, $47, $00, $43, $4F, $4D, $4D, $45, $52, $43, $45, $20, $44, $45, $20
db $56, $49, $4E, $53, $00, $56, $49, $4E, $41, $54, $45, $52, $49, $41, $00, $45
db $4E, $4F, $54, $45, $43, $41, $00, $56, $49, $4E, $54, $41, $47, $45, $00, $4A
db $41, $48, $52, $47, $41, $4E, $47, $00, $43, $52, $55, $00, $43, $4F, $53, $45
db $43, $48, $41, $00, $41, $4E, $4E, $41, $54, $41, $00, $44, $52, $59, $00, $54
db $52, $4F, $43, $4B, $45, $4E, $00, $53, $45, $43, $00, $53, $45, $43, $4F, $00
db $53, $45, $43, $43, $4F, $00, $4D, $45, $44, $49, $55, $4D, $20, $44, $52, $59
db $00, $48, $41, $4C, $42, $54, $52, $4F, $43, $4B, $45, $4E, $00, $44, $45, $4D
db $49, $2D, $53, $45, $43, $00, $53, $55, $41, $56, $45, $00, $41, $42, $42, $4F
db $43, $43, $41, $54, $4F, $00, $53, $57, $45, $45, $54, $00, $4C, $49, $45, $42
db $4C, $49, $43, $48, $00, $44, $4F, $55, $58, $00, $44, $55, $4C, $43, $45, $00
db $41, $4D, $41, $42, $49, $4C, $45, $00, $46, $52, $55, $49, $54, $20, $53, $48
db $4F, $50, $00, $4F, $42, $53, $54, $4C, $41, $44, $45, $4E, $00, $4D, $41, $47
db $41, $53, $49, $4E, $20, $44, $45, $20, $46, $52, $55, $49, $54, $53, $00, $46
db $52, $55, $54, $45, $52, $49, $41, $00, $46, $52, $55, $54, $54, $49, $56, $45
db $4E, $44, $4F, $4C, $4F, $00, $53, $57, $45, $45, $54, $20, $53, $48, $4F, $50
db $00, $53, $43, $48, $4F, $4B, $4F, $4C, $41, $44, $45, $4E, $47, $45, $53, $43
db $48, $32, $46, $54, $00, $43, $4F, $4E, $46, $49, $53, $45, $52, $49, $45, $00
db $43, $4F, $4E, $46, $49, $54, $45, $52, $49, $41, $00, $43, $4F, $4E, $46, $45
db $54, $54, $45, $52, $49, $41, $00, $42, $59, $20, $54, $48, $45, $20, $50, $4F
db $55, $4E, $44, $00, $4C, $4F, $53, $45, $00, $41, $55, $20, $50, $4F, $49, $44
db $53, $00, $41, $4C, $20, $50, $45, $53, $4F, $00, $53, $43, $49, $4F, $4C, $54
db $4F, $2F, $41, $20, $50, $45, $53, $4F, $00, $42, $41, $52, $00, $54, $41, $46
db $45, $4C, $00, $50, $4C, $41, $51, $55, $45, $00, $42, $41, $52, $52, $41, $00
db $54, $41, $56, $4F, $4C, $45, $54, $54, $41, $00, $50, $49, $45, $43, $45, $00
db $53, $54, $38, $43, $4B, $00, $50, $49, $45, $43, $45, $00, $50, $45, $44, $41
db $5A, $4F, $00, $50, $45, $5A, $5A, $4F, $00, $53, $57, $45, $45, $54, $53, $00
db $42, $4F, $4E, $42, $4F, $4E, $53, $00, $42, $4F, $4E, $42, $4F, $4E, $53, $00
db $43, $41, $52, $41, $4D, $45, $4C, $4F, $53, $00, $43, $41, $52, $41, $4D, $45
db $4C, $4C, $45, $00, $46, $4C, $4F, $52, $49, $53, $54, $00, $42, $4C, $55, $4D
db $45, $4E, $47, $45, $53, $43, $48, $31, $46, $54, $00, $46, $4C, $45, $55, $52
db $49, $53, $54, $45, $00, $46, $4C, $4F, $52, $45, $52, $49, $41, $00, $46, $49
db $4F, $52, $41, $49, $4F, $00, $42, $4F, $55, $51, $55, $45, $54, $00, $53, $54
db $52, $41, $55, $33, $00, $42, $4F, $55, $51, $55, $45, $54, $00, $52, $41, $4D
db $4F, $00, $4D, $41, $5A, $5A, $4F, $00, $42, $55, $4E, $43, $48, $00, $42, $55
db $4E, $44, $00, $42, $4F, $54, $54, $45, $00, $52, $41, $4D, $4F, $00, $46, $41
db $53, $43, $49, $4F, $00, $43, $41, $52, $4E, $41, $54, $49, $4F, $4E, $00, $4E
db $45, $4C, $4B, $45, $00, $4F, $45, $49, $4C, $4C, $45, $54, $00, $43, $4C, $41
db $56, $45, $4C, $00, $47, $41, $52, $4F, $46, $41, $4E, $4F, $00, $52, $4F, $53
db $45, $00, $52, $4F, $53, $45, $00, $52, $4F, $53, $45, $00, $52, $4F, $53, $41
db $00, $52, $4F, $53, $41, $00, $54, $55, $4C, $49, $50, $00, $54, $55, $4C, $50
db $45, $00, $54, $55, $4C, $49, $50, $45, $00, $54, $55, $4C, $49, $50, $41, $4E
db $00, $54, $55, $4C, $49, $50, $41, $4E, $4F, $00, $52, $45, $43, $4F, $52, $44
db $20, $53, $48, $4F, $50, $00, $50, $4C, $41, $54, $54, $45, $4E, $4C, $41, $44
db $45, $4E, $00, $4D, $41, $47, $41, $53, $49, $4E, $20, $44, $45, $20, $44, $49
db $53, $51, $55, $45, $53, $00, $54, $49, $45, $4E, $44, $41, $20, $44, $45, $20
db $44, $49, $53, $43, $4F, $53, $00, $4E, $45, $47, $4F, $5A, $49, $4F, $20, $44
db $49, $20, $44, $49, $53, $43, $48, $49, $00, $57, $41, $56, $45, $20, $4C, $45
db $4E, $47, $54, $48, $00, $57, $45, $4C, $4C, $45, $4E, $4C, $32, $4E, $47, $45
db $00, $4C, $4F, $4E, $47, $55, $45, $55, $52, $53, $20, $44, $27, $4F, $4E, $44
db $45, $53, $00, $4C, $4F, $4E, $47, $49, $54, $55, $44, $20, $44, $45, $20, $4F
db $4E, $44, $41, $53, $00, $4C, $55, $4E, $47, $48, $45, $5A, $5A, $41, $20, $44
db $27, $4F, $4E, $44, $41, $00, $43, $41, $52, $20, $52, $41, $44, $49, $4F, $00
db $41, $55, $54, $4F, $52, $41, $44, $49, $4F, $00, $41, $55, $54, $4F, $2D, $52
db $41, $44, $49, $4F, $00, $52, $41, $44, $49, $4F, $20, $44, $45, $20, $41, $55
db $54, $4F, $4D, $4F, $56, $49, $4C, $00, $41, $55, $54, $4F, $52, $41, $44, $49
db $4F, $00, $52, $45, $43, $4F, $52, $44, $20, $50, $4C, $41, $59, $45, $52, $00
db $50, $4C, $41, $54, $54, $45, $4E, $53, $50, $49, $45, $4C, $45, $52, $00, $54
db $4F, $55, $52, $4E, $45, $2D, $44, $49, $53, $51, $55, $45, $53, $00, $50, $4C
db $41, $54, $49, $4E, $41, $00, $47, $49, $52, $41, $44, $49, $53, $43, $48, $49
db $00, $43, $4C, $41, $53, $53, $49, $43, $41, $4C, $20, $4D, $55, $53, $49, $43
db $00, $4B, $4C, $41, $53, $53, $49, $53, $43, $48, $45, $20, $4D, $55, $53, $49
db $4B, $00, $4D, $55, $53, $49, $51, $55, $45, $20, $43, $4C, $41, $53, $53, $49
db $51, $55, $45, $00, $4D, $55, $53, $49, $43, $41, $20, $43, $4C, $41, $53, $49
db $43, $41, $00, $4D, $55, $53, $49, $43, $41, $20, $43, $4C, $41, $53, $53, $49
db $43, $41, $00, $52, $4F, $43, $4B, $00, $52, $4F, $43, $4B, $4D, $55, $53, $49
db $4B, $00, $52, $4F, $43, $4B, $00, $4D, $55, $53, $49, $43, $41, $20, $52, $4F
db $43, $4B, $00, $4D, $55, $53, $49, $43, $41, $20, $52, $4F, $43, $4B, $00, $44
db $49, $53, $43, $4F, $00, $54, $41, $4E, $5A, $4D, $55, $53, $49, $4B, $00, $44
db $49, $53, $43, $4F, $00, $4D, $55, $53, $49, $43, $41, $20, $50, $41, $52, $41
db $20, $42, $41, $49, $4C, $41, $52, $00, $4D, $55, $53, $49, $43, $41, $20, $44
db $41, $20, $44, $49, $53, $43, $4F, $54, $45, $43, $41, $00, $45, $41, $52, $50
db $48, $4F, $4E, $45, $53, $00, $4B, $4F, $50, $46, $48, $39, $52, $45, $52, $00
db $45, $43, $4F, $55, $54, $45, $55, $52, $53, $00, $41, $55, $44, $49, $46, $4F
db $4E, $4F, $53, $00, $43, $55, $46, $46, $49, $41, $00, $46, $52, $49, $44, $47
db $45, $00, $4B, $37, $48, $4C, $53, $43, $48, $52, $41, $4E, $4B, $00, $52, $45
db $46, $52, $49, $47, $45, $52, $41, $54, $45, $55, $52, $00, $46, $52, $49, $47
db $4F, $52, $49, $46, $49, $43, $4F, $00, $46, $52, $49, $47, $4F, $52, $49, $46
db $45, $52, $4F, $00, $46, $52, $45, $45, $5A, $45, $52, $00, $47, $45, $46, $52
db $49, $45, $52, $54, $52, $55, $48, $45, $00, $43, $4F, $4E, $47, $45, $4C, $41
db $54, $45, $55, $52, $00, $43, $4F, $4E, $47, $45, $4C, $41, $44, $4F, $52, $00
db $43, $4F, $4E, $47, $45, $4C, $41, $54, $4F, $52, $45, $00, $49, $52, $4F, $4E
db $00, $42, $37, $47, $45, $4C, $45, $49, $53, $45, $4E, $00, $46, $45, $52, $20
db $41, $20, $52, $45, $50, $41, $53, $53, $45, $52, $00, $50, $4C, $41, $4E, $43
db $48, $41, $00, $46, $45, $52, $52, $4F, $20, $44, $41, $20, $53, $54, $49, $52
db $4F, $00, $42, $4C, $4F, $57, $20, $44, $52, $59, $45, $52, $00, $46, $39, $4E
db $00, $53, $45, $43, $48, $45, $2D, $43, $48, $45, $56, $45, $55, $58, $00, $53
db $45, $43, $41, $44, $4F, $52, $00, $41, $53, $43, $49, $55, $47, $41, $43, $41
db $50, $45, $4C, $4C, $49, $00, $4C, $49, $4D, $4F, $55, $53, $49, $4E, $45, $2F
db $48, $49, $52, $45, $20, $43, $41, $52, $00, $4D, $49, $45, $54, $57, $41, $47
db $45, $4E, $00, $56, $4F, $49, $54, $55, $52, $45, $20, $41, $20, $4C, $4F, $55
db $45, $52, $00, $43, $4F, $43, $48, $45, $20, $44, $45, $20, $41, $4C, $51, $55
db $49, $4C, $45, $52, $00, $4D, $41, $43, $43, $48, $49, $4E, $41, $20, $41, $20
db $4E, $4F, $4C, $45, $47, $47, $49, $4F, $00, $4D, $49, $4E, $49, $42, $55, $53
db $00, $4B, $4C, $45, $49, $4E, $42, $55, $53, $00, $4D, $49, $4E, $49, $2D, $42
db $55, $53, $00, $4D, $49, $4E, $49, $20, $42, $55, $53, $00, $50, $49, $43, $43
db $4F, $4C, $4F, $20, $41, $55, $54, $4F, $42, $55, $53, $00, $54, $4F, $55, $52
db $49, $53, $54, $20, $42, $55, $53, $00, $52, $45, $49, $53, $45, $42, $55, $53
db $00, $41, $55, $54, $4F, $42, $55, $53, $20, $44, $45, $20, $54, $4F, $55, $52
db $49, $53, $4D, $45, $00, $41, $55, $54, $4F, $42, $55, $53, $20, $44, $45, $20
db $54, $55, $52, $49, $53, $4D, $4F, $00, $50, $55, $4C, $4C, $4D, $41, $4E, $00
db $42, $41, $4C, $4C, $00, $42, $41, $4C, $4C, $00, $42, $41, $4C, $4C, $45, $00
db $50, $45, $4C, $4F, $54, $41, $00, $50, $41, $4C, $4C, $41, $00, $54, $45, $4E
db $4E, $49, $53, $20, $52, $41, $43, $4B, $45, $54, $00, $54, $45, $4E, $4E, $49
db $53, $53, $43, $48, $4C, $32, $47, $45, $52, $00, $52, $41, $51, $55, $45, $54
db $54, $45, $20, $44, $45, $20, $54, $45, $4E, $4E, $49, $53, $00, $52, $41, $51
db $55, $45, $54, $41, $20, $44, $45, $20, $54, $45, $4E, $49, $53, $00, $52, $41
db $43, $43, $48, $45, $54, $54, $41, $20, $44, $41, $20, $54, $45, $4E, $4E, $49
db $53, $00, $54, $45, $4E, $4E, $49, $53, $20, $53, $48, $4F, $45, $53, $00, $54
db $45, $4E, $4E, $49, $53, $53, $43, $48, $55, $48, $45, $00, $43, $48, $41, $55
db $53, $53, $55, $52, $45, $53, $20, $44, $45, $20, $54, $45, $4E, $4E, $49, $53
db $00, $5A, $41, $50, $41, $54, $49, $4C, $4C, $41, $53, $20, $44, $45, $20, $54
db $45, $4E, $49, $53, $00, $53, $43, $41, $52, $50, $45, $20, $44, $41, $20, $54
db $45, $4E, $4E, $49, $53, $00, $47, $4F, $4C, $46, $20, $43, $4C, $55, $42, $00
db $47, $4F, $4C, $46, $53, $43, $48, $4C, $32, $47, $45, $52, $00, $43, $52, $4F
db $53, $53, $45, $20, $44, $45, $20, $47, $4F, $4C, $46, $00, $50, $41, $4C, $4F
db $20, $44, $45, $20, $47, $4F, $4C, $46, $00, $4D, $41, $5A, $5A, $41, $20, $44
db $41, $20, $47, $4F, $4C, $46, $00, $47, $4F, $4C, $46, $20, $42, $41, $4C, $4C
db $00, $47, $4F, $4C, $46, $42, $41, $4C, $4C, $00, $42, $41, $4C, $4C, $45, $20
db $44, $45, $20, $47, $4F, $4C, $46, $00, $50, $45, $4C, $4F, $54, $41, $20, $44
db $45, $20, $47, $4F, $4C, $46, $00, $50, $41, $4C, $4C, $41, $20, $44, $41, $20
db $47, $4F, $4C, $46, $00, $43, $52, $41, $53, $48, $20, $48, $45, $4C, $4D, $45
db $54, $00, $53, $54, $55, $52, $5A, $48, $45, $4C, $4D, $00, $42, $4F, $4D, $42
db $45, $00, $43, $41, $53, $43, $4F, $00, $43, $41, $53, $43, $4F, $00, $53, $4B
db $49, $00, $53, $43, $48, $49, $00, $53, $4B, $49, $00, $45, $53, $51, $55, $49
db $00, $53, $43, $49, $00, $53, $4B, $49, $20, $50, $4F, $4C, $45, $00, $53, $43
db $48, $49, $53, $54, $4F, $43, $4B, $00, $42, $41, $54, $4F, $4E, $20, $44, $45
db $20, $53, $4B, $49, $00, $42, $41, $53, $54, $4F, $4E, $20, $44, $45, $20, $45
db $53, $51, $55, $49, $41, $52, $00, $42, $41, $53, $54, $4F, $4E, $43, $49, $4E
db $49, $20, $44, $41, $20, $53, $43, $49, $00, $53, $4B, $49, $20, $42, $4F, $4F
db $54, $53, $00, $53, $43, $48, $49, $53, $54, $49, $45, $46, $45, $4C, $00, $43
db $48, $41, $55, $53, $53, $55, $52, $45, $53, $20, $44, $45, $20, $53, $4B, $49
db $00, $42, $4F, $54, $41, $53, $20, $44, $45, $20, $45, $53, $51, $55, $49, $41
db $52, $00, $53, $43, $41, $52, $50, $4F, $4E, $49, $20, $44, $41, $20, $53, $43
db $49, $00, $46, $49, $53, $48, $49, $4E, $47, $20, $52, $4F, $44, $00, $41, $4E
db $47, $45, $4C, $52, $55, $54, $45, $00, $43, $41, $4E, $4E, $45, $20, $41, $20
db $50, $45, $43, $48, $45, $00, $43, $41, $4E, $41, $20, $44, $45, $20, $50, $45
db $53, $43, $41, $52, $00, $43, $41, $4E, $4E, $41, $20, $44, $41, $20, $50, $45
db $53, $43, $41, $00, $54, $45, $4E, $54, $00, $5A, $45, $4C, $54, $00, $54, $45
db $4E, $54, $45, $00, $54, $49, $45, $4E, $44, $41, $00, $54, $45, $4E, $44, $41
db $00, $53, $4C, $45, $45, $50, $49, $4E, $47, $20, $42, $41, $47, $00, $53, $43
db $48, $4C, $41, $46, $53, $41, $43, $4B, $00, $53, $41, $43, $20, $44, $45, $20
db $43, $4F, $55, $43, $48, $41, $47, $45, $00, $53, $41, $43, $4F, $20, $50, $41
db $52, $41, $20, $44, $4F, $52, $4D, $49, $52, $00, $53, $41, $43, $43, $4F, $20
db $41, $20, $50, $45, $4C, $4F, $00, $47, $41, $53, $20, $43, $4F, $4F, $4B, $45
db $52, $00, $47, $41, $53, $4B, $4F, $43, $48, $45, $52, $00, $52, $45, $43, $48
db $41, $55, $44, $20, $41, $20, $47, $41, $5A, $00, $43, $4F, $43, $49, $4E, $49
db $4C, $4C, $41, $20, $44, $45, $20, $47, $41, $53, $00, $46, $4F, $52, $4E, $45
db $4C, $4C, $4F, $20, $41, $20, $47, $41, $53, $00, $54, $49, $50, $00, $41, $42
db $46, $41, $4C, $4C, $50, $4C, $41, $54, $5A, $00, $44, $45, $43, $48, $41, $52
db $47, $45, $20, $41, $20, $4F, $52, $44, $55, $52, $45, $53, $00, $42, $41, $53
db $55, $52, $45, $52, $4F, $00, $44, $49, $53, $43, $41, $52, $49, $43, $41, $00
db $47, $41, $53, $4F, $4C, $49, $4E, $45, $00, $42, $45, $4E, $5A, $49, $4E, $00
db $45, $53, $53, $45, $4E, $43, $45, $00, $47, $41, $53, $4F, $4C, $49, $4E, $41
db $00, $42, $45, $4E, $5A, $49, $4E, $41, $00, $44, $49, $45, $53, $45, $4C, $00
db $44, $49, $45, $53, $45, $4C, $00, $47, $41, $53, $2D, $4F, $49, $4C, $00, $44
db $49, $45, $53, $45, $4C, $00, $47, $41, $53, $4F, $4C, $49, $4F, $00, $4F, $49
db $4C, $00, $30, $4C, $00, $48, $55, $49, $4C, $45, $00, $41, $43, $45, $49, $54
db $45, $00, $4F, $4C, $49, $4F, $00, $41, $49, $52, $00, $4C, $55, $46, $54, $00
db $41, $49, $52, $00, $41, $49, $52, $45, $00, $41, $52, $49, $41, $00, $46, $49
db $4C, $4C, $49, $4E, $47, $20, $55, $50, $00, $41, $55, $46, $46, $38, $4C, $4C
db $45, $4E, $00, $46, $41, $49, $52, $45, $20, $4C, $45, $20, $50, $4C, $45, $49
db $4E, $00, $4C, $4C, $45, $4E, $41, $52, $20, $45, $4C, $20, $44, $45, $50, $4F
db $53, $49, $54, $4F, $00, $46, $41, $52, $45, $20, $49, $4C, $20, $50, $49, $45
db $4E, $4F, $00, $47, $41, $52, $41, $47, $45, $00, $47, $41, $52, $41, $47, $45
db $00, $47, $41, $52, $41, $47, $45, $00, $47, $41, $52, $41, $4A, $45, $00, $47
db $41, $52, $41, $47, $45, $00, $48, $41, $49, $52, $43, $55, $54, $00, $48, $41
db $41, $52, $53, $43, $48, $4E, $49, $54, $54, $00, $43, $4F, $55, $50, $45, $20
db $44, $45, $20, $43, $48, $45, $56, $45, $55, $58, $00, $43, $4F, $52, $54, $45
db $20, $44, $45, $20, $50, $45, $4C, $4F, $00, $54, $41, $47, $4C, $49, $4F, $20
db $44, $49, $20, $43, $41, $50, $45, $4C, $4C, $49, $00, $54, $52, $49, $4D, $00
db $53, $54, $55, $54, $5A, $45, $4E, $00, $43, $4F, $55, $50, $45, $52, $20, $4C
db $45, $53, $20, $50, $4F, $49, $4E, $54, $45, $53, $00, $52, $45, $43, $4F, $52
db $54, $41, $52, $00, $53, $50, $55, $4E, $54, $41, $52, $45, $00, $57, $41, $53
db $48, $00, $57, $41, $53, $43, $48, $45, $4E, $00, $4C, $41, $56, $45, $52, $00
db $4C, $41, $56, $41, $52, $00, $4C, $41, $56, $41, $52, $45, $00, $4D, $41, $4E
db $49, $43, $55, $52, $45, $00, $4D, $41, $4E, $49, $4B, $37, $52, $45, $00, $4D
db $41, $4E, $55, $43, $55, $52, $45, $00, $4D, $41, $4E, $49, $43, $55, $52, $41
db $00, $4D, $41, $4E, $49, $43, $55, $52, $45, $00, $4D, $41, $53, $53, $41, $47
db $45, $00, $4D, $41, $53, $53, $41, $47, $45, $00, $4D, $41, $53, $53, $41, $47
db $45, $00, $4D, $41, $53, $41, $4A, $45, $00, $4D, $41, $53, $53, $41, $47, $47
db $49, $4F, $00, $50, $45, $44, $49, $43, $55, $52, $45, $00, $50, $45, $44, $49
db $4B, $38, $52, $45, $00, $50, $45, $44, $49, $43, $55, $52, $45, $00, $50, $45
db $44, $49, $43, $55, $52, $41, $00, $50, $45, $44, $49, $43, $55, $52, $45, $00
db $50, $4F, $44, $49, $41, $54, $52, $49, $53, $54, $00, $46, $55, $33, $54, $48
db $45, $52, $41, $50, $45, $55, $54, $00, $50, $45, $44, $49, $43, $55, $52, $45
db $00, $50, $45, $44, $49, $43, $55, $52, $41, $00, $50, $45, $44, $49, $43, $55
db $52, $45, $00, $42, $41, $54, $48, $20, $54, $4F, $57, $45, $4C, $00, $42, $41
db $44, $45, $48, $41, $4E, $44, $54, $55, $43, $48, $00, $53, $45, $52, $56, $49
db $45, $54, $54, $45, $20, $44, $45, $20, $42, $41, $49, $4E, $00, $54, $4F, $41
db $4C, $4C, $41, $20, $44, $45, $20, $42, $41, $4E, $4F, $00, $41, $53, $43, $49
db $55, $47, $41, $4D, $41, $4E, $4F, $00, $43, $41, $52, $00, $50, $45, $52, $53
db $4F, $4E, $45, $4E, $57, $41, $47, $45, $4E, $00, $56, $4F, $49, $54, $55, $52
db $45, $00, $43, $4F, $43, $48, $45, $00, $4D, $41, $43, $43, $48, $49, $4E, $41
db $2F, $41, $55, $54, $4F, $00, $56, $41, $4E, $00, $4C, $49, $45, $46, $45, $52
db $57, $41, $47, $45, $4E, $00, $43, $41, $4D, $49, $4F, $4E, $4E, $45, $54, $54
db $45, $00, $43, $41, $4D, $49, $4F, $4E, $45, $54, $41, $00, $46, $55, $52, $47
db $4F, $4E, $43, $49, $4E, $4F, $00, $43, $4F, $4E, $56, $45, $52, $54, $49, $42
db $4C, $45, $00, $43, $41, $42, $52, $49, $4F, $4C, $45, $54, $00, $43, $41, $42
db $52, $49, $4F, $4C, $45, $54, $00, $43, $4F, $43, $48, $45, $20, $44, $45, $53
db $43, $41, $50, $4F, $54, $41, $42, $4C, $45, $00, $43, $41, $42, $52, $49, $4F
db $4C, $45, $54, $00, $57, $48, $45, $45, $4C, $00, $52, $41, $44, $00, $52, $4F
db $55, $45, $00, $52, $55, $45, $44, $41, $00, $52, $55, $4F, $54, $41, $00, $49
db $47, $4E, $49, $54, $49, $4F, $4E, $00, $5A, $38, $4E, $44, $55, $4E, $47, $00
db $41, $4C, $4C, $55, $4D, $41, $47, $45, $00, $45, $4E, $43, $45, $4E, $44, $49
db $44, $4F, $00, $41, $43, $43, $45, $4E, $53, $49, $4F, $4E, $45, $00, $43, $52
db $41, $4E, $4B, $00, $4B, $55, $52, $42, $45, $4C, $57, $45, $4C, $4C, $45, $00
db $56, $49, $4C, $45, $42, $52, $45, $51, $55, $49, $4E, $00, $43, $49, $47, $55
db $45, $4E, $41, $4C, $00, $41, $4C, $42, $45, $52, $4F, $20, $41, $20, $47, $4F
db $4D, $49, $54, $49, $00, $4F, $49, $4C, $20, $50, $55, $4D, $50, $00, $30, $4C
db $50, $55, $4D, $50, $45, $00, $50, $4F, $4D, $50, $45, $20, $41, $20, $48, $55
db $49, $4C, $45, $00, $42, $4F, $4D, $42, $41, $20, $44, $45, $20, $41, $43, $45
db $49, $54, $45, $00, $50, $4F, $4D, $50, $41, $20, $44, $45, $4C, $4C, $27, $4F
db $4C, $49, $4F, $00, $43, $41, $52, $42, $55, $52, $45, $54, $4F, $52, $00, $56
db $45, $52, $47, $41, $53, $45, $52, $00, $43, $41, $52, $42, $55, $52, $41, $54
db $45, $55, $52, $00, $43, $41, $52, $42, $55, $52, $41, $44, $4F, $52, $00, $43
db $41, $52, $42, $55, $52, $41, $54, $4F, $52, $45, $00, $46, $55, $45, $4C, $20
db $50, $55, $4D, $50, $00, $42, $45, $4E, $5A, $49, $4E, $50, $55, $4D, $50, $45
db $00, $50, $4F, $4D, $50, $45, $20, $41, $20, $45, $53, $53, $45, $4E, $43, $45
db $00, $42, $4F, $4D, $42, $41, $20, $44, $45, $20, $47, $41, $53, $4F, $4C, $49
db $4E, $41, $00, $50, $4F, $4D, $50, $41, $20, $44, $45, $4C, $4C, $41, $20, $42
db $45, $4E, $5A, $49, $4E, $41, $00, $47, $45, $41, $52, $00, $47, $41, $4E, $47
db $00, $56, $49, $54, $45, $53, $53, $45, $00, $56, $45, $4C, $4F, $43, $49, $44
db $41, $44, $00, $4D, $41, $52, $43, $49, $41, $00, $43, $4C, $55, $54, $43, $48
db $00, $4B, $55, $50, $50, $4C, $55, $4E, $47, $00, $45, $4D, $42, $52, $41, $59
db $41, $47, $45, $00, $45, $4D, $42, $52, $41, $47, $55, $45, $00, $46, $52, $49
db $5A, $49, $4F, $4E, $45, $00, $52, $41, $44, $49, $41, $54, $4F, $52, $00, $4B
db $38, $48, $4C, $45, $52, $00, $52, $41, $44, $49, $41, $54, $45, $55, $52, $00
db $52, $41, $44, $49, $41, $44, $4F, $52, $00, $52, $41, $44, $49, $41, $54, $4F
db $52, $45, $00, $45, $58, $48, $41, $55, $53, $54, $00, $41, $55, $53, $50, $55
db $46, $46, $00, $45, $43, $48, $41, $50, $50, $45, $4D, $45, $4E, $54, $00, $45
db $53, $43, $41, $50, $45, $00, $53, $43, $41, $52, $49, $43, $4F, $00, $53, $54
db $45, $45, $52, $49, $4E, $47, $20, $57, $48, $45, $45, $4C, $00, $4C, $45, $4E
db $4B, $52, $41, $44, $00, $56, $4F, $4C, $41, $4E, $54, $00, $56, $4F, $4C, $41
db $4E, $54, $45, $00, $56, $4F, $4C, $41, $4E, $54, $45, $00, $42, $52, $41, $4B
db $45, $53, $00, $42, $52, $45, $4D, $53, $45, $4E, $00, $46, $52, $45, $49, $4E
db $53, $00, $46, $52, $45, $4E, $4F, $53, $00, $46, $52, $45, $4E, $49, $00, $45
db $4D, $45, $52, $47, $45, $4E, $43, $59, $20, $42, $52, $41, $4B, $45, $00, $48
db $41, $4E, $44, $42, $52, $45, $4D, $53, $45, $00, $46, $52, $45, $49, $4E, $20
db $41, $20, $4D, $41, $49, $4E, $00, $46, $52, $45, $4E, $4F, $20, $44, $45, $20
db $4D, $41, $4E, $4F, $00, $46, $52, $45, $4E, $4F, $20, $41, $20, $4D, $41, $4E
db $4F, $00, $53, $50, $41, $52, $45, $20, $54, $49, $52, $45, $00, $52, $45, $53
db $45, $52, $56, $45, $52, $41, $44, $00, $52, $4F, $55, $45, $20, $44, $45, $20
db $53, $45, $43, $4F, $55, $52, $53, $00, $52, $55, $45, $44, $41, $20, $44, $45
db $20, $52, $45, $43, $41, $4D, $42, $49, $4F, $00, $52, $55, $4F, $54, $41, $20
db $44, $49, $20, $53, $43, $4F, $52, $54, $41, $00, $54, $49, $52, $45, $00, $52
db $45, $49, $46, $45, $4E, $00, $50, $4E, $45, $55, $00, $4E, $45, $55, $4D, $41
db $54, $49, $43, $4F, $00, $47, $4F, $4D, $4D, $41, $00, $4A, $41, $43, $4B, $00
db $57, $41, $47, $45, $4E, $48, $45, $42, $45, $52, $00, $43, $52, $49, $43, $00
db $47, $41, $54, $4F, $00, $43, $52, $49, $43, $00, $50, $55, $4E, $43, $54, $55
db $52, $45, $00, $52, $45, $49, $46, $45, $4E, $50, $41, $4E, $4E, $45, $00, $43
db $52, $45, $56, $41, $49, $53, $4F, $4E, $00, $50, $49, $4E, $43, $48, $41, $5A
db $4F, $00, $46, $4F, $52, $41, $54, $55, $52, $41, $00, $41, $49, $52, $20, $50
db $52, $45, $53, $53, $55, $52, $45, $00, $4C, $55, $46, $54, $44, $52, $55, $43
db $4B, $00, $50, $52, $45, $53, $53, $49, $4F, $4E, $20, $44, $45, $20, $4C, $27
db $41, $49, $52, $00, $50, $52, $45, $53, $49, $4F, $4E, $20, $44, $45, $20, $41
db $49, $52, $45, $00, $50, $52, $45, $53, $53, $49, $4F, $4E, $45, $20, $44, $45
db $4C, $4C, $27, $41, $52, $49, $41, $00, $4C, $49, $47, $48, $54, $53, $00, $53
db $43, $48, $45, $49, $4E, $57, $45, $52, $46, $45, $52, $00, $50, $48, $41, $52
db $45, $53, $00, $46, $41, $52, $4F, $53, $00, $46, $41, $52, $49, $00, $48, $4F
db $52, $4E, $00, $48, $55, $50, $45, $00, $4B, $4C, $41, $58, $4F, $4E, $00, $42
db $4F, $43, $49, $4E, $41, $00, $43, $4C, $41, $43, $53, $4F, $4E, $00, $42, $41
db $54, $54, $45, $52, $59, $00, $42, $41, $54, $54, $45, $52, $49, $45, $00, $42
db $41, $54, $54, $45, $52, $49, $45, $00, $42, $41, $54, $45, $52, $49, $41, $00
db $42, $41, $54, $54, $45, $52, $49, $41, $00, $52, $4F, $4F, $46, $20, $52, $41
db $43, $4B, $00, $47, $45, $50, $32, $43, $4B, $54, $52, $32, $47, $45, $52, $00
db $47, $41, $4C, $45, $52, $49, $45, $00, $50, $4F, $52, $54, $41, $45, $51, $55
db $49, $50, $41, $4A, $45, $53, $00, $50, $4F, $52, $54, $41, $2D, $42, $41, $47
db $41, $47, $4C, $49, $00, $53, $50, $41, $52, $45, $20, $50, $41, $52, $54, $53
db $00, $45, $52, $53, $41, $54, $5A, $54, $45, $49, $4C, $45, $00, $50, $49, $45
db $43, $45, $53, $20, $44, $45, $20, $52, $45, $43, $48, $41, $4E, $47, $45, $00
db $50, $49, $45, $5A, $41, $53, $20, $44, $45, $20, $52, $45, $50, $55, $45, $53
db $54, $4F, $00, $50, $45, $5A, $5A, $49, $20, $44, $49, $20, $52, $49, $43, $41
db $4D, $42, $49, $4F, $00, $41, $4E, $54, $49, $46, $52, $45, $45, $5A, $45, $00
db $46, $52, $4F, $53, $54, $53, $43, $48, $55, $54, $5A, $4D, $49, $54, $54, $45
db $4C, $00, $41, $4E, $54, $49, $47, $45, $4C, $00, $41, $4E, $54, $49, $43, $4F
db $4E, $47, $45, $4C, $41, $4E, $54, $45, $00, $4C, $49, $51, $55, $49, $44, $4F
db $20, $41, $4E, $54, $49, $47, $45, $4C, $4F, $00, $46, $52, $45, $45, $57, $41
db $59, $2F, $48, $49, $47, $48, $57, $41, $59, $00, $41, $55, $54, $4F, $42, $41
db $48, $4E, $00, $56, $4F, $49, $45, $20, $52, $41, $50, $49, $44, $45, $00, $41
db $55, $54, $4F, $50, $49, $53, $54, $41, $00, $41, $55, $54, $4F, $53, $54, $52
db $41, $44, $41, $00, $54, $57, $4F, $2D, $57, $41, $59, $20, $53, $54, $52, $45
db $45, $54, $00, $46, $45, $52, $4E, $53, $54, $52, $41, $33, $45, $00, $41, $55
db $54, $4F, $52, $4F, $55, $54, $45, $00, $41, $55, $54, $4F, $50, $49, $53, $54
db $41, $00, $41, $55, $54, $4F, $53, $54, $52, $41, $44, $41, $00, $53, $43, $48
db $4F, $4F, $4C, $00, $53, $43, $48, $55, $4C, $45, $00, $45, $43, $4F, $4C, $45
db $00, $45, $53, $43, $55, $45, $4C, $41, $00, $53, $43, $55, $4F, $4C, $41, $00
db $48, $4F, $53, $50, $49, $54, $41, $4C, $00, $4B, $52, $41, $4E, $4B, $45, $4E
db $48, $41, $55, $53, $00, $48, $4F, $50, $49, $54, $41, $4C, $00, $48, $4F, $53
db $50, $49, $54, $41, $4C, $00, $4F, $53, $50, $45, $44, $41, $4C, $45, $00, $46
db $49, $52, $53, $54, $20, $41, $49, $44, $00, $45, $52, $53, $54, $45, $20, $48
db $49, $4C, $46, $45, $00, $50, $52, $45, $4D, $49, $45, $52, $53, $20, $53, $45
db $43, $4F, $55, $52, $53, $00, $50, $52, $49, $4D, $45, $52, $4F, $53, $20, $41
db $55, $58, $49, $4C, $49, $4F, $53, $00, $50, $52, $4F, $4E, $54, $4F, $20, $53
db $4F, $43, $43, $4F, $52, $53, $4F, $00, $4E, $4F, $52, $54, $48, $00, $4E, $4F
db $52, $44, $45, $4E, $00, $4E, $4F, $52, $44, $00, $4E, $4F, $52, $54, $45, $00
db $4E, $4F, $52, $44, $00, $53, $4F, $55, $54, $48, $00, $53, $38, $44, $45, $4E
db $00, $53, $55, $44, $00, $53, $55, $52, $00, $53, $55, $44, $00, $45, $41, $53
db $54, $00, $4F, $53, $54, $45, $4E, $00, $45, $53, $54, $00, $45, $53, $54, $45
db $00, $45, $53, $54, $00, $57, $45, $53, $54, $00, $57, $45, $53, $54, $45, $4E
db $00, $4F, $55, $45, $53, $54, $00, $4F, $45, $53, $54, $45, $00, $4F, $56, $45
db $53, $54, $00, $41, $55, $54, $4F, $2F, $43, $41, $52, $20, $4C, $49, $43, $45
db $4E, $53, $45, $00, $46, $38, $48, $52, $45, $52, $53, $43, $48, $45, $49, $4E
db $00, $50, $45, $52, $4D, $49, $53, $20, $44, $45, $20, $43, $4F, $4E, $44, $55
db $49, $52, $45, $00, $50, $45, $52, $4D, $49, $53, $4F, $20, $44, $45, $20, $43
db $4F, $4E, $44, $55, $43, $49, $52, $00, $50, $41, $54, $45, $4E, $54, $45, $00
db $42, $55, $53, $20, $54, $4F, $55, $52, $00, $42, $55, $53, $52, $55, $4E, $44
db $46, $41, $48, $52, $54, $00, $45, $58, $43, $55, $52, $53, $49, $4F, $4E, $20
db $45, $4E, $20, $41, $55, $54, $4F, $42, $55, $53, $00, $45, $58, $43, $55, $52
db $53, $49, $4F, $4E, $20, $45, $4E, $20, $41, $55, $54, $4F, $42, $55, $53, $00
db $47, $49, $54, $41, $20, $49, $4E, $20, $41, $55, $54, $4F, $42, $55, $53, $00
db $42, $4F, $41, $54, $20, $54, $4F, $55, $52, $00, $42, $4F, $4F, $54, $53, $46
db $41, $48, $52, $54, $45, $4E, $00, $45, $58, $43, $55, $52, $53, $49, $4F, $4E
db $20, $45, $4E, $20, $42, $41, $54, $45, $41, $55, $58, $00, $45, $58, $43, $55
db $52, $53, $49, $4F, $4E, $20, $45, $4E, $20, $42, $41, $52, $43, $4F, $00, $47
db $49, $54, $41, $20, $49, $4E, $20, $42, $41, $54, $54, $45, $4C, $4C, $4F, $00
db $54, $52, $41, $4D, $00, $53, $54, $52, $41, $33, $45, $4E, $42, $41, $48, $4E
db $00, $54, $52, $41, $4D, $57, $41, $59, $00, $54, $52, $41, $4E, $56, $49, $41
db $00, $54, $52, $41, $4D, $00, $55, $4E, $44, $45, $52, $47, $52, $4F, $55, $4E
db $44, $00, $55, $2D, $42, $41, $48, $4E, $00, $4D, $45, $54, $52, $4F, $00, $4D
db $45, $54, $52, $4F, $00, $4D, $45, $54, $52, $4F, $50, $4F, $4C, $49, $54, $41
db $4E, $41, $00, $43, $41, $52, $20, $52, $45, $4E, $54, $41, $4C, $2F, $4C, $49
db $4D, $4F, $55, $53, $49, $4E, $45, $00, $41, $55, $54, $4F, $56, $45, $52, $4D
db $49, $45, $54, $55, $4E, $47, $00, $4C, $4F, $43, $41, $54, $49, $4F, $4E, $20
db $44, $45, $20, $56, $4F, $49, $54, $55, $52, $45, $53, $00, $41, $4C, $51, $55
db $49, $4C, $45, $52, $20, $44, $45, $20, $43, $4F, $43, $48, $45, $00, $41, $55
db $54, $4F, $4E, $4F, $4C, $45, $47, $47, $49, $4F, $00, $42, $4F, $41, $54, $20
db $52, $45, $4E, $54, $41, $4C, $00, $42, $4F, $4F, $54, $53, $56, $45, $52, $4D
db $49, $45, $54, $55, $4E, $47, $00, $4C, $4F, $43, $41, $54, $49, $4F, $4E, $20
db $44, $45, $20, $42, $41, $54, $45, $41, $55, $58, $00, $41, $4C, $51, $55, $49
db $4C, $45, $52, $20, $44, $45, $20, $42, $41, $52, $43, $4F, $53, $00, $42, $41
db $52, $43, $48, $45, $20, $41, $20, $4E, $4F, $4C, $45, $47, $47, $49, $4F, $00
db $43, $48, $55, $52, $43, $48, $00, $4B, $49, $52, $43, $48, $45, $00, $45, $47
db $4C, $49, $53, $45, $00, $49, $47, $4C, $45, $53, $49, $41, $00, $43, $48, $49
db $45, $53, $41, $00, $54, $4F, $57, $4E, $20, $48, $41, $4C, $4C, $00, $52, $41
db $54, $48, $41, $55, $53, $00, $48, $4F, $54, $45, $4C, $20, $44, $45, $20, $56
db $49, $4C, $4C, $45, $00, $41, $59, $55, $4E, $54, $41, $4D, $49, $45, $4E, $54
db $4F, $00, $4D, $55, $4E, $49, $43, $49, $50, $49, $4F, $00, $45, $58, $48, $49
db $42, $49, $54, $49, $4F, $4E, $00, $41, $55, $53, $53, $54, $45, $4C, $4C, $55
db $4E, $47, $00, $45, $58, $50, $4F, $53, $49, $54, $49, $4F, $4E, $00, $45, $58
db $50, $4F, $53, $49, $43, $49, $4F, $4E, $00, $45, $53, $50, $4F, $53, $49, $5A
db $49, $4F, $4E, $45, $00, $50, $41, $52, $4B, $00, $50, $41, $52, $4B, $00, $50
db $41, $52, $43, $00, $50, $41, $52, $51, $55, $45, $00, $50, $41, $52, $43, $4F
db $00, $53, $4F, $55, $56, $45, $4E, $49, $52, $00, $52, $45, $49, $53, $45, $41
db $4E, $44, $45, $4E, $4B, $45, $4E, $00, $53, $4F, $55, $56, $45, $4E, $49, $52
db $00, $52, $45, $43, $55, $45, $52, $44, $4F, $53, $00, $53, $4F, $55, $56, $45
db $4E, $49, $52, $00, $50, $45, $44, $45, $53, $54, $52, $49, $41, $4E, $53, $00
db $46, $55, $33, $47, $32, $4E, $47, $45, $52, $00, $50, $49, $45, $54, $4F, $4E
db $53, $00, $50, $45, $41, $54, $4F, $4E, $45, $53, $00, $50, $45, $44, $4F, $4E
db $49, $00, $42, $55, $53, $20, $53, $54, $4F, $50, $00, $48, $41, $4C, $54, $45
db $53, $54, $45, $4C, $4C, $45, $00, $41, $52, $52, $45, $54, $00, $50, $41, $52
db $41, $44, $41, $00, $46, $45, $52, $4D, $41, $54, $41, $00, $50, $4F, $4C, $49
db $43, $45, $4D, $41, $4E, $00, $50, $4F, $4C, $49, $5A, $49, $53, $54, $00, $41
db $47, $45, $4E, $54, $20, $44, $45, $20, $50, $4F, $4C, $49, $43, $45, $00, $50
db $4F, $4C, $49, $43, $49, $41, $00, $50, $4F, $4C, $49, $5A, $49, $4F, $54, $54
db $4F, $00, $54, $52, $41, $46, $46, $49, $43, $20, $4C, $49, $47, $48, $54, $00
db $56, $45, $52, $4B, $45, $48, $52, $53, $41, $4D, $50, $45, $4C, $00, $46, $45
db $55, $58, $00, $53, $45, $4D, $41, $46, $4F, $52, $4F, $00, $53, $45, $4D, $41
db $46, $4F, $52, $4F, $00, $52, $4F, $41, $44, $00, $46, $41, $48, $52, $42, $41
db $48, $4E, $00, $43, $48, $41, $55, $53, $53, $45, $45, $00, $43, $41, $4C, $5A
db $41, $44, $41, $00, $53, $54, $52, $41, $44, $41, $00, $42, $49, $43, $59, $43
db $4C, $45, $20, $50, $41, $54, $48, $00, $52, $41, $44, $46, $41, $48, $52, $57
db $45, $47, $00, $50, $49, $53, $54, $45, $20, $43, $59, $43, $4C, $41, $42, $4C
db $45, $00, $50, $49, $53, $54, $41, $20, $50, $41, $52, $41, $20, $43, $49, $43
db $4C, $49, $53, $54, $41, $53, $00, $50, $49, $53, $54, $41, $20, $43, $49, $43
db $4C, $41, $42, $49, $4C, $45, $00, $53, $49, $44, $45, $57, $41, $4C, $4B, $00
db $46, $55, $33, $47, $31, $4E, $47, $45, $52, $5A, $4F, $4E, $45, $00, $52, $55
db $45, $20, $50, $49, $45, $54, $4F, $4E, $4E, $45, $00, $43, $41, $4C, $4C, $45
db $20, $50, $45, $41, $54, $4F, $4E, $41, $4C, $00, $53, $54, $52, $41, $44, $41
db $20, $50, $45, $44, $4F, $4E, $41, $4C, $45, $00, $41, $54, $48, $4C, $45, $54
db $49, $43, $53, $00, $4C, $45, $49, $43, $48, $54, $41, $54, $48, $4C, $45, $54
db $49, $4B, $00, $41, $54, $48, $4C, $45, $54, $49, $53, $4D, $45, $00, $41, $54
db $4C, $45, $54, $49, $53, $4D, $4F, $00, $41, $54, $4C, $45, $54, $49, $43, $41
db $00, $42, $4F, $58, $49, $4E, $47, $00, $42, $4F, $58, $45, $4E, $00, $42, $4F
db $58, $45, $00, $42, $4F, $58, $45, $4F, $00, $50, $55, $47, $49, $4C, $41, $54
db $4F, $00, $43, $52, $49, $43, $4B, $45, $54, $00, $4B, $52, $49, $43, $4B, $45
db $54, $00, $43, $52, $49, $43, $4B, $45, $54, $00, $43, $52, $49, $43, $4B, $45
db $54, $00, $43, $52, $49, $43, $4B, $45, $54, $00, $43, $59, $43, $4C, $49, $4E
db $47, $00, $52, $41, $44, $46, $41, $48, $52, $45, $4E, $00, $43, $59, $43, $4C
db $49, $53, $4D, $45, $00, $43, $49, $43, $4C, $49, $53, $4D, $4F, $00, $43, $49
db $43, $4C, $49, $53, $4D, $4F, $00, $46, $4F, $4F, $54, $42, $41, $4C, $4C, $00
db $46, $55, $33, $42, $41, $4C, $4C, $00, $46, $4F, $4F, $54, $42, $41, $4C, $00
db $46, $55, $54, $42, $4F, $4C, $00, $43, $41, $4C, $43, $49, $4F, $00, $52, $49
db $44, $49, $4E, $47, $00, $52, $45, $49, $54, $45, $4E, $00, $45, $51, $55, $49
db $54, $41, $54, $49, $4F, $4E, $00, $45, $51, $55, $49, $54, $41, $43, $49, $4F
db $4E, $00, $45, $51, $55, $49, $54, $41, $5A, $49, $4F, $4E, $45, $00, $53, $41
db $49, $4C, $49, $4E, $47, $00, $53, $45, $47, $45, $4C, $53, $50, $4F, $52, $54
db $00, $56, $4F, $49, $4C, $45, $00, $44, $45, $50, $4F, $52, $54, $45, $20, $44
db $45, $20, $4C, $41, $20, $56, $45, $4C, $41, $00, $56, $45, $4C, $41, $00, $53
db $4B, $41, $54, $49, $4E, $47, $00, $45, $49, $53, $4C, $41, $55, $46, $00, $50
db $41, $54, $49, $4E, $41, $47, $45, $00, $50, $41, $54, $49, $4E, $41, $4A, $45
db $00, $50, $41, $54, $54, $49, $4E, $41, $47, $47, $49, $4F, $00, $53, $4B, $49
db $49, $4E, $47, $00, $53, $43, $48, $49, $4C, $41, $55, $46, $45, $4E, $00, $53
db $4B, $49, $00, $45, $53, $51, $55, $49, $00, $53, $43, $49, $00, $53, $57, $49
db $4D, $4D, $49, $4E, $47, $00, $53, $43, $48, $57, $49, $4D, $4D, $45, $4E, $00
db $4E, $41, $54, $41, $54, $49, $4F, $4E, $00, $4E, $41, $54, $41, $43, $49, $4F
db $4E, $00, $4E, $55, $4F, $54, $4F, $00, $54, $41, $42, $4C, $45, $20, $54, $45
db $4E, $4E, $49, $53, $00, $54, $49, $53, $43, $48, $54, $45, $4E, $4E, $49, $53
db $00, $50, $49, $4E, $47, $2D, $50, $4F, $4E, $47, $00, $50, $49, $4E, $47, $2D
db $50, $4F, $4E, $47, $00, $50, $49, $4E, $47, $2D, $50, $4F, $4E, $47, $00, $56
db $4F, $4C, $4C, $45, $59, $42, $41, $4C, $4C, $00, $56, $4F, $4C, $4C, $45, $59
db $42, $41, $4C, $4C, $00, $56, $4F, $4C, $4C, $45, $59, $2D, $42, $41, $4C, $4C
db $00, $56, $4F, $4C, $49, $42, $4F, $4C, $00, $50, $41, $4C, $4C, $41, $56, $4F
db $4C, $4F, $00, $53, $54, $41, $44, $49, $55, $4D, $00, $53, $54, $41, $44, $49
db $4F, $4E, $00, $53, $54, $41, $44, $45, $00, $45, $53, $54, $41, $44, $49, $4F
db $00, $53, $54, $41, $44, $49, $4F, $00, $57, $49, $4E, $4E, $45, $52, $00, $53
db $49, $45, $47, $45, $52, $00, $56, $41, $49, $4E, $51, $55, $45, $55, $52, $00
db $47, $41, $4E, $41, $44, $4F, $52, $00, $56, $49, $4E, $43, $49, $54, $4F, $52
db $45, $00, $54, $49, $45, $00, $55, $4E, $45, $4E, $54, $53, $43, $48, $49, $45
db $44, $45, $4E, $00, $4D, $41, $54, $43, $48, $20, $4E, $55, $4C, $00, $45, $4D
db $50, $41, $54, $41, $52, $00, $50, $41, $52, $45, $47, $47, $49, $4F, $00, $47
db $4F, $41, $4C, $00, $54, $4F, $52, $00, $42, $55, $54, $00, $47, $4F, $4C, $00
db $47, $4F, $4C, $00, $50, $4F, $49, $4E, $54, $00, $50, $55, $4E, $4B, $54, $00
db $50, $4F, $49, $4E, $54, $00, $50, $55, $4E, $54, $4F, $00, $50, $55, $4E, $54
db $4F, $00, $50, $52, $49, $5A, $45, $00, $50, $52, $45, $49, $53, $00, $50, $52
db $49, $58, $00, $50, $52, $45, $4D, $49, $4F, $00, $50, $52, $45, $4D, $49, $4F
db $00, $47, $41, $4D, $45, $00, $53, $50, $49, $45, $4C, $00, $4A, $45, $55, $00
db $4A, $55, $45, $47, $4F, $00, $47, $49, $4F, $43, $4F, $00, $53, $54, $41, $52
db $54, $00, $53, $54, $41, $52, $54, $00, $44, $45, $50, $41, $52, $54, $00, $53
db $41, $4C, $49, $44, $41, $00, $50, $41, $52, $54, $45, $4E, $5A, $41, $00, $43
db $41, $4E, $4F, $45, $00, $4B, $41, $4E, $55, $00, $43, $41, $4E, $4F, $45, $00
db $43, $41, $4E, $4F, $41, $00, $43, $41, $4E, $4F, $41, $00, $4F, $41, $52, $00
db $52, $49, $45, $4D, $45, $4E, $00, $52, $41, $4D, $45, $00, $52, $45, $4D, $4F
db $00, $52, $45, $4D, $4F, $00, $4D, $4F, $54, $4F, $52, $42, $4F, $41, $54, $00
db $4D, $4F, $54, $4F, $52, $42, $4F, $4F, $54, $00, $42, $41, $54, $45, $41, $55
db $20, $41, $20, $4D, $4F, $54, $45, $55, $52, $00, $42, $4F, $54, $45, $20, $41
db $20, $4D, $4F, $54, $4F, $52, $00, $42, $41, $52, $43, $41, $20, $41, $20, $4D
db $4F, $54, $4F, $52, $45, $00, $57, $41, $54, $45, $52, $53, $4B, $49, $00, $57
db $41, $53, $53, $45, $52, $53, $43, $48, $49, $00, $53, $4B, $49, $20, $4E, $41
db $55, $54, $49, $51, $55, $45, $00, $45, $53, $51, $55, $49, $20, $41, $43, $55
db $41, $54, $49, $43, $4F, $00, $53, $43, $49, $20, $4E, $41, $55, $54, $49, $43
db $4F, $00, $53, $55, $52, $46, $42, $4F, $41, $52, $44, $00, $53, $55, $52, $46
db $42, $4F, $41, $52, $44, $00, $50, $4C, $41, $4E, $43, $48, $45, $20, $44, $45
db $20, $53, $55, $52, $46, $00, $54, $41, $42, $4C, $41, $20, $44, $45, $20, $53
db $55, $52, $46, $00, $54, $41, $56, $4F, $4C, $41, $20, $44, $41, $20, $53, $55
db $52, $46, $00, $01, $53, $18, $54, $18, $53, $18, $51, $18, $4F, $30, $56, $18
db $58, $18, $56, $0C, $56, $0C, $54, $0C, $54, $0C, $5B, $18, $4F, $18, $4F, $0C
db $4F, $0C, $51, $18, $56, $18, $53, $18, $54, $30, $FF, $01
ds 81, $00

SECTION "rom5", ROMX, BANK[$5]
; Data from 14000 to 15B4B (6988 bytes)
db $41, $64, $72, $65, $73, $73, $65, $20, $4E, $75, $6D, $6D, $65, $72, $3A, $20
db $20, $20, $20, $20, $00, $54, $65, $72, $6D, $69, $6E, $20, $4E, $75, $6D, $6D
db $65, $72, $20, $3A, $00, $45, $69, $6E, $74, $72, $61, $67, $20, $4E, $75, $6D
db $6D, $65, $72, $20, $3A, $20, $20, $20, $20, $00, $53, $75, $63, $68, $20, $41
db $6E, $6C, $67, $6E, $20, $4C, $6F, $65, $73, $20, $65, $44, $69, $74, $00, $56
db $6F, $72, $20, $20, $20, $20, $52, $75, $65, $63, $6B, $20, $20, $20, $20, $45
db $6E, $64, $65, $00, $42, $45, $4C, $2E, $20, $54, $41, $53, $54, $45, $20, $44
db $52, $55, $45, $43, $4B, $45, $4E, $00, $28, $63, $29, $20, $31, $39, $39, $32
db $00, $4D, $6F, $6E, $74, $61, $67, $75, $65, $2D, $57, $65, $73, $74, $6F, $6E
db $2E, $00, $4C, $69, $7A, $65, $6E, $7A, $69, $65, $72, $74, $00, $65, $78, $6B
db $6C, $75, $73, $69, $76, $20, $66, $75, $65, $72, $00, $20, $20, $46, $61, $62
db $74, $65, $6B, $2C, $20, $49, $6E, $63, $2E, $20, $20, $00, $56, $65, $72, $73
db $69, $6F, $6E, $20, $35, $2E, $37, $34, $00, $4C, $69, $7A, $65, $6E, $73, $69
db $65, $72, $74, $20, $64, $75, $72, $63, $68, $00, $4E, $69, $6E, $74, $65, $6E
db $64, $6F, $00, $53, $75, $63, $68, $66, $6F, $6C, $67, $65, $20, $65, $69, $6E
db $67, $65, $62, $65, $6E, $20, $20, $53, $55, $43, $48, $46, $4F, $4C, $47, $45
db $20, $45, $49, $4E, $47, $45, $42, $45, $4E, $20, $20, $20, $42, $49, $53, $20
db $45, $4E, $44, $45, $20, $41, $42, $47, $45, $53, $55, $43, $48, $54, $20, $42
db $45, $4C, $2E, $20, $54, $41, $53, $54, $45, $20, $44, $52, $55, $45, $43, $4B
db $45, $4E, $20, $00, $20, $20, $20, $20, $53, $70, $72, $61, $63, $68, $73, $75
db $63, $68, $65, $20, $20, $20, $20, $20, $20, $41, $62, $67, $65, $73, $75, $63
db $68, $74, $20, $62, $69, $73, $20, $45, $6E, $64, $65, $20, $00, $44, $61, $74
db $65, $6E, $2E, $4B, $65, $69, $6E, $20, $46, $75, $6E, $64, $2E, $20, $20, $20
db $20, $00, $42, $65, $6C, $2E, $20, $54, $61, $73, $74, $65, $20, $64, $72, $75
db $65, $63, $6B, $65, $6E, $00, $20, $20, $20, $56, $6F, $72, $20, $20, $20, $20
db $41, $75, $73, $67, $61, $6E, $67, $20, $20, $20, $00, $56, $4F, $52, $20, $41
db $55, $53, $47, $41, $4E, $47, $20, $20, $4D, $49, $4E, $49, $2D, $55, $45, $42
db $45, $52, $53, $45, $54, $5A, $45, $52, $20, $20, $20, $20, $20, $20, $20, $57
db $6F, $72, $74, $73, $75, $63, $68, $65, $20, $20, $20, $20, $20, $20, $20, $52
db $75, $62, $72, $69, $6B, $65, $6E, $20, $65, $69, $6E, $73, $65, $68, $65, $6E
db $20, $20, $20, $20, $20, $20, $20, $20, $41, $75, $73, $67, $61, $6E, $67
ds 10, $20
db $57, $45, $4C, $54, $46, $55, $4E, $4B, $54, $49, $4F, $4E, $45, $4E, $20, $20
db $20, $20, $20, $4D, $69, $6E, $69, $2D, $55, $65, $62, $65, $72, $73, $65, $74
db $7A, $65, $72, $20, $20, $20, $20, $20, $20, $20, $57, $65, $6C, $74, $61, $74
db $6C, $61, $73, $20, $20, $20, $20, $20, $20, $20, $20, $44, $41, $54, $55, $4D
db $53, $46, $55, $4E, $4B, $54, $49, $4F, $4E, $45, $4E, $20, $20, $20, $20, $20
db $20, $20, $20, $54, $65, $72, $6D, $69, $6E, $65
ds 13, $20
db $4B, $61, $6C, $65, $6E, $64, $65, $72, $20, $20, $20, $20, $20, $20, $20, $54
db $45, $4C, $45, $46, $4F, $4E, $2D, $4D, $4F, $45, $47, $4C, $49, $43, $48, $4B
db $20, $20, $20, $41, $65, $6E, $64, $65, $72, $62, $61, $72, $65, $20, $20, $4E
db $75, $6D, $6D, $65, $72, $20, $20, $20, $20, $20, $20, $43, $75, $72, $73, $6F
db $72, $66, $65, $6C, $64
ds 10, $20
db $55, $4D, $52, $45, $43, $48, $4E, $55, $4E, $47, $20, $20, $20, $20, $20, $20
db $20, $20, $49, $6E, $73, $20, $20, $4D, $65, $74, $72, $69, $73, $63, $68, $65
db $20, $20, $20, $20, $41, $75, $73, $20, $64, $65, $6D, $20, $4D, $65, $74, $72
db $69, $73, $63, $68, $65, $6E, $20, $20, $20, $4D, $4F, $45, $47, $4C, $2E, $20
db $45, $49, $4E, $54, $52, $41, $45, $47, $45, $20, $20, $20, $20, $20, $20, $20
db $44, $61, $74, $65, $6E, $62, $61, $6E, $6B
ds 11, $20
db $41, $64, $72, $65, $73, $73, $62, $75, $63, $68, $20, $20, $20, $20, $20, $44
db $61, $74, $75, $6D, $20, $20, $2F, $20, $20, $2F, $00, $5A, $65, $69, $74, $2D
db $54, $65, $72, $6D, $69, $6E, $3F, $4A, $4E, $00, $5A, $65, $69, $74, $20, $20
db $20, $3A, $00, $4D, $75, $73, $69, $6B, $61, $6C, $69, $73, $63, $68, $3F, $4A
db $4E, $00, $31, $20, $32, $20, $33, $20, $6F, $64, $65, $72, $20, $34, $20, $64
db $72, $75, $65, $63, $6B, $65, $6E, $00, $31, $20, $50, $69, $65, $70, $73, $65
db $72, $2D, $41, $6C, $61, $72, $6D, $00, $32, $20, $47, $65, $62, $75, $72, $74
db $73, $74, $61, $67, $00, $33, $20, $57, $65, $69, $68, $6E, $61, $63, $68, $74
db $65, $6E, $00, $34, $20, $50, $72, $69, $6F, $72, $69, $74, $61, $65, $74, $00
db $43, $6F, $75, $6E, $74, $64, $6F, $77, $6E, $3F, $4A, $4E, $00, $41, $6E, $7A
db $61, $68, $6C, $20, $54, $61, $67, $65, $3F, $28, $31, $2D, $37, $29, $00, $54
db $65, $72, $6D, $69, $6E, $20, $6C, $6F, $65, $73, $63, $68, $65, $6E, $3F, $4A
db $4E, $00, $56, $6F, $72, $20, $5A, $75, $72, $75, $65, $63, $6B, $20, $41, $75
db $73, $67, $61, $6E, $67, $00, $4A, $61, $6E, $75, $61, $72, $00, $46, $65, $62
db $72, $75, $61, $72, $00, $4D, $61, $65, $72, $7A, $00, $41, $70, $72, $69, $6C
db $00, $4D, $61, $69, $00, $4A, $75, $6E, $69, $00, $4A, $75, $6C, $69, $00, $41
db $75, $67, $75, $73, $74, $00, $53, $65, $70, $74, $65, $6D, $62, $65, $72, $00
db $4F, $6B, $74, $6F, $62, $65, $72, $00, $4E, $6F, $76, $65, $6D, $62, $65, $72
db $00, $44, $65, $7A, $65, $6D, $62, $65, $72, $00, $2E, $20, $2E, $20, $2E, $20
db $2E, $20, $4B, $65, $69, $6E, $20, $43, $6F, $75, $6E, $74, $64, $6F, $77, $6E
db $00, $43, $6F, $75, $6E, $74, $64, $6F, $77, $6E, $3A, $00, $31, $20, $54, $61
db $67, $00, $54, $61, $67, $65, $00, $4B, $65, $69, $6E, $20, $41, $6C, $61, $72
db $6D, $2E, $00, $50, $69, $65, $70, $73, $65, $72, $2D, $41, $6C, $61, $72, $6D
db $2E, $00, $47, $65, $62, $75, $72, $74, $73, $74, $61, $67, $73, $2D, $41, $6C
db $61, $72, $6D, $2E, $00, $57, $65, $69, $68, $6E, $61, $63, $68, $74, $73, $2D
db $41, $6C, $61, $72, $6D, $2E, $00, $50, $72, $69, $6F, $72, $69, $74, $61, $65
db $74, $73, $2D, $41, $6C, $61, $72, $6D, $2E, $00, $20, $20, $46, $45, $48, $4C
db $45, $52
ds 11, $20
db $41, $75, $74, $6F
ds 10, $20
db $42, $61, $6E, $6B, $65, $6E, $2F, $46, $69, $6E, $61, $6E, $7A, $65, $6E, $20
db $20, $20, $20, $20, $53, $63, $68, $6F, $65, $6E, $68, $2E, $2F, $47, $65, $73
db $75, $6E, $64, $68, $20, $20, $20, $20, $20, $4B, $6F, $6D, $6D, $75, $6E, $69
db $6B, $61, $74, $69, $6F, $6E, $20, $20, $20, $20, $20, $20, $20, $54, $65, $72
db $6D, $69, $6E, $65, $2F, $57, $65, $74, $74, $65, $72, $20, $20, $20, $20, $20
db $20, $20, $55, $6E, $74, $65, $72, $68, $61, $6C, $74, $75, $6E, $67, $20, $20
db $20, $20, $20, $20, $41, $6C, $6C, $67, $65, $6D, $65, $69, $6E, $2F, $47, $72
db $75, $65, $73, $73, $65, $20, $20, $20, $20, $20, $20, $20, $48, $6F, $74, $65
db $6C
ds 13, $20
db $41, $72, $7A, $74, $2F, $4E, $6F, $74, $66, $61, $6C, $6C, $20, $20, $20, $20
db $20, $20, $52, $65, $73, $74, $61, $75, $72, $61, $6E, $74, $73, $2F, $45, $73
db $73, $65, $6E, $20, $45, $69, $6E, $6B, $61, $75, $66, $2F, $50, $65, $72, $73
db $6F, $65, $6E, $6C, $69, $63, $68, $20, $20, $20, $20, $42, $65, $73, $69, $63
db $68, $74, $69, $67, $75, $6E, $67, $65, $6E
ds 9, $20
db $53, $70, $6F, $72, $74
ds 16, $20
db $52, $65, $69, $73, $65, $20, $20, $20, $20, $20, $20, $20, $20, $56, $4F, $52
db $20, $20, $5A, $55, $52, $55, $45, $43, $4B, $20, $57, $41, $45, $48, $4C, $45
db $4E, $00, $55, $68, $72, $20, $41, $6E, $73, $65, $68, $65, $6E, $00, $5A, $65
db $69, $74, $20, $45, $69, $6E, $73, $74, $65, $6C, $6C, $65, $6E, $00, $41, $6C
db $61, $72, $6D, $20, $45, $69, $6E, $73, $74, $65, $6C, $6C, $65, $6E, $00, $41
db $6C, $61, $72, $6D, $20, $4C, $6F, $65, $73, $63, $68, $65, $6E, $00, $3A, $20
db $20, $3A, $00, $41, $6C, $61, $72, $6D, $20, $20, $20, $3A, $00, $20, $20, $20
db $44, $61, $74, $75, $6D, $20, $45, $69, $6E, $73, $65, $68, $65, $6E, $20, $20
db $20, $20, $20, $44, $61, $74, $75, $6D, $20, $45, $69, $6E, $73, $74, $65, $6C
db $6C, $65, $6E, $20, $20, $20, $20, $42, $45, $54, $52, $41, $47, $20, $20, $45
db $49, $4E, $47, $45, $42, $45, $4E, $20, $20, $45, $49, $4E, $45, $20, $54, $41
db $53, $54, $45, $20, $44, $52, $55, $45, $43, $4B, $2E, $00, $5A, $6F, $6C, $6C
db $20, $69, $6E, $20, $63, $6D, $00, $46, $75, $42, $20, $69, $6E, $20, $4D, $65
db $74, $65, $72, $00, $59, $61, $72, $64, $20, $69, $6E, $20, $4D, $65, $74, $65
db $72, $00, $4D, $65, $69, $6C, $65, $6E, $20, $69, $6E, $20, $4B, $69, $6C, $6F
db $6D, $65, $74, $65, $72, $00, $41, $63, $72, $65, $20, $69, $6E, $20, $48, $65
db $6B, $74, $61, $72, $00, $46, $6C, $75, $69, $64, $20, $4F, $75, $6E, $63, $65
db $20, $69, $6E, $20, $4C, $69, $74, $65, $72, $00, $51, $75, $61, $72, $74, $20
db $69, $6E, $20, $4C, $69, $74, $65, $72, $00, $55, $53, $20, $47, $61, $6C, $6C
db $6F, $6E, $65, $20, $69, $6E, $20, $4C, $69, $74, $65, $72, $00, $47, $61, $6C
db $6C, $6F, $6E, $65, $20, $69, $6E, $20, $4C, $69, $74, $65, $72, $00, $55, $6E
db $7A, $65, $20, $69, $6E, $20, $47, $72, $61, $6D, $6D, $00, $50, $66, $75, $6E
db $64, $20, $69, $6E, $20, $4B, $69, $6C, $6F, $67, $72, $61, $6D, $6D, $00, $54
db $6F, $6E, $6E, $65, $20, $69, $6E, $20, $4D, $65, $74, $72, $2E, $20, $54, $6F
db $6E, $6E, $65, $00, $43, $6D, $20, $69, $6E, $20, $5A, $6F, $6C, $6C, $00, $4D
db $65, $74, $65, $72, $20, $69, $6E, $20, $46, $75, $42, $00, $4D, $65, $74, $65
db $72, $20, $69, $6E, $20, $59, $61, $72, $64, $00, $4B, $69, $6C, $6F, $6D, $65
db $74, $65, $72, $20, $69, $6E, $20, $4D, $65, $69, $6C, $65, $6E, $00, $48, $65
db $6B, $74, $61, $72, $20, $69, $6E, $20, $41, $63, $72, $65, $00, $4C, $69, $74
db $65, $72, $20, $69, $6E, $20, $46, $6C, $75, $69, $64, $20, $4F, $75, $6E, $63
db $65, $00, $4C, $69, $74, $65, $72, $20, $69, $6E, $20, $51, $75, $61, $72, $74
db $00, $4C, $69, $74, $65, $72, $20, $69, $6E, $20, $55, $53, $20, $47, $61, $6C
db $6C, $6F, $6E, $65, $00, $4C, $69, $74, $65, $72, $20, $69, $6E, $20, $47, $61
db $6C, $6C, $6F, $6E, $65, $00, $47, $72, $61, $6D, $6D, $20, $69, $6E, $20, $55
db $6E, $7A, $65, $00, $4B, $69, $6C, $6F, $67, $72, $61, $6D, $6D, $20, $69, $6E
db $20, $50, $66, $75, $6E, $64, $00, $54, $6F, $6E, $6E, $65, $20, $69, $6E, $20
db $4D, $65, $74, $72, $2E, $20, $54, $6F, $6E, $6E, $65, $00, $4B, $65, $69, $6E
db $20, $50, $61, $73, $73, $65, $6E, $64, $65, $72, $20, $46, $75, $6E, $64, $20
db $00, $20, $42, $65, $6C, $2E, $20, $54, $61, $73, $74, $65, $20, $2D, $20, $46
db $6F, $72, $74, $73, $2E, $00, $84, $98, $44, $65, $75, $74, $73, $63, $68, $65
db $20, $4D, $61, $72, $6B, $73, $00, $C6, $98, $44, $6F, $6C, $6C, $61, $72, $00
db $07, $99, $46, $72, $61, $6E, $63, $00, $48, $99, $4C, $69, $72, $61, $00, $86
db $99, $50, $65, $73, $65, $74, $61, $00, $C7, $99, $50, $66, $75, $6E, $64, $00
db $08, $9A, $59, $65, $6E, $00, $10, $20, $20, $20, $44, $65, $75, $74, $73, $63
db $68, $65, $20, $20, $4D, $61, $72, $6B, $20, $20, $20, $08, $20, $20, $20, $20
db $20, $20, $20, $44, $6F, $6C, $6C, $61, $72, $20, $20, $20, $20, $20, $20, $20
db $07, $20, $20, $20, $20, $20, $20, $20, $46, $72, $61, $6E, $63, $20, $20, $20
db $20, $20, $20, $20, $20, $06, $20, $20, $20, $20, $20, $20, $20, $20, $4C, $69
db $72, $61, $20, $20, $20, $20, $20, $20, $20, $20, $08, $20, $20, $20, $20, $20
db $20, $20, $50, $65, $73, $65, $74, $61, $20, $20, $20, $20, $20, $20, $20, $07
db $20, $20, $20, $20, $20, $20, $20, $50, $66, $75, $6E, $64, $20, $20, $20, $20
db $20, $20, $20, $20, $05, $20, $20, $20, $20, $20, $20, $20, $20, $59, $65, $6E
ds 9, $20
db $04, $44, $65, $75, $74, $73, $63, $68, $65, $20, $4D, $61, $72, $6B, $00, $06
db $44, $6F, $6C, $6C, $61, $72, $00, $07, $46, $72, $61, $6E, $63, $00, $08, $4C
db $69, $72, $61, $00, $06, $50, $65, $73, $65, $74, $61, $00, $07, $50, $66, $75
db $6E, $64, $00, $08, $59, $65, $6E, $00, $55, $4D, $52, $45, $43, $48, $4E, $45
db $4E, $20, $56, $4F, $4E, $00, $55, $4D, $52, $45, $43, $48, $4E, $45, $4E, $20
db $49, $4E, $00, $20, $20, $42, $45, $54, $52, $41, $47, $20, $20, $45, $49, $4E
db $47, $45, $42, $45, $4E, $20, $20, $20, $20, $57, $45, $43, $48, $53, $45, $4C
db $4B, $55, $52, $53, $20, $45, $49, $4E, $47, $20, $20, $42, $45, $54, $52, $2E
db $20, $47, $45, $4E, $41, $4E, $4E, $54, $20, $49, $4E, $00, $20, $20, $20, $20
db $53, $54, $45, $55, $45, $52, $4D, $45, $4E, $55, $45, $20, $20, $20, $20, $20
db $20, $41, $4C, $4C, $45, $20, $20, $45, $49, $4E, $54, $2E, $20, $4C, $4F, $45
db $53, $43, $48, $20, $20, $20, $20, $5A, $55, $52, $55, $45, $43, $4B, $53, $54
db $45, $4C, $4C, $45, $4E, $20, $20, $20, $4A, $20, $44, $52, $55, $45, $43, $4B
db $2E, $20, $42, $45, $53, $54, $41, $45, $54, $00, $42, $45, $4C, $20, $41, $4E
db $44, $2E, $20, $54, $41, $53, $54, $45, $2D, $41, $55, $53, $00, $20, $4B, $4F
db $4E, $54, $4F, $53, $54, $41, $4E, $44, $20, $20, $4E, $45, $4E, $4E, $45, $4E
db $20, $20, $20, $20, $49, $53, $54, $2D, $4B, $4F, $4E, $54, $4F, $53, $54, $41
db $4E, $44, $20, $20, $20, $20, $45, $49, $4E, $54, $52, $41, $45, $47, $45, $20
db $45, $49, $4E, $53, $45, $48, $45, $4E, $20, $20, $20, $45, $49, $4E, $54, $52
db $41, $47, $20, $45, $49, $4E, $47, $45, $42, $45, $4E, $20, $20, $4B, $45, $49
db $4E, $45, $20, $45, $49, $4E, $54, $52, $41, $45, $47, $45, $00
ds 15, $20
db $00, $45, $49, $4E, $54, $52, $41, $45, $47, $45, $20, $45, $49, $4E, $53, $45
db $48, $45, $4E, $00, $20, $20, $20, $44, $41, $54, $55, $4D, $20, $45, $49, $4E
db $47, $45, $42, $45, $4E, $20, $20, $20, $2F, $20, $20, $2F, $00, $42, $45, $54
db $52, $41, $47, $20, $20, $45, $49, $4E, $47, $45, $42, $45, $4E, $00, $48, $41
db $42, $45, $4E, $20, $4F, $44, $45, $52, $20, $53, $4F, $4C, $4C, $20, $00, $20
db $20, $20, $20, $20, $20, $20, $48, $41, $42, $45, $4E
ds 16, $20
db $53, $4F, $4C, $4C
ds 9, $20
db $53, $4F, $4C, $4C, $00, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $00, $42, $45
db $53, $43, $48, $52, $2E, $20, $45, $49, $4E, $47, $45, $42, $45, $4E, $00, $8C
db $56, $6F, $72, $8C, $5A, $75, $72, $75, $65, $63, $6B, $8C, $45, $6E, $64, $65
db $8C, $00, $20, $20, $45, $69, $6E, $74, $72, $2E, $20, $4E, $75, $6D, $6D, $65
db $72, $20, $78, $78, $4E, $61, $6D, $65, $20, $75, $6E, $64, $20, $41, $64, $72
db $65, $73, $73, $65, $00, $54, $65, $6C, $65, $66, $6F, $6E, $6E, $75, $6D, $6D
db $65, $72, $00, $5A, $75, $20, $77, $61, $65, $68, $6C, $65, $6E, $64, $65, $20
db $4E, $75, $6D, $6D, $65, $72, $00, $20, $20, $4E, $75, $6D, $6D, $65, $72, $20
db $65, $69, $6E, $74, $69, $70, $70, $65, $6E, $20, $20, $4E, $75, $6D, $6D, $65
db $72, $20, $77, $61, $65, $68, $6C, $74, $20, $6E, $75, $6E, $00, $20, $20, $45
db $53, $43, $41, $50, $45, $20, $2D, $20, $41, $55, $53, $47, $41, $4E, $47, $20
db $20, $42, $45, $4C, $2E, $20, $54, $41, $53, $54, $45, $20, $44, $52, $55, $45
db $43, $4B, $2E, $00, $45, $6E, $67, $6C, $69, $73, $63, $68, $00, $44, $65, $75
db $74, $73, $63, $68, $00, $46, $72, $61, $6E, $7A, $6F, $65, $73, $69, $73, $63
db $68, $00, $53, $70, $61, $6E, $69, $73, $63, $68, $00, $49, $74, $61, $6C, $69
db $65, $6E, $69, $73, $63, $68, $00, $20, $4A, $41, $4E, $55, $41, $52, $20, $20
db $1F, $20, $46, $45, $42, $52, $55, $41, $52, $20, $1C, $20, $20, $4D, $41, $45
db $52, $5A, $20, $20, $1F, $20, $20, $41, $50, $52, $49, $4C, $20, $20, $1E, $20
db $20, $20, $4D, $41, $49, $20, $20, $20, $1F, $20, $20, $20, $4A, $55, $4E, $49
db $20, $20, $1E, $20, $20, $20, $4A, $55, $4C, $49, $20, $20, $1F, $20, $20, $41
db $55, $47, $55, $53, $54, $20, $1F, $53, $45, $50, $54, $45, $4D, $42, $45, $52
db $1E, $20, $4F, $4B, $54, $4F, $42, $45, $52, $20, $1F, $20, $4E, $4F, $56, $45
db $4D, $42, $45, $52, $1E, $20, $44, $45, $5A, $45, $4D, $42, $45, $52, $1F, $53
db $4F, $4E, $4D, $4F, $4E, $44, $49, $45, $4D, $49, $54, $44, $4F, $4E, $46, $52
db $45, $53, $41, $4D, $53, $4F, $4E, $20, $20, $42, $3D, $57, $65, $69, $74, $65
db $72, $20, $20, $41, $3D, $45, $78, $69, $74, $20, $20, $00, $20, $20, $20, $53
db $65, $6C, $65, $63, $74, $3D, $56, $6F, $72, $68, $65, $72, $20, $20, $20, $20
db $00, $65, $72, $53, $74, $65, $6C, $6C, $65, $20, $4C, $6F, $73, $63, $68, $65
db $20, $65, $44, $69, $74, $00, $20, $20, $4D, $49, $54, $20, $4A, $20, $42, $45
db $53, $54, $41, $54, $49, $47, $45, $4E, $20, $20, $00, $41, $4E, $44, $2E, $20
db $54, $41, $53, $54, $45, $4E, $3D, $41, $42, $42, $52, $55, $43, $48, $20, $00
db $2A, $20, $20, $54, $45, $52, $4D, $49, $4E, $45, $20, $50, $52, $55, $46, $45
db $4E, $20, $20, $2A, $00, $20, $20, $20, $53, $50, $52, $41, $43, $48, $45, $20
db $57, $41, $48, $4C, $45, $4E, $20, $20, $20, $20, $20, $53, $49, $43, $48, $45
db $52, $55, $4E, $47, $53, $4F, $50, $54, $49, $4F, $4E, $20, $20, $20, $20, $20
db $20, $41, $55, $46, $20, $50, $43, $20, $4C, $41, $44, $45, $4E, $20, $20, $20
db $20, $20, $20, $56, $4F, $4D, $20, $50, $43, $20, $48, $4F, $43, $48, $4C, $41
db $44, $45, $4E, $20, $20, $20, $20, $20, $20, $20, $53, $54, $45, $55, $45, $52
db $4D, $45, $4E, $55
ds 10, $20
db $41, $44, $52, $45, $53, $53, $42, $55, $43, $48
ds 11, $20
db $54, $45, $52, $4D, $49, $4E, $45
ds 10, $20
db $54, $41, $53, $43, $48, $45, $4E, $52, $45, $43, $48, $4E, $45, $52, $20, $20
db $20, $20, $20, $20, $20, $20, $44, $41, $54, $45, $4E, $42, $41, $4E, $4B, $20
db $20, $20, $20, $20, $20, $53, $75, $63, $68, $65, $6E, $20, $62, $69, $73, $20
db $44, $61, $74, $65, $6E, $65, $6E, $64, $65, $00, $20, $20, $20, $54, $61, $73
db $74, $65, $20, $20, $64, $72, $75, $63, $6B, $65, $6E, $20, $20, $20, $00, $20
db $20, $20, $20, $53, $55, $43, $48, $4F, $50, $54, $49, $4F, $4E, $45, $4E, $20
db $20, $20, $20, $20, $20, $47, $4C, $4F, $42, $41, $4C, $45, $53, $20, $20, $53
db $55, $43, $48, $45, $4E, $20, $20, $20, $20, $20, $53, $50, $45, $5A, $49, $46
db $2E, $20, $53, $55, $43, $48, $45, $4E, $20, $20, $20, $5A, $65, $69, $74, $2F
db $44, $61, $74, $75, $6D, $20, $66, $61, $6C, $73, $63, $68, $00, $42, $61, $74
db $74, $65, $72, $69, $65, $6E, $20, $53, $63, $68, $77, $61, $63, $68, $3F, $00
db $20, $20, $20, $20, $20, $20, $57, $41, $48, $52, $55, $4E, $47
ds 12, $20
db $53, $48, $45, $43, $4B, $42, $55, $43, $48, $20, $20, $20, $20, $20, $20, $52
db $4E, $43, $02, $00, $00, $14, $8F, $00, $00, $0C, $DE, $0D, $DE, $52, $ED, $04
db $01, $0B, $2A, $41, $86, $52, $47, $45, $4E, $54, $49, $4E, $41, $30, $34, $39
db $31, $03, $B8, $60, $5A, $2D, $33, $00, $30, $30, $00, $35, $34, $00, $42, $55
db $17, $4F, $53, $20, $41, $02, $49, $52, $45, $53, $31, $20, $4E, $1D, $60, $1C
db $30, $55, $53, $54, $52, $01, $41, $4C, $49, $41, $31, $33, $38, $99, $12, $37
db $06, $30, $C0, $30, $31, $31, $00, $36, $D7, $02, $0D, $42, $52, $49, $53, $42
db $41, $4E, $45, $37, $20, $31, $34, $12, $CC, $14, $1A, $43, $C3, $0E, $42, $45
db $52, $09, $2F, $36, $32, $20, $38, $2F, $13, $4D, $03, $45, $4C, $42, $4F, $55
db $52, $39, $27, $33, $13, $CE, $10, $18, $16, $00, $50, $24, $54, $48, $63, $39
db $0F, $32, $34, $01, $0C, $32, $38, $00, $53, $59, $44, $90, $1E, $59, $33, $E3
db $76, $36, $92, $1F, $6C, $76, $74, $40, $38, $08, $30, $35, $30, $5A, $18, $73
db $00, $34, $8D, $56, $49, $DB, $A4, $BA, $87, $9E, $37, $39, $39, $16, $26, $81
db $6C, $4C, $47, $49, $55, $4D, $B1, $0F, $0D, $34, $35, $20, $26, $33, $32, $00
db $C6, $84, $54, $57, $60, $12, $50, $33, $20, $39, $17, $30, $A9, $98, $4E, $53
db $2A, $53, $32, $E2, $11, $36, $99, $11, $39, $4F, $9C, $D3, $56, $60, $C0, $55
db $30, $39, $33, $5A, $2D, $56, $34, $06, $C0, $7D, $00, $4C, $41, $20, $50, $39
db $41, $5A, $28, $4E, $18, $6C, $17, $29, $CE, $5A, $37, $49, $4C, $6F, $16, $0F
db $35, $C6, $2F, $35, $00, $9C, $03, $4F, $20, $44, $45, $20, $4A, $81, $FF, $49
db $52, $4F, $32, $CA, $93, $46, $20, $32, $32, $42, $55, $94, $41, $07, $BC, $38
db $32, $0A, $14, $5A, $31, $6C, $95, $5B, $E5, $4F, $6E, $46, $14, $53, $59, $16
db $3B, $15, $2A, $19, $2C, $41, $44, $25, $33, $C0, $0E, $31, $42, $2D, $36, $46
db $00, $56, $C7, $01, $41, $4C, $60, $41, $54, $41, $34, $30, $E3, $BE, $32, $04
db $52, $34, $38, $2D, $37, $60, $69, $54, $49, $53, $48, $30, $20, $43, $B4, $4F
db $4D, $42, $DC, $44, $C3, $CE, $1C, $31, $C0, $1A, $34, $2D, $38, $00, $43, $6C
db $48, $6C, $16, $54, $00, $54, $45, $54, $4F, $57, $4E, $39, $30, $87, $BA, $67
db $BB, $37, $01, $BA, $45, $44, $4D, $4F, $4E, $9E, $15, $4E, $05, $4B, $36, $46
db $52, $16, $60, $38, $49, $43, $17, $35, $31, $30, $36, $17, $33, $38, $23, $2C
db $48, $B0, $E4, $46, $41, $58, $A1, $40, $33, $39, $0C, $2B, $13, $4D, $D8, $A1
db $78, $4F, $42, $D0, $B4, $6F, $46, $32, $4C, $E4, $A6, $36, $53, $43, $2D, $DC
db $B4, $14, $3A, $33, $34, $00, $2A, $2D, $35, $00, $4E, $45, $57, $76, $20, $65
db $19, $4E, $53, $57, $59, $4B, $EE, $05, $57, $18, $19, $46, $4F, $18, $44, $4C
db $C1, $4B, $44, $37, $30, $39, $E0, $03, $18, $4F, $56, $41, $20, $6C, $53, $D2
db $D9, $41, $F0, $05, $74, $51, $55, $45, $1B, $42, $45, $43, $EB, $33, $79, $59
db $C8, $38, $88, $17, $35, $6C, $17, $77, $73, $47, $E8, $B7, $40, $33, $5B, $32
db $36, $ED, $FE, $C0, $75, $53, $41, $53, $4B, $0D, $41, $54, $43, $48, $62, $BC
db $5C, $06, $18, $54, $0D, $20, $4A, $4F, $48, $8D, $E1, $03, $70, $33, $78, $00
db $91, $CA, $52, $B4, $0F, $55, $23, $9E, $71, $75, $29, $56, $19, $09, $52, $F8
db $07, $52, $57, $48, $C3, $7C, $45, $20, $48, $1D, $17, $53, $45, $14, $06, $17
db $21, $34, $35, $17, $86, $80, $4E, $49, $50, $87, $9E, $0F, $83, $6B, $36, $B6
db $C7, $2D, $3B, $4C, $45, $0B, $74, $31, $30, $35, $43, $48, $36, $9D, $9A, $22
db $66, $41, $47, $4F, $B7, $8E, $22, $19, $39, $49, $28, $D0, $BD, $32, $E6, $0D
db $D0, $1C, $00, $00, $38, $24, $66, $48, $25, $47, $03, $74, $49, $3B, $3E, $31
db $1B, $9F, $35, $39, $16, $19, $FA, $49, $4A, $25, $47, $09, $10, $30, $27, $35
db $49, $53, $30, $76, $38, $1B, $08, $33, $4D, $33, $00, $97, $3B, $37, $6E, $81
db $CE, $36, $57, $84, $6D, $20, $9D, $18, $16, $73, $8D, $19, $0D, $9D, $7E, $37
db $39, $D6, $D8, $39, $CE, $86, $86, $39, $4F, $82, $44, $54, $C1, $31, $17, $38
db $CC, $16, $29, $59, $74, $50, $D4, $0D, $2D, $84, $36, $18, $9B, $27, $4C, $49
db $07, $4D, $41, $53, $53, $4F, $69, $D4, $42, $9F, $36, $20, $9F, $5A, $45, $D9
db $B1, $6A, $4C, $D9, $A7, $4B, $10, $CD, $30, $ED, $87, $39, $8A, $36, $32, $00
db $44, $DC, $22, $55, $45, $21, $CD, $16, $D2, $50, $44, $31, $45, $4E, $42, $52
db $4B, $13, $B1, $88, $1E, $43, $2D, $37, $59, $39, $28, $0C, $70, $45, $47, $71
db $54, $A9, $B1, $C8, $3D, $32, $6E, $3D, $5E, $83, $E4, $45, $58, $A3, $0F, $B2
db $77, $33, $53, $CC, $BA, $73, $B1, $3B, $28, $48, $20, $A9, $1F, $35, $39, $82
db $0E, $2A, $46, $49, $4E, $23, $33, $74, $0F, $38, $BE, $37, $39, $39, $40, $39
db $AA, $38, $00, $74, $48, $ED, $C8, $1A, $91, $DA, $97, $90, $1A, $2A, $C3, $8C
db $4E, $43, $45, $74, $48, $1D, $E2, $36, $44, $2E, $44, $39, $8E, $B9, $C6, $BB
db $49, $4C, $66, $41, $33, $60, $33, $15, $CF, $DD, $B2, $2C, $94, $53, $0F, $31
db $92, $10, $03, $E1, $47, $45, $52, $A0, $E2, $59, $20, $6A, $45, $FB, $0E, $A1
db $34, $33, $45, $37, $B7, $36, $66, $6C, $38, $1A, $4C, $D4, $65, $19, $24, $32
db $20, $1B, $F1, $03, $30, $57, $45, $07, $30, $37, $42, $15, $45, $B6, $42, $5E
db $B2, $30, $11, $19, $10, $32, $1C, $E0, $31, $42, $4F, $4E, $09, $4E, $32, $32
db $38, $04, $0F, $35, $31, $00, $00, $A9, $4B, $46, $55, $52, $54, $36, $78, $39
db $01, $13, $48, $41, $31, $4D, $42, $11, $47, $34, $05, $35, $38, $00, $35, $4D
db $55, $4E, $49, $43, $48, $24, $38, $39, $10, $43, $37, $78, $A4, $71, $54, $20
db $8A, $B4, $07, $41, $64, $5C, $56, $34, $34, $76, $4B, $8A, $E8, $0E, $75, $34
db $D9, $BB, $49, $95, $49, $10, $48, $4D, $8A, $C3, $87, $1C, $30, $81, $00, $FA
db $45, $44, $53, $21, $35, $33, $BC, $D1, $AE, $D9, $73, $4C, $99, $8A, $44, $02
db $20, $D1, $C2, $93, $A9, $37, $3C, $27, $34, $01, $16, $4F, $33, $55, $54, $16
db $38, $DC, $02, $16, $E6, $E9, $57, $71, $53, $14, $36, $37, $14, $20, $42, $86
db $45, $ED, $68, $19, $A2, $34, $2D, $CC, $CD, $69, $98, $91, $28, $4E, $DA, $34
db $76, $16, $8E, $61, $48, $4F, $47, $20, $4B, $C8, $04, $80, $C3, $36, $35, $5A
db $38, $8E, $8D, $32, $00, $38, $35, $1A, $E2, $01, $19, $35, $20, $4D, $1B, $1A
db $9B, $0D, $57, $82, $77, $11, $75, $1C, $60, $36, $10, $3E, $FD, $EB, $B7, $3F
db $59, $4E, $4A, $11, $31, $70, $A2, $36, $EE, $8E, $A0, $44, $41, $50, $42, $90
db $67, $1D, $18, $9A, $14, $49, $8A, $A0, $21, $36, $32, $EA, $BA, $87, $5A, $2A
db $72, $1D, $21, $34, $50, $29, $59, $4B, $4A, $41, $1C, $56, $49, $4B, $2B, $A2
db $1B, $2D, $1B, $2C, $28, $BA, $C4, $30, $EA, $84, $26, $38, $5A, $35, $78, $11
db $54, $39, $81, $9E, $4D, $42, $41, $59, $32, $DD, $79, $A7, $18, $00, $17, $43
db $41, $4C, $43, $55, $54, $3A, $54, $41, $3B, $37, $B9, $AA, $13, $37, $C8, $13
db $A8, $DC, $44, $45, $48, $1D, $4C, $49, $31, $3D, $96, $3B, $F4, $53, $9B, $14
db $50, $B0, $CA, $30, $39, $32, $88, $D6, $49, $33, $4F, $9B, $BB, $54, $25, $91
db $15, $A8, $85, $18, $33, $51, $58, $26, $51, $BA, $48, $A5, $58, $39, $5A, $74
db $3B, $39, $36, $EC, $B0, $41, $32, $47, $48, $CD, $44, $10, $CA, $18, $42, $33
db $25, $6E, $CA, $87, $68, $32, $4B, $64, $31, $A1, $84, $35, $87, $17, $44, $55
db $42, $44, $54, $12, $C6, $39, $C6, $80, $49, $53, $4E, $DB, $29, $36, $12, $84
db $35, $37, $CE, $80, $39, $9C, $00, $76, $4C, $71, $20, $EF, $56, $D1, $EB, $4E
db $19, $DD, $83, $04, $28, $4C, $59, $74, $FF, $35, $31, $4B, $46, $74, $42, $B9
db $14, $49, $63, $10, $10, $34, $E6, $C4, $14, $02, $4E, $41, $50, $4C, $45, $53
db $B7, $F3, $5F, $36, $00, $B4, $00, $52, $4F, $4D, $45, $36, $20, $93, $34, $1D
db $0D, $56, $45, $02, $84, $45, $34, $31, $4E, $10, $1B, $2F, $2A, $4A, $30, $22
db $3F, $31, $E2, $39, $34, $47, $39, $5B, $D3, $A3, $BD, $A4, $B5, $53, $48, $EA
db $BB, $3E, $38, $3A, $45, $32, $7A, $CA, $40, $0B, $4B, $59, $4F, $54, $4F, $37
db $EC, $E3, $33, $CE, $24, $35, $EE, $F9, $0C, $E4, $11, $7D, $FE, $32, $43, $1E
db $2A, $4B, $10, $5A, $59, $41, $FB, $D5, $01, $BA, $14, $BD, $13, $91, $B6, $4E
db $50, $00, $42, $49, $32, $20, $93, $19, $B1, $15, $4B, $4F, $D0, $F6, $31, $8B
db $93, $D4, $36, $5A, $60, $70, $DA, $53, $45, $4F, $55, $42, $4C, $6B, $10, $16
db $4C, $32, $55, $57, $38, $54, $2E, $09, $36, $5B, $31, $75, $62, $41, $76, $4C
db $55, $58, $45, $4D, $14, $2A, $78, $47, $7E, $67, $01, $BD, $EB, $B0, $1B, $AB
db $4C, $41, $59, $74, $53, $1C, $0D, $31, $36, $FA, $A8, $9E, $6C, $00, $09, $B5
db $55, $E3, $17, $20, $1B, $37, $4D, $50, $34, $94, $AC, $1C, $50, $38, $2D, $54
db $41, $AC, $33, $34, $87, $43, $3A, $42, $E0, $F3, $4D, $45, $58, $49, $43, $47
db $4F, $47, $6F, $36, $37, $48, $7F, $55, $B7, $FB, $06, $59, $41, $43, $41, $3B
db $6C, $4C, $17, $2C, $38, $AE, $A3, $8B, $36, $E7, $70, $47, $55, $7F, $E5, $02
db $58, $4A, $41, $52, $41, $33, $3B, $A2, $8E, $48, $36, $36, $49, $16, $41, $5D
db $E6, $48, $35, $2C, $37, $E3, $15, $2A, $BE, $5D, $41, $E2, $58, $37, $3E, $57
db $5A, $AA, $F4, $CA, $44, $89, $3B, $21, $4D, $AE, $BC, $43, $2A, $19, $36, $F5
db $48, $73, $86, $32, $31, $87, $CC, $4E, $45, $4A, $7E, $52, $21, $3C, $53, $54
db $53, $EE, $A4, $9D, $35, $42, $49, $4D, $25, $BE, $44, $D5, $15, $4A, $30, $94
db $09, $34, $57, $6B, $AE, $B5, $37, $4A, $30, $94, $07, $34, $64, $F2, $54, $89
db $23, $31, $A2, $23, $B1, $E5, $0E, $EF, $5A, $FF, $E1, $1D, $53, $31, $9C, $F8
db $30, $88, $A8, $6A, $E8, $B9, $08, $41, $55, $43, $4B, $75, $17, $2A, $BB, $34
db $A7, $DF, $AE, $B7, $48, $EB, $F7, $56, $CC, $84, $55, $52, $03, $33, $A7, $16
db $30, $00, $16, $57, $45, $4C, $E8, $BA, $45, $47, $09, $7E, $20, $28, $45, $AD
db $49, $EB, $C5, $42, $28, $D7, $30, $D2, $79, $E8, $24, $32, $33, $34, $EA, $48
db $76, $47, $4F, $AD, $42, $20, $17, $82, $4F, $43, $52, $D6, $AB, $AE, $F2, $03
db $18, $31, $FA, $03, $E4, $F2, $15, $46, $5E, $9A, $2B, $DF, $45, $1A, $30, $04
db $33, $57, $41, $59, $5C, $32, $33, $38, $46, $49, $04, $62, $35, $29, $37, $00
db $3A, $C0, $32, $49, $20, $15, $C7, $58, $50, $77, $CB, $44, $37, $F4, $B9, $0A
db $2F, $33, $5A, $35, $8C, $2F, $98, $4B, $ED, $9D, $DF, $9E, $A9, $B9, $87, $18
db $47, $40, $58, $A3, $55, $8A, $34, $94, $01, $7E, $4E, $3E, $D5, $31, $AF, $C9
db $26, $13, $1F, $4A, $77, $50, $C6, $F8, $49, $50, $50, $E5, $EB, $4E, $32, $32
db $35, $B9, $67, $5A, $37, $5B, $26, $B1, $AD, $50, $4F, $2E, $A2, $BB, $32, $C9
db $97, $77, $22, $A8, $3E, $EE, $82, $94, $41, $57, $32, $2F, $32, $56, $45, $04
db $F9, $FB, $28, $83, $E8, $55, $47, $41, $4C, $A3, $2B, $A6, $83, $76, $51, $C2
db $69, $53, $DD, $3B, $89, $F9, $54, $38, $E7, $9B, $28, $55, $58, $16, $4F, $22
db $20, $52, $3B, $76, $FD, $CC, $59, $C5, $50, $6B, $38, $EC, $41, $2A, $C1, $56
db $55, $44, $49, $20, $C8, $C3, $A1, $02, $39, $C5, $1D, $36, $A4, $09, $36, $00
db $11, $44, $48, $41, $5E, $94, $AC, $1B, $3A, $18, $80, $2C, $4A, $45, $44, $44
db $D2, $12, $91, $66, $36, $37, $33, $D6, $19, $CA, $59, $41, $24, $31, $24, $1F
db $22, $BC, $9A, $94, $47, $BE, $CF, $27, $31, $5A, $01, $DB, $74, $37, $47, $EA
db $4B, $A9, $48, $30, $7F, $44, $8C, $17, $47, $29, $53, $75, $47, $15, $8D, $54
db $28, $32, $B7, $89, $7F, $9F, $70, $D2, $D9, $45, $31, $3B, $31, $37, $11, $79
db $5A, $37, $72, $1F, $35, $00, $25, $96, $53, $DD, $68, $67, $48, $A9, $46, $3A
db $C7, $BD, $01, $4A, $19, $30, $2B, $C6, $D0, $04, $37, $EB, $AA, $7A, $50, $CA
db $C3, $EF, $C4, $77, $71, $AD, $C9, $EA, $5D, $C4, $41, $D4, $AF, $53, $15, $75
db $31, $DE, $61, $45, $30, $0A, $7C, $45, $A5, $B4, $31, $2C, $48, $39, $8A, $0A
db $2E, $53, $50, $FF, $19, $0E, $67, $32, $4A, $D9, $70, $4E, $33, $17, $67, $77
db $52, $7A, $22, $54, $51, $33, $9B, $8A, $9D, $D5, $4D, $41, $42, $75, $44, $51
db $69, $58, $57, $53, $57, $EB, $51, $0F, $4E, $41, $C6, $33, $38, $38, $90, $75
db $34, $38, $99, $5F, $43, $4B, $02, $48, $4F, $4C, $4D, $38, $20, $4A, $1A, $09
db $29, $49, $54, $5A, $4D, $6A, $4A, $3E, $38, $7B, $D8, $77, $05, $21, $53, $45
db $56, $41, $32, $3E, $21, $5E, $2B, $DF, $A6, $EB, $11, $93, $31, $2A, $EC, $34
db $AE, $60, $A1, $75, $38, $3C, $F0, $16, $C8, $E3, $49, $AC, $BC, $3A, $18, $AE
db $5C, $54, $FA, $E9, $53, $25, $0F, $33, $15, $E3, $9C, $F2, $D5, $27, $13, $16
db $BC, $79, $71, $AD, $87, $0F, $52, $4B, $45, $7D, $11, $36, $2F, $E8, $77, $F0
db $EF, $EA, $51, $49, $DB, $F1, $AC, $89, $A7, $16, $6E, $02, $35, $34, $54, $CC
db $40, $06, $20, $45, $4D, $EE, $E4, $78, $0D, $53, $77, $88, $A1, $0D, $34, $2E
db $F5, $2A, $47, $14, $42, $55, $20, $45, $11, $5E, $66, $88, $1A, $34, $EE, $64
db $96, $7B, $34, $01, $0E, $11, $46, $53, $41, $68, $D7, $35, $37, $4C, $88, $F7
db $B7, $1D, $94, $42, $F6, $35, $AD, $8E, $E3, $6C, $33, $9D, $18, $BB, $97, $74
db $E2, $65, $A6, $B9, $31, $5B, $A4, $A1, $BF, $15, $11, $38, $1C, $25, $BD, $34
db $6B, $62, $38, $C9, $01, $13, $49, $5A, $D2, $36, $AB, $6C, $91, $2D, $3B, $55
db $47, $9E, $E7, $E1, $5E, $37, $C4, $13, $37, $5B, $E6, $07, $13, $53, $78, $9F
db $35, $8C, $DA, $32, $E8, $9F, $8B, $77, $61, $7B, $54, $45, $20, $52, $62, $4F
db $2D, $45, $35, $89, $58, $30, $B4, $17, $7C, $58, $72, $37, $84, $80, $5A, $8D
db $33, $83, $13, $4F, $34, $14, $45, $50, $5F, $7F, $88, $7E, $35, $E5, $3C, $4F
db $D8, $CC, $4E, $36, $49, $31, $63, $47, $BB, $43, $4F, $88, $20, $51, $8F, $37
db $8E, $23, $7A, $2D, $8D, $30, $CA, $4A, $45, $0A, $2E, $33, $21, $67, $33, $41
db $C1, $2E, $48, $45, $59, $DE, $10, $78, $45, $33, $A7, $E2, $2B, $35, $2F, $BF
db $D5, $2D, $75, $43, $50, $B4, $33, $A8, $AE, $F3, $E6, $7C, $AD, $85, $4B, $55
db $95, $9F, $33, $72, $1A, $35, $8E, $64, $1A, $14, $C4, $D5, $36, $31, $F5, $13
db $36, $52, $62, $02, $24, $52, $44, $28, $E3, $95, $32, $9D, $13, $DE, $25, $94
db $4B, $32, $38, $26, $F9, $35, $8E, $3A, $F3, $02, $99, $56, $45, $52, $33, $B9
db $BF, $8D, $91, $CC, $77, $12, $53, $11, $20, $4D, $4F, $51, $73, $35, $31, $35
db $24, $29, $0A, $7A, $44, $4F, $25, $28, $32, $9C, $5C, $37, $4E, $95, $9D, $6A
db $55, $5E, $35, $12, $15, $32, $72, $15, $E1, $3D, $B6, $E9, $4F, $56, $37, $11
db $49, $35, $8F, $BB, $16, $E4, $44, $49, $38, $64, $37, $31, $55, $5C, $2D, $D3
db $C6, $D6, $EE, $68, $7E, $D2, $CA, $EF, $B4, $72, $18, $37, $EA, $51, $BF, $55
db $B4, $1D, $3A, $12, $90, $39, $D5, $85, $4D, $58, $A2, $0B, $89, $53, $31, $60
db $DD, $4A, $41, $43, $4B, $EC, $66, $36, $A8, $1F, $46, $30, $0C, $75, $36, $47
db $7B, $46, $46, $45, $E5, $01, $7C, $33, $10, $EB, $39, $99, $E3, $1A, $55, $08
db $D3, $41, $55, $39, $C8, $63, $31, $F4, $A4, $2D, $39, $EE, $A2, $15, $4E, $AB
db $4A, $35, $23, $55, $9E, $B0, $CC, $22, $20, $EA, $47, $25, $41, $53, $BA, $B9
db $97, $B6, $31, $6E, $B9, $EF, $6A, $6E, $67, $F1, $E9, $32, $FB, $02, $12, $1B
db $13, $54, $54, $C1, $A2, $37, $3C, $91, $9A, $83, $31, $54, $4C, $4F, $BB, $41
db $9E, $77, $76, $DD, $6C, $54, $33, $1C, $28, $36, $33, $43, $EA, $A8, $1A, $49
db $AF, $38, $92, $94, $BC, $EC, $DB, $DA, $02, $A2, $06, $B2, $CE, $36, $22, $3B
db $3C, $FE, $75, $47, $22, $28, $52, $59, $32, $89, $16, $32, $20, $D8, $16, $50
db $CE, $52, $49, $B6, $44, $B4, $6E, $FC, $88, $62, $4E, $A7, $48, $56, $38, $87
db $46, $36, $AC, $84, $C3, $23, $EA, $E7, $60, $48, $41, $52, $60, $32, $B6, $FF
db $4F, $35, $D0, $43, $59, $4F, $52, $4B, $EB, $70, $E6, $4C, $58, $32, $31, $9B
db $46, $C1, $08, $1A, $4F, $4B, $4C, $59, $D9, $81, $38, $F1, $02, $9F, $EE, $01
db $1D, $B7, $B4, $75, $56, $8F, $BC, $4E, $0E, $77, $3C, $BD, $59, $6A, $A8, $37
db $D3, $C5, $EE, $05, $1B, $93, $86, $54, $45, $BE, $6E, $53, $7B, $4C, $05, $1F
db $86, $6C, $41, $48, $ED, $4B, $41, $D8, $8E, $44, $F0, $C1, $68, $C3, $4F, $87
db $85, $4D, $50, $49, $4A, $BB, $36, $5E, $C7, $37, $BC, $1F, $28, $25, $48, $41
db $92, $83, $37, $CD, $83, $50, $3C, $D6, $16, $46, $58, $36, $97, $65, $31, $43
db $44, $50, $B0, $24, $52, $45, $36, $B2, $4C, $98, $26, $D6, $56, $49, $E8, $EC
db $EB, $2B, $6F, $4E, $A9, $5D, $A7, $52, $E0, $27, $49, $47, $48, $1F, $39, $31
db $39, $02, $3D, $4E, $D7, $38, $48, $62, $6C, $44, $38, $A5, $A1, $34, $2A, $8C
db $62, $53, $41, $43, $2B, $4D, $77, $45, $A8, $DC, $39, $F6, $DC, $38, $5A, $89
db $CF, $70, $53, $3F, $4D, $35, $8C, $63, $31, $44, $39, $50, $93, $11, $54, $20
db $C5, $D2, $4B, $45, $15, $D0, $38, $54, $39, $33, $A7, $58, $BD, $B1, $57, $20
db $8E, $48, $49, $EA, $FF, $34, $A5, $5B, $30, $67, $46, $57, $D2, $75, $1B, $61
db $7C, $14, $D6, $C5, $FF, $5D, $56, $53, $CF, $90, $47, $5E, $90, $01, $FF, $34
db $28, $DD, $C7, $0C, $AE, $46, $DF, $4C, $22, $44, $32, $14, $B3, $32, $75, $8E
db $81, $4D, $20, $50, $41, $55, $4C, $36, $3A, $F4, $D4, $C7, $ED, $7A, $0A, $5D
db $ED, $48, $E8, $74, $45, $45, $39, $9D, $51, $6C, $36, $18, $31, $C2, $50, $45
db $15, $4B, $41, $39, $09, $98, $38, $08, $3E, $54, $52, $25, $D9, $4E, $74, $3A
db $36, $A5, $5C, $54, $9C, $4E, $53, $25, $49, $38, $25, $19, $90, $57, $D1, $6A
db $2A, $42, $70, $20, $44, $43, $32, $A1, $84, $34, $29, $F3, $74, $2A, $0E, $69
db $45, $5A, $55, $A6, $48, $38, $44, $27, $37, $35, $47, $39, $72, $6B, $43, $8A
db $3A, $F6, $A9, $73, $20, $38, $18, $17, $2A, $76, $57, $33, $4B, $53, $CF, $44
db $02, $A7, $6E, $80, $27, $44, $49, $46, $46, $32, $AE, $CB, $E2, $C1, $5F, $2A
db $59, $55, $D4, $BB, $B2, $4C, $84, $76, $41, $5B, $60, $5C, $F7, $A9, $48, $97
db $33, $38, $A5, $9B, $47, $85, $56, $44, $45, $31, $7E, $C7, $BE, $75, $53, $E0
db $67, $4A, $45, $56, $57, $4F, $93, $77, $A0, $D0, $2A, $00, $78, $1A, $00

; Data from 15B4C to 178FB (7600 bytes)
_DATA_15B4C_:
ds 16, $FF
db $E7, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $E7, $E7, $F3, $FF
db $99, $99, $88, $99, $CC
ds 11, $FF
db $93, $93, $01, $01, $80, $93, $81, $93, $81, $93, $01, $01, $80, $93, $C9, $FF
db $EF, $EF, $C3, $C3, $81, $9F, $C7, $C7, $E3, $F3, $81, $87, $C3, $EF, $F7, $FF
db $FF, $FF, $39, $39, $10, $33, $81, $E7, $C3, $CF, $81, $99, $08, $39, $9C, $FF
db $C7, $C7, $83, $93, $C1, $C7, $83, $8F, $01, $21, $10, $33, $89, $89, $C4, $FF
db $E7, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $C3, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $E7, $E7, $F3, $FF
db $E7, $E7, $F3, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $E1, $E7, $F3, $FF
db $FF, $FF, $93, $93, $C1, $C7, $01, $01, $80, $C7, $83, $93, $C9, $FF, $FF, $FF
db $FF, $FF, $E7, $E7, $E3, $E7, $81, $81, $C0, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $81, $81
db $C0
ds 17, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $F9, $F9, $F0, $F3, $E1, $E7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $83, $83, $01, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $E7, $E7, $C3, $C7, $A3, $A7, $C3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $83, $83, $01, $39, $98, $F9, $80, $83, $01, $3F
db $1F, $3F, $01, $01, $80, $FF, $83, $83, $01, $39, $98, $F9, $E0, $E3, $F1, $F9
db $38, $39, $80, $83, $C1, $FF, $E3, $E3, $C1, $C3, $81, $93, $01, $33, $01, $01
db $80, $F3, $F1, $F3, $F9, $FF, $01, $01, $00, $3F, $1F, $3F, $03, $03, $81, $F9
db $38, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $1C, $3F, $03, $03, $01, $39
db $18, $39, $80, $83, $C1, $FF, $03, $03, $81, $F9, $F8, $F9, $F8, $F9, $F8, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $83, $83, $01, $39, $18, $39, $80, $83, $01, $39
db $18, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $18, $39, $80, $81, $C0, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $E7, $E7
db $E3, $E7, $C3, $CF, $E7, $FF, $E7, $E7, $C3, $CF, $87, $9F, $0F, $3F, $9F, $9F
db $CF, $CF, $E7, $E7, $F3, $FF, $FF, $FF, $FF, $FF, $81, $81, $C0, $FF, $81, $81
db $C0, $FF, $FF, $FF, $FF, $FF, $CF, $CF, $E7, $E7, $F3, $F3, $F9, $F9, $F0, $F3
db $E1, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $99, $C8, $F9, $F0, $F3, $E1, $E7
db $F3, $FF, $E7, $E7, $F3, $FF, $83, $83, $01, $3D, $00, $21, $00, $2D, $02, $23
db $11, $3F, $81, $81, $C0, $FF, $C7, $C7, $83, $93, $09, $39, $00, $01, $00, $39
db $18, $39, $10, $11, $88, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $00, $03, $81, $FF, $C3, $C3, $81, $99, $0C, $3F, $1F, $3F, $1F, $3F
db $99, $99, $C0, $C3, $E1, $FF, $07, $07, $83, $93, $89, $99, $88, $99, $88, $99
db $80, $93, $01, $07, $83, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $89, $9D, $00, $01, $80, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $8B, $9F, $0F, $0F, $87, $FF, $C3, $C3, $81, $99, $0C, $3F, $11, $31, $18, $39
db $98, $99, $C0, $C3, $E1, $FF, $39, $39, $18, $39, $18, $39, $00, $01, $00, $39
db $18, $39, $18, $39, $9C, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $83, $8F, $C7, $FF, $19, $19, $88, $99, $80, $93, $81, $87, $83, $93
db $89, $99, $08, $19, $8C, $FF, $1F, $1F, $8F, $9F, $8F, $9F, $8F, $9F, $8F, $9F
db $89, $99, $00, $01, $80, $FF, $39, $39, $10, $11, $08, $29, $10, $39, $18, $39
db $18, $39, $18, $39, $9C, $FF, $31, $31, $18, $19, $08, $29, $10, $31, $18, $39
db $18, $39, $18, $19, $8C, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $18, $39
db $90, $93, $C1, $C7, $E3, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F
db $8F, $9F, $0F, $0F, $87, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $1C, $3D
db $92, $93, $C9, $C9, $E4, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $08, $19, $8C, $FF, $83, $83, $01, $39, $1C, $3F, $83, $83, $C1, $F9
db $38, $39, $80, $83, $C1, $FF, $81, $81, $80, $A5, $C2, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $C3, $C3, $E1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $90, $93
db $C1, $C7, $E3, $EF, $F7, $FF, $39, $39, $18, $39, $18, $39, $18, $39, $08, $29
db $10, $11, $08, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $83, $93
db $09, $39, $18, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $81, $81, $00, $39, $90, $F3, $E1, $E7, $C3, $CF
db $81, $99, $00, $03, $81, $FF, $C3, $C3, $C1, $CF, $C7, $CF, $C7, $CF, $C7, $CF
db $C7, $CF, $C3, $C3, $E1, $FF, $FF, $FF, $3F, $3F, $9F, $9F, $CF, $CF, $E7, $E7
db $F3, $F3, $F9, $F9, $FC, $FF, $C3, $C3, $E1, $F3, $F1, $F3, $F1, $F3, $F1, $F3
db $F1, $F3, $C1, $C3, $E1, $FF, $E7, $E7, $C3, $C3, $81, $81, $80, $A5, $C2, $E7
db $E3, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $CF, $CF, $87, $9F, $01, $01, $00, $01
db $80, $9F, $CF, $CF, $E7, $FF, $E7, $E7, $E3, $E7, $F3, $F3, $F9
ds 9, $FF
db $40, $C0, $80, $BF, $00, $7F, $00, $60, $00, $6F, $00, $6F, $03, $6F, $03, $6F
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $FF, $00, $FF, $FD, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $FF, $00, $FC, $FB, $FB, $FD, $FD
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $FF, $00, $48, $B7, $B7, $48, $48
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $FE, $01, $FD, $3D, $3D, $DD, $DD
db $00, $00, $00, $F0, $0F, $CF, $30, $30, $C0, $C7, $00, $1F, $00, $7F, $00, $7F
db $00, $00, $00, $3F, $C0, $DF, $20, $20, $40, $C7, $40, $CF, $25, $EF, $27, $E7
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $FF, $00, $FE, $FD, $FD, $FA, $FA
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $7C, $81, $BB, $86, $86, $18, $18
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $63, $98, $9C, $65, $65, $02, $CE
db $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $FF, $00, $FF, $0D, $0F, $F0, $F0
db $03, $03, $01, $FD, $00, $FE, $00, $06, $00, $F6, $00, $F6, $F0, $F6, $F0, $F6
db $03, $6F, $03, $6F, $03, $6F, $03, $6F, $03, $6F, $03, $6F, $01, $6F, $03, $6F
db $7F, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $E0, $E0, $DE, $DF, $91, $B1
db $7F, $FF, $EF, $FF, $DC, $FC, $B9, $FB, $C6, $C6, $9B, $BB, $24, $24, $C0, $CD
db $7A, $FA, $E6, $F6, $D2, $F6, $38, $78, $B5, $B5, $4A, $4A, $2E, $6E, $12, $F2
db $40, $5B, $30, $3F, $08, $4F, $A4, $A7, $93, $9B, $64, $64, $5A, $5A, $51, $51
db $2E, $AE, $16, $F6, $0A, $FA, $08, $F8, $08, $F9, $90, $F1, $50, $73, $61, $63
db $40, $FF, $80, $9F, $80, $BF, $41, $FF, $41, $5F, $42, $5F, $44, $5C, $A8, $BC
db $20, $E0, $43, $C7, $46, $C6, $01, $89, $04, $1C, $0E, $3F, $1D, $3F, $1F, $7F
db $7F, $7F, $AF, $BF, $1F, $5F, $0F, $8F, $07, $1F, $0F, $3F, $9D, $FF, $FF, $FF
db $7F, $FF, $EF, $FF, $DE, $FE, $BD, $FD, $F5, $FD, $FA, $FA, $F4, $F4, $74, $75
db $07, $87, $70, $78, $8E, $8F, $01, $39, $20, $7F, $56, $7F, $59, $59, $86, $86
db $7A, $FA, $E2, $E2, $1D, $1D, $E0, $E0, $00, $0F, $00, $FF, $00, $FF, $00, $7F
db $20, $63, $C0, $CF, $00, $1F, $00, $7F, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $00, $FE, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $0E, $8F, $01, $F9, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $1F, $1F, $C3, $E3, $3C, $3C, $03, $E3, $00, $FE, $00, $FF, $00, $FF, $00, $FF
db $7F, $FF, $03, $03, $F8, $FC, $07, $07, $00, $7C, $00, $FF, $00, $FF, $01, $FF
db $7F, $FF, $EF, $FF, $5F, $7F, $BF, $BF, $57, $5F, $4F, $CF, $85, $8F, $07, $9F
db $70, $F6, $E0, $F6, $D0, $F6, $B0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6
db $20, $A7, $A0, $AF, $A0, $AF, $A2, $AF, $AD, $AD, $B1, $B9, $A0, $A0, $C0, $C2
db $00, $1F, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7F, $80, $FF, $80, $BF
db $04, $F4, $08, $F8, $08, $F9, $08, $F9, $04, $FC, $03, $FF, $00, $FE, $00, $FF
db $30, $33, $21, $A3, $5D, $5D, $A2, $A2, $22, $2E, $C1, $CF, $01, $1F, $02, $FE
db $21, $A7, $C3, $C7, $C3, $EF, $B7, $FF, $77, $7F, $3F, $BF, $DD, $DF, $6F, $6F
db $58, $D8, $E0, $E1, $D0, $F3, $B9, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $3F, $FF, $6F, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $7A, $FA, $E5, $F5, $C5, $ED, $B2, $F2, $F2, $FA, $FC, $FC, $FC, $FD, $FD, $FD
db $B2, $B7, $41, $51, $06, $4E, $89, $89, $30, $B3, $40, $47, $80, $9F, $00, $3F
db $98, $98, $A0, $B3, $20, $2F, $C0, $CF, $00, $1F, $00, $FF, $00, $FF, $00, $FF
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $00, $FF, $00, $FF, $01, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $3D, $FF, $C3, $C3, $06, $06, $C6, $D6, $44, $C4, $20, $E8, $24, $E5, $62, $E7
db $0F, $1F, $0F, $3F, $1F, $3F, $1F, $7F, $37, $7F, $3F, $FF, $7D, $FF, $FF, $FF
db $60, $EE, $E7, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $A0, $BF, $50, $5F, $90, $97, $90, $D7, $D0, $D7, $D0, $D7, $90, $B7, $A0, $A7
db $02, $FE, $02, $FE, $02, $FE, $04, $FC, $04, $FC, $08, $FC, $08, $F8, $08, $F9
db $47, $67, $03, $07, $03, $4F, $27, $7F, $37, $FF, $7F, $FF, $7D, $FF, $7F, $FF
db $79, $F9, $E4, $F5, $D7, $F7, $B4, $F4, $E8, $E9, $E9, $EB, $E6, $EE, $F1, $F1
db $00, $7F, $B0, $FF, $68, $6F, $B6, $B7, $89, $8B, $00, $00, $20, $2A, $D5, $D7
db $00, $FF, $00, $FF, $06, $FF, $19, $F9, $A0, $E0, $6F, $6F, $D8, $D8, $04, $07
db $00, $FF, $0C, $FF, $12, $F3, $24, $E4, $A4, $E5, $12, $33, $12, $72, $14, $F4
db $00, $FF, $00, $FF, $01, $FF, $02, $FF, $02, $FE, $02, $FE, $0A, $FE, $16, $FE
db $A3, $A7, $8B, $8B, $19, $99, $10, $11, $10, $13, $11, $53, $31, $33, $51, $53
db $20, $AF, $D0, $DF, $D0, $D7, $A8, $EF, $E8, $EB, $F4, $F7, $F4, $F5, $FA, $FB
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $07, $FF, $08, $FC, $08, $F8, $10, $F9
db $10, $F9, $10, $F1, $20, $F3, $20, $E2, $C1, $C5, $60, $ED, $24, $26, $23, $A7
db $7F, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $77, $7F, $3F, $3F, $1D, $3F, $1F, $7F
db $7F, $FF, $EF, $FF, $DE, $FE, $BC, $FD, $F6, $FE, $FF, $FF, $FC, $FE, $FD, $FD
db $6E, $EE, $50, $50, $90, $B7, $20, $27, $20, $6F, $40, $4F, $80, $9F, $00, $3F
db $12, $1A, $0D, $FD, $02, $FA, $00, $FE, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $24, $27, $C4, $C5, $34, $35, $14, $F5, $14, $F5, $0A, $FB, $0A, $FA, $05, $FD
db $08, $F9, $00, $FB, $00, $FF, $00, $FF, $20, $FF, $50, $DF, $2C, $EF, $23, $E3
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $F0, $FF, $08, $9F
db $12, $F2, $10, $F0, $10, $F2, $11, $F3, $11, $F3, $11, $F3, $11, $F3, $11, $FB
db $A1, $A3, $C1, $C7, $03, $0F, $07, $9F, $C7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $7B, $FB, $EA, $FA, $D8, $FA, $BC, $FC, $F6, $FE, $FF, $FF, $FD, $FF, $FF, $FF
db $10, $F1, $90, $F3, $90, $B2, $50, $71, $29, $A9, $56, $D6, $E6, $EE, $F1, $F1
db $8B, $8B, $25, $65, $70, $70, $8A, $8A, $80, $80, $80, $9A, $8D, $9F, $4F, $5F
db $3F, $FF, $EF, $FF, $DF, $FF, $3F, $7F, $37, $BF, $1F, $1F, $0D, $BF, $DB, $FB
db $79, $FB, $EA, $FA, $DA, $FA, $BA, $FA, $F2, $FA, $FA, $FA, $FA, $FA, $FA, $FA
db $00, $7F, $00, $7F, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
db $05, $FD, $05, $FD, $02, $FE, $02, $FE, $02, $FE, $01, $FF, $01, $FF, $00, $FF
db $14, $74, $16, $76, $8A, $FE, $82, $BE, $84, $BC, $48, $78, $30, $31, $80, $83
db $04, $07, $02, $33, $19, $7B, $3D, $7D, $35, $7D, $3D, $FD, $7D, $FD, $FD, $FD
db $03, $FF, $04, $FE, $04, $FC, $08, $78, $10, $71, $20, $73, $21, $63, $21, $67
db $00, $FF, $80, $FF, $83, $BF, $45, $7D, $42, $5E, $41, $5F, $21, $7F, $9D, $BF
db $69, $E9, $88, $C9, $00, $81, $00, $1B, $05, $37, $0B, $6B, $29, $29, $14, $35
db $78, $F9, $EC, $FE, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $CE, $CE, $25, $2D, $61, $61, $3E, $7E, $88, $98, $C4, $C7, $E2, $F3, $F2, $F6
db $75, $F5, $20, $20, $D0, $D1, $2E, $2E, $01, $E9, $01, $FF, $00, $FF, $00, $FF
db $7F, $FF, $EF, $FF, $5F, $FF, $BF, $FF, $77, $7F, $3F, $BF, $9D, $9F, $4F, $DF
db $7A, $FA, $E9, $FB, $DD, $FD, $BE, $FE, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $00, $FF, $00, $FF, $00, $7F, $EE, $FF, $11, $3B, $81, $81, $C0, $E1, $F0, $FE
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7F, $80, $FF, $40, $FF
db $69, $EB, $19, $D9, $08, $F9, $08, $F9, $08, $F9, $10, $F9, $10, $F1, $20, $F3
db $7E, $FE, $EF, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $A3, $E7, $43, $47, $43, $4F, $87, $97, $A3, $B3, $D1, $D3, $E1, $E3, $F1, $F7
db $12, $B7, $D2, $D2, $D8, $DA, $88, $D8, $E8, $EC, $C4, $CC, $90, $B4, $D8, $D8
db $10, $30, $08, $29, $08, $68, $23, $63, $11, $D1, $50, $D2, $29, $A9, $4A, $4A
db $7F, $FF, $6F, $FF, $5F, $7F, $BF, $BF, $17, $1F, $0F, $3F, $1D, $7F, $BF, $FF
db $74, $F6, $E4, $F5, $D4, $F5, $B4, $F5, $F4, $F5, $F4, $F5, $F4, $F5, $F4, $F5
db $2F, $EF, $27, $F7, $13, $F3, $0C, $FC, $02, $FB, $01, $FF, $00, $FF, $00, $FF
db $7F, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $77, $7F, $3F, $3F, $9D, $BF, $9F, $9F
db $40, $5F, $40, $5F, $40, $5F, $40, $5F, $20, $7F, $A0, $AF, $90, $BF, $D0, $D7
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $01, $FF, $01, $FF, $01, $FF
db $41, $E3, $41, $C7, $83, $CF, $87, $8F, $87, $9F, $0F, $9F, $0D, $1F, $0F, $3F
db $7B, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $6C, $EC, $EC, $EC, $C0, $EA, $B6, $F6, $F2, $FA, $FD, $FD, $FC, $FD, $FE, $FE
db $85, $9D, $89, $BD, $96, $B6, $66, $66, $34, $74, $00, $00, $80, $84, $01, $1D
db $7F, $7F, $23, $23, $18, $1C, $3F, $7F, $04, $04, $02, $C3, $62, $7A, $38, $BA
db $7F, $FF, $EF, $FF, $DF, $FF, $3F, $7F, $B7, $BF, $9F, $9F, $4D, $DF, $2F, $EF
db $74, $F5, $E2, $F7, $DA, $FA, $B9, $FB, $D5, $DD, $2D, $2D, $C4, $E5, $02, $06
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7F, $00, $7F, $80, $FF, $40, $FF
db $00, $FF, $01, $FF, $01, $FF, $01, $FF, $01, $FF, $02, $FF, $02, $FE, $04, $FE
db $8F, $9F, $0F, $9F, $0F, $1F, $0F, $3F, $17, $3F, $1F, $3F, $1D, $3F, $1F, $7F
db $10, $B7, $A0, $A7, $A0, $AF, $A0, $AF, $A0, $AF, $A0, $AF, $A0, $AF, $90, $BF
db $01, $FF, $01, $FF, $01, $FF, $02, $FE, $02, $FE, $02, $FE, $04, $FC, $04, $FC
db $1F, $3F, $0F, $3F, $07, $27, $13, $1B, $29, $29, $28, $29, $50, $51, $50, $53
db $0A, $3A, $8C, $FC, $DE, $FE, $BF, $FF, $F7, $FF, $FE, $FE, $FC, $FE, $F9, $F9
db $84, $84, $1A, $1A, $28, $A8, $24, $AC, $45, $4D, $85, $9F, $82, $BE, $00, $3E
db $67, $67, $23, $27, $83, $87, $83, $8F, $47, $5F, $4F, $4F, $45, $4F, $47, $EF
db $20, $7F, $40, $4F, $40, $5F, $40, $5F, $40, $5F, $20, $7F, $A0, $AF, $40, $4F
db $08, $FC, $10, $F8, $10, $F1, $20, $F3, $21, $E3, $21, $E7, $21, $E7, $43, $E7
db $3F, $7F, $2F, $FF, $5F, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $50, $D7, $D0, $D7, $C8, $DF, $A8, $EB, $E8, $EB, $E4, $EF, $F4, $F5, $F2, $F7
db $08, $FC, $08, $F8, $08, $F9, $10, $F1, $10, $F3, $11, $F3, $21, $E3, $41, $E7
db $11, $53, $21, $B3, $01, $A3, $81, $C7, $E3, $EF, $F7, $FF, $FD, $FF, $FF, $FF
db $76, $F6, $E8, $E8, $D0, $D3, $90, $D7, $D0, $D7, $D0, $D7, $E8, $EF, $E8, $EB
db $00, $7F, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $38, $FF
db $27, $E7, $23, $E7, $13, $F7, $13, $FB, $09, $F9, $08, $F9, $08, $F9, $08, $F9
db $7E, $FE, $EE, $FE, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $80, $9F, $80, $BF, $41, $7F, $41, $5F, $41, $5F, $22, $7F, $A2, $AE, $42, $4E
db $43, $C7, $83, $CF, $07, $8F, $07, $1F, $07, $3F, $1F, $3F, $1D, $3F, $1F, $7F
db $79, $FB, $EC, $FC, $DE, $FE, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $83, $87, $03, $0F, $07, $3F, $1F, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $77, $F7, $E8, $F8, $DC, $FC, $BE, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $C4, $EF, $02, $03, $01, $09, $04, $FE, $F6, $FE, $FF, $FF, $FD, $FF, $FF, $FF
db $08, $F9, $10, $F1, $20, $F3, $A1, $E3, $A1, $A7, $43, $47, $81, $8F, $A7, $AF
db $7F, $FF, $E3, $F3, $C9, $ED, $A8, $EC, $D0, $D2, $D0, $D6, $D0, $D4, $A8, $AC
db $70, $F6, $E0, $F6, $D0, $F6, $B0, $F6, $70, $F6, $70, $76, $30, $76, $30, $F6
db $44, $5E, $48, $5C, $48, $58, $50, $58, $30, $B1, $00, $C3, $00, $00, $FF, $FF
db $3F, $7F, $2F, $7F, $1F, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF, $FF
db $47, $C7, $E3, $EF, $D7, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF, $FF
db $20, $A8, $90, $B9, $C0, $C1, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF, $FF
db $70, $F6, $60, $F6, $D0, $F6, $00, $06, $00, $FE, $01, $FD, $03, $03, $FF, $FF
db $7F, $FF, $EF, $FF, $9F, $BF, $4F, $4F, $97, $B7, $C3, $C3, $E1, $E7, $F3, $FF
db $7F, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF
db $7F, $FF, $EF, $FF, $DF, $FF, $B7, $F7, $EA, $EA, $EC, $EC, $EA, $EA, $E9, $E9
db $7F, $FF, $EF, $FF, $DF, $FF, $3F, $3F, $57, $DF, $8F, $8F, $85, $9F, $8F, $9F
db $03, $6F, $03, $6F, $03, $6F, $03, $6F, $03, $6F, $03, $6F, $00, $6E, $03, $6F
db $7F, $FF, $EF, $FF, $DF, $FF, $BF, $FF, $F7, $FF, $3B, $3B, $85, $C5, $54, $54
db $50, $D8, $E1, $E0, $D2, $F2, $BA, $FA, $F4, $F5, $F6, $F5, $C7, $CF, $38, $38
db $8F, $9F, $0F, $1F, $8F, $3F, $1F, $7F, $37, $7F, $3C, $3C, $1B, $9B, $E2, $E2
db $54, $54, $54, $54, $BE, $AE, $80, $C0, $E0, $E8, $F4, $FF, $FD, $FF, $FF, $FF
db $DB, $C8, $0B, $39, $84, $0F, $06, $65, $34, $F5, $7A, $FA, $FA, $FA, $FC, $FC
db $5B, $9B, $02, $E2, $03, $83, $02, $0A, $04, $3C, $1E, $3E, $1D, $7F, $3F, $7F
db $83, $8F, $07, $1F, $EF, $EF, $07, $07, $03, $0F, $07, $FF, $7D, $FF, $FF, $FF
db $78, $F8, $E7, $F7, $C8, $E8, $B7, $F7, $E0, $E0, $CF, $DF, $D0, $D0, $E0, $E0
db $BF, $BF, $0F, $9F, $0F, $1F, $8F, $3F, $97, $BF, $9F, $1F, $0D, $3F, $1F, $7F
db $70, $F7, $EB, $FF, $DF, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF, $FF
db $3F, $FF, $EF, $FF, $DF, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF, $FF
db $03, $6F, $03, $6F, $03, $6F, $00, $60, $00, $7F, $80, $BF, $C0, $C0, $FF, $FF
db $7F, $FF, $EF, $FF, $DF, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00
ds 18, $FF
db $00, $00, $66, $E7
ds 10, $66
db $7E, $7E
ds 13, $66
db $E7, $00, $00, $00, $99, $00, $FF, $99, $FF, $FF, $FF, $FF, $FF, $E7, $E7, $DB
db $DB, $D3, $DB, $C1, $C1, $9C, $BE, $26, $66, $66, $66, $66, $66, $26, $66, $1E
db $3F, $00, $00, $00, $C0, $00, $FF, $C0
ds 11, $FF
db $83, $83, $39, $7D, $64, $66, $66, $66, $66, $66, $64, $66, $78, $7C, $60, $61
db $60, $63, $61, $6F, $03, $0F, $0F, $9F, $0F, $FF, $9F, $FF, $FF, $FF, $FF, $FF
db $99, $99
ds 10, $66
db $3C, $3C, $18, $99, $30, $B3, $61, $67, $03, $0F, $07, $9F, $0F, $FF, $9F, $FF
db $FF, $FF, $FF, $FF, $FF, $FF, $7F, $7F, $7F, $7F, $7F, $FF, $7F, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $4C, $63, $4C, $62, $4C, $62, $4C, $63, $4C, $63, $4C, $63
db $4C, $63, $4C, $63
ds 12, $FF
db $FE, $FE, $FE, $FE, $4C, $63, $4C, $63, $4C, $63, $4C, $63, $4C, $63, $4C, $63
db $4C, $62, $4C, $62, $C3, $C3, $99, $BD, $24
ds 9, $66
db $7E, $7E
ds 13, $66
db $E7, $00, $00, $00, $18, $00, $FF, $18
ds 11, $FF
db $83, $83, $39, $7D, $64
ds 9, $66
db $00, $00, $00, $99, $00, $FF, $99
ds 21, $FF
db $E7, $E7, $DB, $DB, $D3, $DB, $C3, $C3, $93, $BB, $9B, $9B, $9B, $DB, $9B, $DB
db $99, $99, $3C, $7E, $00, $00, $00, $81, $00, $FF, $81
ds 11, $FF
db $99, $99, $66, $66, $66, $66, $66, $66, $66, $66, $24, $24, $18, $99, $00, $C3
db $81, $E7, $C3, $FF, $E7
ds 11, $FF
db $C3, $C3, $99, $BD, $24, $66, $7E, $7E, $60, $60, $22, $62, $1C, $3C, $00, $81
db $00, $C3, $81, $FF, $C3
ds 11, $FF
db $83, $83, $3D, $7D, $62, $66, $60, $60, $60, $69, $60, $6F, $69, $6F, $0F, $0F
db $0F, $9F, $0F, $FF, $9F
ds 11, $FF
db $C1, $C1, $BC, $BE, $60, $60, $3C, $3D, $06, $86, $06, $86, $3C, $7C, $00, $01
db $00, $83, $01, $FF, $83
ds 11, $FF
db $FE, $FF, $FE
ds 15, $FF
db $FE, $FE, $FE, $FE, $FE, $FF, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $99
db $00, $FF, $99
ds 11, $FF
db $C3, $C3, $BD, $BD, $66, $66, $7E, $7E, $66, $66, $66, $66, $66, $66, $00, $00
db $03, $03, $7D, $7D, $66, $66, $7C, $7C, $66, $66, $66, $66, $7D, $7D, $03, $03
db $C3, $C3, $BD, $BD, $66, $66, $60, $60, $60, $60, $66, $66, $BD, $BD, $C3, $C3
db $03, $03, $7D, $7D, $66, $66, $66, $66, $66, $66, $66, $66, $7D, $7D, $03, $03
db $00, $00, $7E, $7E, $60, $60, $7B, $7B, $63, $63, $60, $60, $7E, $7E, $00, $00
db $00, $00, $7E, $7E, $60, $60, $7B, $7B, $63, $63, $6F, $6F, $6F, $6F, $0F, $0F
db $C1, $C1, $BE, $BE, $60, $60, $6E, $6E, $66, $66, $66, $66, $BD, $BD, $C3, $C3
db $18, $18, $66, $66, $66, $66, $7E, $7E, $66, $66, $66, $66, $66, $66, $18, $18
db $00, $00, $7E, $7E, $18, $18, $DB, $DB, $DB, $DB, $18, $18, $7E, $7E, $00, $00
db $00, $00, $7E, $7E, $18, $18, $DB, $DB, $1B, $1B, $5B, $5B, $B7, $B7, $CF, $CF
db $00, $00, $66, $66, $6D, $6D, $7B, $7B, $7B, $7B, $6D, $6D, $66, $66, $00, $00
db $0F, $0F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $60, $60, $7E, $7E, $00, $00
db $18, $18, $66, $66, $7E, $7E, $66, $66, $66, $66, $66, $66, $66, $66, $00, $00
db $18, $18, $66, $66, $76, $76, $6E, $6E, $66, $66, $66, $66, $66, $66, $00, $00
db $C3, $C3, $BD, $BD, $66, $66, $66, $66, $66, $66, $66, $66, $BD, $BD, $C3, $C3
db $03, $03, $7D, $7D, $66, $66, $7D, $7D, $63, $63, $6F, $6F, $6F, $6F, $0F, $0F
db $C3, $C3, $BD, $BD, $66, $66, $66, $66, $6A, $6A, $6C, $6C, $B6, $B6, $C1, $C1
db $03, $03, $7D, $7D, $66, $66, $7C, $7C, $66, $66, $66, $66, $66, $66, $00, $00
db $C0, $C0, $BE, $BE, $60, $60, $BD, $BD, $C6, $C6, $06, $06, $7D, $7D, $03, $03
db $00, $00, $7E, $7E, $18, $18, $DB, $DB, $DB, $DB, $DB, $DB, $DB, $DB, $C3, $C3
db $00, $00
ds 10, $66
db $BD, $BD, $C3, $C3, $00, $00, $66, $66, $66, $66, $66, $66, $66, $66, $BD, $BD
db $DB, $DB, $E7, $E7, $18, $18, $66, $66, $66, $66, $66, $66, $66, $66, $7E, $7E
db $66, $66, $00, $00, $00, $00, $66, $66, $BD, $BD, $DB, $DB, $DB, $DB, $BD, $BD
db $66, $66, $00, $00, $00, $00, $66, $66, $66, $66, $BD, $BD, $DB, $DB, $DB, $DB
db $DB, $DB, $C3, $C3, $00, $00, $7E, $7E, $06, $06, $ED, $ED, $DB, $DB, $B0, $B0
db $7E, $7E, $00, $00, $00, $00, $3F, $3F, $40, $5F, $40, $60, $4F, $60, $4F, $60
db $4F, $60, $4F, $60, $00, $00, $FF, $FF, $00, $FF, $00, $00, $FF, $00, $FF, $00
db $FF, $00, $FF, $00, $00, $00, $FC, $FC, $02, $F8, $06, $00, $F6, $00, $F6, $00
db $F6, $00, $F6
ds 17, $00
db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $00
db $80, $00, $40, $3F, $20, $40, $4F, $60, $4F, $60, $4C, $63, $4C, $63, $4C, $63
db $00, $00, $00, $FF, $00, $00, $FF, $00, $FF, $00, $00, $FF, $00, $FF, $FF, $FF
db $01, $00, $02, $FC, $04, $02, $F0, $06, $F4, $06, $04, $F6, $04, $F6, $F4, $F6
db $4F, $60, $4F, $60, $4F, $60, $4F, $60, $4F, $60, $4F, $60, $4F, $60, $4F, $60
db $16, $00, $16, $00, $16, $00, $16, $00, $16, $00, $16, $00, $16, $00, $16, $00
db $4C, $63, $4C, $63, $4C, $63, $4C, $63, $4C, $63, $4C, $63, $4C, $63, $4C, $63
db $F4, $F6, $F4, $F6, $F4, $F6, $F4, $F6, $F4, $F6, $F4, $F6, $F4, $F6, $F4, $F6
db $4F, $60, $4F, $60, $4F, $60, $4F, $60, $40, $60, $5F, $40, $3F
ds 9, $00
db $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $00, $16, $00, $16, $00, $16, $00
db $F6, $00, $06, $00, $FE, $00, $FE, $00, $00, $00, $4C, $63, $4C, $63, $4C, $63
db $4C, $63, $4C, $63, $20, $40, $40, $3F, $80, $00
ds 10, $FF
db $00, $00, $00, $FF, $00, $00, $F4, $F6, $F4, $F6, $F4, $F6, $F4, $F6, $F0, $F6
db $04, $02, $02, $FC, $00, $00, $F0
ds 9, $FF
db $00, $00, $00, $FF, $00, $00, $00, $F0, $00, $FF, $FC, $FF, $FF, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $00, $00, $00, $00, $F0, $00, $FF, $FC, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $00, $00, $00, $00, $0F, $00, $FF, $03, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $00, $00, $0F, $00, $FF, $03, $FF, $FF, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $00, $00, $FF, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF
db $00, $00, $00, $FF, $00, $00, $E0, $E0, $F0, $F8, $F8, $FE, $FE
ds 9, $FF
db $0F, $7F, $03, $0F, $00, $03, $00, $80, $80, $F0, $E0, $FC, $FC, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $3F, $FF, $03, $3F, $00, $03, $00, $00, $00, $C0, $00, $FC
db $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $1F, $FF, $00, $0F, $00, $00, $00, $00
db $00, $F8, $F5, $FF, $FE, $FF, $FF, $FF, $FF, $FF, $1F, $FF, $00, $0F, $00, $00
db $00, $00, $40, $FF, $AA, $FF, $F5, $FF, $FE, $FF, $FF, $FF, $00, $FF, $00, $00
db $00, $00, $00, $FF, $00, $FF, $40, $FF, $AA, $FF, $F5, $FF, $01, $FE, $00, $00
db $0A, $15, $01, $FE, $00, $FF, $00, $FF, $00, $FF, $47, $F8, $F0, $00, $00, $00
db $BF, $40, $55, $AA, $0A, $F5, $01, $FE, $07, $F8, $F0, $00, $00, $00, $00, $00
db $FF, $00, $FF, $00, $BF, $40, $54, $A8, $C0, $00, $00, $00, $00, $03, $00, $3F
db $FE, $00, $F0, $00, $C0, $00, $00, $01, $00, $0F, $00, $3F, $03, $FF, $0F, $FF
db $00, $07, $00, $1F, $01, $7F, $07, $FF, $1F, $FF, $7F, $FF, $FF, $FF, $FF, $FF
db $7F
ds 15, $FF
db $F8, $F9, $F8, $F9, $FC, $FC, $FC, $FC, $FE, $FE
ds 10, $FF
db $7F, $FF, $3F, $7F, $1F, $3F, $07, $1F, $81, $87, $C0, $C1, $47, $EF, $A1, $F3
db $F8, $FC, $FC, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $FF, $FF, $FF, $FF, $FF
db $7F, $FF, $1F, $3F, $03, $C7, $C0, $F8, $F8, $FF, $FF, $FF, $CF, $CF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF, $FF, $3F, $7F, $01, $83, $C0, $FC, $9F, $9F, $9F, $9F
ds 10, $FF
db $03, $07, $F2, $F2, $F2, $F2, $E0, $E0
ds 10, $FF
db $66, $66, $66, $66, $C2, $C2
ds 10, $FF
db $4C, $4C, $4C, $4C, $5F, $5F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $C0, $E0
db $C9, $C9, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FC, $FE, $81, $C0, $3F, $00
db $55, $FF, $FA, $FF, $FF, $FF, $F8, $FC, $C3, $E0, $1F, $00, $FF, $00, $FF, $00
db $53, $F0, $8F, $C0, $3F, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
db $FF, $00, $FF, $00, $FF, $00, $FE, $00, $FC, $00, $F8, $00, $E0, $01, $80, $03
db $87, $1F, $87, $1F, $07, $3F, $07, $3F, $0F, $7F, $0F, $FF, $1F, $FF, $3F, $FF
db $FE, $FE, $FC, $FD, $FC, $FD, $F9, $FB, $F9, $FB, $F9, $FB, $F9, $FB, $F9, $FB
db $55, $FD, $E9, $FD, $D5, $FD, $E8, $FD, $F4, $FE, $EA, $FE, $F5, $FF, $FA, $FF
db $24, $24, $A4, $A4, $E4, $E4, $F4, $F4, $FC, $FC, $7F, $FF, $3F, $7F, $9F, $9F
db $93, $B7, $90, $90, $12, $12, $92, $92, $90, $90, $93, $93, $D3, $D3, $FB, $FB
db $FF, $FF, $FF, $FF, $43, $43, $49, $4B, $C9, $C9, $C1, $C3, $CF, $CF, $CF, $CF
db $FF, $FF, $FF, $FF, $FF, $FF, $2F, $2F, $2F, $2F, $2F, $2F, $9F, $9F, $9F, $9F
db $75, $FF, $FB, $FF, $FF, $FF, $FF, $FF, $E0, $E0, $F2, $F2, $F2, $F2, $F0, $F0
db $50, $FF, $AA, $FF, $75, $FF, $FA, $FF, $C2, $C2, $66, $66, $66, $66, $E6, $E6
db $00, $FF, $AA, $FF, $50, $FF, $E8, $F8, $04, $0C, $48, $4C, $5C, $5C, $0C, $0C
db $00, $FF, $80, $FF, $00, $C9, $08, $49, $40, $C9, $80, $C1, $41, $C9, $C8, $C9
db $00, $EC, $00, $04, $00, $24, $00, $24, $00, $24, $20, $24, $00, $2F, $0A, $1F
db $00, $99, $00, $19, $00, $9B, $00, $9F, $00, $BF, $80, $FF, $00, $FE, $A9, $FC
db $15, $80, $AA, $00, $15, $80, $3A, $80, $7F, $00, $7F, $00, $FF, $00, $FF, $00
db $7F, $7F, $BF, $3F, $1F, $3F, $8F, $1F, $4F, $1F, $C7, $1F, $C7, $1F, $C7, $1F
db $FD, $FD, $FD, $FD, $FD, $FD, $F1, $F9, $E5, $E5, $C9, $DD, $95, $BD, $29, $7D
db $F8, $FF, $FE, $FF, $7F, $7F, $3F, $3F, $2F, $2F, $27, $27, $26, $26, $04, $04
db $1D, $3F, $00, $C7, $80, $F8, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3F, $3F
db $F8, $FF, $0F, $FF, $27, $7F, $00, $83, $00, $FC, $F0, $FF, $FF, $FF, $FF, $FF
db $47, $FF, $83, $FF, $FF, $FF, $88, $FF, $03, $07, $00, $F8, $55, $FF, $FA, $FF
db $FE, $FF, $FE, $FF, $FF, $FF, $FF, $FF, $07, $FF, $00, $00, $50, $FF, $AA, $FF
db $3F, $BF, $87, $FF, $84, $FF, $F8, $FF, $FF, $FF, $00, $00, $00, $FF, $AA, $FF
db $FF, $FF, $FF, $FF, $7F, $FF, $3F, $FF, $C0, $E0, $00, $1F, $00, $FF, $80, $FF
db $F8, $FF, $FF, $FF, $FC, $FE, $80, $C1, $00, $3F, $00, $FF, $00, $FF, $00, $FF
db $40, $FC, $82, $E1, $15, $0A, $AA, $55, $01, $FE, $2A, $D5, $00, $FF, $00, $FE
db $FF, $00, $FF, $00, $5E, $A0, $AA, $54, $50, $A2, $A2, $51, $01, $10, $08, $91
db $8F, $3F, $8F, $3F, $8F, $3F, $8F, $1F, $07, $87, $AB, $03, $15, $81, $AA, $00
db $FC, $FD, $FC, $FC, $FC, $FC, $FC
ds 9, $FD
db $7F, $FF, $FF, $FF, $7F, $FF, $1F, $7F, $17, $BF, $03, $CF, $80, $F3, $E0, $FC
db $C1
ds 13, $FF
db $7F, $FF, $EB, $F3, $E3, $FB, $EB, $FB, $EB, $FB, $EB, $FB, $EB, $FB, $E3, $FB
db $E8
ds 15, $FF
db $7F, $FF, $FC, $FD, $FE, $FE, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF
db $FE, $FF, $DF, $1F, $BF, $3F, $BF, $3F, $3F
ds 9, $BF
db $EB, $F3, $E3, $FB, $EB, $FB, $EB, $FB, $EB, $FB, $EB, $FB, $E3, $FB, $E8
ds 15, $FF
db $7E, $FF, $FF, $FF, $FF, $FF, $FE, $FF, $FC, $FE, $F9, $FC, $E2, $F0, $8D, $C0
db $3F, $00, $0F, $BF, $0F, $3F, $0F, $3F, $8F, $3F, $0F, $3F, $8F, $3F, $0F, $3F
db $8F, $3F, $FF, $FF, $FF, $FF, $FE, $FE, $FC, $FE, $FC, $FD, $FC, $FD, $FC, $FD
db $FC, $FD, $91, $9D, $15, $7D, $35, $FD, $75, $FD, $F5, $FD, $71, $FD, $F4, $FF
db $7C
ds 13, $FF
db $3F, $FF, $23, $FF, $FF, $FF, $F7, $F7, $EB, $EB, $E3, $EB, $D3, $DB, $C9, $D1
db $CD, $D1, $EB, $E3, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $FE, $FE, $FE
db $FD, $FD, $FC, $FD, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $7F, $BF, $BF, $3F, $BF
db $3F, $BF, $9F, $1F, $FF, $FF, $F7, $F7, $EB, $EB, $E3, $EB, $D3, $DB, $C9, $D1
db $CD, $D1, $EB, $E3, $C1, $F1, $D0, $F6, $D6, $F7, $D6, $F7, $D7, $F7, $C7, $F7
db $D0, $FF, $F0, $FF, $FF, $FF, $FF, $FF, $7F, $7F, $3F, $7F, $1F, $BF, $1F, $BF
db $0F, $BF, $0F, $BF, $FB, $FB, $F5, $F5, $F0, $F5, $E8, $ED, $E4, $E8, $E6, $E8
db $F4, $F1, $C5, $E9, $FF, $FF, $FF, $FF, $F0, $F8, $00, $C7, $04, $3F, $0B, $FF
db $3F, $FF, $FF, $FF, $E8, $F8, $08, $9B, $29, $7B, $6B, $FB, $E3, $FB, $E8, $FF
db $F8, $FF, $FF, $FF, $00, $07, $04, $FF, $10, $FF, $FF, $FF, $FF, $FF, $7F, $FF
db $47, $FF, $83, $FF, $02, $FF, $12, $FF, $7A, $FF, $FE
ds 9, $FF
db $80, $BF, $A0, $BF, $3F, $BF, $87, $FF, $84, $FF, $F8, $FF, $FF, $FF, $FF, $FF
db $00, $E0, $60, $FF, $E3, $FF, $FF, $FF, $7F, $FF, $3F, $FF, $FF, $FF, $FF, $FF
db $08, $1B, $28, $F9, $A8, $FA, $EA, $FB, $E3, $FB, $E8, $FF, $F8, $FF, $FF, $FF
db $FF, $3C, $E3, $62, $EE, $60, $FF, $F8, $E3, $60, $EF, $60, $FF, $FE, $80, $00
db $FF, $FF, $FF, $FF, $0F, $1F, $01, $E3, $E0, $FC, $7C, $FF, $47, $FF, $83, $FF
db $EF, $EF, $D7, $D7, $C3, $D7, $A1, $B7, $11, $A3, $19, $23, $10, $C7, $D0, $E7
db $EB, $EB, $E1, $EB, $D0, $DB, $C8, $D1, $CC, $D1, $E8, $E3, $E8, $F3, $E0, $FB
ds 10, $FF
db $7F, $FF, $7F, $FF, $F0, $F8, $FD, $FD, $FC, $FD, $FC, $FD, $FE, $FE, $FE, $FF
db $FE, $FF, $FE, $FF, $00, $01, $0F, $BF, $8F, $1F, $CF, $1F, $87, $3F, $87, $3F
db $0F, $BF, $8F, $BF, $80, $80
ds 14, $FF
db $0F, $1F, $EB, $EB, $E1, $EB, $D0, $DB, $C8, $D1, $CC, $D1, $E8, $E3, $E8, $F3
db $E0, $FB
ds 10, $FF
db $7F, $FF, $7F
ds 17, $FF
db $F7, $F7
ds 12, $FF
db $FE, $FE, $FE, $FE
ds 10, $FF
db $7F, $7F, $BF, $BF, $1F, $BF
ds 14, $FF
db $F7, $F7, $03, $03, $79, $FD, $64, $66, $66, $66, $66, $66, $66, $66, $64, $66
db $7C, $7C, $64
ds 9, $66
db $64, $66, $78, $FC, $00, $01, $00, $03, $01, $FF, $03
ds 21, $FF
db $E7, $E7, $DB, $DB, $DB, $DB, $DB, $DB, $99, $BD, $99, $99, $99, $DB, $99, $DB
db $D9, $D9, $CE, $CE, $C0, $E0, $C0, $F1, $E0, $FF, $F1
ds 21, $FF
db $9F, $9F, $6F, $6F, $6F, $6F, $63, $63, $79, $7D, $64
ds 9, $66
db $00, $00, $00, $99, $00, $FF, $99
ds 21, $FF
db $F9, $F9, $F6, $F6, $F6, $F6, $C6, $C6, $9E, $BE, $26, $66, $66, $66, $66, $66
db $26, $66, $1E, $3E, $00, $80, $00, $C1, $80, $FF, $C1
ds 11, $FF
db $0F, $0F, $24, $24, $24, $24, $04, $04, $24, $24, $24, $24, $E4, $E4, $FC, $FC
ds 10, $FF
db $7F, $FF, $3F, $7F, $9F, $9F, $F8, $FF, $FE
ds 13, $FF
db $1D, $3F, $00, $C7, $80, $F8, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $BF, $BF
db $FF, $FF, $7F, $7F, $B3, $B3, $90, $90
ds 10, $92
db $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $3F, $7F, $01, $83, $C0, $FC, $FF, $FF
db $FF, $FF, $FF, $FF, $C7, $C7, $62, $62, $66, $66, $66, $66, $66, $66, $66, $66
db $47, $47, $F3, $FB, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $03, $07, $75, $FF
db $FB, $FF, $FF, $FF, $FF, $FF, $48, $48, $49, $49, $49, $49, $48, $48, $49, $49
db $19, $19, $B8, $B8
ds 10, $FF
db $50, $FF, $AA, $FF, $75, $FF, $FA, $FF, $21, $21, $E4, $E4, $E4, $E4, $61, $61
db $E4, $E4, $E4, $E4, $24, $24
ds 10, $FF
db $00, $FF, $AA, $FF, $50, $FF, $E2, $E3, $D6, $DE, $9A, $9E, $86, $86, $D2, $D2
db $F2, $F2, $C6, $E6, $9F, $DF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $C0, $E0
db $00, $FF, $80, $FE, $00, $D9, $08, $09, $40, $48, $08, $49, $01, $09, $48, $49
db $49, $49, $7F, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $FC, $FE, $81, $C0, $3F, $00
db $40, $FC, $82, $E1, $15, $0A, $AA, $55, $01, $FE, $2A, $D5, $00, $FF, $00, $FD
db $00, $E5, $00, $65, $00, $27, $00, $33, $00, $73, $20, $33, $00, $33, $2A, $3F
db $FF, $00, $FF, $00, $5F, $A0, $AA, $55, $55, $AA, $AA, $55, $05, $FA, $2A, $D5
db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $80, $FF, $00, $FE, $A9, $FC
db $92, $92, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $3F, $7F, $01, $83, $C0, $FC
db $80, $F8, $F0, $FF, $7F, $FF, $1F, $3F, $03, $C7, $C0, $F8, $F8, $FF, $FF, $FF
db $3F, $7F, $01, $83, $00, $FC, $F8, $FF, $FF, $FF, $3F, $7F, $01, $83, $C0, $FC
db $FF, $FF, $FF, $FF, $03, $07, $00, $F8, $F0, $FF, $FF, $FF, $FF, $FF, $03, $07
db $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
ds 11, $FF
db $C0, $E0, $00, $1F, $0F, $FF, $FF, $FF, $FF, $FF, $C0, $E0, $FC, $FE, $80, $C1
db $00, $3F, $1F, $FF, $FF, $FF, $FC, $FE, $81, $C0, $3F, $00, $01, $1F, $0A, $FF
db $FF, $FF, $F8, $FC, $C3, $E0, $1F, $00, $FF, $00, $FF, $00, $54, $FC, $E8, $FD
db $D5, $FD, $E8, $FD, $F4, $FE, $EA, $FE, $F5, $FF, $FA, $FF, $FF, $FF, $7F, $7F
db $3F, $BF, $8F, $CF, $C3, $F3, $60, $FC, $38, $7F, $9E, $9F, $87, $C7, $F0, $F8
db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $1F, $3F, $03, $C7, $FF, $FF, $7F, $7F
db $03, $83, $F8, $FC
ds 14, $FF
db $07, $07, $F0, $F8, $FF, $FF, $FF, $FF, $FF, $FF, $75, $FF, $FB, $FF, $FF, $FF
db $FF, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $50, $FF, $AA, $FF, $75, $FF
db $FA, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $AA, $FF, $50, $FF
db $E0, $E0, $0D, $1F, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $80, $FE, $00, $C1
db $08, $3F, $55, $FF, $A8, $FF, $F5, $FF, $FE, $FF, $00, $E3, $00, $1F, $00, $FF
db $00, $FF, $00, $FF, $20, $FF, $00, $FC, $80, $E3, $00, $FF, $00, $FE, $00, $FD
db $00, $F3, $00, $CF, $00, $3F, $00, $FE, $29, $FC, $15, $00, $AA, $00, $15, $80
db $3A, $80, $7F, $00, $7F, $00, $FF, $00, $FF, $00, $FD, $FD, $FC, $FC, $FD, $FD
db $F1, $F9, $E5, $E5, $C9, $DD, $95, $BD, $29, $7D, $F8, $FF, $FE, $FF, $7F, $7F
db $BF, $BF, $CF, $CF, $E3, $F3, $F8, $FC, $FE, $FF, $1D, $3F, $00, $C7, $80, $F8
db $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3F, $3F, $FF, $00, $FF, $00, $5E, $A0
db $A8, $55, $51, $A2, $82, $4D, $05, $3A, $2A, $D5, $8F, $3F, $0F, $3F, $8F, $3F
db $8F, $1F, $07, $87, $AB, $03, $15, $81, $2A, $80, $F9, $F9, $F6, $F6, $F7, $F7
db $F7, $F7, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F6, $F9, $F9, $F6, $F6, $6E, $6E
db $9E, $9E, $F6, $F6, $66, $66, $06, $06, $06, $96
ds 12, $F6
db $EE, $EE, $E0, $E0, $06, $F6, $96
ds 9, $F6
db $F7, $F7, $F0, $F0, $E0, $F1, $E0, $FF, $F1
ds 11, $FF
db $F0, $F8, $F0, $FF, $F8
ds 11, $FF
db $00, $C3, $01, $FF, $C3
ds 11, $FF
db $C1, $C1, $9E, $BE, $20, $60, $60, $61, $60, $6F, $61
ds 15, $6F
db $21, $61, $1E, $3E, $00, $80, $00, $C1, $80, $FF, $C1
ds 11, $FF
db $99, $99, $66, $66, $7E, $7E, $66, $66, $66, $66, $66, $66, $66, $66, $00, $00
db $00, $99, $00, $FF, $99
ds 11, $FF
db $18, $18, $66, $66, $66, $66, $66, $66, $66, $66, $7E, $7E, $66, $66, $00, $00
db $00, $99, $00, $FF, $99
ds 21, $FF
db $E7, $E7, $DB, $DB, $C3, $C3, $C3, $E7, $C3, $FF, $E7
ds 11, $FF
db $00, $00, $7E, $FF, $60, $60, $60, $60, $60, $6F, $60, $6F, $63, $63, $79, $7D
db $61, $61, $61, $63, $61, $6F, $63, $6F, $6F, $6F, $60, $60, $7E, $FF, $00, $00
db $00, $00, $00, $FF, $00
ds 11, $FF

; Data from 178FC to 17A63 (360 bytes)
_DATA_178FC_:
ds 160, $00
db $5F, $60, $61, $65, $66, $67, $6B, $6C, $6B, $6C, $71, $72, $75, $76, $79, $7A
db $7B, $7F, $80, $81, $62, $63, $64, $68, $69, $6A, $6D, $6E, $6F, $70, $73, $74
db $77, $78, $7C, $7D, $7E, $82, $83, $84, $85, $86, $89, $8A, $8D, $8E, $91, $92
db $95, $96, $99, $9A, $9D, $9E, $A1, $A2, $85, $86, $91, $92, $87, $88, $8B, $8C
db $8F, $90, $93, $94, $97, $98, $9B, $9C, $9F, $A0, $A3, $A4, $A5, $A6, $A7, $A8
db $F5, $85, $86, $AB, $AC, $91, $86, $8D, $8E, $85, $B3, $B5, $B6, $6B, $B8, $B9
db $BA, $B9, $6C, $F2, $F6, $A9, $AA, $AD, $AE, $AF, $B0, $B1, $B2, $87, $B4, $A9
db $AA, $B7, $A0, $93, $BB, $AF, $BC, $F3, $F7, $F5, $BD, $BE, $C1, $C2, $85, $C5
db $B5, $B6, $91, $92, $CB, $CC, $CF, $D0, $D2, $D3, $D4, $F3, $F9, $F8, $BF, $C0
db $C3, $C4, $87, $C6, $C7, $C8, $C9, $CA, $CD, $CE, $CD, $D1, $D5, $D6, $D7, $F4
db $D8, $D9, $DA, $DE, $DF, $E2, $E3, $E4, $E5, $E6, $E6, $E6, $E6, $E6, $E6, $6C
db $EC, $ED, $6B, $6C, $DB, $DC, $DD, $E0, $E1, $E7, $E8, $E9, $EA, $EB, $EB, $EB
db $EB, $EB, $EB, $70, $EE, $EF, $F0, $F1

; Data from 17A64 to 17CAC (585 bytes)
_DATA_17A64_:
ds 160, $00
db $5F, $60, $61, $65, $66, $67, $F3, $8D, $AB, $F1, $6B, $6C, $6F, $70, $73, $74
db $75, $79, $7A, $7B, $62, $63, $64, $68, $69, $6A, $F4, $EA, $B6, $F2, $6D, $6E
db $71, $72, $76, $77, $78, $7C, $7D, $7E, $7F, $80, $83, $84, $83, $84, $89, $8A
db $89, $8D, $89, $8F, $89, $91, $EB, $8D, $93, $94, $97, $98, $81, $82, $85, $86
db $87, $88, $8B, $8C, $8B, $8E, $8B, $90, $8B, $92, $EC, $EA, $95, $96, $99, $9A
db $FB, $9B, $9C, $9F, $A0, $A3, $A4, $A5, $A6, $AB, $8D, $AC, $AD, $B0, $B1, $ED
db $8D, $F5, $EF, $F6, $FC, $9D, $9E, $A1, $88, $A2, $88, $A7, $A8, $A9, $AA, $AE
db $AF, $B2, $B3, $EE, $EA, $B6, $F0, $F7, $FE, $F9, $B4, $84, $B7, $84, $B7, $84
db $E9, $8D, $BC, $BD, $C0, $C1, $C4, $C5, $C8, $C9, $CA, $F7, $FD, $FA, $B6, $B5
db $B8, $88, $B9, $BA, $BB, $EA, $BE, $BF, $C2, $C3, $C6, $C7, $CB, $CC, $CD, $F8
db $CE, $CF, $D0, $B7, $D4, $D7, $D8, $D9, $DA, $DF, $DF, $DF, $DF, $DF, $DF, $8D
db $E1, $E2, $E5, $E6, $D1, $D2, $D3, $D5, $D6, $DB, $DC, $DD, $DE, $E0, $E0, $E0
db $E0, $E0, $E0, $EA, $E3, $E4, $E7, $E8, $00, $00, $00, $FF, $82, $81, $0A, $01
db $0A, $01, $1A, $01, $02, $01, $FE, $01, $00, $01, $00, $FF, $40
ds 9, $00
db $FF, $00, $00, $00, $00, $FF, $02, $01, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $47, $07, $00, $00, $00, $00, $00, $00, $00, $00
db $FF, $00, $00, $00, $00, $FF, $C2, $C1, $0A, $01, $0A, $01, $1A, $01, $02, $01
db $FE, $01, $00, $01, $00, $FF, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F, $4D, $3F
db $4D, $3F, $4D, $3F, $40, $3F, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC, $B2, $FC
db $B2, $FC, $B2, $FC, $02, $FC, $D0, $E5, $F5, $0A, $1F, $34, $48, $51, $62, $6D
db $7B, $8C, $99, $AA, $B3, $C7, $DB, $EF, $04, $18, $2D, $42, $56, $6B, $76, $8A
db $9E, $B2, $C6, $DA, $EE, $02, $16, $2A, $3E, $52, $66, $7A, $8E, $A2, $B6, $CA
db $DE, $F2, $FE, $0D, $16, $25, $3B, $4B, $58, $66, $73, $80, $92, $92, $A5, $B9
db $C0, $C8, $CE, $D4, $D8, $DD, $E2, $E9, $F3, $FB, $04, $0D, $0F, $11, $13, $15
db $24, $2F, $35, $3A, $46, $55, $68, $7A, $8D, $98, $AC, $C0, $D4, $E8, $FC, $10
db $24, $38, $4C, $60, $74, $88, $9C, $B0, $C5, $D1, $E1, $F2, $01, $06, $10, $24
db $38, $4C, $5F

_LABEL_17CAD_:
	ld   bc, $0012
	add  hl, bc
	scf
	ldi  a, [hl]
	adc  a
	add  a
	jp   _LABEL_17D47_

_LABEL_17CB8_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17CF5_

_LABEL_17CBD_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17CFA_

_LABEL_17CC2_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17CFF_

_LABEL_17CC7_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17D0E_

_LABEL_17CCC_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17CD6_

_LABEL_17CD1_:
	ld   c, $04
_LABEL_17CD3_:
	add  a
	jr   z, _LABEL_17CCC_
_LABEL_17CD6_:
	rl   b
	dec  c
	jr   nz, _LABEL_17CD3_
	push af
	ld   a, $03
	add  b
	add  a
	ld   c, a
_LABEL_17CE1_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  c
	jr   nz, _LABEL_17CE1_
	pop  af
	jp   _LABEL_17D47_

_LABEL_17CEE_:
	ldi  a, [hl]
	adc  a
	jr   c, _LABEL_17D5C_
_LABEL_17CF2_:
	add  a
	jr   z, _LABEL_17CB8_
_LABEL_17CF5_:
	rl   c
	add  a
	jr   z, _LABEL_17CBD_
_LABEL_17CFA_:
	jr   nc, _LABEL_17D0B_
	add  a
	jr   z, _LABEL_17CC2_
_LABEL_17CFF_:
	dec  c
	push hl
	ld   h, a
	ld   a, c
	adc  a
	ld   c, a
	cp   $09
	ld   a, h
	pop  hl
	jr   z, _LABEL_17CD1_
_LABEL_17D0B_:
	add  a
	jr   z, _LABEL_17CC7_
_LABEL_17D0E_:
	jr   nc, _LABEL_17D2A_
	add  a
	jr   nz, _LABEL_17D15_
	ldi  a, [hl]
	adc  a
_LABEL_17D15_:
	rl   b
	add  a
	jr   nz, _LABEL_17D1C_
	ldi  a, [hl]
	adc  a
_LABEL_17D1C_:
	jr   c, _LABEL_17D76_
	inc  b
	dec  b
	jr   nz, _LABEL_17D2A_
	inc  b
_LABEL_17D23_:
	add  a
	jr   nz, _LABEL_17D28_
	ldi  a, [hl]
	adc  a
_LABEL_17D28_:
	rl   b
_LABEL_17D2A_:
	push af
	ld   a, e
	sub  [hl]
	push hl
	ld   l, a
	ld   a, d
	sbc  a, b
	ld   h, a
	dec  hl
_LABEL_17D33_:
	ldi  a, [hl]
	ld   [de], a
	inc  de
	dec  c
	jr   nz, _LABEL_17D33_
	pop  hl
	inc  hl
	pop  af
	jr   _LABEL_17D47_

_LABEL_17D3E_:
	ldi  a, [hl]
	adc  a
	jr   c, _LABEL_17D54_
_LABEL_17D42_:
	push af
	ldi  a, [hl]
	ld   [de], a
	inc  de
	pop  af
_LABEL_17D47_:
	add  a
	jr   c, _LABEL_17D52_
	push af
	ldi  a, [hl]
	ld   [de], a
	inc  de
	pop  af
	add  a
	jr   nc, _LABEL_17D42_
_LABEL_17D52_:
	jr   z, _LABEL_17D3E_
_LABEL_17D54_:
	ld   bc, $0002
	add  a
	jr   z, _LABEL_17CEE_
	jr   nc, _LABEL_17CF2_
_LABEL_17D5C_:
	add  a
	jr   z, _LABEL_17D89_
_LABEL_17D5F_:
	jr   nc, _LABEL_17D2A_
	inc  c
	add  a
	jr   z, _LABEL_17D8E_
_LABEL_17D65_:
	jr   nc, _LABEL_17D0B_
	ld   c, [hl]
	inc  hl
	inc  c
	dec  c
	jr   z, _LABEL_17D93_
	push af
	ld   a, c
	add  $08
	ld   c, a
	pop  af
	jp   _LABEL_17D0B_

_LABEL_17D76_:
	add  a
	jr   nz, _LABEL_17D7B_
	ldi  a, [hl]
	adc  a
_LABEL_17D7B_:
	rl   b
	set  2, b
	add  a
	jr   nz, _LABEL_17D84_
	ldi  a, [hl]
	adc  a
_LABEL_17D84_:
	jr   c, _LABEL_17D2A_
	jp   _LABEL_17D23_

_LABEL_17D89_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17D5F_

_LABEL_17D8E_:
	ldi  a, [hl]
	adc  a
	jp   _LABEL_17D65_

_LABEL_17D93_:
	add  a
	jr   nz, _LABEL_17D98_
	ldi  a, [hl]
	adc  a
_LABEL_17D98_:
	jr   c, _LABEL_17D47_
	ret

; Data from 17D9B to 17FFF (613 bytes)
db $D0, $E5, $F5, $0A, $1F, $34, $42, $4B, $5C, $65, $75, $86, $93, $9F, $A8, $BC
db $D0, $E4, $F9, $0D, $20, $34, $42, $57, $63, $77, $8B, $9F, $B3, $C7, $DB, $EF
db $03, $17, $2B, $3F, $53, $67, $7B, $8F, $A3, $B7, $CB, $DF, $EB, $00, $09, $14
db $25, $34, $3F, $4B, $56, $63, $78, $78, $8D, $A0, $A8, $B1, $B7, $BD, $C1, $C6
db $CB, $D2, $DC, $E4, $ED, $F6, $F8, $FA, $FC, $FE, $0C, $17, $1D, $22, $2D, $3B
db $4B, $5C, $6C, $77, $8B, $9F, $B3, $C7, $DB, $EF, $03, $17, $2B, $3F, $53, $67
db $7B, $8F, $A4, $AF, $B8, $C2, $CE, $D3, $DD, $EC, $00, $14, $21, $2E, $3D, $4D
db $61, $73, $86, $97, $AC, $BE, $CE, $E2, $F1, $FE, $0D, $1D, $31, $43, $56, $67
db $7C, $8E, $9E, $B2, $C1, $D6, $EB, $FA, $04, $0D, $14, $1E, $27, $2D, $42, $57
db $6C, $81, $96, $AB, $C0, $CE, $D7, $DF, $E5, $EE, $F6, $FB, $08, $15, $29, $3D
db $51, $65, $79, $8D, $A0, $B5, $C9, $DD, $F1, $05, $12, $1F, $2C, $40, $45, $58
db $6B, $78, $8C, $93, $9C, $AF, $C2, $D6, $E7, $F8, $0D, $21, $34, $48, $5B, $63
db $6A, $71, $79, $81, $8B, $95, $9F, $A9, $B3, $BD, $C7, $D1, $DB, $E5, $EF, $F9
db $11, $26, $36, $4B, $60, $75, $8A, $9E, $B2, $C6, $DA, $EE, $02, $16, $2A, $3E
db $53, $68, $7D, $92, $A7, $B7, $C6, $DA, $D0, $E5, $F5, $0A, $1F, $34, $47, $50
db $61, $6E, $7A, $8B, $98, $A5, $AE, $C2, $D6, $EA, $FF, $13, $27, $3B, $4E, $63
db $71, $85, $99, $AD, $C1, $D5, $E9, $FD, $11, $25, $39, $4D, $61, $75, $89, $9D
db $B1, $C5, $D9, $ED, $F9, $0A, $13, $1E, $31, $3C, $4B, $52, $5D, $71, $85, $85
db $98, $AB, $B3, $BB, $C0, $C6, $CA, $CF, $D7, $DC, $E6, $EE, $F7, $00, $03, $03
db $03, $05, $1A, $2C, $33, $39, $49, $52, $68, $79, $8E, $99, $AD, $C1, $D5, $E9
db $FD, $11, $25, $39, $4D, $61, $75, $89, $9D, $B1, $C6, $D3, $E0, $F0, $01, $06
db $10, $24, $38, $4C, $5F, $6C, $7C, $8C, $A0, $B2, $C7, $D8, $ED, $02, $13, $27
db $36, $43, $53, $63, $77, $89, $9E, $AF, $C4, $D9, $EA, $FE, $0D, $22, $34, $43
db $4D, $56, $5E, $68, $7A, $80, $95, $AA, $BF, $D4, $E9, $FE, $13, $21, $2A, $32
db $39, $42, $53, $58, $65, $72, $86, $9A, $AE, $C2, $D6, $EA, $FF, $14, $28, $3C
db $50, $64, $73, $82, $91, $A6, $AB, $BE, $D1, $DF, $F3, $FA, $03, $16, $29, $3D
db $4C, $5C, $71, $85, $98, $AC, $BF, $C7, $D0, $D9, $E2, $EA, $F4, $FE, $08, $12
db $1C, $26, $30, $3A, $44, $4E, $58, $62, $7A, $8F, $A4, $B9, $CE, $E3, $F8, $0C
db $20, $34, $48, $5C, $70, $84, $98, $AC, $C1, $D6, $EA, $FE, $12, $24, $39, $4D
ds 149, $00

SECTION "rom6", ROMX, BANK[$6]
; Data from 18000 to 1BFFF (16384 bytes)
db $00, $43, $4F, $4E, $43, $45, $52, $54, $00, $4B, $4F, $4E, $5A, $45, $52, $54
db $00, $43, $4F, $4E, $43, $45, $52, $54, $00, $43, $4F, $4E, $43, $49, $45, $52
db $54, $4F, $00, $43, $4F, $4E, $43, $45, $52, $54, $4F, $00, $54, $48, $45, $41
db $54, $52, $45, $00, $54, $48, $45, $41, $54, $45, $52, $00, $54, $48, $45, $41
db $54, $52, $45, $00, $54, $45, $41, $54, $52, $4F, $00, $54, $45, $41, $54, $52
db $4F, $00, $43, $49, $4E, $45, $4D, $41, $00, $4B, $49, $4E, $4F, $00, $43, $49
db $4E, $45, $4D, $41, $00, $43, $49, $4E, $45, $00, $43, $49, $4E, $45, $4D, $41
db $00, $43, $41, $53, $49, $4E, $4F, $00, $53, $50, $49, $45, $4C, $4B, $41, $53
db $49, $4E, $4F, $00, $43, $41, $53, $49, $4E, $4F, $00, $43, $41, $53, $49, $4E
db $4F, $00, $43, $41, $53, $49, $4E, $4F, $00, $43, $49, $52, $43, $55, $53, $00
db $5A, $49, $52, $4B, $55, $53, $00, $43, $49, $52, $51, $55, $45, $00, $43, $49
db $52, $43, $4F, $00, $43, $49, $52, $43, $4F, $00, $43, $4F, $4D, $50, $45, $54
db $49, $54, $49, $4F, $4E, $00, $57, $45, $54, $54, $4B, $41, $4D, $50, $46, $00
db $43, $4F, $4D, $50, $45, $54, $49, $54, $49, $4F, $4E, $00, $43, $4F, $4D, $50
db $45, $54, $49, $43, $49, $4F, $4E, $00, $47, $41, $52, $41, $00, $44, $41, $4E
db $43, $45, $00, $54, $41, $4E, $5A, $00, $44, $41, $4E, $53, $45, $00, $42, $41
db $49, $4C, $45, $00, $44, $41, $4E, $5A, $41, $00, $42, $4F, $58, $20, $4F, $46
db $46, $49, $43, $45, $00, $54, $48, $45, $41, $54, $45, $52, $4B, $41, $53, $53
db $45, $00, $42, $55, $52, $45, $41, $55, $20, $44, $45, $20, $4C, $4F, $43, $41
db $54, $49, $4F, $4E, $00, $54, $41, $51, $55, $49, $4C, $4C, $41, $00, $42, $49
db $47, $4C, $49, $45, $54, $54, $45, $52, $49, $41, $00, $54, $49, $43, $4B, $45
db $54, $53, $00, $45, $49, $4E, $54, $52, $49, $54, $54, $53, $4B, $41, $52, $54
db $45, $4E, $00, $42, $49, $4C, $4C, $45, $54, $53, $00, $42, $49, $4C, $4C, $45
db $54, $45, $53, $00, $42, $49, $47, $4C, $49, $45, $54, $54, $49, $00, $4F, $50
db $45, $52, $41, $00, $4F, $50, $45, $52, $00, $4F, $50, $45, $52, $41, $00, $4F
db $50, $45, $52, $41, $00, $4F, $50, $45, $52, $41, $00, $50, $4C, $41, $59, $00
db $53, $43, $48, $41, $55, $53, $50, $49, $45, $4C, $00, $50, $49, $45, $43, $45
db $20, $44, $45, $20, $54, $48, $45, $41, $54, $52, $45, $00, $4F, $42, $52, $41
db $20, $44, $45, $20, $54, $45, $41, $54, $52, $4F, $00, $43, $4F, $4D, $4D, $45
db $44, $49, $41, $00, $42, $41, $4C, $4C, $45, $54, $00, $42, $41, $4C, $4C, $45
db $54, $54, $00, $42, $41, $4C, $4C, $45, $54, $00, $42, $41, $4C, $4C, $45, $54
db $00, $42, $41, $4C, $4C, $45, $54, $54, $4F, $00, $4F, $52, $43, $48, $45, $53
db $54, $52, $41, $00, $4F, $52, $43, $48, $45, $53, $54, $45, $52, $00, $4F, $52
db $43, $48, $45, $53, $54, $52, $45, $00, $4F, $52, $51, $55, $45, $53, $54, $41
db $00, $4F, $52, $43, $48, $45, $53, $54, $52, $41, $00, $4E, $49, $47, $48, $54
db $20, $43, $4C, $55, $42, $00, $4E, $41, $43, $48, $54, $4B, $4C, $55, $42, $00
db $4E, $49, $47, $48, $54, $2D, $43, $4C, $55, $42, $00, $43, $4C, $55, $42, $20
db $4E, $4F, $43, $54, $55, $52, $4E, $4F, $00, $4E, $49, $47, $48, $54, $2D, $43
db $4C, $55, $42, $00, $44, $45, $4E, $54, $49, $53, $54, $00, $5A, $41, $48, $4E
db $41, $52, $5A, $54, $00, $44, $45, $4E, $54, $49, $53, $54, $45, $00, $44, $45
db $4E, $54, $49, $53, $54, $41, $00, $44, $45, $4E, $54, $49, $53, $54, $41, $00
db $43, $48, $45, $4D, $49, $53, $54, $00, $41, $50, $4F, $54, $48, $45, $4B, $45
db $00, $50, $48, $41, $52, $4D, $41, $43, $49, $45, $00, $46, $41, $52, $4D, $41
db $43, $49, $41, $00, $46, $41, $52, $4D, $41, $43, $49, $41, $00, $54, $41, $42
db $4C, $45, $54, $53, $00, $54, $41, $42, $4C, $45, $54, $54, $45, $4E, $00, $54
db $41, $42, $4C, $45, $54, $54, $45, $53, $00, $54, $41, $42, $4C, $45, $54, $41
db $53, $00, $50, $41, $53, $54, $49, $47, $4C, $49, $45, $00, $43, $4F, $54, $54
db $4F, $4E, $20, $57, $4F, $4F, $4C, $00, $57, $41, $54, $54, $45, $00, $43, $4F
db $54, $4F, $4E, $00, $41, $4C, $47, $4F, $44, $4F, $4E, $00, $4F, $56, $41, $54
db $54, $41, $00, $42, $41, $4E, $44, $41, $47, $45, $00, $4D, $55, $4C, $4C, $42
db $49, $4E, $44, $45, $00, $42, $41, $4E, $44, $45, $00, $56, $45, $4E, $44, $41
db $00, $42, $45, $4E, $44, $41, $00, $4F, $49, $4E, $54, $4D, $45, $4E, $54, $00
db $53, $41, $4C, $42, $45, $00, $4F, $4E, $47, $55, $45, $4E, $54, $00, $55, $4E
db $47, $55, $45, $4E, $54, $4F, $00, $55, $4E, $47, $55, $45, $4E, $54, $4F, $00
db $48, $45, $41, $44, $41, $43, $48, $45, $00, $4B, $4F, $50, $46, $53, $43, $48
db $4D, $45, $52, $5A, $45, $4E, $00, $4D, $41, $4C, $20, $44, $45, $20, $54, $45
db $54, $45, $00, $44, $4F, $4C, $4F, $52, $20, $44, $45, $20, $43, $41, $42, $45
db $5A, $41, $00, $4D, $41, $4C, $20, $44, $49, $20, $54, $45, $53, $54, $41, $00
db $4C, $41, $58, $41, $54, $49, $56, $45, $00, $41, $42, $46, $38, $48, $52, $4D
db $49, $54, $54, $45, $4C, $00, $4C, $41, $58, $41, $54, $49, $46, $00, $4C, $41
db $58, $41, $4E, $54, $45, $00, $4C, $41, $53, $53, $41, $54, $49, $56, $4F, $00
db $41, $4E, $54, $49, $53, $45, $50, $54, $49, $43, $00, $41, $4E, $54, $49, $53
db $45, $50, $54, $49, $53, $43, $48, $45, $20, $4D, $49, $54, $54, $45, $4C, $00
db $50, $52, $4F, $44, $55, $49, $54, $20, $41, $4E, $54, $49, $53, $45, $50, $54
db $49, $51, $55, $45, $00, $41, $4E, $54, $49, $53, $45, $50, $54, $49, $43, $4F
db $00, $41, $4E, $54, $49, $53, $45, $54, $54, $49, $43, $4F, $00, $53, $45, $44
db $41, $54, $49, $56, $45, $53, $00, $53, $43, $48, $4D, $45, $52, $5A, $54, $41
db $42, $4C, $45, $54, $54, $45, $4E, $00, $43, $41, $4C, $4D, $41, $4E, $54, $53
db $00, $43, $41, $4C, $4D, $41, $4E, $54, $45, $53, $00, $43, $41, $4C, $4D, $41
db $4E, $54, $49, $2F, $53, $45, $44, $41, $54, $49, $56, $49, $00, $43, $4F, $4E
db $54, $52, $41, $43, $45, $50, $54, $49, $56, $45, $53, $00, $56, $45, $52, $48
db $38, $54, $55, $4E, $47, $53, $4D, $49, $54, $54, $45, $4C, $00, $43, $4F, $4E
db $54, $52, $41, $43, $45, $50, $54, $49, $46, $53, $00, $41, $4E, $54, $49, $43
db $4F, $4E, $43, $45, $50, $54, $49, $56, $4F, $53, $00, $43, $4F, $4E, $54, $52
db $41, $43, $43, $45, $54, $54, $49, $56, $49, $00, $43, $4F, $4E, $44, $4F, $4D
db $00, $4B, $4F, $4E, $44, $4F, $4D, $00, $50, $52, $45, $53, $45, $52, $56, $41
db $54, $49, $46, $00, $43, $4F, $4E, $44, $4F, $4E, $00, $50, $52, $45, $53, $45
db $52, $56, $41, $54, $49, $56, $4F, $00, $56, $49, $54, $41, $4D, $49, $4E, $53
db $00, $56, $49, $54, $41, $4D, $49, $4E, $54, $41, $42, $4C, $45, $54, $54, $45
db $4E, $00, $56, $49, $54, $41, $4D, $49, $4E, $45, $53, $00, $56, $49, $54, $41
db $4D, $49, $4E, $41, $53, $00, $56, $49, $54, $41, $4D, $49, $4E, $45, $00, $53
db $41, $4E, $49, $54, $41, $52, $59, $20, $50, $41, $44, $00, $4D, $4F, $4E, $41
db $54, $53, $42, $49, $4E, $44, $45, $00, $53, $45, $52, $56, $49, $45, $54, $54
db $45, $20, $48, $59, $47, $49, $45, $4E, $49, $51, $55, $45, $00, $43, $4F, $4D
db $50, $52, $45, $53, $41, $20, $48, $49, $47, $49, $45, $4E, $49, $43, $41, $00
db $41, $53, $53, $4F, $52, $42, $45, $4E, $54, $49, $00, $50, $52, $45, $53, $43
db $52, $49, $50, $54, $49, $4F, $4E, $00, $52, $45, $5A, $45, $50, $54, $00, $4F
db $52, $44, $4F, $4E, $4E, $41, $4E, $43, $45, $00, $52, $45, $43, $45, $54, $41
db $00, $52, $49, $43, $45, $54, $54, $41, $00, $44, $4F, $43, $54, $4F, $52, $00
db $41, $52, $5A, $54, $00, $4D, $45, $44, $45, $43, $49, $4E, $00, $4D, $45, $44
db $49, $43, $4F, $00, $4D, $45, $44, $49, $43, $4F, $00, $53, $55, $52, $47, $45
db $4F, $4E, $00, $43, $48, $49, $52, $55, $52, $47, $00, $43, $48, $49, $52, $55
db $52, $47, $49, $45, $4E, $00, $43, $49, $52, $55, $4A, $41, $4E, $4F, $00, $43
db $48, $49, $52, $55, $52, $47, $4F, $00, $47, $59, $4E, $45, $43, $4F, $4C, $4F
db $47, $49, $53, $54, $00, $46, $52, $41, $55, $45, $4E, $41, $52, $5A, $54, $00
db $47, $59, $4E, $45, $43, $4F, $4C, $4F, $47, $55, $45, $00, $47, $49, $4E, $45
db $43, $4F, $4C, $4F, $47, $4F, $00, $47, $49, $4E, $45, $43, $4F, $4C, $4F, $47
db $4F, $00, $43, $4F, $4E, $53, $55, $4C, $54, $41, $54, $49, $4F, $4E, $00, $4B
db $4F, $4E, $53, $55, $4C, $54, $41, $54, $49, $4F, $4E, $00, $43, $4F, $4E, $53
db $55, $4C, $54, $41, $54, $49, $4F, $4E, $00, $43, $4F, $4E, $53, $55, $4C, $54
db $41, $00, $43, $4F, $4E, $53, $55, $4C, $54, $41, $5A, $49, $4F, $4E, $45, $00
db $43, $55, $52, $45, $00, $4B, $55, $52, $00, $54, $52, $41, $49, $54, $45, $4D
db $45, $4E, $54, $00, $54, $52, $41, $54, $41, $4D, $49, $45, $4E, $54, $4F, $00
db $43, $55, $52, $41, $00, $54, $45, $4D, $50, $45, $52, $41, $54, $55, $52, $45
db $00, $54, $45, $4D, $50, $45, $52, $41, $54, $55, $52, $00, $54, $45, $4D, $50
db $45, $52, $41, $54, $55, $52, $45, $00, $54, $45, $4D, $50, $45, $52, $41, $54
db $55, $52, $41, $00, $54, $45, $4D, $50, $45, $52, $41, $54, $55, $52, $41, $00
db $56, $41, $43, $43, $49, $4E, $41, $54, $49, $4F, $4E, $00, $49, $4D, $50, $46
db $55, $4E, $47, $00, $56, $41, $43, $43, $49, $4E, $41, $54, $49, $4F, $4E, $00
db $56, $41, $43, $55, $4E, $41, $43, $49, $4F, $4E, $00, $56, $41, $43, $43, $49
db $4E, $41, $5A, $49, $4F, $4E, $45, $00, $49, $4E, $46, $45, $43, $54, $49, $4F
db $4E, $00, $41, $4E, $53, $54, $45, $43, $4B, $55, $4E, $47, $00, $43, $4F, $4E
db $54, $41, $47, $49, $4F, $4E, $00, $43, $4F, $4E, $54, $41, $47, $49, $4F, $00
db $43, $4F, $4E, $54, $41, $47, $49, $4F, $2F, $49, $4E, $46, $45, $5A, $49, $4F
db $4E, $45, $00, $54, $4F, $4F, $54, $48, $41, $43, $48, $45, $00, $5A, $41, $48
db $4E, $53, $43, $48, $4D, $45, $52, $5A, $45, $4E, $00, $4D, $41, $4C, $20, $44
db $45, $20, $44, $45, $4E, $54, $00, $44, $4F, $4C, $4F, $52, $20, $44, $45, $20
db $44, $49, $45, $4E, $54, $45, $53, $00, $4D, $41, $4C, $20, $44, $49, $20, $44
db $45, $4E, $54, $49, $00, $54, $4F, $4F, $54, $48, $20, $45, $58, $54, $52, $41
db $43, $54, $49, $4F, $4E, $00, $5A, $41, $48, $4E, $5A, $49, $45, $48, $45, $4E
db $00, $41, $52, $52, $41, $43, $48, $41, $47, $45, $20, $44, $45, $20, $44, $45
db $4E, $54, $00, $45, $58, $54, $52, $41, $43, $43, $49, $4F, $4E, $20, $44, $45
db $20, $44, $49, $45, $4E, $54, $45, $00, $45, $53, $54, $52, $41, $5A, $49, $4F
db $4E, $45, $20, $44, $49, $20, $44, $45, $4E, $54, $45, $00, $46, $49, $4C, $4C
db $49, $4E, $47, $00, $50, $4C, $4F, $4D, $42, $49, $45, $52, $45, $4E, $00, $50
db $4C, $4F, $4D, $42, $41, $47, $45, $00, $45, $4D, $50, $41, $53, $54, $45, $20
db $44, $45, $20, $44, $49, $45, $4E, $54, $45, $53, $00, $4F, $54, $54, $55, $52
db $41, $5A, $49, $4F, $4E, $45, $00, $44, $45, $4E, $54, $55, $52, $45, $53, $00
db $50, $52, $4F, $54, $48, $45, $53, $45, $00, $44, $45, $4E, $54, $49, $45, $52
db $00, $44, $45, $4E, $54, $41, $44, $55, $52, $41, $20, $50, $4F, $53, $54, $49
db $5A, $41, $00, $44, $45, $4E, $54, $49, $45, $52, $41, $00, $49, $4E, $46, $4C
db $41, $4D, $4D, $41, $54, $49, $4F, $4E, $00, $45, $4E, $54, $5A, $37, $4E, $44
db $55, $4E, $47, $00, $49, $4E, $46, $4C, $41, $4D, $4D, $41, $54, $49, $4F, $4E
db $00, $49, $4E, $46, $4C, $41, $4D, $41, $43, $49, $4F, $4E, $00, $49, $4E, $46
db $49, $41, $4D, $4D, $41, $5A, $49, $4F, $4E, $45, $00, $44, $49, $41, $52, $52
db $48, $45, $41, $00, $44, $55, $52, $43, $48, $46, $41, $4C, $4C, $00, $44, $49
db $41, $52, $52, $48, $45, $45, $00, $44, $49, $41, $52, $52, $45, $41, $00, $44
db $49, $41, $52, $52, $45, $41, $00, $45, $50, $49, $4C, $45, $50, $53, $59, $00
db $45, $50, $49, $4C, $45, $50, $53, $49, $45, $00, $45, $50, $49, $4C, $45, $50
db $53, $49, $45, $00, $45, $50, $49, $4C, $45, $50, $53, $49, $41, $00, $45, $50
db $49, $4C, $45, $53, $53, $49, $41, $00, $46, $45, $56, $45, $52, $00, $46, $49
db $45, $42, $45, $52, $00, $46, $49, $45, $56, $52, $45, $00, $46, $49, $45, $42
db $52, $45, $00, $46, $45, $42, $42, $52, $45, $00, $48, $41, $59, $20, $46, $45
db $56, $45, $52, $00, $48, $45, $55, $46, $49, $45, $42, $45, $52, $00, $52, $48
db $55, $4D, $45, $20, $44, $45, $53, $20, $46, $4F, $49, $4E, $53, $00, $43, $4F
db $52, $49, $5A, $41, $00, $52, $41, $46, $46, $52, $45, $44, $44, $4F, $52, $45
db $20, $44, $41, $20, $46, $49, $45, $4E, $4F, $00, $50, $4F, $49, $53, $4F, $4E
db $49, $4E, $47, $00, $56, $45, $52, $47, $49, $46, $54, $55, $4E, $47, $00, $45
db $4D, $50, $4F, $49, $53, $4F, $4E, $4E, $45, $4D, $45, $4E, $54, $00, $45, $4E
db $56, $45, $4E, $45, $4E, $41, $4D, $49, $45, $4E, $54, $4F, $00, $41, $56, $56
db $45, $4C, $45, $4E, $41, $4D, $45, $4E, $54, $4F, $00, $49, $4E, $44, $49, $47
db $45, $53, $54, $49, $4F, $4E, $00, $56, $45, $52, $44, $41, $55, $55, $4E, $47
db $53, $50, $52, $4F, $42, $4C, $45, $4D, $45, $00, $49, $4E, $44, $49, $47, $45
db $53, $54, $49, $4F, $4E, $00, $49, $4E, $44, $49, $47, $45, $53, $54, $49, $4F
db $4E, $00, $49, $4E, $44, $49, $47, $45, $53, $54, $49, $4F, $4E, $45, $00, $48
db $45, $41, $52, $54, $20, $54, $52, $4F, $55, $42, $4C, $45, $00, $48, $45, $52
db $5A, $42, $45, $53, $43, $48, $57, $45, $52, $44, $45, $4E, $00, $54, $52, $4F
db $55, $42, $4C, $45, $53, $20, $43, $41, $52, $44, $49, $41, $51, $55, $45, $53
db $00, $54, $52, $41, $53, $54, $4F, $52, $4E, $4F, $53, $20, $43, $41, $52, $44
db $49, $41, $43, $4F, $53, $00, $44, $49, $53, $54, $55, $52, $42, $49, $20, $43
db $41, $52, $44, $49, $41, $43, $49, $00, $43, $4F, $55, $47, $48, $00, $48, $55
db $53, $54, $45, $4E, $00, $54, $4F, $55, $58, $00, $54, $4F, $53, $00, $54, $4F
db $53, $53, $45, $00, $48, $45, $4D, $4F, $52, $52, $48, $4F, $49, $44, $53, $00
db $48, $41, $4D, $4F, $52, $52, $48, $4F, $49, $44, $45, $4E, $00, $48, $45, $4D
db $4F, $52, $52, $4F, $49, $44, $45, $53, $00, $48, $45, $4D, $4F, $52, $52, $4F
db $49, $44, $45, $53, $00, $45, $4D, $4F, $52, $52, $4F, $49, $44, $49, $00, $43
db $4F, $4E, $56, $55, $4C, $53, $49, $4F, $4E, $00, $4B, $52, $41, $4D, $50, $46
db $00, $53, $50, $41, $53, $4D, $45, $00, $45, $53, $50, $41, $53, $4D, $4F, $00
db $43, $4F, $4E, $56, $55, $4C, $53, $49, $4F, $4E, $49, $00, $53, $4F, $52, $45
db $20, $54, $48, $52, $4F, $41, $54, $00, $48, $41, $4C, $53, $53, $43, $48, $4D
db $45, $52, $5A, $45, $4E, $00, $4D, $41, $4C, $20, $44, $45, $20, $47, $4F, $52
db $47, $45, $00, $44, $4F, $4C, $4F, $52, $20, $44, $45, $20, $47, $41, $52, $47
db $41, $4E, $54, $41, $00, $4D, $41, $4C, $20, $44, $49, $20, $47, $4F, $4C, $41
db $00, $53, $55, $4E, $53, $54, $52, $4F, $4B, $45, $00, $53, $4F, $4E, $4E, $45
db $4E, $53, $54, $49, $43, $48, $00, $49, $4E, $53, $4F, $4C, $41, $54, $49, $4F
db $4E, $00, $49, $4E, $53, $4F, $4C, $41, $43, $49, $4F, $4E, $00, $49, $4E, $53
db $4F, $4C, $41, $5A, $49, $4F, $4E, $45, $00, $44, $49, $41, $42, $45, $54, $45
db $53, $00, $5A, $55, $43, $4B, $45, $52, $4B, $52, $41, $4E, $4B, $48, $45, $49
db $54, $00, $44, $49, $41, $42, $45, $54, $45, $00, $44, $49, $41, $42, $45, $54
db $45, $53, $00, $44, $49, $41, $42, $45, $54, $45, $00, $41, $50, $50, $45, $4E
db $44, $49, $43, $49, $54, $49, $53, $00, $42, $4C, $49, $4E, $44, $44, $41, $52
db $4D, $45, $4E, $54, $5A, $38, $4E, $44, $55, $4E, $47, $00, $41, $50, $50, $45
db $4E, $44, $49, $43, $49, $54, $45, $00, $41, $50, $45, $4E, $44, $49, $43, $49
db $54, $49, $53, $00, $41, $50, $50, $45, $4E, $44, $49, $43, $49, $54, $45, $00
db $46, $52, $41, $43, $54, $55, $52, $45, $00, $42, $52, $55, $43, $48, $00, $46
db $52, $41, $43, $54, $55, $52, $45, $00, $46, $52, $41, $43, $54, $55, $52, $41
db $00, $46, $52, $41, $54, $54, $55, $52, $41, $00, $49, $4E, $4A, $45, $43, $54
db $49, $4F, $4E, $00, $49, $4E, $4A, $45, $4B, $54, $49, $4F, $4E, $00, $49, $4E
db $4A, $45, $43, $54, $49, $4F, $4E, $00, $49, $4E, $59, $45, $43, $43, $49, $4F
db $4E, $00, $49, $4E, $49, $45, $5A, $49, $4F, $4E, $45, $00, $41, $4D, $42, $55
db $4C, $41, $4E, $43, $45, $00, $4B, $52, $41, $4E, $4B, $45, $4E, $57, $41, $47
db $45, $4E, $00, $41, $4D, $42, $55, $4C, $41, $4E, $43, $45, $00, $41, $4D, $42
db $55, $4C, $41, $4E, $43, $49, $41, $00, $41, $4D, $42, $55, $4C, $41, $4E, $5A
db $41, $00, $50, $52, $45, $47, $4E, $41, $4E, $54, $00, $53, $43, $48, $57, $41
db $4E, $47, $45, $52, $00, $45, $4E, $43, $45, $49, $4E, $54, $45, $00, $45, $4D
db $42, $41, $52, $41, $5A, $41, $44, $41, $00, $49, $4E, $43, $49, $4E, $54, $41
db $00, $41, $52, $4D, $00, $41, $52, $4D, $00, $42, $52, $41, $53, $00, $42, $52
db $41, $5A, $4F, $00, $42, $52, $41, $43, $43, $49, $4F, $00, $45, $4C, $42, $4F
db $57, $00, $45, $4C, $4C, $45, $4E, $42, $4F, $47, $45, $4E, $00, $43, $4F, $55
db $44, $45, $00, $43, $4F, $44, $4F, $00, $47, $4F, $4D, $49, $54, $4F, $00, $48
db $41, $4E, $44, $00, $48, $41, $4E, $44, $00, $4D, $41, $49, $4E, $00, $4D, $41
db $4E, $4F, $00, $4D, $41, $4E, $4F, $00, $46, $49, $4E, $47, $45, $52, $00, $46
db $49, $4E, $47, $45, $52, $00, $44, $4F, $49, $47, $54, $00, $44, $45, $44, $4F
db $00, $44, $49, $54, $4F, $00, $42, $41, $43, $4B, $00, $52, $38, $43, $4B, $45
db $4E, $00, $44, $4F, $53, $00, $45, $53, $50, $41, $4C, $44, $41, $00, $53, $43
db $48, $49, $45, $4E, $41, $00, $41, $42, $44, $4F, $4D, $45, $4E, $00, $42, $41
db $55, $43, $48, $00, $56, $45, $4E, $54, $52, $45, $00, $56, $49, $45, $4E, $54
db $52, $45, $00, $41, $44, $44, $4F, $4D, $45, $00, $53, $54, $4F, $4D, $41, $43
db $48, $00, $4D, $41, $47, $45, $4E, $00, $45, $53, $54, $4F, $4D, $41, $43, $00
db $45, $53, $54, $4F, $4D, $41, $47, $4F, $00, $53, $54, $4F, $4D, $41, $43, $4F
db $00, $42, $4F, $57, $45, $4C, $00, $44, $41, $52, $4D, $00, $49, $4E, $54, $45
db $53, $54, $49, $4E, $00, $49, $4E, $54, $45, $53, $54, $49, $4E, $4F, $53, $00
db $49, $4E, $54, $45, $53, $54, $49, $4E, $4F, $00, $4C, $45, $47, $00, $42, $45
db $49, $4E, $00, $4A, $41, $4D, $42, $45, $00, $50, $49, $45, $52, $4E, $41, $00
db $47, $41, $4D, $42, $41, $00, $4B, $4E, $45, $45, $00, $4B, $4E, $49, $45, $00
db $47, $45, $4E, $4F, $55, $00, $52, $4F, $44, $49, $4C, $4C, $41, $00, $47, $49
db $4E, $4F, $43, $43, $48, $49, $4F, $00, $46, $4F, $4F, $54, $00, $46, $55, $33
db $00, $50, $49, $45, $44, $00, $50, $49, $45, $00, $50, $49, $45, $44, $45, $00
db $54, $4F, $45, $00, $5A, $45, $48, $45, $00, $4F, $52, $54, $45, $49, $4C, $00
db $44, $45, $44, $4F, $20, $44, $45, $4C, $20, $50, $49, $45, $00, $44, $49, $54
db $4F, $20, $44, $45, $4C, $20, $50, $49, $45, $44, $45, $00, $48, $45, $41, $52
db $54, $00, $48, $45, $52, $5A, $00, $43, $4F, $45, $55, $52, $00, $43, $4F, $52
db $41, $5A, $4F, $4E, $00, $43, $55, $4F, $52, $45, $00, $4C, $55, $4E, $47, $00
db $4C, $55, $4E, $47, $45, $00, $50, $4F, $55, $4D, $4F, $4E, $00, $50, $55, $4C
db $4D, $4F, $4E, $00, $50, $4F, $4C, $4D, $4F, $4E, $45, $00, $4B, $49, $44, $4E
db $45, $59, $00, $4E, $49, $45, $52, $45, $00, $52, $45, $49, $4E, $00, $52, $49
db $4E, $4F, $4E, $00, $52, $45, $4E, $45, $00, $41, $50, $50, $45, $4E, $44, $49
db $58, $00, $42, $4C, $49, $4E, $44, $44, $41, $52, $4D, $00, $41, $50, $50, $45
db $4E, $44, $49, $43, $45, $00, $41, $50, $45, $4E, $44, $49, $43, $45, $00, $41
db $50, $50, $45, $4E, $44, $49, $43, $45, $00, $52, $49, $42, $00, $52, $49, $50
db $50, $45, $4E, $00, $43, $4F, $54, $45, $00, $43, $4F, $53, $54, $49, $4C, $4C
db $41, $00, $43, $4F, $53, $54, $4F, $4C, $41, $00, $4D, $55, $53, $43, $4C, $45
db $53, $00, $4D, $55, $53, $4B, $45, $4C, $4E, $00, $4D, $55, $53, $43, $4C, $45
db $53, $00, $4D, $55, $53, $43, $55, $4C, $4F, $53, $00, $4D, $55, $53, $43, $4F
db $4C, $49, $00, $4E, $45, $52, $56, $45, $00, $4E, $45, $52, $56, $00, $4E, $45
db $52, $46, $00, $4E, $45, $52, $56, $49, $4F, $00, $4E, $45, $52, $56, $4F, $00
db $42, $4C, $4F, $4F, $44, $00, $42, $4C, $55, $54, $00, $53, $41, $4E, $47, $00
db $53, $41, $4E, $47, $52, $45, $00, $53, $41, $4E, $47, $55, $45, $00, $01, $00
db $48, $45, $4C, $4C, $4F, $00, $47, $55, $54, $45, $4E, $20, $54, $41, $47, $00
db $42, $4F, $4E, $4A, $4F, $55, $52, $00, $42, $55, $45, $4E, $4F, $53, $20, $44
db $49, $41, $53, $00, $42, $55, $4F, $4E, $2D, $47, $49, $4F, $52, $4E, $4F, $00
db $47, $4F, $4F, $44, $42, $59, $45, $00, $41, $55, $46, $20, $57, $49, $45, $44
db $45, $52, $53, $45, $48, $45, $4E, $00, $41, $55, $20, $52, $45, $56, $4F, $49
db $52, $00, $41, $44, $49, $4F, $53, $00, $41, $52, $52, $49, $56, $45, $44, $45
db $52, $43, $49, $00, $54, $48, $41, $4E, $4B, $20, $59, $4F, $55, $00, $44, $41
db $4E, $4B, $45, $00, $4D, $45, $52, $43, $49, $00, $47, $52, $41, $43, $49, $41
db $53, $00, $47, $52, $41, $5A, $49, $45, $00, $57, $48, $41, $54, $20, $54, $49
db $4D, $45, $20, $49, $53, $20, $49, $54, $00, $57, $49, $45, $20, $53, $50, $31
db $54, $20, $49, $53, $54, $20, $45, $53, $00, $51, $55, $45, $4C, $4C, $45, $20
db $48, $45, $55, $52, $45, $20, $45, $53, $54, $2D, $49, $4C, $00, $51, $55, $45
db $20, $48, $4F, $52, $41, $20, $45, $53, $00, $43, $48, $45, $20, $4F, $52, $45
db $20, $53, $4F, $4E, $4F, $00, $43, $4F, $4E, $53, $55, $4C, $00, $4B, $4F, $4E
db $53, $55, $4C, $00, $43, $4F, $4E, $53, $55, $4C, $00, $43, $4F, $4E, $53, $55
db $4C, $00, $43, $4F, $4E, $53, $4F, $4C, $45, $00, $44, $45, $4C, $45, $47, $41
db $54, $45, $00, $44, $45, $4C, $45, $47, $49, $45, $52, $54, $45, $52, $00, $44
db $45, $4C, $45, $47, $55, $45, $00, $44, $45, $4C, $45, $47, $41, $44, $4F, $00
db $44, $45, $4C, $45, $47, $41, $54, $4F, $00, $4D, $41, $4E, $00, $4D, $41, $4E
db $4E, $00, $48, $4F, $4D, $4D, $45, $00, $48, $4F, $4D, $42, $52, $45, $00, $55
db $4F, $4D, $4F, $00, $46, $41, $54, $48, $45, $52, $00, $56, $41, $54, $45, $52
db $00, $50, $45, $52, $45, $00, $50, $41, $44, $52, $45, $00, $50, $41, $44, $52
db $45, $00, $57, $4F, $4D, $41, $4E, $00, $46, $52, $41, $55, $00, $44, $41, $4D
db $45, $00, $53, $45, $4E, $4F, $52, $41, $00, $44, $4F, $4E, $4E, $41, $00, $4D
db $4F, $54, $48, $45, $52, $00, $4D, $55, $54, $54, $45, $52, $00, $4D, $45, $52
db $45, $00, $4D, $41, $44, $52, $45, $00, $4D, $41, $44, $52, $45, $00, $42, $4F
db $59, $00, $4A, $55, $4E, $47, $45, $00, $47, $41, $52, $43, $4F, $4E, $00, $4D
db $55, $43, $48, $41, $43, $48, $4F, $00, $52, $41, $47, $41, $5A, $5A, $4F, $00
db $53, $4F, $4E, $00, $53, $4F, $48, $4E, $00, $46, $49, $4C, $53, $00, $48, $49
db $4A, $4F, $00, $46, $49, $47, $4C, $49, $4F, $00, $44, $41, $55, $47, $48, $54
db $45, $52, $00, $54, $4F, $43, $48, $54, $45, $52, $00, $46, $49, $4C, $4C, $45
db $00, $48, $49, $4A, $41, $00, $46, $49, $47, $4C, $49, $41, $00, $59, $45, $41
db $52, $00, $4A, $41, $48, $52, $00, $41, $4E, $4E, $45, $45, $00, $41, $4E, $4F
db $00, $41, $4E, $4E, $4F, $00, $53, $50, $52, $49, $4E, $47, $00, $46, $52, $37
db $48, $4C, $49, $4E, $47, $00, $50, $52, $49, $4E, $54, $45, $4D, $50, $53, $00
db $50, $52, $49, $4D, $41, $56, $45, $52, $41, $00, $50, $52, $49, $4D, $41, $56
db $45, $52, $41, $00, $53, $55, $4D, $4D, $45, $52, $00, $53, $4F, $4D, $4D, $45
db $52, $00, $45, $54, $45, $00, $56, $45, $52, $41, $4E, $4F, $00, $45, $53, $54
db $41, $54, $45, $00, $41, $55, $54, $55, $4D, $4E, $2F, $46, $41, $4C, $4C, $00
db $48, $45, $52, $42, $53, $54, $00, $41, $55, $54, $4F, $4D, $4E, $45, $00, $4F
db $54, $4F, $4E, $4F, $00, $41, $55, $54, $55, $4E, $4E, $4F, $00, $57, $49, $4E
db $54, $45, $52, $00, $57, $49, $4E, $54, $45, $52, $00, $48, $49, $56, $45, $52
db $00, $49, $4E, $56, $49, $45, $52, $4E, $4F, $00, $49, $4E, $56, $45, $52, $4E
db $4F, $00, $4D, $4F, $4E, $54, $48, $00, $4D, $4F, $4E, $41, $54, $00, $4D, $4F
db $49, $53, $00, $4D, $45, $53, $00, $4D, $45, $53, $45, $00, $4A, $41, $4E, $55
db $41, $52, $59, $00, $4A, $41, $4E, $55, $41, $52, $00, $4A, $41, $4E, $56, $49
db $45, $52, $00, $45, $4E, $45, $52, $4F, $00, $47, $45, $4E, $4E, $41, $49, $4F
db $00, $46, $45, $42, $52, $55, $41, $52, $59, $00, $46, $45, $42, $52, $55, $41
db $52, $00, $46, $45, $56, $52, $49, $45, $52, $00, $46, $45, $42, $52, $45, $52
db $4F, $00, $46, $45, $42, $42, $52, $41, $49, $4F, $00, $4D, $41, $52, $43, $48
db $00, $4D, $37, $52, $5A, $00, $4D, $41, $52, $53, $00, $4D, $41, $52, $5A, $4F
db $00, $4D, $41, $52, $5A, $4F, $00, $41, $50, $52, $49, $4C, $00, $41, $50, $52
db $49, $4C, $00, $41, $56, $52, $49, $4C, $00, $41, $42, $52, $49, $4C, $00, $41
db $50, $52, $49, $4C, $45, $00, $4D, $41, $59, $00, $4D, $41, $49, $00, $4D, $41
db $49, $00, $4D, $41, $59, $4F, $00, $4D, $41, $47, $47, $49, $4F, $00, $4A, $55
db $4E, $45, $00, $4A, $55, $4E, $49, $00, $4A, $55, $49, $4E, $00, $4A, $55, $4E
db $49, $4F, $00, $47, $49, $55, $47, $4E, $4F, $00, $4A, $55, $4C, $59, $00, $4A
db $55, $4C, $49, $00, $4A, $55, $49, $4C, $4C, $45, $54, $00, $4A, $55, $4C, $49
db $4F, $00, $4C, $55, $47, $4C, $49, $4F, $00, $41, $55, $47, $55, $53, $54, $00
db $41, $55, $47, $55, $53, $54, $00, $41, $4F, $55, $54, $00, $41, $47, $4F, $53
db $54, $4F, $00, $41, $47, $4F, $53, $54, $4F, $00, $53, $45, $50, $54, $45, $4D
db $42, $45, $52, $00, $53, $45, $50, $54, $45, $4D, $42, $45, $52, $00, $53, $45
db $50, $54, $45, $4D, $42, $52, $45, $00, $53, $45, $50, $54, $49, $45, $4D, $42
db $52, $45, $00, $53, $45, $54, $54, $45, $4D, $42, $52, $45, $00, $4F, $43, $54
db $4F, $42, $45, $52, $00, $4F, $4B, $54, $4F, $42, $45, $52, $00, $4F, $43, $54
db $4F, $42, $52, $45, $00, $4F, $43, $54, $55, $42, $52, $45, $00, $4F, $54, $54
db $4F, $42, $52, $45, $00, $4E, $4F, $56, $45, $4D, $42, $45, $52, $00, $4E, $4F
db $56, $45, $4D, $42, $45, $52, $00, $4E, $4F, $56, $45, $4D, $42, $52, $45, $00
db $4E, $4F, $56, $49, $45, $4D, $42, $52, $45, $00, $4E, $4F, $56, $45, $4D, $42
db $52, $45, $00, $44, $45, $43, $45, $4D, $42, $45, $52, $00, $44, $45, $5A, $45
db $4D, $42, $45, $52, $00, $44, $45, $43, $45, $4D, $42, $52, $45, $00, $44, $49
db $43, $49, $45, $4D, $42, $52, $45, $00, $44, $49, $43, $45, $4D, $42, $52, $45
db $00, $57, $45, $45, $4B, $00, $57, $4F, $43, $48, $45, $00, $53, $45, $4D, $41
db $49, $4E, $45, $00, $53, $45, $4D, $41, $4E, $41, $00, $53, $45, $54, $54, $49
db $4D, $41, $4E, $41, $00, $4D, $4F, $4E, $44, $41, $59, $00, $4D, $4F, $4E, $54
db $41, $47, $00, $4C, $55, $4E, $44, $49, $00, $4C, $55, $4E, $45, $53, $00, $4C
db $55, $4E, $45, $44, $49, $00, $54, $55, $45, $53, $44, $41, $59, $00, $44, $49
db $45, $4E, $53, $54, $41, $47, $00, $4D, $41, $52, $44, $49, $00, $4D, $41, $52
db $54, $45, $53, $00, $4D, $41, $52, $54, $45, $44, $49, $00, $57, $45, $44, $4E
db $45, $53, $44, $41, $59, $00, $4D, $49, $54, $54, $57, $4F, $43, $48, $00, $4D
db $45, $52, $43, $52, $45, $44, $49, $00, $4D, $49, $45, $52, $43, $4F, $4C, $45
db $53, $00, $4D, $45, $52, $43, $4F, $4C, $45, $44, $49, $00, $54, $48, $55, $52
db $53, $44, $41, $59, $00, $44, $4F, $4E, $4E, $45, $52, $53, $54, $41, $47, $00
db $4A, $45, $55, $44, $49, $00, $4A, $55, $45, $56, $45, $53, $00, $47, $49, $4F
db $56, $45, $44, $49, $00, $46, $52, $49, $44, $41, $59, $00, $46, $52, $45, $49
db $54, $41, $47, $00, $56, $45, $4E, $44, $52, $45, $44, $49, $00, $56, $49, $45
db $52, $4E, $45, $53, $00, $56, $45, $4E, $45, $52, $44, $49, $00, $53, $41, $54
db $55, $52, $44, $41, $59, $00, $53, $41, $4D, $53, $54, $41, $47, $00, $53, $41
db $4D, $45, $44, $49, $00, $53, $41, $42, $41, $44, $4F, $00, $53, $41, $42, $41
db $54, $4F, $00, $53, $55, $4E, $44, $41, $59, $00, $53, $4F, $4E, $4E, $54, $41
db $47, $00, $44, $49, $4D, $41, $4E, $43, $48, $45, $00, $44, $4F, $4D, $49, $4E
db $47, $4F, $00, $44, $4F, $4D, $45, $4E, $49, $43, $41, $00, $54, $4F, $44, $41
db $59, $00, $48, $45, $55, $54, $45, $00, $41, $55, $4A, $4F, $55, $52, $44, $27
db $48, $55, $49, $00, $48, $4F, $59, $00, $4F, $47, $47, $49, $00, $54, $4F, $4D
db $4F, $52, $52, $4F, $57, $00, $4D, $4F, $52, $47, $45, $4E, $00, $44, $45, $4D
db $41, $49, $4E, $00, $4D, $41, $4E, $41, $4E, $41, $00, $44, $4F, $4D, $41, $4E
db $49, $00, $59, $45, $53, $54, $45, $52, $44, $41, $59, $00, $47, $45, $53, $54
db $45, $52, $4E, $00, $48, $49, $45, $52, $00, $41, $59, $45, $52, $00, $49, $45
db $52, $49, $00, $4D, $4F, $52, $4E, $49, $4E, $47, $00, $56, $4F, $52, $4D, $49
db $54, $54, $41, $47, $00, $4D, $41, $54, $49, $4E, $00, $4D, $41, $4E, $41, $4E
db $41, $00, $4D, $41, $54, $54, $49, $4E, $41, $00, $41, $46, $54, $45, $52, $4E
db $4F, $4F, $4E, $00, $4E, $41, $43, $48, $4D, $49, $54, $54, $41, $47, $00, $41
db $50, $52, $45, $53, $2D, $4D, $49, $44, $49, $00, $54, $41, $52, $44, $45, $00
db $50, $4F, $4D, $45, $52, $49, $47, $47, $49, $4F, $00, $45, $56, $45, $4E, $49
db $4E, $47, $00, $41, $42, $45, $4E, $44, $00, $53, $4F, $49, $52, $00, $4E, $4F
db $43, $48, $45, $00, $53, $45, $52, $41, $00, $4E, $49, $47, $48, $54, $00, $4E
db $41, $43, $48, $54, $00, $4E, $55, $49, $54, $00, $4E, $4F, $43, $48, $45, $00
db $4E, $4F, $54, $54, $45, $00, $43, $48, $52, $49, $53, $54, $4D, $41, $53, $00
db $57, $45, $49, $48, $4E, $41, $43, $48, $54, $45, $4E, $00, $4E, $4F, $45, $4C
db $00, $4E, $41, $56, $49, $44, $41, $44, $00, $4E, $41, $54, $41, $4C, $45, $00
db $45, $41, $53, $54, $45, $52, $00, $4F, $53, $54, $45, $52, $4E, $00, $50, $41
db $51, $55, $45, $53, $00, $50, $41, $53, $43, $55, $41, $00, $50, $41, $53, $51
db $55, $41, $00, $4E, $45, $57, $20, $59, $45, $41, $52, $00, $4E, $45, $55, $4A
db $41, $48, $52, $00, $4E, $4F, $55, $56, $45, $4C, $20, $41, $4E, $00, $41, $4E
db $4F, $20, $4E, $55, $45, $56, $4F, $00, $43, $41, $50, $4F, $44, $41, $4E, $4E
db $4F, $00, $53, $55, $4E, $00, $53, $4F, $4E, $4E, $45, $00, $53, $4F, $4C, $45
db $49, $4C, $00, $53, $4F, $4C, $00, $53, $4F, $4C, $45, $00, $52, $41, $49, $4E
db $00, $52, $45, $47, $45, $4E, $00, $50, $4C, $55, $49, $45, $00, $4C, $4C, $55
db $56, $49, $41, $00, $50, $49, $4F, $47, $47, $49, $41, $00, $53, $4E, $4F, $57
db $00, $53, $43, $48, $4E, $45, $45, $00, $4E, $45, $49, $47, $45, $00, $4E, $49
db $45, $56, $45, $00, $4E, $45, $56, $45, $00, $48, $41, $49, $4C, $00, $48, $41
db $47, $45, $4C, $00, $47, $52, $45, $4C, $45, $00, $47, $52, $41, $4E, $49, $5A
db $4F, $00, $47, $52, $41, $4E, $44, $49, $4E, $45, $00, $43, $4F, $4C, $44, $00
db $4B, $32, $4C, $54, $45, $00, $46, $52, $4F, $49, $44, $00, $46, $52, $49, $4F
db $00, $46, $52, $45, $44, $44, $4F, $00, $46, $52, $4F, $53, $54, $00, $46, $52
db $4F, $53, $54, $00, $47, $45, $4C, $45, $45, $00, $48, $45, $4C, $41, $44, $41
db $00, $47, $45, $4C, $4F, $00, $53, $54, $4F, $52, $4D, $00, $53, $54, $55, $52
db $4D, $00, $54, $45, $4D, $50, $45, $54, $45, $00, $54, $45, $4D, $50, $45, $53
db $54, $41, $44, $00, $54, $45, $4D, $50, $45, $53, $54, $41, $00, $57, $49, $4E
db $44, $00, $57, $49, $4E, $44, $00, $56, $45, $4E, $54, $00, $56, $49, $45, $4E
db $54, $4F, $00, $56, $45, $4E, $54, $4F, $00, $46, $4F, $47, $00, $4E, $45, $42
db $45, $4C, $00, $42, $52, $4F, $55, $49, $4C, $4C, $41, $52, $44, $00, $4E, $49
db $45, $42, $4C, $41, $00, $4E, $45, $42, $42, $49, $41, $00, $4C, $49, $47, $48
db $54, $4E, $49, $4E, $47, $00, $42, $4C, $49, $54, $5A, $00, $45, $43, $4C, $41
db $49, $52, $00, $52, $45, $4C, $41, $4D, $50, $41, $47, $4F, $00, $4C, $41, $4D
db $50, $4F, $00, $54, $48, $55, $4E, $44, $45, $52, $00, $44, $4F, $4E, $4E, $45
db $52, $00, $54, $4F, $4E, $4E, $45, $52, $52, $45, $00, $54, $52, $55, $45, $4E
db $4F, $00, $54, $55, $4F, $4E, $4F, $00, $45, $41, $52, $54, $48, $51, $55, $41
db $4B, $45, $00, $45, $52, $44, $42, $45, $42, $45, $4E, $00, $54, $52, $45, $4D
db $42, $4C, $45, $4D, $45, $4E, $54, $20, $44, $45, $20, $54, $45, $52, $52, $45
db $00, $54, $45, $52, $52, $45, $4D, $4F, $54, $4F, $00, $54, $45, $52, $52, $45
db $4D, $4F, $54, $4F, $00, $46, $49, $52, $45, $00, $46, $45, $55, $45, $52, $00
db $46, $45, $55, $00, $46, $55, $45, $47, $4F, $00, $46, $55, $4F, $43, $4F, $00
db $53, $4D, $4F, $4B, $45, $00, $52, $41, $55, $43, $48, $00, $46, $55, $4D, $45
db $45, $00, $48, $55, $4D, $4F, $00, $46, $55, $4D, $4F, $00, $43, $4C, $4F, $55
db $44, $53, $00, $57, $4F, $4C, $4B, $45, $4E, $00, $4E, $55, $41, $47, $45, $53
db $00, $4E, $55, $42, $45, $53, $00, $4E, $55, $56, $4F, $4C, $45, $00, $48, $4F
db $54, $00, $48, $45, $49, $33, $00, $43, $48, $41, $55, $44, $00, $43, $41, $4C
db $49, $45, $4E, $54, $45, $00, $43, $41, $4C, $44, $49, $53, $53, $49, $4D, $4F
db $2F, $43, $41, $4C, $44, $4F, $00, $57, $48, $49, $54, $45, $00, $57, $45, $49
db $33, $00, $42, $4C, $41, $4E, $43, $00, $42, $4C, $41, $4E, $43, $4F, $00, $42
db $49, $41, $4E, $43, $4F, $00, $42, $4C, $41, $43, $4B, $00, $53, $43, $48, $57
db $41, $52, $5A, $00, $4E, $4F, $49, $52, $00, $4E, $45, $47, $52, $4F, $00, $4E
db $45, $52, $4F, $00, $52, $45, $44, $00, $52, $4F, $54, $00, $52, $4F, $55, $47
db $45, $00, $52, $4F, $4A, $4F, $00, $52, $4F, $53, $53, $4F, $00, $42, $4C, $55
db $45, $00, $42, $4C, $41, $55, $00, $42, $4C, $55, $00, $41, $5A, $55, $4C, $00
db $42, $4C, $45, $55, $00, $59, $45, $4C, $4C, $4F, $57, $00, $47, $45, $4C, $42
db $00, $4A, $41, $55, $4E, $45, $00, $41, $4D, $41, $52, $49, $4C, $4C, $4F, $00
db $47, $49, $41, $4C, $4C, $4F, $00, $47, $52, $45, $45, $4E, $00, $47, $52, $38
db $4E, $00, $56, $45, $52, $54, $00, $56, $45, $52, $44, $45, $00, $56, $45, $52
db $44, $45, $00, $42, $52, $4F, $57, $4E, $00, $42, $52, $41, $55, $4E, $00, $42
db $52, $55, $4E, $00, $50, $41, $52, $44, $4F, $00, $4D, $41, $52, $52, $4F, $4E
db $45, $00, $4C, $49, $4C, $41, $43, $00, $4C, $49, $4C, $41, $00, $4C, $49, $4C
db $41, $53, $00, $4C, $49, $4C, $41, $00, $4C, $49, $4C, $4C, $41, $00, $50, $49
db $4E, $4B, $00, $52, $4F, $53, $41, $00, $52, $4F, $53, $45, $00, $52, $4F, $53
db $41, $00, $52, $4F, $53, $41, $00, $50, $55, $52, $50, $4C, $45, $00, $50, $55
db $52, $50, $55, $52, $00, $50, $4F, $55, $52, $50, $52, $45, $00, $50, $55, $52
db $50, $55, $52, $41, $00, $50, $4F, $52, $50, $4F, $52, $41, $00, $54, $52, $41
db $56, $45, $4C, $20, $41, $47, $45, $4E, $43, $59, $00, $52, $45, $49, $53, $45
db $42, $37, $52, $4F, $00, $41, $47, $45, $4E, $43, $45, $20, $44, $45, $20, $56
db $4F, $59, $41, $47, $45, $53, $00, $41, $47, $45, $4E, $43, $49, $41, $20, $44
db $45, $20, $56, $49, $41, $4A, $45, $53, $00, $41, $47, $45, $4E, $5A, $49, $41
db $20, $44, $49, $20, $56, $49, $41, $47, $47, $49, $00, $54, $52, $41, $49, $4E
db $20, $53, $54, $41, $54, $49, $4F, $4E, $00, $42, $41, $48, $4E, $48, $4F, $46
db $00, $47, $41, $52, $45, $00, $45, $53, $54, $41, $43, $49, $4F, $4E, $20, $44
db $45, $4C, $20, $54, $52, $45, $4E, $00, $53, $54, $41, $5A, $49, $4F, $4E, $45
db $00, $50, $4C, $41, $54, $46, $4F, $52, $4D, $00, $42, $41, $48, $4E, $53, $54
db $45, $49, $47, $00, $51, $55, $41, $49, $00, $41, $4E, $44, $45, $4E, $00, $42
db $49, $4E, $41, $52, $49, $4F, $00, $54, $52, $41, $49, $4E, $00, $5A, $55, $47
db $00, $54, $52, $41, $49, $4E, $00, $54, $52, $45, $4E, $00, $54, $52, $45, $4E
db $4F, $00, $49, $4E, $46, $4F, $52, $4D, $41, $54, $49, $4F, $4E, $00, $41, $55
db $53, $4B, $55, $4E, $46, $54, $00, $52, $45, $4E, $53, $45, $49, $47, $4E, $45
db $4D, $45, $4E, $54, $53, $00, $49, $4E, $46, $4F, $52, $4D, $41, $43, $49, $4F
db $4E, $00, $49, $4E, $46, $4F, $52, $4D, $41, $5A, $49, $4F, $4E, $49, $00, $57
db $41, $49, $54, $49, $4E, $47, $20, $52, $4F, $4F, $4D, $00, $57, $41, $52, $54
db $45, $53, $41, $41, $4C, $00, $53, $41, $4C, $4C, $45, $20, $44, $27, $41, $54
db $54, $45, $4E, $54, $45, $00, $53, $41, $4C, $41, $20, $44, $45, $20, $45, $53
db $50, $45, $52, $41, $00, $53, $41, $4C, $41, $20, $44, $27, $41, $54, $54, $45
db $53, $41, $00, $54, $4F, $49, $4C, $45, $54, $53, $2F, $42, $41, $54, $48, $52
db $4F, $4F, $4D, $53, $00, $54, $4F, $49, $4C, $45, $54, $54, $45, $4E, $00, $54
db $4F, $49, $4C, $45, $54, $54, $45, $53, $00, $4C, $41, $56, $41, $42, $4F, $53
db $2F, $42, $41, $34, $4F, $53, $00, $47, $41, $42, $49, $4E, $45, $54, $54, $49
db $00, $44, $49, $4E, $49, $4E, $47, $20, $43, $41, $52, $00, $53, $50, $45, $49
db $53, $45, $57, $41, $47, $45, $4E, $00, $57, $41, $47, $4F, $4E, $2D, $52, $45
db $53, $54, $41, $55, $52, $41, $4E, $54, $00, $43, $4F, $43, $48, $45, $20, $43
db $4F, $4D, $45, $44, $4F, $52, $00, $56, $41, $47, $4F, $4E, $45, $20, $52, $49
db $53, $54, $4F, $52, $41, $4E, $54, $45, $00, $53, $4D, $4F, $4B, $49, $4E, $47
db $00, $52, $41, $55, $43, $48, $45, $52, $00, $46, $55, $4D, $45, $55, $52, $00
db $46, $55, $4D, $41, $44, $4F, $52, $45, $53, $00, $46, $55, $4D, $41, $54, $4F
db $52, $49, $00, $4E, $4F, $20, $53, $4D, $4F, $4B, $49, $4E, $47, $00, $4E, $49
db $43, $48, $54, $52, $41, $55, $43, $48, $45, $52, $00, $4E, $4F, $4E, $20, $46
db $55, $4D, $45, $55, $52, $00, $4E, $4F, $20, $46, $55, $4D, $41, $44, $4F, $52
db $45, $53, $00, $4E, $4F, $4E, $20, $46, $55, $4D, $41, $54, $4F, $52, $49, $00
db $53, $54, $4F, $50, $00, $41, $55, $46, $45, $4E, $54, $48, $41, $4C, $54, $00
db $41, $52, $52, $45, $54, $00, $50, $41, $52, $41, $44, $41, $00, $46, $45, $52
db $4D, $41, $54, $41, $00, $44, $45, $50, $41, $52, $54, $55, $52, $45, $00, $41
db $42, $46, $41, $48, $52, $54, $00, $44, $45, $50, $41, $52, $54, $00, $53, $41
db $4C, $49, $44, $41, $00, $50, $41, $52, $54, $45, $4E, $5A, $41, $00, $41, $52
db $52, $49, $56, $41, $4C, $00, $41, $4E, $4B, $55, $4E, $46, $54, $00, $41, $52
db $52, $49, $56, $45, $45, $00, $4C, $4C, $45, $47, $41, $44, $41, $00, $41, $52
db $52, $49, $56, $4F, $00, $45, $4E, $54, $52, $41, $4E, $43, $45, $00, $45, $49
db $4E, $47, $41, $4E, $47, $00, $45, $4E, $54, $52, $45, $45, $00, $45, $4E, $54
db $52, $41, $44, $41, $00, $45, $4E, $54, $52, $41, $54, $41, $00, $45, $58, $49
db $54, $00, $41, $55, $53, $47, $41, $4E, $47, $00, $53, $4F, $52, $54, $49, $45
db $00, $53, $41, $4C, $49, $44, $41, $00, $55, $53, $43, $49, $54, $41, $00, $54
db $49, $4D, $45, $54, $41, $42, $4C, $45, $00, $46, $41, $48, $52, $50, $4C, $41
db $4E, $00, $48, $4F, $52, $41, $49, $52, $45, $00, $48, $4F, $52, $41, $52, $49
db $4F, $00, $4F, $52, $41, $52, $49, $4F, $00, $44, $45, $4C, $41, $59, $00, $56
db $45, $52, $53, $50, $31, $54, $55, $4E, $47, $00, $52, $45, $54, $41, $52, $44
db $00, $52, $45, $54, $52, $41, $53, $4F, $00, $52, $49, $54, $41, $52, $44, $4F
db $00, $46, $45, $52, $52, $59, $00, $46, $31, $48, $52, $45, $00, $46, $45, $52
db $52, $59, $2D, $42, $4F, $41, $54, $00, $54, $52, $41, $4E, $53, $42, $4F, $52
db $44, $41, $44, $4F, $52, $00, $54, $52, $41, $47, $48, $45, $54, $54, $4F, $00
db $43, $41, $42, $49, $4E, $00, $4B, $41, $42, $49, $4E, $45, $00, $43, $41, $42
db $49, $4E, $45, $00, $43, $41, $4D, $41, $52, $4F, $54, $45, $00, $43, $41, $42
db $49, $4E, $41, $00, $44, $4F, $4D, $45, $53, $54, $49, $43, $20, $46, $4C, $49
db $47, $48, $54, $00, $49, $4E, $4C, $41, $4E, $44, $53, $46, $4C, $55, $47, $00
db $56, $4F, $4C, $20, $49, $4E, $54, $45, $52, $49, $45, $55, $52, $00, $56, $55
db $45, $4C, $4F, $20, $44, $4F, $4D, $45, $53, $54, $49, $43, $4F, $00, $56, $4F
db $4C, $4F, $20, $4E, $41, $5A, $49, $4F, $4E, $41, $4C, $45, $00, $49, $4E, $54
db $45, $52, $4E, $41, $54, $49, $4F, $4E, $41, $4C, $20, $46, $4C, $49, $47, $48
db $54, $00, $41, $55, $53, $4C, $41, $4E, $44, $53, $46, $4C, $55, $47, $00, $56
db $4F, $4C, $20, $49, $4E, $54, $45, $52, $4E, $41, $54, $49, $4F, $4E, $41, $4C
db $00, $56, $55, $45, $4C, $4F, $20, $49, $4E, $54, $45, $52, $4E, $41, $43, $49
db $4F, $4E, $41, $4C, $00, $56, $4F, $4C, $4F, $20, $49, $4E, $54, $45, $52, $4E
db $41, $5A, $49, $4F, $4E, $41, $4C, $45, $00, $41, $49, $52, $50, $4F, $52, $54
db $00, $46, $4C, $55, $47, $48, $41, $46, $45, $4E, $00, $41, $45, $52, $4F, $50
db $4F, $52, $54, $00, $41, $45, $52, $4F, $50, $55, $45, $52, $54, $4F, $00, $41
db $45, $52, $4F, $50, $4F, $52, $54, $4F, $00, $54, $41, $4B, $45, $4F, $46, $46
db $00, $41, $42, $49, $4C, $55, $47, $00, $44, $45, $43, $4F, $4C, $4C, $4F, $00
db $44, $45, $53, $50, $45, $47, $55, $45, $00, $44, $45, $43, $4F, $4C, $4C, $41
db $52, $45, $00, $4C, $41, $4E, $44, $00, $4C, $41, $4E, $44, $45, $4E, $00, $41
db $54, $54, $45, $52, $52, $49, $52, $00, $41, $54, $45, $52, $52, $49, $5A, $41
db $52, $00, $41, $54, $54, $45, $52, $52, $41, $47, $49, $4F, $00, $48, $41, $4E
db $44, $2D, $4C, $55, $47, $47, $41, $47, $45, $00, $48, $41, $4E, $44, $47, $45
db $50, $31, $43, $4B, $00, $42, $41, $47, $41, $47, $45, $53, $20, $41, $20, $4D
db $41, $49, $4E, $00, $4D, $41, $4C, $45, $54, $49, $4E, $00, $42, $41, $47, $41
db $47, $4C, $49, $4F, $20, $41, $20, $4D, $41, $4E, $4F, $00, $45, $58, $43, $45
db $53, $53, $20, $57, $45, $49, $47, $48, $54, $00, $37, $42, $45, $52, $47, $45
db $57, $49, $43, $48, $54, $00, $53, $55, $52, $43, $48, $41, $52, $47, $45, $00
db $53, $4F, $42, $52, $45, $43, $41, $52, $47, $41, $00, $53, $4F, $56, $52, $41
db $50, $50, $45, $53, $4F, $00, $43, $55, $53, $54, $4F, $4D, $53, $00, $5A, $4F
db $4C, $4C, $00, $44, $4F, $55, $41, $4E, $45, $00, $41, $44, $55, $41, $4E, $41
db $00, $44, $4F, $47, $41, $4E, $41, $00, $50, $4F, $52, $54, $45, $52, $00, $54
db $52, $31, $47, $45, $52, $00, $50, $4F, $52, $54, $45, $55, $52, $00, $4D, $4F
db $5A, $4F, $20, $44, $45, $4C, $20, $45, $51, $55, $49, $50, $41, $4A, $45, $00
db $46, $41, $43, $43, $48, $49, $4E, $4F, $00, $43, $48, $41, $4D, $42, $45, $52
db $4D, $41, $49, $44, $00, $5A, $49, $4D, $4D, $45, $52, $4D, $31, $44, $43, $48
db $45, $4E, $00, $46, $45, $4D, $4D, $45, $20, $44, $45, $20, $43, $48, $41, $4D
db $42, $52, $45, $00, $43, $41, $4D, $41, $52, $45, $52, $41, $00, $43, $41, $4D
db $45, $52, $49, $45, $52, $41, $00, $44, $4F, $55, $42, $4C, $45, $20, $52, $4F
db $4F, $4D, $00, $44, $4F, $50, $50, $45, $4C, $5A, $49, $4D, $4D, $45, $52, $00
db $43, $48, $41, $4D, $42, $52, $45, $20, $41, $20, $44, $45, $55, $58, $20, $4C
db $49, $54, $53, $00, $48, $41, $42, $49, $54, $41, $43, $49, $4F, $4E, $20, $44
db $4F, $42, $4C, $45, $00, $43, $41, $4D, $45, $52, $41, $20, $44, $4F, $50, $50
db $49, $41, $00, $44, $4F, $55, $42, $4C, $45, $20, $42, $45, $44, $00, $44, $4F
db $50, $50, $45, $4C, $42, $45, $54, $54, $00, $4C, $49, $54, $20, $41, $20, $44
db $45, $55, $58, $20, $50, $4C, $41, $43, $45, $53, $00, $43, $41, $4D, $41, $20
db $44, $4F, $42, $4C, $45, $00, $4C, $45, $54, $54, $4F, $20, $4D, $41, $54, $52
db $49, $4D, $4F, $4E, $49, $41, $4C, $45, $00, $42, $41, $54, $48, $00, $42, $41
db $44, $00, $42, $41, $49, $4E, $00, $42, $41, $4E, $4F, $00, $42, $41, $47, $4E
db $4F, $00, $53, $48, $4F, $57, $45, $52, $00, $44, $55, $53, $43, $48, $45, $00
db $44, $4F, $55, $43, $48, $45, $00, $44, $55, $43, $48, $41, $00, $44, $4F, $43
db $43, $49, $41, $00, $43, $4F, $54, $00, $4B, $49, $4E, $44, $45, $52, $42, $45
db $54, $54, $00, $4C, $49, $54, $20, $44, $27, $45, $4E, $46, $41, $4E, $54, $00
db $43, $41, $4D, $41, $20, $50, $41, $52, $41, $20, $4E, $49, $4E, $4F, $00, $4C
db $45, $54, $54, $4F, $20, $50, $45, $52, $20, $42, $41, $4D, $42, $49, $4E, $4F
db $00, $4C, $49, $47, $48, $54, $20, $42, $55, $4C, $42, $00, $47, $4C, $37, $48
db $42, $49, $52, $4E, $45, $00, $41, $4D, $50, $4F, $55, $4C, $45, $20, $45, $4C
db $45, $43, $54, $52, $49, $51, $55, $45, $00, $42, $4F, $4D, $42, $49, $4C, $4C
db $41, $00, $4C, $41, $4D, $50, $41, $44, $49, $4E, $41, $00, $54, $4F, $49, $4C
db $45, $54, $20, $50, $41, $50, $45, $52, $00, $54, $4F, $49, $4C, $45, $54, $54
db $45, $4E, $50, $41, $50, $49, $45, $52, $00, $50, $41, $50, $49, $45, $52, $20
db $48, $59, $47, $49, $45, $4E, $49, $51, $55, $45, $00, $50, $41, $50, $45, $4C
db $20, $48, $49, $47, $49, $45, $4E, $49, $43, $4F, $00, $43, $41, $52, $54, $41
db $20, $49, $47, $49, $45, $4E, $49, $43, $41, $00, $52, $45, $53, $45, $52, $56
db $41, $54, $49, $4F, $4E, $00, $52, $45, $53, $45, $52, $56, $49, $45, $52, $45
db $4E, $00, $52, $45, $53, $45, $52, $56, $45, $52, $00, $52, $45, $53, $45, $52
db $56, $41, $52, $00, $50, $52, $45, $4E, $4F, $54, $41, $5A, $49, $4F, $4E, $45
db $00, $57, $41, $4B, $45, $20, $55, $50, $20, $43, $41, $4C, $4C, $00, $57, $45
db $43, $4B, $45, $4E, $00, $52, $45, $56, $45, $49, $4C, $4C, $45, $52, $00, $44
db $45, $53, $50, $45, $52, $54, $41, $52, $00, $53, $56, $45, $47, $4C, $49, $41
db $00, $44, $49, $52, $54, $59, $00, $53, $43, $48, $4D, $55, $54, $5A, $49, $47
db $00, $53, $41, $4C, $45, $00, $53, $55, $43, $49, $4F, $00, $53, $50, $4F, $52
db $43, $4F, $00, $4D, $41, $4B, $45, $20, $54, $48, $45, $20, $42, $45, $44, $00
db $44, $41, $53, $20, $42, $45, $54, $54, $20, $4D, $41, $43, $48, $45, $4E, $00
db $46, $41, $49, $52, $45, $20, $4C, $45, $20, $4C, $49, $54, $00, $48, $41, $43
db $45, $52, $20, $4C, $41, $20, $43, $41, $4D, $41, $00, $46, $41, $52, $45, $20
db $49, $4C, $20, $4C, $45, $54, $54, $4F, $00, $4F, $52, $44, $45, $52, $00, $42
db $45, $53, $54, $45, $4C, $4C, $45, $4E, $00, $43, $4F, $4D, $4D, $41, $4E, $44
db $45, $52, $00, $50, $45, $44, $49, $52, $00, $4F, $52, $44, $49, $4E, $41, $5A
db $49, $4F, $4E, $45, $00, $53, $45, $4C, $46, $2D, $53, $45, $52, $56, $49, $43
db $45, $00, $53, $45, $4C, $42, $53, $54, $42, $45, $44, $49, $45, $4E, $55, $4E
db $47, $00, $53, $45, $4C, $46, $2D, $53, $45, $52, $56, $49, $43, $45, $00, $41
db $55, $54, $4F, $2D, $53, $45, $52, $56, $49, $43, $49, $4F, $00, $53, $45, $4C
db $46, $2D, $53, $45, $52, $56, $49, $43, $45, $00, $57, $41, $49, $54, $45, $52
db $00, $4B, $45, $4C, $4C, $4E, $45, $52, $00, $47, $41, $52, $43, $4F, $4E, $00
db $43, $41, $4D, $41, $52, $45, $52, $4F, $00, $43, $41, $4D, $45, $52, $49, $45
db $52, $45, $00, $57, $41, $49, $54, $52, $45, $53, $53, $00, $4B, $45, $4C, $4C
db $4E, $45, $52, $49, $4E, $00, $53, $45, $52, $56, $45, $55, $53, $45, $00, $43
db $41, $4D, $41, $52, $45, $52, $41, $00, $43, $41, $4D, $45, $52, $49, $45, $52
db $41, $00, $54, $41, $42, $4C, $45, $00, $54, $49, $53, $43, $48, $00, $54, $41
db $42, $4C, $45, $00, $4D, $45, $53, $41, $00, $54, $41, $56, $4F, $4C, $4F, $00
db $43, $48, $41, $49, $52, $00, $53, $54, $55, $48, $4C, $00, $43, $48, $41, $49
db $53, $45, $00, $53, $49, $4C, $4C, $41, $00, $53, $45, $44, $49, $41, $00, $50
db $4C, $41, $54, $45, $00, $54, $45, $4C, $4C, $45, $52, $00, $41, $53, $53, $49
db $45, $54, $54, $45, $00, $50, $4C, $41, $54, $4F, $00, $50, $49, $41, $54, $54
db $4F, $00, $4E, $41, $50, $4B, $49, $4E, $00, $53, $45, $52, $56, $49, $45, $54
db $54, $45, $00, $53, $45, $52, $56, $49, $45, $54, $54, $45, $00, $53, $45, $52
db $56, $49, $4C, $4C, $45, $54, $41, $00, $54, $4F, $56, $41, $47, $4C, $49, $4F
db $4C, $4F, $00, $46, $4F, $52, $4B, $00, $47, $41, $42, $45, $4C, $00, $46, $4F
db $55, $52, $43, $48, $45, $54, $54, $45, $00, $54, $45, $4E, $45, $44, $4F, $52
db $00, $46, $4F, $52, $43, $48, $45, $54, $54, $41, $00, $4B, $4E, $49, $46, $45
db $00, $4D, $45, $53, $53, $45, $52, $00, $43, $4F, $55, $54, $45, $41, $55, $00
db $43, $55, $43, $48, $49, $4C, $4C, $4F, $00, $43, $4F, $4C, $54, $45, $4C, $4C
db $4F, $00, $53, $50, $4F, $4F, $4E, $00, $4C, $39, $46, $46, $45, $4C, $00, $43
db $55, $49, $4C, $4C, $45, $52, $45, $00, $43, $55, $43, $48, $41, $52, $41, $00
db $43, $55, $43, $43, $48, $49, $41, $49, $4F, $00, $47, $4C, $41, $53, $53, $00
db $47, $4C, $41, $53, $00, $56, $45, $52, $52, $45, $00, $56, $41, $53, $4F, $00
db $42, $49, $43, $43, $48, $49, $45, $52, $45, $00, $41, $53, $48, $54, $52, $41
db $59, $00, $41, $53, $43, $48, $45, $4E, $42, $45, $43, $48, $45, $52, $00, $43
db $45, $4E, $44, $52, $49, $45, $52, $00, $43, $45, $4E, $49, $43, $45, $52, $4F
db $00, $50, $4F, $52, $54, $41, $43, $45, $4E, $45, $52, $45, $00, $54, $4F, $4F
db $54, $48, $50, $49, $43, $4B, $00, $5A, $41, $48, $4E, $53, $54, $4F, $43, $48
db $45, $52, $00, $43, $55, $52, $45, $2D, $44, $45, $4E, $54, $53, $00, $50, $41
db $4C, $49, $4C, $4C, $4F, $00, $53, $54, $55, $5A, $5A, $49, $43, $41, $44, $45
db $4E, $54, $49, $00, $4D, $45, $4E, $55, $00, $53, $50, $45, $49, $53, $45, $4B
db $41, $52, $54, $45, $00, $43, $41, $52, $54, $45, $00, $4D, $45, $4E, $55, $00
db $4D, $45, $4E, $55, $00, $43, $4F, $46, $46, $45, $45, $00, $4B, $41, $46, $46
db $45, $45, $00, $43, $41, $46, $45, $00, $43, $41, $46, $45, $00, $43, $41, $46
db $46, $45, $00, $54, $45, $41, $00, $54, $45, $45, $00, $54, $48, $45, $00, $54
db $45, $00, $54, $45, $00, $4D, $49, $4C, $4B, $00, $4D, $49, $4C, $43, $48, $00
db $4C, $41, $49, $54, $00, $4C, $45, $43, $48, $45, $00, $4C, $41, $54, $54, $45
db $00, $46, $52, $45, $4E, $43, $48, $20, $42, $52, $45, $41, $44, $00, $42, $41
db $47, $55, $45, $54, $54, $45, $00, $42, $41, $47, $55, $45, $54, $54, $45, $00
db $50, $41, $4E, $20, $46, $52, $41, $4E, $43, $45, $53, $00, $50, $41, $4E, $45
db $20, $46, $52, $41, $4E, $43, $45, $53, $45, $00, $43, $52, $49, $53, $50, $42
db $52, $45, $41, $44, $00, $4B, $4E, $31, $43, $4B, $45, $42, $52, $4F, $54, $00
db $50, $41, $49, $4E, $20, $53, $43, $41, $4E, $44, $49, $4E, $41, $56, $45, $00
db $50, $41, $4E, $20, $43, $52, $55, $4A, $49, $45, $4E, $54, $45, $00, $50, $41
db $4E, $45, $20, $43, $52, $4F, $43, $43, $41, $4E, $54, $45, $00, $52, $4F, $4C
db $4C, $00, $42, $52, $39, $54, $43, $48, $45, $4E, $00, $50, $45, $54, $49, $54
db $20, $50, $41, $49, $4E, $00, $50, $41, $4E, $45, $43, $49, $4C, $4C, $4F, $00
db $50, $41, $4E, $49, $4E, $4F, $00, $43, $52, $41, $43, $4B, $45, $52, $53, $00
db $4B, $45, $4B, $53, $00, $43, $52, $41, $43, $4B, $45, $52, $53, $00, $47, $41
db $4C, $4C, $45, $54, $41, $53, $00, $43, $52, $41, $43, $4B, $45, $52, $53, $00
db $42, $49, $53, $43, $55, $49, $54, $53, $00, $4B, $4C, $45, $49, $4E, $47, $45
db $42, $31, $43, $4B, $00, $43, $4F, $4F, $4B, $49, $45, $53, $00, $47, $41, $4C
db $4C, $45, $54, $49, $54, $41, $53, $00, $42, $49, $53, $43, $4F, $54, $54, $49
db $00, $44, $41, $4E, $49, $53, $48, $20, $50, $41, $53, $54, $52, $59, $00, $47
db $45, $42, $31, $43, $4B, $00, $50, $41, $54, $49, $53, $53, $45, $52, $49, $45
db $20, $44, $41, $4E, $4F, $49, $53, $45, $00, $50, $41, $53, $54, $45, $4C, $45
db $53, $20, $44, $41, $4E, $45, $53, $45, $53, $00, $50, $41, $53, $54, $49, $43
db $43, $45, $52, $49, $41, $20, $44, $41, $4E, $45, $53, $45, $00, $48, $4F, $54
db $20, $4D, $49, $4C, $4B, $00, $57, $41, $52, $4D, $45, $20, $4D, $49, $4C, $43
db $48, $00, $4C, $41, $49, $54, $20, $43, $48, $41, $55, $44, $00, $4C, $45, $43
db $48, $45, $20, $43, $41, $4C, $49, $45, $4E, $54, $45, $00, $4C, $41, $54, $54
db $45, $20, $43, $41, $4C, $44, $4F, $00, $59, $4F, $47, $55, $52, $54, $00, $4A
db $4F, $47, $48, $55, $52, $54, $00, $59, $41, $4F, $55, $52, $54, $00, $59, $4F
db $47, $55, $52, $00, $59, $4F, $47, $55, $52, $54, $00, $45, $47, $47, $00, $45
db $49, $00, $4F, $45, $55, $46, $00, $48, $55, $45, $56, $4F, $00, $55, $4F, $56
db $4F, $00, $53, $4F, $46, $54, $2D, $42, $4F, $49, $4C, $45, $44, $00, $57, $45
db $49, $43, $48, $47, $45, $4B, $4F, $43, $48, $54, $00, $41, $20, $4C, $41, $20
db $43, $4F, $51, $55, $45, $00, $50, $41, $53, $41, $44, $4F, $20, $50, $4F, $52
db $20, $41, $47, $55, $41, $00, $41, $4C, $4C, $41, $20, $43, $4F, $51, $55, $45
db $00, $48, $41, $52, $44, $2D, $42, $4F, $49, $4C, $45, $44, $00, $48, $41, $52
db $54, $47, $45, $4B, $4F, $43, $48, $54, $00, $44, $55, $52, $00, $44, $55, $52
db $4F, $00, $55, $4F, $56, $41, $20, $53, $4F, $44, $45, $00, $46, $52, $49, $45
db $44, $20, $45, $47, $47, $00, $53, $50, $49, $45, $47, $45, $4C, $45, $49, $00
db $4F, $45, $55, $46, $20, $53, $55, $52, $20, $4C, $45, $20, $50, $4C, $41, $54
db $00, $48, $55, $45, $56, $4F, $53, $20, $46, $52, $49, $54, $4F, $53, $00, $55
db $4F, $56, $4F, $20, $41, $4C, $20, $54, $45, $47, $41, $4D, $49, $4E, $4F, $00
db $53, $43, $52, $41, $4D, $42, $4C, $45, $44, $20, $45, $47, $47, $53, $00, $52
db $37, $48, $52, $45, $49, $00, $4F, $45, $55, $46, $53, $20, $42, $52, $4F, $55
db $49, $4C, $4C, $45, $53, $00, $48, $55, $45, $56, $4F, $53, $20, $52, $45, $56
db $55, $45, $4C, $54, $4F, $53, $00, $55, $4F, $56, $41, $20, $53, $54, $52, $41
db $50, $41, $5A, $5A, $41, $54, $45, $00, $46, $49, $53, $48, $20, $46, $49, $4C
db $4C, $45, $54, $00, $46, $49, $53, $43, $48, $46, $49, $4C, $45, $54, $00, $46
db $49, $4C, $45, $54, $20, $44, $45, $20, $50, $4F, $49, $53, $53, $4F, $4E, $00
db $46, $49, $4C, $45, $54, $45, $20, $44, $45, $20, $50, $45, $53, $43, $41, $44
db $4F, $00, $46, $49, $4C, $45, $54, $54, $4F, $20, $44, $49, $20, $50, $45, $53
db $43, $45, $00, $4C, $4F, $42, $53, $54, $45, $52, $00, $48, $55, $4D, $4D, $45
db $52, $00, $48, $4F, $4D, $41, $52, $44, $00, $4C, $41, $4E, $47, $4F, $53, $54
db $41, $00, $41, $52, $41, $47, $4F, $53, $54, $41, $00, $43, $48, $49, $43, $4B
db $45, $4E, $00, $48, $37, $48, $4E, $43, $48, $45, $4E, $00, $50, $4F, $55, $4C
db $45, $54, $00, $50, $4F, $4C, $4C, $4F, $00, $50, $4F, $4C, $4C, $4F, $00, $44
db $55, $43, $4B, $00, $45, $4E, $54, $45, $00, $43, $41, $4E, $41, $52, $44, $00
db $50, $41, $54, $4F, $00, $41, $4E, $41, $54, $52, $41, $00, $46, $52, $55, $49
db $54, $20, $53, $41, $4C, $41, $44, $00, $46, $52, $55, $43, $48, $54, $53, $41
db $4C, $41, $54, $00, $4D, $41, $43, $45, $44, $4F, $49, $4E, $45, $20, $44, $45
db $20, $46, $52, $55, $49, $54, $53, $00, $45, $4E, $53, $41, $4C, $41, $44, $41
db $20, $44, $45, $20, $46, $52, $55, $54, $41, $53, $00, $4D, $41, $43, $45, $44
db $4F, $4E, $49, $41, $20, $44, $49, $20, $46, $52, $55, $54, $54, $41, $00, $52
db $4F, $41, $53, $54, $20, $42, $45, $45, $46, $00, $52, $4F, $41, $53, $54, $42
db $45, $45, $46, $00, $52, $4F, $53, $42, $49, $46, $00, $52, $4F, $53, $42, $49
db $46, $00, $52, $4F, $41, $53, $54, $42, $45, $45, $46, $00, $52, $4F, $41, $53
db $54, $20, $50, $4F, $52, $4B, $00, $53, $43, $48, $57, $45, $49, $4E, $45, $42
db $52, $41, $54, $45, $4E, $00, $52, $4F, $54, $49, $20, $44, $45, $20, $50, $4F
db $52, $43, $00, $43, $45, $52, $44, $4F, $20, $41, $53, $41, $44, $4F, $00, $41
db $52, $52, $4F, $53, $54, $4F, $20, $44, $49, $20, $4D, $41, $49, $41, $4C, $45
db $00, $52, $4F, $41, $53, $54, $20, $4C, $41, $4D, $42, $00, $4C, $41, $4D, $4D
db $42, $52, $41, $54, $45, $4E, $00, $52, $4F, $54, $49, $20, $44, $27, $41, $47
db $4E, $45, $41, $55, $00, $43, $4F, $52, $44, $45, $52, $4F, $20, $41, $53, $41
db $44, $4F, $00, $41, $52, $52, $4F, $53, $54, $4F, $20, $44, $27, $41, $47, $4E
db $45, $4C, $4C, $4F, $00, $53, $41, $55, $53, $41, $47, $45, $00, $57, $38, $52
db $53, $54, $43, $48, $45, $4E, $00, $53, $41, $55, $43, $49, $53, $53, $45, $00
db $53, $41, $4C, $43, $48, $49, $43, $48, $41, $00, $53, $41, $4C, $53, $49, $43
db $43, $49, $41, $00, $4C, $49, $56, $45, $52, $20, $50, $41, $54, $35, $00, $4C
db $45, $42, $45, $52, $50, $41, $53, $54, $45, $54, $45, $00, $50, $41, $54, $45
db $20, $44, $45, $20, $46, $4F, $49, $45, $00, $50, $41, $54, $45, $20, $44, $45
db $20, $48, $49, $47, $41, $44, $4F, $00, $50, $41, $54, $45, $20, $44, $49, $20
db $46, $45, $47, $41, $54, $4F, $00, $54, $4F, $4D, $41, $54, $4F, $00, $54, $4F
db $4D, $41, $54, $45, $00, $54, $4F, $4D, $41, $54, $45, $00, $54, $4F, $4D, $41
db $54, $45, $00, $50, $4F, $4D, $4F, $44, $4F, $52, $4F, $00, $43, $48, $45, $45
db $53, $45, $00, $4B, $32, $53, $45, $00, $46, $52, $4F, $4D, $41, $47, $45, $00
db $51, $55, $45, $53, $4F, $00, $46, $4F, $52, $4D, $41, $47, $47, $49, $4F, $00
db $50, $4C, $41, $49, $4E, $20, $4F, $4D, $45, $4C, $45, $54, $00, $4F, $4D, $45
db $4C, $45, $54, $54, $20, $4E, $41, $54, $55, $52, $45, $4C, $4C, $00, $4F, $4D
db $45, $4C, $45, $54, $54, $45, $20, $4E, $41, $54, $55, $52, $45, $00, $54, $4F
db $52, $54, $49, $4C, $4C, $41, $20, $46, $52, $41, $4E, $43, $45, $53, $41, $00
db $46, $52, $49, $54, $54, $41, $54, $41, $00, $43, $52, $45, $41, $4D, $45, $44
db $20, $53, $4F, $55, $50, $00, $4C, $45, $47, $49, $45, $52, $54, $45, $20, $53
db $55, $50, $50, $45, $00, $56, $45, $4C, $4F, $55, $54, $45, $00, $43, $52, $45
db $4D, $41, $00, $4D, $49, $4E, $45, $53, $54, $52, $41, $00, $56, $45, $47, $45
db $54, $41, $42, $4C, $45, $20, $53, $4F, $55, $50, $00, $47, $45, $4D, $37, $53
db $45, $53, $55, $50, $50, $45, $00, $53, $4F, $55, $50, $45, $20, $44, $45, $20
db $4C, $45, $47, $55, $4D, $45, $53, $00, $53, $4F, $50, $41, $20, $44, $45, $20
db $4C, $45, $47, $55, $4D, $42, $52, $45, $53, $00, $5A, $55, $50, $50, $41, $20
db $44, $49, $20, $56, $45, $52, $44, $55, $52, $45, $00, $43, $48, $49, $43, $4B
db $45, $4E, $20, $53, $4F, $55, $50, $00, $48, $37, $48, $4E, $45, $52, $42, $52
db $37, $48, $45, $00, $53, $4F, $55, $50, $45, $20, $41, $55, $20, $50, $4F, $55
db $4C, $45, $54, $00, $53, $4F, $50, $41, $20, $44, $45, $20, $50, $4F, $4C, $4C
db $4F, $00, $42, $52, $4F, $44, $4F, $20, $44, $49, $20, $50, $4F, $4C, $4C, $4F
db $00, $46, $49, $53, $48, $20, $53, $4F, $55, $50, $00, $46, $49, $53, $43, $48
db $53, $55, $50, $50, $45, $00, $53, $4F, $55, $50, $45, $20, $44, $45, $20, $50
db $4F, $49, $53, $53, $4F, $4E, $00, $53, $4F, $50, $41, $20, $44, $45, $20, $50
db $45, $53, $43, $41, $44, $4F, $00, $5A, $55, $50, $50, $41, $20, $44, $49, $20
db $50, $45, $53, $43, $45, $00, $41, $53, $50, $41, $52, $41, $47, $55, $53, $20
db $53, $4F, $55, $50, $00, $53, $50, $41, $52, $47, $45, $4C, $53, $55, $50, $50
db $45, $00, $43, $52, $45, $4D, $45, $20, $44, $27, $41, $53, $50, $45, $52, $47
db $45, $53, $00, $5A, $55, $50, $50, $41, $20, $44, $49, $20, $41, $53, $50, $41
db $52, $41, $47, $49, $00, $43, $52, $45, $4D, $41, $20, $44, $49, $20, $41, $53
db $50, $41, $52, $41, $47, $49, $00, $4E, $4F, $4F, $44, $4C, $45, $20, $53, $4F
db $55, $50, $00, $4E, $55, $44, $45, $4C, $53, $55, $50, $50, $45, $00, $53, $4F
db $55, $50, $45, $20, $41, $55, $20, $56, $45, $52, $4D, $49, $43, $45, $4C, $4C
db $45, $00, $53, $4F, $50, $41, $20, $44, $45, $20, $46, $49, $44, $45, $4F, $53
db $00, $54, $41, $47, $4C, $49, $41, $54, $45, $4C, $4C, $45, $20, $49, $4E, $20
db $42, $52, $4F, $44, $4F, $00, $50, $4C, $41, $49, $43, $45, $00, $53, $43, $48
db $4F, $4C, $4C, $45, $00, $43, $41, $52, $52, $45, $4C, $45, $54, $00, $50, $4C
db $41, $54, $49, $4A, $41, $00, $50, $41, $53, $53, $45, $52, $41, $20, $44, $49
db $20, $4D, $41, $52, $45, $00, $53, $41, $4C, $4D, $4F, $4E, $00, $4C, $41, $43
db $48, $53, $00, $53, $41, $55, $4D, $4F, $4E, $00, $53, $41, $4C, $4D, $4F, $4E
db $00, $53, $41, $4C, $4D, $4F, $4E, $45, $00, $54, $52, $4F, $55, $54, $00, $46
db $4F, $52, $45, $4C, $4C, $45, $00, $54, $52, $55, $49, $54, $45, $00, $54, $52
db $55, $43, $48, $41, $00, $54, $52, $4F, $54, $41, $00, $48, $41, $4C, $49, $42
db $55, $54, $00, $48, $45, $49, $4C, $42, $55, $54, $54, $00, $46, $4C, $45, $54
db $41, $4E, $00, $48, $49, $50, $4F, $47, $4C, $4F, $53, $4F, $00, $49, $50, $50
db $4F, $47, $4C, $4F, $53, $53, $4F, $00, $43, $4F, $44, $00, $4B, $41, $42, $45
db $4C, $4A, $41, $55, $00, $4D, $4F, $52, $55, $45, $00, $42, $41, $43, $41, $4C
db $41, $4F, $00, $4D, $45, $52, $4C, $55, $5A, $5A, $4F, $00, $53, $4F, $4C, $45
db $00, $53, $45, $45, $5A, $55, $4E, $47, $45, $00, $53, $4F, $4C, $45, $00, $4C
db $45, $4E, $47, $55, $41, $44, $4F, $00, $53, $4F, $47, $4C, $49, $4F, $4C, $41
db $00, $54, $55, $4E, $41, $00, $54, $48, $55, $4E, $46, $49, $53, $43, $48, $00
db $54, $48, $4F, $4E, $00, $41, $54, $55, $4E, $00, $54, $4F, $4E, $4E, $4F, $00
db $50, $52, $41, $57, $4E, $53, $00, $53, $43, $41, $4D, $50, $49, $00, $43, $52
db $45, $56, $45, $54, $54, $45, $53, $00, $4C, $41, $4E, $47, $4F, $53, $54, $49
db $4E, $4F, $00, $47, $41, $4D, $42, $45, $52, $49, $00, $53, $43, $41, $4D, $50
db $49, $00, $4C, $41, $4E, $47, $55, $53, $54, $45, $00, $4C, $41, $4E, $47, $4F
db $55, $53, $54, $49, $4E, $45, $00, $47, $41, $4D, $42, $41, $00, $53, $43, $41
db $4D, $50, $49, $00, $43, $52, $41, $42, $00, $54, $41, $53, $43, $48, $45, $4E
db $4B, $52, $45, $42, $53, $00, $43, $52, $41, $42, $45, $00, $43, $41, $4E, $47
db $52, $45, $4A, $4F, $20, $44, $45, $20, $4D, $41, $52, $00, $47, $52, $41, $4E
db $43, $48, $49, $4F, $00, $4F, $59, $53, $54, $45, $52, $00, $41, $55, $53, $54
db $45, $52, $00, $48, $55, $49, $54, $52, $45, $00, $4F, $53, $54, $52, $41, $00
db $4F, $53, $54, $52, $49, $43, $41, $00, $4D, $55, $53, $53, $45, $4C, $00, $4D
db $55, $53, $43, $48, $45, $4C, $00, $4D, $4F, $55, $4C, $45, $00, $4D, $45, $4A
db $49, $4C, $4C, $4F, $4E, $00, $43, $4F, $5A, $5A, $41, $00, $53, $4E, $41, $49
db $4C, $00, $57, $45, $49, $4E, $42, $45, $52, $47, $53, $43, $48, $4E, $45, $43
db $4B, $45, $00, $45, $53, $43, $41, $52, $47, $4F, $54, $00, $43, $41, $52, $41
db $43, $4F, $4C, $00, $4C, $55, $4D, $41, $43, $41, $00, $50, $4F, $54, $41, $54
db $4F, $45, $53, $00, $4B, $41, $52, $54, $4F, $46, $46, $45, $4C, $4E, $00, $50
db $4F, $4D, $4D, $45, $53, $20, $44, $45, $20, $54, $45, $52, $52, $45, $00, $50
db $41, $54, $41, $54, $41, $53, $00, $50, $41, $54, $41, $54, $45, $00, $43, $48
db $49, $50, $53, $00, $50, $4F, $4D, $4D, $45, $53, $20, $46, $52, $49, $54, $45
db $53, $00, $50, $4F, $4D, $4D, $45, $53, $20, $46, $52, $49, $54, $45, $53, $00
db $50, $41, $54, $41, $54, $41, $53, $20, $46, $52, $49, $54, $41, $53, $00, $50
db $41, $54, $41, $54, $49, $4E, $45, $20, $46, $52, $49, $54, $54, $45, $00, $43
db $41, $42, $42, $41, $47, $45, $00, $4B, $4F, $48, $4C, $00, $43, $48, $4F, $55
db $00, $43, $4F, $4C, $00, $43, $41, $56, $4F, $4C, $4F, $00, $43, $41, $55, $4C
db $49, $46, $4C, $4F, $57, $45, $52, $00, $42, $4C, $55, $4D, $45, $4E, $4B, $4F
db $48, $4C, $00, $43, $48, $4F, $55, $2D, $46, $4C, $45, $55, $52, $00, $43, $4F
db $4C, $49, $46, $4C, $4F, $52, $00, $43, $41, $56, $4F, $4C, $46, $49, $4F, $52
db $45, $00, $42, $52, $4F, $43, $43, $4F, $4C, $49, $00, $42, $52, $4F, $4B, $4B
db $4F, $4C, $49, $00, $42, $52, $4F, $43, $4F, $4C, $49, $00, $42, $52, $4F, $43
db $4F, $4C, $49, $00, $42, $52, $4F, $43, $43, $4F, $4C, $49, $00, $4F, $4E, $49
db $4F, $4E, $00, $5A, $57, $49, $45, $42, $45, $4C, $00, $4F, $49, $47, $4E, $4F
db $4E, $00, $43, $45, $42, $4F, $4C, $4C, $41, $00, $43, $49, $50, $50, $4F, $4C
db $41, $00, $47, $41, $52, $4C, $49, $43, $00, $4B, $4E, $4F, $42, $4C, $41, $55
db $43, $48, $00, $41, $49, $4C, $00, $41, $4A, $4F, $00, $41, $47, $4C, $49, $4F
db $00, $4C, $45, $54, $54, $55, $43, $45, $00, $53, $41, $4C, $41, $54, $4B, $4F
db $50, $46, $00, $4C, $41, $49, $54, $55, $45, $00, $4C, $45, $43, $48, $55, $47
db $41, $00, $4C, $41, $54, $54, $55, $47, $41, $00, $43, $45, $4C, $45, $52, $59
db $00, $53, $54, $41, $4E, $47, $45, $4E, $53, $45, $4C, $4C, $45, $52, $49, $45
db $00, $43, $45, $4C, $45, $52, $49, $00, $41, $50, $49, $4F, $00, $53, $45, $44
db $41, $4E, $4F, $00, $41, $52, $54, $49, $43, $48, $4F, $4B, $45, $00, $41, $52
db $54, $49, $53, $43, $48, $4F, $43, $4B, $45, $00, $41, $52, $54, $49, $43, $48
db $41, $55, $54, $00, $41, $4C, $43, $41, $43, $48, $4F, $46, $41, $00, $43, $41
db $52, $43, $49, $4F, $46, $4F, $00, $48, $4F, $52, $53, $45, $52, $41, $44, $49
db $53, $48, $00, $4D, $45, $45, $52, $52, $45, $54, $54, $49, $43, $48, $00, $52
db $41, $49, $46, $4F, $52, $54, $00, $52, $41, $42, $41, $4E, $4F, $20, $50, $49
db $43, $41, $4E, $54, $45, $00, $52, $41, $50, $41, $4E, $45, $4C, $4C, $49, $00
db $53, $50, $49, $4E, $41, $43, $48, $00, $53, $50, $49, $4E, $41, $54, $00, $45
db $50, $49, $4E, $41, $52, $44, $53, $00, $45, $53, $50, $49, $4E, $41, $43, $41
db $00, $53, $50, $49, $4E, $41, $43, $49, $00, $42, $45, $45, $54, $52, $4F, $4F
db $54, $2F, $42, $45, $45, $54, $00, $52, $4F, $54, $45, $20, $42, $45, $45, $54
db $45, $00, $42, $45, $54, $54, $45, $52, $41, $56, $45, $00, $52, $45, $4D, $4F
db $4C, $41, $43, $48, $41, $00, $42, $41, $52, $42, $41, $42, $49, $45, $54, $4F
db $4C, $41, $00, $4C, $45, $45, $4B, $53, $00, $50, $4F, $52, $52, $45, $45, $00
db $50, $4F, $49, $52, $45, $41, $55, $58, $00, $50, $55, $45, $52, $52, $4F, $00
db $50, $4F, $52, $52, $49, $00, $43, $4F, $52, $4E, $00, $4D, $41, $49, $53, $00
db $4D, $41, $49, $53, $00, $4D, $41, $49, $5A, $00, $47, $52, $41, $4E, $4F, $54
db $55, $52, $43, $4F, $00, $43, $55, $43, $55, $4D, $42, $45, $52, $00, $47, $55
db $52, $4B, $45, $00, $43, $4F, $4E, $43, $4F, $4D, $42, $52, $45, $00, $50, $45
db $50, $49, $4E, $4F, $00, $43, $45, $54, $52, $49, $4F, $4C, $4F, $00, $43, $41
db $52, $52, $4F, $54, $53, $00, $4B, $41, $52, $4F, $54, $54, $45, $4E, $00, $43
db $41, $52, $4F, $54, $54, $45, $53, $00, $5A, $41, $4E, $41, $48, $4F, $52, $49
db $41, $53, $00, $43, $41, $52, $4F, $54, $45, $00, $42, $45, $41, $4E, $53, $00
db $42, $4F, $48, $4E, $45, $4E, $00, $48, $41, $52, $49, $43, $4F, $54, $53, $00
db $4A, $55, $44, $49, $41, $53, $00, $46, $41, $47, $49, $4F, $4C, $49, $00, $50
db $45, $41, $53, $00, $45, $52, $42, $53, $45, $4E, $00, $50, $4F, $49, $53, $00
db $47, $55, $49, $53, $41, $4E, $54, $45, $53, $00, $50, $49, $53, $45, $4C, $4C
db $49, $00, $41, $53, $50, $41, $52, $41, $47, $55, $53, $00, $53, $50, $41, $52
db $47, $45, $4C, $00, $41, $53, $50, $45, $52, $47, $45, $53, $00, $45, $53, $50
db $41, $52, $52, $41, $47, $4F, $53, $00, $41, $53, $50, $41, $52, $41, $47, $49
db $00, $52, $49, $43, $45, $00, $52, $45, $49, $53, $00, $52, $49, $5A, $00, $41
db $52, $52, $4F, $5A, $00, $52, $49, $53, $4F, $00, $4F, $4C, $49, $56, $45, $53
db $00, $4F, $4C, $49, $56, $45, $4E, $00, $4F, $4C, $49, $56, $45, $53, $00, $41
db $43, $45, $49, $54, $55, $4E, $41, $53, $00, $4F, $4C, $49, $56, $45, $00, $4D
db $55, $53, $48, $52, $4F, $4F, $4D, $53, $00, $50, $49, $4C, $5A, $45, $00, $43
db $48, $41, $4D, $50, $49, $47, $4E, $4F, $4E, $53, $00, $48, $4F, $4E, $47, $4F
db $53, $00, $46, $55, $4E, $47, $48, $49, $00, $47, $4F, $4F, $53, $45, $00, $47
db $41, $4E, $53, $00, $4F, $49, $45, $00, $47, $41, $4E, $53, $4F, $00, $4F, $43
db $41, $00, $50, $48, $45, $41, $53, $41, $4E, $54, $00, $46, $41, $53, $41, $4E
db $00, $46, $41, $49, $53, $41, $4E, $00, $46, $41, $49, $53, $41, $4E, $00, $46
db $41, $47, $49, $41, $4E, $4F, $00, $54, $55, $52, $4B, $45, $59, $00, $54, $52
db $55, $54, $48, $41, $48, $4E, $00, $44, $49, $4E, $44, $45, $00, $50, $41, $56
db $4F, $00, $54, $41, $43, $43, $48, $49, $4E, $4F, $00, $52, $41, $42, $42, $49
db $54, $00, $4B, $41, $4E, $49, $4E, $43, $48, $45, $4E, $00, $4C, $41, $50, $49
db $4E, $00, $43, $4F, $4E, $45, $4A, $4F, $00, $43, $4F, $4E, $49, $47, $4C, $49
db $4F, $00, $53, $54, $45, $41, $4B, $00, $52, $49, $4E, $44, $45, $52, $53, $54
db $45, $41, $4B, $00, $42, $49, $46, $54, $45, $43, $4B, $00, $42, $49, $46, $54
db $45, $43, $00, $42, $49, $53, $54, $45, $43, $43, $41, $00, $53, $54, $45, $41
db $4B, $20, $54, $41, $52, $54, $41, $52, $45, $00, $54, $41, $52, $54, $41, $52
db $42, $45, $45, $46, $53, $54, $45, $41, $4B, $00, $53, $54, $45, $41, $4B, $20
db $48, $41, $43, $48, $45, $20, $54, $41, $52, $54, $41, $52, $45, $00, $42, $49
db $46, $54, $45, $43, $20, $54, $41, $52, $54, $41, $52, $4F, $00, $42, $49, $53
db $54, $45, $43, $43, $41, $20, $41, $4C, $4C, $41, $20, $54, $41, $52, $54, $41
db $52, $41, $00, $48, $41, $4D, $00, $53, $43, $48, $49, $4E, $4B, $45, $4E, $00
db $4A, $41, $4D, $42, $4F, $4E, $00, $4A, $41, $4D, $4F, $4E, $00, $50, $52, $4F
db $53, $43, $49, $55, $54, $54, $4F, $00, $42, $41, $43, $4F, $4E, $00, $53, $50
db $45, $43, $4B, $00, $42, $41, $43, $4F, $4E, $00, $54, $4F, $43, $49, $4E, $4F
db $00, $50, $41, $4E, $43, $45, $54, $54, $41, $00, $42, $4C, $41, $43, $4B, $20
db $50, $55, $44, $44, $49, $4E, $47, $00, $42, $4C, $55, $54, $57, $55, $52, $53
db $54, $00, $42, $4F, $55, $44, $49, $4E, $00, $4D, $4F, $52, $43, $49, $4C, $4C
db $41, $00, $53, $41, $4E, $47, $55, $49, $4E, $41, $43, $43, $49, $4F, $00, $4D
db $45, $41, $54, $42, $41, $4C, $4C, $53, $00, $46, $52, $49, $4B, $41, $44, $45
db $4C, $4C, $45, $4E, $00, $42, $4F, $55, $4C, $45, $54, $54, $45, $53, $20, $44
db $45, $20, $56, $49, $41, $4E, $44, $45, $00, $41, $4C, $42, $4F, $4E, $44, $49
db $47, $41, $53, $00, $50, $4F, $4C, $50, $45, $54, $54, $49, $4E, $45, $00, $42
db $4F, $49, $4C, $45, $44, $00, $47, $45, $4B, $4F, $43, $48, $54, $00, $42, $4F
db $55, $49, $4C, $4C, $49, $00, $43, $4F, $43, $49, $44, $4F, $00, $42, $4F, $4C
db $4C, $49, $54, $4F, $00, $52, $4F, $41, $53, $54, $45, $44, $00, $47, $45, $42
db $52, $41, $54, $45, $4E, $00, $52, $4F, $54, $49, $00, $41, $53, $41, $44, $4F
db $00, $41, $52, $52, $4F, $53, $54, $4F, $00, $46, $52, $49, $45, $44, $00, $47
db $45, $42, $52, $41, $54, $45, $4E, $00, $46, $52, $49, $54, $00, $46, $52, $49
db $54, $4F, $00, $46, $52, $49, $54, $54, $4F, $00, $53, $4D, $4F, $4B, $45, $44
db $00, $47, $45, $52, $31, $55, $43, $48, $45, $52, $54, $00, $46, $55, $4D, $45
db $00, $41, $48, $55, $4D, $41, $44, $4F, $00, $41, $46, $46, $55, $4D, $49, $43
db $41, $54, $4F, $00, $53, $54, $45, $57, $45, $44, $00, $47, $45, $53, $43, $48
db $4D, $4F, $52, $54, $00, $41, $20, $4C, $27, $45, $54, $4F, $55, $46, $46, $45
db $45, $00, $45, $53, $54, $4F, $46, $41, $44, $4F, $00, $53, $54, $55, $46, $41
db $54, $4F, $00, $43, $48, $4F, $50, $50, $45, $44, $00, $47, $45, $48, $41, $43
db $4B, $54, $00, $48, $41, $43, $48, $45, $00, $50, $49, $43, $41, $44, $4F, $00
db $54, $52, $49, $54, $41, $54, $4F, $00, $53, $41, $4C, $54, $45, $44, $00, $47
db $45, $53, $41, $4C, $5A, $45, $4E, $00, $53, $41, $4C, $45, $00, $53, $41, $4C
db $41, $44, $4F, $00, $53, $41, $4C, $41, $54, $4F, $00, $53, $57, $45, $45, $54
db $45, $4E, $45, $44, $00, $47, $45, $53, $38, $33, $54, $00, $53, $55, $43, $52
db $45, $00, $45, $4E, $44, $55, $4C, $5A, $41, $44, $4F, $00, $41, $44, $44, $4F
db $4C, $43, $49, $54, $4F, $00, $53, $54, $55, $46, $46, $45, $44, $00, $47, $45
db $46, $38, $4C, $4C, $54, $00, $46, $4F, $55, $52, $52, $45, $00, $52, $45, $4C
db $4C, $45, $4E, $4F, $00, $52, $49, $50, $49, $45, $4E, $4F, $00, $42, $52, $45
db $41, $44, $45, $44, $00, $50, $41, $4E, $49, $45, $52, $54, $00, $50, $41, $4E
db $45, $00, $45, $4D, $50, $41, $4E, $41, $44, $4F, $00, $49, $4D, $50, $41, $4E
db $41, $54, $4F, $00, $52, $41, $57, $00, $52, $4F, $48, $00, $43, $52, $55, $00
db $43, $52, $55, $44, $4F, $00, $43, $52, $55, $44, $4F, $00, $52, $41, $52, $45
db $00, $4B, $55, $52, $5A, $47, $45, $42, $52, $41, $54, $45, $4E, $00, $50, $45
db $55, $20, $52, $4F, $54, $49, $00, $50, $4F, $43, $4F, $20, $41, $53, $41, $44
db $4F, $00, $50, $4F, $43, $4F, $20, $43, $4F, $54, $54, $4F, $00, $4D, $45, $44
db $49, $55, $4D, $00, $4D, $45, $44, $49, $55, $4D, $00, $41, $20, $50, $4F, $49
db $4E, $54, $00, $4D, $45, $44, $49, $4F, $00, $43, $4F, $54, $54, $4F, $20, $41
db $20, $50, $55, $4E, $54, $49, $4E, $4F, $00, $4D, $45, $44, $49, $55, $4D, $20
db $52, $41, $52, $45, $00, $4D, $45, $44, $49, $55, $4D, $20, $52, $41, $52, $45
db $00, $53, $41, $49, $47, $4E, $41, $4E, $54, $00, $50, $4F, $43, $4F, $20, $43
db $4F, $43, $49, $44, $4F, $00, $41, $4C, $20, $53, $41, $4E, $47, $55, $45, $00
db $4D, $45, $44, $49, $55, $4D, $20, $57, $45, $4C, $4C, $00, $4D, $45, $44, $49
db $55, $4D, $20, $57, $45, $4C, $4C, $00, $41, $20, $50, $4F, $49, $4E, $54, $00
db $4D, $45, $44, $49, $4F, $20, $43, $4F, $43, $49, $44, $4F, $00, $43, $4F, $54
db $54, $4F, $20, $41, $20, $50, $55, $4E, $54, $49, $4E, $4F, $00, $57, $45, $4C
db $4C, $20, $44, $4F, $4E, $45, $00, $44, $55, $52, $43, $48, $47, $45, $42, $52
db $41, $54, $45, $4E, $00, $42, $49, $45, $4E, $20, $43, $55, $49, $54, $00, $42
db $49, $45, $4E, $20, $43, $4F, $43, $49, $44, $4F, $00, $42, $45, $4E, $20, $43
db $4F, $54, $54, $4F, $00, $47, $52, $49, $4C, $4C, $45, $44, $00, $47, $45, $47
db $52, $49, $4C, $4C, $54, $00, $47, $52, $49, $4C, $4C, $45, $00, $41, $20, $4C
db $41, $20, $50, $41, $52, $52, $49, $4C, $4C, $41, $00, $41, $4C, $4C, $41, $20
db $47, $52, $49, $47, $4C, $49, $41, $00, $46, $4C, $41, $4D, $42, $35, $44, $2F
db $46, $4C, $41, $4D, $42, $35, $45, $44, $00, $46, $4C, $41, $4D, $42, $49, $45
db $52, $54, $00, $46, $4C, $41, $4D, $42, $45, $00, $46, $4C, $41, $4D, $45, $41
db $44, $4F, $00, $41, $4C, $4C, $41, $20, $46, $49, $41, $4D, $4D, $41, $00, $47
db $52, $41, $56, $59, $00, $42, $52, $41, $54, $45, $4E, $53, $4F, $33, $45, $00
db $53, $41, $55, $43, $45, $00, $4A, $55, $47, $4F, $00, $53, $55, $47, $4F, $20
db $44, $49, $20, $43, $41, $52, $4E, $45, $00, $4C, $4F, $42, $53, $54, $45, $52
db $20, $53, $41, $55, $43, $45, $00, $48, $55, $4D, $4D, $45, $52, $53, $4F, $33
db $45, $00, $53, $41, $55, $43, $45, $20, $41, $55, $20, $48, $4F, $4D, $41, $52
db $44, $00, $53, $41, $4C, $53, $41, $20, $44, $45, $20, $4C, $41, $4E, $47, $4F
db $53, $54, $41, $00, $53, $41, $4C, $53, $41, $20, $41, $4C, $4C, $27, $41, $52
db $41, $47, $4F, $53, $54, $41, $00, $54, $4F, $4D, $41, $54, $4F, $20, $53, $41
db $55, $43, $45, $00, $54, $4F, $4D, $41, $54, $45, $4E, $53, $4F, $33, $45, $00
db $53, $41, $55, $43, $45, $20, $54, $4F, $4D, $41, $54, $45, $00, $53, $41, $4C
db $53, $41, $20, $44, $45, $20, $54, $4F, $4D, $41, $54, $45, $00, $53, $41, $4C
db $53, $41, $20, $44, $49, $20, $50, $4F, $4D, $4F, $44, $4F, $52, $4F, $00, $4C
db $45, $4D, $4F, $4E, $20, $53, $41, $55, $43, $45, $00, $5A, $49, $54, $52, $4F
db $4E, $45, $4E, $53, $4F, $33, $45, $00, $53, $41, $55, $43, $45, $20, $41, $55
db $20, $43, $49, $54, $52, $4F, $4E, $00, $53, $41, $4C, $53, $41, $20, $44, $45
db $20, $4C, $49, $4D, $4F, $4E, $00, $53, $41, $4C, $53, $41, $20, $41, $4C, $20
db $4C, $49, $4D, $4F, $4E, $45, $00, $48, $4F, $4C, $4C, $41, $4E, $44, $41, $49
db $53, $45, $20, $53, $41, $55, $43, $45, $00, $48, $4F, $4C, $4C, $41, $4E, $44
db $41, $49, $53, $45, $53, $4F, $33, $45, $00, $53, $41, $55, $43, $45, $20, $48
db $4F, $4C, $4C, $41, $4E, $44, $41, $49, $53, $45, $00, $53, $41, $4C, $53, $41
db $20, $48, $4F, $4C, $41, $4E, $44, $45, $53, $41, $00, $53, $41, $4C, $53, $41
db $20, $4F, $4C, $41, $4E, $44, $45, $53, $45, $00, $54, $41, $52, $54, $41, $52
db $20, $53, $41, $55, $43, $45, $00, $52, $45, $4D, $4F, $55, $4C, $41, $44, $45
db $4E, $53, $4F, $33, $45, $00, $53, $41, $55, $43, $45, $20, $54, $41, $52, $54
db $41, $52, $45, $00, $53, $41, $4C, $53, $41, $20, $54, $41, $52, $54, $41, $52
db $41, $00, $53, $41, $4C, $53, $41, $20, $54, $41, $52, $54, $41, $52, $41, $00
db $4D, $41, $59, $4F, $4E, $4E, $41, $49, $53, $45, $00, $4D, $41, $59, $4F, $4E
db $4E, $41, $49, $53, $45, $00, $4D, $41, $59, $4F, $4E, $4E, $41, $49, $53, $45
db $00, $4D, $41, $59, $4F, $4E, $45, $53, $41, $00, $4D, $41, $49, $4F, $4E, $45
db $53, $45, $00, $53, $59, $52, $55, $50, $00, $53, $49, $52, $55, $50, $00, $53
db $49, $52, $4F, $50, $00, $4A, $41, $52, $41, $42, $45, $00, $53, $43, $49, $52
db $4F, $50, $50, $4F, $00, $50, $45, $50, $50, $45, $52, $00, $50, $46, $45, $46
db $46, $45, $52, $00, $50, $4F, $49, $56, $52, $45, $00, $50, $49, $4D, $49, $45
db $4E, $54, $41, $00, $50, $45, $50, $45, $00, $50, $49, $43, $4B, $4C, $45, $53
db $00, $53, $41, $55, $52, $45, $20, $47, $55, $52, $4B, $45, $4E, $00, $50, $49
db $43, $4B, $4C, $45, $53, $00, $50, $45, $50, $49, $4E, $49, $4C, $4C, $4F, $53
db $00, $53, $4F, $54, $54, $41, $43, $45, $54, $49, $00, $53, $41, $4C, $54, $00
db $53, $41, $4C, $5A, $00, $53, $45, $4C, $00, $53, $41, $4C, $00, $53, $41, $4C
db $45, $00, $53, $55, $47, $41, $52, $00, $5A, $55, $43, $4B, $45, $52, $00, $53
db $55, $43, $52, $45, $00, $41, $5A, $55, $43, $41, $52, $00, $5A, $55, $43, $43
db $48, $45, $52, $4F, $00, $56, $49, $4E, $45, $47, $41, $52, $00, $45, $53, $53
db $49, $47, $00, $56, $49, $4E, $41, $49, $47, $52, $45, $00, $56, $49, $4E, $41
db $47, $52, $45, $00, $41, $43, $45, $54, $4F, $00, $4D, $55, $53, $54, $41, $52
db $44, $00, $53, $45, $4E, $46, $00, $4D, $4F, $55, $54, $41, $52, $44, $45, $00
db $4D, $4F, $53, $54, $41, $5A, $41, $00, $53, $45, $4E, $41, $50, $45, $00, $48
db $4F, $4D, $45, $4D, $41, $44, $45, $00, $48, $41, $55, $53, $47, $45, $4D, $41
db $43, $48, $54, $00, $4D, $41, $49, $53, $4F, $4E, $00, $43, $41, $53, $45, $52
db $4F, $00, $46, $41, $54, $54, $4F, $20, $49, $4E, $20, $43, $41, $53, $41, $00
db $4F, $52, $41, $4E, $47, $45, $00, $4F, $52, $41, $4E, $47, $45, $00, $4F, $52
db $41, $4E, $47, $45, $00, $4E, $41, $52, $41, $4E, $4A, $41, $00, $41, $52, $41
db $4E, $43, $49, $41, $00, $50, $49, $4E, $45, $41, $50, $50, $4C, $45, $00, $41
db $4E, $41, $4E, $41, $53, $00, $41, $4E, $41, $4E, $41, $53, $00, $50, $49, $4E
db $41, $00, $41, $4E, $41, $4E, $41, $53, $00, $41, $50, $52, $49, $43, $4F, $54
db $00, $41, $50, $52, $49, $4B, $4F, $53, $45, $00, $41, $42, $52, $49, $43, $4F
db $54, $00, $41, $4C, $42, $41, $52, $49, $43, $4F, $51, $55, $45, $00, $41, $4C
db $42, $49, $43, $4F, $43, $43, $41, $00, $42, $41, $4E, $41, $4E, $41, $00, $42
db $41, $4E, $41, $4E, $45, $00, $42, $41, $4E, $41, $4E, $45, $00, $42, $41, $4E
db $41, $4E, $4F, $00, $42, $41, $4E, $41, $4E, $41, $00, $50, $4C, $55, $4D, $00
db $50, $46, $4C, $41, $55, $4D, $45, $00, $50, $52, $55, $4E, $45, $00, $43, $49
db $52, $55, $45, $4C, $41, $00, $50, $52, $55, $47, $4E, $41, $00, $4D, $49, $58
db $45, $44, $20, $46, $52, $55, $49, $54, $00, $47, $45, $4D, $49, $53, $43, $48
db $54, $45, $53, $20, $4F, $42, $53, $54, $00, $46, $52, $55, $49, $54, $53, $20
db $41, $53, $53, $4F, $52, $54, $49, $53, $00, $46, $52, $55, $54, $41, $53, $20
db $4D, $49, $58, $54, $41, $53, $00, $46, $52, $55, $54, $54, $41, $20, $4D, $49
db $53, $54, $41, $00, $4C, $45, $4D, $4F, $4E, $00, $5A, $49, $54, $52, $4F, $4E
db $45, $00, $43, $49, $54, $52, $4F, $4E, $00, $4C, $49, $4D, $4F, $4E, $00, $4C
db $49, $4D, $4F, $4E, $45, $00, $47, $52, $41, $50, $45, $46, $52, $55, $49, $54
db $00, $47, $52, $41, $50, $45, $46, $52, $55, $49, $54, $00, $50, $41, $4D, $50
db $4C, $45, $4D, $4F, $55, $53, $53, $45, $00, $50, $4F, $4D, $45, $4C, $4F, $00
db $50, $4F, $4D, $50, $45, $4C, $4D, $4F, $00, $50, $45, $41, $43, $48, $00, $50
db $46, $49, $52, $53, $49, $43, $48, $00, $50, $45, $43, $48, $45, $00, $4D, $45
db $4C, $4F, $43, $4F, $54, $4F, $4E, $00, $50, $45, $53, $43, $41, $00, $50, $45
db $41, $52, $00, $42, $49, $52, $4E, $45, $00, $50, $4F, $49, $52, $45, $00, $50
db $45, $52, $41, $00, $50, $45, $52, $41, $00, $41, $50, $50, $4C, $45, $00, $41
db $50, $46, $45, $4C, $00, $50, $4F, $4D, $4D, $45, $00, $4D, $41, $4E, $5A, $41
db $4E, $41, $00, $4D, $45, $4C, $41, $00, $4D, $45, $4C, $4F, $4E, $00, $4D, $45
db $4C, $4F, $4E, $45, $00, $4D, $45, $4C, $4F, $4E, $00, $4D, $45, $4C, $4F, $4E
db $00, $4D, $45, $4C, $4F, $4E, $45, $00, $52, $41, $53, $50, $42, $45, $52, $52
db $59, $00, $48, $49, $4D, $42, $45, $45, $52, $45, $00, $46, $52, $41, $4D, $42
db $4F, $49, $53, $45, $00, $46, $52, $41, $4D, $42, $55, $45, $53, $41, $00, $4C
db $41, $4D, $50, $4F, $4E, $45, $00, $53, $54, $52, $41, $57, $42, $45, $52, $52
db $59, $00, $45, $52, $44, $42, $45, $45, $52, $45, $00, $46, $52, $41, $49, $53
db $45, $00, $46, $52, $45, $53, $41, $00, $46, $52, $41, $47, $4F, $4C, $41, $00
db $43, $48, $45, $52, $52, $59, $00, $4B, $49, $52, $53, $43, $48, $45, $00, $43
db $45, $52, $49, $53, $45, $00, $43, $45, $52, $45, $5A, $41, $00, $43, $49, $4C
db $49, $45, $47, $49, $41, $00, $43, $52, $41, $4E, $42, $45, $52, $52, $59, $00
db $50, $52, $45, $49, $53, $45, $4C, $42, $45, $45, $52, $45, $00, $43, $41, $4E
db $4E, $45, $42, $45, $52, $47, $45, $00, $41, $52, $41, $4E, $44, $41, $4E, $4F
db $20, $52, $4F, $4A, $4F, $00, $4D, $49, $52, $54, $49, $4C, $4C, $4F, $00, $47
db $52, $41, $50, $45, $00, $57, $45, $49, $4E, $54, $52, $41, $55, $42, $45, $00
db $52, $41, $49, $53, $49, $4E, $00, $55, $56, $41, $00, $55, $56, $41, $00, $48
db $41, $5A, $45, $4C, $4E, $55, $54, $00, $48, $41, $53, $45, $4C, $4E, $55, $33
db $00, $4E, $4F, $49, $53, $45, $54, $54, $45, $00, $41, $56, $45, $4C, $4C, $41
db $4E, $41, $53, $00, $4E, $4F, $43, $43, $49, $4F, $4C, $41, $00, $43, $4F, $43
db $4F, $4E, $55, $54, $00, $4B, $4F, $4B, $4F, $53, $4E, $55, $33, $00, $4E, $4F
db $49, $58, $20, $44, $45, $20, $43, $4F, $43, $4F, $00, $43, $4F, $43, $4F, $00
db $4E, $4F, $43, $45, $20, $44, $49, $20, $43, $4F, $43, $43, $4F, $00, $50, $45
db $41, $4E, $55, $54, $00, $45, $52, $44, $4E, $55, $33, $00, $43, $41, $43, $41
db $48, $55, $45, $54, $45, $00, $43, $41, $43, $41, $48, $55, $45, $54, $45, $00
db $41, $52, $41, $43, $48, $49, $44, $45, $00, $46, $52, $55, $49, $54, $20, $50
db $49, $45, $00, $4F, $42, $53, $54, $54, $4F, $52, $54, $45, $00, $54, $41, $52
db $54, $45, $20, $41, $55, $58, $20, $46, $52, $55, $49, $54, $53, $00, $54, $41
db $52, $54, $41, $20, $44, $45, $20, $46, $52, $55, $54, $41, $53, $00, $43, $52
db $4F, $53, $54, $41, $54, $41, $20, $44, $49, $20, $46, $52, $55, $54, $54, $41
db $00, $43, $52, $45, $41, $4D, $20, $43, $41, $52, $41, $4D, $45, $4C, $00, $4B
db $41, $52, $41, $4D, $45, $4C, $50, $55, $44, $44, $49, $4E, $47, $00, $46, $4C
db $41, $4E, $20, $43, $41, $52, $41, $4D, $45, $4C, $00, $46, $4C, $41, $4E, $20
db $43, $41, $52, $41, $4D, $45, $4C, $4F, $00, $43, $52, $45, $4D, $45, $20, $43
db $41, $52, $41, $4D, $45, $4C, $00, $49, $43, $45, $20, $43, $52, $45, $41, $4D
db $00, $45, $49, $53, $00, $47, $4C, $41, $43, $45, $00, $48, $45, $4C, $41, $44
db $4F, $00, $47, $45, $4C, $41, $54, $4F, $00, $53, $4F, $52, $42, $45, $54, $00
db $53, $4F, $52, $42, $45, $54, $00, $53, $4F, $52, $42, $45, $54, $00, $53, $4F
db $52, $42, $45, $54, $45, $00, $53, $4F, $52, $42, $45, $54, $54, $4F, $00, $4D
db $45, $52, $49, $4E, $47, $55, $45, $00, $42, $41, $49, $53, $45, $52, $00, $4D
db $45, $52, $49, $4E, $47, $55, $45, $00, $4D, $45, $52, $45, $4E, $47, $55, $45
db $00, $4D, $45, $52, $49, $4E, $47, $41, $00, $57, $41, $54, $45, $52, $00, $57
db $41, $53, $53, $45, $52, $00, $45, $41, $55, $00, $41, $47, $55, $41, $00, $41
db $43, $51, $55, $41, $00, $54, $4F, $4E, $49, $43, $00, $54, $4F, $4E, $49, $43
db $00, $54, $4F, $4E, $49, $51, $55, $45, $00, $41, $47, $55, $41, $20, $54, $4F
db $4E, $49, $43, $41, $00, $41, $43, $51, $55, $41, $20, $54, $4F, $4E, $49, $43
db $41, $00, $4C, $45, $4D, $4F, $4E, $41, $44, $45, $00, $5A, $49, $54, $52, $4F
db $4E, $45, $4E, $4C, $49, $4D, $4F, $4E, $41, $44, $45, $00, $4C, $49, $4D, $4F
db $4E, $41, $44, $45, $00, $4C, $49, $4D, $4F, $4E, $41, $44, $41, $00, $4C, $49
db $4D, $4F, $4E, $41, $54, $41, $00, $43, $52, $45, $41, $4D, $00, $53, $41, $48
db $4E, $45, $00, $43, $52, $45, $4D, $45, $00, $4E, $41, $54, $41, $00, $50, $41
db $4E, $4E, $41, $00, $4C, $41, $47, $45, $52, $2F, $42, $45, $45, $52, $00, $50
db $49, $4C, $53, $00, $42, $49, $45, $52, $45, $20, $42, $4C, $4F, $4E, $44, $45
db $00, $43, $45, $52, $56, $45, $5A, $41, $20, $52, $55, $42, $49, $41, $00, $42
db $49, $52, $52, $41, $20, $43, $48, $49, $41, $52, $41, $00, $41, $4C, $43, $4F
db $48, $4F, $4C, $2D, $46, $52, $45, $45, $20, $4C, $41, $47, $45, $52, $00, $41
db $4C, $4B, $4F, $48, $4F, $4C, $46, $52, $45, $49, $45, $53, $20, $42, $49, $45
db $52, $00, $42, $49, $45, $52, $45, $20, $53, $41, $4E, $53, $20, $41, $4C, $43
db $4F, $4F, $4C, $00, $43, $45, $52, $56, $45, $5A, $41, $20, $53, $49, $4E, $20
db $41, $4C, $43, $4F, $48, $4F, $4C, $00, $42, $49, $52, $52, $41, $20, $41, $4E
db $41, $4C, $43, $4F, $4C, $49, $43, $41, $00, $42, $4F, $54, $54, $4C, $45, $00
db $46, $4C, $41, $53, $43, $48, $45, $00, $42, $4F, $55, $54, $45, $49, $4C, $4C
db $45, $00, $42, $4F, $54, $45, $4C, $4C, $41, $00, $42, $4F, $54, $54, $49, $47
db $4C, $49, $41, $00, $44, $45, $53, $53, $45, $52, $54, $20, $57, $49, $4E, $45
db $00, $4C, $49, $45, $42, $4C, $49, $43, $48, $45, $52, $20, $57, $45, $49, $4E
db $00, $56, $49, $4E, $20, $44, $4F, $55, $58, $00, $56, $49, $4E, $4F, $20, $44
db $55, $4C, $43, $45, $00, $56, $49, $4E, $4F, $20, $44, $4F, $4C, $43, $45, $00
db $57, $48, $49, $54, $45, $20, $57, $49, $4E, $45, $00, $57, $45, $49, $33, $57
db $45, $49, $4E, $00, $56, $49, $4E, $20, $42, $4C, $41, $4E, $43, $00, $56, $49
db $4E, $4F, $20, $42, $4C, $41, $4E, $43, $4F, $00, $56, $49, $4E, $4F, $20, $42
db $49, $41, $4E, $43, $4F, $00, $52, $45, $44, $20, $57, $49, $4E, $45, $00, $52
db $4F, $54, $57, $45, $49, $4E, $00, $56, $49, $4E, $20, $52, $4F, $55, $47, $45
db $00, $56, $49, $4E, $4F, $20, $54, $49, $4E, $54, $4F, $00, $56, $49, $4E, $4F
db $20, $52, $4F, $53, $53, $4F, $00, $52, $4F, $53, $45, $20, $57, $49, $4E, $45
db $00, $52, $4F, $53, $35, $00, $52, $4F, $53, $45, $00, $56, $49, $4E, $4F, $20
db $52, $4F, $53, $41, $44, $4F, $00, $56, $49, $4E, $4F, $20, $52, $4F, $53, $35
db $00, $43, $48, $49, $4C, $4C, $45, $44, $00, $47, $45, $4B, $37, $48, $4C, $54
db $00, $52, $45, $46, $52, $49, $47, $45, $52, $45, $00, $48, $45, $4C, $41, $44
db $4F, $00, $52, $41, $46, $46, $52, $45, $44, $44, $41, $54, $4F, $00, $53, $50
db $41, $52, $4B, $4C, $49, $4E, $47, $00, $4D, $4F, $55, $53, $53, $49, $45, $52
db $45, $4E, $44, $00, $4D, $4F, $55, $53, $53, $45, $55, $58, $00, $45, $53, $50
db $55, $4D, $4F, $53, $4F, $00, $46, $52, $49, $5A, $5A, $41, $4E, $54, $45, $00
db $01
ds 31, $00

SECTION "rom7", ROMX, BANK[$7]
; Data from 1C000 to 1CE91 (3730 bytes)
db $4E, $6F, $20, $64, $27, $61, $64, $72, $65, $73, $73, $65, $20, $20, $3A, $20
db $20, $20, $20, $20, $00, $4E, $6F, $20, $64, $65, $20, $72, $65, $75, $6E, $69
db $6F, $6E, $20, $3A, $00, $4E, $6F, $20, $64, $27, $61, $72, $74, $69, $63, $6C
db $65, $20, $20, $3A, $20, $20, $20, $20, $20, $00, $54, $72, $6F, $75, $76, $20
db $46, $61, $69, $74, $20, $45, $66, $66, $63, $20, $65, $44, $69, $74, $00, $53
db $75, $69, $76, $20, $50, $72, $65, $63, $65, $64, $20, $51, $75, $69, $74, $74
db $65, $72, $20, $00, $50, $52, $45, $53, $53, $45, $52, $20, $55, $4E, $45, $20
db $54, $4F, $55, $43, $48, $45, $00, $28, $63, $29, $20, $31, $39, $39, $32, $00
db $4D, $6F, $6E, $74, $61, $67, $75, $65, $2D, $57, $65, $73, $74, $6F, $6E, $2E
db $00, $53, $6F, $75, $73, $20, $6C, $69, $63, $65, $6E, $63, $65, $00, $65, $78
db $63, $6C, $75, $73, $69, $76, $65, $20, $61, $00, $20, $20, $46, $61, $62, $74
db $65, $6B, $2C, $20, $49, $6E, $63, $2E, $20, $20, $00, $56, $65, $72, $73, $69
db $6F, $6E, $20, $35, $2E, $37, $34, $00, $4F, $63, $74, $72, $6F, $79, $65, $65
db $20, $70, $61, $72, $00, $4E, $69, $6E, $74, $65, $6E, $64, $6F, $00, $45, $6E
db $74, $72, $20, $63, $68, $61, $69, $6E, $65, $20, $72, $65, $63, $68, $65, $72
db $63, $68, $45, $4E, $54, $52, $20, $43, $48, $41, $49, $4E, $45, $20, $52, $45
db $43, $48, $45, $52, $43, $48, $52, $45, $43, $48, $45, $52, $43, $48, $20, $4A
db $55, $53, $51, $55, $27, $41, $20, $46, $49, $4E, $20, $50, $52, $45, $53, $53
db $45, $52, $20, $55, $4E, $45, $20, $54, $4F, $55, $43, $48, $45, $20, $00, $20
db $4C, $61, $6E, $67, $75, $65, $20, $20, $72, $65, $63, $68, $65, $72, $63, $68
db $65, $65, $20, $52, $65, $63, $68, $65, $72, $63, $68, $20, $6A, $75, $73, $71
db $75, $27, $61, $20, $66, $69, $6E, $64, $6F, $6E, $6E, $65, $65, $73, $2E, $49
db $6E, $74, $72, $6F, $75, $76, $61, $62, $6C, $65, $00, $50, $72, $65, $73, $73
db $65, $72, $20, $75, $6E, $65, $20, $74, $6F, $75, $63, $68, $65, $00, $20, $20
db $53, $75, $69, $76, $61, $6E, $74, $20, $20, $20, $73, $4F, $72, $74, $69, $65
db $20, $20, $00, $53, $55, $49, $56, $41, $4E, $54, $20, $53, $4F, $52, $54, $49
db $45, $20, $20, $20, $4D, $49, $4E, $49, $54, $52, $41, $44, $55, $43, $54, $45
db $55, $52, $20, $20, $20, $20, $20, $20, $20, $54, $72, $6F, $75, $76, $65, $72
db $20, $20, $4D, $6F, $74, $20, $20, $20, $20, $20, $20, $20, $20, $56, $6F, $69
db $72, $20, $20, $54, $69, $74, $72, $65, $73
ds 11, $20
db $53, $6F, $72, $74, $69, $65
ds 9, $20
db $46, $4F, $4E, $43, $54, $49, $4F, $4E, $53, $20, $20, $4D, $4F, $4E, $44, $45
db $20, $20, $20, $20, $20, $4D, $69, $6E, $69, $74, $72, $61, $64, $75, $63, $74
db $65, $75, $72, $20, $20, $20, $20, $20, $20, $43, $61, $72, $74, $65, $20, $44
db $75, $20, $4D, $6F, $6E, $64, $65, $20, $20, $20, $20, $20, $20, $46, $4F, $4E
db $43, $54, $49, $4F, $4E, $53, $20, $44, $41, $54, $45
ds 9, $20
db $52, $65, $75, $6E, $69, $6F, $6E
ds 12, $20
db $43, $61, $6C, $65, $6E, $64, $72, $69, $65, $72, $20, $20, $20, $20, $20, $20
db $4F, $50, $54, $49, $4F, $4E, $53, $20, $20, $54, $45, $4C, $45, $50, $48, $4F
db $4E, $45, $20, $20, $20, $4E, $75, $6D, $65, $72, $6F, $20, $20, $61, $20, $65
db $64, $69, $74, $65, $72, $20, $20, $20, $20, $20, $50, $61, $76, $65, $20, $6E
db $75, $6D, $65, $72, $69, $71, $75, $65, $20, $20, $20, $20, $20, $20, $20, $20
db $43, $4F, $4E, $56, $45, $52, $53, $49, $4F, $4E
ds 9, $20
db $45, $6E, $20, $20, $4D, $65, $74, $72, $69, $71, $75, $65, $20, $20, $20, $20
db $20, $20, $44, $65, $70, $75, $69, $73, $20, $20, $6D, $65, $74, $72, $69, $71
db $75, $65, $20, $20, $20, $20, $4F, $50, $54, $49, $4F, $4E, $53, $20, $20, $44
db $4F, $4E, $4E, $45, $45, $53, $20, $20, $20, $20, $42, $61, $73, $65, $20, $20
db $64, $65, $20, $64, $6F, $6E, $6E, $65, $65, $73, $20, $20, $20, $43, $61, $72
db $6E, $65, $74, $20, $20, $64, $27, $61, $64, $72, $65, $73, $73, $65, $73, $20
db $44, $61, $74, $65, $20, $20, $20, $2F, $20, $20, $2F, $00, $48, $65, $75, $72
db $65, $20, $72, $65, $75, $6E, $69, $6F, $6E, $3F, $4F, $4E, $00, $48, $65, $75
db $72, $65, $20, $20, $3A, $00, $4D, $75, $73, $69, $63, $61, $6C, $3F, $4F, $4E
db $00, $50, $72, $65, $73, $73, $65, $72, $20, $31, $20, $32, $20, $33, $20, $6F
db $75, $20, $34, $00, $31, $20, $53, $6F, $6E, $6E, $65, $72, $69, $65, $00, $32
db $20, $41, $6E, $6E, $69, $76, $65, $72, $73, $61, $69, $72, $65, $00, $33, $20
db $4E, $6F, $65, $6C, $00, $34, $20, $50, $72, $69, $6F, $72, $69, $74, $65, $00
db $43, $6F, $6D, $70, $74, $65, $20, $61, $20, $72, $65, $62, $6F, $75, $72, $73
db $3F, $4F, $4E, $00, $4E, $62, $20, $64, $65, $20, $6A, $6F, $75, $72, $73, $3F
db $28, $31, $20, $61, $20, $37, $29, $00, $45, $66, $66, $61, $63, $65, $72, $20
db $72, $65, $75, $6E, $69, $6F, $6E, $3F, $4F, $4E, $00, $53, $75, $69, $76, $20
db $50, $72, $65, $63, $65, $64, $20, $73, $4F, $72, $74, $69, $72, $00, $4A, $61
db $6E, $76, $69, $65, $72, $00, $46, $65, $76, $72, $69, $65, $72, $00, $4D, $61
db $72, $73, $00, $41, $76, $72, $69, $6C, $00, $4D, $61, $69, $00, $4A, $75, $69
db $6E, $00, $4A, $75, $69, $6C, $6C, $65, $74, $00, $41, $6F, $75, $74, $00, $53
db $65, $70, $74, $65, $6D, $62, $72, $65, $00, $4F, $63, $74, $6F, $62, $72, $65
db $00, $4E, $6F, $76, $65, $6D, $62, $72, $65, $00, $44, $65, $63, $65, $6D, $62
db $72, $65, $00, $69, $65, $72, $20, $20, $50, $61, $73, $20, $63, $6F, $6D, $70
db $74, $65, $20, $61, $20, $72, $65, $62, $6F, $75, $72, $73, $00, $43, $6F, $6D
db $70, $74, $65, $20, $61, $20, $72, $65, $62, $6F, $75, $72, $73, $3A, $00, $31
db $20, $6A, $6F, $75, $72, $00, $6A, $6F, $75, $72, $73, $00, $50, $61, $73, $20
db $64, $65, $20, $73, $6F, $6E, $6E, $65, $72, $69, $65, $00, $53, $6F, $6E, $6E
db $65, $72, $69, $65, $00, $53, $6F, $6E, $6E, $65, $72, $69, $65, $20, $61, $6E
db $6E, $69, $76, $65, $72, $73, $61, $69, $72, $65, $00, $53, $6F, $6E, $6E, $65
db $72, $69, $65, $20, $64, $65, $20, $4E, $6F, $65, $6C, $00, $53, $6F, $6E, $6E
db $65, $72, $69, $65, $20, $64, $65, $20, $70, $72, $69, $6F, $72, $69, $74, $65
db $00, $20, $20, $45, $52, $52, $45, $55, $52, $20, $20, $20, $20, $20, $20, $20
db $41, $75, $74, $6F, $6D, $6F, $62, $69, $6C, $65
ds 9, $20
db $42, $61, $6E, $71, $75, $65, $2F, $46, $69, $6E, $61, $6E, $63, $65, $20, $20
db $20, $20, $20, $20, $20, $42, $65, $61, $75, $74, $65, $2F, $53, $61, $6E, $74
db $65, $20, $20, $20, $20, $20, $20, $20, $43, $6F, $6D, $6D, $75, $6E, $69, $63
db $61, $74, $69, $6F, $6E
ds 9, $20
db $44, $61, $74, $65, $73, $2F, $54, $65, $6D, $70, $73
ds 9, $20
db $53, $70, $65, $63, $74, $61, $63, $6C, $65, $20, $20, $20, $20, $20, $20, $20
db $20, $47, $65, $6E, $65, $72, $61, $6C, $2F, $53, $6F, $75, $68, $61, $69, $74
db $73, $20, $20, $20, $20, $20, $20, $20, $20, $48, $6F, $74, $65, $6C
ds 12, $20
db $4D, $65, $64, $69, $63, $61, $6C, $2F, $55, $72, $67, $65, $6E, $63, $65, $20
db $20, $20, $20, $20, $20, $20, $52, $65, $73, $74, $61, $75, $72, $61, $6E, $74
db $20, $20, $20, $20, $20, $20, $20, $43, $6F, $75, $72, $73, $65, $73, $2F, $50
db $65, $72, $73, $6F, $6E, $6E, $65, $6C, $20, $20, $20, $20, $20, $20, $41, $20
db $76, $69, $73, $69, $74, $65, $72
ds 12, $20
db $53, $70, $6F, $72, $74
ds 16, $20
db $56, $6F, $79, $61, $67, $65, $20, $20, $20, $20, $20, $20, $20, $53, $55, $49
db $56, $20, $20, $50, $52, $45, $43, $45, $44, $20, $20, $43, $48, $4F, $49, $53
db $49, $00, $56, $6F, $69, $72, $20, $68, $6F, $72, $6C, $6F, $67, $65, $00, $52
db $65, $67, $6C, $65, $72, $20, $68, $65, $75, $72, $65, $00, $52, $65, $67, $6C
db $65, $72, $20, $73, $6F, $6E, $6E, $65, $72, $69, $65, $00, $45, $66, $66, $61
db $63, $65, $72, $20, $73, $6F, $6E, $6E, $65, $72, $69, $65, $00, $3A, $20, $20
db $3A, $00, $53, $6F, $6E, $6E, $65, $72, $69, $65, $3A, $00, $20, $20, $20, $20
db $20, $56, $6F, $69, $72, $20, $20, $64, $61, $74, $65
ds 9, $20
db $52, $65, $67, $6C, $65, $72, $20, $20, $64, $61, $74, $65, $20, $20, $20, $20
db $20, $20, $45, $4E, $54, $52, $45, $52, $20, $20, $51, $55, $41, $4E, $54, $49
db $54, $45, $20, $20, $50, $52, $45, $53, $53, $45, $52, $20, $55, $4E, $45, $20
db $54, $4F, $55, $43, $48, $45, $00, $50, $6F, $75, $63, $65, $73, $20, $65, $6E
db $20, $43, $6D, $00, $50, $69, $65, $64, $73, $20, $65, $6E, $20, $4D, $65, $74
db $72, $65, $73, $00, $59, $61, $72, $64, $73, $20, $65, $6E, $20, $4D, $65, $74
db $72, $65, $73, $00, $4D, $69, $6C, $65, $73, $20, $65, $6E, $20, $4B, $69, $6C
db $6F, $6D, $65, $74, $72, $65, $73, $00, $41, $63, $72, $65, $73, $20, $65, $6E
db $20, $48, $65, $63, $74, $61, $72, $65, $73, $00, $4F, $6E, $63, $65, $73, $20
db $66, $6C, $75, $69, $20, $65, $6E, $20, $4C, $69, $74, $72, $65, $73, $00, $51
db $75, $61, $72, $74, $73, $20, $65, $6E, $20, $4C, $69, $74, $72, $65, $73, $00
db $47, $61, $6C, $6C, $6F, $6E, $73, $20, $55, $53, $20, $65, $6E, $20, $4C, $69
db $74, $72, $65, $73, $00, $47, $61, $6C, $6C, $6F, $6E, $73, $20, $55, $4B, $20
db $65, $6E, $20, $4C, $69, $74, $72, $65, $73, $00, $4F, $6E, $63, $65, $73, $20
db $65, $6E, $20, $47, $72, $61, $6D, $6D, $65, $73, $00, $4C, $69, $76, $72, $65
db $73, $20, $65, $6E, $20, $4B, $27, $67, $72, $61, $6D, $6D, $65, $73, $00, $54
db $6F, $6E, $73, $20, $65, $6E, $20, $54, $6F, $6E, $6E, $65, $73, $00, $43, $6D
db $20, $65, $6E, $20, $50, $6F, $75, $63, $65, $73, $00, $4D, $65, $74, $72, $65
db $73, $20, $65, $6E, $20, $50, $69, $65, $64, $73, $00, $4D, $65, $74, $72, $65
db $73, $20, $65, $6E, $20, $59, $61, $72, $64, $73, $00, $4B, $69, $6C, $6F, $6D
db $65, $74, $72, $65, $73, $20, $65, $6E, $20, $4D, $69, $6C, $65, $73, $00, $48
db $65, $63, $74, $61, $72, $65, $73, $20, $65, $6E, $20, $41, $63, $72, $65, $73
db $00, $4C, $69, $74, $72, $65, $73, $20, $65, $6E, $20, $4F, $6E, $63, $65, $73
db $20, $66, $6C, $75, $69, $00, $4C, $69, $74, $72, $65, $73, $20, $65, $6E, $20
db $51, $75, $61, $72, $74, $73, $00, $4C, $69, $74, $72, $65, $73, $20, $65, $6E
db $20, $47, $61, $6C, $6C, $6F, $6E, $73, $20, $55, $53, $00, $4C, $69, $74, $72
db $65, $73, $20, $65, $6E, $20, $47, $61, $6C, $6C, $6F, $6E, $73, $20, $55, $4B
db $00, $47, $72, $61, $6D, $6D, $65, $73, $20, $65, $6E, $20, $4F, $6E, $63, $65
db $73, $00, $4B, $27, $67, $72, $61, $6D, $6D, $65, $73, $20, $65, $6E, $20, $4C
db $69, $76, $72, $65, $73, $00, $54, $6F, $6E, $6E, $65, $73, $20, $65, $6E, $20
db $54, $6F, $6E, $73, $00, $43, $6F, $72, $72, $65, $73, $70, $6F, $6E, $64, $2E
db $20, $69, $6E, $74, $72, $6F, $75, $76, $20, $00, $54, $6F, $75, $63, $68, $65
db $20, $70, $6F, $75, $72, $20, $63, $6F, $6E, $74, $2E, $00, $84, $98, $44, $65
db $75, $74, $73, $63, $68, $6D, $61, $72, $6B, $73, $00, $C6, $98, $44, $6F, $6C
db $6C, $61, $72, $73, $00, $07, $99, $46, $72, $61, $6E, $63, $73, $00, $48, $99
db $4C, $69, $72, $65, $73, $00, $86, $99, $50, $65, $73, $65, $74, $61, $73, $00
db $C2, $99, $4C, $69, $76, $72, $65, $73, $20, $53, $74, $65, $72, $6C, $69, $6E
db $67, $00, $08, $9A, $59, $65, $6E, $00, $0E, $20, $20, $20, $20, $44, $65, $75
db $74, $73, $63, $68, $6D, $61, $72, $6B, $73, $20, $20, $20, $20, $09, $20, $20
db $20, $20, $20, $20, $44, $6F, $6C, $6C, $61, $72, $73, $20, $20, $20, $20, $20
db $20, $20, $08, $20, $20, $20, $20, $20, $20, $20, $46, $72, $61, $6E, $63, $73
db $20, $20, $20, $20, $20, $20, $20, $07, $20, $20, $20, $20, $20, $20, $20, $20
db $4C, $69, $72, $65, $73, $20, $20, $20, $20, $20, $20, $20, $09, $20, $20, $20
db $20, $20, $20, $50, $65, $73, $65, $74, $61, $73, $20, $20, $20, $20, $20, $20
db $20, $11, $20, $20, $4C, $69, $76, $72, $65, $73, $20, $53, $74, $65, $72, $6C
db $69, $6E, $67, $20, $20, $20, $05, $20, $20, $20, $20, $20, $20, $20, $20, $59
db $65, $6E
ds 9, $20
db $04, $44, $65, $75, $74, $73, $63, $68, $6D, $61, $72, $6B, $73, $00, $06, $44
db $6F, $6C, $6C, $61, $72, $73, $00, $07, $46, $72, $61, $6E, $63, $73, $00, $07
db $4C, $69, $72, $65, $73, $00, $06, $50, $65, $73, $65, $74, $61, $73, $00, $03
db $4C, $69, $76, $72, $65, $73, $20, $53, $74, $65, $72, $6C, $69, $6E, $67, $00
db $08, $59, $65, $6E, $00, $43, $4F, $4E, $56, $45, $52, $54, $49, $52, $20, $44
db $45, $00, $43, $4F, $4E, $56, $45, $52, $54, $49, $52, $20, $45, $4E, $00, $20
db $20, $45, $4E, $54, $52, $45, $52, $20, $20, $51, $55, $41, $4E, $54, $49, $54
db $45, $20, $20, $20, $20, $20, $20, $45, $4E, $54, $52, $45, $52, $20, $20, $54
db $41, $55, $58, $20, $20, $20, $20, $20, $51, $55, $41, $4E, $54, $49, $54, $45
db $20, $44, $4F, $4E, $4E, $45, $45, $20, $45, $4E, $20, $20, $20, $4D, $45, $4E
db $55, $20, $44, $45, $20, $43, $4F, $4E, $54, $52, $4F, $4C, $45, $20, $20, $20
db $45, $46, $46, $43, $2E, $20, $54, $4F, $55, $53, $20, $41, $52, $54, $49, $43
db $4C, $45, $20, $20, $20, $20, $52, $45, $47, $4C, $45, $52, $20, $20, $41, $20
db $5A, $45, $52, $4F, $20, $20, $20, $50, $52, $45, $53, $53, $45, $52, $20, $4F
db $3D, $43, $4F, $4E, $46, $49, $52, $4D, $45, $52, $20, $00, $41, $55, $54, $52
db $20, $54, $4F, $55, $43, $48, $45, $3D, $41, $42, $41, $4E, $44, $4F, $4E, $20
db $00, $20, $20, $20, $20, $44, $4F, $4E, $4E, $45, $52, $20, $53, $4F, $4C, $44
db $45, $20, $20, $20, $20, $20, $20, $20, $20, $53, $4F, $4C, $44, $45, $20, $41
db $43, $54, $55, $45, $4C, $20, $20, $20, $20, $20, $20, $20, $56, $4F, $49, $52
db $20, $20, $41, $52, $54, $49, $43, $4C, $45, $53, $20, $20, $20, $20, $20, $20
db $45, $4E, $54, $52, $45, $52, $20, $41, $52, $54, $49, $43, $4C, $45, $20, $20
db $20, $50, $41, $53, $20, $20, $44, $27, $41, $52, $54, $49, $43, $4C, $45, $00
ds 14, $20
db $00, $56, $4F, $49, $52, $20, $20, $41, $52, $54, $49, $43, $4C, $45, $53, $00
db $20, $20, $20, $20, $45, $4E, $54, $52, $45, $52, $20, $20, $44, $41, $54, $45
db $20, $20, $20, $20, $00, $2F, $20, $20, $2F, $00, $20, $45, $4E, $54, $52, $45
db $52, $20, $4C, $41, $20, $53, $4F, $4D, $4D, $45, $20, $20, $00, $20, $43, $52
db $45, $44, $49, $54, $20, $4F, $55, $20, $20, $44, $45, $42, $49, $54, $20, $00
db $20, $20, $20, $20, $20, $20, $20, $43, $52, $45, $44, $49, $54, $00, $20, $20
db $20, $20, $20, $20, $20, $44, $45, $42, $49, $54, $20, $20, $20, $20, $20, $20
db $20, $20, $44, $45, $42, $49, $54, $20, $00, $8C, $8C, $8C, $8C, $8C, $8C, $8C
db $8C, $00, $45, $4E, $54, $52, $45, $52, $20, $44, $45, $53, $43, $52, $49, $50
db $54, $49, $4F, $4E, $00, $53, $75, $69, $76, $8C, $50, $72, $65, $63, $65, $64
db $8C, $73, $4F, $72, $74, $69, $72, $00, $20, $20, $41, $72, $74, $69, $63, $6C
db $65, $20, $6E, $75, $6D, $65, $72, $20, $58, $58, $20, $20, $4E, $6F, $6D, $20
db $65, $74, $20, $61, $64, $72, $65, $73, $73, $65, $00, $4E, $6F, $20, $64, $65
db $20, $54, $65, $6C, $65, $70, $68, $6F, $6E, $65, $00, $45, $6E, $74, $72, $65
db $72, $20, $4E, $6F, $20, $61, $20, $63, $6F, $6D, $70, $6F, $73, $65, $72, $00
db $20, $20, $20, $20, $54, $61, $70, $65, $72, $20, $6E, $75, $6D, $65, $72, $6F
db $20, $20, $20, $20, $4E, $75, $6D, $65, $72, $6F, $20, $65, $73, $74, $20, $63
db $6F, $6D, $70, $6F, $73, $65, $00, $45, $43, $48, $41, $50, $50, $2E, $20, $56
db $45, $52, $53, $20, $20, $53, $4F, $52, $54, $49, $45, $50, $52, $45, $53, $53
db $45, $52, $20, $55, $4E, $45, $20, $54, $4F, $55, $43, $48, $45, $00, $41, $6E
db $67, $6C, $61, $69, $73, $00, $41, $6C, $6C, $65, $6D, $61, $6E, $64, $00, $46
db $72, $61, $6E, $63, $61, $69, $73, $00, $45, $73, $70, $61, $67, $6E, $6F, $6C
db $00, $49, $74, $61, $6C, $69, $65, $6E, $00, $20, $4A, $41, $4E, $56, $49, $45
db $52, $20, $1F, $20, $46, $45, $56, $52, $49, $45, $52, $20, $1C, $20, $20, $20
db $4D, $41, $52, $53, $20, $20, $1F, $20, $20, $41, $56, $52, $49, $4C, $20, $20
db $1E, $20, $20, $20, $4D, $41, $49, $20, $20, $20, $1F, $20, $20, $20, $4A, $55
db $49, $4E, $20, $20, $1E, $20, $4A, $55, $49, $4C, $4C, $45, $54, $20, $1F, $20
db $20, $20, $41, $4F, $55, $54, $20, $20, $1F, $53, $45, $50, $54, $45, $4D, $42
db $52, $45, $1E, $20, $4F, $43, $54, $4F, $42, $52, $45, $20, $1F, $20, $4E, $4F
db $56, $45, $4D, $42, $52, $45, $1E, $20, $44, $45, $43, $45, $4D, $42, $52, $45
db $1F, $44, $49, $4D, $4C, $55, $4E, $4D, $41, $52, $4D, $45, $52, $4A, $45, $55
db $56, $45, $4E, $53, $41, $4D, $44, $49, $4D, $20, $42, $3D, $53, $75, $69, $76
db $61, $6E, $74, $20, $41, $3D, $53, $6F, $72, $74, $69, $65, $20, $00, $20, $20
db $53, $65, $6C, $65, $63, $74, $3D, $50, $72, $65, $63, $65, $64, $65, $6E, $74
db $20, $20, $00, $46, $61, $69, $72, $65, $20, $45, $66, $66, $61, $63, $65, $72
db $20, $65, $44, $69, $74, $65, $72, $00, $41, $50, $50, $2E, $20, $53, $55, $52
db $20, $4F, $20, $50, $4F, $55, $52, $20, $43, $4F, $4E, $46, $00, $41, $55, $54
db $52, $45, $20, $54, $4F, $55, $43, $48, $45, $20, $41, $42, $41, $4E, $44, $4F
db $4E, $00, $2A, $56, $45, $52, $49, $46, $49, $20, $52, $45, $4E, $44, $45, $5A
db $2D, $56, $4F, $55, $53, $2A, $00, $20, $20, $43, $48, $4F, $49, $53, $49, $20
db $4C, $41, $20, $4C, $41, $4E, $47, $55, $45, $20, $20, $20, $4F, $50, $54, $49
db $4F, $4E, $53, $20, $44, $45, $20, $53, $45, $43, $4F, $55, $52, $53, $20, $20
db $20, $54, $52, $41, $4E, $53, $46, $45, $52, $54, $20, $41, $20, $4C, $27, $4F
db $50, $20, $20, $20, $54, $52, $41, $4E, $53, $46, $45, $52, $54, $20, $20, $44
db $45, $20, $4C, $27, $4F, $50, $20, $20, $20, $4D, $45, $4E, $55, $20, $44, $45
db $20, $43, $4F, $4D, $4D, $41, $4E, $44, $45, $20, $20, $20, $43, $41, $52, $4E
db $45, $54, $20, $20, $44, $27, $41, $44, $52, $45, $53, $53, $45, $53, $20, $20
db $20, $20, $20, $52, $45, $4E, $44, $45, $5A, $2D, $56, $4F, $55, $53, $20, $20
db $20, $20, $20, $20, $54, $41, $42, $4C, $45, $20, $43, $41, $4C, $43, $55, $4C
db $41, $54, $52, $49, $43, $45, $20, $20, $20, $42, $41, $53, $45, $20, $20, $44
db $45, $20, $44, $4F, $4E, $4E, $45, $45, $53, $20, $20, $20, $52, $65, $63, $68
db $65, $72, $63, $68, $65, $20, $61, $20, $66, $69, $6E, $20, $64, $65, $20, $00
db $64, $6F, $6E, $20, $41, $70, $70, $20, $74, $6F, $75, $74, $65, $20, $74, $6F
db $75, $63, $68, $65, $00, $20, $4F, $50, $54, $49, $4F, $4E, $53, $20, $20, $52
db $45, $43, $48, $45, $52, $43, $48, $45, $20, $20, $52, $65, $63, $68, $65, $72
db $63, $68, $65, $20, $20, $47, $6C, $6F, $62, $61, $6C, $65, $20, $20, $52, $65
db $63, $68, $65, $72, $63, $68, $65, $20, $20, $53, $70, $65, $63, $69, $66, $69
db $20, $48, $65, $75, $72, $65, $2F, $44, $61, $74, $65, $20, $66, $61, $75, $73
db $73, $65, $00, $42, $61, $74, $74, $65, $72, $69, $65, $73, $20, $65, $6E, $20
db $62, $61, $69, $73, $73, $65, $3F, $00, $20, $20, $20, $20, $20, $20, $4D, $4F
db $4E, $4E, $41, $49, $45
ds 13, $20
db $43, $48, $45, $51, $55, $49, $45, $52, $20, $20, $20, $20, $20, $20, $01

; Data from 1CE92 to 1CE99 (8 bytes)
_DATA_1CE92_:
db $0F, $1F, $3F, $38, $38, $38, $38, $3F

; Data from 1CE9A to 1D251 (952 bytes)
_DATA_1CE9A_:
db $00, $0F, $10, $17, $17, $17, $17, $10, $F0, $F8, $F4, $14, $14, $14, $14, $F4
db $00, $F0, $08, $E8, $E8, $E8, $E8, $08, $3F, $3B, $33, $3F, $3F, $3E, $1F, $0F
db $1F, $1F, $1D, $1B, $1F, $1F, $0F, $00, $F4, $F4, $D4, $B4, $F4, $64, $C8, $F0
db $F8, $F8, $E8, $D8, $F8, $F8, $F0, $00, $1F, $2F, $2F, $2C, $2C, $2C, $2C, $2F
db $00, $1F, $18, $1B, $1B, $1B, $1B, $18, $80, $70, $E8, $68, $28, $28, $28, $E8
db $00, $80, $70, $90, $D0, $D0, $D0, $10, $2F, $2D, $29, $2F, $2F, $2F, $27, $1F
db $1F, $1F, $1E, $1D, $1F, $1F, $1F, $00, $E8, $E8, $A8, $E8, $68, $C8, $70, $80
db $F0, $F0, $D0, $B0, $F0, $F0, $80, $00, $0F, $13, $17, $16, $16, $16, $16, $17
db $00, $0F, $0C, $0D, $0D, $0D, $0D, $0C, $00, $C0, $E0, $D0, $50, $50, $50, $D0
db $00, $00, $C0, $20, $A0, $A0, $A0, $20, $17, $16, $14, $17, $17, $17, $12, $0F
db $0F, $0F, $0F, $0E, $0F, $0F, $0F, $00, $D0, $D0, $50, $D0, $50, $A0, $C0, $00
db $E0, $E0, $A0, $E0, $E0, $C0, $00, $00, $07, $09, $0B, $0F, $0F, $0F, $0F, $0F
db $00, $07, $06, $06, $06, $06, $06, $06, $00, $80, $C0, $A0, $A0, $A0, $A0, $A0
db $00, $00, $80, $40, $40, $40, $40, $40, $0F, $0F, $0E, $0F, $0F, $0B, $08, $07
db $07, $07, $07, $07, $07, $07, $07, $00, $A0, $A0, $A0, $20, $A0, $40, $80, $00
db $C0, $C0, $40, $C0, $C0, $80, $00, $00, $01, $03, $05, $05, $05, $05, $05, $05
db $00, $01, $03, $03, $03, $03, $03, $03, $80, $C0, $40, $40, $40, $40, $40, $40
db $00, $80, $80, $80, $80, $80, $80, $80, $40, $40, $40, $40, $40, $40, $40, $80
db $80, $80, $80, $80, $80, $80, $80, $00, $01, $03, $07, $0B, $0F, $0E, $0F, $0C
db $00, $01, $02, $04, $05, $07, $07, $07, $C0, $20, $20, $A0, $A0, $A0, $A0, $A0
db $00, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $0F, $0F, $0F, $0F, $0B, $05, $02, $01
db $07, $04, $04, $04, $04, $02, $01, $00, $01, $06, $0B, $17, $1E, $1E, $1F, $1C
db $00, $01, $07, $0A, $09, $0F, $0F, $0F, $E0, $90, $D0, $D0, $D0, $D0, $D0, $D0
db $00, $E0, $60, $60, $E0, $E0, $E0, $E0, $1F, $1F, $1F, $1E, $15, $0A, $07, $01
db $0F, $08, $0B, $0B, $0B, $07, $01, $00, $D0, $D0, $D0, $D0, $D0, $D0, $10, $E0
db $E0, $60, $60, $60, $60, $60, $E0, $00, $03, $1C, $27, $2D, $3F, $3E, $3F, $38
db $00, $03, $1F, $16, $11, $1F, $1F, $1F, $F0, $C8, $E8, $E8, $E8, $68, $E8, $68
db $00, $F0, $B0, $30, $F0, $F0, $F0, $F0, $3F, $3F, $3F, $3E, $3D, $26, $1C, $03
db $1F, $10, $17, $17, $17, $1F, $03, $00, $E8, $E8, $E8, $E8, $E8, $E8, $88, $F0
db $F0, $30, $B0, $B0, $B0, $B0, $F0, $00, $0F, $1F, $3F, $3F, $3F, $38, $3F, $38
db $00, $0F, $17, $10, $1F, $1F, $1F, $1F, $F0, $F8, $F4, $F4, $F4, $14, $F4, $14
db $00, $F0, $E8, $08, $F8, $F8, $F8, $F8, $3F, $3F, $3F, $3C, $3F, $2C, $17, $0F
db $1F, $10, $17, $17, $17, $17, $0F, $00, $F4, $F4, $F4, $34, $F4, $34, $E8, $F0
db $F8, $08, $E8, $E8, $E8, $E8, $F0, $00, $1F, $26, $2F, $2F, $2F, $2C, $2F, $2C
db $00, $1F, $1B, $18, $1F, $1F, $1F, $1F, $80, $70, $C8, $68, $F8, $F8, $F8, $38
db $00, $80, $F0, $D0, $10, $F0, $F0, $F0, $2F, $2F, $2F, $2E, $2F, $2E, $22, $1F
db $1F, $18, $1B, $1B, $1B, $1B, $1F, $00, $F8, $F8, $F8, $F8, $78, $C8, $70, $80
db $F0, $10, $D0, $D0, $D0, $F0, $80, $00, $0F, $12, $17, $17, $16, $16, $17, $16
db $00, $0F, $0D, $0C, $0F, $0F, $0F, $0F, $00, $C0, $A0, $D0, $F0, $F0, $F0, $70
db $00, $00, $C0, $A0, $20, $E0, $E0, $E0, $17, $17, $17, $16, $17, $16, $11, $0F
db $0F, $0C, $0D, $0D, $0D, $0D, $0F, $00, $F0, $F0, $F0, $F0, $50, $A0, $C0, $00
db $E0, $20, $A0, $A0, $A0, $C0, $00, $00, $07, $09, $09, $0B, $0B, $0A, $0B, $0A
db $00, $07, $06, $06, $07, $07, $07, $07, $00, $80, $C0, $A0, $E0, $E0, $E0, $60
db $00, $00, $80, $40, $40, $C0, $C0, $C0, $0B, $0B, $0B, $0B, $0B, $09, $08, $07
db $07, $06, $06, $06, $06, $06, $07, $00, $E0, $E0, $E0, $E0, $A0, $40, $80, $00
db $C0, $40, $40, $40, $40, $80, $00, $00, $03, $07, $05, $05, $05, $05, $05, $05
db $00, $03, $03, $03, $03, $03, $03, $03, $00, $80, $40, $40, $40, $40, $40, $40
db $00, $00, $80, $80, $80, $80, $80, $80, $05, $05, $05, $05, $05, $05, $05, $03
db $03, $03, $03, $03, $03, $03, $03, $00, $01, $03, $07, $0B, $0F, $0F, $0F, $0F
db $00, $01, $02, $04, $04, $04, $04, $04, $C0, $20, $A0, $E0, $E0, $E0, $E0, $E0
db $00, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $0F, $0F, $0E, $0D, $0B, $05, $02, $01
db $07, $07, $05, $07, $07, $03, $01, $00, $01, $07, $0F, $16, $1C, $1C, $1C, $1F
db $00, $01, $06, $09, $0B, $0B, $0B, $08, $E0, $90, $D0, $D0, $D0, $D0, $D0, $D0
db $00, $E0, $60, $60, $60, $60, $60, $60, $1F, $1D, $18, $1F, $15, $0B, $06, $01
db $0F, $0F, $0F, $0D, $0F, $07, $01, $00, $D0, $D0, $D0, $D0, $D0, $D0, $90, $E0
db $E0, $E0, $60, $E0, $E0, $E0, $E0, $00, $03, $1D, $2F, $3C, $38, $38, $38, $3F
db $00, $03, $1C, $13, $17, $17, $17, $10, $F0, $E8, $E8, $68, $68, $68, $68, $E8
db $00, $F0, $30, $B0, $B0, $B0, $B0, $30, $3F, $3B, $33, $3F, $3E, $27, $1D, $03
db $1F, $1F, $1D, $1B, $1F, $1F, $03, $00, $E8, $E8, $68, $E8, $E8, $E8, $C8, $F0
db $F0, $F0, $B0, $70, $F0, $F0, $F0, $00

; Data from 1D252 to 1DC61 (2576 bytes)
_DATA_1D252_:
ds 16, $FF
db $E7, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $E7, $E7, $F3, $FF
db $99, $99, $88, $99, $CC
ds 11, $FF
db $93, $93, $01, $01, $80, $93, $81, $93, $81, $93, $01, $01, $80, $93, $C9, $FF
db $EF, $EF, $C3, $C3, $81, $9F, $C7, $C7, $E3, $F3, $81, $87, $C3, $EF, $F7, $FF
db $FF, $FF, $39, $39, $10, $33, $81, $E7, $C3, $CF, $81, $99, $08, $39, $9C, $FF
db $C7, $C7, $83, $93, $C1, $C7, $83, $8F, $01, $21, $10, $33, $89, $89, $C4, $FF
db $E7, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $C3, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $E7, $E7, $F3, $FF
db $E7, $E7, $F3, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $E1, $E7, $F3, $FF
db $FF, $FF, $93, $93, $C1, $C7, $01, $01, $80, $C7, $83, $93, $C9, $FF, $FF, $FF
db $FF, $FF, $E7, $E7, $E3, $E7, $81, $81, $C0, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $81, $81
db $C0
ds 17, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $F9, $F9, $F0, $F3, $E1, $E7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $83, $83, $01, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $E7, $E7, $C3, $C7, $A3, $A7, $C3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $83, $83, $01, $39, $98, $F9, $80, $83, $01, $3F
db $1F, $3F, $01, $01, $80, $FF, $83, $83, $01, $39, $98, $F9, $E0, $E3, $F1, $F9
db $38, $39, $80, $83, $C1, $FF, $E3, $E3, $C1, $C3, $81, $93, $01, $33, $01, $01
db $80, $F3, $F1, $F3, $F9, $FF, $01, $01, $00, $3F, $1F, $3F, $03, $03, $81, $F9
db $38, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $1C, $3F, $03, $03, $01, $39
db $18, $39, $80, $83, $C1, $FF, $03, $03, $81, $F9, $F8, $F9, $F8, $F9, $F8, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $83, $83, $01, $39, $18, $39, $80, $83, $01, $39
db $18, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $18, $39, $80, $81, $C0, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $E7, $E7
db $E3, $E7, $C3, $CF, $E7, $FF, $E7, $E7, $C3, $CF, $87, $9F, $0F, $3F, $9F, $9F
db $CF, $CF, $E7, $E7, $F3, $FF, $FF, $FF, $FF, $FF, $81, $81, $C0, $FF, $81, $81
db $C0, $FF, $FF, $FF, $FF, $FF, $CF, $CF, $E7, $E7, $F3, $F3, $F9, $F9, $F0, $F3
db $E1, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $99, $C8, $F9, $F0, $F3, $E1, $E7
db $F3, $FF, $E7, $E7, $F3, $FF, $83, $83, $01, $3D, $00, $21, $00, $2D, $02, $23
db $11, $3F, $81, $81, $C0, $FF, $C7, $C7, $83, $93, $09, $39, $00, $01, $00, $39
db $18, $39, $10, $11, $88, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $00, $03, $81, $FF, $C3, $C3, $81, $99, $0C, $3F, $1F, $3F, $1F, $3F
db $99, $99, $C0, $C3, $E1, $FF, $07, $07, $83, $93, $89, $99, $88, $99, $88, $99
db $80, $93, $01, $07, $83, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $89, $9D, $00, $01, $80, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $8B, $9F, $0F, $0F, $87, $FF, $C3, $C3, $81, $99, $0C, $3F, $11, $31, $18, $39
db $98, $99, $C0, $C3, $E1, $FF, $39, $39, $18, $39, $18, $39, $00, $01, $00, $39
db $18, $39, $18, $39, $9C, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $83, $8F, $C7, $FF, $19, $19, $88, $99, $80, $93, $81, $87, $83, $93
db $89, $99, $08, $19, $8C, $FF, $1F, $1F, $8F, $9F, $8F, $9F, $8F, $9F, $8F, $9F
db $89, $99, $00, $01, $80, $FF, $39, $39, $10, $11, $08, $29, $10, $39, $18, $39
db $18, $39, $18, $39, $9C, $FF, $31, $31, $18, $19, $08, $29, $10, $31, $18, $39
db $18, $39, $18, $19, $8C, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $18, $39
db $90, $93, $C1, $C7, $E3, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F
db $8F, $9F, $0F, $0F, $87, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $1C, $3D
db $92, $93, $C9, $C9, $E4, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $08, $19, $8C, $FF, $83, $83, $01, $39, $1C, $3F, $83, $83, $C1, $F9
db $38, $39, $80, $83, $C1, $FF, $81, $81, $80, $A5, $C2, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $C3, $C3, $E1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $90, $93
db $C1, $C7, $E3, $EF, $F7, $FF, $39, $39, $18, $39, $18, $39, $18, $39, $08, $29
db $10, $11, $08, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $83, $93
db $09, $39, $18, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $81, $81, $00, $39, $90, $F3, $E1, $E7, $C3, $CF
db $81, $99, $00, $03, $81, $FF, $C3, $C3, $C1, $CF, $C7, $CF, $C7, $CF, $C7, $CF
db $C7, $CF, $C3, $C3, $E1, $FF, $FF, $FF, $3F, $3F, $9F, $9F, $CF, $CF, $E7, $E7
db $F3, $F3, $F9, $F9, $FC, $FF, $C3, $C3, $E1, $F3, $F1, $F3, $F1, $F3, $F1, $F3
db $F1, $F3, $C1, $C3, $E1, $FF, $E7, $E7, $C3, $C3, $81, $81, $80, $A5, $C2, $E7
db $E3, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $CF, $CF, $87, $9F, $01, $01, $00, $01
db $80, $9F, $CF, $CF, $E7, $FF, $E7, $E7, $E3, $E7, $F3, $F3, $F9
ds 13, $FF
db $87, $87, $C3, $F3, $81, $83, $01, $33, $81, $81, $C0, $FF, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $00, $03, $81, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $8C, $9F, $89, $99, $C0, $C3, $E1, $FF, $F1, $F1, $F0, $F3
db $81, $83, $01, $33, $11, $33, $11, $33, $81, $81, $C0, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $80, $83, $81, $9F, $C3, $C3, $E1, $FF, $E3, $E3, $C1, $CF
db $87, $87, $C3, $CF, $C7, $CF, $C7, $CF, $87, $87, $C3, $FF, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $01, $07, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $CF, $1F, $1F, $8F, $9F
db $89, $99, $80, $93, $81, $87, $83, $93, $09, $19, $8C, $FF, $C7, $C7, $E3, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $13, $13, $01, $01, $00, $29, $10, $39, $18, $39, $9C, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $88, $99, $88, $99, $C0, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F, $0F, $0F, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $E1, $E1, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $8C, $9F, $8F, $9F, $0F, $0F, $87, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $80, $9F, $C3, $C3, $E1, $F9, $80, $83, $C1, $FF, $E7, $E7, $E3, $E7
db $C3, $C3, $E1, $E7, $E3, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $88, $99, $C0, $C1, $E0, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $C8, $DB, $E5, $E7, $F3, $FF, $FF, $FF, $FF, $FF
db $11, $11, $08, $39, $08, $29, $00, $01, $00, $13, $89, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $C3, $81, $99, $CC, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $CF, $87, $9F, $CF, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $A0, $B3, $C1, $E7, $C1, $CD, $82, $83, $C1, $FF, $F3, $F3, $E1, $E7
db $E3, $E7, $C3, $CF, $E7, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $E7, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $CF, $CF, $E7, $E7
db $E3, $E7, $F3, $F3, $E1, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $9D
db $8E, $9F, $07, $07, $83, $9F, $8F, $9F, $01, $01, $80, $FF, $C0, $C0, $80, $BF
db $00, $7F, $00, $60, $0F, $6F, $0F, $6F, $0F, $6F, $0F, $6F, $00, $00, $00, $FF
db $00, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $03, $03, $01, $FD
db $00, $FE, $00, $06, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $0F, $6F, $0F, $6F
db $0F, $6F, $0F, $6F, $0F, $6F, $0F, $6F, $0F, $6F, $0F, $6F, $30, $F6, $30, $F6
db $30, $F6, $30, $F6, $30, $F6, $30, $F6, $30, $F6, $30, $F6, $0F, $6F, $0F, $6F
db $0F, $6F, $0F, $6F, $00, $60, $00, $7F, $80, $BF, $C0, $C0, $00, $FF, $00, $FF
db $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $70, $F6, $F0, $F6
db $F0, $F6, $F0, $F6, $00, $06, $00, $FE, $00, $FD, $00, $03, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $F0, $F6, $F0, $F6
db $F0, $F6, $F0, $F6, $00, $06, $00, $FE, $00, $FD, $00, $03, $F0, $F6, $F0, $F6
db $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $60, $FF, $F0, $FF
db $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF, $80, $7F, $10, $EF
db $DF, $FF, $BF, $FF, $F7, $FF, $FF, $FF, $FD, $FF, $FF, $FF, $70, $F6, $F0, $F6
db $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6
db $F0, $F6, $70, $F6, $30, $F6, $30, $F6, $30, $F6, $30, $F6, $E0, $FF, $F0, $FF
db $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $FF, $00, $00, $FF, $FF, $FF, $FF
db $FF, $FF, $C0, $C0, $BF, $BF, $40, $40, $40, $5F, $40, $5F, $FF, $FF, $FE, $FE
db $FE, $FE, $3E, $3E, $DF, $DF, $0F, $2F, $07, $AF, $03, $AF, $40, $5F, $40, $5F
db $40, $40, $7F, $7F, $6F, $7F, $47, $77, $6E, $6F, $7F, $7F, $03, $AF, $03, $AF
db $03, $2F, $C3, $EF, $C3, $EF, $03, $AF, $43, $6F, $C3, $EF, $79, $7F, $BF, $BF
db $C0, $C0, $E0, $FF, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $83, $EF, $03, $DF
db $03, $3F, $07, $FF, $0F
ds 13, $FF
db $FC, $FC, $FB, $FB, $F4, $F4, $F4, $F5, $F4, $F5, $FF, $FF, $FF, $FF, $FF, $FF
db $03, $03, $FD, $FD, $00, $02, $00, $FA, $00, $FA, $F0, $F6, $F0, $F6, $F0, $F6
db $F0, $F6, $F0, $F6, $F0, $F6, $70, $F6, $30, $F6, $F4, $F5, $F4, $F5, $F4, $F4
db $F7, $F7, $F6, $F7, $F4, $F7, $76, $76, $37, $77, $00, $FA, $00, $FA, $00, $02
db $FC, $FE, $FC, $FE, $70, $7A, $E4, $F6, $FC, $FE, $17, $77, $1B, $7B, $1C, $7C
db $1E, $7F, $1F, $FF, $9F, $FF, $FF, $FF, $FF, $FF, $98, $FE, $F0, $FD, $00, $03
db $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $30, $F6, $30, $F6, $30, $F6
db $70, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $F0, $F6, $FF, $FF, $0F, $0F, $E7, $E7
db $63, $E7, $61, $67, $61, $67, $31, $77, $B1, $B3, $FF, $FF, $F8, $F8, $FB, $FB
db $FB, $FB, $FB, $FB, $FB, $FB, $F6, $F7, $F6, $F6, $FF, $FF, $3F, $3F, $9F, $9F
db $0F, $9F, $07, $1F, $07, $3F, $07, $3F, $00, $20
ds 14, $FF
db $C2, $C2, $FF, $FF, $F0, $F0, $F6, $F7, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
db $1B, $1B, $FF, $FF, $FE, $FE, $7E, $7E, $3F, $3F, $1F, $3F, $0F, $3F, $0F, $3F
db $01, $31, $FF, $FF, $1F, $1F, $CF, $EF, $67, $67, $63, $67, $61, $67, $61, $67
db $60, $60
ds 14, $FF
db $FC, $FC
ds 14, $FF
db $18, $18
ds 14, $FF
db $70, $70, $B1, $B3, $B0, $B2, $98, $BA, $D9, $D9, $D9, $D9, $DF, $DF, $CE, $DE
db $EE, $EE, $76, $76, $B6, $B6, $8C, $8E, $CC, $CC, $4C, $4C, $7C, $7C, $38, $3C
db $38, $38, $0E, $5F, $31, $31, $20, $60, $60, $66, $60, $66, $60, $66, $60, $66
db $20, $66, $5D, $5D, $AE, $AE, $8C
ds 9, $CC
db $8C, $CC, $CB, $EB, $33, $33, $13, $13, $03, $E3, $03, $F3, $3B, $FB, $3B, $FB
db $3B, $FB, $0C, $2C, $18, $18, $30, $31, $60, $63, $C0, $C7, $C0, $CF, $61, $6F
db $33, $37, $6E, $7F, $71, $71, $60, $60, $60, $66, $60, $66, $60, $66, $60, $66
db $60, $66, $79, $7B, $B6, $B6, $84
ds 9, $CC
db $84, $CC, $CB, $EB, $35, $35, $11, $19, $19, $D9, $19, $D9, $19, $D9, $19, $D9
db $10, $D9, $B7, $B7, $9B, $9B, $8B, $9B, $83, $9B, $83, $9B, $83, $9B, $83, $9B
db $83, $9B, $7F, $7F, $3F, $3F, $1F, $3F, $0F, $3F, $0F, $3F, $00, $20, $0F, $2F
db $06, $36
ds 10, $FF
db $1C, $1C, $6A, $6A, $76, $76, $EC, $EC, $EC, $EC, $E0, $E0, $F0, $F0, $F8, $FF
db $FC, $FF, $FF, $FF, $FF, $FF, $18, $59, $18, $D9, $00, $C1, $20, $E1, $30, $FF
db $38, $FF, $FF, $FF, $FF, $FF, $31, $B1, $0E, $DF, $60, $E0, $70, $F0, $78, $FF
db $7C, $FF, $FF, $FF, $FF, $FF, $8C, $8C, $1E, $1E, $00, $00, $00, $60, $00, $FF
db $18, $FF, $FF, $FF, $FF, $FF, $3B, $FB, $36, $F7, $30, $70, $38, $78, $1C, $FF
db $1E, $FF, $FF, $FF, $FF, $FF, $1B, $1B, $0C, $2C, $00, $30, $08, $78, $0C, $FF
db $1E, $FF, $FF, $FF, $FF, $FF, $71, $71, $8E, $DF, $00, $00, $00, $10, $00, $FF
db $04, $FF, $FF, $FF, $FF, $FF, $86, $86, $01, $1B, $00, $3C, $06, $7E, $0F, $FF
db $1F, $FF, $FF, $FF, $FF, $FF, $30, $30, $C0, $E3, $00, $07, $00, $0C, $01, $FD
db $80, $FD, $FE, $FE, $FF, $FF, $C7, $C7, $3B, $7F, $03, $83, $43, $43, $A3, $BB
db $92, $9B, $C6, $C6, $38, $7C, $06, $36, $06, $36, $00, $30, $08, $38, $0C, $3F
db $0E, $3F, $0F, $3F, $0F, $7F, $6A, $6A, $62, $62, $00, $00, $00, $0E, $00, $FF
db $03, $FF, $FF, $FF, $FF, $FF, $80, $80, $C0, $C1, $E0, $FF, $F0, $FF, $00, $00
db $00, $FF, $00, $FF, $00, $00, $0F, $FF, $1F, $FF, $3F, $FF, $7F, $FF, $00, $00
db $00, $FF, $00, $FF, $00, $00

; Data from 1DC62 to 1DDC9 (360 bytes)
_DATA_1DC62_:
db $5F
ds 18, $60
db $61, $62, $5F
ds 16, $60
db $61, $6D, $62, $62, $6F, $70, $7D, $7E, $7F, $80, $81, $82, $83, $84, $85, $86
db $00, $00, $75, $76, $77, $63, $62, $62, $71, $72, $87, $88, $89, $8A, $8B, $8C
db $8D, $8E, $8F, $90, $91, $92, $78, $79, $63, $63, $62, $62, $73, $74, $93, $94
db $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $7A, $7B, $7C, $63, $62, $64
ds 11, $67
db $9F, $A0, $67, $67, $67, $68, $63, $62, $6A
ds 17, $6B
db $6C, $62, $5F
ds 16, $60
db $61, $6D, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $62
ds 16, $00
db $69, $63, $62, $64
ds 16, $67
db $68, $63, $64, $6E
ds 17, $65
db $66

; Data from 1DDCA to 1ED69 (4000 bytes)
_DATA_1DDCA_:
ds 16, $FF
db $E7, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $E7, $E7, $F3, $FF
db $99, $99, $88, $99, $CC
ds 11, $FF
db $93, $93, $01, $01, $80, $93, $81, $93, $81, $93, $01, $01, $80, $93, $C9, $FF
db $EF, $EF, $C3, $C3, $81, $9F, $C7, $C7, $E3, $F3, $81, $87, $C3, $EF, $F7, $FF
db $FF, $FF, $39, $39, $10, $33, $81, $E7, $C3, $CF, $81, $99, $08, $39, $9C, $FF
db $C7, $C7, $83, $93, $C1, $C7, $83, $8F, $01, $21, $10, $33, $89, $89, $C4, $FF
db $E7, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $C3, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $E7, $E7, $F3, $FF
db $E7, $E7, $F3, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $E1, $E7, $F3, $FF
db $FF, $FF, $93, $93, $C1, $C7, $01, $01, $80, $C7, $83, $93, $C9, $FF, $FF, $FF
db $FF, $FF, $E7, $E7, $E3, $E7, $81, $81, $C0, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $81, $81
db $C0
ds 17, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $F9, $F9, $F0, $F3, $E1, $E7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $83, $83, $01, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $E7, $E7, $C3, $C7, $A3, $A7, $C3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $83, $83, $01, $39, $98, $F9, $80, $83, $01, $3F
db $1F, $3F, $01, $01, $80, $FF, $83, $83, $01, $39, $98, $F9, $E0, $E3, $F1, $F9
db $38, $39, $80, $83, $C1, $FF, $E3, $E3, $C1, $C3, $81, $93, $01, $33, $01, $01
db $80, $F3, $F1, $F3, $F9, $FF, $01, $01, $00, $3F, $1F, $3F, $03, $03, $81, $F9
db $38, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $1C, $3F, $03, $03, $01, $39
db $18, $39, $80, $83, $C1, $FF, $03, $03, $81, $F9, $F8, $F9, $F8, $F9, $F8, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $83, $83, $01, $39, $18, $39, $80, $83, $01, $39
db $18, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $18, $39, $80, $81, $C0, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $E7, $E7
db $E3, $E7, $C3, $CF, $E7, $FF, $E7, $E7, $C3, $CF, $87, $9F, $0F, $3F, $9F, $9F
db $CF, $CF, $E7, $E7, $F3, $FF, $FF, $FF, $FF, $FF, $81, $81, $C0, $FF, $81, $81
db $C0, $FF, $FF, $FF, $FF, $FF, $CF, $CF, $E7, $E7, $F3, $F3, $F9, $F9, $F0, $F3
db $E1, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $99, $C8, $F9, $F0, $F3, $E1, $E7
db $F3, $FF, $E7, $E7, $F3, $FF, $83, $83, $01, $3D, $00, $21, $00, $2D, $02, $23
db $11, $3F, $81, $81, $C0, $FF, $C7, $C7, $83, $93, $09, $39, $00, $01, $00, $39
db $18, $39, $10, $11, $88, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $00, $03, $81, $FF, $C3, $C3, $81, $99, $0C, $3F, $1F, $3F, $1F, $3F
db $99, $99, $C0, $C3, $E1, $FF, $07, $07, $83, $93, $89, $99, $88, $99, $88, $99
db $80, $93, $01, $07, $83, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $89, $9D, $00, $01, $80, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $8B, $9F, $0F, $0F, $87, $FF, $C3, $C3, $81, $99, $0C, $3F, $11, $31, $18, $39
db $98, $99, $C0, $C3, $E1, $FF, $39, $39, $18, $39, $18, $39, $00, $01, $00, $39
db $18, $39, $18, $39, $9C, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $83, $8F, $C7, $FF, $19, $19, $88, $99, $80, $93, $81, $87, $83, $93
db $89, $99, $08, $19, $8C, $FF, $1F, $1F, $8F, $9F, $8F, $9F, $8F, $9F, $8F, $9F
db $89, $99, $00, $01, $80, $FF, $39, $39, $10, $11, $08, $29, $10, $39, $18, $39
db $18, $39, $18, $39, $9C, $FF, $31, $31, $18, $19, $08, $29, $10, $31, $18, $39
db $18, $39, $18, $19, $8C, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $18, $39
db $90, $93, $C1, $C7, $E3, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F
db $8F, $9F, $0F, $0F, $87, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $1C, $3D
db $92, $93, $C9, $C9, $E4, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $08, $19, $8C, $FF, $83, $83, $01, $39, $1C, $3F, $83, $83, $C1, $F9
db $38, $39, $80, $83, $C1, $FF, $81, $81, $80, $A5, $C2, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $C3, $C3, $E1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $90, $93
db $C1, $C7, $E3, $EF, $F7, $FF, $39, $39, $18, $39, $18, $39, $18, $39, $08, $29
db $10, $11, $08, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $83, $93
db $09, $39, $18, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $81, $81, $00, $39, $90, $F3, $E1, $E7, $C3, $CF
db $81, $99, $00, $03, $81, $FF, $C3, $C3, $C1, $CF, $C7, $CF, $C7, $CF, $C7, $CF
db $C7, $CF, $C3, $C3, $E1, $FF, $FF, $FF, $3F, $3F, $9F, $9F, $CF, $CF, $E7, $E7
db $F3, $F3, $F9, $F9, $FC, $FF, $C3, $C3, $E1, $F3, $F1, $F3, $F1, $F3, $F1, $F3
db $F1, $F3, $C1, $C3, $E1, $FF, $E7, $E7, $C3, $C3, $81, $81, $80, $A5, $C2, $E7
db $E3, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $CF, $CF, $87, $9F, $01, $01, $00, $01
db $80, $9F, $CF, $CF, $E7, $FF, $E7, $E7, $E3, $E7, $F3, $F3, $F9
ds 13, $FF
db $87, $87, $C3, $F3, $81, $83, $01, $33, $81, $81, $C0, $FF, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $00, $03, $81, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $8C, $9F, $89, $99, $C0, $C3, $E1, $FF, $F1, $F1, $F0, $F3
db $81, $83, $01, $33, $11, $33, $11, $33, $81, $81, $C0, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $80, $83, $81, $9F, $C3, $C3, $E1, $FF, $E3, $E3, $C1, $CF
db $87, $87, $C3, $CF, $C7, $CF, $C7, $CF, $87, $87, $C3, $FF, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $01, $07, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $CF, $1F, $1F, $8F, $9F
db $89, $99, $80, $93, $81, $87, $83, $93, $09, $19, $8C, $FF, $C7, $C7, $E3, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $13, $13, $01, $01, $00, $29, $10, $39, $18, $39, $9C, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $88, $99, $88, $99, $C0, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F, $0F, $0F, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $E1, $E1, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $8C, $9F, $8F, $9F, $0F, $0F, $87, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $80, $9F, $C3, $C3, $E1, $F9, $80, $83, $C1, $FF, $E7, $E7, $E3, $E7
db $C3, $C3, $E1, $E7, $E3, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $88, $99, $C0, $C1, $E0, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $C8, $DB, $E5, $E7, $F3, $FF, $FF, $FF, $FF, $FF
db $11, $11, $08, $39, $08, $29, $00, $01, $00, $13, $89, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $C3, $81, $99, $CC, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $CF, $87, $9F, $CF, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $A0, $B3, $C1, $E7, $C1, $CD, $82, $83, $C1, $FF, $F3, $F3, $E1, $E7
db $E3, $E7, $C3, $CF, $E7, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $E7, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $CF, $CF, $E7, $E7
db $E3, $E7, $F3, $F3, $E1, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $9D
db $8E, $9F, $07, $07, $83, $9F, $8F, $9F, $01, $01, $80, $FF, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $93, $B3, $91, $B1, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $C6, $C6, $9C, $9C, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $38, $3A, $F8, $FA, $93, $B3, $93, $B3
db $90, $B0, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $CC, $CC, $E4, $E4
db $8E, $8E, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $F8, $FA, $F8, $FA
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $86, $A6, $82, $A2, $84, $A4, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $94, $94, $94, $94, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $E8, $EA, $48, $4A, $86, $A6, $86, $A6
db $86, $A6, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $94, $94, $94, $94
db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $A8, $AA, $E8, $EA
db $E8, $EA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $9F, $BF, $9E, $BE
db $9E, $BE, $9C, $BC, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $F8, $FA, $78, $7A
db $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $9F, $BF, $9C, $BC
db $9C, $BC, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $F8, $FA, $F8, $FA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9E, $BE, $9C, $BC, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $38, $3A, $F8, $FA, $9C, $BC, $9F, $BF
db $98, $B8, $9E, $BE, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $38, $3A
db $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $9E, $BE, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $38, $3A, $78, $7A, $9C, $BC, $99, $B9
db $93, $B3, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $F8, $FA, $F8, $FA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $92, $B2, $92, $B2, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $84, $84, $9C, $9C, $8C, $8C, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $92, $B2, $92, $B2
db $91, $B1, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $9C, $9C, $9C, $9C
db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $F8, $FA, $F8, $FA
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $99, $B9, $99, $B9, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $9B, $9B, $8A, $8A, $93, $93, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $18, $1A, $78, $7A, $38, $3A, $99, $B9, $99, $B9
db $90, $B0, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $9B, $9B, $9B, $9B
db $9A, $9A, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $98, $9A, $98, $9A
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9C, $BC, $99, $B9, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $78, $7A, $38, $3A, $98, $9A, $93, $B3, $93, $B3
db $99, $B9, $9C, $BC, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $D8, $DA
db $38, $3A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $93, $B3, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $98, $9A, $93, $B3, $92, $B2
db $91, $B1, $93, $B3, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $98, $9A
db $18, $1A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $99, $B9, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $18, $1A, $D8, $DA, $78, $7A, $98, $B8, $99, $B9
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $78, $7A
db $D8, $DA, $18, $1A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $99, $B9, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $98, $9A, $98, $B8, $99, $B9
db $99, $B9, $91, $B1, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $98, $9A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $98, $B8, $9A, $BA, $9E, $BE, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $18, $1A, $58, $5A, $78, $7A, $9E, $BE, $9E, $BE
db $9E, $BE, $9C, $BC, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $78, $7A
db $78, $7A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $99, $B9, $99, $B9, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $98, $9A, $9C, $BC, $9E, $BE
db $9E, $BE, $9E, $BE, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $78, $7A
db $78, $7A, $78, $7A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $93, $B3, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $98, $9A, $93, $B3, $93, $B3
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $98, $9A
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9C, $BC, $9E, $BE, $9E, $BE, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $78, $7A, $78, $7A, $9E, $BE, $9E, $BE
db $9E, $BE, $9C, $BC, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $78, $7A
db $78, $7A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $93, $B3, $93, $B3
db $99, $B9, $9C, $BC, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $98, $9A
db $38, $3A, $78, $7A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $98, $B8, $99, $B9
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $F8, $FA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $90, $B0, $93, $B3
db $93, $B3, $93, $B3, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $18, $1A, $98, $9A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $98, $B8, $93, $B3, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $F8, $FA, $98, $B8, $9F, $BF
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $98, $9A
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $99, $B9, $99, $B9
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $98, $9A
db $38, $3A, $78, $7A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $98, $B8, $99, $B9
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $78, $7A
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $F8, $FA, $18, $1A, $98, $9A
db $98, $9A, $18, $1A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $93, $B3, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $98, $9A, $9F, $BF, $93, $B3
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $98, $9A, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $99, $B9, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $38, $3A, $78, $7A, $38, $3A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $F8, $FA, $F8, $FA
db $98, $9A, $18, $1A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $98, $B8, $93, $B3, $9F, $BF, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $18, $1A, $98, $9A, $38, $3A, $9E, $BE, $9C, $BC
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $F8, $FA
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $93, $B3, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $38, $3A, $9C, $BC, $99, $B9
db $93, $B3, $93, $B3, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $38, $3A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $F8, $FA, $F8, $FA, $F8, $FA
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $93, $B3, $99, $B9
db $9C, $BC, $9E, $BE, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $38, $3A
db $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $98, $B8, $99, $B9
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $98, $9A
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $91, $B1, $92, $B2, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $98, $9A, $93, $B3, $93, $B3
db $93, $B3, $93, $B3, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $18, $1A, $98, $9A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $91, $B1, $92, $B2, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $18, $1A, $98, $9A, $98, $9A, $98, $9A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $92, $B2, $92, $B2, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $CF, $CF, $87, $87, $CC, $CC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $78, $7A, $91, $B1, $92, $B2
db $92, $B2, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $CC, $CC, $CC, $CC
db $E4, $E4, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $B8, $BA, $B8, $BA
db $B8, $BA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $97, $B7, $97, $B7, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $11, $11, $55, $55, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $18, $1A, $78, $7A, $97, $B7, $97, $B7
db $91, $B1, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $11, $11, $57, $57
db $57, $57, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $18, $1A, $D8, $DA
db $18, $1A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $99, $B9, $99, $B9, $9D, $BD, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $98, $9A, $D8, $DA, $9B, $BB, $9F, $BF
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $B8, $BA, $F8, $FA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9E, $BE, $9E, $BE, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $1F, $1F, $71, $71, $32, $32, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $CE, $CE, $94, $94, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $61, $61, $A7, $A7, $00, $00, $FF, $FF
db $00, $00, $00
ds 9, $FF
db $9F, $BF, $9F, $BF, $9E, $BE, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F
db $11, $11, $93, $93, $33, $33, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF
db $84, $84, $94, $94, $96, $96, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF
db $E3, $E3, $A7, $A7, $61, $61, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
ds 13, $FF
db $00, $00, $00, $FF, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9F, $BF
db $9E, $BE, $9E, $BE, $00, $00, $FC, $FC, $00, $06, $00, $FA, $F8, $FA, $F8, $FA
db $78, $7A, $78, $7A, $9F, $BF, $9E, $BE, $9E, $BE, $9C, $BC, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $F8, $FA, $78, $7A, $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $9C, $BC, $9C, $BC, $99, $B9, $9B, $BB, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $00, $00, $00, $3E, $00, $40, $1E, $5E, $1E, $56, $1E, $5E
db $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E, $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E
db $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E, $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E
db $00, $40, $3E, $3E, $00, $00, $00, $FC, $02, $02, $FA, $FA, $FA, $72, $FA, $FA
db $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA, $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA
db $FA, $DA, $FA, $FA, $FA, $72, $FA, $FB, $F8, $D8, $FF, $FF, $FF, $77, $FF, $FF
db $FF, $DD, $FF, $FF, $FA, $72, $FA, $FA, $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA
db $02, $02, $FC, $FC, $FF, $77, $FF, $FF, $FF, $DD, $FF, $FF, $FF, $77, $FF, $FF
db $00, $00, $FF, $FF

; Data from 1ED6A to 1FD59 (4080 bytes)
_DATA_1ED6A_:
ds 16, $FF
db $E7, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $E7, $E7, $F3, $FF
db $99, $99, $88, $99, $CC
ds 11, $FF
db $93, $93, $01, $01, $80, $93, $81, $93, $81, $93, $01, $01, $80, $93, $C9, $FF
db $EF, $EF, $C3, $C3, $81, $9F, $C7, $C7, $E3, $F3, $81, $87, $C3, $EF, $F7, $FF
db $FF, $FF, $39, $39, $10, $33, $81, $E7, $C3, $CF, $81, $99, $08, $39, $9C, $FF
db $C7, $C7, $83, $93, $C1, $C7, $83, $8F, $01, $21, $10, $33, $89, $89, $C4, $FF
db $E7, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $C3, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $C7, $CF, $E7, $E7, $F3, $FF
db $E7, $E7, $F3, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $F1, $F3, $E1, $E7, $F3, $FF
db $FF, $FF, $93, $93, $C1, $C7, $01, $01, $80, $C7, $83, $93, $C9, $FF, $FF, $FF
db $FF, $FF, $E7, $E7, $E3, $E7, $81, $81, $C0, $E7, $E3, $E7, $F3
ds 11, $FF
db $E7, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $81, $81
db $C0
ds 17, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $F9, $F9, $F0, $F3, $E1, $E7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $83, $83, $01, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $E7, $E7, $C3, $C7, $A3, $A7, $C3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $83, $83, $01, $39, $98, $F9, $80, $83, $01, $3F
db $1F, $3F, $01, $01, $80, $FF, $83, $83, $01, $39, $98, $F9, $E0, $E3, $F1, $F9
db $38, $39, $80, $83, $C1, $FF, $E3, $E3, $C1, $C3, $81, $93, $01, $33, $01, $01
db $80, $F3, $F1, $F3, $F9, $FF, $01, $01, $00, $3F, $1F, $3F, $03, $03, $81, $F9
db $38, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $1C, $3F, $03, $03, $01, $39
db $18, $39, $80, $83, $C1, $FF, $03, $03, $81, $F9, $F8, $F9, $F8, $F9, $F8, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $83, $83, $01, $39, $18, $39, $80, $83, $01, $39
db $18, $39, $80, $83, $C1, $FF, $83, $83, $01, $39, $18, $39, $80, $81, $C0, $F9
db $F8, $F9, $F8, $F9, $FC, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF
db $E7, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $E7, $E7, $E3, $E7, $F3, $FF, $E7, $E7
db $E3, $E7, $C3, $CF, $E7, $FF, $E7, $E7, $C3, $CF, $87, $9F, $0F, $3F, $9F, $9F
db $CF, $CF, $E7, $E7, $F3, $FF, $FF, $FF, $FF, $FF, $81, $81, $C0, $FF, $81, $81
db $C0, $FF, $FF, $FF, $FF, $FF, $CF, $CF, $E7, $E7, $F3, $F3, $F9, $F9, $F0, $F3
db $E1, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $99, $C8, $F9, $F0, $F3, $E1, $E7
db $F3, $FF, $E7, $E7, $F3, $FF, $83, $83, $01, $3D, $00, $21, $00, $2D, $02, $23
db $11, $3F, $81, $81, $C0, $FF, $C7, $C7, $83, $93, $09, $39, $00, $01, $00, $39
db $18, $39, $10, $11, $88, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $00, $03, $81, $FF, $C3, $C3, $81, $99, $0C, $3F, $1F, $3F, $1F, $3F
db $99, $99, $C0, $C3, $E1, $FF, $07, $07, $83, $93, $89, $99, $88, $99, $88, $99
db $80, $93, $01, $07, $83, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $89, $9D, $00, $01, $80, $FF, $01, $01, $80, $9D, $86, $97, $83, $87, $83, $97
db $8B, $9F, $0F, $0F, $87, $FF, $C3, $C3, $81, $99, $0C, $3F, $11, $31, $18, $39
db $98, $99, $C0, $C3, $E1, $FF, $39, $39, $18, $39, $18, $39, $00, $01, $00, $39
db $18, $39, $18, $39, $9C, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $81, $81, $C0, $FF, $81, $81, $C0, $E7, $E3, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $83, $8F, $C7, $FF, $19, $19, $88, $99, $80, $93, $81, $87, $83, $93
db $89, $99, $08, $19, $8C, $FF, $1F, $1F, $8F, $9F, $8F, $9F, $8F, $9F, $8F, $9F
db $89, $99, $00, $01, $80, $FF, $39, $39, $10, $11, $08, $29, $10, $39, $18, $39
db $18, $39, $18, $39, $9C, $FF, $31, $31, $18, $19, $08, $29, $10, $31, $18, $39
db $18, $39, $18, $19, $8C, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $18, $39
db $90, $93, $C1, $C7, $E3, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F
db $8F, $9F, $0F, $0F, $87, $FF, $C7, $C7, $83, $93, $09, $39, $18, $39, $1C, $3D
db $92, $93, $C9, $C9, $E4, $FF, $03, $03, $81, $99, $88, $99, $80, $83, $81, $99
db $88, $99, $08, $19, $8C, $FF, $83, $83, $01, $39, $1C, $3F, $83, $83, $C1, $F9
db $38, $39, $80, $83, $C1, $FF, $81, $81, $80, $A5, $C2, $E7, $E3, $E7, $E3, $E7
db $E3, $E7, $C3, $C3, $E1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $18, $39
db $18, $39, $80, $83, $C1, $FF, $11, $11, $08, $39, $18, $39, $18, $39, $90, $93
db $C1, $C7, $E3, $EF, $F7, $FF, $39, $39, $18, $39, $18, $39, $18, $39, $08, $29
db $10, $11, $08, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $83, $93
db $09, $39, $18, $39, $9C, $FF, $39, $39, $18, $39, $90, $93, $C1, $C7, $C3, $CF
db $87, $9F, $0F, $3F, $9F, $FF, $81, $81, $00, $39, $90, $F3, $E1, $E7, $C3, $CF
db $81, $99, $00, $03, $81, $FF, $C3, $C3, $C1, $CF, $C7, $CF, $C7, $CF, $C7, $CF
db $C7, $CF, $C3, $C3, $E1, $FF, $FF, $FF, $3F, $3F, $9F, $9F, $CF, $CF, $E7, $E7
db $F3, $F3, $F9, $F9, $FC, $FF, $C3, $C3, $E1, $F3, $F1, $F3, $F1, $F3, $F1, $F3
db $F1, $F3, $C1, $C3, $E1, $FF, $E7, $E7, $C3, $C3, $81, $81, $80, $A5, $C2, $E7
db $E3, $E7, $E3, $E7, $F3, $FF, $FF, $FF, $CF, $CF, $87, $9F, $01, $01, $00, $01
db $80, $9F, $CF, $CF, $E7, $FF, $E7, $E7, $E3, $E7, $F3, $F3, $F9
ds 13, $FF
db $87, $87, $C3, $F3, $81, $83, $01, $33, $81, $81, $C0, $FF, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $00, $03, $81, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $8C, $9F, $89, $99, $C0, $C3, $E1, $FF, $F1, $F1, $F0, $F3
db $81, $83, $01, $33, $11, $33, $11, $33, $81, $81, $C0, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $80, $83, $81, $9F, $C3, $C3, $E1, $FF, $E3, $E3, $C1, $CF
db $87, $87, $C3, $CF, $C7, $CF, $C7, $CF, $87, $87, $C3, $FF, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $01, $07, $1F, $1F, $8F, $9F
db $83, $83, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $E7, $E7, $F3, $FF
db $C7, $C7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $CF, $1F, $1F, $8F, $9F
db $89, $99, $80, $93, $81, $87, $83, $93, $09, $19, $8C, $FF, $C7, $C7, $E3, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $C3, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $13, $13, $01, $01, $00, $29, $10, $39, $18, $39, $9C, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $88, $99, $08, $19, $8C, $FF, $FF, $FF, $FF, $FF
db $C3, $C3, $81, $99, $88, $99, $88, $99, $C0, $C3, $E1, $FF, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $88, $99, $80, $83, $81, $9F, $0F, $0F, $FF, $FF, $FF, $FF
db $81, $81, $00, $33, $11, $33, $81, $83, $C1, $F3, $E1, $E1, $FF, $FF, $FF, $FF
db $03, $03, $81, $99, $8C, $9F, $8F, $9F, $0F, $0F, $87, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $80, $9F, $C3, $C3, $E1, $F9, $80, $83, $C1, $FF, $E7, $E7, $E3, $E7
db $C3, $C3, $E1, $E7, $E3, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $88, $99, $C0, $C1, $E0, $FF, $FF, $FF, $FF, $FF
db $11, $11, $88, $99, $88, $99, $C8, $DB, $E5, $E7, $F3, $FF, $FF, $FF, $FF, $FF
db $11, $11, $08, $39, $08, $29, $00, $01, $00, $13, $89, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $C3, $81, $99, $CC, $FF, $FF, $FF, $FF, $FF
db $99, $99, $C0, $C3, $E1, $E7, $C3, $CF, $87, $9F, $CF, $FF, $FF, $FF, $FF, $FF
db $C1, $C1, $A0, $B3, $C1, $E7, $C1, $CD, $82, $83, $C1, $FF, $F3, $F3, $E1, $E7
db $E3, $E7, $C3, $CF, $E7, $E7, $E3, $E7, $F3, $F3, $F9, $FF, $FF, $FF, $E7, $E7
db $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $E3, $E7, $F3, $FF, $CF, $CF, $E7, $E7
db $E3, $E7, $F3, $F3, $E1, $E7, $E3, $E7, $C3, $CF, $E7, $FF, $C3, $C3, $81, $9D
db $8E, $9F, $07, $07, $83, $9F, $8F, $9F, $01, $01, $80, $FF, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $93, $B3, $91, $B1, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $C6, $C6, $9C, $9C, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $38, $3A, $F8, $FA, $93, $B3, $93, $B3
db $90, $B0, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $CC, $CC, $E4, $E4
db $8E, $8E, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $F8, $FA, $F8, $FA
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $86, $A6, $82, $A2, $84, $A4, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $94, $94, $94, $94, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $E8, $EA, $48, $4A, $86, $A6, $86, $A6
db $86, $A6, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $94, $94, $94, $94
db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $A8, $AA, $E8, $EA
db $E8, $EA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $99, $B9, $90, $B0, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $18, $1A, $38, $3A, $99, $B9, $90, $B0
db $99, $B9, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $18, $1A
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9C, $BC, $99, $B9, $9F, $BF, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $98, $9A, $9F, $BF, $9E, $BE
db $9F, $BF, $9E, $BE, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $78, $7A
db $F8, $FA, $78, $7A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $92, $B2, $92, $B2, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $84, $84, $9C, $9C, $8C, $8C, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $92, $B2, $92, $B2
db $91, $B1, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $9C, $9C, $9C, $9C
db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $F8, $FA, $F8, $FA
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $99, $B9, $99, $B9, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $9B, $9B, $8A, $8A, $93, $93, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $18, $1A, $78, $7A, $38, $3A, $99, $B9, $99, $B9
db $90, $B0, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $9B, $9B, $9B, $9B
db $9A, $9A, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $98, $9A, $98, $9A
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9E, $BE, $9C, $BC, $9A, $BA, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $78, $7A, $78, $7A, $78, $7A, $9E, $BE, $9E, $BE
db $9E, $BE, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $78, $7A
db $78, $7A, $18, $1A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $98, $B8, $93, $B3, $9F, $BF, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $98, $9A, $98, $B8, $93, $B3
db $93, $B3, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $F8, $FA
db $F8, $FA, $18, $1A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $9E, $BE, $9F, $BF
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $98, $9A
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $8E, $AE, $84, $A4, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $D8, $DA, $8A, $AA, $8E, $AE
db $8E, $AE, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $88, $8A, $D8, $DA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $88, $8A, $F8, $FA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $98, $9A, $A8, $AA, $98, $9A, $A8, $AA
db $A8, $AA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $88, $8A, $B8, $BA, $B8, $BA, $B8, $BA
db $88, $8A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9C, $BC, $99, $B9, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $D8, $DA, $F8, $FA, $90, $B0, $99, $B9
db $99, $B9, $90, $B0, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $F8, $FA
db $F8, $FA, $18, $1A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $99, $B9, $9C, $BC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $38, $3A, $78, $7A, $90, $B0, $9C, $BC
db $99, $B9, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $18, $1A, $78, $7A
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9E, $BE, $9C, $BC, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $38, $3A, $38, $3A, $93, $B3, $90, $B0
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $18, $1A
db $38, $3A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $93, $B3, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $18, $1A, $F8, $FA, $F8, $FA, $90, $B0, $9F, $BF
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $90, $B0, $93, $B3
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $98, $B8, $93, $B3, $93, $B3, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $F8, $FA, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9E, $BE, $9E, $BE, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $78, $7A, $78, $7A, $98, $B8, $9E, $BE
db $9E, $BE, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $18, $1A, $78, $7A
db $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $98, $B8, $9F, $BF
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $38, $3A, $F8, $FA
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $99, $B9, $9C, $BC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $98, $9A, $38, $3A, $9E, $BE, $9C, $BC
db $99, $B9, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $78, $7A, $38, $3A
db $98, $9A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9E, $BE, $9F, $BF, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $78, $7A, $F8, $FA, $98, $B8, $9F, $BF
db $9E, $BE, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $18, $1A, $F8, $FA
db $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $90, $B0, $9F, $BF, $9F, $BF, $98, $9A, $98, $9A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $9F, $BF, $9F, $BF
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $98, $B8, $93, $B3, $93, $B3, $98, $B8, $93, $B3
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $B8, $9F, $BF
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $18, $1A, $98, $9A
db $98, $9A, $98, $9A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $9C, $BC, $9F, $BF
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $93, $B3, $93, $B3, $9E, $BE, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $98, $9A, $38, $3A, $78, $7A, $9C, $BC, $99, $B9
db $93, $B3, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $F8, $FA, $98, $9A
db $98, $9A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $98, $B8, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $38, $3A, $9F, $BF, $98, $B8
db $9F, $BF, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $F8, $FA, $38, $3A
db $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9C, $BC, $99, $B9, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $38, $3A, $F8, $FA, $99, $B9, $99, $B9
db $9C, $BC, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $F8, $FA, $F8, $FA
db $38, $3A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $92, $B2, $92, $B2, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $CF, $CF, $87, $87, $CC, $CC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $78, $7A, $91, $B1, $92, $B2
db $92, $B2, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $CC, $CC, $CC, $CC
db $E4, $E4, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $B8, $BA, $B8, $BA
db $B8, $BA, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $91, $B1, $97, $B7, $97, $B7, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $11, $11, $55, $55, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $F8, $FA, $18, $1A, $78, $7A, $97, $B7, $97, $B7
db $91, $B1, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $11, $11, $57, $57
db $57, $57, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $18, $1A, $D8, $DA
db $18, $1A, $F8, $FA, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $FC, $FC
db $00, $06, $00, $FA, $F8, $FA, $38, $3A, $98, $9A, $18, $1A, $92, $B2, $91, $B1
db $93, $B3, $98, $B8, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $98, $9A, $98, $9A
db $98, $9A, $38, $3A, $F8, $FA, $F8, $FA, $00, $06, $00, $FC, $00, $00, $7F, $7F
db $80, $C0, $80, $BF, $9F, $BF, $9F, $BF, $9E, $BE, $9E, $BE, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $1F, $1F, $71, $71, $32, $32, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $CE, $CE, $94, $94, $00, $00, $FF, $FF
db $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $61, $61, $A7, $A7, $9F, $BF, $9F, $BF
db $9E, $BE, $9F, $BF, $9F, $BF, $9F, $BF, $80, $C0, $00, $7F, $11, $11, $93, $93
db $33, $33, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $84, $84, $94, $94
db $96, $96, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $E3, $E3, $A7, $A7
db $61, $61, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF
db $00, $00, $00
ds 21, $FF
db $00, $00, $00, $FF, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9F, $BF
db $9E, $BE, $9E, $BE, $00, $00, $FC, $FC, $00, $06, $00, $FA, $F8, $FA, $F8, $FA
db $78, $7A, $78, $7A, $9F, $BF, $9E, $BE, $9E, $BE, $9F, $BF, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $F8, $FA, $78, $7A, $78, $7A, $F8, $FA, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $98, $B8
db $93, $B3, $92, $B2, $00, $00, $FC, $FC, $00, $06, $00, $FA, $F8, $FA, $38, $3A
db $D8, $DA, $18, $1A, $92, $B2, $92, $B2, $93, $B3, $98, $B8, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $D8, $DA, $38, $3A, $F8, $FA, $38, $3A, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9F, $BF
db $9F, $BF, $9C, $BC, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9C, $BC
db $9C, $BC, $9C, $BC, $9C, $BC, $9C, $BC, $9F, $BF, $9C, $BC, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9C, $BC
db $99, $B9, $99, $B9, $99, $B9, $99, $B9, $99, $B9, $9C, $BC, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $00, $00, $FC, $FC, $00, $06, $00, $FA, $F8, $FA, $38, $3A
db $98, $9A, $98, $9A, $98, $9A, $98, $9A, $98, $9A, $38, $3A, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $00, $00, $FC, $FC, $00, $06, $00, $FA, $F8, $FA, $38, $3A
db $98, $9A, $98, $9A, $C8, $CA, $98, $9A, $98, $9A, $38, $3A, $F8, $FA, $F8, $FA
db $00, $06, $00, $FC, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9C, $BC
db $99, $B9, $99, $B9, $93, $B3, $99, $B9, $99, $B9, $9C, $BC, $9F, $BF, $9F, $BF
db $80, $C0, $00, $7F, $00, $00, $7F, $7F, $80, $C0, $80, $BF, $9F, $BF, $9F, $BF
db $9F, $BF, $9F, $BF, $00, $00, $00, $3E, $00, $40, $1E, $5E, $1E, $56, $1E, $5E
db $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E, $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E
db $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E, $1E, $5C, $1E, $5E, $1E, $56, $1E, $5E
db $00, $40, $3E, $3E, $00, $00, $00, $FC, $02, $02, $FA, $FA, $FA, $72, $FA, $FA
db $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA, $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA
db $02, $02, $FC, $FC, $00, $00, $00, $FC, $02, $02, $FA, $FA, $FA, $72, $FA, $FA
db $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA, $FA, $DA, $FA, $FA, $FA, $72, $FA, $FA
db $FA, $DA, $FA, $FA, $FF, $77, $FF, $FF, $FF, $DD, $FF, $FF, $FF, $77, $FF, $FF
db $00, $00, $FF, $FF, $FA, $72, $FA, $FB, $F8, $D8, $FF, $FF, $FF, $77, $FF, $FF
db $FF, $DD, $FF, $FF

; Data from 1FD5A to 1FD61 (8 bytes)
_DATA_1FD5A_:
db $00, $60, $B0, $E8, $EC, $EE, $EE, $EE

; Data from 1FD62 to 1FE75 (276 bytes)
_DATA_1FD62_:
db $00, $00, $60, $70, $70, $70, $70, $70, $03, $0E, $3B, $6E, $F6, $D7, $D7, $7E
db $00, $03, $0F, $3F, $7F, $7F, $7F, $3F, $EE, $EE, $EE, $6F, $EF, $C7, $F8, $B4
db $70, $70, $70, $F0, $F1, $FB, $FF, $FF, $00, $00, $E0, $F0, $98, $3C, $FE, $FC
db $00, $00, $00, $E0, $F0, $C0, $00, $00, $7F, $7F, $3F, $3E, $1F, $1D, $0F, $0F
db $3F, $3F, $1F, $1F, $0F, $0F, $07, $00, $E1, $51, $C3, $A3, $87, $47, $8F, $FF
db $FE, $FE, $FC, $FC, $F8, $F8, $F0, $00, $F0, $E0, $C0, $C0, $80, $80
ds 10, $00
db $0F, $0F, $0F, $0F, $07, $03, $01, $00, $07, $07, $07, $07, $00, $00, $00, $00
db $8E, $6E, $EE, $0E, $FE, $FE, $FC, $00, $F0, $90, $B0, $F0, $00, $00, $00, $00
db $00, $00, $30, $58, $74, $76, $77, $B7, $00, $00, $00, $30, $38, $38, $38, $78
db $03, $0D, $35, $57, $7B, $6F, $6F, $7E, $00, $03, $0F, $3F, $3F, $3F, $3F, $3F
db $AF, $EF, $EE, $6F, $CF, $67, $FA, $B1, $70, $70, $70, $F0, $F1, $FB, $FF, $FE
db $00, $00, $00, $C0, $E0, $30, $78, $FC, $00, $00, $00, $00, $C0, $E0, $80, $00
db $7F, $3F, $3E, $1F, $1D, $0F, $0F, $0F, $3F, $1F, $1F, $0F, $0F, $07, $00, $07
db $51, $C3, $A3, $87, $47, $8F, $FF, $8E, $FE, $FC, $FC, $F8, $F8, $F0, $00, $F0
db $F8, $E0, $C0, $80, $80
ds 11, $00
db $0F, $0F, $0F, $07, $03, $01, $00, $00, $07, $07, $04, $00, $00, $00, $00, $00
db $6E, $0E, $EE, $FE, $FE, $FC, $00, $00, $B0, $F0, $10, $00

; Data from 1FE76 to 1FEB0 (59 bytes)
_DATA_1FE76_:
db $00, $00, $00, $00, $00, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00
db $00, $00, $00, $00, $00, $00, $FC, $00, $FC, $00, $FC, $00, $FC, $00, $FC, $00
db $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $00, $00, $00, $00, $00, $00
db $FC, $00, $FC, $00, $FC, $00, $FC, $00, $FC, $00, $00

; Data from 1FEB1 to 1FEB8 (8 bytes)
_DATA_1FEB1_:
db $00, $00, $00, $00, $00, $00, $00, $00

; Data from 1FEB9 to 1FFFF (327 bytes)
_DATA_1FEB9_:
db $00, $00, $00, $00, $00, $00, $00, $00, $07, $1F, $38, $60, $60, $C0, $C0, $C0
db $00, $07, $1F, $38, $30, $60, $60, $60, $00, $03, $0F, $1C, $30, $30, $60, $60
db $00, $00, $03, $0F, $1C, $18, $30, $30, $00, $00, $03, $0F, $1C, $18, $30, $30
db $00, $00, $00, $03, $0F, $0C, $18, $18, $00, $00, $00, $03, $0F, $0C, $18, $18
db $00, $00, $00, $00, $03, $07, $0C, $0C, $00, $00, $00, $00, $03, $07, $0C, $0C
db $00, $00, $00, $00, $00, $03, $07, $06, $00, $00, $00, $00, $00, $03, $07, $06
db $00, $00, $00, $00, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $01, $03
db $00, $00, $00, $00, $00, $00, $00, $01, $05, $0F, $19, $1B, $1D, $1F, $21, $31
db $3F, $45, $4A, $56, $67, $7A, $8A, $9C, $A7, $BB, $CF, $E3, $F7, $0B, $1F, $33
db $47, $5B, $6F, $83, $97, $AB, $BF, $D4, $DE, $EC, $FC, $0D, $12, $1C, $30, $44
db $58, $6B, $79, $87, $97, $AB, $BD, $D0, $E5, $FA, $0B, $1A, $2E, $42, $50, $5E
db $6E, $82, $94, $A7, $BC, $D1, $E2, $F1, $05, $19, $2E, $44, $56, $60, $6A, $71
db $7B, $84, $8A, $9F, $B4, $C9, $DE, $F3, $08, $1D, $2E, $37, $40, $46, $4F, $57
db $5C, $69, $75, $89, $9D, $B1, $C5, $D9, $ED, $02, $17, $2B, $3F, $53, $67, $74
db $81, $90, $A4, $A9, $BB, $CD, $E1, $F5, $FA, $03, $15, $28, $3C, $4F, $62, $77
db $8B, $9E, $B2, $C5, $CC, $D3, $DB, $E3, $EC, $F6, $00, $0A, $14, $1E, $28, $32
db $3C, $46, $50, $5A, $64, $7C, $91, $A6, $BB, $D0, $E5, $FA, $0E, $22, $36, $4A
db $5E, $72, $86, $9A, $AE, $C3, $D8, $EC, $00, $14, $29, $39, $4D
ds 42, $00

