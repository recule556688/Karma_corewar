.name "The Chaos"
.comment "A champion that corrupts memory and floods processes"

start:
    live %1
    fork %:corruptor
    live %1
    fork %:flooder
    live %1
    fork %:chaos_engine
    live %1
    zjmp %:start

corruptor:
    ld %0, r2
    ld %47, r3
    ld %0, r4
    ld %53, r5

corrupt_loop:
    ldi %:corrupt_pos, r4, r6
    xor r6, r3, r6
    sti r6, r4, %0
    add r4, r3, r4
    xor r3, r5, r3
    live %1
    zjmp %:corrupt_loop

flooder:
    ld %0, r7
    ld %41, r8
    ld %0, r9

flood_loop:
    fork %:flood_loop
    live %1
    fork %:flood_loop
    live %1
    zjmp %:flood_loop

chaos_engine:
    ld %0, r10
    ld %43, r11
    ld %0, r12
    ld %59, r13

chaos_loop:
    ldi %:chaos_pos, r12, r14
    and r14, r11, r14
    sti r14, r12, %0
    add r12, r11, r12
    xor r11, r13, r11
    live %1
    fork %:chaos_loop
    zjmp %:chaos_loop

corrupt_pos:
    dat 0, 0, 0, 0

chaos_pos:
    dat 0, 0, 0, 0 