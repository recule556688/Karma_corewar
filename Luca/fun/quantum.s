.name "The Quantum"
.comment "An enhanced champion with quantum entanglement and tunneling"

start:
    live %1
    fork %:superposition
    live %1
    fork %:quantum_shield
    live %1
    fork %:tunnel
    live %1
    zjmp %:start

superposition:
    ld %0, r2
    ld %23, r3
    ld %0, r4
    ld %13, r5
    ld %7, r6

super_loop:
    ldi %:quantum_pos, r4, r7
    xor r7, r3, r7
    sti r7, r4, %0
    add r4, r3, r4
    xor r3, r5, r3
    add r3, r6, r3
    live %1
    zjmp %:super_loop

quantum_shield:
    ld %0, r8
    ld %19, r9
    ld %0, r10
    ld %5, r11

shield_loop:
    ldi %:shield_pos, r10, r12
    or r12, r9, r12
    sti r12, r10, %0
    add r10, r9, r10
    xor r9, r11, r9
    live %1
    zjmp %:shield_loop

tunnel:
    ld %0, r13
    ld %17, r14
    ld %0, r15

tunnel_loop:
    ldi %:tunnel_pos, r15, r16
    and r16, r14, r16
    sti r16, r15, %0
    add r15, r14, r15
    live %1
    zjmp %:tunnel_loop

quantum_pos:
    dat 0, 0, 0, 0

shield_pos:
    dat 0, 0, 0, 0

tunnel_pos:
    dat 0, 0, 0, 0 