#ifndef __BYTER_VM__
#define __BYTER_VM__

#include <stdint.h>
#include <stdbool.h>

#define MEM_SIZE    4096
#define REG_COUNT   16
#define REG_L       14
#define REG_M       15
#define IO_COUNT    16


enum OP_CODE
{
    NOP,
    AND,
    OR,
    NOT,
    XOR,
    ADD,
    SUB,
    SWAP,
    RETURN,
    RETURNL,
    MOV,
    LSL,
    LSR,
    CSL,
    CSR,
    IN,
    OUT,
    CMP,
    INC,
    DEC,
    LIT,
    SETB,
    CLRB,
    PUSH,
    POP,
    PCADD,
    CALL=0x20,
    JMP=0x30,
    JC=0x40,
    JNC=0x50,
    JZ=0x60,
    JNZ=0x70,
    STORE=0x80,
    LOAD=0x90
};

enum FLAGS
{
    FL_C,
    FL_Z,
    FL_SIZE
};

typedef struct stack
{
    uint16_t data[8];
    uint8_t n;
} stack;

typedef struct byter_vm
{
    // Program Counter
    uint16_t pc; // 12 bits

    // true if continously running, false otherwise
    bool running;

    // Registers
    uint8_t reg[REG_COUNT];

    // Flags
    bool flags[FL_SIZE];

    // Memories
    uint16_t rom[MEM_SIZE];
    uint8_t ram[MEM_SIZE];

    // IO Ports
    uint8_t in_ports[IO_COUNT];
    uint8_t out_ports[IO_COUNT];

    // Stacks
    stack *pc_stack;
    stack *reg_stack;
} byter_vm;

void byter_init(byter_vm *b);
void push(stack *s, uint16_t d);
uint16_t pop(stack *s);
int byter_exec_op(byter_vm *b, uint16_t program);
int byter_exec_next(byter_vm *b);
int byter_run(byter_vm *b);
void byter_reset(byter_vm *b);
void byter_stop(byter_vm *b);
int byter_load_image_file(byter_vm *b, char *filename);

#endif