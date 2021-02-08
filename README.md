# avr-assembler-optiboot

Optiboot bootloader for AVR processors in assembler language, which can be used  for nearly any AVR processor.

You should download the optiboot path to your local computer and change to the optiboot
directory as your working directory in the command terminal.
The build process is done with a bash script file, which is controlled by a Makefile.
So you can simply generate a standard bootloader for a ATmega328 with the command:

make atmega328

You will get a file with the name optiboot_atmega328.hex and also a optiboot_atmega328.lst and optiboot_atmega328.log.
The length of this optiboot example is 488 bytes, which fit into one bootpage.
You can read in the first line of the screen log, that this optiboot is configured 
for 16.00 MHz operation with Baudrate 115200 and EEprom support.

The most important information for a user is how the bootloader program gets into the ATmega328. 
You can tell with the make call, that you want to program the target with:

make atmega328 ISP=1

Before you use this call, you need a ISP programmer, which is well connected to your PC and the target ATmega328.
You should also know, which interface is used for the programmer access.
With a Linux system the script file helps you finding a serial port, if the access fail.

If you find the right port you can add the ISPPORT= setting to the last make call,
for example "make atmega328 ISP=1 ISPPORT=/dev/ttyUSB0".
Some ISP programmers like AVRISPmkII use a special USB protocol which can be used with a ISPPORT=usb setting.
Getting the programmer up and running is the greatest difficulty for installing the bootloader.
But the advantage is, that the installation steps are done automatically 
and prevents you from stepping into one of the many pitfalls.
So it is highly recommended to find no other way to install your optiboot bootloader (.hex file),
you should use the ISP=1 setting instead.

All of the build process runs best with a Linux system.
Windows 10 can be used only, if you install additional packages like Cygwin64.

Probably you should first read the Wiki pages or the full PDF documentation to learn more about
usage and alternative configurations.
