.name "The Mirror"
.comment "An enhanced champion with adaptive reflection and counter-attack"

start:
    live %1
    fork %:reflector
    live %1
    fork %:protector
    live %1
    fork %:counter
    live %1
    zjmp %:start

reflector:
    ld %0, r2
    ld %17, r3
    ld %0, r4
    ld %13, r5
    ld %7, r6

reflect_loop:
    ldi %:reflect_pos, r4, r7
    sti r7, r4, %0
    add r4, r3, r4
    xor r3, r5, r3
    add r3, r6, r3
    live %1
    zjmp %:reflect_loop

protector:
    ld %0, r8
    ld %19, r9
    ld %0, r10
    ld %5, r11

protect_loop:
    ldi %:protect_pos, r10, r12
    and r12, r12, r13
    zjmp %:protect_loop
    sti r1, r12, %0
    add r10, r9, r10
    xor r9, r11, r9
    live %1
    zjmp %:protect_loop

counter:
    ld %0, r14
    ld %23, r15
    ld %0, r16

counter_loop:
    ldi %:counter_pos, r16, r17
    or r17, r15, r17
    sti r17, r16, %0
    add r16, r15, r16
    live %1
    zjmp %:counter_loop

reflect_pos:
    dat 0, 0, 0, 0

protect_pos:
    dat 0, 0, 0, 0

counter_pos:
    dat 0, 0, 0, 0