read_me:
----------------
RISCV_TOP.v 
top module is consist from 

1-DATA_PATH_TOP.v
	it is consist from
		-REG_FILE.v=> its testbench is REG_FILE_TB.v
		-ADDER_4.v
		-ALU_RSIC.v=>its testbench is "ALU_RSIC_TB.v"
		-BRANCH_COMP.v =>its testbench is BRANCH_COMP.v_TB
		-DATA_memory.v
		-IMM_GENRATOR.v
		-INST_memmory.v =>testing using simulation 
		-MUX_2.v
		-MUX_4.v
		-PC.v =>its testbench is PC_REG_TB.v
		 
2-CONTROL_UNIT.v
------------------------------------------------------------------------------------------------
assempley_code:
------------------
.data
.word 2, 4, 6, 8
n: .word 9

.text
main:   add     t0, x0, x0
        addi    t1, x0, 1
        la      t3, n
        lw      t3, 0(t3)
fib:    beq     t3, x0, finish
        add     t2, t1, t0
        mv      t0, t1
        mv      t1, t2
        addi    t3, t3, -1
        j       fib
finish: addi    a0, x0, 1
        addi    a1, t0, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall

---------------------------------
machine_code:
-------------
0x000002B3
0x00100313
0x10000E17
0x008E0E13
0x000E2E03
0x000E0C63
0x005303B3
0x00030293
0x00038313
0xFFFE0E13
0xFEDFF06F
0x00100513
0x00028593
0x00000073
0x00A00513
0x00000073
