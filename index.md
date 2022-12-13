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

The serial port is connected to the Raspberry Pi Pico that outputs values to an external computer. It was used to receive user input of the .bmp file. 

* Video Graphics Array (VGA)

The VGA is a display that is used to display the compression array in greyscale as well as what the algorithm has determined to be the letter. The VGA runs with 6 pins: VSYNC, HSYNC, BLUE, GREEN, RED, and Ground. Once the writing image goes through compression and the pico determines what letter it is then it will display the writing that was compressed image of the handwriting as well as what the algorithm determines the letter is.

* Decoder

To be able to have a grey scale on the VGA we created a decoder to send in the same voltage to all the red green blue pins. The decoder consisted of 3 different resistors that were connected in series with each other and output the voltage value to the VGA screen. The reason why we wanted a grey scale was because all of our images are black and white but when we compress the image to a smaller one that the algorithm uses we wanted to show the compression in a grey scale. Here you can find the (#1) [schematic](./schematics.md).


## Results

The final result of our design was that we were able to create a handwriting recognition program with the Pico. We were also able to display both the compression array as well as the predicted value that the algorithm has determined. Although we weren't able to combine both the camera as well as the algorithm code we were able to make them work separately. Going back to the algorithm there were able to make all of the lowercase letters get detected correctly whenever the drawings were nicely done. Other times, the algorithm would not detect the letter we were wanting to write. One other thing that we were able to get working were digits 0 to 9 since these were a lot smaller testing data we were able to train the algorithm a lot more. Due to limitations given the size of the memory in the Pico, we decide to stick with only lowercase letters to show the capabilities of the RP2040. Finally, our demo was able to demonstrate the functionality of going from a large picture to a smaller compression and running through the algorithm for twenty-six letters in the alphabet. We believe that this project has demonstrated how powerful the Raspberry Pi Pico is given a very small and inexpensive chip. It also demonstrated that we are able to use this algorithm to be able to translate written text like notes we take to type up notes for our convenience. Even though we weren't able to fully integrate the camera it has opened up doors to using cmake to interact with the pico.


## Conclusion

<iframe width="560" height="315" src="https://www.youtube.com/embed/teCES6Atgzo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Appendix Links

[Code](./code.md)

[Schematics](./schematics.md)

[Tasks](./tasks.md)

[References](./references.md)

[Appendix A](./appendixA.md)
