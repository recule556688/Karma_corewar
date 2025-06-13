.name "The Scanner"
.comment "A precision hunter that finds and eliminates targets"

start:
    live %1
    fork %:scanner
    live %1
    zjmp %:start

scanner:
    ld %0, r2
    ld %19, r3
    ld %0, r4

scan_loop:
    ldi %:scan_pos, r4, r5
    and r5, r5, r6
    zjmp %:found
    add r4, r3, r4
    live %1
    zjmp %:scan_loop

found:
    sti r1, r5, %0
    live %1
    zjmp %:scan_loop

scan_pos:
    dat 0, 0, 0, 0 