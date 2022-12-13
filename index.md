# Welcome to ECE 4760 Microcontroller's Final project.

This project was worked on by Maria Boza (mib57) Anya Prabowo (afp65) Eshita Sangani (ens57)


## Project Description

Our project was to demonstrate handwriting detection using the Raspberry Pi Pico. There was a second part of the project that consisted of a camera being used to take pictures. 


The project first starts off with the user writing a lowercase letter (character) on a paint application and converted into a .bmp file. This file is then compressed to a 28 by 28 array. After the compression, it will be run through a KNN algorithm to determine what letter was written to and then display it on the VGA screen. 

The second part of our project was the camera module. We used the Arducam camera and a button to take a picture and display it on our computer screen.



## High Level Design


## Program Design


## Hardware Design
* Raspberry Pi Pico / RP2040

The RP2040 is a high-performance microcontroller device with interfaces such as GPIO, ADC, and SPI flashing. It is responsible for flashing our programs in conjunction with the different peripheral devices. 	

* USB Serial Port

The serial port  is connected to the Raspberry Pi Pico that outputs values to an external computer. It was used to receive user input of the .bmp file. 

* Video Graphics Array (VGA)

The VGA is a display that is used to display the boids and the motion as well as the bounds. The VGA runs with 6 pins: VSYNC, HSYNC, BLUE, GREEN, RED, and Ground. Once the writing image goes through compression and the pico determines what letter it is then it will display the writing that was compressed image of the handwriting as well as what the algorithm determines the letter is.

* Decoder

To be able to have a grey scale on the vga we created a decoder to send in the same voltage to all the red green blue pins. The decoder consisted of 3 different resistors that were connected in series with each other and output the voltage value to the VGA screen. The reason why we wanted a grey scale was because all of our images are black and white but when we compress the image to a smaller one that the algorithm uses we wanted to show the compression in grey scale. Here you can find the (#1) [schematic](./schematics.md).


## Results


## Conclusion

<iframe width="560" height="315" src="https://www.youtube.com/embed/teCES6Atgzo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Appendix Links

[Code](./code.md)

[Schematics](./schematics.md)

[Tasks](./tasks.md)

[References](./references.md)

[Appendix A](./appendixA.md)
