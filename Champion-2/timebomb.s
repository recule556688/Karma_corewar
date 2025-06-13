.name "The Time Bomb"
.comment "An enhanced champion with variable timing and self-repair"

start:
    live %1
    fork %:bomb_planter
    live %1
    fork %:timer
    live %1
    fork %:repair
    live %1
    zjmp %:start

bomb_planter:
    ld %0, r2
    ld %23, r3
    ld %0, r4
    ld %13, r5
    ld %7, r6

plant_loop:
    sti r1, r4, %0
    add r4, r3, r4
    xor r3, r5, r3
    add r3, r6, r3
    live %1
    zjmp %:plant_loop

timer:
    ld %0, r7
    ld %5, r8
    ld %0, r9
    ld %11, r10
    ld %3, r11

timer_loop:
    add r9, r8, r9
    live %1
    zjmp %:timer_loop
    sti r1, r9, %0
    xor r8, r10, r8
    add r8, r11, r8
    zjmp %:timer_loop

repair:
    ld %0, r12
    ld %17, r13
    ld %0, r14

repair_loop:
    ldi %:repair_pos, r14, r15
    and r15, r15, r16
    zjmp %:repair_loop
    sti r1, r15, %0
    add r14, r13, r14
    live %1
    zjmp %:repair_loop

repair_pos:
    live %0

defender:
    ld %0, r10
    ld %23, r11
    ld %0, r12

defend_loop:
    ldi %:defend_pos, r12, r13
    and r13, r13, r14
    zjmp %:defend_loop
    sti r1, r13, %0
    add r12, r11, r12
    live %1
    zjmp %:defend_loop

defend_pos:
    live %0