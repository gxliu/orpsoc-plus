JIC=orpsoc.jic
UBOOT_DIR=../../u-boot
ORPSOC_DIR=../../orpsoc
LINUX_DIR=../../linux

jic: linuxjic

linuxjic:
	$(UBOOT_DIR)/tools/mkimage -A or1k -T kernel -C gzip -a 0 -e 0x100 -d $(LINUX_DIR)/vmlinux.bin.gz uImage.bin
	$(ORPSOC_DIR)/sw/utils/bin2binsizeword $(UBOOT_DIR)/u-boot.bin bu-boot.bin
	bin2hex.py uImage.bin uImage.hex
	bin2hex.py bu-boot.bin bu-boot.hex
	cp $(ORPSOC_DIR)/boards/altera/de0_nano/syn/quartus/run/orpsoc.sof .
	cp ../scripts/cof/orpsoc_linux.cof .
	quartus_cpf -c orpsoc_linux.cof


#TODO: this rule in incomplete
barejic:
	$(UBOOT_DIR)/tools/mkimage -A or1k -T standalone -C none -a 0x40000 -e 0x40000 -n helloWorld -d hello_world.bin hello_world_uImage
	bin2hex.py hello_world_uImage hello_world_uImage.hex
	cp $(ORPSOC_DIR)/boards/altera/de0_nano/syn/quartus/run/orpsoc.sof .
	quartus_cpf -c ../scripts/cof/orpsoc_hello_world.cof 
	quartus_pgm --mode=jtag -o pi\;orpsoc_hello_world.jic


pgm:
	quartus_pgm --mode=jtag -o pi\;$(JIC)