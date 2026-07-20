
; DEF TARGET_MEGADUCK EQU 1
; include "../inc/hardware.inc"
; include "../inc/megaduck_laptop_io.inc"


; Tuck this into some free space left by removing unusual Workboy sram init code
SECTION "Duck Laptop Detect Model ROM0", ROM0[$01CE]

; This should be called on startup before tile vram gets cleared or overwritten
;
; In the case of the Workboy, it gets called immmediately on power up as the
; first code executed
; 
; Preserves NO registers
; Called immediately on startup, no need to preserve registers
duck_check_model_on_startup_wrapper_bank_0::
    ; Stack won't be set up yet, so do that first
    di
    ld   hl, $FFFE
    ld   sp, hl

    ld   a, BANK(duck_check_model)
    call duck_mbc_switch_bank_A_and_cache_banknum__and_save_current_first
    ; ld   [rMBC_ROMBANK], BANK(duck_io_keyboard_poll)

        call duck_check_model

    ; Don't actually care about restoring the bank here,
    ; it will have nonsense in it. Save a few bytes by omitting
    ;
    ; call duck_mbc_restore_saved_bank

    ; Now jump to normal code startup
    jp   startup_init__0150



; Leave section floating to be placed inside the removed
; Italian Translation section in Bank 4
SECTION "Duck Laptop Detect Model ROMX", ROMX, BANK[$4]

; ===== Laptop Model Detection =====

; Returns which MegaDuck Model the program is being run on
; 
; Possible models are:
; - Handheld: MEGADUCK_HANDHELD_STANDARD
; - Spanish Laptop "Super QuiQue": MEGADUCK_LAPTOP_SPANISH
; - German Laptop "Super Junior Computer": MEGADUCK_LAPTOP_GERMAN
;
; This detection should be called immediately at the start of the program
; for most reliable results, since it relies on inspecting uncleared VRAM
; contents.
;
; In the case of the Workboy, it gets called via the following bank 0 wrapper
; that is installed at the entry point (0x0000) and then jumps to normal startup
; after model detection is complete.
; - duck_check_model_on_startup_wrapper_bank_0
;
; It works by checking for distinct font VRAM Tile Patterns (which aren't
; cleared before cart program launch) between the Spanish and German Laptop
; models which have slightly different character sets.
;
; So VRAM *must not* be cleared or modified at program startup until after
; this function is called (not by the crt0.s, not by the program itself).
;
; Note: This detection may not work in emulators which don't simulate
;       the preloaded Laptop System ROM font tiles in VRAM.
;
DEF MEGADUCK_MODEL_TILE_ADDR_CHECK EQU $8D00  ; First tile at $8D00, Second tile at $8D10
; 2 consecutive Tiles:
; * Spanish model: Upside-down black Question Mark and Exclamation Point
; * German  model: 2 pixel tall black Underscore and Inverted 0 on dark grey background
;
; Note: It may be sufficient to just check 1 tile
duck_model_check_spanish_tiles:
db $00, $00, $18, $18, $00, $00, $38, $38, $70, $70, $72, $72, $76, $76, $3C, $3C ; Upside-down black Question Mark
db $00, $00, $18, $18, $00, $00, $18, $18, $3C, $3C, $3C, $3C, $3C, $3C, $18, $18 ; Upside-down black Exclamation Point
duck_model_check_spanish_tiles_end:
;
duck_model_check_german_tiles:
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF  ; 2 pixel tall black Underscore
db $00, $FF, $00, $C3, $00, $99, $00, $99, $00, $99, $00, $99, $00, $C3, $00, $FF  ; Inverted 0 on dark grey background
duck_model_check_german_tiles_end:
;
DEF MODEL_SPANISH_TILES_SZ  EQU (duck_model_check_spanish_tiles_end - duck_model_check_spanish_tiles)
DEF MODEL_GERMAN_TILES_SZ   EQU (duck_model_check_german_tiles_end  - duck_model_check_german_tiles)
; addr1    in BC
; addr2    in HL
; cmp_size in DE
;
; Returns in A, 1 if matched, 0 if no match
memcmp:
    .compare_loop
    ld   a, [bc]
    cp   a, [hl]
    jr   nz, .fail_nomatch

    inc  bc
    inc  hl
    dec  de

    ld   a, d
    or   e
    jr   nz, .compare_loop

    .done_match
    ld   a, 1
    ret

    .fail_nomatch
    xor  a
    ret


; Preserves all registers
; Result stored in: duck_detected_model
; No return value
duck_check_model::
    push af
    push bc
    push de
    push hl

    ldh  a, [rLCDC]
    push af  ; Cache rLCDC 
    bit  LCDCF_B_ON, a
    jr   z, .lcd_off
        call gfx__turn_off_screen_2827
    .lcd_off

    ld   bc, MEGADUCK_MODEL_TILE_ADDR_CHECK
    ld   hl, duck_model_check_spanish_tiles
    ld   de, MODEL_SPANISH_TILES_SZ
    call memcmp
    or   a
    jr   nz, .found_spanish

    ld   bc, MEGADUCK_MODEL_TILE_ADDR_CHECK
    ld   hl, duck_model_check_german_tiles
    ld   de, MODEL_GERMAN_TILES_SZ
    call memcmp
    or   a
    jr   nz, .found_german

    ; Neither spanish nor german models found, return default
    .no_match_found
    ld   a, MEGADUCK_HANDHELD_STANDARD

    .done
    ldh  [duck_detected_model], a 

    pop   af  ; Restore cached rLCDC 
    ldh  [rLCDC], a

    pop  hl    
    pop  de
    pop  bc
    pop  af
    ret

    .found_spanish
    ld   a, MEGADUCK_LAPTOP_SPANISH
    jr  .done

    .found_german
    ld   a, MEGADUCK_LAPTOP_GERMAN
    jr  .done
