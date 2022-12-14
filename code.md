[Home](./index.md)

# Code

## Digitrec

// Include necessary libraries
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "pico/stdlib.h"
#include "pico/multicore.h"
#include "hardware/sync.h"
#include "hardware/spi.h"
// Include protothreads
#include "pt_cornell_rp2040_v1.h"
#include "training_data.h"
#include "testing_data.h"
#include "hardware/uart.h"
#include "vga_graphics.h"
 
#define NUM_VAL 784 // Number of pixels in image
 
// Order for greyscale:
// 0 1 2 4 3 5 6 7
// darkest - lightest
 
#define UART_ID1 uart1
#define BAUD_RATE 115200
#define UART_TX_PIN 4
#define UART_RX_PIN 5
 
// knn k value
#define K_CONST 5
 
// Initialize global variables
char num[NUM_VAL][3];      // Array of pixels in chars/strings
int  count[NUM_VAL];       // Number of chars per pixel e.g. 255 has 3 chars
