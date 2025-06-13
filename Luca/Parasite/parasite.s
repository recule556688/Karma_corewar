.name "The Parasite"
.comment "A champion that hijacks and controls opponent processes"

start:
    live %1
    fork %:hijacker
    live %1
    fork %:controller
    live %1
    fork %:spreader
    live %1
    zjmp %:start

hijacker:
    ld %0, r2
    ld %37, r3
    ld %0, r4
    ld %61, r5

hijack_loop:
    ldi %:hijack_pos, r4, r6
    or r6, r3, r6
    sti r6, r4, %0
    add r4, r3, r4
    xor r3, r5, r3
    live %1
    zjmp %:hijack_loop

controller:
    ld %0, r7
    ld %67, r8
    ld %0, r9
    ld %71, r10

control_loop:
    ldi %:control_pos, r9, r11
    and r11, r8, r11
    sti r11, r9, %0
    add r9, r8, r9
    xor r8, r10, r8
    live %1
    fork %:control_loop
    zjmp %:control_loop

spreader:
    ld %0, r12
    ld %73, r13
    ld %0, r14

spread_loop:
    fork %:spread_loop
    live %1
    fork %:spread_loop
    live %1
    zjmp %:spread_loop

hijack_pos:
    dat 0, 0, 0, 0

control_pos:
    dat 0, 0, 0, 0