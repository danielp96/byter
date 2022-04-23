#include <stdio.h>
#include <stdlib.h>

#include "byter.h"

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("byter-vm [image-file]\n");
        exit(1);
    }

    byter_vm byter;

    byter_init(&byter);

    if (byter_load_image_file(&byter, argv[1]))
    {
        printf("Failed to open file.\n");
        exit(2);
    }


    printf("PC     PROGRAM INSTR   OPRND    C  Z  RL  RM   IN_0    OUT_0   RAM_0\n");

    byter.in_ports[0] = 0x42;

    byter_exec_op(&byter, 0x14AA);
    printf("%03X\t%04X\t%02X\t%02X", byter.pc, byter.rom[byter.pc & 0x0FFF], byter.rom[byter.pc & 0x0FFF] >> 8, byter.rom[byter.pc & 0x0FFF] & 0x00FF);
    printf("\t%X  %X  %02X  %02X\t%02X\t%02X\t%02X\n", byter.flags[FL_C], byter.flags[FL_Z], byter.reg[14], byter.reg[15], byter.in_ports[0], byter.out_ports[0], byter.ram[0]);

    byter_exec_op(&byter, 0x0AFE);
    printf("%03X\t%04X\t%02X\t%02X", byter.pc, byter.rom[byter.pc & 0x0FFF], byter.rom[byter.pc & 0x0FFF] >> 8, byter.rom[byter.pc & 0x0FFF] & 0x00FF);
    printf("\t%X  %X  %02X  %02X\t%02X\t%02X\t%02X\n", byter.flags[FL_C], byter.flags[FL_Z], byter.reg[14], byter.reg[15], byter.in_ports[0], byter.out_ports[0], byter.ram[0]);

    byter_exec_op(&byter, 0x8000);
    printf("%03X\t%04X\t%02X\t%02X", byter.pc, byter.rom[byter.pc & 0x0FFF], byter.rom[byter.pc & 0x0FFF] >> 8, byter.rom[byter.pc & 0x0FFF] & 0x00FF);
    printf("\t%X  %X  %02X  %02X\t%02X\t%02X\t%02X\n", byter.flags[FL_C], byter.flags[FL_Z], byter.reg[14], byter.reg[15], byter.in_ports[0], byter.out_ports[0], byter.ram[0]);

    exit(0);
}
