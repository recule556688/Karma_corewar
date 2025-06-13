.name "The Vampire"
.comment "A champion that infects and controls other processes"

start:
    live %1
    fork %:infect
    live %1
    zjmp %:start

infect:
    ld %0, r2
    ld %23, r3
    ld %0, r4

infect_loop:
    ldi %:infect_pos, r4, r5
    sti r1, r5, %0
    add r4, r3, r4
    live %1
    fork %:infect_loop
    zjmp %:infect_loop

infect_pos:
    dat 0, 0, 0, 0 