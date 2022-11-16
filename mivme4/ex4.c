//
// Created by shirataitel on 1/8/22.
//

/******************
* Shira Taitelbaum
* 322207341
* 01
* ass03
*******************/
#include "ex4.h"
#include <stdio.h>


/******************
* Function Name:gcd
* Input:long int n1, long int n2
* Output:none
* Function Operation:print the gcd
******************/
void gcd(long int n1, long int n2) {
    if (n2 == 0) {
        printf("GCD=%ld\n", n1);
    } else if (n1 == 0) {
        printf("GCD=%ld\n", n2);
    } else {
        printf("%ld*%ld+%ld=%ld(a=%ld,b=%ld)\n", n2, n1 / n2, n1 % n2, n1, n1, n2);
        gcd(n2, n1 % n2);
    }
}

/******************
* Function Name:isPalindromeIter
* Input:char str[], int len
* Output:none
* Function Operation:print if the word is PalindromeIt or not
******************/
void isPalindromeIter(char str[], int len) {
    int x = 0;
    for (int i = 0; i <= ((len) / 2); i++) {
        if (str[i] != str[len - 1 - i]) {
            x = 1;
            break;
        }
    }
    if (x == 0) {
        printf("The reverse of %s is also %s.\n", str, str);
    } else {
        printf("The reverse of %s is not %s.\n", str, str);
    }
}

/******************
* Function Name:IsDividedBy3Iter
* Input:long long num
* Output:none
* Function Operation:print if the number is divisible by 3 or not
******************/
void IsDividedBy3Iter(long long num) {
    long long isdiv = DividedBy3Iter1(num);
    if ((isdiv == 3) || (isdiv == 6) || (isdiv == 9))
        printf("The number %lld is divisible by 3.\n", num);
    else
        printf("The number %lld is not divisible by 3.\n", num);
}

long long DividedBy3Iter1(long long num) {
    long long num1 =0;
    while (num > 10) {
        while (num > 0) {
            num1 += num % 10;
            num = num / 10;
        }
        num = num1;
        num1 = 0;
    }
    num1 = num;
    return num1;
}
