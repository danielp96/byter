NOP

:start
// boolean
AND $L $M //comment
OR $L $M
NOT $M $M
XOR $L $M  // .14 .15
ADD $L $M
SUB $L $M
SWAP $L $L

//return
RETURN
RETURNL 0xAF

// regs
    MOV $1 $2
    LSL $1 $2
    LSR $1 $2
    CSL $1 $2
    CSR $1 $2
    IN  $1 $2
    OUT $1 $2
    CMP $1 $2
    INC $1 $1
    DEC $1 $1
    LIT 0xFA

:function
// bits
SETB 0x1 0x4
CLRB 0x1 0x4

//stack
PUSH 0xF
POP 0xF

PCADD

// address
CALL 0xF09
JMP :function
JC 0xF09
JNC 0xF09
JZ 0xF09
JNZ 0xF09

@var0 0x000

STORE @var0
LOAD @var0


@var1 0x0A1
@var2 0x0A2
@var3 0x0A3
@var4 0x0A4
@var5 0x0A5

STORE @var1
STORE @var2
STORE @var3
STORE @var4
STORE @var5

LIT .255
LIT b11110000
LIT b11111111
