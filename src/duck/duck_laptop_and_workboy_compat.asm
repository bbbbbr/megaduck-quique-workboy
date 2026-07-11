; Read Mega Duck RTC data and translate into Workboy RTC format
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;                      (RTC struct data not updated if polling failed)
;
; Regs: Does not preserve F
duck_rtc_read__translate_to_workboy_siobuffer::

    call duck_io_get_rtc
    cp   a, DUCK_IO_OK
    jr   nz, .return_failure

    ; Load the Megaduck rtc data into the expected Workboy BCD formatted RTC buffer
    ;
    ; [2] = Seconds BCD
    ld   a, [duck_rtc_sec]
    ld   [sioxfer_time__seconds__BCD__RAM_C2B0], a

    ; [3] = Minutes BCD
    ld   a, [duck_rtc_min]
    ld   [sioxfer_time__minutes__BCD__RAM_C2B1], a

    ; [4] = Hours BCD
    ; Translate MegaDuck AM/PM style to Workboy 24 hour style
    ld   a, [duck_rtc_ampm]
    jr   z, .am
    .pm
        ld   a, [duck_rtc_hour]
        add  a, $12
        daa  ; BCD add correction
        jr   .ampmdone
    .am
        ld   a, [duck_rtc_hour]
    .ampmdone
    ld   [sioxfer_time__hours__BCD__RAM_C2B2], a

    ; [5] = Day BCD
    ld   a, [duck_rtc_day]
    ld   [sioxfer_time__days__RAM_C2B3], a

    ; [6] = Month BCD + DoW packed        
    push bc
    ; Pack DoW into upper 3 bits
    ld   a, [duck_rtc_weekday]
    swap a ; << 4
    add  a ; << 1
    ld   c, a
    ; Add Month
    ld   a, [duck_rtc_mon]
    add  c
    ld   [sioxfer_time__month__RAM_C2B4], a
    pop  bc        

    ; [F] = Year, decimal (same for Megaduck RTC)
    ld   a, [duck_rtc_year]
    ; MegaDuck RTC stores year as BCD since 2000 (if >= 2000) or since 1900 (if < 2000)
    ; Workboy stores year as DEC since 1900
    ; So convert and add 100 years
    ; (Don't support years < 2000)
    ; (Also duck system rom doesn't support setting year > 2011 due to missing leap year tables)
    call bcd2dec_result_in_A
    add  a, 100
    ld   [sioxfer_time__year__RAM_C2BD], a

    ; Refresh the MegaDuck laptop rtc valid key in WRAM in case it's been overwritten
    ; to try and avoid causing the system rom to reset the RTC
    call duck_io_set_laptop_sysrom_rtc_wram_valid_keys


    .return_success
        call delay_2_94msec__334A
        ld   a, DUCK_IO_OK
        ret

    .return_failure
        call delay_2_94msec__334A
        ld   a, DUCK_IO_FAIL
        ret


; Translate Workboy RTC data into Mega Duck format and send to Laptop Hardware
;
; Returns: Status in:  A (DUCK_IO_OK or DUCK_IO_FAIL)
;                      (RTC struct data not updated if polling failed)
;
; Regs: Does not preserve F
duck_rtc_write__translate_from_workboy_siobuffer::
    ; Pick out the relevant workboy rtc bytes
    ; and reformat them into the megaduck rtc buffer
    ;
    ; [2] = Seconds BCD
    ld   a, [sioxfer_time__seconds__BCD__RAM_C2B0]
    ld   [duck_rtc_sec], a

    ; [3] = Minutes BCD
    ld   a, [sioxfer_time__minutes__BCD__RAM_C2B1]
    ld   [duck_rtc_min], a

    ; [4] = Hours BCD
    ; Translate Workboy 24 hour style -> MegaDuck AM/PM style
    ld   a, [sioxfer_time__hours__BCD__RAM_C2B2]
    cp   $12   ; if (hour < 12) then -> AM
    jr   c, .am
    .pm
        sub  a, $12
        daa  ; BCD sub correction
        ld   [duck_rtc_hour], a

        ld   a, DUCK_RTC_PM
        jr .ampmload
    .am
        ld   [duck_rtc_hour], a
        ld   a, DUCK_RTC_AM
    .ampmload
    ld   [duck_rtc_ampm], a

    ; [5] = Day BCD
    ld   a, [sioxfer_time__days__RAM_C2B3]
    ld   [duck_rtc_day], a

    ; [6] = Month BCD
    ; Easier to pull Month from standalone var instead of packed [Month + DoW]
    ; ld   a, [sioxfer_time__month__RAM_C2B4]
    ld   a, [date__month__decimal__maybe__RAM_C138]
    ld   [duck_rtc_mon], a

    ; [F] = Year, decimal (Megaduck RTC is BCD)
    ;
    ; MegaDuck RTC stores year as BCD since 2000 (if >= 2000) or since 1900 (if < 2000)
    ; Workboy stores year as DEC since 1900
    ; So subtract 100 years and convert
    ; (Don't support years < 2000)
    ; (Also duck system rom doesn't support setting year > 2011 due to missing leap year tables)
    ld   a, [sioxfer_time__year__RAM_C2BD]
    sub  a, 100
    call dec2bcd_result_in_A    
    ld   [duck_rtc_year], a

    ; Easier to pull Day of Week from standalone var instead of packed [Month + DoW]
    ; Workboy and Mega Duck use same style (0-6 = sun-sat)
    ld  a, [date__dayofweek_0_to_6_sun_to_mon__decimal__RAM_C304]
    ld  [duck_rtc_weekday], a

    ; Now send the RTC command
    call duck_io_set_rtc

    ; Refresh the MegaDuck laptop rtc valid key in WRAM in case it's been overwritten
    ; to try and avoid causing the system rom to reset the RTC
    call duck_io_set_laptop_sysrom_rtc_wram_valid_keys

    call delay_2_94msec__334A

    ; cp   a, DUCK_IO_OK
    ; Result in A from above call is return value
    ;
    ; Force always returning success (upstream calling code may permaloop if not)
    ld   a, DUCK_IO_OK
    ret
