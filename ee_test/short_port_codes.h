/*
 * ------------------------------------------------------------------------
 * A bunch of macros to enable the LED to be specifed as "B5" for bit 5 
 * of port B, and similar.
 */

#ifdef PORTA
#define pA0 0x100
#define pA1 0x101
#define pA2 0x102
#define pA3 0x103
#define pA4 0x104
#define pA5 0x105
#define pA6 0x106
#define pA7 0x107
#else
#define pA0 0x1100
#define pA1 0x1101
#define pA2 0x1102
#define pA3 0x1103
#define pA4 0x1104
#define pA5 0x1105
#define pA6 0x1106
#define pA7 0x1107
#endif

#ifdef PORTB
#define pB0 0x200
#define pB1 0x201
#define pB2 0x202
#define pB3 0x203
#define pB4 0x204
#define pB5 0x205
#define pB6 0x206
#define pB7 0x207
#else
#define pB0 0x1200
#define pB1 0x1201
#define pB2 0x1202
#define pB3 0x1203
#define pB4 0x1204
#define pB5 0x1205
#define pB6 0x1206
#define pB7 0x1207
#endif

#ifdef PORTC
#define pC0 0x300
#define pC1 0x301
#define pC2 0x302
#define pC3 0x303
#define pC4 0x304
#define pC5 0x305
#define pC6 0x306
#define pC7 0x307
#else
#define pC0 0x1300
#define pC1 0x1301
#define pC2 0x1302
#define pC3 0x1303
#define pC4 0x1304
#define pC5 0x1305
#define pC6 0x1306
#define pC7 0x1307
#endif

#ifdef PORTD
#define pD0 0x400
#define pD1 0x401
#define pD2 0x402
#define pD3 0x403
#define pD4 0x404
#define pD5 0x405
#define pD6 0x406
#define pD7 0x407
#else
#define pD0 0x1400
#define pD1 0x1401
#define pD2 0x1402
#define pD3 0x1403
#define pD4 0x1404
#define pD5 0x1405
#define pD6 0x1406
#define pD7 0x1407
#endif

#ifdef PORTE
#define pE0 0x500
#define pE1 0x501
#define pE2 0x502
#define pE3 0x503
#define pE4 0x504
#define pE5 0x505
#define pE6 0x506
#define pE7 0x507
#else
#define pE0 0x1500
#define pE1 0x1501
#define pE2 0x1502
#define pE3 0x1503
#define pE4 0x1504
#define pE5 0x1505
#define pE6 0x1506
#define pE7 0x1507
#endif

#ifdef PORTF
#define pF0 0x600
#define pF1 0x601
#define pF2 0x602
#define pF3 0x603
#define pF4 0x604
#define pF5 0x605
#define pF6 0x606
#define pF7 0x607
#else
#define pF0 0x1600
#define pF1 0x1601
#define pF2 0x1602
#define pF3 0x1603
#define pF4 0x1604
#define pF5 0x1605
#define pF6 0x1606
#define pF7 0x1607
#endif

#ifdef PORTG
#define pG0 0x700
#define pG1 0x701
#define pG2 0x702
#define pG3 0x703
#define pG4 0x704
#define pG5 0x705
#define pG6 0x706
#define pG7 0x707
#else
#define pG0 0x1700
#define pG1 0x1701
#define pG2 0x1702
#define pG3 0x1703
#define pG4 0x1704
#define pG5 0x1705
#define pG6 0x1706
#define pG7 0x1707
#endif

#ifdef PORTH
#define pH0 0x800
#define pH1 0x801
#define pH2 0x802
#define pH3 0x803
#define pH4 0x804
#define pH5 0x805
#define pH6 0x806
#define pH7 0x807
#else
#define pH0 0x1800
#define pH1 0x1801
#define pH2 0x1802
#define pH3 0x1803
#define pH4 0x1804
#define pH5 0x1805
#define pH6 0x1806
#define pH7 0x1807
#endif

#ifdef PORTJ
#define pJ0 0xA00
#define pJ1 0xA01
#define pJ2 0xA02
#define pJ3 0xA03
#define pJ4 0xA04
#define pJ5 0xA05
#define pJ6 0xA06
#define pJ7 0xA07
#else
#define pJ0 0x1A00
#define pJ1 0x1A01
#define pJ2 0x1A02
#define pJ3 0x1A03
#define pJ4 0x1A04
#define pJ5 0x1A05
#define pJ6 0x1A06
#define pJ7 0x1A07
#endif

#ifdef PORTK
#define pK0 0xB00
#define pK1 0xB01
#define pK2 0xB02
#define pK3 0xB03
#define pK4 0xB04
#define pK5 0xB05
#define pK6 0xB06
#define pK7 0xB07
#else
#define pK0 0x1B00
#define pK1 0x1B01
#define pK2 0x1B02
#define pK3 0x1B03
#define pK4 0x1B04
#define pK5 0x1B05
#define pK6 0x1B06
#define pK7 0x1B07
#endif

#ifdef PORTL
#define pL0 0xC00
#define pL1 0xC01
#define pL2 0xC02
#define pL3 0xC03
#define pL4 0xC04
#define pL5 0xC05
#define pL6 0xC06
#define pL7 0xC07
#else
#define pL0 0x1C00
#define pL1 0x1C01
#define pL2 0x1C02
#define pL3 0x1C03
#define pL4 0x1C04
#define pL5 0x1C05
#define pL6 0x1C06
#define pL7 0x1C07
#endif
