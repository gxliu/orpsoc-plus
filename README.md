orpsoc-plus
===========

The goal of this project is to provide missing functionalities from the original
ORPSoC(OpenRISC Reference Platform System-on-Chip).

Ready to use features:
  * USB Cable to program and control the system via jtag-uart(jtag-atlantic) interface

Our first target is the board Terasic DE0-Nano(Altera's Cyclone IV FPGA)


Setup
=====
 * Download orpsoc, linux and u-boot in a directory(eg. ~/openrisc)
 * Download orpsoc-plus in the same dirlevel as orpsoc, linux, u-boot... ( ~/openrisc)
 * In the file  orpsoc/boards/altera/de0_nano/rtl/verilog/orpsoc_top/orpsoc_top.v
   (near to the line 1878) 
   replace the module name uart16550 
   to uart16550_jtag 
 * Copy the verilog from orpsoc-plus/rtl/verilog to orpsoc/rtl/verilog/uart16550
 * Compile orpsoc.sof 
 * generate a .jic: cd orpsoc-plus/bin ; make jic
 * program de0-nano: make pgm
 * disconnect USB-Cable
 * reconnect USB-Cabe
 * open nios2-terminal : You should see linux boot


People  
======
  * Elmar Uwe Kurt Melcher
     * Federal University of Campina Grande - UFCG
     * [Laboratório de Arquiteturas Dedicadas] (http://lad.dsc.ufpb.br)
  * Isaac Maia Pessoa
     * Federal University of Paraíba - UFPB
     * [Centro de Energias Alternativas e Renováveis] (http://cear.ufpb.br/~isaac) 
    
