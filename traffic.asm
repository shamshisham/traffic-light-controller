
_color_west:

;traffic.c,2 :: 		void color_west(char c){
;traffic.c,3 :: 		switch(c) {
	GOTO       L_color_west0
;traffic.c,4 :: 		case 0:portc.B4=0; portc.B5=0;portc.B6=0;
L_color_west2:
	BCF        PORTC+0, 4
	BCF        PORTC+0, 5
	BCF        PORTC+0, 6
;traffic.c,5 :: 		break;
	GOTO       L_color_west1
;traffic.c,6 :: 		case 1: portc.B4=1; portc.B5=0;portc.B6=0,west_red=1,south_red=0;
L_color_west3:
	BSF        PORTC+0, 4
	BCF        PORTC+0, 5
	BCF        PORTC+0, 6
	MOVLW      1
	MOVWF      _west_red+0
	CLRF       _south_red+0
;traffic.c,7 :: 		break;
	GOTO       L_color_west1
;traffic.c,8 :: 		case 2: portc.B5=1;portc.B4=0;portc.B4=0;
L_color_west4:
	BSF        PORTC+0, 5
	BCF        PORTC+0, 4
	BCF        PORTC+0, 4
;traffic.c,9 :: 		break;
	GOTO       L_color_west1
;traffic.c,10 :: 		case 3 : portc.B6=1; portc.B4=0;portc.B5=0;
L_color_west5:
	BSF        PORTC+0, 6
	BCF        PORTC+0, 4
	BCF        PORTC+0, 5
;traffic.c,11 :: 		break;
	GOTO       L_color_west1
;traffic.c,12 :: 		}
L_color_west0:
	MOVF       FARG_color_west_c+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_color_west2
	MOVF       FARG_color_west_c+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_color_west3
	MOVF       FARG_color_west_c+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_color_west4
	MOVF       FARG_color_west_c+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_color_west5
L_color_west1:
;traffic.c,13 :: 		}
L_end_color_west:
	RETURN
; end of _color_west

_color_south:

;traffic.c,14 :: 		void color_south(char c){
;traffic.c,15 :: 		switch(c) {
	GOTO       L_color_south6
;traffic.c,16 :: 		case 0:portd.B4=0; portd.B5=0;portd.B6=0;
L_color_south8:
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
	BCF        PORTD+0, 6
;traffic.c,17 :: 		break;
	GOTO       L_color_south7
;traffic.c,18 :: 		case 1: portd.B4=1; portd.B5=0; portd.B6=0,west_red=0,south_red=1;
L_color_south9:
	BSF        PORTD+0, 4
	BCF        PORTD+0, 5
	BCF        PORTD+0, 6
	CLRF       _west_red+0
	MOVLW      1
	MOVWF      _south_red+0
;traffic.c,19 :: 		break;
	GOTO       L_color_south7
;traffic.c,20 :: 		case 2: portd.B5=1;portd.B4=0;portd.B6=0;
L_color_south10:
	BSF        PORTD+0, 5
	BCF        PORTD+0, 4
	BCF        PORTD+0, 6
;traffic.c,21 :: 		break;
	GOTO       L_color_south7
;traffic.c,22 :: 		case 3 : portd.B6=1; portd.B4=0;portd.B5=0;
L_color_south11:
	BSF        PORTD+0, 6
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;traffic.c,23 :: 		break;
	GOTO       L_color_south7
;traffic.c,24 :: 		}
L_color_south6:
	MOVF       FARG_color_south_c+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_color_south8
	MOVF       FARG_color_south_c+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_color_south9
	MOVF       FARG_color_south_c+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_color_south10
	MOVF       FARG_color_south_c+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_color_south11
L_color_south7:
;traffic.c,25 :: 		}
L_end_color_south:
	RETURN
; end of _color_south

_traffic:

;traffic.c,26 :: 		void traffic(unsigned char count,char c1,char c2){
;traffic.c,28 :: 		left=count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_traffic_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _left+0
;traffic.c,29 :: 		right=count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_traffic_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;traffic.c,30 :: 		porta.B2=0;
	BCF        PORTA+0, 2
;traffic.c,31 :: 		porta.B3=1;
	BSF        PORTA+0, 3
;traffic.c,32 :: 		portc =right ;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;traffic.c,33 :: 		color_west(c1);
	MOVF       FARG_traffic_c1+0, 0
	MOVWF      FARG_color_west_c+0
	CALL       _color_west+0
;traffic.c,34 :: 		color_south(c2);
	MOVF       FARG_traffic_c2+0, 0
	MOVWF      FARG_color_south_c+0
	CALL       _color_south+0
;traffic.c,35 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_traffic12:
	DECFSZ     R13+0, 1
	GOTO       L_traffic12
	DECFSZ     R12+0, 1
	GOTO       L_traffic12
	NOP
;traffic.c,36 :: 		porta.B2=1;
	BSF        PORTA+0, 2
;traffic.c,37 :: 		porta.B3=0;
	BCF        PORTA+0, 3
;traffic.c,38 :: 		portc=left;
	MOVF       _left+0, 0
	MOVWF      PORTC+0
;traffic.c,39 :: 		color_west(c1);
	MOVF       FARG_traffic_c1+0, 0
	MOVWF      FARG_color_west_c+0
	CALL       _color_west+0
;traffic.c,40 :: 		color_south(c2);
	MOVF       FARG_traffic_c2+0, 0
	MOVWF      FARG_color_south_c+0
	CALL       _color_south+0
;traffic.c,41 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_traffic13:
	DECFSZ     R13+0, 1
	GOTO       L_traffic13
	DECFSZ     R12+0, 1
	GOTO       L_traffic13
	NOP
;traffic.c,43 :: 		}
L_end_traffic:
	RETURN
; end of _traffic

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;traffic.c,46 :: 		void interrupt(){
;traffic.c,47 :: 		if(INTF_BIT==1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt14
;traffic.c,48 :: 		INTF_BIT=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;traffic.c,49 :: 		counter_flag++;
	INCF       _counter_flag+0, 1
;traffic.c,50 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
;traffic.c,51 :: 		if (counter_flag==4) counter_flag=0;
	MOVF       _counter_flag+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt15
	CLRF       _counter_flag+0
L_interrupt15:
;traffic.c,53 :: 		}
L_interrupt14:
;traffic.c,54 :: 		}
L_end_interrupt:
L__interrupt189:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;traffic.c,55 :: 		void main() {
;traffic.c,56 :: 		adcon1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;traffic.c,57 :: 		trisa=0;
	CLRF       TRISA+0
;traffic.c,58 :: 		porta=0;
	CLRF       PORTA+0
;traffic.c,59 :: 		trisb=1;
	MOVLW      1
	MOVWF      TRISB+0
;traffic.c,60 :: 		NOT_RBPU_bit=0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;traffic.c,61 :: 		GIE_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;traffic.c,62 :: 		INTE_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;traffic.c,63 :: 		INTEDG_bit=0;
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;traffic.c,64 :: 		trisc=0;
	CLRF       TRISC+0
;traffic.c,65 :: 		portc=0;
	CLRF       PORTC+0
;traffic.c,66 :: 		trisd=0;
	CLRF       TRISD+0
;traffic.c,67 :: 		portd=0;
	CLRF       PORTD+0
;traffic.c,68 :: 		while (1){
L_main16:
;traffic.c,71 :: 		if(portb.b3){
	BTFSS      PORTB+0, 3
	GOTO       L_main18
;traffic.c,72 :: 		for( count=15 ; count>0 ; count--){
	MOVLW      15
	MOVWF      _count+0
L_main19:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main20
;traffic.c,73 :: 		if (portb.b3==0)  break;
	BTFSC      PORTB+0, 3
	GOTO       L_main22
	GOTO       L_main20
L_main22:
;traffic.c,74 :: 		if(flag){
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
;traffic.c,75 :: 		if(south_red)break;
	MOVF       _south_red+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	GOTO       L_main20
L_main24:
;traffic.c,76 :: 		flag=0;
	CLRF       _flag+0
;traffic.c,77 :: 		}
L_main23:
;traffic.c,78 :: 		for(i=0;i<30;i++){
	CLRF       _i+0
L_main25:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;traffic.c,79 :: 		if (count>3){traffic( count,1,3); south_color=3; }
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main28
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      3
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
	MOVLW      3
	MOVWF      _south_color+0
	GOTO       L_main29
L_main28:
;traffic.c,80 :: 		else {traffic( count,1,2);south_color=2; count_saver=count;}}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      2
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
	MOVLW      2
	MOVWF      _south_color+0
	MOVF       _count+0, 0
	MOVWF      _count_saver+0
L_main29:
;traffic.c,78 :: 		for(i=0;i<30;i++){
	INCF       _i+0, 1
;traffic.c,80 :: 		else {traffic( count,1,2);south_color=2; count_saver=count;}}
	GOTO       L_main25
L_main26:
;traffic.c,72 :: 		for( count=15 ; count>0 ; count--){
	DECF       _count+0, 1
;traffic.c,81 :: 		}
	GOTO       L_main19
L_main20:
;traffic.c,83 :: 		for( count=23; count>0; count--){
	MOVLW      23
	MOVWF      _count+0
L_main30:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main31
;traffic.c,84 :: 		if (portb.b3==0)  break;
	BTFSC      PORTB+0, 3
	GOTO       L_main33
	GOTO       L_main31
L_main33:
;traffic.c,85 :: 		if(flag){
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main34
;traffic.c,86 :: 		if(west_red)break;
	MOVF       _west_red+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	GOTO       L_main31
L_main35:
;traffic.c,87 :: 		flag=0;
	CLRF       _flag+0
;traffic.c,88 :: 		}
L_main34:
;traffic.c,89 :: 		for(i=0;i<30;i++){
	CLRF       _i+0
L_main36:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;traffic.c,90 :: 		if(count>3) {traffic(count,3,1);west_color=3;}
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main39
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
	MOVLW      3
	MOVWF      _west_color+0
	GOTO       L_main40
L_main39:
;traffic.c,91 :: 		else {traffic( count,2,1);west_color=2;count_saver=count;}}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      2
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
	MOVLW      2
	MOVWF      _west_color+0
	MOVF       _count+0, 0
	MOVWF      _count_saver+0
L_main40:
;traffic.c,89 :: 		for(i=0;i<30;i++){
	INCF       _i+0, 1
;traffic.c,91 :: 		else {traffic( count,2,1);west_color=2;count_saver=count;}}
	GOTO       L_main36
L_main37:
;traffic.c,83 :: 		for( count=23; count>0; count--){
	DECF       _count+0, 1
;traffic.c,92 :: 		}
	GOTO       L_main30
L_main31:
;traffic.c,94 :: 		}
L_main18:
;traffic.c,96 :: 		if(!portb.B3){
	BTFSC      PORTB+0, 3
	GOTO       L_main41
;traffic.c,98 :: 		if (south_color==3){
	MOVF       _south_color+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main42
;traffic.c,99 :: 		if(counter_flag==0){
	MOVF       _counter_flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main43
;traffic.c,100 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main44:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main45
;traffic.c,101 :: 		traffic(0,1,3);}}
	CLRF       FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      3
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,100 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,101 :: 		traffic(0,1,3);}}
	GOTO       L_main44
L_main45:
	GOTO       L_main47
L_main43:
;traffic.c,103 :: 		else if (counter_flag==1){
	MOVF       _counter_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main48
;traffic.c,104 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main49:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main50
;traffic.c,105 :: 		if(portb.B3==1){break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main52
	GOTO       L_main50
L_main52:
;traffic.c,106 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main53:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main54
;traffic.c,107 :: 		traffic(count,1,2);}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      2
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,106 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,107 :: 		traffic(count,1,2);}
	GOTO       L_main53
L_main54:
;traffic.c,104 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,108 :: 		} counter_flag=2;}
	GOTO       L_main49
L_main50:
	MOVLW      2
	MOVWF      _counter_flag+0
	GOTO       L_main56
L_main48:
;traffic.c,110 :: 		else if (counter_flag==2){
	MOVF       _counter_flag+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main57
;traffic.c,111 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main58:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main59
;traffic.c,112 :: 		traffic(0,3,1);
	CLRF       FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,111 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,113 :: 		}}
	GOTO       L_main58
L_main59:
	GOTO       L_main61
L_main57:
;traffic.c,115 :: 		else if (counter_flag==3){
	MOVF       _counter_flag+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main62
;traffic.c,116 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main63:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main64
;traffic.c,117 :: 		if(portb.B3==1){ traffic(0,0,0); break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main66
	CLRF       FARG_traffic_count+0
	CLRF       FARG_traffic_c1+0
	CLRF       FARG_traffic_c2+0
	CALL       _traffic+0
	GOTO       L_main64
L_main66:
;traffic.c,118 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main67:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main68
;traffic.c,119 :: 		traffic( count,2,1); }
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      2
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,118 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,119 :: 		traffic( count,2,1); }
	GOTO       L_main67
L_main68:
;traffic.c,116 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,121 :: 		}
	GOTO       L_main63
L_main64:
;traffic.c,122 :: 		counter_flag=0;
	CLRF       _counter_flag+0
;traffic.c,123 :: 		}}
L_main62:
L_main61:
L_main56:
L_main47:
	GOTO       L_main70
L_main42:
;traffic.c,126 :: 		else if (west_color==3){
	MOVF       _west_color+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main71
;traffic.c,127 :: 		if(counter_flag==0){
	MOVF       _counter_flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main72
;traffic.c,128 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main73:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main74
;traffic.c,129 :: 		traffic(0,3,1);}}
	CLRF       FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,128 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,129 :: 		traffic(0,3,1);}}
	GOTO       L_main73
L_main74:
	GOTO       L_main76
L_main72:
;traffic.c,131 :: 		else if (counter_flag==1){
	MOVF       _counter_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main77
;traffic.c,132 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main78:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main79
;traffic.c,133 :: 		if(portb.B3==1){break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main81
	GOTO       L_main79
L_main81:
;traffic.c,134 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main82:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main83
;traffic.c,135 :: 		traffic(count,2,1);}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      2
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,134 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,135 :: 		traffic(count,2,1);}
	GOTO       L_main82
L_main83:
;traffic.c,132 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,136 :: 		} counter_flag=2;}
	GOTO       L_main78
L_main79:
	MOVLW      2
	MOVWF      _counter_flag+0
	GOTO       L_main85
L_main77:
;traffic.c,138 :: 		else if (counter_flag==2){
	MOVF       _counter_flag+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main86
;traffic.c,139 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main87:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main88
;traffic.c,140 :: 		traffic(0,1,3);
	CLRF       FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      3
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,139 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,141 :: 		}}
	GOTO       L_main87
L_main88:
	GOTO       L_main90
L_main86:
;traffic.c,143 :: 		else if (counter_flag==3){
	MOVF       _counter_flag+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main91
;traffic.c,144 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main92:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main93
;traffic.c,145 :: 		if(portb.B3==1){ traffic(0,0,0); break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main95
	CLRF       FARG_traffic_count+0
	CLRF       FARG_traffic_c1+0
	CLRF       FARG_traffic_c2+0
	CALL       _traffic+0
	GOTO       L_main93
L_main95:
;traffic.c,146 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main96:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main97
;traffic.c,147 :: 		traffic( count,3,2); }
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      2
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,146 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,147 :: 		traffic( count,3,2); }
	GOTO       L_main96
L_main97:
;traffic.c,144 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,149 :: 		}
	GOTO       L_main92
L_main93:
;traffic.c,150 :: 		counter_flag=0;
	CLRF       _counter_flag+0
;traffic.c,151 :: 		}}
L_main91:
L_main90:
L_main85:
L_main76:
	GOTO       L_main99
L_main71:
;traffic.c,154 :: 		else if (west_color==2){
	MOVF       _west_color+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main100
;traffic.c,155 :: 		if(counter_flag==0){
	MOVF       _counter_flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main101
;traffic.c,156 :: 		for(count=count_saver;count>0;count--){
	MOVF       _count_saver+0, 0
	MOVWF      _count+0
L_main102:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main103
;traffic.c,157 :: 		if(portb.B3==1){break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main105
	GOTO       L_main103
L_main105:
;traffic.c,158 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main106:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main107
;traffic.c,159 :: 		traffic(count,2,1);}} count_saver=3;counter_flag=1;}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      2
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,158 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,159 :: 		traffic(count,2,1);}} count_saver=3;counter_flag=1;}
	GOTO       L_main106
L_main107:
;traffic.c,156 :: 		for(count=count_saver;count>0;count--){
	DECF       _count+0, 1
;traffic.c,159 :: 		traffic(count,2,1);}} count_saver=3;counter_flag=1;}
	GOTO       L_main102
L_main103:
	MOVLW      3
	MOVWF      _count_saver+0
	MOVLW      1
	MOVWF      _counter_flag+0
	GOTO       L_main109
L_main101:
;traffic.c,161 :: 		else if (counter_flag==1){
	MOVF       _counter_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main110
;traffic.c,162 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main111:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main112
;traffic.c,163 :: 		traffic(0,1,3);}}
	CLRF       FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      3
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,162 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,163 :: 		traffic(0,1,3);}}
	GOTO       L_main111
L_main112:
	GOTO       L_main114
L_main110:
;traffic.c,165 :: 		else if (counter_flag==2){
	MOVF       _counter_flag+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main115
;traffic.c,166 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main116:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main117
;traffic.c,167 :: 		if(portb.B3==1){break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main119
	GOTO       L_main117
L_main119:
;traffic.c,168 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main120:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main121
;traffic.c,169 :: 		traffic( count,1,2); }}counter_flag=3;}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      2
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,168 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,169 :: 		traffic( count,1,2); }}counter_flag=3;}
	GOTO       L_main120
L_main121:
;traffic.c,166 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,169 :: 		traffic( count,1,2); }}counter_flag=3;}
	GOTO       L_main116
L_main117:
	MOVLW      3
	MOVWF      _counter_flag+0
	GOTO       L_main123
L_main115:
;traffic.c,171 :: 		else if (counter_flag==3){
	MOVF       _counter_flag+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main124
;traffic.c,172 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main125:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main126
;traffic.c,173 :: 		traffic( 0,3,1); }}
	CLRF       FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,172 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,173 :: 		traffic( 0,3,1); }}
	GOTO       L_main125
L_main126:
L_main124:
L_main123:
L_main114:
L_main109:
;traffic.c,174 :: 		}
	GOTO       L_main128
L_main100:
;traffic.c,177 :: 		else if (south_color==2){
	MOVF       _south_color+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main129
;traffic.c,178 :: 		if(counter_flag==0){
	MOVF       _counter_flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main130
;traffic.c,179 :: 		for(count=count_saver;count>0;count--){
	MOVF       _count_saver+0, 0
	MOVWF      _count+0
L_main131:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main132
;traffic.c,180 :: 		if(portb.B3==1){break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main134
	GOTO       L_main132
L_main134:
;traffic.c,181 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main135:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main136
;traffic.c,182 :: 		traffic(count,1,2);}} count_saver=3; counter_flag=1;}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      2
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,181 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,182 :: 		traffic(count,1,2);}} count_saver=3; counter_flag=1;}
	GOTO       L_main135
L_main136:
;traffic.c,179 :: 		for(count=count_saver;count>0;count--){
	DECF       _count+0, 1
;traffic.c,182 :: 		traffic(count,1,2);}} count_saver=3; counter_flag=1;}
	GOTO       L_main131
L_main132:
	MOVLW      3
	MOVWF      _count_saver+0
	MOVLW      1
	MOVWF      _counter_flag+0
	GOTO       L_main138
L_main130:
;traffic.c,184 :: 		else if (counter_flag==1){
	MOVF       _counter_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main139
;traffic.c,185 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main140:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main141
;traffic.c,186 :: 		traffic(0,3,1);}}
	CLRF       FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,185 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,186 :: 		traffic(0,3,1);}}
	GOTO       L_main140
L_main141:
	GOTO       L_main143
L_main139:
;traffic.c,188 :: 		else if (counter_flag==2){
	MOVF       _counter_flag+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main144
;traffic.c,189 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main145:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main146
;traffic.c,190 :: 		if(portb.B3==1){break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main148
	GOTO       L_main146
L_main148:
;traffic.c,191 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main149:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main150
;traffic.c,192 :: 		traffic( count,2,1); }}counter_flag=3;}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      2
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,191 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,192 :: 		traffic( count,2,1); }}counter_flag=3;}
	GOTO       L_main149
L_main150:
;traffic.c,189 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,192 :: 		traffic( count,2,1); }}counter_flag=3;}
	GOTO       L_main145
L_main146:
	MOVLW      3
	MOVWF      _counter_flag+0
	GOTO       L_main152
L_main144:
;traffic.c,194 :: 		else if (counter_flag==3){
	MOVF       _counter_flag+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main153
;traffic.c,195 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main154:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main155
;traffic.c,196 :: 		traffic( 0,1,3); }}
	CLRF       FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      3
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,195 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,196 :: 		traffic( 0,1,3); }}
	GOTO       L_main154
L_main155:
L_main153:
L_main152:
L_main143:
L_main138:
;traffic.c,197 :: 		}
L_main129:
L_main128:
L_main99:
L_main70:
;traffic.c,200 :: 		if (west_color==0){
	MOVF       _west_color+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main157
;traffic.c,201 :: 		if (counter_flag==0){
	MOVF       _counter_flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main158
;traffic.c,202 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main159:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main160
;traffic.c,203 :: 		traffic(0,1,3);
	CLRF       FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      3
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,202 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,204 :: 		}}
	GOTO       L_main159
L_main160:
	GOTO       L_main162
L_main158:
;traffic.c,205 :: 		else if (counter_flag==1){
	MOVF       _counter_flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main163
;traffic.c,206 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main164:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main165
;traffic.c,207 :: 		if(portb.B3==1){ traffic(0,0,0); break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main167
	CLRF       FARG_traffic_count+0
	CLRF       FARG_traffic_c1+0
	CLRF       FARG_traffic_c2+0
	CALL       _traffic+0
	GOTO       L_main165
L_main167:
;traffic.c,208 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main168:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main169
;traffic.c,209 :: 		traffic(count,1,2);}
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      1
	MOVWF      FARG_traffic_c1+0
	MOVLW      2
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,208 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,209 :: 		traffic(count,1,2);}
	GOTO       L_main168
L_main169:
;traffic.c,206 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,210 :: 		} counter_flag=2;}
	GOTO       L_main164
L_main165:
	MOVLW      2
	MOVWF      _counter_flag+0
	GOTO       L_main171
L_main163:
;traffic.c,212 :: 		else if (counter_flag==2){
	MOVF       _counter_flag+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main172
;traffic.c,213 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main173:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main174
;traffic.c,214 :: 		traffic(0,3,1);
	CLRF       FARG_traffic_count+0
	MOVLW      3
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,213 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,215 :: 		}}
	GOTO       L_main173
L_main174:
	GOTO       L_main176
L_main172:
;traffic.c,217 :: 		else  if(counter_flag==3){
	MOVF       _counter_flag+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main177
;traffic.c,218 :: 		for(count=3;count>0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main178:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main179
;traffic.c,219 :: 		if(portb.B3==1){ traffic(0,0,0); break;}
	BTFSS      PORTB+0, 3
	GOTO       L_main181
	CLRF       FARG_traffic_count+0
	CLRF       FARG_traffic_c1+0
	CLRF       FARG_traffic_c2+0
	CALL       _traffic+0
	GOTO       L_main179
L_main181:
;traffic.c,220 :: 		for(i=0;i<100;i++){
	CLRF       _i+0
L_main182:
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      100
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main183
;traffic.c,221 :: 		traffic( count,2,1); }
	MOVF       _count+0, 0
	MOVWF      FARG_traffic_count+0
	MOVLW      2
	MOVWF      FARG_traffic_c1+0
	MOVLW      1
	MOVWF      FARG_traffic_c2+0
	CALL       _traffic+0
;traffic.c,220 :: 		for(i=0;i<100;i++){
	INCF       _i+0, 1
;traffic.c,221 :: 		traffic( count,2,1); }
	GOTO       L_main182
L_main183:
;traffic.c,218 :: 		for(count=3;count>0;count--){
	DECF       _count+0, 1
;traffic.c,223 :: 		}
	GOTO       L_main178
L_main179:
;traffic.c,224 :: 		counter_flag=0;
	CLRF       _counter_flag+0
;traffic.c,225 :: 		}
L_main177:
L_main176:
L_main171:
L_main162:
;traffic.c,226 :: 		}
L_main157:
;traffic.c,229 :: 		}}
L_main41:
	GOTO       L_main16
;traffic.c,231 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
