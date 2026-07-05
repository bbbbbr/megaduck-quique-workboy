

; ==== TODO: CURRENT MEGADUCK KEYBOARD ====
; Shift seems to be handled like this:
; - It's a key that has separate codes for Up / Down
;   - SHIFT_DOWN        39
;   - SHIFT_UP          50
; - In order to send a key that requires it
;   - Need to first send the SHIFT-DOWN key
;     - Then on next poll send the REQUIRES SHIFT key
;       - Then on third poll send the SHIFT-UP key
;
; Can we patch over all this and set SHIFT directly
; without having to emulate multiple polling?
;
; Is this going to require also masking the megaduck
; shift key behavior?
; 
; Workboy[NUM KEY] -> is the shift key?
; But it always selects the alternate superscript key?
;
; What does the CAPS key do?

;TODO: handling for emulating shift
;DEF WORKBOY_KEY_SHIFT_DOWN       EQU  39
;DEF WORKBOY_KEY_SHIFT_UP         EQU  50



; Commented out means not yet assigned in
; megaduck_to_workboy_keyboard_keycode_recode_table

DEF WORKBOY_KEY_NONE              EQU $FF
DEF WORKBOY_KEY_REQUIRE_SHIFT     EQU $40
;DEF WORKBOY_KEY_BLOCK_SHIFT      EQU $80
    
DEF WORKBOY_KEY_CLOCK             EQU 1
DEF WORKBOY_KEY_TEMPERATURE       EQU 2
DEF WORKBOY_KEY_MONEY             EQU 3
DEF WORKBOY_KEY_CALCULATOR        EQU 4
DEF WORKBOY_KEY_DATE              EQU 5
DEF WORKBOY_KEY_CONVERSION        EQU 6
DEF WORKBOY_KEY_RECORD            EQU 7
DEF WORKBOY_KEY_WORLD             EQU 8
DEF WORKBOY_KEY_PHONE             EQU 9
DEF WORKBOY_KEY_ESCAPE            EQU 10
DEF WORKBOY_KEY_BACKSPACE         EQU 11
;DEF WORKBOY_KEY_UNKNOWN          EQU  12
DEF WORKBOY_KEY_LEFT              EQU 13
DEF WORKBOY_KEY_Q                 EQU 17
DEF WORKBOY_KEY_1                 EQU WORKBOY_KEY_Q      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_W                 EQU 18
DEF WORKBOY_KEY_2                 EQU WORKBOY_KEY_W      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_E                 EQU 19
DEF WORKBOY_KEY_3                 EQU WORKBOY_KEY_E      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_R                 EQU 20
DEF WORKBOY_KEY_T                 EQU 21
DEF WORKBOY_KEY_Y                 EQU 22 
DEF WORKBOY_KEY_U                 EQU 23 
DEF WORKBOY_KEY_I                 EQU 24
DEF WORKBOY_KEY_EXCLAMATION_MARK  EQU WORKBOY_KEY_I      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_O                 EQU 25
;DEF WORKBOY_KEY_TILDE            EQU  WORKBOY_KEY_O      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_P                 EQU 26
DEF WORKBOY_KEY_ASTERISK          EQU WORKBOY_KEY_P      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_DOLLAR            EQU 27 ;               | WORKBOY_KEY_BLOCK_SHIFT
DEF WORKBOY_KEY_HASH              EQU WORKBOY_KEY_DOLLAR | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_A                 EQU 28
DEF WORKBOY_KEY_4                 EQU WORKBOY_KEY_A      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_S                 EQU 29
DEF WORKBOY_KEY_5                 EQU WORKBOY_KEY_S      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_D                 EQU 30
DEF WORKBOY_KEY_6                 EQU WORKBOY_KEY_D      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_F                 EQU 31
DEF WORKBOY_KEY_PLUS              EQU WORKBOY_KEY_F      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_G                 EQU 32
DEF WORKBOY_KEY_MINUS             EQU WORKBOY_KEY_G      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_H                 EQU 33
DEF WORKBOY_KEY_J                 EQU 34
DEF WORKBOY_KEY_K                 EQU 35
DEF WORKBOY_KEY_LEFT_PARENTHESIS  EQU WORKBOY_KEY_K      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_L                 EQU 36
DEF WORKBOY_KEY_RIGHT_PARENTHESIS EQU WORKBOY_KEY_L      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_SEMICOLON         EQU 37 ;               | WORKBOY_KEY_BLOCK_SHIFT
DEF WORKBOY_KEY_COLON             EQU 37
DEF WORKBOY_KEY_ENTER             EQU 38
;DEF WORKBOY_KEY_SHIFT_DOWN       EQU  39 (0x27)
DEF WORKBOY_KEY_Z                 EQU 40
DEF WORKBOY_KEY_7                 EQU WORKBOY_KEY_Z      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_X                 EQU 41
DEF WORKBOY_KEY_8                 EQU WORKBOY_KEY_X      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_C                 EQU 42
DEF WORKBOY_KEY_9                 EQU WORKBOY_KEY_C      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_V                 EQU 43
DEF WORKBOY_KEY_DECIMAL_POINT     EQU WORKBOY_KEY_V      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_B                 EQU 44
DEF WORKBOY_KEY_PERCENT           EQU WORKBOY_KEY_B      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_N                 EQU 45
DEF WORKBOY_KEY_EQUAL             EQU WORKBOY_KEY_N      | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_M                 EQU 46
DEF WORKBOY_KEY_COMMA             EQU 47 ;               | WORKBOY_KEY_BLOCK_SHIFT
DEF WORKBOY_KEY_LT                EQU WORKBOY_KEY_COMMA  | WORKBOY_KEY_REQUIRE_SHIFT
;DEF WORKBOY_KEY_DOT              EQU  48 ;               | WORKBOY_KEY_BLOCK_SHIFT
                                    DEF WORKBOY_KEY_DOT              EQU  48 ;               TODO: NOT YET IMPLEMENTED
DEF WORKBOY_KEY_GT                EQU WORKBOY_KEY_DOT    | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_SLASH             EQU 49 ;               | WORKBOY_KEY_BLOCK_SHIFT
DEF WORKBOY_KEY_QUESTION_MARK     EQU WORKBOY_KEY_SLASH  | WORKBOY_KEY_REQUIRE_SHIFT
;DEF WORKBOY_KEY_SHIFT_UP         EQU  50 (0x32)
;DEF WORKBOY_KEY_DOUBLE_QUOTE     EQU  51
            DEF WORKBOY_KEY_DOUBLE_QUOTE           EQU  51                                                   ; Not yet implemented
DEF WORKBOY_KEY_0                 EQU WORKBOY_KEY_DOUBLE_QUOTE  | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_SPACE             EQU 52
DEF WORKBOY_KEY_QUOTE             EQU 53 ;               | WORKBOY_KEY_BLOCK_SHIFT     ; TODO: This looks wrong, should be the Apostrophe or whatever key
;DEF WORKBOY_KEY_AT               EQU  WORKBOY_KEY_QUOTE  | WORKBOY_KEY_REQUIRE_SHIFT
DEF WORKBOY_KEY_UP                EQU 54
DEF WORKBOY_KEY_DOWN              EQU 55
DEF WORKBOY_KEY_RIGHT             EQU 56

