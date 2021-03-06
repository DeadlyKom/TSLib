
; -----------------------------------------
; Note:
;   https://www.random.org/
; -----------------------------------------
                align 256
PRNG_TAB:       ifndef PRNG_SEQUENCE

                ; integer
                DB  -79,     -26,	 -41,	  13,	  80,	  55,	  10,	 117
                DB   63,	  78,	  53,	 -85,	  18,	-111,	 -49,	 112
                DB  -33,	 -99,	 -13,	 -78,	 -92,	  -6,	  40,	  55
                DB   96,	  14,	 -66,	 111,	  94,	-119,	 106,	  82
                DB   21,  	  38,	-115,	-120,	 -30,	 -67,	 -29,	 121
                DB  100,	 -95,	   0,	-117,	 -14,	 -88,	-110,	 123
                DB   38,	  10,	 -24,	  17,	  38,	   0,	 105,	 -10
                DB   62,	 126,	 -90,	 -92,	  99,	 104,	  -6,	 -13
                DB   59,	 -49,	 -35,	 112,	 -41,	-114,	 -79,	 115
                DB   79,	-127,	  66,	-115,	 -98,	  37,	  71,	-116
                DB -113,	 -52,	 -83,	  21,	-121,	  71,	  63,	  42
                DB   24,	  84,	 -35,	 -37,	 -77,	  69,	  58,	 -77
                DB -102,	  81,	  63,	-107,	  20,	  61,	  95,	 -90
                DB   73,	  -6,	  59, 	 112,	 -95,	  93,	 -11,	  58
                DB  -30,	-113,	 -42,	  70,	 -44,	  82,	 -48,	  -4
                DB   59,	  83,	  36,	 126,	-117,	 -99,	  33,	 119
                DB  105,	  33,	 -93,	 -37,	 113,	-111,	 108,	 -72
                DB   64,	  -6,	 -53,	 -82,	-127,	-111,	 125,	 -12
                DB  124,	 125,	-111,	-103,	 -99,	  68,	   9,	 -37
                DB   82,	   7,	  63,	 -12,	 -95,	 -85,	-106,	 -94
                DB   53,	 -74,	 116,	  -5,	  15,	  66,	-121,	 -95
                DB   98,	 -64,	 110,	  82,	  58,	 -24,	-124,	 -20
                DB  -86,	-120,	 122,	  46,	  33,	   5,	 -24,	 -77
                DB -107,	- 98,	  29,	 -35,	 -55,	 -10,	  79,	 -14
                DB   11,	  63,	  52,	 -94,	  23,	  32,	 126,	 107
                DB -123,	-102,	-106,	   0,	 -35,	 124,	-119,	 -64
                DB  -27,	  64,	  99,	 -98,	  69,	  84,	  80,	  -1
                DB  -80,	-124,	 -91,	 -24,	 -29,	  54,	 126,	-102
                DB   19,	 -49,	  -2,	 -59,	-123,	 -84,	-101,	  71
                DB  -36,	 -74,	 -77,	 -72,	   2,	 -19,	 -35,	 -99
                DB  -21,	 -88,	 -36,	 -83,	 110,	  71,	   8,	 -46
                DB   40,	  80,	 -32,	 -89,	 -76,	 127,	  79,	 -32

                else

                ; sequence
                DB  106,     -37,    -22,     38,    -68,     54,     37,     27
                DB  -17,     -89,    118,    -13,    -99,    -107,    -5,     84
                DB   35,      -3,     32,     17,    -81,      86,    52,    -24
                DB -120,     100,   -113,     69,    121,     -40,    74,   -100
                DB  -26,      25,    -62,    -44,    119,    -109,   -90,     56
                DB   78,     -63,    122,    -61,    -20,      91,    36,    115
                DB -119,     -25,    -60,    -49,     34,     -76,  -108,     31
                DB  111,     101,      4,    116,     16,      63,   -93,     98
                DB  -72,      43,    -38,    -86,   -121,    -111,    -2,     42
                DB  120,      47,     66,     99,   -112,    -114,   -21,    -83
                DB   29,     -34,    -88,     12,     97,       6,   108,    -70
                DB   -8,     107,     55,     87,    110,     -39,    -4,     -1
                DB   76,    -126,    -74,    -58,     65,    -104,   -51,     85
                DB  -30,      10,    -75,    -23,   -127,      28,   -84,     81
                DB    0,      14,     80,    -73,     48,     -18,    22,    -96
                DB  -19,      57,     26,     24,    125,     -42,   -80,    105
                DB  -98,    -103,    126,    -41,     53,      59,    39,     21
                DB  -57,      18,     95,      2,     77,     -43,   -59,     73
                DB  -52,     103,    -28,      3,    -54,     114,   117,    -87
                DB   71,      79,    -16,     33,    -92,    -101,    58,     30
                DB  -85      -97,     -6,    -53,    -27,      50,   -79,     83
                DB  -32     -102,     89,    113,   -117,     -14,    45,    -11
                DB  -36,     -45,     92,    -65,      8,     -94,  -105,     15
                DB  -66,     -95,     46,      9,    -56,     -55,    -7,   -122
                DB   70,     -46,     44,      5,    -12,     -10,   -47,     88
                DB   68,     -77,      1,    -78,     94,     102,  -124,     19
                DB -118,     -91,     75,     62,     40,      11,   109,    -35
                DB  -48,       7,    -71,    127,    -67,      96,   104,    112
                DB -128,     -29,     72,     20,    123,     -31,    82,     67
                DB -115,    -123,     60,     61,   -106,     -64,    23,    -50
                DB  124,      90,     -9,    -69,     93,    -110,    49,   -116
                DB  -82,    -125,     13,     64,    -15,     -33,    51,     41

                endif
