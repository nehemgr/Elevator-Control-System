# Elevator-Control-System
This project focuses on a simulation of an elevator control system in Multisim using the PIC16F84A microcontroller, push buttons and a LCD Display. As an added innovation to this, the code defines the number of hours in a day (a new hour is visualized by the blinking of the LCD), and the elevator will wait at the floor where the most probable calls will come from in that hour. The code has been highly optimized to fit the constrained resources of the PIC microcontroller, and with a few modifications to the initial #define of the program, it can be extended to any number of floors and any number of hours. By default, the program is defined for 4 floors and 3 hours in a day.

## Running the Project
Make sure you have NI Multisim 14.2 or above installed on your system. Open the LCDMulti.ms14 file and run the simulation.
1. To request the elevator at a particular floor to go either up or down, press the respective floor buttons.
2. Once the elevator has reached the floor, the LCD will ask the number of people entering the lift. A maximum of 5 people can enter, which can be chosen only with the respective buttons of the current floor.
3. To confirm this choice, press the common Confirm button.
4. Next, the LCD requests for the required floors the elevator must go to. Once again, the floors can be accessed by the respective buttons of the current floor and chosen using the common Confirm button.
5. Once all the inputs are completed, navigate to the X choice and hit the Confirm button to exit. The elevator will now resume its motion.
6. Note that hall calls can be given from any floor during the above processes - i.e. while the elevator is moving or requesting input, if any other floor's buttons are pressed, it will be registered as a hall call and fulfilled.
7. When there are no more calls to fulfill, the elevator will move to and remain stationary at the floor where the most hall calls are anticipated. However, if there is any call while the elevator moves to this floor, the priority is for the current floor calls.
8. A new hour is conveyed by the blinking of the LCD display.

## Circuit Diagram
![alt text](<https://github.com/nehemgr/Elevator-Control-System/blob/main/Files/circuit_diagram.jpg>)

## Project Demo
![alt text](<https://github.com/nehemgr/Elevator-Control-System/blob/main/Files/sample_run.jpg>)
