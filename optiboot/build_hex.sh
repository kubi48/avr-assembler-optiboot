#!/bin/bash

# VerboseLev  1 = minimal output to screen
#             2 = only the main avr-gcc call is shown
#             3 = the main tasks are shown
#             4 = nearly all tasks are shown

MYLANG=`echo ${LANGUAGE} | cut -c 1-3`
# replace 1M to 20M with 1000000 to 20000000
if [ "${AVR_FREQ}" = "1M" ] ; then
 export AVR_FREQ=1000000
fi
if [ "${AVR_FREQ}" = "2M" ] ; then
 export AVR_FREQ=2000000
fi
if [ "${AVR_FREQ}" = "3M" ] ; then
 export AVR_FREQ=3000000
fi
if [ "${AVR_FREQ}" = "4M" ] ; then
 export AVR_FREQ=4000000
fi
if [ "${AVR_FREQ}" = "5M" ] ; then
 export AVR_FREQ=5000000
fi
if [ "${AVR_FREQ}" = "6M" ] ; then
 export AVR_FREQ=6000000
fi
if [ "${AVR_FREQ}" = "7M" ] ; then
 export AVR_FREQ=7000000
fi
if [ "${AVR_FREQ}" = "8M" ] ; then
 export AVR_FREQ=8000000
fi
if [ "${AVR_FREQ}" = "9M" ] ; then
 export AVR_FREQ=9000000
fi
if [ "${AVR_FREQ}" = "10M" ] ; then
 export AVR_FREQ=10000000
fi
if [ "${AVR_FREQ}" = "11M" ] ; then
 export AVR_FREQ=11000000
fi
if [ "${AVR_FREQ}" = "12M" ] ; then
 export AVR_FREQ=12000000
fi
if [ "${AVR_FREQ}" = "13M" ] ; then
 export AVR_FREQ=13000000
fi
if [ "${AVR_FREQ}" = "14M" ] ; then
 export AVR_FREQ=14000000
fi
if [ "${AVR_FREQ}" = "15M" ] ; then
 export AVR_FREQ=15000000
fi
if [ "${AVR_FREQ}" = "16M" ] ; then
 export AVR_FREQ=16000000
fi
if [ "${AVR_FREQ}" = "17M" ] ; then
 export AVR_FREQ=17000000
fi
if [ "${AVR_FREQ}" = "18M" ] ; then
 export AVR_FREQ=18000000
fi
if [ "${AVR_FREQ}" = "19M" ] ; then
 export AVR_FREQ=19000000
fi
if [ "${AVR_FREQ}" = "20M" ] ; then
 export AVR_FREQ=20000000
fi
if [ "${VerboseLev}" = "" ] ; then
  #define the default VerboseLev value in this script
  VerboseLev=2
fi
#set colors for terminal output
source ./def_colors.sh

if [ "${PROGRAM}" = "" ] ; then
 PROGRAM="optiboot"
fi

if (( 0${LED_DATA_FLASH} > 0 )) ; then
 # force to disable START_FLASH
  if (( 0${LED_START_FLASHES} > 0 )) ; then
   if (( ${VerboseLev} > 1 )) ; then 
    if [ "${MYLANG}" == "de_" ] ; then
      echo ">> ${Vgelb}LED_START_FLASHES${Vnormal} abgeschaltet weil LED_DATA_FLASH gesetzt ist!!"
    else
      echo ">> ${Vgelb}LED_START_FLASHES${Vnormal} disabled because LED_DATA_FLASH is set!!"
    fi
   fi
  fi
 LED_START_FLASHES=0
fi

if [ "${LED_START_FLASHES}" = "" ] ; then
 LED_START_FLASHES=3
fi

if [ "${C_SOURCE}" = "" ] || (( ${C_SOURCE}0 == 0 )) ; then
 SOURCE_TYPE="S"
 if [ "${SUPPORT_EEPROM}" = "" ] ; then
  SUPPORT_EEPROM=1
 fi
else
 SOURCE_TYPE="c"
 if [ "${SUPPORT_EEPROM}" = "" ] ; then
  SUPPORT_EEPROM=0
 fi
fi

if [ "${MCU_TARGET}" = "" ] ; then
 MCU_TARGET="${TARGET}"
fi
source get_avr_params.sh

VersionAdr=`echo "obase=16;${FLASH_SIZE}-2" | bc`
LIBS="-lc"
LDSECTIONS="-Wl,--section-start=.version=0x${VersionAdr}"


LOGFILE="${PROGRAM}_${TARGET}.log"
AVR_MHZ="(`echo "scale=2;${AVR_FREQ} / 1000000" | bc` Mhz)"
if [ "${MYLANG}" == "de_" ] ; then
 FREQ_OPER="Optiboot für ${Vgelb}${AVR_FREQ} Hz ${AVR_MHZ} Betrieb${Vnormal}"
else
 FREQ_OPER="Optiboot for ${Vgelb}${AVR_FREQ} Hz ${AVR_MHZ} operation${Vnormal}"
fi
if [ "${MYLANG}" == "de_" ] ; then
 EE_SUPPORT=" und ${Vinv}EEprom Unterstützung${Vnormal} konfiguriert."
else
 EE_SUPPORT=" and ${Vinv}EEprom support${Vnormal} configured."
fi
echo "###############################" > ${LOGFILE}
echo "Build of ${FREQ_OPER}" >> ${LOGFILE}

echo " "

if (( ${BAUD_RATE} < 100 )) ; then
 if (( ${SUPPORT_EEPROM}0 == 0 )) ; then
  if [ "${MYLANG}" == "de_" ] ; then
   echo "${FREQ_OPER} mit ${Vgelb}automatischer Baudrate${Vnormal} konfiguriert."
  else
   echo "${FREQ_OPER} with ${Vgelb}Auto-Baudrate${Vnormal} configured."
  fi
 else
  if [ "${MYLANG}" == "de_" ] ; then
   echo "${FREQ_OPER} mit ${Vgelb}automatischer Baudrate${Vnormal}${EE_SUPPORT}"
  else
   echo "${FREQ_OPER} with ${Vgelb}Auto-Baudrate${Vnormal}${EE_SUPPORT}"
  fi
 fi
 if (( ${BAUD_RATE} < 20 )) || (( ${BAUD_RATE} > 59 )) ; then
  if (( ${LED_START_FLASHES} < -1 )) ; then
   if [ "${MYLANG}" == "de_" ] ; then
    echo "Ohne Überwachung der seriellen Empfangsdaten die LED bitte nur einmal blinken lassen!"
   else
    echo "Without monitoring the serial input you should flash the LED only once!"
   fi
  fi
  if (( ${LED_START_FLASHES} > 2 )) ; then
   if [ "${MYLANG}" == "de_" ] ; then
    echo "Bei dieser Autobaud Betriebsart sollten Sie die LED bitte nur maximal 2x blinken lassen!"
   else
    echo "With this Autobaud operating mode you should only let the LED flash a maximum of 2 times!"
   fi
  fi
 fi
else
 if (( ${SUPPORT_EEPROM}0 == 0 )) ; then
  if [ "${MYLANG}" == "de_" ] ; then
   echo "${FREQ_OPER} mit ${Vgelb}Baudrate ${BAUD_RATE}${Vnormal} konfiguriert."
  else
   echo "${FREQ_OPER} with ${Vgelb}Baudrate ${BAUD_RATE}${Vnormal} configured."
  fi
 else
  if [ "${MYLANG}" == "de_" ] ; then
   echo "${FREQ_OPER} mit ${Vgelb}Baudrate ${BAUD_RATE}${Vnormal}${EE_SUPPORT}"
  else
   echo "${FREQ_OPER} with ${Vgelb}Baudrate ${BAUD_RATE}${Vnormal}${EE_SUPPORT}"
  fi
 fi
fi

if [ "${MYLANG}" == "de_" ] ; then
 echo " >>> Starte: optiboot für AVR ${MCU_TARGET} erstellen"
else
 echo " >>> Start building optiboot for AVR ${MCU_TARGET}:"
fi

source avr_family.sh  ; #build a name for AVR_FAMILY from MCU_TARGET

# set all required values and also the default values

if [ "${LED_START_FLASHES}" = "" ] ; then
  LED_START_FLASHES=3
fi
if [ "${TEST_OUTPUT}" = "" ] ; then
  TEST_OUTPUT=0
fi
if [ "${INVERSE_UART}" = "" ] ; then
  INVERSE_UART=0
fi
if [ "${BIGBOOT}" = "" ] ; then
  BIGBOOT=0
fi

# the pin for LED should be known or set in the avr_pins/${AVR_FAMILY}.pins.
source show_led_pin.sh

OPTIMIZE="-Os -fno-split-wide-types -mrelax"
CFLAGS="-g -Wall -Os -fno-split-wide-types -mrelax -mmcu=${MCU_TARGET} ${DEFS} -fno-diagnostics-show-caret"
COMMON_OPTIONS="-DBAUD_RATE=${BAUD_RATE} -DLED_START_FLASHES=${LED_START_FLASHES}"
if [ "${LED_DATA_FLASH}" != "" ] ; then
  COMMON_OPTIONS="${COMMON_OPTIONS} -DLED_DATA_FLASH=${LED_DATA_FLASH}"
fi
if [ "${TIMEOUT_MS}" != "" ] ; then
  COMMON_OPTIONS="${COMMON_OPTIONS} -DTIMEOUT_MS=${TIMEOUT_MS}"
fi
if [ "${OSCCAL_CORR}" != "" ] ; then
  COMMON_OPTIONS="${COMMON_OPTIONS} -DOSCCAL_CORR=${OSCCAL_CORR}"
fi
XTRA_OPTIONS="-DSUPPORT_EEPROM=${SUPPORT_EEPROM}"
if (( ${TEST_OUTPUT} != 0 )) ; then
  XTRA_OPTIONS="${XTRA_OPTIONS} -DTEST_OUTPUT=1"
fi
if (( ${INVERSE_UART} != 0 )) ; then
  XTRA_OPTIONS="${XTRA_OPTIONS} -DINVERSE_UART=1"
fi
if (( ${BIGBOOT} != 0 )) ; then
  XTRA_OPTIONS="${XTRA_OPTIONS} -DBIGBOOT=${BIGBOOT}"
fi
if [ "${FORCE_WATCHDOG}" != "" ] ; then
  XTRA_OPTIONS="${XTRA_OPTIONS} -DFORCE_WATCHDOG=1"
fi
if [ "${FORCE_RSTDISBL}" != "" ] ; then
  XTRA_OPTIONS="${XTRA_OPTIONS} -DFORCE_RSTDISBL=1"
fi
if [ "${WRITE_PROTECT_PIN}" != "" ] ; then
	XTRA_OPTIONS="${XTRA_OPTIONS} -DWRITE_PROTECT_PIN=p${WRITE_PROTECT_PIN}"
fi
if [ "${NO_EARLY_PAGE_ERASE}" != "" ] ; then
	XTRA_OPTIONS="${XTRA_OPTIONS} -DNO_EARLY_PAGE_ERASE=${NO_EARLY_PAGE_ERASE}"
fi
if [ "${TWO_STOP_BITS}" != "" ] ; then
	XTRA_OPTIONS="${XTRA_OPTIONS} -DTWO_STOP_BITS=${TWO_STOP_BITS}"
fi
if [ "${NO_APP_SPM}" != "" ] ; then
	XTRA_OPTIONS="${XTRA_OPTIONS} -DNO_APP_SPM=${NO_APP_SPM}"
fi
if [ "${UART}" = "" ] ; then
UART=0
fi
if (( ${UART} > ${my_uarts} )) && (( ${my_uarts} > 0 )); then
  max_uart_nr=`echo "${my_uarts} - 1" | bc`
  echo "${MPU_TARGET} has only ${my_uarts} UARTs, UART set to ${max_uart_nr}"
  UART=${max_uart_nr}
fi
# Check input format for LFUSE, HFUSE, EFUSE
if (( ${#LFUSE} != 2 )) ; then
  echo "Only two hex digits are accepted for LFUSE setting!"
  exit 1
fi
if (( ${#HFUSE} != 2 )) ; then
  echo "Only two hex digits are accepted for HFUSE setting!"
  exit 1
fi
if [ "${EFUSE}" != "" ] ; then
  if (( ${#EFUSE} != 2 )) ; then
    echo "Only two hex digits are accepted for EFUSE setting!"
    exit 1
  fi
fi
source show_rx_pin.sh
source show_tx_pin.sh
source show_write_protect.sh
LDFLAGS="-Wl,--relax -nostartfiles -nostdlib"
LDSECTIONS="-Wl,--section-start=.version=0x`echo "obase=16;${FLASH_SIZE}-2" | bc`"

# Build of the first object file .o
c_params="${CFLAGS} ${COMMON_OPTIONS} ${XTRA_OPTIONS}"
if (( 0${VIRTUAL_BOOT_PARTITION} > 0 )) ; then
 FLASH_ERASE_CNT=${VIRTUAL_BOOT_PARTITION}
 c_params+=" -DVIRTUAL_BOOT_PARTITION=${VIRTUAL_BOOT_PARTITION}"
 if [ "${save_vect_num}" != "" ] ; then
  c_params+=" -Dsave_vect_num=${save_vect_num}"
 fi
fi
c_params+=" -DLED=p${LED} -DUART=0${UART} -DSOFT_UART=0${SOFT_UART} -DUART_RX=p${UART_RX} -DUART_TX=p${UART_TX} -DF_CPU=${AVR_FREQ}"
c_params+=" -DHFUSE=hex${HFUSE^^} -DLFUSE=hex${LFUSE^^} -DBOOT_PAGE_LEN=${BOOT_PAGE_LEN}"
c_params+=" -DVerboseLev=${VerboseLev} -c -o ${PROGRAM}.o ${PROGRAM}.${SOURCE_TYPE}"

if (( ${VerboseLev} > 1 )) ; then echo "${Vgreen}avr-gcc ${c_params}${Vnormal}"; fi
avr-gcc ${c_params}

if (( $? == 0 )) ; then
 echo " .o build : OK!" >> ${LOGFILE}
else
 echo " .o build : FAILED!" >> ${LOGFILE} ; exit 1
fi

#  we can determine the size of the loader with optiboot.o for Assembler source input,
#  but for C source we need to do some optimizing  with the binder call (.elf).
#  This call is done without the relolation of the .text section (instruction code).
#  After computing the required size (and the possible relocation address),
#  This x.elf is removed later.

c_paramsx="${CFLAGS} ${COMMON_OPTIONS} ${XTRA_OPTIONS} ${LDSECTIONS}"
#  We must set a temporarely section start for .text section to prevent error message
#  because of rjmp use to start user application.
c_paramsx+=" -Wl,--section-start=.text=0x`echo "obase=16;${FLASH_SIZE}-1024" | bc`"
c_paramsx+=" ${LDFLAGS} -o ${PROGRAM}x.elf ${PROGRAM}.o ${LIBS}"

if (( ${VerboseLev} > 3 )) ; then echo "${Vgreen}avr-gcc ${c_paramsx}${Vnormal}" ; fi
avr-gcc ${c_paramsx}

if (( $? == 0 )) ; then
 echo " x.elf build : OK!" >> ${LOGFILE}
else
 echo " x.elf build : FAILED!" >> ${LOGFILE} 
 exit 1
fi

# BootPages fetch the actual boot loader size from a interim ${PROGRAM}x.elf file, not from the
# ${PROGRAM}.o file. The ld program can do some optimizing for code generated from a C-source.
# For code generated with the assembler there is no size difference between .o and .elf !
# If 3 pages are required, number of pages is rounded to 4.
# If more than 4 pages are required, the number of pages is rounded to 8.
# Above 8 pages there is no round up.
# The ATtiny84 has no hardware feature for the bootloader like the ATmega family.
# Therefore the "round up" is not required for the ATtiny84, but the BOOT_PAGE_LEN is 64 for
# this processor, so the number of pages is more than 7 pages for the actual size of optiboot.

export prog_size=`avr-size ${PROGRAM}x.elf | grep "${PROGRAM}x.elf" | cut -c 1-7`
export pg_anz=`echo "(${prog_size}-1)/${BOOT_PAGE_LEN}+1" | bc`

if (( 0${VIRTUAL_BOOT_PARTITION} > 0 )) ; then
 export BootPages=`echo "( (${prog_size}-1)/${FLASH_PAGE_SIZE}/${FLASH_ERASE_CNT} +1) * ${FLASH_ERASE_CNT}" | bc`
else
 export BootPages=`echo "${pg_anz} + (${pg_anz}==3 ) + (${pg_anz}==5)*3 + (${pg_anz}==6)*2 + (${pg_anz} == 7)" | bc`
fi


# With the  BootPages and the ${BOOT_PAGE_LEN} or ${FLASH_PAGE_SIZE} we can compute the 
# Start Address BL_StartAdr of the bootloader depending on the ${FLASH_SIZE} 
if (( 0${VIRTUAL_BOOT_PARTITION} > 0 )) ; then
 export BL_StartAdr=`echo "obase=16;${FLASH_SIZE} - (${BootPages}*${FLASH_PAGE_SIZE})" | bc`
else
 export BL_StartAdr=`echo "obase=16;${FLASH_SIZE} - (${BootPages}*${BOOT_PAGE_LEN})" | bc` 
fi
rm ${PROGRAM}x.elf

echo " "


# the C preprocessor make the script file baudcheck.tmp from baudcheck.S with real Parameters
c_params="${CFLAGS} ${COMMON_OPTIONS} -DUART=0${UART} -DSOFT_UART=0${SOFT_UART} -DUART_RX=p${UART_RX} -DUART_TX=p${UART_TX} -DF_CPU=${AVR_FREQ} -o baudcheck.tmp -E baudcheck.S"
  if (( ${VerboseLev} > 3 )) ; then echo "${Vgreen}avr-gcc ${c_params}${Vnormal}" ; fi
avr-gcc ${c_params}

if (( $? == 0 )) ; then
 echo " baudcheck.tmp.sh build : OK!" >> ${LOGFILE}
else
 echo " baudcheck.tmp.sh build : FAILED!" >> ${LOGFILE}
fi

# remove \r from baudcheck.tmp to make a bash script
  if (( ${VerboseLev} > 3 )) ; then echo "${Vgreen}cat baudcheck.tmp | tr -d \"\r\" > baudcheck.tmp.sh${Vnormal}" ; fi
cat baudcheck.tmp | tr -d "\r" > baudcheck.tmp.sh

  if (( ${VerboseLev} > 3 )) ; then echo "${Vgreen}source ./baudcheck.sh${Vnormal}" ; fi
source ./baudcheck.tmp.sh
rm -f ./baudcheck.tmp
PROGNAME=${PROGRAM}_${TARGET}

# Generate the final ${PROGRAM}.elf file at the right Start Address,
# which is the base to generate the ${PROGNAME}.hex and ${PROGNAME}.lst files.
echo "${Vgrau}# # # # # # # # # # # # # # # # # # # # # #"
if [ "${MYLANG}" == "de_" ] ; then
 echo "${Vnormal}Bootlader Startadresse: 0x${BL_StartAdr}${Vgrau} = `echo "ibase=16;${BL_StartAdr}" | bc`"
 else
 echo "${Vnormal}Boot Loader start address: 0x${BL_StartAdr}${Vgrau} = `echo "ibase=16;${BL_StartAdr}" | bc`"
fi
echo "# # # # # # # # # # # # # # # # # # # # # #${Vnormal}"
c_paramf="${CFLAGS} ${COMMON_OPTIONS} ${LDSECTIONS} -Wl,--section-start=.text=0x${BL_StartAdr} ${LDFLAGS} -o ${PROGNAME}.elf ${PROGRAM}.o ${LIBS}"
  if (( ${VerboseLev} > 2 )) ; then echo "${Vgreen}avr-gcc ${c_paramf}${Vnormal}" ; fi
avr-gcc ${c_paramf}
echo " "

# With the ${Bootpages} file we can set the required BOOTSZ1 and BOOTSZ0 bits, which are
# combined to BOOTSZ (0 for eight pages, 1 for four pages, 2 for two pages and 3 for one page)
# This ${BOOTSZ} is taken by the Makefile.isp file to correct the HFUSE or EFUSE.
# With option VIRTUAL_BOOT_PARTITION ${BOOTSZ} is allways set to 3
#
  if (( ${VerboseLev} > 2 )) ; then echo "${Vgreen}avr-size ${PROGNAME}.elf${Vnormal}" ; fi
avr-size ${PROGNAME}.elf

if (( $? == 0 )) ; then
 echo " avr-size run : OK!" >> ${LOGFILE}
else
 echo " avr-size run : FAILED!" >> ${LOGFILE}
fi

if (( 0${VIRTUAL_BOOT_PARTITION} > 0 )) ; then
  RelVal=`echo "scale=1;${BootPages}*${FLASH_PAGE_SIZE}*100/${FLASH_SIZE}" | bc`
  if [ "${MYLANG}" == "de_" ] ; then
   RelMsg=`echo ", das ist ${RelVal}% des Flash Speichers"`
  else
   RelMsg=`echo ", which is ${RelVal}% of Flash Memory"`
  fi
  size2know=`echo "${BootPages} * ${FLASH_PAGE_SIZE}" | bc`
  if (( ${BootPages} > 1 )) ; then
   if [ "${MYLANG}" == "de_" ] ; then
    echo -n "Benötigt ${BootPages} Flash Seiten, je ${FLASH_PAGE_SIZE} Bytes${RelMsg}"
   else
    echo -n "Requires ${BootPages} Flash Pages, ${FLASH_PAGE_SIZE} Bytes each${RelMsg}"
   fi
  else
   if [ "${MYLANG}" == "de_" ] ; then
    echo -n "Benötigt ${BootPages} Flash Seite mit ${FLASH_PAGE_SIZE} Bytes${RelMsg}"
   else
    echo -n "Requires ${BootPages} Flash Page of ${FLASH_PAGE_SIZE} Bytes${RelMsg}"
   fi
  fi
 if (( 0${FLASH_ERASE_CNT} > 1 )) ; then
   if [ "${MYLANG}" == "de_" ] ; then
    echo ", Gruppe von ${FLASH_ERASE_CNT} Seiten löschbar"
   else
    echo ", Cluster of ${FLASH_ERASE_CNT} Pages erasable"
   fi
 else
    echo " "
 fi
 if (( ${BOOT_PAGE_LEN} < 129)) ; then
   if [ "${MYLANG}" == "de_" ] ; then
    echo "Keine Boot Seiten vorhanden!"
   else
    echo "No Boot Pages present!"
   fi
 else
   if [ "${MYLANG}" == "de_" ] ; then
    echo "Boot Seiten vorhanden, werden aber nicht benutzt!"
   else
    echo "Boot Pages present, but No Boot Pages used!"
   fi
 fi
 BOOTSZ=3 
else
# no virtual boot page
 BOOTSZ=`echo "0+(${pg_anz}<5)+(${pg_anz}<3)+(${pg_anz}<2)" | bc`

 RelVal=`echo "scale=1;${BootPages}*${BOOT_PAGE_LEN}*100/${FLASH_SIZE}" | bc`
 if [ "${MYLANG}" == "de_" ] ; then
  RelMsg=`echo ", das ist ${RelVal}% des Flash Speichers"`
 else
  RelMsg=`echo ", which is ${RelVal}% of Flash Memory"`
 fi
 size2know=`echo "${BootPages} * ${BOOT_PAGE_LEN}" | bc`
 if (( ${pg_anz} > 1 )) ; then
  if [ "${MYLANG}" == "de_" ] ; then
   echo "Benötigt ${BootPages} Boot Seiten, je ${BOOT_PAGE_LEN} Bytes${RelMsg}"
   echo "${Vinv}BOOTSZ=${BOOTSZ}${Vnormal}, das bedeutet ${Vinv}${BootPages} Boot Seiten${Vnormal}"
  else
   echo "Requires ${pg_anz} Boot Pages, ${BOOT_PAGE_LEN} Bytes each${RelMsg}"
   echo "${Vinv}BOOTSZ=${BOOTSZ}${Vnormal}, which means ${Vinv}${BootPages} Boot Pages${Vnormal}"
  fi
 else
  if [ "${MYLANG}" == "de_" ] ; then
   echo "Benötigt ${pg_anz} Boot Seite mit ${BOOT_PAGE_LEN} Bytes${RelMsg}"
   echo "${Vinv}BOOTSZ=${BOOTSZ}${Vnormal}, das bedeutet ${Vinv}${BootPages} Boot Seite${Vnormal}"
  else
   echo "Requires ${pg_anz} Boot Page of ${BOOT_PAGE_LEN} Bytes${RelMsg}"
   echo "${Vinv}BOOTSZ=${BOOTSZ}${Vnormal}, which means ${Vinv}${BootPages} Boot Page${Vnormal}"
  fi
 fi
fi

# generate a new .hex and .lst file from the right .elf
ocp_args="-j .text -j .data -j .version --set-section-flags .version=alloc,load -O ihex ${PROGNAME}.elf ${PROGNAME}.hex"
  if (( ${VerboseLev} > 3 )) ; then echo "${Vgreen}avr-objcopy ${ocp_args}${Vnormal}" ; fi
avr-objcopy -j .text -j .data -j .version --set-section-flags .version=alloc,load -O ihex ${PROGNAME}.elf ${PROGNAME}.hex

  if (( ${VerboseLev} > 3 )) ; then echo "${Vgreen}avr-objdump -h -S ${PROGNAME}.elf > ${PROGNAME}.lst${Vnormal}" ; fi
 LSTFILE="${PROGNAME}.lst"
avr-objdump -h -S ${PROGNAME}.elf > ${LSTFILE}

if (( $? == 0 )) ; then
 echo " avr-objdump run : OK!" >> ${LOGFILE}
else
 echo " avr-objdump run : FAILED!" >> ${LOGFILE}
fi

# copy the  .lst and .hex files to files which identify the target
# add some options to the end of the .lst file as comment
echo "; " >> ${LSTFILE}
echo "; FORCE_WATCHDOG=${FORCE_WATCHDOG}" >> ${LSTFILE}
echo "; LED_START_FLASHES=${LED_START_FLASHES}" >> ${LSTFILE}
echo "; LED_DATA_FLASH=${LED_DATA_FLASH}" >> ${LSTFILE}
echo "; LED=${LED}" >> ${LSTFILE}
if (( 0${SOFT_UART} > 0 )) ; then
  echo "; SOFT_UART=${SOFT_UART}" >> ${LSTFILE}
  echo "; UART_RX=${UART_RX}" >> ${LSTFILE}
  echo "; UART_TX=${UART_TX}" >> ${LSTFILE}
fi
echo "; UART=${UART}" >> ${LSTFILE}
echo "; SOURCE_TYPE=${SOURCE_TYPE}" >> ${LSTFILE}
echo "; SUPPORT_EEPROM=${SUPPORT_EEPROM}" >> ${LSTFILE}
echo "; MCU_TARGET = ${MCU_TARGET}" >> ${LSTFILE}
echo "; AVR_FREQ= ${AVR_FREQ}" >> ${LSTFILE}
echo "; BAUD_RATE=${BAUD_RATE}" >> ${LSTFILE}

echo "${PROGRAM} for ${TARGET} with AVR ${MCU_TARGET}" >> ${LOGFILE}
echo "Parameter Settings:" >> ${LOGFILE}
echo "AVR_FREQ=${AVR_FREQ}" >> ${LOGFILE}
echo "BAUD_RATE=${BAUD_RATE}" >> ${LOGFILE}
echo "UART=${UART}" >> ${LOGFILE}
echo "LED_START_FLASHES=${LED_START_FLASHES}" >> ${LOGFILE}
echo "LED_DATA_FLASH=${LED_DATA_FLASH}" >> ${LOGFILE}
echo "LED=${LED}" >> ${LOGFILE}
echo "SUPPORT_EEPROM=${SUPPORT_EEPROM}" >> ${LOGFILE}
echo "ISP=${ISP}" >> ${LOGFILE}
echo "SOFT_UART=${SOFT_UART}" >> ${LOGFILE}
echo "UART_RX=${UART_RX}" >> ${LOGFILE}
echo "UART_TX=${UART_TX}" >> ${LOGFILE}
echo "C_SOURCE=${C_SOURCE} ,SOURCE_TYPE=${SOURCE_TYPE}" >> ${LOGFILE}
echo "BIGBOOT=${BIGBOOT}" >> ${LOGFILE}
echo "VIRTUAL_BOOT_PARTITION=${VIRTUAL_BOOT_PARTITION}" >> ${LOGFILE}
echo "TIMEOUT_MS=${TIMEOUT_MS}" >> ${LOGFILE}
echo "OSCCAL_CORR=${OSCCAL_CORR}" >> ${LOGFILE}
echo "FORCE_RSTDISBL=${FORCE_RSTDISBL}" >> ${LOGFILE}
echo "save_vect_num=${save_vect_num}" >> ${LOGFILE}
if [ "${WRITE_PROTECT_PIN}" != "" ] ; then
echo "WRITE_PROTECT_PIN=${WRITE_PROTECT_PIN}" >> ${LOGFILE}
fi
if [ "${NO_EARLY_PAGE_ERASE}" != "" ] ; then
echo "NO_EARLY_PAGE_ERASE=${NO_EARLY_PAGE_ERASE}" >> ${LOGFILE}
echo "TWO_STOP_BITS=${TWO_STOP_BITS}" >> ${LOGFILE}
fi
echo "NO_APP_SPM=${NO_APP_SPM}" >> ${LOGFILE}
echo " " >> ${LOGFILE}
echo "Bootloader use ${size2know} Bytes of Flash," >> ${LOGFILE}
echo "so the Application must use less than 0x${BL_StartAdr} Bytes of Flash " >> ${LOGFILE}

export TARGET FLASH_SIZE BOOT_PAGE_LEN BOOTSZ BL_StartAdr
export EFUSE HFUSE LFUSE
export PROGRAM TARGET MCU_TARGET AVR_FREQ
if (( 0${ISP} > 0 )) ; then
 source  ./program_target.sh
# make --no-print-directory --warn-undefined-variables -r -f Makefile.isp do_isp
else
 if (( ${VerboseLev} > 3 )) ; then 
   if [ "${EFUSE}" = "" ] ; then
    echo "${Vgelb}Fuse Setting:${Vnormal} LFUSE=0x${LFUSE}, HFUSE=0x${HFUSE}"
   else
    echo "${Vgelb}Fuse Setting:${Vnormal} LFUSE=0x${LFUSE}, HFUSE=0x${HFUSE}, EFUSE=0x${EFUSE}"
   fi
 fi
fi
echo " "
exit 0
