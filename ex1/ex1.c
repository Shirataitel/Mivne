//
// / 322207341 Shira Taitelbaum
//

#include "ex1.h"

int is_big_endian() {
    //chose a number to check if little or big
    //the num is 1 and the rest is 0
    int x = 1;
    //pointer to thr num
    char *c = (char *) &x;
    return (c[0] == 0);
}

unsigned long merge_bytes(unsigned long x, unsigned long int y) {
    int size = sizeof(unsigned long) / 2;
    //diffrence between big and little
    if (is_big_endian()) {
        //pointers to the middle of the words
        char *cX = (char *) &x + size;
        char *cY = (char *) &y + size;
        //for loop
        for (int i = 0; i < size; i++) {
            //change x[i] to y[i]
            *cX = *cY;
            cX++;
            cY++;
        }
    } else {
        //pointers to the middle of the words
        char *cX = (char *) &x + size - 1;
        char *cY = (char *) &y + size - 1;
        //for loop
        for (int i = 0; i < size + 1; i++) {
            //change x[i] to y[i]
            *cX = *cY;
            cX--;
            cY--;
        }
    }
    return x;
}

unsigned long put_byte(unsigned long x, unsigned char b, int i) {
    //diffrence between big and little
    if (is_big_endian()) {
        //go to the right index
        char *cX = (char *) &x + i;
        //change to b
        *cX = b;
    } else {
        //go to the right index
        char* cX = (char *) &x +sizeof (unsigned long ) -1 -i;
        //change to b
        *cX = b;
    }
    return x;
}