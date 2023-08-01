 signed char left , right , count =0,count2=0 ,i,west_color ,south_color ,count_saver ,state ,west_red,south_red;
 void color_west(char c){
 switch(c) {
   case 0:portc.B4=0; portc.B5=0;portc.B6=0;
   break;
   case 1: portc.B4=1; portc.B5=0;portc.B6=0,west_red=1,south_red=0;
   break;
   case 2: portc.B5=1;portc.B4=0;portc.B4=0;
   break;
   case 3 : portc.B6=1; portc.B4=0;portc.B5=0;
   break;
 }
 }
 void color_south(char c){
 switch(c) {
   case 0:portd.B4=0; portd.B5=0;portd.B6=0;
   break;
   case 1: portd.B4=1; portd.B5=0; portd.B6=0,west_red=0,south_red=1;
   break;
   case 2: portd.B5=1;portd.B4=0;portd.B6=0;
   break;
   case 3 : portd.B6=1; portd.B4=0;portd.B5=0;
   break;
 }
 }
 void traffic(unsigned char count,char c1,char c2){

 left=count/10;
 right=count%10;
 porta.B2=0;
 porta.B3=1;
 portc =right ;
 color_west(c1);
 color_south(c2);
 delay_ms(10);
 porta.B2=1;
 porta.B3=0;
 portc=left;
 color_west(c1);
 color_south(c2);
 delay_ms(10);

 }
char counter_flag=0;
char flag=0;
void interrupt(){
 if(INTF_BIT==1){
  INTF_BIT=0;
  counter_flag++;
  flag=1;
  if (counter_flag==4) counter_flag=0;
  
  }
 }
void main() {
  adcon1=7;
  trisa=0;
  porta=0;
  trisb=1;
  NOT_RBPU_bit=0;
  GIE_bit=1;
  INTE_bit=1;
  INTEDG_bit=0;
  trisc=0;
  portc=0;
  trisd=0;
  portd=0;
  while (1){
  
  //Automatic
  if(portb.b3){
 for( count=15 ; count>0 ; count--){
  if (portb.b3==0)  break;
  if(flag){
    if(south_red)break;
    flag=0;
  }
     for(i=0;i<30;i++){
     if (count>3){traffic( count,1,3); south_color=3; }
        else {traffic( count,1,2);south_color=2; count_saver=count;}}
    }

  for( count=23; count>0; count--){
      if (portb.b3==0)  break;
      if(flag){
       if(west_red)break;
       flag=0;
      }
      for(i=0;i<30;i++){
      if(count>3) {traffic(count,3,1);west_color=3;}
      else {traffic( count,2,1);west_color=2;count_saver=count;}}
   }

  }
   // Manual
  if(!portb.B3){
  // state 1
     if (south_color==3){
     if(counter_flag==0){
      for(i=0;i<100;i++){
       traffic(0,1,3);}}
       //____________________________________
     else if (counter_flag==1){
     for(count=3;count>0;count--){
     if(portb.B3==1){break;}
       for(i=0;i<100;i++){
      traffic(count,1,2);}
       } counter_flag=2;}
      //_______________________________________
     else if (counter_flag==2){
      for(i=0;i<100;i++){
      traffic(0,3,1);
      }}
      //_______________________________________
      else if (counter_flag==3){
     for(count=3;count>0;count--){
    if(portb.B3==1){ traffic(0,0,0); break;}
      for(i=0;i<100;i++){
    traffic( count,2,1); }

      }
      counter_flag=0;
    }}

     // state 2
     else if (west_color==3){
     if(counter_flag==0){
      for(i=0;i<100;i++){
       traffic(0,3,1);}}
       //____________________________________
     else if (counter_flag==1){
     for(count=3;count>0;count--){
     if(portb.B3==1){break;}
       for(i=0;i<100;i++){
      traffic(count,2,1);}
       } counter_flag=2;}
      //_______________________________________
     else if (counter_flag==2){
      for(i=0;i<100;i++){
      traffic(0,1,3);
      }}
      //_______________________________________
      else if (counter_flag==3){
     for(count=3;count>0;count--){
    if(portb.B3==1){ traffic(0,0,0); break;}
      for(i=0;i<100;i++){
    traffic( count,3,2); }

      }
      counter_flag=0;
    }}
     
     // state 3
     else if (west_color==2){
     if(counter_flag==0){
     for(count=count_saver;count>0;count--){
      if(portb.B3==1){break;}
      for(i=0;i<100;i++){
       traffic(count,2,1);}} count_saver=3;counter_flag=1;}
       //____________________________________
     else if (counter_flag==1){
      for(i=0;i<100;i++){
      traffic(0,1,3);}}
      //_______________________________________
     else if (counter_flag==2){
      for(count=3;count>0;count--){
    if(portb.B3==1){break;}
      for(i=0;i<100;i++){
    traffic( count,1,2); }}counter_flag=3;}
      //_______________________________________
      else if (counter_flag==3){
      for(i=0;i<100;i++){
    traffic( 0,3,1); }}
      }

     // state 4
     else if (south_color==2){
     if(counter_flag==0){
     for(count=count_saver;count>0;count--){
      if(portb.B3==1){break;}
      for(i=0;i<100;i++){
       traffic(count,1,2);}} count_saver=3; counter_flag=1;}
       //____________________________________
     else if (counter_flag==1){
      for(i=0;i<100;i++){
      traffic(0,3,1);}}
      //_______________________________________
     else if (counter_flag==2){
      for(count=3;count>0;count--){
    if(portb.B3==1){break;}
      for(i=0;i<100;i++){
    traffic( count,2,1); }}counter_flag=3;}
      //_______________________________________
      else if (counter_flag==3){
      for(i=0;i<100;i++){
    traffic( 0,1,3); }}
      }

     // defult state
     if (west_color==0){
      if (counter_flag==0){
      for(i=0;i<100;i++){
       traffic(0,1,3);
    }}
     else if (counter_flag==1){
     for(count=3;count>0;count--){
     if(portb.B3==1){ traffic(0,0,0); break;}
       for(i=0;i<100;i++){
      traffic(count,1,2);}
       } counter_flag=2;}

     else if (counter_flag==2){
      for(i=0;i<100;i++){
      traffic(0,3,1);
      }}

   else  if(counter_flag==3){
    for(count=3;count>0;count--){
    if(portb.B3==1){ traffic(0,0,0); break;}
      for(i=0;i<100;i++){
    traffic( count,2,1); }

      }
      counter_flag=0;
    }
     }
     
     
}}

}