opt subtitle "HI-TECH Software Omniscient Code Generator (PRO mode) build 9453"

opt pagewidth 120

	opt pm

	processor	16F84A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 6 "LEDCode.c"
	psect config,class=CONFIG,delta=2 ;#
# 6 "LEDCode.c"
	dw 0xFFFE & 0xFFFB & 0xFFF7 & 0xFFFF ;#
	FNCALL	_main,_initialize
	FNCALL	_main,_disp
	FNCALL	_main,_button_press
	FNCALL	_main,_button_direction
	FNCALL	_main,_button_to_floor
	FNCALL	_main,_cmd
	FNCALL	_main,_moving
	FNCALL	_main,_nearest_call
	FNCALL	_moving,_disp
	FNCALL	_moving,_button_press
	FNCALL	_moving,_set_floor
	FNCALL	_moving,_set_destination
	FNCALL	_moving,_cmd
	FNCALL	_moving,_floor_details
	FNCALL	_moving,_cabin_call_min
	FNCALL	_moving,_cabin_call_max
	FNCALL	_floor_details,_cmd
	FNCALL	_floor_details,_disp
	FNCALL	_floor_details,_button_press
	FNCALL	_floor_details,_button_to_floor
	FNCALL	_floor_details,_clr_char
	FNCALL	_floor_details,_set_floor
	FNCALL	_floor_details,_set_destination
	FNCALL	_floor_details,_strlen
	FNCALL	_initialize,_cmd
	FNCALL	_clr_char,_cmd
	FNCALL	_clr_char,_disp
	FNCALL	_set_destination,_button_direction
	FNCALL	_set_destination,_button_to_floor
	FNCALL	_set_floor,_button_to_floor
	FNCALL	_set_floor,_button_direction
	FNROOT	_main
	global	_floor_call
	global	_cabin_call
	global	_button
	global	_current_floor
	global	_destination_floor
	global	_i
	global	_j
	global	_PORTA
psect	text351,local,class=CODE,delta=2
global __ptext351
__ptext351:
_PORTA	set	5
	global	_PORTB
_PORTB	set	6
	global	_RA0
_RA0	set	40
	global	_RA1
_RA1	set	41
	global	_RA2
_RA2	set	42
	global	_RA3
_RA3	set	43
	global	_RA4
_RA4	set	44
	global	_TRISB
_TRISB	set	134
	global	_TRISA0
_TRISA0	set	1064
	global	_TRISA1
_TRISA1	set	1065
	global	_TRISA2
_TRISA2	set	1066
	global	_TRISA3
_TRISA3	set	1067
	global	_TRISA4
_TRISA4	set	1068
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	
STR_2:	
	retlw	69	;'E'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	32	;' '
	retlw	70	;'F'
	retlw	108	;'l'
	retlw	111	;'o'
	retlw	111	;'o'
	retlw	114	;'r'
	retlw	115	;'s'
	retlw	58	;':'
	retlw	32	;' '
	retlw	69	;'E'
	retlw	120	;'x'
	retlw	105	;'i'
	retlw	116	;'t'
	retlw	32	;' '
	retlw	0
	retlw	0
psect	strings
	
STR_1:	
	retlw	69	;'E'
	retlw	110	;'n'
	retlw	116	;'t'
	retlw	101	;'e'
	retlw	114	;'r'
	retlw	32	;' '
	retlw	80	;'P'
	retlw	101	;'e'
	retlw	111	;'o'
	retlw	112	;'p'
	retlw	108	;'l'
	retlw	101	;'e'
	retlw	58	;':'
	retlw	32	;' '
	retlw	48	;'0'
	retlw	0
	retlw	0
psect	strings
	file	"PT=space.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_floor_call:
       ds      8

_cabin_call:
       ds      4

_button:
       ds      2

_current_floor:
       ds      2

_destination_floor:
       ds      2

_i:
       ds      2

_j:
       ds      2

psect clrtext,class=CODE,delta=2
global clear_ram
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram:
	clrwdt			;clear the watchdog before getting into this loop
clrloop:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop		;do the next byte

; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+016h)
	fcall	clear_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	??_strlen
??_strlen:	; 0 bytes @ 0x0
	global	??_disp
??_disp:	; 0 bytes @ 0x0
	global	??_cmd
??_cmd:	; 0 bytes @ 0x0
	global	??_initialize
??_initialize:	; 0 bytes @ 0x0
	global	??_button_press
??_button_press:	; 0 bytes @ 0x0
	global	??_button_direction
??_button_direction:	; 0 bytes @ 0x0
	global	??_cabin_call_max
??_cabin_call_max:	; 0 bytes @ 0x0
	global	??_cabin_call_min
??_cabin_call_min:	; 0 bytes @ 0x0
	global	??_nearest_call
??_nearest_call:	; 0 bytes @ 0x0
	global	??_floor_details
??_floor_details:	; 0 bytes @ 0x0
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	?_disp
?_disp:	; 0 bytes @ 0x0
	global	?_cmd
?_cmd:	; 0 bytes @ 0x0
	global	?_initialize
?_initialize:	; 0 bytes @ 0x0
	global	?_set_floor
?_set_floor:	; 0 bytes @ 0x0
	global	?_set_destination
?_set_destination:	; 0 bytes @ 0x0
	global	?_floor_details
?_floor_details:	; 0 bytes @ 0x0
	global	?_moving
?_moving:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_strlen
?_strlen:	; 2 bytes @ 0x0
	global	?_button_press
?_button_press:	; 2 bytes @ 0x0
	global	?_button_to_floor
?_button_to_floor:	; 2 bytes @ 0x0
	global	?_button_direction
?_button_direction:	; 2 bytes @ 0x0
	global	?_cabin_call_max
?_cabin_call_max:	; 2 bytes @ 0x0
	global	?_cabin_call_min
?_cabin_call_min:	; 2 bytes @ 0x0
	global	?_nearest_call
?_nearest_call:	; 2 bytes @ 0x0
	global	cmd@cmd_msg
cmd@cmd_msg:	; 1 bytes @ 0x0
	ds	2
	global	??_button_to_floor
??_button_to_floor:	; 0 bytes @ 0x2
	global	strlen@s
strlen@s:	; 1 bytes @ 0x2
	ds	1
	global	strlen@cp
strlen@cp:	; 1 bytes @ 0x3
	ds	1
	global	?_clr_char
?_clr_char:	; 0 bytes @ 0x4
	global	??_set_floor
??_set_floor:	; 0 bytes @ 0x4
	global	??_set_destination
??_set_destination:	; 0 bytes @ 0x4
	global	clr_char@spaces
clr_char@spaces:	; 2 bytes @ 0x4
	ds	2
	global	??_clr_char
??_clr_char:	; 0 bytes @ 0x6
	ds	3
	global	floor_details@i
floor_details@i:	; 2 bytes @ 0x9
	ds	2
	global	??_moving
??_moving:	; 0 bytes @ 0xB
	ds	9
	global	moving@counter
moving@counter:	; 2 bytes @ 0x14
	ds	2
	global	??_main
??_main:	; 0 bytes @ 0x16
	ds	1
;;Data sizes: Strings 38, constant 0, data 0, bss 22, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON           0      0       0
;; BANK0           66     23      45

;;
;; Pointer list with targets:

;; ?_strlen	unsigned int  size(1) Largest target is 21
;;		 -> STR_2(CODE[21]), STR_1(CODE[17]), 
;;
;; ?_nearest_call	short  size(1) Largest target is 0
;;
;; ?_cabin_call_min	short  size(1) Largest target is 0
;;
;; ?_cabin_call_max	short  size(1) Largest target is 0
;;
;; ?_button_to_floor	short  size(1) Largest target is 0
;;
;; strlen@s	PTR const unsigned char  size(1) Largest target is 21
;;		 -> STR_2(CODE[21]), STR_1(CODE[17]), 
;;
;; strlen@cp	PTR const unsigned char  size(1) Largest target is 21
;;		 -> STR_2(CODE[21]), STR_1(CODE[17]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_moving
;;   _moving->_floor_details
;;   _floor_details->_clr_char
;;   _initialize->_cmd
;;   _clr_char->_strlen
;;   _set_destination->_button_to_floor
;;   _set_floor->_button_to_floor

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 1     1      0     479
;;                                             22 BANK0      1     1      0
;;                         _initialize
;;                               _disp
;;                       _button_press
;;                   _button_direction
;;                    _button_to_floor
;;                                _cmd
;;                             _moving
;;                       _nearest_call
;; ---------------------------------------------------------------------------------
;; (1) _moving                                              11    11      0     435
;;                                             11 BANK0     11    11      0
;;                               _disp
;;                       _button_press
;;                          _set_floor
;;                    _set_destination
;;                                _cmd
;;                      _floor_details
;;                     _cabin_call_min
;;                     _cabin_call_max
;; ---------------------------------------------------------------------------------
;; (2) _floor_details                                        2     2      0     388
;;                                              9 BANK0      2     2      0
;;                                _cmd
;;                               _disp
;;                       _button_press
;;                    _button_to_floor
;;                           _clr_char
;;                          _set_floor
;;                    _set_destination
;;                             _strlen
;; ---------------------------------------------------------------------------------
;; (1) _initialize                                           0     0      0      22
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (3) _clr_char                                             5     3      2      44
;;                                              4 BANK0      5     3      2
;;                                _cmd
;;                               _disp
;;                             _strlen (ARG)
;; ---------------------------------------------------------------------------------
;; (3) _set_destination                                      2     2      0       0
;;                                              4 BANK0      2     2      0
;;                   _button_direction
;;                    _button_to_floor
;; ---------------------------------------------------------------------------------
;; (3) _set_floor                                            3     3      0       0
;;                                              4 BANK0      3     3      0
;;                    _button_to_floor
;;                   _button_direction
;; ---------------------------------------------------------------------------------
;; (4) _cmd                                                  1     1      0      22
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (4) _strlen                                               4     2      2      89
;;                                              0 BANK0      4     2      2
;; ---------------------------------------------------------------------------------
;; (1) _nearest_call                                         2     0      2       0
;;                                              0 BANK0      2     0      2
;; ---------------------------------------------------------------------------------
;; (2) _cabin_call_min                                       2     0      2       0
;;                                              0 BANK0      2     0      2
;; ---------------------------------------------------------------------------------
;; (2) _cabin_call_max                                       2     0      2       0
;;                                              0 BANK0      2     0      2
;; ---------------------------------------------------------------------------------
;; (4) _button_direction                                     2     0      2       0
;;                                              0 BANK0      2     0      2
;; ---------------------------------------------------------------------------------
;; (4) _button_to_floor                                      4     2      2       0
;;                                              0 BANK0      4     2      2
;; ---------------------------------------------------------------------------------
;; (3) _button_press                                         2     0      2       0
;;                                              0 BANK0      2     0      2
;; ---------------------------------------------------------------------------------
;; (4) _disp                                                 0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 4
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _initialize
;;     _cmd
;;   _disp
;;   _button_press
;;   _button_direction
;;   _button_to_floor
;;   _cmd
;;   _moving
;;     _disp
;;     _button_press
;;     _set_floor
;;       _button_to_floor
;;       _button_direction
;;     _set_destination
;;       _button_direction
;;       _button_to_floor
;;     _cmd
;;     _floor_details
;;       _cmd
;;       _disp
;;       _button_press
;;       _button_to_floor
;;       _clr_char
;;         _cmd
;;         _disp
;;         _strlen (ARG)
;;       _set_floor
;;         _button_to_floor
;;         _button_direction
;;       _set_destination
;;         _button_direction
;;         _button_to_floor
;;       _strlen
;;     _cabin_call_min
;;     _cabin_call_max
;;   _nearest_call
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            0      0       0       0        0.0%
;;EEDATA              40      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;COMMON               0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       4       2        0.0%
;;BANK0               42     17      2D       3       68.2%
;;ABS                  0      0      2D       4        0.0%
;;BITBANK0            42      0       0       5        0.0%
;;DATA                 0      0      31       6        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 343 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       1
;;      Totals:         0       1
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_initialize
;;		_disp
;;		_button_press
;;		_button_direction
;;		_button_to_floor
;;		_cmd
;;		_moving
;;		_nearest_call
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"LEDCode.c"
	line	343
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 4
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	344
	
l1938:	
	fcall	_initialize
	line	345
	
l1940:	
	clrf	(_current_floor)
	clrf	(_current_floor+1)
	line	346
	
l1942:	
	movlw	low(-1)
	movwf	(_destination_floor)
	movlw	high(-1)
	movwf	((_destination_floor))+1
	line	348
	
l1944:	
	fcall	_disp
	line	350
	
l1946:	
	fcall	_button_press
	movf	(1+(?_button_press)),w
	movwf	(_button+1)
	movf	(0+(?_button_press)),w
	movwf	(_button)
	line	351
	
l1948:	
	incf	(_button),w
	skipnz
	incf	(_button+1),w

	skipnz
	goto	u2041
	goto	u2040
u2041:
	goto	l1960
u2040:
	
l1950:	
	incf	(_destination_floor),w
	skipnz
	incf	(_destination_floor+1),w

	skipz
	goto	u2051
	goto	u2050
u2051:
	goto	l1960
u2050:
	line	352
	
l1952:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_main+0)+0
	addwf	(??_main+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	fcall	_button_direction
	movf	(0+(?_button_direction)),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(1+(?_button_direction)),w
	movwf	indf
	line	353
	
l1954:	
	fcall	_button_to_floor
	movf	(1+(?_button_to_floor)),w
	movwf	(_destination_floor+1)
	movf	(0+(?_button_to_floor)),w
	movwf	(_destination_floor)
	line	354
	
l1956:	
	movlw	(01h)
	fcall	_cmd
	line	355
	
l1958:	
	fcall	_moving
	line	356
	goto	l1946
	line	357
	
l1960:	
	incf	(_destination_floor),w
	skipnz
	incf	(_destination_floor+1),w

	skipnz
	goto	u2061
	goto	u2060
u2061:
	goto	l1966
u2060:
	line	358
	
l1962:	
	movlw	(01h)
	fcall	_cmd
	goto	l1958
	line	362
	
l1966:	
	fcall	_nearest_call
	movf	(1+(?_nearest_call)),w
	movwf	(_destination_floor+1)
	movf	(0+(?_nearest_call)),w
	movwf	(_destination_floor)
	goto	l1946
	global	start
	ljmp	start
	opt stack 0
psect	maintext
	line	364
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_moving
psect	text352,local,class=CODE,delta=2
global __ptext352
__ptext352:

;; *************** function _moving *****************
;; Defined at:
;;		line 275 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  counter         2   20[BANK0 ] short 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       2
;;      Temps:          0       9
;;      Totals:         0      11
;;Total ram usage:       11 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_disp
;;		_button_press
;;		_set_floor
;;		_set_destination
;;		_cmd
;;		_floor_details
;;		_cabin_call_min
;;		_cabin_call_max
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text352
	file	"LEDCode.c"
	line	275
	global	__size_of_moving
	__size_of_moving	equ	__end_of_moving-_moving
	
_moving:	
	opt	stack 4
; Regs used in _moving: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	276
	
l1840:	
	clrf	(moving@counter)
	clrf	(moving@counter+1)
	line	277
	goto	l1898
	line	280
	
l1842:	
	fcall	_disp
	line	281
	goto	l1890
	line	282
	
l1844:	
	bcf	status, 5	;RP0=0, select bank0
	incf	(moving@counter),f
	skipnz
	incf	(moving@counter+1),f
	line	283
	
l1846:	
	fcall	_button_press
	movf	(1+(?_button_press)),w
	movwf	(_button+1)
	movf	(0+(?_button_press)),w
	movwf	(_button)
	line	284
	
l1848:	
	incf	(_button),w
	skipnz
	incf	(_button+1),w

	skipnz
	goto	u1821
	goto	u1820
u1821:
	goto	l1852
u1820:
	line	285
	
l1850:	
	fcall	_set_floor
	line	286
	fcall	_set_destination
	line	288
	
l1852:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_current_floor+1),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_destination_floor+1),w
	xorlw	80h
	subwf	(??_moving+0)+0,w
	skipz
	goto	u1835
	movf	(_destination_floor),w
	subwf	(_current_floor),w
u1835:

	skipnc
	goto	u1831
	goto	u1830
u1831:
	goto	l1858
u1830:
	
l1854:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
	decf	0+(??_moving+0)+0,w
	iorwf	1+(??_moving+0)+0,w

	skipnz
	goto	u1841
	goto	u1840
u1841:
	goto	l1862
u1840:
	
l1856:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
	movf	1+(??_moving+0)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1855
	movlw	low(03h)
	subwf	0+(??_moving+0)+0,w
u1855:

	skipnc
	goto	u1851
	goto	u1850
u1851:
	goto	l1862
u1850:
	
l1858:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_destination_floor+1),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_current_floor+1),w
	xorlw	80h
	subwf	(??_moving+0)+0,w
	skipz
	goto	u1865
	movf	(_current_floor),w
	subwf	(_destination_floor),w
u1865:

	skipnc
	goto	u1861
	goto	u1860
u1861:
	goto	l1882
u1860:
	
l1860:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
	movf	1+(??_moving+0)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(02h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1875
	movlw	low(02h)
	subwf	0+(??_moving+0)+0,w
u1875:

	skipc
	goto	u1871
	goto	u1870
u1871:
	goto	l1882
u1870:
	line	289
	
l1862:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_current_floor+1),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_destination_floor+1),w
	xorlw	80h
	subwf	(??_moving+0)+0,w
	skipz
	goto	u1885
	movf	(_destination_floor),w
	subwf	(_current_floor),w
u1885:

	skipnc
	goto	u1881
	goto	u1880
u1881:
	goto	l1868
u1880:
	
l1864:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
	movf	1+(??_moving+0)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1895
	movlw	low(03h)
	subwf	0+(??_moving+0)+0,w
u1895:

	skipc
	goto	u1891
	goto	u1890
u1891:
	goto	l1868
u1890:
	line	290
	
l1866:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	low(02h)
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movlw	high(02h)
	movwf	indf
	line	291
	
l1868:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_destination_floor+1),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_current_floor+1),w
	xorlw	80h
	subwf	(??_moving+0)+0,w
	skipz
	goto	u1905
	movf	(_current_floor),w
	subwf	(_destination_floor),w
u1905:

	skipnc
	goto	u1901
	goto	u1900
u1901:
	goto	l317
u1900:
	
l1870:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
	movf	1+(??_moving+0)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1915
	movlw	low(03h)
	subwf	0+(??_moving+0)+0,w
u1915:

	skipc
	goto	u1911
	goto	u1910
u1911:
	goto	l317
u1910:
	line	292
	
l1872:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	low(01h)
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movlw	high(01h)
	movwf	indf
	
l317:	
	line	293
	bcf	status, 5	;RP0=0, select bank0
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	decf	indf,w
	skipz
	goto	u1921
	goto	u1920
u1921:
	goto	l1876
u1920:
	line	294
	
l1874:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	295
	
l1876:	
	movlw	(01h)
	fcall	_cmd
	line	298
	
l1878:	
	fcall	_disp
	line	299
	
l1880:	
	fcall	_floor_details
	line	300
	goto	l1892
	line	302
	
l1882:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	decf	indf,w
	skipz
	goto	u1931
	goto	u1930
u1931:
	goto	l1890
u1930:
	line	303
	
l1884:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	304
	
l1886:	
	movlw	(01h)
	fcall	_cmd
	goto	l1842
	line	281
	
l1890:	
	movf	(moving@counter+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(0BB9h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1945
	movlw	low(0BB9h)
	subwf	(moving@counter),w
u1945:

	skipc
	goto	u1941
	goto	u1940
u1941:
	goto	l1844
u1940:
	line	310
	
l1892:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(moving@counter)
	clrf	(moving@counter+1)
	line	311
	
l1894:	
	movf	(_current_floor),w
	subwf	(_destination_floor),w
	movwf	(??_moving+0)+0
	movf	(_current_floor+1),w
	skipc
	incf	(_current_floor+1),w
	subwf	(_destination_floor+1),w
	movwf	1+(??_moving+0)+0
	movlw	0
	btfsc	1+(??_moving+0)+0,7
	movlw	1
	movwf	(??_moving+2)+0
	clrf	(??_moving+2)+0+1
	movf	(_current_floor),w
	subwf	(_destination_floor),w
	movwf	(??_moving+4)+0
	movf	(_current_floor+1),w
	skipc
	incf	(_current_floor+1),w
	subwf	(_destination_floor+1),w
	movwf	1+(??_moving+4)+0
	movf	1+(??_moving+4)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(01h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1955
	movlw	low(01h)
	subwf	0+(??_moving+4)+0,w
u1955:

	movlw	0
	skipnc
	movlw	1
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_moving+6)+0
	movf	0+(??_moving+2)+0,w
	subwf	(??_moving+6)+0,w
	movwf	(??_moving+7)+0
	comf	1+(??_moving+2)+0,w
	skipnc
	addlw	1
	movwf	((??_moving+7)+0)+1
	movf	(_current_floor),w
	addwf	0+(??_moving+7)+0,w
	movwf	(_current_floor)
	movf	(_current_floor+1),w
	skipnc
	incf	(_current_floor+1),w
	addwf	1+(??_moving+7)+0,w
	movwf	1+(_current_floor)
	line	312
	
l1896:	
	movlw	(01h)
	fcall	_cmd
	line	277
	
l1898:	
	movf	(_destination_floor+1),w
	xorwf	(_current_floor+1),w
	skipz
	goto	u1965
	movf	(_destination_floor),w
	xorwf	(_current_floor),w
u1965:

	skipz
	goto	u1961
	goto	u1960
u1961:
	goto	l1842
u1960:
	line	314
	
l1900:	
	clrc
	rlf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	incf	fsr0,f
	iorwf	indf,w
	skipnz
	goto	u1971
	goto	u1970
u1971:
	goto	l1928
u1970:
	line	315
	
l1902:	
	movf	(_destination_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u1981
	goto	u1980
u1981:
	goto	l1906
u1980:
	line	316
	
l1904:	
	movf	(_destination_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	319
	
l1906:	
	fcall	_disp
	line	320
	
l1908:	
	movlw	low(-1)
	movwf	(_destination_floor)
	movlw	high(-1)
	movwf	((_destination_floor))+1
	line	321
	
l1910:	
	fcall	_floor_details
	line	322
	
l1912:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	btfsc	indf,(0)&7
	goto	u1991
	goto	u1990
u1991:
	goto	l1920
u1990:
	line	323
	
l1914:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
		movf	0+(??_moving+0)+0,w
	xorlw	4
	iorwf	1+(??_moving+0)+0,w

	skipz
	goto	u2001
	goto	u2000
u2001:
	goto	l1918
u2000:
	line	324
	
l1916:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	low(01h)
	movwf	indf
	incf	fsr0,f
	movlw	high(01h)
	movwf	indf
	line	325
	
l1918:	
	fcall	_cabin_call_min
	bcf	status, 5	;RP0=0, select bank0
	movf	(1+(?_cabin_call_min)),w
	movwf	(_destination_floor+1)
	movf	(0+(?_cabin_call_min)),w
	movwf	(_destination_floor)
	line	326
	goto	l331
	line	327
	
l1920:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	btfss	indf,(0)&7
	goto	u2011
	goto	u2010
u2011:
	goto	l331
u2010:
	line	328
	
l1922:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	movwf	(??_moving+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_moving+0)+0+1
		movf	0+(??_moving+0)+0,w
	xorlw	3
	iorwf	1+(??_moving+0)+0,w

	skipz
	goto	u2021
	goto	u2020
u2021:
	goto	l1926
u2020:
	line	329
	
l1924:	
	clrc
	rlf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	low(02h)
	movwf	indf
	incf	fsr0,f
	movlw	high(02h)
	movwf	indf
	line	330
	
l1926:	
	fcall	_cabin_call_max
	movf	(1+(?_cabin_call_max)),w
	movwf	(_destination_floor+1)
	movf	(0+(?_cabin_call_max)),w
	movwf	(_destination_floor)
	goto	l331
	line	333
	
l1928:	
	movf	(_destination_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u2031
	goto	u2030
u2031:
	goto	l331
u2030:
	line	334
	
l1930:	
	movf	(_destination_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	335
	
l1932:	
	movlw	(01h)
	fcall	_cmd
	line	338
	
l1934:	
	fcall	_disp
	line	339
	
l1936:	
	movlw	low(-1)
	movwf	(_destination_floor)
	movlw	high(-1)
	movwf	((_destination_floor))+1
	line	341
	
l331:	
	return
	opt stack 0
GLOBAL	__end_of_moving
	__end_of_moving:
;; =============== function _moving ends ============

	signat	_moving,88
	global	_floor_details
psect	text353,local,class=CODE,delta=2
global __ptext353
__ptext353:

;; *************** function _floor_details *****************
;; Defined at:
;;		line 191 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2    9[BANK0 ] short 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       2
;;      Temps:          0       0
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_cmd
;;		_disp
;;		_button_press
;;		_button_to_floor
;;		_clr_char
;;		_set_floor
;;		_set_destination
;;		_strlen
;; This function is called by:
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text353
	file	"LEDCode.c"
	line	191
	global	__size_of_floor_details
	__size_of_floor_details	equ	__end_of_floor_details-_floor_details
	
_floor_details:	
	opt	stack 4
; Regs used in _floor_details: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	192
	
l1738:	
	movlw	(0C0h)
	fcall	_cmd
	line	194
	
l1740:	
	fcall	_disp
	line	195
	
l1742:	
	clrf	(floor_details@i)
	clrf	(floor_details@i+1)
	line	197
	
l1744:	
	fcall	_disp
	line	198
	
l1746:	
	fcall	_button_press
	movf	(1+(?_button_press)),w
	movwf	(_button+1)
	movf	(0+(?_button_press)),w
	movwf	(_button)
	line	199
	goto	l1776
	line	200
	
l1748:	
	incf	(_button),w
	skipnz
	incf	(_button+1),w

	skipnz
	goto	u1641
	goto	u1640
u1641:
	goto	l1746
u1640:
	line	201
	
l1750:	
	fcall	_button_to_floor
	movf	(_current_floor+1),w
	xorwf	(1+(?_button_to_floor)),w
	skipz
	goto	u1655
	movf	(_current_floor),w
	xorwf	(0+(?_button_to_floor)),w
u1655:

	skipz
	goto	u1651
	goto	u1650
u1651:
	goto	l1772
u1650:
	line	202
	
l1752:	
	btfss	(_button),(0)&7
	goto	u1661
	goto	u1660
u1661:
	goto	l1762
u1660:
	
l1754:	
	decf	(_button),w
	iorwf	(_button+1),w

	skipnz
	goto	u1671
	goto	u1670
u1671:
	goto	l1762
u1670:
	line	203
	
l1756:	
	movf	((floor_details@i+1)),w
	iorwf	((floor_details@i)),w
	skipz
	goto	u1681
	goto	u1680
u1681:
	goto	l1760
u1680:
	line	204
	
l1758:	
	movlw	06h
	movwf	(floor_details@i)
	clrf	(floor_details@i+1)
	line	205
	
l1760:	
	movlw	-1
	addwf	(floor_details@i),f
	skipc
	decf	(floor_details@i+1),f
	line	206
	goto	l1768
	line	208
	
l1762:	
		movf	(floor_details@i),w
	xorlw	5
	iorwf	(floor_details@i+1),w

	skipz
	goto	u1691
	goto	u1690
u1691:
	goto	l1766
u1690:
	line	209
	
l1764:	
	movlw	low(-1)
	movwf	(floor_details@i)
	movlw	high(-1)
	movwf	((floor_details@i))+1
	line	210
	
l1766:	
	incf	(floor_details@i),f
	skipnz
	incf	(floor_details@i+1),f
	line	212
	
l1768:	
	clrf	(?_clr_char)
	incf	(?_clr_char),f
	clrf	(?_clr_char+1)
	fcall	_clr_char
	goto	l1744
	line	217
	
l1772:	
	fcall	_set_floor
	line	218
	fcall	_set_destination
	goto	l1746
	line	199
	
l1776:	
		movf	(_button),w
	xorlw	7
	iorwf	(_button+1),w

	skipz
	goto	u1701
	goto	u1700
u1701:
	goto	l1748
u1700:
	line	223
	
l1778:	
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_strlen
	movf	(1+(?_strlen)),w
	movwf	(?_clr_char+1)
	movf	(0+(?_strlen)),w
	movwf	(?_clr_char)
	fcall	_clr_char
	line	225
	
l1780:	
	fcall	_disp
	line	226
	
l1782:	
	clrf	(floor_details@i)
	clrf	(floor_details@i+1)
	line	228
	
l1784:	
	fcall	_disp
	line	230
	
l1786:	
	fcall	_button_press
	movf	(1+(?_button_press)),w
	movwf	(_button+1)
	movf	(0+(?_button_press)),w
	movwf	(_button)
	line	231
	
l1788:	
	incf	(_button),w
	skipnz
	incf	(_button+1),w

	skipnz
	goto	u1711
	goto	u1710
u1711:
	goto	l1786
u1710:
	line	232
	
l1790:	
	fcall	_button_to_floor
	movf	(_current_floor+1),w
	xorwf	(1+(?_button_to_floor)),w
	skipz
	goto	u1725
	movf	(_current_floor),w
	xorwf	(0+(?_button_to_floor)),w
u1725:

	skipz
	goto	u1721
	goto	u1720
u1721:
	goto	l1826
u1720:
	line	233
	
l1792:	
	btfss	(_button),(0)&7
	goto	u1731
	goto	u1730
u1731:
	goto	l1810
u1730:
	
l1794:	
	decf	(_button),w
	iorwf	(_button+1),w

	skipnz
	goto	u1741
	goto	u1740
u1741:
	goto	l1810
u1740:
	line	234
	
l1796:	
	movf	((floor_details@i+1)),w
	iorwf	((floor_details@i)),w
	skipz
	goto	u1751
	goto	u1750
u1751:
	goto	l1800
u1750:
	line	235
	
l1798:	
	movlw	05h
	movwf	(floor_details@i)
	clrf	(floor_details@i+1)
	line	236
	
l1800:	
	movlw	-1
	addwf	(floor_details@i),f
	skipc
	decf	(floor_details@i+1),f
	line	237
	
l1802:	
	movf	(_current_floor+1),w
	xorwf	(floor_details@i+1),w
	skipz
	goto	u1765
	movf	(_current_floor),w
	xorwf	(floor_details@i),w
u1765:

	skipz
	goto	u1761
	goto	u1760
u1761:
	goto	l1808
u1760:
	line	238
	
l1804:	
	movf	((floor_details@i+1)),w
	iorwf	((floor_details@i)),w
	skipz
	goto	u1771
	goto	u1770
u1771:
	goto	l1808
u1770:
	line	239
	
l1806:	
	movlw	05h
	movwf	(floor_details@i)
	clrf	(floor_details@i+1)
	line	240
	
l1808:	
	movlw	-1
	addwf	(floor_details@i),f
	skipc
	decf	(floor_details@i+1),f
	line	241
	goto	l1784
	line	243
	
l1810:	
		movf	(floor_details@i),w
	xorlw	4
	iorwf	(floor_details@i+1),w

	skipz
	goto	u1781
	goto	u1780
u1781:
	goto	l1814
u1780:
	line	244
	
l1812:	
	movlw	low(-1)
	movwf	(floor_details@i)
	movlw	high(-1)
	movwf	((floor_details@i))+1
	line	245
	
l1814:	
	incf	(floor_details@i),f
	skipnz
	incf	(floor_details@i+1),f
	line	246
	
l1816:	
	movf	(_current_floor+1),w
	xorwf	(floor_details@i+1),w
	skipz
	goto	u1795
	movf	(_current_floor),w
	xorwf	(floor_details@i),w
u1795:

	skipz
	goto	u1791
	goto	u1790
u1791:
	goto	l1820
u1790:
	line	247
	
l1818:	
	incf	(floor_details@i),f
	skipnz
	incf	(floor_details@i+1),f
	goto	l1784
	line	250
	
l1820:	
	goto	l1784
	line	259
	
l1826:	
		movf	(_button),w
	xorlw	7
	iorwf	(_button+1),w

	skipz
	goto	u1801
	goto	u1800
u1801:
	goto	l1836
u1800:
	line	260
	
l1828:	
		movf	(floor_details@i),w
	xorlw	4
	iorwf	(floor_details@i+1),w

	skipz
	goto	u1811
	goto	u1810
u1811:
	goto	l1834
u1810:
	goto	l1838
	line	263
	
l1834:	
	movf	(floor_details@i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	clrf	indf
	incf	indf,f
	goto	l1786
	line	267
	
l1836:	
	fcall	_set_floor
	line	268
	fcall	_set_destination
	goto	l1786
	line	272
	
l1838:	
	movlw	((STR_2-__stringbase))&0ffh
	fcall	_strlen
	movf	(1+(?_strlen)),w
	movwf	(?_clr_char+1)
	movf	(0+(?_strlen)),w
	movwf	(?_clr_char)
	fcall	_clr_char
	line	273
	
l303:	
	return
	opt stack 0
GLOBAL	__end_of_floor_details
	__end_of_floor_details:
;; =============== function _floor_details ends ============

	signat	_floor_details,88
	global	_initialize
psect	text354,local,class=CODE,delta=2
global __ptext354
__ptext354:

;; *************** function _initialize *****************
;; Defined at:
;;		line 87 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_cmd
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text354
	file	"LEDCode.c"
	line	87
	global	__size_of_initialize
	__size_of_initialize	equ	__end_of_initialize-_initialize
	
_initialize:	
	opt	stack 6
; Regs used in _initialize: [wreg+status,2+status,0+pclath+cstack]
	line	89
	
l1722:	
	clrf	(5)	;volatile
	line	90
	clrf	(6)	;volatile
	line	91
	bsf	status, 5	;RP0=1, select bank1
	clrf	(134)^080h	;volatile
	line	92
	
l1724:	
	bsf	(1064/8)^080h,(1064)&7
	line	93
	
l1726:	
	bsf	(1065/8)^080h,(1065)&7
	line	94
	
l1728:	
	bsf	(1066/8)^080h,(1066)&7
	line	95
	
l1730:	
	bcf	(1067/8)^080h,(1067)&7
	line	96
	
l1732:	
	bcf	(1068/8)^080h,(1068)&7
	line	99
	
l1734:	
	movlw	(0Eh)
	fcall	_cmd
	line	100
	
l1736:	
	movlw	(01h)
	fcall	_cmd
	line	101
	
l197:	
	return
	opt stack 0
GLOBAL	__end_of_initialize
	__end_of_initialize:
;; =============== function _initialize ends ============

	signat	_initialize,88
	global	_clr_char
psect	text355,local,class=CODE,delta=2
global __ptext355
__ptext355:

;; *************** function _clr_char *****************
;; Defined at:
;;		line 76 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;  spaces          2    4[BANK0 ] short 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       3
;;      Totals:         0       5
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_cmd
;;		_disp
;; This function is called by:
;;		_floor_details
;; This function uses a non-reentrant model
;;
psect	text355
	file	"LEDCode.c"
	line	76
	global	__size_of_clr_char
	__size_of_clr_char	equ	__end_of_clr_char-_clr_char
	
_clr_char:	
	opt	stack 4
; Regs used in _clr_char: [wreg+status,2+status,0+pclath+cstack]
	line	77
	
l1708:	
	clrf	(_i)
	clrf	(_i+1)
	goto	l1712
	
l1710:	
	bcf	status, 5	;RP0=0, select bank0
	incf	(_i),f
	skipnz
	incf	(_i+1),f
	
l1712:	
	movf	(clr_char@spaces),w
	addlw	low(01h)
	movwf	(??_clr_char+0)+0
	movf	(clr_char@spaces+1),w
	skipnc
	addlw	1
	addlw	high(01h)
	movwf	1+(??_clr_char+0)+0
	movf	(_i+1),w
	xorlw	80h
	movwf	(??_clr_char+2)+0
	movf	1+(??_clr_char+0)+0,w
	xorlw	80h
	subwf	(??_clr_char+2)+0,w
	skipz
	goto	u1635
	movf	0+(??_clr_char+0)+0,w
	subwf	(_i),w
u1635:

	skipc
	goto	u1631
	goto	u1630
u1631:
	goto	l1710
u1630:
	line	81
	
l1714:	
	movlw	(04h)
	fcall	_cmd
	line	82
	
l1716:	
	fcall	_disp
	line	83
	
l1718:	
	movlw	(06h)
	fcall	_cmd
	line	84
	
l1720:	
	movlw	(014h)
	fcall	_cmd
	line	85
	
l194:	
	return
	opt stack 0
GLOBAL	__end_of_clr_char
	__end_of_clr_char:
;; =============== function _clr_char ends ============

	signat	_clr_char,4216
	global	_set_destination
psect	text356,local,class=CODE,delta=2
global __ptext356
__ptext356:

;; *************** function _set_destination *****************
;; Defined at:
;;		line 182 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 0/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       2
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_button_direction
;;		_button_to_floor
;; This function is called by:
;;		_floor_details
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text356
	file	"LEDCode.c"
	line	182
	global	__size_of_set_destination
	__size_of_set_destination	equ	__end_of_set_destination-_set_destination
	
_set_destination:	
	opt	stack 4
; Regs used in _set_destination: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	183
	
l1686:	
	incf	(_destination_floor),w
	skipnz
	incf	(_destination_floor+1),w

	skipnz
	goto	u1541
	goto	u1540
u1541:
	goto	l271
u1540:
	line	184
	
l1688:	
	movf	(_current_floor+1),w
	xorlw	80h
	movwf	(??_set_destination+0)+0
	movf	(_destination_floor+1),w
	xorlw	80h
	subwf	(??_set_destination+0)+0,w
	skipz
	goto	u1555
	movf	(_destination_floor),w
	subwf	(_current_floor),w
u1555:

	skipnc
	goto	u1551
	goto	u1550
u1551:
	goto	l1698
u1550:
	
l1690:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_destination+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_destination+0)+0+1
	fcall	_button_direction
	movf	1+(??_set_destination+0)+0,w
	xorwf	(1+(?_button_direction)),w
	skipz
	goto	u1565
	movf	0+(??_set_destination+0)+0,w
	xorwf	(0+(?_button_direction)),w
u1565:

	skipnz
	goto	u1561
	goto	u1560
u1561:
	goto	l1694
u1560:
	
l1692:	
	clrc
	rlf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_destination+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_destination+0)+0+1
	movf	1+(??_set_destination+0)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1575
	movlw	low(03h)
	subwf	0+(??_set_destination+0)+0,w
u1575:

	skipc
	goto	u1571
	goto	u1570
u1571:
	goto	l1698
u1570:
	
l1694:	
	fcall	_button_to_floor
	movf	(_destination_floor+1),w
	xorlw	80h
	movwf	(??_set_destination+0)+0
	movf	(1+(?_button_to_floor)),w
	xorlw	80h
	subwf	(??_set_destination+0)+0,w
	skipz
	goto	u1585
	movf	(0+(?_button_to_floor)),w
	subwf	(_destination_floor),w
u1585:

	skipnc
	goto	u1581
	goto	u1580
u1581:
	goto	l1698
u1580:
	line	185
	
l1696:	
	fcall	_button_to_floor
	movf	(1+(?_button_to_floor)),w
	movwf	(_destination_floor+1)
	movf	(0+(?_button_to_floor)),w
	movwf	(_destination_floor)
	goto	l271
	line	186
	
l1698:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_destination_floor+1),w
	xorlw	80h
	movwf	(??_set_destination+0)+0
	movf	(_current_floor+1),w
	xorlw	80h
	subwf	(??_set_destination+0)+0,w
	skipz
	goto	u1595
	movf	(_current_floor),w
	subwf	(_destination_floor),w
u1595:

	skipnc
	goto	u1591
	goto	u1590
u1591:
	goto	l271
u1590:
	
l1700:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_destination+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_destination+0)+0+1
	fcall	_button_direction
	movf	1+(??_set_destination+0)+0,w
	xorwf	(1+(?_button_direction)),w
	skipz
	goto	u1605
	movf	0+(??_set_destination+0)+0,w
	xorwf	(0+(?_button_direction)),w
u1605:

	skipnz
	goto	u1601
	goto	u1600
u1601:
	goto	l1704
u1600:
	
l1702:	
	clrc
	rlf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_destination+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_destination+0)+0+1
	movf	1+(??_set_destination+0)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(03h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1615
	movlw	low(03h)
	subwf	0+(??_set_destination+0)+0,w
u1615:

	skipc
	goto	u1611
	goto	u1610
u1611:
	goto	l271
u1610:
	
l1704:	
	fcall	_button_to_floor
	movf	(1+(?_button_to_floor)),w
	xorlw	80h
	movwf	(??_set_destination+0)+0
	movf	(_destination_floor+1),w
	xorlw	80h
	subwf	(??_set_destination+0)+0,w
	skipz
	goto	u1625
	movf	(_destination_floor),w
	subwf	(0+(?_button_to_floor)),w
u1625:

	skipnc
	goto	u1621
	goto	u1620
u1621:
	goto	l271
u1620:
	goto	l1696
	line	189
	
l271:	
	return
	opt stack 0
GLOBAL	__end_of_set_destination
	__end_of_set_destination:
;; =============== function _set_destination ends ============

	signat	_set_destination,88
	global	_set_floor
psect	text357,local,class=CODE,delta=2
global __ptext357
__ptext357:

;; *************** function _set_floor *****************
;; Defined at:
;;		line 173 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       3
;;      Totals:         0       3
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_button_to_floor
;;		_button_direction
;; This function is called by:
;;		_floor_details
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text357
	file	"LEDCode.c"
	line	173
	global	__size_of_set_floor
	__size_of_set_floor	equ	__end_of_set_floor-_set_floor
	
_set_floor:	
	opt	stack 4
; Regs used in _set_floor: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	174
	
l1674:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_set_floor+0)+0
	addwf	(??_set_floor+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_floor+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_floor+1)+0+1
	fcall	_button_direction
	movf	1+(??_set_floor+1)+0,w
	xorwf	(1+(?_button_direction)),w
	skipz
	goto	u1505
	movf	0+(??_set_floor+1)+0,w
	xorwf	(0+(?_button_direction)),w
u1505:

	skipnz
	goto	u1501
	goto	u1500
u1501:
	goto	l260
u1500:
	
l1676:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_set_floor+0)+0
	addwf	(??_set_floor+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_floor+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_floor+1)+0+1
		movf	0+(??_set_floor+1)+0,w
	xorlw	3
	iorwf	1+(??_set_floor+1)+0,w

	skipnz
	goto	u1511
	goto	u1510
u1511:
	goto	l260
u1510:
	
l1678:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_set_floor+0)+0
	addwf	(??_set_floor+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_floor+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_floor+1)+0+1
		movf	0+(??_set_floor+1)+0,w
	xorlw	4
	iorwf	1+(??_set_floor+1)+0,w

	skipnz
	goto	u1521
	goto	u1520
u1521:
	goto	l260
u1520:
	line	175
	
l1680:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_set_floor+0)+0
	addwf	(??_set_floor+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_set_floor+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_set_floor+1)+0+1
		movf	0+(??_set_floor+1)+0,w
	xorlw	2
	iorwf	1+(??_set_floor+1)+0,w

	skipz
	goto	u1531
	goto	u1530
u1531:
	goto	l1684
u1530:
	line	176
	
l1682:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_set_floor+0)+0
	addwf	(??_set_floor+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	low(04h)
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movlw	high(04h)
	movwf	indf
	goto	l260
	line	178
	
l1684:	
	fcall	_button_to_floor
	movf	(0+(?_button_to_floor)),w
	movwf	(??_set_floor+0)+0
	addwf	(??_set_floor+0)+0,w
	addlw	_floor_call&0ffh
	movwf	fsr0
	fcall	_button_direction
	movf	(0+(?_button_direction)),w
	bcf	status, 7	;select IRP bank0
	addwf	indf,f
	incfsz	fsr0,f
	movf	indf,w
	skipnc
	incf	indf,w
	movwf	btemp+1
	movf	(1+(?_button_direction)),w
	addwf	btemp+1,w
	movwf	indf
	decf	fsr0,f
	line	180
	
l260:	
	return
	opt stack 0
GLOBAL	__end_of_set_floor
	__end_of_set_floor:
;; =============== function _set_floor ends ============

	signat	_set_floor,88
	global	_cmd
psect	text358,local,class=CODE,delta=2
global __ptext358
__ptext358:

;; *************** function _cmd *****************
;; Defined at:
;;		line 68 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;  cmd_msg         1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  cmd_msg         1    0[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       1
;;      Temps:          0       0
;;      Totals:         0       1
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_clr_char
;;		_initialize
;;		_floor_details
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text358
	file	"LEDCode.c"
	line	68
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 4
; Regs used in _cmd: [wreg]
	bcf	status, 5	;RP0=0, select bank0
	movwf	(cmd@cmd_msg)
	line	69
	
l1664:	
	movf	(cmd@cmd_msg),w
	movwf	(6)	;volatile
	line	70
	
l1666:	
	bcf	(44/8),(44)&7
	line	71
	
l1668:	
	bsf	(43/8),(43)&7
	line	72
	
l1670:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	73
	
l1672:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	74
	
l188:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
	global	_strlen
psect	text359,local,class=CODE,delta=2
global __ptext359
__ptext359:

;; *************** function _strlen *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\strlen.c"
;; Parameters:    Size  Location     Type
;;  s               1    wreg     PTR const unsigned char 
;;		 -> STR_2(21), STR_1(17), 
;; Auto vars:     Size  Location     Type
;;  s               1    2[BANK0 ] PTR const unsigned char 
;;		 -> STR_2(21), STR_1(17), 
;;  cp              1    3[BANK0 ] PTR const unsigned char 
;;		 -> STR_2(21), STR_1(17), 
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] unsigned int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       2
;;      Temps:          0       0
;;      Totals:         0       4
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_floor_details
;; This function uses a non-reentrant model
;;
psect	text359
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\strlen.c"
	line	5
	global	__size_of_strlen
	__size_of_strlen	equ	__end_of_strlen-_strlen
	
_strlen:	
	opt	stack 4
; Regs used in _strlen: [wreg-fsr0h+status,2+status,0+pclath]
	line	8
	movwf	(strlen@s)
	
l1656:	
	movf	(strlen@s),w
	movwf	(strlen@cp)
	line	9
	
l1658:	
	movf	(strlen@cp),w
	incf	(strlen@cp),f
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u1491
	goto	u1490
u1491:
	goto	l1658
u1490:
	line	11
	
l1660:	
	movf	(strlen@s),w
	subwf	(strlen@cp),w
	movwf	(?_strlen)
	clrf	(?_strlen+1)
	btfsc	(?_strlen),7
	decf	(?_strlen+1),f
	movlw	-1
	addwf	(?_strlen),f
	skipc
	decf	(?_strlen+1),f
	line	12
	
l555:	
	return
	opt stack 0
GLOBAL	__end_of_strlen
	__end_of_strlen:
;; =============== function _strlen ends ============

	signat	_strlen,4218
	global	_nearest_call
psect	text360,local,class=CODE,delta=2
global __ptext360
__ptext360:

;; *************** function _nearest_call *****************
;; Defined at:
;;		line 161 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] short 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text360
	file	"LEDCode.c"
	line	161
	global	__size_of_nearest_call
	__size_of_nearest_call	equ	__end_of_nearest_call-_nearest_call
	
_nearest_call:	
	opt	stack 7
; Regs used in _nearest_call: [wreg-fsr0h+status,2+status,0+btemp+1]
	line	162
	
l1620:	
	movf	(_current_floor+1),w
	movwf	(_i+1)
	movf	(_current_floor),w
	movwf	(_i)
	
l1622:	
	movlw	-1
	addwf	(_i),f
	skipc
	decf	(_i+1),f
	
l1624:	
	movf	(_current_floor+1),w
	movwf	(_j+1)
	movf	(_current_floor),w
	movwf	(_j)
	
l1626:	
	incf	(_j),f
	skipnz
	incf	(_j+1),f
	goto	l243
	line	163
	
l1628:	
	movf	(_j+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(04h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1415
	movlw	low(04h)
	subwf	(_j),w
u1415:

	skipnc
	goto	u1411
	goto	u1410
u1411:
	goto	l245
u1410:
	line	164
	
l1630:	
	bcf	status, 5	;RP0=0, select bank0
	clrc
	rlf	(_j),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	incf	fsr0,f
	iorwf	indf,w
	skipz
	goto	u1421
	goto	u1420
u1421:
	goto	l1634
u1420:
	
l1632:	
	movf	(_j),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u1431
	goto	u1430
u1431:
	goto	l245
u1430:
	line	165
	
l1634:	
	movf	(_j+1),w
	movwf	(?_nearest_call+1)
	movf	(_j),w
	movwf	(?_nearest_call)
	goto	l249
	line	166
	
l245:	
	bcf	status, 5	;RP0=0, select bank0
	btfsc	(_i+1),7
	goto	u1441
	goto	u1440
u1441:
	goto	l1646
u1440:
	line	167
	
l1638:	
	clrc
	rlf	(_i),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	incf	fsr0,f
	iorwf	indf,w
	skipz
	goto	u1451
	goto	u1450
u1451:
	goto	l1642
u1450:
	
l1640:	
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u1461
	goto	u1460
u1461:
	goto	l1646
u1460:
	line	168
	
l1642:	
	movf	(_i+1),w
	movwf	(?_nearest_call+1)
	movf	(_i),w
	movwf	(?_nearest_call)
	goto	l249
	line	162
	
l1646:	
	movlw	-1
	addwf	(_i),f
	skipc
	decf	(_i+1),f
	goto	l1626
	
l243:	
	incf	(_i),w
	skipnz
	incf	(_i+1),w

	skipz
	goto	u1471
	goto	u1470
u1471:
	goto	l1628
u1470:
	
l1650:	
		movf	(_j),w
	xorlw	4
	iorwf	(_j+1),w

	skipz
	goto	u1481
	goto	u1480
u1481:
	goto	l1628
u1480:
	line	170
	
l1652:	
	movlw	low(-1)
	movwf	(?_nearest_call)
	movlw	high(-1)
	movwf	((?_nearest_call))+1
	line	171
	
l249:	
	return
	opt stack 0
GLOBAL	__end_of_nearest_call
	__end_of_nearest_call:
;; =============== function _nearest_call ends ============

	signat	_nearest_call,90
	global	_cabin_call_min
psect	text361,local,class=CODE,delta=2
global __ptext361
__ptext361:

;; *************** function _cabin_call_min *****************
;; Defined at:
;;		line 154 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] short 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1
;; Tracked objects:
;;		On entry : 120/0
;;		On exit  : 0/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text361
	file	"LEDCode.c"
	line	154
	global	__size_of_cabin_call_min
	__size_of_cabin_call_min	equ	__end_of_cabin_call_min-_cabin_call_min
	
_cabin_call_min:	
	opt	stack 6
; Regs used in _cabin_call_min: [wreg-fsr0h+status,2+status,0+btemp+1]
	line	155
	
l1604:	
	clrf	(_i)
	clrf	(_i+1)
	
l1606:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(04h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1395
	movlw	low(04h)
	subwf	(_i),w
u1395:

	skipc
	goto	u1391
	goto	u1390
u1391:
	goto	l1610
u1390:
	goto	l240
	line	156
	
l1610:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	decf	indf,w
	skipz
	goto	u1401
	goto	u1400
u1401:
	goto	l1616
u1400:
	line	157
	
l1612:	
	movf	(_i+1),w
	movwf	(?_cabin_call_min+1)
	movf	(_i),w
	movwf	(?_cabin_call_min)
	goto	l240
	line	155
	
l1616:	
	incf	(_i),f
	skipnz
	incf	(_i+1),f
	goto	l1606
	line	159
	
l240:	
	return
	opt stack 0
GLOBAL	__end_of_cabin_call_min
	__end_of_cabin_call_min:
;; =============== function _cabin_call_min ends ============

	signat	_cabin_call_min,90
	global	_cabin_call_max
psect	text362,local,class=CODE,delta=2
global __ptext362
__ptext362:

;; *************** function _cabin_call_max *****************
;; Defined at:
;;		line 147 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] short 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 120/0
;;		On exit  : 120/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text362
	file	"LEDCode.c"
	line	147
	global	__size_of_cabin_call_max
	__size_of_cabin_call_max	equ	__end_of_cabin_call_max-_cabin_call_max
	
_cabin_call_max:	
	opt	stack 6
; Regs used in _cabin_call_max: [wreg-fsr0h+status,2+status,0]
	line	148
	
l1588:	
	movlw	03h
	movwf	(_i)
	clrf	(_i+1)
	
l1590:	
	btfss	(_i+1),7
	goto	u1371
	goto	u1370
u1371:
	goto	l1594
u1370:
	goto	l234
	line	149
	
l1594:	
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u1381
	goto	u1380
u1381:
	goto	l1600
u1380:
	line	150
	
l1596:	
	movf	(_i+1),w
	movwf	(?_cabin_call_max+1)
	movf	(_i),w
	movwf	(?_cabin_call_max)
	goto	l234
	line	148
	
l1600:	
	movlw	-1
	addwf	(_i),f
	skipc
	decf	(_i+1),f
	goto	l1590
	line	152
	
l234:	
	return
	opt stack 0
GLOBAL	__end_of_cabin_call_max
	__end_of_cabin_call_max:
;; =============== function _cabin_call_max ends ============

	signat	_cabin_call_max,90
	global	_button_direction
psect	text363,local,class=CODE,delta=2
global __ptext363
__ptext363:

;; *************** function _button_direction *****************
;; Defined at:
;;		line 133 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] short 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_set_floor
;;		_set_destination
;;		_main
;; This function uses a non-reentrant model
;;
psect	text363
	file	"LEDCode.c"
	line	133
	global	__size_of_button_direction
	__size_of_button_direction	equ	__end_of_button_direction-_button_direction
	
_button_direction:	
	opt	stack 4
; Regs used in _button_direction: [wreg+status,2+status,0+btemp+1]
	line	134
	
l1544:	
	decf	(_button),w
	iorwf	(_button+1),w

	skipz
	goto	u1301
	goto	u1300
u1301:
	goto	l1550
u1300:
	line	135
	
l1546:	
	clrf	(?_button_direction)
	incf	(?_button_direction),f
	clrf	(?_button_direction+1)
	goto	l222
	line	136
	
l1550:	
	movlw	02h
	movwf	(_i)
	clrf	(_i+1)
	
l1552:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(05h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1315
	movlw	low(05h)
	subwf	(_i),w
u1315:

	skipc
	goto	u1311
	goto	u1310
u1311:
	goto	l1556
u1310:
	goto	l1578
	line	137
	
l1556:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_i+1),w
	xorwf	(_button+1),w
	skipz
	goto	u1325
	movf	(_i),w
	xorwf	(_button),w
u1325:

	skipz
	goto	u1321
	goto	u1320
u1321:
	goto	l1566
u1320:
	
l1558:	
	btfsc	(_i),(0)&7
	goto	u1331
	goto	u1330
u1331:
	goto	l1566
u1330:
	goto	l1546
	line	139
	
l1566:	
	movf	(_i+1),w
	xorwf	(_button+1),w
	skipz
	goto	u1345
	movf	(_i),w
	xorwf	(_button),w
u1345:

	skipz
	goto	u1341
	goto	u1340
u1341:
	goto	l1574
u1340:
	
l1568:	
	btfss	(_i),(0)&7
	goto	u1351
	goto	u1350
u1351:
	goto	l1574
u1350:
	line	140
	
l1570:	
	movlw	02h
	movwf	(?_button_direction)
	clrf	(?_button_direction+1)
	goto	l222
	line	136
	
l1574:	
	incf	(_i),f
	skipnz
	incf	(_i+1),f
	goto	l1552
	line	142
	
l1578:	
	bcf	status, 5	;RP0=0, select bank0
		movf	(_button),w
	xorlw	6
	iorwf	(_button+1),w

	skipz
	goto	u1361
	goto	u1360
u1361:
	goto	l1584
u1360:
	goto	l1570
	line	144
	
l1584:	
	movlw	low(-1)
	movwf	(?_button_direction)
	movlw	high(-1)
	movwf	((?_button_direction))+1
	line	145
	
l222:	
	return
	opt stack 0
GLOBAL	__end_of_button_direction
	__end_of_button_direction:
;; =============== function _button_direction ends ============

	signat	_button_direction,90
	global	_button_to_floor
psect	text364,local,class=CODE,delta=2
global __ptext364
__ptext364:

;; *************** function _button_to_floor *****************
;; Defined at:
;;		line 121 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] short 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 20/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       2
;;      Totals:         0       4
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_set_floor
;;		_set_destination
;;		_floor_details
;;		_main
;; This function uses a non-reentrant model
;;
psect	text364
	file	"LEDCode.c"
	line	121
	global	__size_of_button_to_floor
	__size_of_button_to_floor	equ	__end_of_button_to_floor-_button_to_floor
	
_button_to_floor:	
	opt	stack 4
; Regs used in _button_to_floor: [wreg+status,2+status,0+btemp+1]
	line	122
	
l1510:	
	bcf	status, 5	;RP0=0, select bank0
	decf	(_button),w
	iorwf	(_button+1),w

	skipz
	goto	u1251
	goto	u1250
u1251:
	goto	l1516
u1250:
	line	123
	
l1512:	
	clrf	(?_button_to_floor)
	clrf	(?_button_to_floor+1)
	goto	l211
	line	124
	
l1516:	
	movlw	02h
	movwf	(_i)
	clrf	(_i+1)
	
l1518:	
	clrf	(_j)
	incf	(_j),f
	clrf	(_j+1)
	goto	l1532
	line	125
	
l1520:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_i+1),w
	xorwf	(_button+1),w
	skipz
	goto	u1265
	movf	(_i),w
	xorwf	(_button),w
u1265:

	skipnz
	goto	u1261
	goto	u1260
u1261:
	goto	l1524
u1260:
	
l1522:	
	movf	(_i),w
	addlw	low(01h)
	movwf	(??_button_to_floor+0)+0
	movf	(_i+1),w
	skipnc
	addlw	1
	addlw	high(01h)
	movwf	1+(??_button_to_floor+0)+0
	movf	(_button+1),w
	xorwf	1+(??_button_to_floor+0)+0,w
	skipz
	goto	u1275
	movf	(_button),w
	xorwf	0+(??_button_to_floor+0)+0,w
u1275:

	skipz
	goto	u1271
	goto	u1270
u1271:
	goto	l1528
u1270:
	line	126
	
l1524:	
	movf	(_j+1),w
	movwf	(?_button_to_floor+1)
	movf	(_j),w
	movwf	(?_button_to_floor)
	goto	l211
	line	124
	
l1528:	
	movlw	02h
	addwf	(_i),f
	skipnc
	incf	(_i+1),f
	
l1530:	
	incf	(_j),f
	skipnz
	incf	(_j+1),f
	
l1532:	
	movf	(_i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(05h))^80h
	subwf	btemp+1,w
	skipz
	goto	u1285
	movlw	low(05h)
	subwf	(_i),w
u1285:

	skipc
	goto	u1281
	goto	u1280
u1281:
	goto	l1520
u1280:
	line	128
	
l1534:	
	bcf	status, 5	;RP0=0, select bank0
		movf	(_button),w
	xorlw	6
	iorwf	(_button+1),w

	skipz
	goto	u1291
	goto	u1290
u1291:
	goto	l1540
u1290:
	line	129
	
l1536:	
	movlw	03h
	movwf	(?_button_to_floor)
	clrf	(?_button_to_floor+1)
	goto	l211
	line	130
	
l1540:	
	movlw	low(-1)
	movwf	(?_button_to_floor)
	movlw	high(-1)
	movwf	((?_button_to_floor))+1
	line	131
	
l211:	
	return
	opt stack 0
GLOBAL	__end_of_button_to_floor
	__end_of_button_to_floor:
;; =============== function _button_to_floor ends ============

	signat	_button_to_floor,90
	global	_button_press
psect	text365,local,class=CODE,delta=2
global __ptext365
__ptext365:

;; *************** function _button_press *****************
;; Defined at:
;;		line 103 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] short 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 20/0
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       2
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_floor_details
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text365
	file	"LEDCode.c"
	line	103
	global	__size_of_button_press
	__size_of_button_press	equ	__end_of_button_press-_button_press
	
_button_press:	
	opt	stack 5
; Regs used in _button_press: [wreg+status,2+status,0]
	line	104
	
l1448:	
	bcf	status, 5	;RP0=0, select bank0
	btfsc	(40/8),(40)&7
	goto	u1041
	goto	u1040
u1041:
	goto	l200
u1040:
	
l1450:	
	btfsc	(41/8),(41)&7
	goto	u1051
	goto	u1050
u1051:
	goto	l200
u1050:
	
l1452:	
	btfsc	(42/8),(42)&7
	goto	u1061
	goto	u1060
u1061:
	goto	l200
u1060:
	line	105
	
l1454:	
	clrf	(?_button_press)
	incf	(?_button_press),f
	clrf	(?_button_press+1)
	goto	l201
	
l200:	
	line	106
	btfss	(40/8),(40)&7
	goto	u1071
	goto	u1070
u1071:
	goto	l202
u1070:
	
l1458:	
	btfsc	(41/8),(41)&7
	goto	u1081
	goto	u1080
u1081:
	goto	l202
u1080:
	
l1460:	
	btfsc	(42/8),(42)&7
	goto	u1091
	goto	u1090
u1091:
	goto	l202
u1090:
	line	107
	
l1462:	
	movlw	02h
	movwf	(?_button_press)
	clrf	(?_button_press+1)
	goto	l201
	
l202:	
	line	108
	btfsc	(40/8),(40)&7
	goto	u1101
	goto	u1100
u1101:
	goto	l203
u1100:
	
l1466:	
	btfss	(41/8),(41)&7
	goto	u1111
	goto	u1110
u1111:
	goto	l203
u1110:
	
l1468:	
	btfsc	(42/8),(42)&7
	goto	u1121
	goto	u1120
u1121:
	goto	l203
u1120:
	line	109
	
l1470:	
	movlw	03h
	movwf	(?_button_press)
	clrf	(?_button_press+1)
	goto	l201
	
l203:	
	line	110
	btfss	(40/8),(40)&7
	goto	u1131
	goto	u1130
u1131:
	goto	l204
u1130:
	
l1474:	
	btfss	(41/8),(41)&7
	goto	u1141
	goto	u1140
u1141:
	goto	l204
u1140:
	
l1476:	
	btfsc	(42/8),(42)&7
	goto	u1151
	goto	u1150
u1151:
	goto	l204
u1150:
	line	111
	
l1478:	
	movlw	04h
	movwf	(?_button_press)
	clrf	(?_button_press+1)
	goto	l201
	
l204:	
	line	112
	btfsc	(40/8),(40)&7
	goto	u1161
	goto	u1160
u1161:
	goto	l205
u1160:
	
l1482:	
	btfsc	(41/8),(41)&7
	goto	u1171
	goto	u1170
u1171:
	goto	l205
u1170:
	
l1484:	
	btfss	(42/8),(42)&7
	goto	u1181
	goto	u1180
u1181:
	goto	l205
u1180:
	line	113
	
l1486:	
	movlw	05h
	movwf	(?_button_press)
	clrf	(?_button_press+1)
	goto	l201
	
l205:	
	line	114
	btfss	(40/8),(40)&7
	goto	u1191
	goto	u1190
u1191:
	goto	l206
u1190:
	
l1490:	
	btfsc	(41/8),(41)&7
	goto	u1201
	goto	u1200
u1201:
	goto	l206
u1200:
	
l1492:	
	btfss	(42/8),(42)&7
	goto	u1211
	goto	u1210
u1211:
	goto	l206
u1210:
	line	115
	
l1494:	
	movlw	06h
	movwf	(?_button_press)
	clrf	(?_button_press+1)
	goto	l201
	
l206:	
	line	116
	btfsc	(40/8),(40)&7
	goto	u1221
	goto	u1220
u1221:
	goto	l1506
u1220:
	
l1498:	
	btfss	(41/8),(41)&7
	goto	u1231
	goto	u1230
u1231:
	goto	l1506
u1230:
	
l1500:	
	btfss	(42/8),(42)&7
	goto	u1241
	goto	u1240
u1241:
	goto	l1506
u1240:
	line	117
	
l1502:	
	movlw	07h
	movwf	(?_button_press)
	clrf	(?_button_press+1)
	goto	l201
	line	118
	
l1506:	
	movlw	low(-1)
	movwf	(?_button_press)
	movlw	high(-1)
	movwf	((?_button_press))+1
	line	119
	
l201:	
	return
	opt stack 0
GLOBAL	__end_of_button_press
	__end_of_button_press:
;; =============== function _button_press ends ============

	signat	_button_press,90
	global	_disp
psect	text366,local,class=CODE,delta=2
global __ptext366
__ptext366:

;; *************** function _disp *****************
;; Defined at:
;;		line 58 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFFFFFDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_clr_char
;;		_floor_details
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text366
	file	"LEDCode.c"
	line	58
	global	__size_of_disp
	__size_of_disp	equ	__end_of_disp-_disp
	
_disp:	
	opt	stack 4
; Regs used in _disp: []
	line	66
	
l185:	
	return
	opt stack 0
GLOBAL	__end_of_disp
	__end_of_disp:
;; =============== function _disp ends ============

	signat	_disp,88
psect	text367,local,class=CODE,delta=2
global __ptext367
__ptext367:
	global	btemp
	btemp set 04Eh

	DABS	1,78,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
