#include "ex4.h"
#include <stdio.h>


int main() {
    //***********************************
    gcd(275, 55);
    gcd(10, 3);
    gcd(0, 3);
    gcd(3, 0);
    //***********************************
    IsDividedBy3Iter(123);
    IsDividedBy3Iter(1);
    //***********************************
    isPalindromeIter("sun", 3);
    isPalindromeIter("pop", 3);

    return 0;
}