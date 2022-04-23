#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

#include "byter.h"


void byter_init(byter_vm *b)
{
    stack pc_stack;
    stack reg_stack;

    b->pc_stack = &pc_stack;
    b->reg_stack = &reg_stack;

    for (int i = 0; i<IO_COUNT; i++)
    {
        b->in_ports[i] = 0;
        b->out_ports[i] = 0;
    }

    for (int i = 0; i < REG_COUNT; ++i)
    {
        b->reg[i] = 0;
    }

    for (int i = 0; i < MEM_SIZE; ++i)
    {
        b->rom[i] = 0;
        b->ram[i] = 0;
    }
}

void push(stack *s, uint16_t d)
{
    s->data[s->n] = d;
    s->n = s->n + 1;
}

uint16_t pop(stack *s)
{
    s->n = s->n - 1;
    return s->data[s->n];
}

// execute instruction program in byter pointed at by b
int byter_exec_op(byter_vm *b, uint16_t program)
{
    uint8_t instr = program >> 8;
    uint8_t oprnd = program & 0x00FF;

    uint8_t rd = oprnd >> 4;
    uint8_t rr = oprnd & 0x0F;
    bool temp = false;

    switch(instr)
    {
        case NOP:
            b->pc++;

            break;

        case AND:
            b->reg[rd] = b->reg[rd] & b->reg[rr];

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case OR:
            b->reg[rd] = b->reg[rd] | b->reg[rr];

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case NOT:
            b->reg[rd] = ~b->reg[rr];

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case XOR:
            b->reg[rd] = b->reg[rd] ^ b->reg[rr];

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case ADD:
            b->flags[FL_C] = (b->reg[rd] + b->reg[rr]) > 0xFF? true: false;

            b->reg[rd] = b->reg[rd] + b->reg[rr];

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case SUB:
            b->flags[FL_C] = (b->reg[rd] - b->reg[rr]) < 0? true: false;

            b->reg[rd] = b->reg[rd] - b->reg[rr];

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case SWAP:

            b->reg[rd] = (b->reg[rr] >> 4) | ((b->reg[rr] << 4)& 0xF0);
            
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case RETURN:
            b->pc = pop(b->pc_stack);

            break;

        case RETURNL:
            b->pc = pop(b->pc_stack);

            b->reg[REG_L] = oprnd;

            break;

        case MOV:
            b->reg[rd] = b->reg[rr];

            b->pc++;

            break;

        case LSL:
            b->reg[rd] = ((b->reg[rr] << 1) & 0xFE) | ((b->reg[rr] >> 7) & 0x01);
            
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case LSR:
            b->reg[rd] = ((b->reg[rr] >> 1) & 0x7F) | ((b->reg[rr] << 7) & 0x80);
            
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case CSL:
            temp = b->flags[FL_C];

            b->flags[FL_C] = (b->reg[rr] >> 7) & 0x01;

            b->reg[rd] = ((b->reg[rr] << 1) & 0xFE) | (temp & 0x01);
            
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case CSR:
            temp = b->flags[FL_C];

            b->flags[FL_C] = b->reg[rr] & 0x01;

            b->reg[rd] = ((b->reg[rr] >> 1) & 0x7F) | ((temp << 7) & 0x80);
            
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case IN:
            b->reg[rd] = b->in_ports[rr];
            b->flags[FL_Z] = !b->reg[rd];
            b->pc++;
            break;

        case OUT:
            b->out_ports[rd] = b->reg[rr];
            b->pc++;
            break;

        case CMP:
            b->flags[FL_C] = b->reg[rr] > b->reg[rd];
            b->flags[FL_Z] = b->reg[rr] == b->reg[rd];
            break;

        case INC:
            b->flags[FL_C] = b->reg[rr] == 0xFF;

            b->reg[rd] = b->reg[rr] + 1;

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case DEC:
            b->flags[FL_C] = b->reg[rr] == 0x00;
            
            b->reg[rd] = b->reg[rr] - 1;

            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case LIT:
            b->reg[REG_L] = oprnd;
            b->flags[FL_Z] = !b->reg[REG_L];

            b->pc++;

            break;

        case SETB:

            b->reg[rd] |=  0x01 << (rr & 0x7);
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case CLRB:

            b->reg[rd] &= ~(0x01 << (rr & 0x7));
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case PUSH:

            push(b->reg_stack, b->reg[rr]);

            b->pc++;

            break;

        case POP:

            b->reg[rd] = pop(b->reg_stack);
            b->flags[FL_Z] = !b->reg[rd];

            b->pc++;

            break;

        case PCADD:

            b->pc += ((b->reg[13] << 8) | b->reg[12]) & 0x0FFF;

            b->pc++;

            break;

    }

    switch (instr & 0xF0)
    {
        case CALL:
            push(b->pc_stack, b->pc+1);
            b->pc = program & 0x0FFF;

            break;

        case JMP:
            b->pc = program & 0x0FFF;
            break;

        case JC:
            b->pc = b->flags[FL_C]? program & 0x0FFF: b->pc +1;

            break;

        case JNC:
            b->pc = !b->flags[FL_C]? program & 0x0FFF: b->pc +1;

            break;

        case JZ:
            b->pc = b->flags[FL_Z]? program & 0x0FFF: b->pc +1;

            break;

        case JNZ:
            b->pc = !b->flags[FL_Z]? program & 0x0FFF: b->pc +1;

            break;

        case STORE:
            b->ram[program & 0x0FFF] = b->reg[REG_M];
            b->pc++;

            break;

        case LOAD:
            b->reg[REG_M] = b->ram[program & 0x0FFF];
            b->pc++;

            break;

        default:
            return 1;
    }

    return 0;
}

// execute next instruction in rom in byter pointed at by b
int byter_exec_next(byter_vm *b)
{
    return byter_exec_op(b, b->rom[b->pc & 0x0FFF]);
}

// continously execute instructions until error or stopped
int byter_run(byter_vm *b)
{
    b->running = true;

    int er = 0;

    while (b->running)
    {
        er = byter_exec_next(b);

        if (er)
        {
            byter_stop(b);
            printf("ERROR: Invalid op at %03X\n", b->pc & 0x0FFF);
            return er;
        }
    }
}

void byter_stop(byter_vm *b)
{
    b->running = false;
}

void byter_reset(byter_vm *b)
{

    b->pc_stack->n = 0;
    b->reg_stack->n = 0;

    b->pc = 0;

    for (int i = 0; i<IO_COUNT; i++)
    {
        b->in_ports[i] = 0;
        b->out_ports[i] = 0;
    }

    for (int i = 0; i < REG_COUNT; ++i)
    {
        b->reg[i] = 0;
    }

    for (int i = 0; i < MEM_SIZE; ++i)
    {
        b->rom[i] = 0;
        b->ram[i] = 0;
    }
}


int byter_load_image_file(byter_vm *b, char *filename)
{
    FILE* file = fopen(filename, "rb");

    if (file == NULL)
    {
        exit(1);
    }

    fread(b->rom, sizeof(uint16_t), MEM_SIZE, file);

    // fix endianess
    for (int i = 0; i<MEM_SIZE; i++)
    {
        b->rom[i] = (b->rom[i] >> 8) | ((b->rom[i] << 8 )& 0xFF00);
    }

    fclose(file);
}


