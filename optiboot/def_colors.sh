#!/bin/bash
# This def_colors.sh set the colors for formatting the echo output

if (( 0${WITH_COLORS} == 0 )) ; then
  WITH_COLORS=1
fi
if (( 0${WITH_COLORS} > 1 )) ; then WITH_COLORS=0; fi
if (( WITH_COLORS == 1 )) ; then
 #define the used  tput extension
 #color red
 Vrot=`tput setaf 9`
 #color yellow
 Vgelb=`tput setaf 11`
 #color green
 Vgreen=`tput setaf 2`
 #color grey
 Vgrau=`tput setaf 245`
 # bold
 Vfett=`tput bold`
 #
 Vlila=`tput setaf 13`
 # reverse
 Vinv=`tput rev`
 #normal
 Vnormal=`tput sgr0`
else
 Vrot=""
 Vgelb=""
 Vgreen=""
 Vgrau=""
 Vfett=""
 Vlila=""
 Vinv=""
 Vnormal=""
fi
