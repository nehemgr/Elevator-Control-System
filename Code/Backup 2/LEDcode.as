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
# 4 "LEDCode.c"
	psect config,class=CONFIG,delta=2 ;#
# 4 "LEDCode.c"
	dw 0xFFFE & 0xFFFB & 0xFFF7 & 0xFFFF ;#
	FNCALL	_main,_initialize
	FNCALL	_main,_button_press
	FNCALL	_main,_moving
	FNCALL	_main,_cmd
	FNCALL	_main,_disp_string
	FNCALL	_main,_max_prob_floor
	FNCALL	_moving,_cmd
	FNCALL	_moving,_disp_string
	FNCALL	_moving,_button_press
	FNCALL	_moving,_set_floor
	FNCALL	_moving,_floor_details
	FNCALL	_moving,_call_min
	FNCALL	_moving,_call_max
	FNCALL	_moving,_max_prob_floor
	FNCALL	_floor_details,_cmd
	FNCALL	_floor_details,_disp_string
	FNCALL	_floor_details,_button_press
	FNCALL	_floor_details,_clr_char
	FNCALL	_floor_details,_set_floor
	FNCALL	_clr_char,_cmd
	FNROOT	_main
	FNCALL	_hour_ISR,i1_cmd
	FNCALL	intlevel1,_hour_ISR
	global	intlevel1
	FNROOT	intlevel1
	global	_reached_msg
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
	file	"LEDCode.c"
	line	61
_reached_msg:
	retlw	052h
	retlw	065h
	retlw	061h
	retlw	063h
	retlw	068h
	retlw	03Ah
	retlw	020h
	retlw	046h
	retlw	06Ch
	retlw	072h
	retlw	020h
	retlw	0
	global	_moving_msg
psect	strings
	file	"LEDCode.c"
	line	60
_moving_msg:
	retlw	04Dh
	retlw	06Fh
	retlw	076h
	retlw	065h
	retlw	03Ah
	retlw	020h
	retlw	046h
	retlw	06Ch
	retlw	072h
	retlw	020h
	retlw	0
	global	_stopped_msg
psect	strings
	file	"LEDCode.c"
	line	59
_stopped_msg:
	retlw	053h
	retlw	074h
	retlw	06Fh
	retlw	070h
	retlw	03Ah
	retlw	020h
	retlw	046h
	retlw	06Ch
	retlw	072h
	retlw	020h
	retlw	0
	global	_people_msg
psect	strings
	file	"LEDCode.c"
	line	57
_people_msg:
	retlw	050h
	retlw	065h
	retlw	06Fh
	retlw	070h
	retlw	06Ch
	retlw	065h
	retlw	03Ah
	retlw	020h
	retlw	0
	global	_floor_msg
psect	strings
	file	"LEDCode.c"
	line	58
_floor_msg:
	retlw	046h
	retlw	06Ch
	retlw	072h
	retlw	073h
	retlw	03Ah
	retlw	020h
	retlw	0
	global	_reached_msg
	global	_moving_msg
	global	_stopped_msg
	global	_people_msg
	global	_floor_msg
	global	_prob_matrix
	global	_cabin_call
	global	_floor_call
	global	_current_floor
	global	_hour
	global	_temp
	global	_prob_move
	global	_counter2
psect	nvBANK0,class=BANK0,space=1
global __pnvBANK0
__pnvBANK0:
_counter2:
       ds      2

	global	_button
_button:
       ds      1

	global	_destination_floor
_destination_floor:
       ds      1

	global	_floor_direction
_floor_direction:
       ds      1

	global	_floor_index
_floor_index:
       ds      1

	global	_i
_i:
       ds      1

	global	_PORTA
_PORTA	set	5
	global	_PORTB
_PORTB	set	6
	global	_TMR0
_TMR0	set	1
	global	_GIE
_GIE	set	95
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
	global	_T0IE
_T0IE	set	93
	global	_T0IF
_T0IF	set	90
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	file	"LEDCode.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_prob_matrix:
       ds      12

_cabin_call:
       ds      4

_floor_call:
       ds      4

_current_floor:
       ds      1

_hour:
       ds      1

_temp:
       ds      1

psect	bitbssBANK0,class=BANK0,bit,space=1
global __pbitbssBANK0
__pbitbssBANK0:
_prob_move:
       ds      1

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
	movlw	low((__pbssBANK0)+017h)
	fcall	clear_ram
; Clear objects allocated to BITBANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbitbssBANK0/8)+0)&07Fh
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	??_disp_string
??_disp_string:	; 0 bytes @ 0x0
	global	??_cmd
??_cmd:	; 0 bytes @ 0x0
	global	??_clr_char
??_clr_char:	; 0 bytes @ 0x0
	global	??_initialize
??_initialize:	; 0 bytes @ 0x0
	global	??_button_press
??_button_press:	; 0 bytes @ 0x0
	global	??_call_max
??_call_max:	; 0 bytes @ 0x0
	global	??_call_min
??_call_min:	; 0 bytes @ 0x0
	global	??_main
??_main:	; 0 bytes @ 0x0
	global	??i1_cmd
??i1_cmd:	; 0 bytes @ 0x0
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	?_disp_string
?_disp_string:	; 0 bytes @ 0x0
	global	?_cmd
?_cmd:	; 0 bytes @ 0x0
	global	?_clr_char
?_clr_char:	; 0 bytes @ 0x0
	global	?_initialize
?_initialize:	; 0 bytes @ 0x0
	global	?_hour_ISR
?_hour_ISR:	; 0 bytes @ 0x0
	global	?_button_press
?_button_press:	; 0 bytes @ 0x0
	global	?_max_prob_floor
?_max_prob_floor:	; 0 bytes @ 0x0
	global	?_call_max
?_call_max:	; 0 bytes @ 0x0
	global	?_call_min
?_call_min:	; 0 bytes @ 0x0
	global	?_set_floor
?_set_floor:	; 0 bytes @ 0x0
	global	?_floor_details
?_floor_details:	; 0 bytes @ 0x0
	global	?_moving
?_moving:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?i1_cmd
?i1_cmd:	; 0 bytes @ 0x0
	global	i1cmd@cmd_msg
i1cmd@cmd_msg:	; 1 bytes @ 0x0
	ds	1
	global	??_hour_ISR
??_hour_ISR:	; 0 bytes @ 0x1
	ds	4
	global	??_max_prob_floor
??_max_prob_floor:	; 0 bytes @ 0x5
	global	??_set_floor
??_set_floor:	; 0 bytes @ 0x5
	global	disp_string@c
disp_string@c:	; 1 bytes @ 0x5
	global	cmd@cmd_msg
cmd@cmd_msg:	; 1 bytes @ 0x5
	ds	1
	global	clr_char@spaces
clr_char@spaces:	; 1 bytes @ 0x6
	ds	1
	global	??_floor_details
??_floor_details:	; 0 bytes @ 0x7
	ds	1
	global	floor_details@j
floor_details@j:	; 1 bytes @ 0x8
	ds	1
	global	??_moving
??_moving:	; 0 bytes @ 0x9
	ds	6
	global	moving@counter
moving@counter:	; 2 bytes @ 0xF
	ds	2
;;Data sizes: Strings 0, constant 50, data 0, bss 23, persistent 7 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON           0      0       0
;; BANK0           66     17      48

;;
;; Pointer list with targets:

;; disp_string@c	PTR const unsigned char  size(1) Largest target is 1024
;;		 -> stopped_msg(CODE[11]), reached_msg(CODE[12]), moving_msg(CODE[11]), floor_msg(CODE[7]), 
;;		 -> ROM(CODE[1024]), people_msg(CODE[9]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _hour_ISR in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_moving
;;   _moving->_floor_details
;;   _floor_details->_clr_char
;;   _clr_char->_cmd
;;
;; Critical Paths under _hour_ISR in BANK0
;;
;;   _hour_ISR->i1_cmd

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 0     0      0     702
;;                         _initialize
;;                       _button_press
;;                             _moving
;;                                _cmd
;;                        _disp_string
;;                     _max_prob_floor
;; ---------------------------------------------------------------------------------
;; (1) _moving                                               8     8      0     613
;;                                              9 BANK0      8     8      0
;;                                _cmd
;;                        _disp_string
;;                       _button_press
;;                          _set_floor
;;                      _floor_details
;;                           _call_min
;;                           _call_max
;;                     _max_prob_floor
;; ---------------------------------------------------------------------------------
;; (2) _floor_details                                        2     2      0     499
;;                                              7 BANK0      2     2      0
;;                                _cmd
;;                        _disp_string
;;                       _button_press
;;                           _clr_char
;;                          _set_floor
;; ---------------------------------------------------------------------------------
;; (3) _clr_char                                             1     1      0      44
;;                                              6 BANK0      1     1      0
;;                                _cmd
;; ---------------------------------------------------------------------------------
;; (1) _cmd                                                  1     1      0      22
;;                                              5 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (1) _disp_string                                          1     1      0      67
;;                                              5 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (3) _set_floor                                            1     1      0       0
;;                                              5 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (2) _call_min                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _call_max                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _max_prob_floor                                       3     3      0       0
;;                                              5 BANK0      3     3      0
;; ---------------------------------------------------------------------------------
;; (3) _button_press                                         0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _initialize                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 3
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (5) _hour_ISR                                             4     4      0      73
;;                                              1 BANK0      4     4      0
;;                              i1_cmd
;; ---------------------------------------------------------------------------------
;; (6) i1_cmd                                                1     1      0      73
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 6
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _initialize
;;   _button_press
;;   _moving
;;     _cmd
;;     _disp_string
;;     _button_press
;;     _set_floor
;;     _floor_details
;;       _cmd
;;       _disp_string
;;       _button_press
;;       _clr_char
;;         _cmd
;;       _set_floor
;;     _call_min
;;     _call_max
;;     _max_prob_floor
;;   _cmd
;;   _disp_string
;;   _max_prob_floor
;;
;; _hour_ISR (ROOT)
;;   i1_cmd
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
;;STACK                0      0       8       2        0.0%
;;BANK0               42     11      30       3       72.7%
;;ABS                  0      0      30       4        0.0%
;;BITBANK0            42      0       1       5        1.5%
;;DATA                 0      0      38       6        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 405 in file "LEDCode.c"
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
;;		On exit  : 120/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    6
;; This function calls:
;;		_initialize
;;		_button_press
;;		_moving
;;		_cmd
;;		_disp_string
;;		_max_prob_floor
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"LEDCode.c"
	line	405
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 2
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	406
	
l2082:	
	fcall	_initialize
	line	407
	
l2084:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(_hour)
	line	408
	
l2086:	
	movlw	low(0BB8h)
	movwf	(_counter2)
	movlw	high(0BB8h)
	movwf	((_counter2))+1
	line	409
	
l2088:	
	bcf	(_prob_move/8),(_prob_move)&7
	line	410
	
l2090:	
	clrf	(_current_floor)
	line	411
	
l2092:	
	clrf	(_destination_floor)
	decf	(_destination_floor),f
	line	412
	
l2094:	
	movlw	(-10)
	movwf	(_i)
	line	413
	
l361:	
	line	414
	fcall	_button_press
	line	415
	
l2096:	
	incf	(_button),w
	skipnz
	goto	u2171
	goto	u2170
u2171:
	goto	l2108
u2170:
	
l2098:	
	movf	(_button),w
	xorlw	07h
	skipnz
	goto	u2181
	goto	u2180
u2181:
	goto	l2108
u2180:
	line	416
	
l2100:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	(_floor_direction),w
	movwf	indf
	line	417
	
l2102:	
	movf	(_floor_index),w
	movwf	(_destination_floor)
	goto	l2108
	line	420
	
l2104:	
	fcall	_moving
	line	421
	
l2106:	
	movlw	(-10)
	movwf	(_i)
	line	419
	
l2108:	
	incf	(_destination_floor),w
	skipz
	goto	u2191
	goto	u2190
u2191:
	goto	l2104
u2190:
	line	423
	
l2110:	
	movf	(_i),w
	xorlw	-10
	skipz
	goto	u2201
	goto	u2200
u2201:
	goto	l2122
u2200:
	line	424
	
l2112:	
	movlw	(-9)
	movwf	(_i)
	line	425
	
l2114:	
	movlw	(01h)
	fcall	_cmd
	line	426
	
l2116:	
	movf	(_current_floor),w
	addlw	030h
	movwf	(_temp)
	line	427
	
l2118:	
	movlw	((_stopped_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	428
	
l2120:	
	movlw	(0)
	fcall	_disp_string
	line	430
	
l2122:	
	fcall	_max_prob_floor
	goto	l361
	global	start
	ljmp	start
	opt stack 0
psect	maintext
	line	432
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_moving
psect	text340,local,class=CODE,delta=2
global __ptext340
__ptext340:

;; *************** function _moving *****************
;; Defined at:
;;		line 322 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  counter         2   15[BANK0 ] int 
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
;;      Temps:          0       6
;;      Totals:         0       8
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_cmd
;;		_disp_string
;;		_button_press
;;		_set_floor
;;		_floor_details
;;		_call_min
;;		_call_max
;;		_max_prob_floor
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text340
	file	"LEDCode.c"
	line	322
	global	__size_of_moving
	__size_of_moving	equ	__end_of_moving-_moving
	
_moving:	
	opt	stack 2
; Regs used in _moving: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	323
	
l1936:	
	movlw	low(03E8h)
	movwf	(moving@counter)
	movlw	high(03E8h)
	movwf	((moving@counter))+1
	line	324
	goto	l2020
	line	325
	
l1938:	
	movlw	(01h)
	fcall	_cmd
	line	326
	
l1940:	
	movf	(_current_floor),w
	addlw	030h
	movwf	(_temp)
	line	327
	
l1942:	
	movlw	((_moving_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	328
	
l1944:	
	movlw	(0)
	fcall	_disp_string
	line	329
	goto	l2014
	line	330
	
l1946:	
	movlw	-1
	addwf	(moving@counter),f
	skipc
	decf	(moving@counter+1),f
	line	331
	
l1948:	
	fcall	_button_press
	line	332
	
l1950:	
	incf	(_button),w
	skipnz
	goto	u1901
	goto	u1900
u1901:
	goto	l1956
u1900:
	
l1952:	
	movf	(_button),w
	xorlw	07h
	skipnz
	goto	u1911
	goto	u1910
u1911:
	goto	l1956
u1910:
	line	333
	
l1954:	
	fcall	_set_floor
	line	335
	
l1956:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorlw	80h
	addlw	-((03h)^80h)
	skipnc
	goto	u1921
	goto	u1920
u1921:
	goto	l1966
u1920:
	
l1958:	
	movf	(_current_floor),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_destination_floor),w
	xorlw	80h
	subwf	(??_moving+0)+0
	skipnc
	goto	u1931
	goto	u1930
u1931:
	goto	l1962
u1930:
	
l1960:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipnz
	goto	u1941
	goto	u1940
u1941:
	goto	l1966
u1940:
	
l1962:	
	movf	(_destination_floor),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_current_floor),w
	xorlw	80h
	subwf	(??_moving+0)+0
	skipnc
	goto	u1951
	goto	u1950
u1951:
	goto	l1996
u1950:
	
l1964:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	02h
	skipz
	goto	u1961
	goto	u1960
u1961:
	goto	l1996
u1960:
	line	336
	
l1966:	
	movf	(_current_floor),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_destination_floor),w
	xorlw	80h
	subwf	(??_moving+0)+0
	skipnc
	goto	u1971
	goto	u1970
u1971:
	goto	l1972
u1970:
	
l1968:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	80h
	addlw	-((03h)^80h)
	skipc
	goto	u1981
	goto	u1980
u1981:
	goto	l1972
u1980:
	line	337
	
l1970:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(02h)
	movwf	indf
	goto	l340
	line	338
	
l1972:	
	movf	(_destination_floor),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_current_floor),w
	xorlw	80h
	subwf	(??_moving+0)+0
	skipnc
	goto	u1991
	goto	u1990
u1991:
	goto	l1978
u1990:
	
l1974:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	80h
	addlw	-((03h)^80h)
	skipc
	goto	u2001
	goto	u2000
u2001:
	goto	l1978
u2000:
	line	339
	
l1976:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	clrf	indf
	incf	indf,f
	goto	l340
	line	341
	
l1978:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	clrf	indf
	
l340:	
	line	342
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	343
	
l1980:	
	movlw	(01h)
	fcall	_cmd
	line	344
	
l1982:	
	movlw	((_reached_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	345
	
l1984:	
	movlw	(0)
	fcall	_disp_string
	line	346
	
l1986:	
	fcall	_floor_details
	line	347
	
l1988:	
	movlw	(01h)
	fcall	_cmd
	line	348
	
l1990:	
	movf	(_current_floor),w
	addlw	030h
	movwf	(_temp)
	line	349
	
l1992:	
	movlw	((_moving_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	350
	
l1994:	
	movlw	(0)
	fcall	_disp_string
	line	352
	
l1996:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf
	skipnz
	goto	u2011
	goto	u2010
u2011:
	goto	l2014
u2010:
	line	353
	
l1998:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	354
	
l2000:	
	movlw	(01h)
	fcall	_cmd
	line	355
	
l2002:	
	movlw	((_reached_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	356
	
l2004:	
	movlw	(0)
	fcall	_disp_string
	line	357
	
l2006:	
	opt asmopt_off
movlw	33
movwf	((??_moving+0)+0+1),f
	movlw	118
movwf	((??_moving+0)+0),f
u2217:
	decfsz	((??_moving+0)+0),f
	goto	u2217
	decfsz	((??_moving+0)+0+1),f
	goto	u2217
	clrwdt
opt asmopt_on

	line	358
	
l2008:	
	movlw	(01h)
	fcall	_cmd
	line	359
	
l2010:	
	movlw	((_moving_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	360
	
l2012:	
	movlw	(0)
	fcall	_disp_string
	line	329
	
l2014:	
	movf	((moving@counter+1)),w
	iorwf	((moving@counter)),w
	skipz
	goto	u2021
	goto	u2020
u2021:
	goto	l1946
u2020:
	line	363
	
l2016:	
	movlw	low(03E8h)
	movwf	(moving@counter)
	movlw	high(03E8h)
	movwf	((moving@counter))+1
	line	364
	
l2018:	
	movf	(_current_floor),w
	subwf	(_destination_floor),w
	movwf	(??_moving+0)+0
	clrf	(??_moving+0)+0+1
	skipc
	decf	1+(??_moving+0)+0,f
	btfsc	(_destination_floor),7
	decf	((??_moving+0)+0)+1,f
	btfss	(_current_floor),7
	goto	u2035o
	incf	((??_moving+0)+0)+1,f
	
u2035o:
	
	movlw	0
	bcf	status, 5	;RP0=0, select bank0
	btfsc	1+(??_moving+0)+0,7
	movlw	1
	movwf	(??_moving+2)+0
	movf	(_current_floor),w
	subwf	(_destination_floor),w
	movwf	(??_moving+3)+0
	clrf	(??_moving+3)+0+1
	skipc
	decf	1+(??_moving+3)+0,f
	btfsc	(_destination_floor),7
	decf	((??_moving+3)+0)+1,f
	btfss	(_current_floor),7
	goto	u2045o
	incf	((??_moving+3)+0)+1,f
	
u2045o:
	
	bcf	status, 5	;RP0=0, select bank0
	movf	1+(??_moving+3)+0,w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(01h))^80h
	subwf	btemp+1,w
	skipz
	goto	u2055
	movlw	low(01h)
	subwf	0+(??_moving+3)+0,w
u2055:

	movlw	0
	skipnc
	movlw	1
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_moving+5)+0
	movf	(??_moving+2)+0,w
	subwf	(??_moving+5)+0,w
	addwf	(_current_floor),w
	movwf	(_current_floor)
	line	324
	
l2020:	
	movf	(_current_floor),w
	xorwf	(_destination_floor),w
	skipz
	goto	u2061
	goto	u2060
u2061:
	goto	l1938
u2060:
	line	366
	
l2022:	
	movlw	(01h)
	fcall	_cmd
	line	367
	
l2024:	
	movf	(_destination_floor),w
	addlw	030h
	movwf	(_temp)
	line	368
	
l2026:	
	movlw	((_reached_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	369
	
l2028:	
	movlw	(0)
	fcall	_disp_string
	line	370
	
l2030:	
	bcf	(_prob_move/8),(_prob_move)&7
	line	371
	
l2032:	
	clrf	(_destination_floor)
	decf	(_destination_floor),f
	line	372
	
l2034:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf
	skipnz
	goto	u2071
	goto	u2070
u2071:
	goto	l2052
u2070:
	line	373
	
l2036:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	374
	
l2038:	
	fcall	_floor_details
	line	375
	
l2040:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	btfsc	indf,(0)&7
	goto	u2081
	goto	u2080
u2081:
	goto	l2048
u2080:
	line	376
	
l2042:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	04h
	skipz
	goto	u2091
	goto	u2090
u2091:
	goto	l348
u2090:
	line	377
	
l2044:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(03h)
	movwf	indf
	
l348:	
	line	378
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(-2)
	addwf	indf,f
	line	379
	
l2046:	
	fcall	_call_min
	line	380
	goto	l2066
	line	382
	
l2048:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	decf	indf,f
	line	383
	
l2050:	
	fcall	_call_max
	goto	l2066
	line	386
	
l2052:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	movf	indf
	skipnz
	goto	u2101
	goto	u2100
u2101:
	goto	l2066
u2100:
	line	387
	
l2054:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u2111
	goto	u2110
u2111:
	goto	l2060
u2110:
	line	388
	
l2056:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	389
	
l2058:	
	fcall	_call_min
	line	390
	goto	l2064
	line	392
	
l2060:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	393
	
l2062:	
	fcall	_call_max
	line	395
	
l2064:	
	opt asmopt_off
movlw	33
movwf	((??_moving+0)+0+1),f
	movlw	118
movwf	((??_moving+0)+0),f
u2227:
	decfsz	((??_moving+0)+0),f
	goto	u2227
	decfsz	((??_moving+0)+0+1),f
	goto	u2227
	clrwdt
opt asmopt_on

	line	397
	
l2066:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_current_floor),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_destination_floor),w
	xorlw	80h
	subwf	(??_moving+0)+0
	skipnc
	goto	u2121
	goto	u2120
u2121:
	goto	l2072
u2120:
	
l2068:	
	incf	(_destination_floor),w
	skipnz
	goto	u2131
	goto	u2130
u2131:
	goto	l2072
u2130:
	line	398
	
l2070:	
	fcall	_call_max
	goto	l2078
	line	399
	
l2072:	
	movf	(_destination_floor),w
	xorlw	80h
	movwf	(??_moving+0)+0
	movf	(_current_floor),w
	xorlw	80h
	subwf	(??_moving+0)+0
	skipnc
	goto	u2141
	goto	u2140
u2141:
	goto	l2078
u2140:
	
l2074:	
	incf	(_destination_floor),w
	skipnz
	goto	u2151
	goto	u2150
u2151:
	goto	l2078
u2150:
	line	400
	
l2076:	
	fcall	_call_min
	line	401
	
l2078:	
	incf	(_destination_floor),w
	skipz
	goto	u2161
	goto	u2160
u2161:
	goto	l358
u2160:
	line	402
	
l2080:	
	fcall	_max_prob_floor
	line	403
	
l358:	
	return
	opt stack 0
GLOBAL	__end_of_moving
	__end_of_moving:
;; =============== function _moving ends ============

	signat	_moving,88
	global	_floor_details
psect	text341,local,class=CODE,delta=2
global __ptext341
__ptext341:

;; *************** function _floor_details *****************
;; Defined at:
;;		line 238 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  j               1    8[BANK0 ] char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       1
;;      Temps:          0       1
;;      Totals:         0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_cmd
;;		_disp_string
;;		_button_press
;;		_clr_char
;;		_set_floor
;; This function is called by:
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text341
	file	"LEDCode.c"
	line	238
	global	__size_of_floor_details
	__size_of_floor_details	equ	__end_of_floor_details-_floor_details
	
_floor_details:	
	opt	stack 2
; Regs used in _floor_details: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	239
	
l1812:	
	movlw	(0C0h)
	fcall	_cmd
	line	240
	
l1814:	
	clrf	(floor_details@j)
	line	241
	
l1816:	
	movlw	(030h)
	movwf	(_temp)
	line	242
	
l1818:	
	movlw	((_people_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	243
	
l1820:	
	movlw	(0)
	fcall	_disp_string
	line	244
	
l1822:	
	fcall	_button_press
	line	245
	goto	l1854
	line	246
	
l1824:	
	incf	(_button),w
	skipnz
	goto	u1691
	goto	u1690
u1691:
	goto	l1822
u1690:
	line	247
	
l1826:	
	movf	(_floor_index),w
	xorwf	(_current_floor),w
	skipz
	goto	u1701
	goto	u1700
u1701:
	goto	l1850
u1700:
	line	248
	
l1828:	
	btfss	(_button),(0)&7
	goto	u1711
	goto	u1710
u1711:
	goto	l1838
u1710:
	
l1830:	
	decf	(_button),w
	skipnz
	goto	u1721
	goto	u1720
u1721:
	goto	l1838
u1720:
	line	249
	
l1832:	
	movf	(floor_details@j),f
	skipz
	goto	u1731
	goto	u1730
u1731:
	goto	l1836
u1730:
	line	250
	
l1834:	
	movlw	(06h)
	movwf	(floor_details@j)
	line	251
	
l1836:	
	decf	(floor_details@j),f
	line	252
	goto	l1844
	line	254
	
l1838:	
	movf	(floor_details@j),w
	xorlw	05h
	skipz
	goto	u1741
	goto	u1740
u1741:
	goto	l1842
u1740:
	line	255
	
l1840:	
	clrf	(floor_details@j)
	decf	(floor_details@j),f
	line	256
	
l1842:	
	incf	(floor_details@j),f
	line	258
	
l1844:	
	movlw	(01h)
	fcall	_clr_char
	line	259
	
l1846:	
	movf	(floor_details@j),w
	addlw	030h
	movwf	(_temp)
	line	260
	
l1848:	
	movlw	(0)
	fcall	_disp_string
	line	261
	goto	l1822
	line	263
	
l1850:	
	fcall	_set_floor
	goto	l1822
	line	245
	
l1854:	
	movf	(_button),w
	xorlw	07h
	skipz
	goto	u1751
	goto	u1750
u1751:
	goto	l1824
u1750:
	line	267
	
l1856:	
	movf	(_current_floor),w
	addwf	(_current_floor),w
	addwf	(_current_floor),w
	addlw	_prob_matrix&0ffh
	addwf	(_hour),w
	movwf	(??_floor_details+0)+0
	movf	0+(??_floor_details+0)+0,w
	movwf	fsr0
	movf	(floor_details@j),w
	bcf	status, 7	;select IRP bank0
	addwf	indf,f
	line	268
	
l1858:	
	movlw	(09h)
	fcall	_clr_char
	line	269
	
l1860:	
	clrf	(floor_details@j)
	line	270
	
l1862:	
	movf	(_current_floor),f
	skipz
	goto	u1761
	goto	u1760
u1761:
	goto	l1866
u1760:
	line	271
	
l1864:	
	clrf	(floor_details@j)
	incf	(floor_details@j),f
	line	272
	
l1866:	
	movf	(floor_details@j),w
	addlw	030h
	movwf	(_temp)
	line	273
	
l1868:	
	movlw	((_floor_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	274
	
l1870:	
	movlw	(0)
	fcall	_disp_string
	line	276
	
l1872:	
	fcall	_button_press
	line	277
	
l1874:	
	incf	(_button),w
	skipnz
	goto	u1771
	goto	u1770
u1771:
	goto	l1872
u1770:
	line	278
	
l1876:	
	movf	(_floor_index),w
	xorwf	(_current_floor),w
	skipz
	goto	u1781
	goto	u1780
u1781:
	goto	l1918
u1780:
	line	279
	
l1878:	
	btfss	(_button),(0)&7
	goto	u1791
	goto	u1790
u1791:
	goto	l1896
u1790:
	
l1880:	
	decf	(_button),w
	skipnz
	goto	u1801
	goto	u1800
u1801:
	goto	l1896
u1800:
	line	280
	
l1882:	
	movf	(floor_details@j),f
	skipz
	goto	u1811
	goto	u1810
u1811:
	goto	l1886
u1810:
	line	281
	
l1884:	
	movlw	(05h)
	movwf	(floor_details@j)
	line	282
	
l1886:	
	decf	(floor_details@j),f
	line	283
	
l1888:	
	movf	(floor_details@j),w
	xorwf	(_current_floor),w
	skipz
	goto	u1821
	goto	u1820
u1821:
	goto	l1906
u1820:
	line	284
	
l1890:	
	movf	(floor_details@j),f
	skipz
	goto	u1831
	goto	u1830
u1831:
	goto	l1894
u1830:
	line	285
	
l1892:	
	movlw	(05h)
	movwf	(floor_details@j)
	line	286
	
l1894:	
	decf	(floor_details@j),f
	goto	l1906
	line	290
	
l1896:	
	movf	(floor_details@j),w
	xorlw	04h
	skipz
	goto	u1841
	goto	u1840
u1841:
	goto	l1900
u1840:
	line	291
	
l1898:	
	clrf	(floor_details@j)
	decf	(floor_details@j),f
	line	292
	
l1900:	
	incf	(floor_details@j),f
	line	293
	
l1902:	
	movf	(floor_details@j),w
	xorwf	(_current_floor),w
	skipz
	goto	u1851
	goto	u1850
u1851:
	goto	l1906
u1850:
	line	294
	
l1904:	
	incf	(floor_details@j),f
	line	296
	
l1906:	
	movlw	(01h)
	fcall	_clr_char
	line	297
	
l1908:	
	movf	(floor_details@j),w
	xorlw	04h
	skipz
	goto	u1861
	goto	u1860
u1861:
	goto	l1914
u1860:
	line	298
	
l1910:	
	movlw	(058h)
	movwf	(_temp)
	line	299
	
l1912:	
	movlw	(0)
	fcall	_disp_string
	line	300
	goto	l1872
	line	302
	
l1914:	
	movf	(floor_details@j),w
	addlw	030h
	movwf	(_temp)
	line	303
	
l1916:	
	movlw	(0)
	fcall	_disp_string
	goto	l1872
	line	306
	
l1918:	
	movf	(_button),w
	xorlw	07h
	skipz
	goto	u1871
	goto	u1870
u1871:
	goto	l1932
u1870:
	line	307
	
l1920:	
	movf	(floor_details@j),w
	xorlw	04h
	skipz
	goto	u1881
	goto	u1880
u1881:
	goto	l1926
u1880:
	goto	l1934
	line	310
	
l1926:	
	movf	(floor_details@j),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	clrf	indf
	incf	indf,f
	line	311
	
l1928:	
	movf	(floor_details@j),w
	xorlw	80h
	movwf	(??_floor_details+0)+0
	movf	(_current_floor),w
	xorlw	80h
	subwf	(??_floor_details+0)+0
	skipnc
	goto	u1891
	goto	u1890
u1891:
	goto	l307
u1890:
	line	312
	
l1930:	
	movf	(floor_details@j),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	movlw	(02h)
	movwf	indf
	goto	l1872
	line	316
	
l1932:	
	fcall	_set_floor
	goto	l1872
	line	317
	
l307:	
	goto	l1872
	line	319
	
l1934:	
	movlw	(07h)
	fcall	_clr_char
	line	320
	
l326:	
	return
	opt stack 0
GLOBAL	__end_of_floor_details
	__end_of_floor_details:
;; =============== function _floor_details ends ============

	signat	_floor_details,88
	global	_clr_char
psect	text342,local,class=CODE,delta=2
global __ptext342
__ptext342:

;; *************** function _clr_char *****************
;; Defined at:
;;		line 103 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;  spaces          1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  spaces          1    6[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       1
;;      Temps:          0       0
;;      Totals:         0       1
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_cmd
;; This function is called by:
;;		_floor_details
;; This function uses a non-reentrant model
;;
psect	text342
	file	"LEDCode.c"
	line	103
	global	__size_of_clr_char
	__size_of_clr_char	equ	__end_of_clr_char-_clr_char
	
_clr_char:	
	opt	stack 2
; Regs used in _clr_char: [wreg+status,2+status,0+pclath+cstack]
	movwf	(clr_char@spaces)
	line	104
	
l1792:	
	movlw	(04h)
	fcall	_cmd
	line	105
	
l1794:	
	bsf	(44/8),(44)&7
	line	106
	
l1796:	
	movf	(clr_char@spaces),w
	movwf	(_i)
	goto	l1808
	line	107
	
l1798:	
	movlw	(020h)
	movwf	(6)	;volatile
	line	108
	
l1800:	
	bsf	(43/8),(43)&7
	line	109
	
l1802:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	110
	
l1804:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	106
	
l1806:	
	decf	(_i),f
	
l1808:	
	incf	(_i),w
	skipz
	goto	u1681
	goto	u1680
u1681:
	goto	l1798
u1680:
	line	112
	
l1810:	
	movlw	(06h)
	fcall	_cmd
	line	113
	movlw	(014h)
	fcall	_cmd
	line	114
	
l219:	
	return
	opt stack 0
GLOBAL	__end_of_clr_char
	__end_of_clr_char:
;; =============== function _clr_char ends ============

	signat	_clr_char,4216
	global	_cmd
psect	text343,local,class=CODE,delta=2
global __ptext343
__ptext343:

;; *************** function _cmd *****************
;; Defined at:
;;		line 95 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;  cmd_msg         1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  cmd_msg         1    5[BANK0 ] unsigned char 
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
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_clr_char
;;		_floor_details
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text343
	file	"LEDCode.c"
	line	95
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 5
; Regs used in _cmd: [wreg]
	bcf	status, 5	;RP0=0, select bank0
	movwf	(cmd@cmd_msg)
	line	96
	
l1782:	
	movf	(cmd@cmd_msg),w
	movwf	(6)	;volatile
	line	97
	
l1784:	
	bcf	(44/8),(44)&7
	line	98
	
l1786:	
	bsf	(43/8),(43)&7
	line	99
	
l1788:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	100
	
l1790:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	101
	
l213:	
	return
	opt stack 0
GLOBAL	__end_of_cmd
	__end_of_cmd:
;; =============== function _cmd ends ============

	signat	_cmd,4216
	global	_disp_string
psect	text344,local,class=CODE,delta=2
global __ptext344
__ptext344:

;; *************** function _disp_string *****************
;; Defined at:
;;		line 77 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;  c               1    wreg     PTR const unsigned char 
;;		 -> stopped_msg(11), reached_msg(12), moving_msg(11), floor_msg(7), 
;;		 -> ROM(1024), people_msg(9), 
;; Auto vars:     Size  Location     Type
;;  c               1    5[BANK0 ] PTR const unsigned char 
;;		 -> stopped_msg(11), reached_msg(12), moving_msg(11), floor_msg(7), 
;;		 -> ROM(1024), people_msg(9), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       1
;;      Temps:          0       0
;;      Totals:         0       1
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_floor_details
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text344
	file	"LEDCode.c"
	line	77
	global	__size_of_disp_string
	__size_of_disp_string	equ	__end_of_disp_string-_disp_string
	
_disp_string:	
	opt	stack 5
; Regs used in _disp_string: [wreg-fsr0h+status,2+status,0+pclath]
	movwf	(disp_string@c)
	line	78
	
l1758:	
	bsf	(44/8),(44)&7
	line	79
	
l1760:	
	movf	(disp_string@c),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u1661
	goto	u1660
u1661:
	goto	l1780
u1660:
	line	80
	
l1762:	
	movf	(_temp),w
	movwf	(6)	;volatile
	line	81
	
l1764:	
	bsf	(43/8),(43)&7
	line	82
	
l1766:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	83
	
l1768:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	84
	goto	l210
	line	87
	
l1770:	
	movf	(disp_string@c),w
	movwf	fsr0
	fcall	stringdir
	movwf	(6)	;volatile
	line	88
	
l1772:	
	bsf	(43/8),(43)&7
	line	89
	
l1774:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	90
	
l1776:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	86
	
l1778:	
	incf	(disp_string@c),f
	
l1780:	
	movf	(disp_string@c),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u1671
	goto	u1670
u1671:
	goto	l1770
u1670:
	line	93
	
l210:	
	return
	opt stack 0
GLOBAL	__end_of_disp_string
	__end_of_disp_string:
;; =============== function _disp_string ends ============

	signat	_disp_string,4216
	global	_set_floor
psect	text345,local,class=CODE,delta=2
global __ptext345
__ptext345:

;; *************** function _set_floor *****************
;; Defined at:
;;		line 219 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 120/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       1
;;      Totals:         0       1
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_floor_details
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text345
	file	"LEDCode.c"
	line	219
	global	__size_of_set_floor
	__size_of_set_floor	equ	__end_of_set_floor-_set_floor
	
_set_floor:	
	opt	stack 3
; Regs used in _set_floor: [wreg-fsr0h+status,2+status,0]
	line	220
	
l1710:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorwf	(_floor_direction),w
	skipnz
	goto	u1511
	goto	u1510
u1511:
	goto	l292
u1510:
	
l1712:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	80h
	addlw	-((03h)^80h)
	skipnc
	goto	u1521
	goto	u1520
u1521:
	goto	l292
u1520:
	line	221
	
l1714:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	02h
	skipz
	goto	u1531
	goto	u1530
u1531:
	goto	l279
u1530:
	line	222
	
l1716:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(03h)
	movwf	indf
	
l279:	
	line	223
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	(_floor_direction),w
	addwf	indf,f
	line	224
	
l1718:	
	btfss	(_prob_move/8),(_prob_move)&7
	goto	u1541
	goto	u1540
u1541:
	goto	l1724
u1540:
	line	225
	
l1720:	
	movf	(_floor_index),w
	movwf	(_destination_floor)
	line	226
	
l1722:	
	bcf	(_prob_move/8),(_prob_move)&7
	line	227
	goto	l292
	line	228
	
l1724:	
	incf	(_destination_floor),w
	skipnz
	goto	u1551
	goto	u1550
u1551:
	goto	l292
u1550:
	line	230
	
l1726:	
	movf	(_current_floor),w
	xorlw	80h
	movwf	(??_set_floor+0)+0
	movf	(_destination_floor),w
	xorlw	80h
	subwf	(??_set_floor+0)+0
	skipnc
	goto	u1561
	goto	u1560
u1561:
	goto	l1736
u1560:
	
l1728:	
	movf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorwf	(_floor_direction),w
	skipnz
	goto	u1571
	goto	u1570
u1571:
	goto	l1734
u1570:
	
l1730:	
	movf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	80h
	addlw	-((03h)^80h)
	skipnc
	goto	u1581
	goto	u1580
u1581:
	goto	l1734
u1580:
	
l1732:	
	movf	(_floor_index),w
	xorlw	03h
	skipz
	goto	u1591
	goto	u1590
u1591:
	goto	l1736
u1590:
	
l1734:	
	movf	(_destination_floor),w
	xorlw	80h
	movwf	(??_set_floor+0)+0
	movf	(_floor_index),w
	xorlw	80h
	subwf	(??_set_floor+0)+0
	skipc
	goto	u1601
	goto	u1600
u1601:
	goto	l1746
u1600:
	
l1736:	
	movf	(_destination_floor),w
	xorlw	80h
	movwf	(??_set_floor+0)+0
	movf	(_current_floor),w
	xorlw	80h
	subwf	(??_set_floor+0)+0
	skipnc
	goto	u1611
	goto	u1610
u1611:
	goto	l281
u1610:
	
l1738:	
	movf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorwf	(_floor_direction),w
	skipnz
	goto	u1621
	goto	u1620
u1621:
	goto	l1744
u1620:
	
l1740:	
	movf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	80h
	addlw	-((03h)^80h)
	skipnc
	goto	u1631
	goto	u1630
u1631:
	goto	l1744
u1630:
	
l1742:	
	movf	(_floor_index),f
	skipz
	goto	u1641
	goto	u1640
u1641:
	goto	l281
u1640:
	
l1744:	
	movf	(_floor_index),w
	xorlw	80h
	movwf	(??_set_floor+0)+0
	movf	(_destination_floor),w
	xorlw	80h
	subwf	(??_set_floor+0)+0
	skipnc
	goto	u1651
	goto	u1650
u1651:
	goto	l281
u1650:
	line	231
	
l1746:	
	movf	(_floor_index),w
	movwf	(_destination_floor)
	goto	l292
	line	235
	
l281:	
	line	236
	
l292:	
	return
	opt stack 0
GLOBAL	__end_of_set_floor
	__end_of_set_floor:
;; =============== function _set_floor ends ============

	signat	_set_floor,88
	global	_call_min
psect	text346,local,class=CODE,delta=2
global __ptext346
__ptext346:

;; *************** function _call_min *****************
;; Defined at:
;;		line 212 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text346
	file	"LEDCode.c"
	line	212
	global	__size_of_call_min
	__size_of_call_min	equ	__end_of_call_min-_call_min
	
_call_min:	
	opt	stack 4
; Regs used in _call_min: [wreg-fsr0h+status,2+status,0]
	line	213
	
l1694:	
	movlw	(03h)
	movwf	(_i)
	
l1696:	
	btfss	(_i),7
	goto	u1481
	goto	u1480
u1481:
	goto	l1700
u1480:
	goto	l275
	line	214
	
l1700:	
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,f
	skipz
	goto	u1491
	goto	u1490
u1491:
	goto	l1704
u1490:
	
l1702:	
	movf	(_i),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf
	skipnz
	goto	u1501
	goto	u1500
u1501:
	goto	l1706
u1500:
	line	215
	
l1704:	
	movf	(_i),w
	movwf	(_destination_floor)
	line	213
	
l1706:	
	decf	(_i),f
	goto	l1696
	line	217
	
l275:	
	return
	opt stack 0
GLOBAL	__end_of_call_min
	__end_of_call_min:
;; =============== function _call_min ends ============

	signat	_call_min,88
	global	_call_max
psect	text347,local,class=CODE,delta=2
global __ptext347
__ptext347:

;; *************** function _call_max *****************
;; Defined at:
;;		line 203 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_moving
;; This function uses a non-reentrant model
;;
psect	text347
	file	"LEDCode.c"
	line	203
	global	__size_of_call_max
	__size_of_call_max	equ	__end_of_call_max-_call_max
	
_call_max:	
	opt	stack 4
; Regs used in _call_max: [wreg-fsr0h+status,2+status,0]
	line	204
	
l1678:	
	movlw	(03h)
	movwf	(_i)
	
l1680:	
	btfss	(_i),7
	goto	u1451
	goto	u1450
u1451:
	goto	l1684
u1450:
	goto	l267
	line	205
	
l1684:	
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,f
	skipz
	goto	u1461
	goto	u1460
u1461:
	goto	l1688
u1460:
	
l1686:	
	movf	(_i),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf
	skipnz
	goto	u1471
	goto	u1470
u1471:
	goto	l1690
u1470:
	line	206
	
l1688:	
	movf	(_i),w
	movwf	(_destination_floor)
	line	207
	goto	l267
	line	204
	
l1690:	
	decf	(_i),f
	goto	l1680
	line	210
	
l267:	
	return
	opt stack 0
GLOBAL	__end_of_call_max
	__end_of_call_max:
;; =============== function _call_max ends ============

	signat	_call_max,88
	global	_max_prob_floor
psect	text348,local,class=CODE,delta=2
global __ptext348
__ptext348:

;; *************** function _max_prob_floor *****************
;; Defined at:
;;		line 190 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 120/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       3
;;      Totals:         0       3
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text348
	file	"LEDCode.c"
	line	190
	global	__size_of_max_prob_floor
	__size_of_max_prob_floor	equ	__end_of_max_prob_floor-_max_prob_floor
	
_max_prob_floor:	
	opt	stack 5
; Regs used in _max_prob_floor: [wreg-fsr0h+status,2+status,0]
	line	191
	
l1660:	
	bsf	(_prob_move/8),(_prob_move)&7
	line	192
	
l1662:	
	movlw	(03h)
	movwf	(_destination_floor)
	line	193
	movlw	(02h)
	movwf	(_i)
	incf	(_i),w
	skipz
	goto	u1401
	goto	u1400
u1401:
	goto	l1666
u1400:
	goto	l1674
	line	194
	
l1666:	
	movf	(_destination_floor),w
	addwf	(_destination_floor),w
	addwf	(_destination_floor),w
	addlw	_prob_matrix&0ffh
	addwf	(_hour),w
	movwf	(??_max_prob_floor+0)+0
	movf	0+(??_max_prob_floor+0)+0,w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorlw	80h
	movwf	(??_max_prob_floor+1)+0
	movf	(_i),w
	addwf	(_i),w
	addwf	(_i),w
	addlw	_prob_matrix&0ffh
	addwf	(_hour),w
	movwf	(??_max_prob_floor+2)+0
	movf	0+(??_max_prob_floor+2)+0,w
	movwf	fsr0
	movf	indf,w
	xorlw	80h
	subwf	(??_max_prob_floor+1)+0
	skipnc
	goto	u1411
	goto	u1410
u1411:
	goto	l1670
u1410:
	line	195
	
l1668:	
	movf	(_i),w
	movwf	(_destination_floor)
	line	193
	
l1670:	
	decf	(_i),f
	
l1672:	
	incf	(_i),w
	skipz
	goto	u1421
	goto	u1420
u1421:
	goto	l1666
u1420:
	line	197
	
l1674:	
	movf	(_destination_floor),w
	addwf	(_destination_floor),w
	addwf	(_destination_floor),w
	addlw	_prob_matrix&0ffh
	addwf	(_hour),w
	movwf	(??_max_prob_floor+0)+0
	movf	0+(??_max_prob_floor+0)+0,w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf
	skipnz
	goto	u1431
	goto	u1430
u1431:
	goto	l258
u1430:
	
l1676:	
	movf	(_current_floor),w
	xorwf	(_destination_floor),w
	skipz
	goto	u1441
	goto	u1440
u1441:
	goto	l259
u1440:
	
l258:	
	line	198
	clrf	(_destination_floor)
	decf	(_destination_floor),f
	line	199
	bcf	(_prob_move/8),(_prob_move)&7
	line	201
	
l259:	
	return
	opt stack 0
GLOBAL	__end_of_max_prob_floor
	__end_of_max_prob_floor:
;; =============== function _max_prob_floor ends ============

	signat	_max_prob_floor,88
	global	_button_press
psect	text349,local,class=CODE,delta=2
global __ptext349
__ptext349:

;; *************** function _button_press *****************
;; Defined at:
;;		line 149 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_floor_details
;;		_moving
;;		_main
;; This function uses a non-reentrant model
;;
psect	text349
	file	"LEDCode.c"
	line	149
	global	__size_of_button_press
	__size_of_button_press	equ	__end_of_button_press-_button_press
	
_button_press:	
	opt	stack 3
; Regs used in _button_press: [wreg+status,2+status,0]
	line	150
	
l1586:	
	clrf	(_button)
	decf	(_button),f
	line	151
	clrf	(_floor_index)
	decf	(_floor_index),f
	line	152
	clrf	(_floor_direction)
	decf	(_floor_direction),f
	line	154
	btfsc	(40/8),(40)&7
	goto	u1131
	goto	u1130
u1131:
	goto	l230
u1130:
	
l1588:	
	btfsc	(41/8),(41)&7
	goto	u1141
	goto	u1140
u1141:
	goto	l230
u1140:
	
l1590:	
	btfsc	(42/8),(42)&7
	goto	u1151
	goto	u1150
u1151:
	goto	l230
u1150:
	line	155
	
l1592:	
	clrf	(_button)
	incf	(_button),f
	goto	l231
	line	156
	
l230:	
	btfss	(40/8),(40)&7
	goto	u1161
	goto	u1160
u1161:
	goto	l232
u1160:
	
l1594:	
	btfsc	(41/8),(41)&7
	goto	u1171
	goto	u1170
u1171:
	goto	l232
u1170:
	
l1596:	
	btfsc	(42/8),(42)&7
	goto	u1181
	goto	u1180
u1181:
	goto	l232
u1180:
	line	157
	
l1598:	
	movlw	(02h)
	movwf	(_button)
	goto	l231
	line	158
	
l232:	
	btfsc	(40/8),(40)&7
	goto	u1191
	goto	u1190
u1191:
	goto	l234
u1190:
	
l1600:	
	btfss	(41/8),(41)&7
	goto	u1201
	goto	u1200
u1201:
	goto	l234
u1200:
	
l1602:	
	btfsc	(42/8),(42)&7
	goto	u1211
	goto	u1210
u1211:
	goto	l234
u1210:
	line	159
	
l1604:	
	movlw	(03h)
	movwf	(_button)
	goto	l231
	line	160
	
l234:	
	btfss	(40/8),(40)&7
	goto	u1221
	goto	u1220
u1221:
	goto	l236
u1220:
	
l1606:	
	btfss	(41/8),(41)&7
	goto	u1231
	goto	u1230
u1231:
	goto	l236
u1230:
	
l1608:	
	btfsc	(42/8),(42)&7
	goto	u1241
	goto	u1240
u1241:
	goto	l236
u1240:
	line	161
	
l1610:	
	movlw	(04h)
	movwf	(_button)
	goto	l231
	line	162
	
l236:	
	btfsc	(40/8),(40)&7
	goto	u1251
	goto	u1250
u1251:
	goto	l238
u1250:
	
l1612:	
	btfsc	(41/8),(41)&7
	goto	u1261
	goto	u1260
u1261:
	goto	l238
u1260:
	
l1614:	
	btfss	(42/8),(42)&7
	goto	u1271
	goto	u1270
u1271:
	goto	l238
u1270:
	line	163
	
l1616:	
	movlw	(05h)
	movwf	(_button)
	goto	l231
	line	164
	
l238:	
	btfss	(40/8),(40)&7
	goto	u1281
	goto	u1280
u1281:
	goto	l240
u1280:
	
l1618:	
	btfsc	(41/8),(41)&7
	goto	u1291
	goto	u1290
u1291:
	goto	l240
u1290:
	
l1620:	
	btfss	(42/8),(42)&7
	goto	u1301
	goto	u1300
u1301:
	goto	l240
u1300:
	line	165
	
l1622:	
	movlw	(06h)
	movwf	(_button)
	goto	l231
	line	166
	
l240:	
	btfsc	(40/8),(40)&7
	goto	u1311
	goto	u1310
u1311:
	goto	l237
u1310:
	
l1624:	
	btfss	(41/8),(41)&7
	goto	u1321
	goto	u1320
u1321:
	goto	l237
u1320:
	
l1626:	
	btfss	(42/8),(42)&7
	goto	u1331
	goto	u1330
u1331:
	goto	l237
u1330:
	line	167
	
l1628:	
	movlw	(07h)
	movwf	(_button)
	goto	l231
	line	169
	
l237:	
	
l231:	
	incf	(_button),w
	skipnz
	goto	u1341
	goto	u1340
u1341:
	goto	l250
u1340:
	line	170
	
l1630:	
	decf	(_button),w
	skipz
	goto	u1351
	goto	u1350
u1351:
	goto	l1636
u1350:
	line	171
	
l1632:	
	clrf	(_floor_index)
	line	172
	
l1634:	
	clrf	(_floor_direction)
	incf	(_floor_direction),f
	line	174
	
l1636:	
	movlw	(05h)
	movwf	(_i)
	
l1638:	
	decf	(_i),w
	skipz
	goto	u1361
	goto	u1360
u1361:
	goto	l1642
u1360:
	goto	l1656
	line	175
	
l1642:	
	movf	(_button),w
	xorwf	(_i),w
	skipz
	goto	u1371
	goto	u1370
u1371:
	goto	l1652
u1370:
	line	176
	
l1644:	
	rlf	(_i),w
	rrf	(_i),w
	movwf	(_floor_index)
	line	177
	
l1646:	
	clrf	(_floor_direction)
	incf	(_floor_direction),f
	line	178
	
l1648:	
	btfss	(_i),(0)&7
	goto	u1381
	goto	u1380
u1381:
	goto	l1656
u1380:
	line	179
	
l1650:	
	movlw	(02h)
	movwf	(_floor_direction)
	goto	l1656
	line	174
	
l1652:	
	decf	(_i),f
	goto	l1638
	line	183
	
l1656:	
	movf	(_button),w
	xorlw	06h
	skipz
	goto	u1391
	goto	u1390
u1391:
	goto	l250
u1390:
	line	184
	
l1658:	
	movlw	(03h)
	movwf	(_floor_index)
	line	185
	movlw	(02h)
	movwf	(_floor_direction)
	line	188
	
l250:	
	return
	opt stack 0
GLOBAL	__end_of_button_press
	__end_of_button_press:
;; =============== function _button_press ends ============

	signat	_button_press,88
	global	_initialize
psect	text350,local,class=CODE,delta=2
global __ptext350
__ptext350:

;; *************** function _initialize *****************
;; Defined at:
;;		line 116 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       0
;;      Totals:         0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text350
	file	"LEDCode.c"
	line	116
	global	__size_of_initialize
	__size_of_initialize	equ	__end_of_initialize-_initialize
	
_initialize:	
	opt	stack 5
; Regs used in _initialize: [wreg+status,2]
	line	118
	
l1554:	
	clrf	(5)	;volatile
	line	119
	clrf	(6)	;volatile
	line	120
	bsf	status, 5	;RP0=1, select bank1
	clrf	(134)^080h	;volatile
	line	121
	
l1556:	
	movlw	(07h)
	movwf	(133)^080h	;volatile
	line	124
	
l1558:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(1)	;volatile
	line	125
	movlw	(08h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(129)^080h	;volatile
	line	126
	
l1560:	
	bsf	(93/8),(93)&7
	line	127
	
l1562:	
	bsf	(95/8),(95)&7
	line	132
	
l222:	
	return
	opt stack 0
GLOBAL	__end_of_initialize
	__end_of_initialize:
;; =============== function _initialize ends ============

	signat	_initialize,88
	global	_hour_ISR
psect	text351,local,class=CODE,delta=2
global __ptext351
__ptext351:

;; *************** function _hour_ISR *****************
;; Defined at:
;;		line 134 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 20/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0
;;      Params:         0       0
;;      Locals:         0       0
;;      Temps:          0       4
;;      Totals:         0       4
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		i1_cmd
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text351
	file	"LEDCode.c"
	line	134
	global	__size_of_hour_ISR
	__size_of_hour_ISR	equ	__end_of_hour_ISR-_hour_ISR
	
_hour_ISR:	
	opt	stack 2
; Regs used in _hour_ISR: [wreg+status,2+status,0+pclath+cstack]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_hour_ISR+2)
	movf	pclath,w
	movwf	(??_hour_ISR+3)
	ljmp	_hour_ISR
psect	text351
	line	135
	
i1l1564:	
	movlw	-1
	addwf	(_counter2),f
	skipc
	decf	(_counter2+1),f
	line	136
	
i1l1566:	
	movf	((_counter2+1)),w
	iorwf	((_counter2)),w
	skipz
	goto	u111_21
	goto	u111_20
u111_21:
	goto	i1l1582
u111_20:
	line	137
	
i1l1568:	
	movlw	low(0BB8h)
	movwf	(_counter2)
	movlw	high(0BB8h)
	movwf	((_counter2))+1
	line	138
	
i1l1570:	
	incf	(_hour),f
	line	139
	
i1l1572:	
	movf	(_hour),w
	xorlw	03h
	skipz
	goto	u112_21
	goto	u112_20
u112_21:
	goto	i1l1576
u112_20:
	line	140
	
i1l1574:	
	clrf	(_hour)
	line	141
	
i1l1576:	
	movlw	(0Ah)
	fcall	i1_cmd
	line	142
	
i1l1578:	
	opt asmopt_off
movlw	13
movwf	((??_hour_ISR+0)+0+1),f
	movlw	251
movwf	((??_hour_ISR+0)+0),f
u223_27:
	decfsz	((??_hour_ISR+0)+0),f
	goto	u223_27
	decfsz	((??_hour_ISR+0)+0+1),f
	goto	u223_27
	nop2
opt asmopt_on

	line	143
	
i1l1580:	
	movlw	(0Eh)
	fcall	i1_cmd
	line	145
	
i1l1582:	
	bcf	(90/8),(90)&7
	line	146
	
i1l1584:	
	bsf	(95/8),(95)&7
	line	147
	
i1l227:	
	movf	(??_hour_ISR+3),w
	movwf	pclath
	swapf	(??_hour_ISR+2)^00h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_hour_ISR
	__end_of_hour_ISR:
;; =============== function _hour_ISR ends ============

	signat	_hour_ISR,88
	global	i1_cmd
psect	text352,local,class=CODE,delta=2
global __ptext352
__ptext352:

;; *************** function i1_cmd *****************
;; Defined at:
;;		line 95 in file "LEDCode.c"
;; Parameters:    Size  Location     Type
;;  cmd             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  cmd             1    0[BANK0 ] unsigned char 
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
;;		_hour_ISR
;; This function uses a non-reentrant model
;;
psect	text352
	file	"LEDCode.c"
	line	95
	global	__size_ofi1_cmd
	__size_ofi1_cmd	equ	__end_ofi1_cmd-i1_cmd
	
i1_cmd:	
	opt	stack 2
; Regs used in i1_cmd: [wreg]
	bcf	status, 5	;RP0=0, select bank0
	movwf	(i1cmd@cmd_msg)
	line	96
	
i1l1748:	
	movf	(i1cmd@cmd_msg),w
	movwf	(6)	;volatile
	line	97
	
i1l1750:	
	bcf	(44/8),(44)&7
	line	98
	
i1l1752:	
	bsf	(43/8),(43)&7
	line	99
	
i1l1754:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	100
	
i1l1756:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	101
	
i1l213:	
	return
	opt stack 0
GLOBAL	__end_ofi1_cmd
	__end_ofi1_cmd:
;; =============== function i1_cmd ends ============

	signat	i1_cmd,88
psect	text353,local,class=CODE,delta=2
global __ptext353
__ptext353:
	global	btemp
	btemp set 04Eh

	DABS	1,78,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
