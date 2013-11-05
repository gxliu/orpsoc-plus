#!/bin/bash

# rm linux/vmlinux.bin.gz orpsoc.jic
# make -C linux -j3
# make -C u-boot -j3
or32-elf-objcopy -O binary vmlinux vmlinux.bin
gzip linux/vmlinux.bin
u-boot/tools/mkimage -A or1k -T kernel -C gzip -a 0 -e 0x100 -d linux/vmlinux.bin.gz uImage.bin
make -C ~/openrisc/orpsoc/sw/utils
orpsoc/sw/utils/bin2binsizeword u-boot/u-boot.bin bu-boot.bin
# pegar http://www.bialix.com/intelhex/manual/part1-3.html
bin2hex.py uImage.bin uImage.hex
bin2hex.py bu-boot.bin bu-boot.hex
cp orpsoc/boards/altera/de0_nano/syn/quartus/run/orpsoc.sof ./
quartus_cpf -c orpsoc.cof
quartus_pgm --mode=jtag -o pi\;orpsoc.jic