.name "The Annihilator"
.comment "A champion that uses extreme memory manipulation"

start:
    live %1
    fork %:destroyer
    live %1
    fork %:manipulator
    live %1
    fork %:annihilator
    live %1
    zjmp %:start

destroyer:
    ld %0, r2
    ld %79, r3
    ld %0, r4
    ld %83, r5

destroy_loop:
    ldi %:destroy_pos, r4, r6
    xor r6, r3, r6
    sti r6, r4, %0
    add r4, r3, r4
    xor r3, r5, r3
    live %1
    fork %:destroy_loop
    zjmp %:destroy_loop

manipulator:
    ld %0, r7
    ld %89, r8
    ld %0, r9
    ld %97, r10

manipulate_loop:
    ldi %:manipulate_pos, r9, r11
    and r11, r8, r11
    sti r11, r9, %0
    add r9, r8, r9
    xor r8, r10, r8
    live %1
    fork %:manipulate_loop
    zjmp %:manipulate_loop

annihilator:
    ld %0, r12
    ld %101, r13
    ld %0, r14

annihilate_loop:
    fork %:annihilate_loop
    live %1
    fork %:annihilate_loop
    live %1
    zjmp %:annihilate_loop

destroy_pos:
    dat 0, 0, 0, 0

manipulate_pos:
    dat 0, 0, 0, 0