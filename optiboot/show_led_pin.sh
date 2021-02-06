#!/bin/bash

# Look for  a pin description in the database avr_pins.
# Requires LED set to a valid pin in short form like B5 for Port B, Pin No. 5.
# If LED is unset, tries to find a default pin in the avr_pins/${AVR_FAMILY} desription
# Additionally AVR_FAMILY should hold the name of the AVR family,
# which is usually the biggest member like atmega328 for atmega168.
# You can convert the name of the target processor in MCI_TARGET to
# AVR_FAMILY with avr_family.sh .

if (( ${LED_START_FLASHES}0 == 0 )) && (( ${LED_DATA_FLASH}0 == 0 )) ; then
  if (( ${VerboseLev} > 2 )) ; then
    if [ "${LANGUAGE}" == "de_DE" ] ; then
      echo "${Vgrau}LED-Pin wird nicht benutzt!${Vnormal}"
    else
      echo "${Vgrau}LED-Pin not used!${Vnormal}"
    fi
  fi
else
  if [ "${LED}" = "" ] ; then
   led_grep_txt="LED"
  else
   led_grep_txt="^p${LED}"
  fi
  if (( ${VerboseLev} > 3 )) ; then echo "rx_zeile=grep --color=never \"${led_grep_txt}\" avr_pins/${AVR_FAMILY}.pins" ; fi
  pin_zeile=`grep --color=never "${led_grep_txt}" avr_pins/${AVR_FAMILY}.pins` 2> /dev/null
  if (( $? == 0 )) ; then
    if [ "${LED}" = "" ] ; then
      nled=`echo ${pin_zeile} | cut -c2-3`
      if (( ${VerboseLev} > 2 )) ; then
        if [ "${LANGUAGE}" == "de_DE" ] ; then
          echo "LED wird in list_led_pins.sh auf ${nled} gesetzt." 
        else
          echo "LED set to ${nled} in list_led_pins.sh." 
        fi
      fi
      LED=${nled}
      unset nled
    fi
    pin_desc=`echo "${pin_zeile}" | cut -f3`
    pin_layout=`echo "${pin_zeile}" | cut -f2`
    if [ "${LANGUAGE}" == "de_DE" ] ; then
      echo -n "${Vgrau}LED-Pin ${Vnormal}P${LED} ${Vgrau}benutzt Pin ${Vnormal}${pin_layout}"
    else
      echo -n "${Vgrau}LED-Pin ${Vnormal}P${LED} ${Vgrau}use Pin ${Vnormal}${pin_layout}"
    fi
    if [ "${pin_desc}" = "-" ] || [ "${pin_desc}" = "" ] ; then
     echo "."
    else
     if [ "${LANGUAGE}" == "de_DE" ] ; then
       echo "${Vgrau}, mit Spezialfunktionen: ${Vnormal}${pin_desc}."
     else
       echo "${Vgrau}, with special functions: ${Vnormal}${pin_desc}."
     fi
    fi
    unset pin_layout
    unset pin_desc
  else
    if [ "${LANGUAGE}" == "de_DE" ] ; then
      echo "list_led_pin.sh hat ${rx_grep_txt} in avr_pins/${AVR_FAMILY}.pins nicht gefunden."
      echo "Liste der verfügbaren Pinne der ${AVR_FAMILY} Gruppe:"
    else
      echo "list_led_pin.sh has not found \"${led_grep_txt}\" in avr_pins/${AVR_FAMILY}.pins"
      echo "List of available pins for ${AVR_FAMILY} group:"
    fi
    grep "^p[A-N][0-7]" avr_pins/${AVR_FAMILY}.pins
    exit 1
  fi
  unset pin_zeile
fi
