[Home](./index.md)

# Code

## Digitrec

```
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
int  actual_num[NUM_VAL];  // Pixel values in integers
char actual_char[NUM_VAL]; // Pixel values in char (8bits)
int  final_val = 0;        // All the pixels are valid
 
// Array to index for lowercase character result
char char_arr[26] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
 
// —------------------------------
// Helper functions
// —------------------------------
 
int abs( int val ) {
 if ( val < 0 )
   return -val;
 return val;
}
 
int distance_euclidean( char a[NUM_VAL], const char b[NUM_VAL] ) {
 int dist = 0;
 int interm = 0;
 
 // Iterate through array
 for ( int i = 0; i < NUM_VAL; i++ )
   dist += abs( (int)a[i] - (int)b[i] );
  return dist;
}
 
// —------------------------------
// knn functions
// —------------------------------
 
void update_knn( char test_inst[NUM_VAL], const char train_inst[NUM_VAL], int min_distances[K_CONST]) {
 
 int dist = distance_euclidean( test_inst, train_inst ); 
 // Replace minimum distance
for ( int i = 0; i < K_CONST; i++ ) {
   if ( dist < min_distances[i] ) {
     int temp = min_distances[i];
     min_distances[i] = dist;
     dist = temp;
   }
 }
}
 
int knn_vote( int knn_set[26][K_CONST] ) {
 int k_dist[K_CONST];     // Array of k smallest distances
 int digit_near[K_CONST]; // knn digits
 printf("\n");
 
 for ( int i = 0; i < 26; i++ ) {
   printf("%d: ", i);
   for ( int j = 0; j < K_CONST; j++ ) {
     printf("%d ", knn_set[i][j]);
   }
   printf("\n");
 }
 
 // Initialize
 for ( int i = 0; i < K_CONST; i++ ) {
   k_dist[i] = 200000;
   digit_near[i] = 27;
 }
 
 // Loop through each minimum distances
 for ( int i = 0; i < 26; i++ ) {
   for ( int j = 0; j < K_CONST; j++ ) {
 
     // Assign distance and digit
     int dist  = knn_set[i][j];
     int digit = i;
 
     // Loop through array of current k nearest neighbors
     for ( int k = 0; k < K_CONST; k++ ) {
       // Replace if smaller
       if ( dist < k_dist[k] ) {
         // Swap so we can check the other knn
         int temp1 = k_dist[k];
         k_dist[k] = dist;
         dist = temp1;
         int temp2 = digit_near[k];
         digit_near[k] = digit;
         digit = temp2;
       }
     }
   }
 }
 
 // Count number of instances of digit
 int count[K_CONST];
 
 for ( int i = 0; i < K_CONST; i++ )
   count[i] = 0;
 
 for ( int i = 0; i < K_CONST; i++ )
   for ( int j = 0; j < K_CONST; j++ )
     if ( digit_near[i] == digit_near[j] )
       count[i] += 1; // If match, increment counter
 
 int largest_count = 0;
 int digit;
 
 // Find the largest count (and if tie, take the first one)
 for ( int i = 0; i < K_CONST; i++ ) {
   if ( count[i] > largest_count ) {
     largest_count = count[i];
     digit = digit_near[i];
   }
 }
 
 return digit;
}
 
// —------------------------------
// Core 0 thread
// —------------------------------
 
static PT_THREAD (protothread_uart0(struct pt *pt)) {
 // Indicate thread beginning
 PT_BEGIN(pt) ;
 
 while(1) {
   PT_YIELD_usec(100) ;
 
   // If entire image has been sent serially
   if ( final_val ) {
     fillRect(0, 0, 640, 480, 0); // Clear vga screen
      for ( int i = 0; i < NUM_VAL; i++) {
       // Convert to integer
       if ( count[i] < 2 ) {
         actual_num[i] = num[i][0] - '0';
         actual_char[i] = actual_num[i];
       } else {
         char str[3] = "";
         for ( int j = 0; j < count[i]; j++ )
           strncat(str, &num[i][j], 1);
         actual_num[i] = atoi(str);
         actual_char[i] = actual_num[i];
       }
     }
 
     // Print digit on screen
     for (int row = 0; row < 28; row++) {
       for(int col = 0; col < 28; col++) {
         if ( actual_num[28*row + col] < 41 )
           fillRect(col*10 + 180, row*10 + 50, 10, 10, 0);
         else if ( actual_num[28*row + col] < 83 )
           fillRect(col*10 + 180, row*10 + 50, 10, 10, 1);
         else if ( actual_num[28*row + col] < 125 )
           fillRect(col*10 + 180, row*10 + 50, 10, 10, 2);
         else if ( actual_num[28*row + col] < 167 )
           fillRect(col*10 + 180, row*10 + 50, 10, 10, 3);
         else if ( actual_num[28*row + col] < 209 )
           fillRect(col*10 + 180, row*10 + 50, 10, 10, 6);
         else
           fillRect(col*10 + 180, row*10 + 50, 10, 10, 7);
       }
     }
 
     // -----------------------------
     // knn algorithm
     // -----------------------------
 
     // This array stores K minimum distances per training set
     int knn_set[26][K_CONST];
 
     // Initialize the knn set
     for ( int i = 0; i < 26; ++i )
       for ( int k = 0; k < K_CONST; ++k )
         knn_set[i][k] = 200000; // Max distance is 200000
    
     // i is for training data sets, and j is looping through each digit
     for ( int i = 0; i < TRAINING_SIZE; ++i ) {
```
