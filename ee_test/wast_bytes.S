/* wast_bytes.S generates a sequence of words in section text. */
/* A sequence of 7 different words is repeated as often as */
/* the Byte count value BIGPROGRAM specifies */
/* Currently a sequence of 0,1,2,3,4,5,6 is generated. */
/* The only sense is to test the bootloader for higher addresses. */

#ifndef __ASSEMBLER__
 #define __ASSEMBLER__
#endif
	.section .text
	.func wast_bytes
#ifndef REPCNT
 #define REPCNT 7
#endif
#if REPCNT < 3
 #warning "REPCNT is set to 3"
 #undef REPCNT
 #define REPCNT 3
#endif
#if REPCNT > 11
 #warning "REPCNT is set to 11"
  #undef REPCNT
  #define REPCNT 11
#endif

#define REPETITION_COUNT ((BIGPROGRAM+1)/(2*REPCNT))

#if REPCNT > 7
/* use 11 words for repetition */
	.rept	REPETITION_COUNT
        .word	0x0000
        .word	0x0001
        .word	0x0002
        .word	0x0003
        .word	0x0004
        .word	0x0005
        .word	0x0006
	.word	0x0007
 #if REPCNT > 8
	.word	0x0008
  #if REPCNT > 9
	.word	0x0009
   #if REPCNT > 10
	.word	0x000a
    #if REPCNT > 11
	.word	0x000b
     #if REPCNT > 12
	.word	0x000c
      #if REPCNT > 13
	.word	0x000d
      #endif
     #endif
    #endif
   #endif
  #endif
 #endif
	.endr
#else
/* use 7 words for repetition */
	.rept	REPETITION_COUNT
        .word	0x0000
        .word	0x0001
        .word	0x0002
 #if REPCNT > 3
        .word	0x0003
  #if REPCNT > 4
        .word	0x0004
   #if REPCNT > 5
        .word	0x0005
    #if REPCNT > 6
        .word	0x0006
    #endif
   #endif
  #endif
 #endif
	.endr
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 0
	.word	0x0000
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 2
	.word	0x0001
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 4
	.word	0x0002
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 6
	.word	0x0003
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 8
	.word	0x0004
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 10
	.word	0x0005
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 12
	.word	0x0006
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 14
	.word	0x0007
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 16
	.word	0x0008
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 18
	.word	0x0009
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 20
	.word	0x000a
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 22
	.word	0x000b
#endif
#if  (BIGPROGRAM - (REPETITION_COUNT*2*REPCNT)) > 24
	.word	0x000c
#endif

	.endfunc
