
; WORKBOY_SYS_KEY_*  : Translated keys after conversion for system use
; WORKBOY_SCAN_KEY_* : Codes received from hardware (or Megaduck compat layer)

; These key values are from the translated from the raw keyboard scancode versions
; into something ASCII-like, except for the special codes
DEF WORKBOY_SYS_KEY_NUM_MODE      EQU  $0B
DEF WORKBOY_SYS_KEY_CAPS_MODE     EQU  $0C
DEF WORKBOY_SYS_KEY_RETURN        EQU  $0D ; Matches ms vkey


DEF WORKBOY_SYS_KEY_ARROW_UP      EQU  $0F
DEF WORKBOY_SYS_KEY_ARROW_LEFT    EQU  $10
DEF WORKBOY_SYS_KEY_ARROW_RIGHT   EQU  $11
DEF WORKBOY_SYS_KEY_ARROW_DOWN    EQU  $12

; Some of the App keys map to a launcher sub-menu that chooses between multiple different apps
DEF WORKBOY_SYS_KEY_CLOCK         EQU  1
DEF WORKBOY_SYS_KEY_THERMOMETER   EQU  2
DEF WORKBOY_SYS_KEY_FINANCE       EQU  3
DEF WORKBOY_SYS_KEY_CALCULATOR    EQU  4
DEF WORKBOY_SYS_KEY_SCHEDULER     EQU  5
DEF WORKBOY_SYS_KEY_CONVERSION    EQU  6
DEF WORKBOY_SYS_KEY_DATABASE      EQU  7
DEF WORKBOY_SYS_KEY_WORLD         EQU  8
DEF WORKBOY_SYS_KEY_PHONE         EQU  9
DEF WORKBOY_SYS_KEY_APPS_AFTER    EQU (WORKBOY_SYS_KEY_PHONE + 1)

