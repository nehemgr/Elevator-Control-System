#include <htc.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

__CONFIG(FOSC_HS & WDTE_OFF & PWRTE_ON & CP_OFF); // Config word

#define _XTAL_FREQ 20000000 // Define CPU Frequency

//Physical Parameters
#define num_floors 4
#define move_time 3000
#define max_people 5

//LCD Pins
#define E RA3
#define RS RA4

//LCD Properties
#define line_size 24

//LCD Hex Codes
#define LCD_set 0x0E
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
#define F0_UP 1
#define F1_UP 2
#define F1_DOWN 3
#define F2_UP 4
#define F2_DOWN 5
#define F3_DOWN 6
#define CONFIRM 7

char msg[25];
short floor_call[num_floors];
bool cabin_call[num_floors];
short current_floor;
short destination_floor;
short button;
short i;
short j;

void disp(){
for (i = 0; i < strlen(msg); i++){
    PORTB = msg[i];
    RS = 1;
    E = 1;
    __delay_us(0.35);
    E = 0;
    }
}

void cmd(char cmd_msg){
PORTB = cmd_msg;
RS = 0;
E = 1;
__delay_us(0.35);
E = 0;
}

void clr_char(short spaces){
for (i = 0; i < spaces + 1; i++){
    msg[i] = ' ';
    }
msg[spaces + 1] = '\0';
cmd(cursor_backwards);
disp();
cmd(cursor_forwards);
cmd(cursor_right);
}

void initialize(){
//MCU
PORTA = 0x00; //Initialize PORTA pins to 0
PORTB = 0x00; //Initialize PORTB pins to 0
TRISB = 0x00; //Set PORTB pins to output mode
TRISA0 = 1; //Set A0 as input mode
TRISA1 = 1; //Set A1 as input mode
TRISA2 = 1; //Set A2 as input mode
TRISA3 = 0; //Set A3 as output mode
TRISA4 = 0; //Set A4 as output mode

//LCD
cmd(LCD_set);
cmd(clear_screen);
}

short button_press(){
if (S1)
    return 1;
if (S2)
    return 2;
if (S3)
    return 3;
if (S4)
    return 4;
if (S5)
    return 5;
if (S6)
    return 6;
if (S7)
    return 7;
return -1;
}

short button_to_floor(){
if (button == 1)
    return 0;
for (i = 2, j = 1; i <= num_floors*2 - 4; i = i + 2, j++){
    if ((button == i) || (button == i + 1))
        return j;
    }
if (button == num_floors*2 - 2)
    return num_floors - 1;
return -1;
}

short button_direction(){
if (button == 1)
    return 1;
for (i = 2; i <= num_floors*2 - 4; i++){
    if ((button == i) && (i % 2 == 0))
        return 1;
    else if ((button == i) && (i % 2 != 0))
        return 2;
    }
if (button == num_floors*2 - 2)
    return 2;
return -1;
}

short cabin_call_max(){
for (i = num_floors - 1; i > -1; i--){
    if (cabin_call[i] == 1)
        return i;
    }
}

short cabin_call_min(){
for (i = 0; i < num_floors; i++){
    if (cabin_call[i] == 1)
        return i;
    }
}

short nearest_call(){
for (i = current_floor - 1, j = current_floor + 1; (i != -1 || j != num_floors); i--, j++){
    if (j < num_floors)
        if ((floor_call[j] != 0) || (cabin_call[j] == 1))
            return j;
    if (i > -1)
        if ((floor_call[i] != 0) || (cabin_call[i] == 1))
            return i;
    }
return -1;
}

void set_floor(){
if ((floor_call[button_to_floor()] != button_direction()) && (floor_call[button_to_floor()] != 3) && (floor_call[button_to_floor()] != 4)){
    if (floor_call[button_to_floor()] == 2)
        floor_call[button_to_floor()] = 4;
    else
        floor_call[button_to_floor()] += button_direction();
    }
}

void set_destination(){
if (destination_floor != -1){
    if ((current_floor < destination_floor) && ((button_direction() == floor_call[destination_floor]) || (floor_call[destination_floor] > 2)) && (button_to_floor() > destination_floor))
        destination_floor = button_to_floor();
    else if ((current_floor > destination_floor) && ((button_direction() == floor_call[destination_floor]) || (floor_call[destination_floor] > 2)) && (button_to_floor() < destination_floor))
        destination_floor = button_to_floor();
    }
}

void floor_details(){
cmd(line2);
strcpy(msg, "Enter People: \0");
disp();
short i = 0;
itoa(msg, i, 10);
disp();
button = button_press();
while (button != CONFIRM){
    if (button != -1){
        if (button_to_floor() == current_floor){
            if (button % 2 != 0 && button != 1){
                if (i == 0)
                    i = max_people + 1;
                i--;
                }
            else {
                if (i == max_people)
                    i = -1;
                i++;  
                }
            clr_char(1);
            itoa(msg, i, 10);
            disp();
            }
        else{
            set_floor();
            set_destination();
            }
        }
    button = button_press();
    }
clr_char(strlen("Enter People: 0\0"));
strcpy(msg, "Enter Floors: \0");
disp();
i = 0;
itoa(msg, i, 10);
disp();
while (1){
    button = button_press();
    if (button != -1){
        if (button_to_floor() == current_floor){
            if (button % 2 != 0 && button != 1){
                if (i == 0)
                    i = num_floors + 1;
                i--;
                if (i == current_floor)
                    if (i == 0)
                        i = num_floors + 1;
                    i--;
                }
            else {
                if (i == num_floors)
                    i = -1;
                i++;
                if (i == current_floor)
                    i++;
                }
            clr_char(strlen(msg));
            if (i == num_floors){
                strcpy(msg, "Exit \0");
                disp();
                }
            else {
                itoa(msg, i, 10);
                disp(); 
                }
            }
        else if (button == CONFIRM){
            if (i == num_floors)
                break;
            else {
                cabin_call[i] = 1;
                }
            }
        else{
            set_floor();
            set_destination();
            }
        }
    }
clr_char(strlen("Enter Floors: Exit \0"));
}

void moving(){
short counter = 0;
while (current_floor != destination_floor){
    strcpy(msg, "Moving - Floor  \0");
    msg[strlen(msg)-1] = current_floor + '0';
    disp();
    while (counter <= move_time){
        counter++;
        button = button_press();
        if (button != -1){
            set_floor();
            set_destination();
            }
        if (((current_floor < destination_floor) && ((floor_call[current_floor] == 1) || (floor_call[current_floor] > 2))) || ((current_floor > destination_floor) && (floor_call[current_floor] >= 2))){
            if ((current_floor < destination_floor) && (floor_call[current_floor] >= 3))
                floor_call[current_floor] = 2;
            if ((current_floor > destination_floor) && (floor_call[current_floor] >= 3))
                floor_call[current_floor] = 1;
            if (cabin_call[current_floor] == 1)
                cabin_call[current_floor] = 0;
            cmd(clear_screen);
            strcpy(msg, "Stationary - Floor  \0");
            msg[strlen(msg)-1] = current_floor + '0';
            disp();
            floor_details();
            break;
            }
        if (cabin_call[current_floor] == 1){
            cabin_call[current_floor] = 0;
            cmd(clear_screen);
            strcpy(msg, "Reached - Floor  \0");
            msg[strlen(msg)-1] = current_floor + '0';
            disp();
            }
        }
    counter = 0;
    current_floor = current_floor + ((destination_floor - current_floor > 0) - (destination_floor - current_floor < 0));
    cmd(clear_screen);
    }
if (floor_call[destination_floor] != 0){
    if (cabin_call[destination_floor] == 1)
        cabin_call[destination_floor] = 0;
    strcpy(msg, "Stationary - Floor  \0");
    msg[strlen(msg)-1] = destination_floor + '0';
    disp();
    destination_floor = -1;
    floor_details();
    if (floor_call[current_floor] % 2 == 0){
        if (floor_call[current_floor] == 4)
            floor_call[current_floor] = 1;
        destination_floor = cabin_call_min();
        }
    else if (floor_call[current_floor] % 2 != 0){
        if (floor_call[current_floor] == 3)
            floor_call[current_floor] = 2;
        destination_floor = cabin_call_max();
        }
    }
else if (cabin_call[destination_floor] == 1){
    cabin_call[destination_floor] = 0;
    cmd(clear_screen);
    strcpy(msg, "Reached - Floor  \0");
    msg[strlen(msg)-1] = current_floor + '0';
    disp();
    destination_floor = -1;
    }
}

void main(){
initialize();
current_floor = 0;
destination_floor = -1;
strcpy(msg, "Stationary - Floor 0\0");
disp();
while (1){
    button = button_press();
    if ((button != -1) && (destination_floor == -1)){
        floor_call[button_to_floor()] = button_direction();
        destination_floor = button_to_floor();
        cmd(clear_screen);
        moving();
        }
    else if (destination_floor != -1){
        cmd(clear_screen);
        moving();
        }
    else
        destination_floor = nearest_call();
    }
}

