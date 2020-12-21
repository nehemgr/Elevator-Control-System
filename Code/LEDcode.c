#include <htc.h>
#include <stdlib.h>

__CONFIG(FOSC_HS & WDTE_OFF & PWRTE_ON & CP_OFF); // Config word

#define _XTAL_FREQ 20000000 // Define CPU Frequency

//Physical Parameters
#define num_floors 4
#define move_time 1000
#define max_people 5
#define num_hours 3
#define interrupt_time 3000

//LCD Pins
#define E RA3
#define RS RA4

//LCD Properties
#define line_size 24

//LCD Hex Codes
#define LCD_ON 0x0E
#define LCD_OFF 0x0A
#define clear_screen 0x01
#define cursor_left 0x10
#define cursor_right 0x14
#define cursor_forwards 0x06
#define cursor_backwards 0x04
#define line2 0xC0

//Switches Pressed
#define S1 (RA0 == 0 && RA1 == 0 && RA2 == 0)
#define S2 (RA0 == 1 && RA1 == 0 && RA2 == 0)
#define S3 (RA0 == 0 && RA1 == 1 && RA2 == 0)
#define S4 (RA0 == 1 && RA1 == 1 && RA2 == 0)
#define S5 (RA0 == 0 && RA1 == 0 && RA2 == 1)
#define S6 (RA0 == 1 && RA1 == 0 && RA2 == 1)
#define S7 (RA0 == 0 && RA1 == 1 && RA2 == 1)

//Switches Names
#define CONFIRM 7

void disp_string(const char* c);
void cmd(char cmd_msg);
void clr_char(char spaces);
void initialize();
void interrupt hour_ISR();
void button_press();
void max_prob_floor();
void call_max();
void call_min();
void set_floor();
void floor_details();
void moving();

const char people_msg[] = "People: ";
const char floor_msg[] = "Flrs: ";
const char stopped_msg[] = "Stop: Flr ";
const char moving_msg[] = "Move: Flr ";
const char reached_msg[] = "Reach: Flr ";

char temp;
signed char floor_call[num_floors] = {0};
signed char cabin_call[num_floors] = {0};
signed char current_floor;
signed char destination_floor;
signed char floor_index;
signed char floor_direction;
signed char button;
signed char i;
signed char hour;
signed int counter2;
bit prob_move;
signed char prob_matrix[num_floors][num_hours] = {{0}};

void disp_string(const char* c){
RS = 1;
if (*c == NULL){
    PORTB = temp;
    E = 1;
    __delay_us(0.35);
    E = 0;
    }
else {
    for (; *c != '\0'; c++){
        PORTB = *c;
        E = 1;
        __delay_us(0.35);
        E = 0;
        }
    }
}

void cmd(char cmd_msg){
PORTB = cmd_msg;
RS = 0;
E = 1;
__delay_us(0.35);
E = 0;
}

void clr_char(char spaces){
cmd(cursor_backwards);
RS = 1;
for (i = spaces; i != -1; i--){
    PORTB = ' ';
    E = 1;
    __delay_us(0.35);
    E = 0;
    }
cmd(cursor_forwards);
cmd(cursor_right);
}

void initialize(){
//MCU
PORTA = 0x00; //Initialize PORTA pins to 0
PORTB = 0x00; //Initialize PORTB pins to 0
TRISB = 0x00; //Set PORTB pins to output mode
TRISA = 0x07; // Set PORTA pins as: Set A0, A1 and A2 as input mode and Set A3 and A4 as output mode

//Timer
TMR0 = 0; //Clear timer overflow counter register
OPTION_REG = 0x08; //T0CS = 0 - Turn on the Timer0; PSA = 1 - Select WDT as clock; PS2, PS1, PS0 = 0 - For prescaler of 1:1
T0IE = 1; //Enable Timer 0 interrupts
GIE = 1; //Enable global interrupts bit
}

void interrupt hour_ISR(){
counter2--;
if (counter2 == 0){
    counter2 = interrupt_time;
    hour++;
    if (hour == num_hours)
        hour = 0;
    cmd(LCD_OFF);
    __delay_ms(2);
    cmd(LCD_ON);
    }
T0IF = 0;
GIE = 1;
}

void button_press(){
button = -1;
floor_index = -1;
floor_direction = -1;
if (S1)
    button = 1;
else if (S2)
    button = 2;
else if (S3)
    button = 3;
else if (S4)
    button = 4;
else if (S5)
    button = 5;
else if (S6)
    button = 6;
else if (S7)
    button = 7;
if (button != -1){
    if (button == 1){
        floor_index = 0;
        floor_direction = 1;
        }
    for (i = num_floors*2 - 3; i != 1; i--){
        if (button == i){
            floor_index = i >> 1; 
            floor_direction = 1;
            if (i % 2 != 0)
                floor_direction = 2;
            break;
            }
        }
    if (button == num_floors*2 - 2){
        floor_index = num_floors - 1;
        floor_direction = 2;
        }
    }
}

void max_prob_floor(){
prob_move = 1;
destination_floor = num_floors - 1;
for (i = num_floors - 2; i != -1; i--){
    if (prob_matrix[i][hour] > prob_matrix[destination_floor][hour])
        destination_floor = i;
    }
if ((prob_matrix[destination_floor][hour] == 0) || (current_floor == destination_floor)){
    destination_floor = -1;
    prob_move = 0;
    }
}

void call_max(){
for (i = num_floors - 1; i > -1; i--){
    if ((cabin_call[i] != 0) || (floor_call[i] != 0)){
        destination_floor = i;
        break;
        }
    }
}

void call_min(){
for (i = num_floors - 1; i > -1; i--){
    if ((cabin_call[i] != 0) || (floor_call[i] != 0))
        destination_floor = i;
    }
}

void set_floor(){
if ((floor_call[floor_index] != floor_direction) && (floor_call[floor_index] < 3)){
    if (floor_call[floor_index] == 2)
        floor_call[floor_index] = 3;
    floor_call[floor_index] += floor_direction;
    if (prob_move){
        destination_floor = floor_index;
        prob_move = 0;
        }
    if (destination_floor != -1){
        if (((current_floor < destination_floor) && ((floor_direction == floor_call[destination_floor]) || (floor_call[destination_floor] > 2) || (floor_index == num_floors - 1)) && (floor_index > destination_floor))
            || ((current_floor > destination_floor) && ((floor_direction == floor_call[destination_floor]) || (floor_call[destination_floor] > 2) || (floor_index == 0)) && (floor_index < destination_floor)))
            destination_floor = floor_index;
        }
    }
}

void floor_details(){
cmd(line2);
signed char j = 0;
temp = '0';
disp_string(&people_msg);
disp_string(NULL);
button_press();
while (button != CONFIRM){
    if (button != -1){
        if (floor_index == current_floor){
            if (button % 2 != 0 && button != 1){
                if (j == 0)
                    j = max_people + 1;
                j--;
                }
            else {
                if (j == max_people)
                    j = -1;
                j++;  
                }
            clr_char(1);
            temp = j + '0';
            disp_string(NULL);
            }
        else 
            set_floor();
        }
    button_press();
    }
prob_matrix[current_floor][hour] += j;
clr_char(9); //strlen("People: 0")
j = 0;
if (current_floor == 0)
    j = 1;
temp = j + '0';
disp_string(&floor_msg);
disp_string(NULL);
while (1){
    button_press();
    if (button != -1){
        if (floor_index == current_floor){
            if (button % 2 != 0 && button != 1){
                if (j == 0)
                    j = num_floors + 1;
                j--;
                if (j == current_floor){
                    if (j == 0)
                        j = num_floors + 1;
                    j--;
                    }
                }
            else {
                if (j == num_floors)
                    j = -1;
                j++;
                if (j == current_floor)
                    j++;
                }
            clr_char(1);
            if (j == num_floors){
                temp = 'X';
                disp_string(NULL);
                }
            else {
                temp = j + '0';
                disp_string(NULL);
                }
            }
        else if (button == CONFIRM){
            if (j == num_floors)
                break;
            else {
                cabin_call[j] = 1;
                if (current_floor > j)
                    cabin_call[j] = 2;
                }
            }
        else
            set_floor();
        }
    }
clr_char(7); //strlen("Flrs: X")
}

void moving(){
int counter = move_time;
while (current_floor != destination_floor){
    cmd(clear_screen);
    temp = current_floor + '0';
    disp_string(&moving_msg);
    disp_string(NULL);
    while (counter != 0){
        counter--;
        button_press();
        if ((button != -1) && (button != CONFIRM)){
            set_floor();
            }
        if ((floor_call[current_floor] > 2) || ((current_floor < destination_floor) && (floor_call[current_floor] == 1)) || ((current_floor > destination_floor) && (floor_call[current_floor] == 2))){
            if ((current_floor < destination_floor) && (floor_call[current_floor] >= 3))
                floor_call[current_floor] = 2;
            else if ((current_floor > destination_floor) && (floor_call[current_floor] >= 3))
                floor_call[current_floor] = 1;
            else
                floor_call[current_floor] = 0;
            cabin_call[current_floor] = 0;
            cmd(clear_screen);
            disp_string(&reached_msg);
            disp_string(NULL);
            floor_details();
            cmd(clear_screen);
            temp = current_floor + '0';
            disp_string(&moving_msg);
            disp_string(NULL);
            }
        if (cabin_call[current_floor] != 0){
            cabin_call[current_floor] = 0;
            cmd(clear_screen);
            disp_string(&reached_msg);
            disp_string(NULL);
            __delay_ms(5);
            cmd(clear_screen);
            disp_string(&moving_msg);
            disp_string(NULL);
            }
        }
    counter = move_time;
    current_floor = current_floor + ((destination_floor - current_floor > 0) - (destination_floor - current_floor < 0));
    }
cmd(clear_screen);
temp = destination_floor + '0';
disp_string(&reached_msg);
disp_string(NULL);
prob_move = 0;
destination_floor = -1;
if (floor_call[current_floor] != 0){
    cabin_call[current_floor] = 0;
    floor_details();
    if (floor_call[current_floor] % 2 == 0){
        if (floor_call[current_floor] == 4)
            floor_call[current_floor] = 3;
        floor_call[current_floor] -= 2;    
        call_min();
        }
    else {
        floor_call[current_floor] -= 1; 
        call_max();
        }
    }
else if (cabin_call[current_floor] != 0){
    if (cabin_call[current_floor] == 1){
        cabin_call[current_floor] = 0;
        call_min();
        }
    else {
        cabin_call[current_floor] = 0;
        call_max();
        }
    __delay_ms(5);
    }
if ((current_floor < destination_floor) && (destination_floor != -1))
    call_max();
else if ((current_floor > destination_floor) && (destination_floor != -1))
    call_min();
if (destination_floor == -1)
    max_prob_floor();
}

void main(){
initialize();
hour = 0;
counter2 = interrupt_time;
prob_move = 0;
current_floor = 0;
destination_floor = -1;
i = -10;
while (1){
    button_press();
    if ((button != -1) && (button != CONFIRM)){
        floor_call[floor_index] = floor_direction;
        destination_floor = floor_index;
        }
    while (destination_floor != -1){
            moving();
            i = -10;
        }
    if (i == -10){
        i = -9;
        cmd(clear_screen);
        temp = current_floor + '0';
        disp_string(&stopped_msg);
        disp_string(NULL);
        }
    max_prob_floor();
    }
}