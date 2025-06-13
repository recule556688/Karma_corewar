.name "The Replicator"
.comment "A champion that replicates and bombs simultaneously"

start:
    live %1
    fork %:bomber
    live %1
    fork %:replicator
    live %1
    zjmp %:start

bomber:
    ld %0, r2
    ld %17, r3
    ld %0, r4

bomb_loop:
    sti r1, r4, %0
    add r4, r3, r4
    live %1
    zjmp %:bomb_loop

replicator:
    live %1
    fork %:replicator
    live %1
    zjmp %:replicator 