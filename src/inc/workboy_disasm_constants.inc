
DEF  APP_0_CLOCK          EQU $00
DEF  APP_1_CALCULATOR     EQU $01
DEF  APP_2_DATABASE       EQU $02
DEF  APP_3_APPOINTMENTS   EQU $03
DEF  APP_4_CALENDAR       EQU $04
DEF  APP_5_WORLD          EQU $05
DEF  APP_6_THERMOMETER    EQU $06
DEF  APP_7_CONVERSION     EQU $07
DEF  APP_8_CHECKBOOK      EQU $08
DEF  APP_9_CURRENCY       EQU $09
DEF  APP_A_SYSCONTROL     EQU $0A
DEF  APP_B_PHONE          EQU $0B


; At least one version of this is
; stored in keyboard_cur_mode__RAM_C280
DEF KEYBD_MODE_ALT_DEFAULT_TEXT_AND_LIST_MENU_NAV_0x01   EQU $01 ; Set when CAPS key pressed ; Seems to be default, and for List Menu/Sub-menu style popup navigation (up/down/enter)
DEF KEYBD_MODE_ALT_NUMERIC_PHONE_MAYBE_OTHERS_0x02       EQU $02 ; Set when NUM key pressed
DEF KEYBD_MODE_ALT_NUMERIC_AND_DATE_0x03                 EQU $03 ; Set for entering: Time of Day (clock), Date (Calendar), Currency (Money app), Numbers (Conversion app)
DEF KEYBD_MODE_ALT_UNKNOWN_0x04                          EQU $04 ; This gets set sometimes too, not yet checked conditions




; See: keyboard_cur_mode__RAM_C280
; Commands sent to the Workboy peripheral over serial IO
DEF WORKBOY_CMD_TODO_0       EQU 0   ; $00  ; TODO: Might be a poll for "Ready"
DEF WORKBOY_CMD_O_READKEY    EQU "O" ; $4F  ; TODO: Maybe this is more general, "just read something?"
DEF WORKBOY_CMD_R_TODO       EQU "R" ; $52  ; TODO: Sent at startup to check hardware and read RTC
DEF WORKBOY_CMD_W_TODO       EQU "W" ; $57  ; TODO: Is this Write mode?

DEF WORKBOY_REPLY_D_MAYBE_AN_ACK_TODO     EQU "D"

DEF MAIN_MENU__GAMEPAD_POLLTIME_RESET  EQU  20 ; $14


DEF KYBD_STATUS__NOT_FOUND   EQU  0  ; Set if user presses a button during startup keyboard screen with no keyboard present
DEF KYBD_STATUS__OK          EQU  1  ; Set when "R" CMD returns "D" reply
DEF KYBD_STATUS__UNSET       EQU  2  ; Initial value on startup


; Queue-able VBL Commands
; See: vblank__dispatch_table__2557
DEF VBL_CMD__DEFAULT__0x00 EQU $00
DEF VBL_CMD__COPY_TEXT__0x0F EQU $0f

DEF WORKBOY_SAVE_DATA__CHECK_SEQUENCE_LEN  EQU 4