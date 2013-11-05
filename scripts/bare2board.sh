#!/bin/bash


#from Elmar Melcher

#consegi rodar o hello_world pelo SPI flash.
#Usei uma DE0-nano que eu tinha comprado um tempo atrás e que usa uma
#flash M25P64 da ST Micro.
#A flash das DE0-nano compradas agora é outra, aparentemente uma
#Spansion S25FL064A mas que dá uma id falsa de 01.

#Comandos para gerar e gravar o orpsoc_hello_world.jic:


cd u-boot/examples/standalone

~/openrisc/u-boot/tools/mkimage -A or1k -T standalone -C none -a
0x40000 -e 0x40000 -n helloWorld -d hello_world.bin hello_world_uImage

bin2hex.py hello_world_uImage ~/openrisc/hello_world_uImage.hex

cd ~/openrisc

quartus_cpf -c orpsoc_hello_world.cof  (usa orpsoc.sof e bu-boot.hex
gerado pelos comandos que já lhe enviei)

quartus_pgm --mode=jtag -o pi\;orpsoc_hello_world.jic