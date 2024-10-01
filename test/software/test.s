li a5, 0x40000000

li a4, 0x666
sw a4, 0(a5)

li a5, 0x80000000

li a4, 0x420
sw a4, 0(a5)

li a4, 0x123
sw a4, 4(a5)

ebreak
