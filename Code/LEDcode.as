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
# 4 "LEDcode.c"
	psect config,class=CONFIG,delta=2 ;#
# 4 "LEDcode.c"
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
	file	"LEDcode.c"
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
	file	"LEDcode.c"
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
	file	"LEDcode.c"
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
	file	"LEDcode.c"
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
	file	"LEDcode.c"
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
	file	"LEDcode.as"
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
;;		line 399 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	399
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 2
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	400
	
l2077:	
	fcall	_initialize
	line	401
	
l2079:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(_hour)
	line	402
	
l2081:	
	movlw	low(0BB8h)
	movwf	(_counter2)
	movlw	high(0BB8h)
	movwf	((_counter2))+1
	line	403
	
l2083:	
	bcf	(_prob_move/8),(_prob_move)&7
	line	404
	
l2085:	
	clrf	(_current_floor)
	line	405
	
l2087:	
	clrf	(_destination_floor)
	decf	(_destination_floor),f
	line	406
	
l2089:	
	movlw	(-10)
	movwf	(_i)
	line	407
	
l360:	
	line	408
	fcall	_button_press
	line	409
	
l2091:	
	incf	(_button),w
	skipnz
	goto	u2171
	goto	u2170
u2171:
	goto	l2103
u2170:
	
l2093:	
	movf	(_button),w
	xorlw	07h
	skipnz
	goto	u2181
	goto	u2180
u2181:
	goto	l2103
u2180:
	line	410
	
l2095:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	(_floor_direction),w
	movwf	indf
	line	411
	
l2097:	
	movf	(_floor_index),w
	movwf	(_destination_floor)
	goto	l2103
	line	414
	
l2099:	
	fcall	_moving
	line	415
	
l2101:	
	movlw	(-10)
	movwf	(_i)
	line	413
	
l2103:	
	incf	(_destination_floor),w
	skipz
	goto	u2191
	goto	u2190
u2191:
	goto	l2099
u2190:
	line	417
	
l2105:	
	movf	(_i),w
	xorlw	-10
	skipz
	goto	u2201
	goto	u2200
u2201:
	goto	l2117
u2200:
	line	418
	
l2107:	
	movlw	(-9)
	movwf	(_i)
	line	419
	
l2109:	
	movlw	(01h)
	fcall	_cmd
	line	420
	
l2111:	
	movf	(_current_floor),w
	addlw	030h
	movwf	(_temp)
	line	421
	
l2113:	
	movlw	((_stopped_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	422
	
l2115:	
	movlw	(0)
	fcall	_disp_string
	line	424
	
l2117:	
	fcall	_max_prob_floor
	goto	l360
	global	start
	ljmp	start
	opt stack 0
psect	maintext
	line	426
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
;;		line 316 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	316
	global	__size_of_moving
	__size_of_moving	equ	__end_of_moving-_moving
	
_moving:	
	opt	stack 2
; Regs used in _moving: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	317
	
l1931:	
	movlw	low(03E8h)
	movwf	(moving@counter)
	movlw	high(03E8h)
	movwf	((moving@counter))+1
	line	318
	goto	l2015
	line	319
	
l1933:	
	movlw	(01h)
	fcall	_cmd
	line	320
	
l1935:	
	movf	(_current_floor),w
	addlw	030h
	movwf	(_temp)
	line	321
	
l1937:	
	movlw	((_moving_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	322
	
l1939:	
	movlw	(0)
	fcall	_disp_string
	line	323
	goto	l2009
	line	324
	
l1941:	
	movlw	-1
	addwf	(moving@counter),f
	skipc
	decf	(moving@counter+1),f
	line	325
	
l1943:	
	fcall	_button_press
	line	326
	
l1945:	
	incf	(_button),w
	skipnz
	goto	u1901
	goto	u1900
u1901:
	goto	l1951
u1900:
	
l1947:	
	movf	(_button),w
	xorlw	07h
	skipnz
	goto	u1911
	goto	u1910
u1911:
	goto	l1951
u1910:
	line	327
	
l1949:	
	fcall	_set_floor
	line	329
	
l1951:	
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
	goto	l1961
u1920:
	
l1953:	
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
	goto	l1957
u1930:
	
l1955:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipnz
	goto	u1941
	goto	u1940
u1941:
	goto	l1961
u1940:
	
l1957:	
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
	goto	l1991
u1950:
	
l1959:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	02h
	skipz
	goto	u1961
	goto	u1960
u1961:
	goto	l1991
u1960:
	line	330
	
l1961:	
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
	goto	l1967
u1970:
	
l1963:	
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
	goto	l1967
u1980:
	line	331
	
l1965:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(02h)
	movwf	indf
	goto	l339
	line	332
	
l1967:	
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
	goto	l1973
u1990:
	
l1969:	
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
	goto	l1973
u2000:
	line	333
	
l1971:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	clrf	indf
	incf	indf,f
	goto	l339
	line	335
	
l1973:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	clrf	indf
	
l339:	
	line	336
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	337
	
l1975:	
	movlw	(01h)
	fcall	_cmd
	line	338
	
l1977:	
	movlw	((_reached_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	339
	
l1979:	
	movlw	(0)
	fcall	_disp_string
	line	340
	
l1981:	
	fcall	_floor_details
	line	341
	
l1983:	
	movlw	(01h)
	fcall	_cmd
	line	342
	
l1985:	
	movf	(_current_floor),w
	addlw	030h
	movwf	(_temp)
	line	343
	
l1987:	
	movlw	((_moving_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	344
	
l1989:	
	movlw	(0)
	fcall	_disp_string
	line	346
	
l1991:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf
	skipnz
	goto	u2011
	goto	u2010
u2011:
	goto	l2009
u2010:
	line	347
	
l1993:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	348
	
l1995:	
	movlw	(01h)
	fcall	_cmd
	line	349
	
l1997:	
	movlw	((_reached_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	350
	
l1999:	
	movlw	(0)
	fcall	_disp_string
	line	351
	
l2001:	
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

	line	352
	
l2003:	
	movlw	(01h)
	fcall	_cmd
	line	353
	
l2005:	
	movlw	((_moving_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	354
	
l2007:	
	movlw	(0)
	fcall	_disp_string
	line	323
	
l2009:	
	movf	((moving@counter+1)),w
	iorwf	((moving@counter)),w
	skipz
	goto	u2021
	goto	u2020
u2021:
	goto	l1941
u2020:
	line	357
	
l2011:	
	movlw	low(03E8h)
	movwf	(moving@counter)
	movlw	high(03E8h)
	movwf	((moving@counter))+1
	line	358
	
l2013:	
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
	line	318
	
l2015:	
	movf	(_current_floor),w
	xorwf	(_destination_floor),w
	skipz
	goto	u2061
	goto	u2060
u2061:
	goto	l1933
u2060:
	line	360
	
l2017:	
	movlw	(01h)
	fcall	_cmd
	line	361
	
l2019:	
	movf	(_destination_floor),w
	addlw	030h
	movwf	(_temp)
	line	362
	
l2021:	
	movlw	((_reached_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	363
	
l2023:	
	movlw	(0)
	fcall	_disp_string
	line	364
	
l2025:	
	bcf	(_prob_move/8),(_prob_move)&7
	line	365
	
l2027:	
	clrf	(_destination_floor)
	decf	(_destination_floor),f
	line	366
	
l2029:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf
	skipnz
	goto	u2071
	goto	u2070
u2071:
	goto	l2047
u2070:
	line	367
	
l2031:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	368
	
l2033:	
	fcall	_floor_details
	line	369
	
l2035:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	btfsc	indf,(0)&7
	goto	u2081
	goto	u2080
u2081:
	goto	l2043
u2080:
	line	370
	
l2037:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorlw	04h
	skipz
	goto	u2091
	goto	u2090
u2091:
	goto	l347
u2090:
	line	371
	
l2039:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(03h)
	movwf	indf
	
l347:	
	line	372
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(-2)
	addwf	indf,f
	line	373
	
l2041:	
	fcall	_call_min
	line	374
	goto	l2061
	line	376
	
l2043:	
	movf	(_current_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	decf	indf,f
	line	377
	
l2045:	
	fcall	_call_max
	goto	l2061
	line	380
	
l2047:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	movf	indf
	skipnz
	goto	u2101
	goto	u2100
u2101:
	goto	l2061
u2100:
	line	381
	
l2049:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	decf	indf,w
	skipz
	goto	u2111
	goto	u2110
u2111:
	goto	l2055
u2110:
	line	382
	
l2051:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	383
	
l2053:	
	fcall	_call_min
	line	384
	goto	l2059
	line	386
	
l2055:	
	movf	(_current_floor),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	clrf	indf
	line	387
	
l2057:	
	fcall	_call_max
	line	389
	
l2059:	
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

	line	391
	
l2061:	
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
	goto	l2067
u2120:
	
l2063:	
	incf	(_destination_floor),w
	skipnz
	goto	u2131
	goto	u2130
u2131:
	goto	l2067
u2130:
	line	392
	
l2065:	
	fcall	_call_max
	goto	l2073
	line	393
	
l2067:	
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
	goto	l2073
u2140:
	
l2069:	
	incf	(_destination_floor),w
	skipnz
	goto	u2151
	goto	u2150
u2151:
	goto	l2073
u2150:
	line	394
	
l2071:	
	fcall	_call_min
	line	395
	
l2073:	
	incf	(_destination_floor),w
	skipz
	goto	u2161
	goto	u2160
u2161:
	goto	l357
u2160:
	line	396
	
l2075:	
	fcall	_max_prob_floor
	line	397
	
l357:	
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
;;		line 232 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	232
	global	__size_of_floor_details
	__size_of_floor_details	equ	__end_of_floor_details-_floor_details
	
_floor_details:	
	opt	stack 2
; Regs used in _floor_details: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	233
	
l1807:	
	movlw	(0C0h)
	fcall	_cmd
	line	234
	
l1809:	
	clrf	(floor_details@j)
	line	235
	
l1811:	
	movlw	(030h)
	movwf	(_temp)
	line	236
	
l1813:	
	movlw	((_people_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	237
	
l1815:	
	movlw	(0)
	fcall	_disp_string
	line	238
	
l1817:	
	fcall	_button_press
	line	239
	goto	l1849
	line	240
	
l1819:	
	incf	(_button),w
	skipnz
	goto	u1691
	goto	u1690
u1691:
	goto	l1817
u1690:
	line	241
	
l1821:	
	movf	(_floor_index),w
	xorwf	(_current_floor),w
	skipz
	goto	u1701
	goto	u1700
u1701:
	goto	l1845
u1700:
	line	242
	
l1823:	
	btfss	(_button),(0)&7
	goto	u1711
	goto	u1710
u1711:
	goto	l1833
u1710:
	
l1825:	
	decf	(_button),w
	skipnz
	goto	u1721
	goto	u1720
u1721:
	goto	l1833
u1720:
	line	243
	
l1827:	
	movf	(floor_details@j),f
	skipz
	goto	u1731
	goto	u1730
u1731:
	goto	l1831
u1730:
	line	244
	
l1829:	
	movlw	(06h)
	movwf	(floor_details@j)
	line	245
	
l1831:	
	decf	(floor_details@j),f
	line	246
	goto	l1839
	line	248
	
l1833:	
	movf	(floor_details@j),w
	xorlw	05h
	skipz
	goto	u1741
	goto	u1740
u1741:
	goto	l1837
u1740:
	line	249
	
l1835:	
	clrf	(floor_details@j)
	decf	(floor_details@j),f
	line	250
	
l1837:	
	incf	(floor_details@j),f
	line	252
	
l1839:	
	movlw	(01h)
	fcall	_clr_char
	line	253
	
l1841:	
	movf	(floor_details@j),w
	addlw	030h
	movwf	(_temp)
	line	254
	
l1843:	
	movlw	(0)
	fcall	_disp_string
	line	255
	goto	l1817
	line	257
	
l1845:	
	fcall	_set_floor
	goto	l1817
	line	239
	
l1849:	
	movf	(_button),w
	xorlw	07h
	skipz
	goto	u1751
	goto	u1750
u1751:
	goto	l1819
u1750:
	line	261
	
l1851:	
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
	line	262
	
l1853:	
	movlw	(09h)
	fcall	_clr_char
	line	263
	
l1855:	
	clrf	(floor_details@j)
	line	264
	
l1857:	
	movf	(_current_floor),f
	skipz
	goto	u1761
	goto	u1760
u1761:
	goto	l1861
u1760:
	line	265
	
l1859:	
	clrf	(floor_details@j)
	incf	(floor_details@j),f
	line	266
	
l1861:	
	movf	(floor_details@j),w
	addlw	030h
	movwf	(_temp)
	line	267
	
l1863:	
	movlw	((_floor_msg-__stringbase))&0ffh
	fcall	_disp_string
	line	268
	
l1865:	
	movlw	(0)
	fcall	_disp_string
	line	270
	
l1867:	
	fcall	_button_press
	line	271
	
l1869:	
	incf	(_button),w
	skipnz
	goto	u1771
	goto	u1770
u1771:
	goto	l1867
u1770:
	line	272
	
l1871:	
	movf	(_floor_index),w
	xorwf	(_current_floor),w
	skipz
	goto	u1781
	goto	u1780
u1781:
	goto	l1913
u1780:
	line	273
	
l1873:	
	btfss	(_button),(0)&7
	goto	u1791
	goto	u1790
u1791:
	goto	l1891
u1790:
	
l1875:	
	decf	(_button),w
	skipnz
	goto	u1801
	goto	u1800
u1801:
	goto	l1891
u1800:
	line	274
	
l1877:	
	movf	(floor_details@j),f
	skipz
	goto	u1811
	goto	u1810
u1811:
	goto	l1881
u1810:
	line	275
	
l1879:	
	movlw	(05h)
	movwf	(floor_details@j)
	line	276
	
l1881:	
	decf	(floor_details@j),f
	line	277
	
l1883:	
	movf	(floor_details@j),w
	xorwf	(_current_floor),w
	skipz
	goto	u1821
	goto	u1820
u1821:
	goto	l1901
u1820:
	line	278
	
l1885:	
	movf	(floor_details@j),f
	skipz
	goto	u1831
	goto	u1830
u1831:
	goto	l1889
u1830:
	line	279
	
l1887:	
	movlw	(05h)
	movwf	(floor_details@j)
	line	280
	
l1889:	
	decf	(floor_details@j),f
	goto	l1901
	line	284
	
l1891:	
	movf	(floor_details@j),w
	xorlw	04h
	skipz
	goto	u1841
	goto	u1840
u1841:
	goto	l1895
u1840:
	line	285
	
l1893:	
	clrf	(floor_details@j)
	decf	(floor_details@j),f
	line	286
	
l1895:	
	incf	(floor_details@j),f
	line	287
	
l1897:	
	movf	(floor_details@j),w
	xorwf	(_current_floor),w
	skipz
	goto	u1851
	goto	u1850
u1851:
	goto	l1901
u1850:
	line	288
	
l1899:	
	incf	(floor_details@j),f
	line	290
	
l1901:	
	movlw	(01h)
	fcall	_clr_char
	line	291
	
l1903:	
	movf	(floor_details@j),w
	xorlw	04h
	skipz
	goto	u1861
	goto	u1860
u1861:
	goto	l1909
u1860:
	line	292
	
l1905:	
	movlw	(058h)
	movwf	(_temp)
	line	293
	
l1907:	
	movlw	(0)
	fcall	_disp_string
	line	294
	goto	l1867
	line	296
	
l1909:	
	movf	(floor_details@j),w
	addlw	030h
	movwf	(_temp)
	line	297
	
l1911:	
	movlw	(0)
	fcall	_disp_string
	goto	l1867
	line	300
	
l1913:	
	movf	(_button),w
	xorlw	07h
	skipz
	goto	u1871
	goto	u1870
u1871:
	goto	l1927
u1870:
	line	301
	
l1915:	
	movf	(floor_details@j),w
	xorlw	04h
	skipz
	goto	u1881
	goto	u1880
u1881:
	goto	l1921
u1880:
	goto	l1929
	line	304
	
l1921:	
	movf	(floor_details@j),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	clrf	indf
	incf	indf,f
	line	305
	
l1923:	
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
	goto	l306
u1890:
	line	306
	
l1925:	
	movf	(floor_details@j),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	movlw	(02h)
	movwf	indf
	goto	l1867
	line	310
	
l1927:	
	fcall	_set_floor
	goto	l1867
	line	311
	
l306:	
	goto	l1867
	line	313
	
l1929:	
	movlw	(07h)
	fcall	_clr_char
	line	314
	
l325:	
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
;;		line 103 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	103
	global	__size_of_clr_char
	__size_of_clr_char	equ	__end_of_clr_char-_clr_char
	
_clr_char:	
	opt	stack 2
; Regs used in _clr_char: [wreg+status,2+status,0+pclath+cstack]
	movwf	(clr_char@spaces)
	line	104
	
l1787:	
	movlw	(04h)
	fcall	_cmd
	line	105
	
l1789:	
	bsf	(44/8),(44)&7
	line	106
	
l1791:	
	movf	(clr_char@spaces),w
	movwf	(_i)
	goto	l1803
	line	107
	
l1793:	
	movlw	(020h)
	movwf	(6)	;volatile
	line	108
	
l1795:	
	bsf	(43/8),(43)&7
	line	109
	
l1797:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	110
	
l1799:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	106
	
l1801:	
	decf	(_i),f
	
l1803:	
	incf	(_i),w
	skipz
	goto	u1681
	goto	u1680
u1681:
	goto	l1793
u1680:
	line	112
	
l1805:	
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
;;		line 95 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	95
	global	__size_of_cmd
	__size_of_cmd	equ	__end_of_cmd-_cmd
	
_cmd:	
	opt	stack 5
; Regs used in _cmd: [wreg]
	bcf	status, 5	;RP0=0, select bank0
	movwf	(cmd@cmd_msg)
	line	96
	
l1777:	
	movf	(cmd@cmd_msg),w
	movwf	(6)	;volatile
	line	97
	
l1779:	
	bcf	(44/8),(44)&7
	line	98
	
l1781:	
	bsf	(43/8),(43)&7
	line	99
	
l1783:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	100
	
l1785:	
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
;;		line 77 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	77
	global	__size_of_disp_string
	__size_of_disp_string	equ	__end_of_disp_string-_disp_string
	
_disp_string:	
	opt	stack 5
; Regs used in _disp_string: [wreg-fsr0h+status,2+status,0+pclath]
	movwf	(disp_string@c)
	line	78
	
l1753:	
	bsf	(44/8),(44)&7
	line	79
	
l1755:	
	movf	(disp_string@c),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u1661
	goto	u1660
u1661:
	goto	l1775
u1660:
	line	80
	
l1757:	
	movf	(_temp),w
	movwf	(6)	;volatile
	line	81
	
l1759:	
	bsf	(43/8),(43)&7
	line	82
	
l1761:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	83
	
l1763:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	84
	goto	l210
	line	87
	
l1765:	
	movf	(disp_string@c),w
	movwf	fsr0
	fcall	stringdir
	movwf	(6)	;volatile
	line	88
	
l1767:	
	bsf	(43/8),(43)&7
	line	89
	
l1769:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	90
	
l1771:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	86
	
l1773:	
	incf	(disp_string@c),f
	
l1775:	
	movf	(disp_string@c),w
	movwf	fsr0
	fcall	stringdir
	iorlw	0
	skipz
	goto	u1671
	goto	u1670
u1671:
	goto	l1765
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
;;		line 215 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	215
	global	__size_of_set_floor
	__size_of_set_floor	equ	__end_of_set_floor-_set_floor
	
_set_floor:	
	opt	stack 3
; Regs used in _set_floor: [wreg-fsr0h+status,2+status,0]
	line	216
	
l1707:	
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
	goto	l291
u1510:
	
l1709:	
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
	goto	l291
u1520:
	line	217
	
l1711:	
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
	line	218
	
l1713:	
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movlw	(03h)
	movwf	indf
	
l279:	
	line	219
	movf	(_floor_index),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	(_floor_direction),w
	addwf	indf,f
	line	220
	
l1715:	
	btfss	(_prob_move/8),(_prob_move)&7
	goto	u1541
	goto	u1540
u1541:
	goto	l280
u1540:
	line	221
	
l1717:	
	movf	(_floor_index),w
	movwf	(_destination_floor)
	line	222
	
l1719:	
	bcf	(_prob_move/8),(_prob_move)&7
	line	223
	
l280:	
	line	224
	incf	(_destination_floor),w
	skipnz
	goto	u1551
	goto	u1550
u1551:
	goto	l291
u1550:
	line	226
	
l1721:	
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
	goto	l1731
u1560:
	
l1723:	
	movf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorwf	(_floor_direction),w
	skipnz
	goto	u1571
	goto	u1570
u1571:
	goto	l1729
u1570:
	
l1725:	
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
	goto	l1729
u1580:
	
l1727:	
	movf	(_floor_index),w
	xorlw	03h
	skipz
	goto	u1591
	goto	u1590
u1591:
	goto	l1731
u1590:
	
l1729:	
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
	goto	l1741
u1600:
	
l1731:	
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
	goto	l291
u1610:
	
l1733:	
	movf	(_destination_floor),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf,w
	xorwf	(_floor_direction),w
	skipnz
	goto	u1621
	goto	u1620
u1621:
	goto	l1739
u1620:
	
l1735:	
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
	goto	l1739
u1630:
	
l1737:	
	movf	(_floor_index),f
	skipz
	goto	u1641
	goto	u1640
u1641:
	goto	l291
u1640:
	
l1739:	
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
	goto	l291
u1650:
	line	227
	
l1741:	
	movf	(_floor_index),w
	movwf	(_destination_floor)
	line	230
	
l291:	
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
;;		line 208 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	208
	global	__size_of_call_min
	__size_of_call_min	equ	__end_of_call_min-_call_min
	
_call_min:	
	opt	stack 4
; Regs used in _call_min: [wreg-fsr0h+status,2+status,0]
	line	209
	
l1691:	
	movlw	(03h)
	movwf	(_i)
	
l1693:	
	btfss	(_i),7
	goto	u1481
	goto	u1480
u1481:
	goto	l1697
u1480:
	goto	l275
	line	210
	
l1697:	
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,f
	skipz
	goto	u1491
	goto	u1490
u1491:
	goto	l1701
u1490:
	
l1699:	
	movf	(_i),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf
	skipnz
	goto	u1501
	goto	u1500
u1501:
	goto	l1703
u1500:
	line	211
	
l1701:	
	movf	(_i),w
	movwf	(_destination_floor)
	line	209
	
l1703:	
	decf	(_i),f
	goto	l1693
	line	213
	
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
;;		line 199 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	199
	global	__size_of_call_max
	__size_of_call_max	equ	__end_of_call_max-_call_max
	
_call_max:	
	opt	stack 4
; Regs used in _call_max: [wreg-fsr0h+status,2+status,0]
	line	200
	
l1675:	
	movlw	(03h)
	movwf	(_i)
	
l1677:	
	btfss	(_i),7
	goto	u1451
	goto	u1450
u1451:
	goto	l1681
u1450:
	goto	l267
	line	201
	
l1681:	
	movf	(_i),w
	addlw	_cabin_call&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,f
	skipz
	goto	u1461
	goto	u1460
u1461:
	goto	l1685
u1460:
	
l1683:	
	movf	(_i),w
	addlw	_floor_call&0ffh
	movwf	fsr0
	movf	indf
	skipnz
	goto	u1471
	goto	u1470
u1471:
	goto	l1687
u1470:
	line	202
	
l1685:	
	movf	(_i),w
	movwf	(_destination_floor)
	line	203
	goto	l267
	line	200
	
l1687:	
	decf	(_i),f
	goto	l1677
	line	206
	
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
;;		line 186 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	186
	global	__size_of_max_prob_floor
	__size_of_max_prob_floor	equ	__end_of_max_prob_floor-_max_prob_floor
	
_max_prob_floor:	
	opt	stack 5
; Regs used in _max_prob_floor: [wreg-fsr0h+status,2+status,0]
	line	187
	
l1657:	
	bsf	(_prob_move/8),(_prob_move)&7
	line	188
	
l1659:	
	movlw	(03h)
	movwf	(_destination_floor)
	line	189
	movlw	(02h)
	movwf	(_i)
	incf	(_i),w
	skipz
	goto	u1401
	goto	u1400
u1401:
	goto	l1663
u1400:
	goto	l1671
	line	190
	
l1663:	
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
	goto	l1667
u1410:
	line	191
	
l1665:	
	movf	(_i),w
	movwf	(_destination_floor)
	line	189
	
l1667:	
	decf	(_i),f
	
l1669:	
	incf	(_i),w
	skipz
	goto	u1421
	goto	u1420
u1421:
	goto	l1663
u1420:
	line	193
	
l1671:	
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
	
l1673:	
	movf	(_current_floor),w
	xorwf	(_destination_floor),w
	skipz
	goto	u1441
	goto	u1440
u1441:
	goto	l259
u1440:
	
l258:	
	line	194
	clrf	(_destination_floor)
	decf	(_destination_floor),f
	line	195
	bcf	(_prob_move/8),(_prob_move)&7
	line	197
	
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
;;		line 145 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	145
	global	__size_of_button_press
	__size_of_button_press	equ	__end_of_button_press-_button_press
	
_button_press:	
	opt	stack 3
; Regs used in _button_press: [wreg+status,2+status,0]
	line	146
	
l1583:	
	clrf	(_button)
	decf	(_button),f
	line	147
	clrf	(_floor_index)
	decf	(_floor_index),f
	line	148
	clrf	(_floor_direction)
	decf	(_floor_direction),f
	line	150
	btfsc	(40/8),(40)&7
	goto	u1131
	goto	u1130
u1131:
	goto	l230
u1130:
	
l1585:	
	btfsc	(41/8),(41)&7
	goto	u1141
	goto	u1140
u1141:
	goto	l230
u1140:
	
l1587:	
	btfsc	(42/8),(42)&7
	goto	u1151
	goto	u1150
u1151:
	goto	l230
u1150:
	line	151
	
l1589:	
	clrf	(_button)
	incf	(_button),f
	goto	l231
	line	152
	
l230:	
	btfss	(40/8),(40)&7
	goto	u1161
	goto	u1160
u1161:
	goto	l232
u1160:
	
l1591:	
	btfsc	(41/8),(41)&7
	goto	u1171
	goto	u1170
u1171:
	goto	l232
u1170:
	
l1593:	
	btfsc	(42/8),(42)&7
	goto	u1181
	goto	u1180
u1181:
	goto	l232
u1180:
	line	153
	
l1595:	
	movlw	(02h)
	movwf	(_button)
	goto	l231
	line	154
	
l232:	
	btfsc	(40/8),(40)&7
	goto	u1191
	goto	u1190
u1191:
	goto	l234
u1190:
	
l1597:	
	btfss	(41/8),(41)&7
	goto	u1201
	goto	u1200
u1201:
	goto	l234
u1200:
	
l1599:	
	btfsc	(42/8),(42)&7
	goto	u1211
	goto	u1210
u1211:
	goto	l234
u1210:
	line	155
	
l1601:	
	movlw	(03h)
	movwf	(_button)
	goto	l231
	line	156
	
l234:	
	btfss	(40/8),(40)&7
	goto	u1221
	goto	u1220
u1221:
	goto	l236
u1220:
	
l1603:	
	btfss	(41/8),(41)&7
	goto	u1231
	goto	u1230
u1231:
	goto	l236
u1230:
	
l1605:	
	btfsc	(42/8),(42)&7
	goto	u1241
	goto	u1240
u1241:
	goto	l236
u1240:
	line	157
	
l1607:	
	movlw	(04h)
	movwf	(_button)
	goto	l231
	line	158
	
l236:	
	btfsc	(40/8),(40)&7
	goto	u1251
	goto	u1250
u1251:
	goto	l238
u1250:
	
l1609:	
	btfsc	(41/8),(41)&7
	goto	u1261
	goto	u1260
u1261:
	goto	l238
u1260:
	
l1611:	
	btfss	(42/8),(42)&7
	goto	u1271
	goto	u1270
u1271:
	goto	l238
u1270:
	line	159
	
l1613:	
	movlw	(05h)
	movwf	(_button)
	goto	l231
	line	160
	
l238:	
	btfss	(40/8),(40)&7
	goto	u1281
	goto	u1280
u1281:
	goto	l240
u1280:
	
l1615:	
	btfsc	(41/8),(41)&7
	goto	u1291
	goto	u1290
u1291:
	goto	l240
u1290:
	
l1617:	
	btfss	(42/8),(42)&7
	goto	u1301
	goto	u1300
u1301:
	goto	l240
u1300:
	line	161
	
l1619:	
	movlw	(06h)
	movwf	(_button)
	goto	l231
	line	162
	
l240:	
	btfsc	(40/8),(40)&7
	goto	u1311
	goto	u1310
u1311:
	goto	l237
u1310:
	
l1621:	
	btfss	(41/8),(41)&7
	goto	u1321
	goto	u1320
u1321:
	goto	l237
u1320:
	
l1623:	
	btfss	(42/8),(42)&7
	goto	u1331
	goto	u1330
u1331:
	goto	l237
u1330:
	line	163
	
l1625:	
	movlw	(07h)
	movwf	(_button)
	goto	l231
	line	165
	
l237:	
	
l231:	
	incf	(_button),w
	skipnz
	goto	u1341
	goto	u1340
u1341:
	goto	l250
u1340:
	line	166
	
l1627:	
	decf	(_button),w
	skipz
	goto	u1351
	goto	u1350
u1351:
	goto	l1633
u1350:
	line	167
	
l1629:	
	clrf	(_floor_index)
	line	168
	
l1631:	
	clrf	(_floor_direction)
	incf	(_floor_direction),f
	line	170
	
l1633:	
	movlw	(05h)
	movwf	(_i)
	
l1635:	
	decf	(_i),w
	skipz
	goto	u1361
	goto	u1360
u1361:
	goto	l1639
u1360:
	goto	l1653
	line	171
	
l1639:	
	movf	(_button),w
	xorwf	(_i),w
	skipz
	goto	u1371
	goto	u1370
u1371:
	goto	l1649
u1370:
	line	172
	
l1641:	
	rlf	(_i),w
	rrf	(_i),w
	movwf	(_floor_index)
	line	173
	
l1643:	
	clrf	(_floor_direction)
	incf	(_floor_direction),f
	line	174
	
l1645:	
	btfss	(_i),(0)&7
	goto	u1381
	goto	u1380
u1381:
	goto	l1653
u1380:
	line	175
	
l1647:	
	movlw	(02h)
	movwf	(_floor_direction)
	goto	l1653
	line	170
	
l1649:	
	decf	(_i),f
	goto	l1635
	line	179
	
l1653:	
	movf	(_button),w
	xorlw	06h
	skipz
	goto	u1391
	goto	u1390
u1391:
	goto	l250
u1390:
	line	180
	
l1655:	
	movlw	(03h)
	movwf	(_floor_index)
	line	181
	movlw	(02h)
	movwf	(_floor_direction)
	line	184
	
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
;;		line 116 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	116
	global	__size_of_initialize
	__size_of_initialize	equ	__end_of_initialize-_initialize
	
_initialize:	
	opt	stack 5
; Regs used in _initialize: [wreg+status,2]
	line	118
	
l1551:	
	clrf	(5)	;volatile
	line	119
	clrf	(6)	;volatile
	line	120
	bsf	status, 5	;RP0=1, select bank1
	clrf	(134)^080h	;volatile
	line	121
	
l1553:	
	movlw	(07h)
	movwf	(133)^080h	;volatile
	line	124
	
l1555:	
	bcf	status, 5	;RP0=0, select bank0
	clrf	(1)	;volatile
	line	125
	movlw	(08h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(129)^080h	;volatile
	line	126
	
l1557:	
	bsf	(93/8),(93)&7
	line	127
	
l1559:	
	bsf	(95/8),(95)&7
	line	128
	
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
;;		line 130 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	130
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
	line	131
	
i1l1561:	
	movlw	-1
	addwf	(_counter2),f
	skipc
	decf	(_counter2+1),f
	line	132
	
i1l1563:	
	movf	((_counter2+1)),w
	iorwf	((_counter2)),w
	skipz
	goto	u111_21
	goto	u111_20
u111_21:
	goto	i1l1579
u111_20:
	line	133
	
i1l1565:	
	movlw	low(0BB8h)
	movwf	(_counter2)
	movlw	high(0BB8h)
	movwf	((_counter2))+1
	line	134
	
i1l1567:	
	incf	(_hour),f
	line	135
	
i1l1569:	
	movf	(_hour),w
	xorlw	03h
	skipz
	goto	u112_21
	goto	u112_20
u112_21:
	goto	i1l1573
u112_20:
	line	136
	
i1l1571:	
	clrf	(_hour)
	line	137
	
i1l1573:	
	movlw	(0Ah)
	fcall	i1_cmd
	line	138
	
i1l1575:	
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

	line	139
	
i1l1577:	
	movlw	(0Eh)
	fcall	i1_cmd
	line	141
	
i1l1579:	
	bcf	(90/8),(90)&7
	line	142
	
i1l1581:	
	bsf	(95/8),(95)&7
	line	143
	
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
;;		line 95 in file "LEDcode.c"
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
	file	"LEDcode.c"
	line	95
	global	__size_ofi1_cmd
	__size_ofi1_cmd	equ	__end_ofi1_cmd-i1_cmd
	
i1_cmd:	
	opt	stack 2
; Regs used in i1_cmd: [wreg]
	bcf	status, 5	;RP0=0, select bank0
	movwf	(i1cmd@cmd_msg)
	line	96
	
i1l1743:	
	movf	(i1cmd@cmd_msg),w
	movwf	(6)	;volatile
	line	97
	
i1l1745:	
	bcf	(44/8),(44)&7
	line	98
	
i1l1747:	
	bsf	(43/8),(43)&7
	line	99
	
i1l1749:	
		opt asmopt_off
	clrwdt
	opt asmopt_on

	line	100
	
i1l1751:	
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
