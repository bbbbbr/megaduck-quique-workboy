
; DEF TARGET_MEGADUCK EQU 1
; include "../inc/hardware.inc"
; include "../inc/megaduck_laptop_io.inc"


; This location doesn't seem to conflict with
; *currently known* workboy WRAM usage (aside
; from transitory tile, etc loading).
; Placed after main duck laptop control vars
SECTION "Duck Laptop IO WRAM RTC", WRAMX[$D140]
duck_rtc::
duck_rtc_year::    db
duck_rtc_mon::     db
duck_rtc_day::     db
duck_rtc_weekday:: db
duck_rtc_ampm::    db
duck_rtc_hour::    db
duck_rtc_min::     db
duck_rtc_sec::     db


; Workboy expects:
; Seconds: BCD
; Minutes: BCD
; Hours:   BCD
; Days:    BCD, Bits .7..6 added to year
; Months:  BCD
; Years:   Decimal, years since 1900



; SECTION "Duck Laptop RTC", ROM0
;
; Leave section floating to be placed inside the removed
; Italian Translation section in Bank 4
SECTION "Duck Laptop RTC", ROMX, BANK[$4]


; Convert value in A from BCD to Decimal
; 8 bit values only
;
; Returns: Resulting decimal value in:  A
;
; Regs: Does not preserve F
bcd2dec_result_in_A::
    push bc
    ld   c, a

    ; Multiply Upper BCD digit x 10
    swap a
    and  $0F
    add  a ; N x 2
    ld   b, a ; Save (N x 2)
    add  a ; N x 4
    add  a ; N x 8
    add  a, b ; N x 10
    ld   b, a

    ; Add result to Lower BCD digit
    ld   a, c
    and  $0F
    add  b
    pop  bc
    ret


; Convert value in A from Decimal to BCD
; 8 bit values only
; Not particularly fast
;
; Returns: Resulting BCD value in: A
;
; Regs: Does not preserve F
dec2bcd_result_in_A::
    push bc

    ld   b, 0
    .divide_by_10_loop
        cp   a, 10
        jr   c, .divide_done
        sub  a, 10
        inc  b
        jr  .divide_by_10_loop

    .divide_done
    ld   c, a  ; c has remainder (input % 10)
    ld   a, b  ; b has int(input / 10)
    swap a     ; set upper BCD digit
    and  $F0   ; make sure there is nothing in lower nybble
    or   c     ; add in lower BCD digit

    pop  bc
    ret


; Request RTC data and handle the response
; Note: Raw RTC data is in BCD format
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;                      (RTC struct data not updated if polling failed)
;
; Regs: Does not preserve F
duck_io_get_rtc::

    ; Send the command and wait for the buffer reply
    ld   a, DUCK_IO_CMD_GET_RTC
    call duck_io_send_cmd_and_receive_buffer
    cp   a, DUCK_IO_OK
    jr   nz, .return_failure

    ; Make sure the received length matches
    ld   a, [duck_io_rx_buf_len]
    cp   a, DUCK_IO_LEN_RTC_GET
    jr   nz, .return_failure

    ; Year is not in BCD, it's decimal value since 1900
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_YEAR]
    ld   [duck_rtc_year], a

    ; All the remaining values are BCD (Weekday only has range of 7 values)
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_MON]
    ld   [duck_rtc_mon], a
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_DAY]
    ld   [duck_rtc_day], a
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_MON]
    ld   [duck_rtc_mon], a
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_WEEKDAY]
    ld   [duck_rtc_weekday], a

    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_AMPM]
    ld   [duck_rtc_ampm], a
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_HOUR]
    ld   [duck_rtc_hour], a
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_MIN]
    ld   [duck_rtc_min], a
    ld   a, [duck_io_rx_buf + DUCK_IO_RTC_SEC]
    ld   [duck_rtc_sec], a

    .return_success
        ld   a, DUCK_IO_OK
        ret

    .return_failure
        ld   a, DUCK_IO_FAIL
        ret


; Send RTC data to the Laptop Hardware and handle the response
; Note: Raw RTC data is in BCD format
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;                      (RTC struct data not updated if polling failed)
;
; Regs: Does not preserve F
duck_io_set_rtc::

    ; Values in BCD (Year is 2000 + BCD value)
    ;               (and for sysrom 1900 + BCD value when BCD Value > 12 and < 99)
    ld   a, [duck_rtc_year]
    ld  [duck_io_tx_buf + DUCK_IO_RTC_YEAR], a
    ld   a, [duck_rtc_mon]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_MON], a
    ld   a, [duck_rtc_day]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_DAY], a
    ld   a, [duck_rtc_weekday]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_WEEKDAY], a

    ld   a, [duck_rtc_ampm]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_AMPM], a
    ld   a, [duck_rtc_hour]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_HOUR], a
    ld   a, [duck_rtc_min]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_MIN], a
    ld   a, [duck_rtc_sec]
    ld   [duck_io_tx_buf + DUCK_IO_RTC_SEC], a


    ; Set length, then send command and buffer
    ld   a, DUCK_IO_LEN_RTC_SET
    ld   [duck_io_tx_buf_len], a
    ld   a, DUCK_IO_CMD_SET_RTC
    call duck_io_send_cmd_and_buffer

    cp   a, DUCK_IO_OK
    jr   nz, .return_failure

    .return_success
        ld   a, DUCK_IO_OK
        ret

    .return_failure
        ld   a, DUCK_IO_FAIL
        ret


