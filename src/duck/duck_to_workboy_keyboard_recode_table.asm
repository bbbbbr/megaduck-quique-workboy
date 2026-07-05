; Recode table for MegaDuck Laptop Keyboard -> Workboy Keyboard
;
; This is the SPANISH recode table
;
; Byte index: MegaDuck Key Scan Code
; Value     : Workboy  Key Scan Code
megaduck_to_workboy_keyboard_keycode_recode_table:
    ; // == Start of shift adjusted scan code range (0x00 through 0x7F) ==
    ; //
    ; // Caps lock is handled separate by manually adjusting a-z
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x80
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x81
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x82
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x83
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x84
    db WORKBOY_KEY_EXCLAMATION_MARK          ; '!',        // 0x85 Shift alt: !
    db WORKBOY_KEY_Q                         ; 'Q',        // 0x86 Shift alt: Q
    db WORKBOY_KEY_A                         ; 'A',        // 0x87 Shift alt: A
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x88
    db WORKBOY_KEY_QUOTE                     ; '"',        // 0x89 Shift alt:  "
    db WORKBOY_KEY_W                         ; 'W',        // 0x8A Shift alt: W
    db WORKBOY_KEY_S                         ; 'S',        // 0x8B Shift alt: S
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x8C
    db WORKBOY_KEY_NONE                      ; '·',        // 0x8D Shift alt: · (Spanish, mid-dot) | § (German, legal section)
    db WORKBOY_KEY_E                         ; 'E',        // 0x8E Shift alt: E
    db WORKBOY_KEY_D                         ; 'D',        // 0x8F Shift alt: D

    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x90
    db WORKBOY_KEY_DOLLAR                    ; '$',        // 0x91 Shift alt: $
    db WORKBOY_KEY_R                         ; 'R',        // 0x92
    db WORKBOY_KEY_F                         ; 'F',        // 0x93
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x94
    db WORKBOY_KEY_PERCENT                   ; '%',        // 0x95 Shift alt: %
    db WORKBOY_KEY_T                         ; 'T',        // 0x96
    db WORKBOY_KEY_G                         ; 'G',        // 0x97
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x98
    db WORKBOY_KEY_NONE                      ; '&',        // 0x99 Shift alt: &
    db WORKBOY_KEY_Y                         ; 'Y',        // 0x9A
    db WORKBOY_KEY_H                         ; 'H',        // 0x9B
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x9C
    db WORKBOY_KEY_SLASH                     ; '/',        // 0x9D Shift alt: /
    db WORKBOY_KEY_U                         ; 'U',        // 0x9E
    db WORKBOY_KEY_J                         ; 'J',        // 0x9F

    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xA0
    db WORKBOY_KEY_LEFT_PARENTHESIS          ; '(',        // 0xA1 Shift alt: (
    db WORKBOY_KEY_I                         ; 'I',        // 0xA2
    db WORKBOY_KEY_K                         ; 'K',        // 0xA3
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xA4
    db WORKBOY_KEY_RIGHT_PARENTHESIS         ; ')',        // 0xA5 Shift alt: )
    db WORKBOY_KEY_O                         ; 'O',        // 0xA6
    db WORKBOY_KEY_L                         ; 'L',        // 0xA7
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xA8
    db WORKBOY_KEY_NONE                      ; '\\',       // 0xA9 Shift alt: "\"
    db WORKBOY_KEY_P                         ; 'P',        // 0xAA
    db WORKBOY_KEY_NONE                      ; 'Ñ',        // 0xAB
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xAC
    db WORKBOY_KEY_QUESTION_MARK             ; '?',        // 0xAD Shift alt: ?
    db WORKBOY_KEY_NONE                      ; '[',        // 0xAE Shift alt: [ (Spanish, only shift mode works) | German version: Ü
    db WORKBOY_KEY_NONE                      ; 'Ü',        // 0xAF

    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB0
    db WORKBOY_KEY_NONE                      ; '¿',        // 0xB1 Shift alt: ¿ (Spanish) | ` (German)  ; German version: ' (single quote?)
    db WORKBOY_KEY_ASTERISK                  ; '*',        // 0xB2 Shift alt: * | German version: · (mid-dot)
    db WORKBOY_KEY_NONE                      ; 'ª',        // 0xB3 Shift alt: Feminine Ordinal [A over line] (Spanish) | ^ (German)
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB4
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB5
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB6
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB7
    db WORKBOY_KEY_Z                         ; 'Z',        // 0xB8  // German version : 'Y'
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB9
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBB
    db WORKBOY_KEY_X                         ; 'X',        // 0xBC
    db WORKBOY_KEY_GT                        ; '>',        // 0xBD Shift alt: >
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBF

    db WORKBOY_KEY_C                         ; 'C',        // 0xC0
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC1
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC3
    db WORKBOY_KEY_V                         ; 'V',        // 0xC4
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC5
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC6
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC7
    db WORKBOY_KEY_B                         ; 'B',        // 0xC8
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC9
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCB
    db WORKBOY_KEY_N                         ; 'N',        // 0xCC
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCD
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCF

    db WORKBOY_KEY_M                         ; 'M',        // 0xD0
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD1
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD3
    db WORKBOY_KEY_SEMICOLON                 ; ';',        // 0xD4  ; Shift alt: ;
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD5
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD6
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD7
    db WORKBOY_KEY_COLON                     ; ':',        // 0xD8  ; Shift alt: :
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD9
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDB
    db WORKBOY_KEY_NONE                      ; '_',        // 0xDC  ; Shift alt: _ | German version: @
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDD
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDF

    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE0
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE1
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE3
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE4
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE5
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE6
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE7
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE8
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE9
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEB
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEC
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xED
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEF

    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF0
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF1
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF3
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF4
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF5
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF6
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF7
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF8
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF9
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFB
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFC
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFD
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFF

    ; // == Start of actual scan code range (0x80 through 0xFF) ==
    db WORKBOY_KEY_CLOCK                     ; NO_KEY,     // 0x80 DUCK_KEY_CODE_F1
    db WORKBOY_KEY_ESCAPE                    ; KEY_ESCAPE, // 0x81 DUCK_KEY_CODE_ESCAPE
    db WORKBOY_KEY_NONE                      ; KEY_HELP,   // 0x82 DUCK_KEY_CODE_HELP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0x83
    db WORKBOY_KEY_TEMPERATURE               ; NO_KEY,     // 0x84 DUCK_KEY_CODE_F2
    db WORKBOY_KEY_1                         ; '1',        // 0x85 DUCK_KEY_CODE_1
    db WORKBOY_KEY_Q                         ; 'q',        // 0x86 DUCK_KEY_CODE_Q
    db WORKBOY_KEY_A                         ; 'a',        // 0x87 DUCK_KEY_CODE_A
    db WORKBOY_KEY_MONEY                     ; NO_KEY,     // 0x88 DUCK_KEY_CODE_F3
    db WORKBOY_KEY_2                         ; '2',        // 0x89 DUCK_KEY_CODE_2
    db WORKBOY_KEY_W                         ; 'w',        // 0x8A DUCK_KEY_CODE_W
    db WORKBOY_KEY_S                         ; 's',        // 0x8B DUCK_KEY_CODE_S
    db WORKBOY_KEY_CALCULATOR                ; NO_KEY,     // 0x8C DUCK_KEY_CODE_F4
    db WORKBOY_KEY_3                         ; '3',        // 0x8D DUCK_KEY_CODE_3
    db WORKBOY_KEY_E                         ; 'e',        // 0x8E DUCK_KEY_CODE_E
    db WORKBOY_KEY_D                         ; 'd',        // 0x8F DUCK_KEY_CODE_D

    db WORKBOY_KEY_DATE                      ; NO_KEY,     // 0x90 DUCK_KEY_CODE_F5
    db WORKBOY_KEY_4                         ; '4',        // 0x91 DUCK_KEY_CODE_4
    db WORKBOY_KEY_R                         ; 'r',        // 0x92 DUCK_KEY_CODE_R
    db WORKBOY_KEY_F                         ; 'f',        // 0x93 DUCK_KEY_CODE_F
    db WORKBOY_KEY_CONVERSION                ; NO_KEY,     // 0x94 DUCK_KEY_CODE_F6
    db WORKBOY_KEY_5                         ; '5',        // 0x95 DUCK_KEY_CODE_5
    db WORKBOY_KEY_T                         ; 't',        // 0x96 DUCK_KEY_CODE_T
    db WORKBOY_KEY_G                         ; 'g',        // 0x97 DUCK_KEY_CODE_G
    db WORKBOY_KEY_RECORD                    ; NO_KEY,     // 0x98 DUCK_KEY_CODE_F7
    db WORKBOY_KEY_6                         ; '6',        // 0x99 DUCK_KEY_CODE_6
    db WORKBOY_KEY_Y                         ; 'y',        // 0x9A DUCK_KEY_CODE_Y
    db WORKBOY_KEY_H                         ; 'h',        // 0x9B DUCK_KEY_CODE_H
    db WORKBOY_KEY_WORLD                     ; NO_KEY,     // 0x9C DUCK_KEY_CODE_F8
    db WORKBOY_KEY_7                         ; '7',        // 0x9D DUCK_KEY_CODE_7
    db WORKBOY_KEY_U                         ; 'u',        // 0x9E DUCK_KEY_CODE_U
    db WORKBOY_KEY_J                         ; 'j',        // 0x9F DUCK_KEY_CODE_J

    db WORKBOY_KEY_PHONE                     ; NO_KEY,     // 0xA0 DUCK_KEY_CODE_F9
    db WORKBOY_KEY_8                         ; '8',        // 0xA1 DUCK_KEY_CODE_8
    db WORKBOY_KEY_I                         ; 'i',        // 0xA2 DUCK_KEY_CODE_I
    db WORKBOY_KEY_K                         ; 'k',        // 0xA3 DUCK_KEY_CODE_K
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xA4 DUCK_KEY_CODE_F10
    db WORKBOY_KEY_9                         ; '9',        // 0xA5 DUCK_KEY_CODE_9
    db WORKBOY_KEY_O                         ; 'o',        // 0xA6 DUCK_KEY_CODE_O
    db WORKBOY_KEY_L                         ; 'l',        // 0xA7 DUCK_KEY_CODE_L
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xA8 DUCK_KEY_CODE_F11
    db WORKBOY_KEY_0                         ; '0',        // 0xA9 DUCK_KEY_CODE_0
    db WORKBOY_KEY_P                         ; 'p',        // 0xAA DUCK_KEY_CODE_P
    db WORKBOY_KEY_NONE                      ; 'ñ',        // 0xAB DUCK_KEY_CODE_N_TILDE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xAC DUCK_KEY_CODE_F12
    db WORKBOY_KEY_NONE                      ; '\'',       // 0xAD DUCK_KEY_CODE_SINGLE_QUOTE
    db WORKBOY_KEY_NONE                      ; '`',        // 0xAE DUCK_KEY_CODE_BACKTICK
    db WORKBOY_KEY_NONE                      ; 'ü',        // 0xAF DUCK_KEY_CODE_U_UMLAUT

    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB0
    db WORKBOY_KEY_NONE                      ; '¡',        // 0xB1 DUCK_KEY_CODE_EXCLAMATION_FLIPPED
    db WORKBOY_KEY_NONE                      ; ']',        // 0xB2 DUCK_KEY_CODE_RIGHT_SQ_BRACKET
    db WORKBOY_KEY_NONE                      ; 'º',     // 0xB3 DUCK_KEY_CODE_O_OVER_LINE Masculine Ordinal
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB4
    db WORKBOY_KEY_BACKSPACE                 ; KEY_BACKSPACE, // 0xB5 DUCK_KEY_CODE_BACKSPACE
    db WORKBOY_KEY_ENTER                     ; KEY_ENTER,     // 0xB6 DUCK_KEY_CODE_ENTER
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xB7
    db WORKBOY_KEY_Z                         ; 'z',        // 0xB8 DUCK_KEY_CODE_Z     // German version : 'y'
    db WORKBOY_KEY_SPACE                     ; ' ',        // 0xB9 DUCK_KEY_CODE_SPACE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBA DUCK_KEY_CODE_PIANO_DO_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBB DUCK_KEY_CODE_PIANO_DO
    db WORKBOY_KEY_X                         ; 'x',        // 0xBC DUCK_KEY_CODE_X
    db WORKBOY_KEY_LT                        ; '<',        // 0xBD DUCK_KEY_CODE_LESS_THAN
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBE DUCK_KEY_CODE_PIANO_RE_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xBF DUCK_KEY_CODE_PIANO_RE

    db WORKBOY_KEY_C                         ; 'c',        // 0xC0 DUCK_KEY_CODE_C
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC1 DUCK_KEY_CODE_PAGE_UP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC3 DUCK_KEY_CODE_PIANO_MI
    db WORKBOY_KEY_V                         ; 'v',        // 0xC4 DUCK_KEY_CODE_V
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC5 DUCK_KEY_CODE_PAGE_DOWN
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC6 DUCK_KEY_CODE_PIANO_FA_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC7 DUCK_KEY_CODE_PIANO_FA
    db WORKBOY_KEY_B                         ; 'b',        // 0xC8 DUCK_KEY_CODE_B
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xC9 DUCK_KEY_CODE_MEMORY_MINUS
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCA DUCK_KEY_CODE_PIANO_SOL_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCB DUCK_KEY_CODE_PIANO_SOL
    db WORKBOY_KEY_N                         ; 'n',        // 0xCC DUCK_KEY_CODE_N
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCD DUCK_KEY_CODE_MEMORY_PLUS
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCE DUCK_KEY_CODE_PIANO_LA_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xCF DUCK_KEY_CODE_PIANO_LA

    db WORKBOY_KEY_M                         ; 'm',        // 0xD0 DUCK_KEY_CODE_M
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD1 DUCK_KEY_CODE_MEMORY_RECALL
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD3 DUCK_KEY_CODE_PIANO_SI
    db WORKBOY_KEY_COMMA                     ; ',',        // 0xD4 DUCK_KEY_CODE_COMMA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD5 DUCK_KEY_CODE_SQUAREROOT
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD6 DUCK_KEY_CODE_PIANO_DO_2_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xD7 DUCK_KEY_CODE_PIANO_DO_2
    db WORKBOY_KEY_DECIMAL_POINT             ; '.',        // 0xD8 DUCK_KEY_CODE_PERIOD
    db WORKBOY_KEY_ASTERISK                  ; '*',        // 0xD9 DUCK_KEY_CODE_MULTIPLY
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDA DUCK_KEY_CODE_PIANO_RE_2_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDB DUCK_KEY_CODE_PIANO_RE_2
    db WORKBOY_KEY_NONE                      ; '-',        // 0xDC DUCK_KEY_CODE_DASH
    db WORKBOY_KEY_DOWN                      ; KEY_ARROW_DOWN,     // 0xDD DUCK_KEY_CODE_ARROW_DOWN    // TODO: Temporary
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDE DUCK_KEY_CODE_PRINTSCREEN_RIGHT
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xDF

    db WORKBOY_KEY_NONE                      ; KEY_DELETE, // 0xE0 DUCK_KEY_CODE_DELETE
    db WORKBOY_KEY_MINUS                     ; '-',        // 0xE1 DUCK_KEY_CODE_MINUS
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE2 DUCK_KEY_CODE_PIANO_FA_2_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE3 DUCK_KEY_CODE_PIANO_FA_2
    db WORKBOY_KEY_NONE                      ; '÷',        // 0xE4 DUCK_KEY_CODE_DIVIDE
    db WORKBOY_KEY_LEFT                      ; KEY_ARROW_LEFT,     // 0xE5 DUCK_KEY_CODE_ARROW_LEFT    // TODO: Temporary
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE6 DUCK_KEY_CODE_PIANO_SOL_2_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xE7 DUCK_KEY_CODE_PIANO_SOL_2
    db WORKBOY_KEY_UP                        ; KEY_ARROW_UP,     // 0xE8 DUCK_KEY_CODE_ARROW_UP    // TODO: Temporary
    db WORKBOY_KEY_EQUAL                     ; '=',        // 0xE9 DUCK_KEY_CODE_EQUALS
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEA DUCK_KEY_CODE_PIANO_LA_2_SHARP
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEB DUCK_KEY_CODE_PIANO_LA_2
    db WORKBOY_KEY_PLUS                      ; '+',        // 0xEC DUCK_KEY_CODE_PLUS
    db WORKBOY_KEY_RIGHT                     ; KEY_ARROW_RIGHT,     // 0xED DUCK_KEY_CODE_ARROW_RIGHT    // TODO: Temporary
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEE
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xEF DUCK_KEY_CODE_PIANO_MI_2

    db WORKBOY_KEY_T                         ; 't',        // 0xF0 DUCK_KEY_CODE_MAYBE_SYST_CODES_START
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF1
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF2
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF3
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF4
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF5
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF6 DUCK_KEY_CODE_MAYBE_RX_NOT_A_KEY
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF7
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF8
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xF9
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFA
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFB
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFC
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFD
    db WORKBOY_KEY_NONE                      ; NO_KEY,     // 0xFE
    db WORKBOY_KEY_NONE                      ; NO_KEY      // 0xFF
