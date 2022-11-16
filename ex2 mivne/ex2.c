//
// Created by Shira Taitelbaum 322207341
//
#include "ex2.h"

#define MSB 0x80000000

int magToInt(magnitude a) {
    //-2147483648 in binary is -0 so it is 0
    if (a == -2147483648) {
        return 0;
    }
    //change to int
    int num = a & ~MSB;
    num = a & MSB ? -num : num;
    return num;
}

magnitude intToMag(int a) {
    //-2147483648 in binary is -0 so it is 0
    if (a == -2147483648) {
        return 0;
    }
    //the positive is the same
    if (a >= 0) {
        return a;
    } else {
        //else its negative
        int num = -a;
        //return to magnitude
        num = num | MSB;
        return num;
    }
}

magnitude add(magnitude a, magnitude b) {
    //change a and b to int
    a = magToInt(a);
    b = magToInt(b);
    //the sum of and b
    int sum = a + b;
    //if a and b positive
    if (a >= 0 && b >= 0) {
        //if sum >0
        if (sum > 0) {
            //return intToMag(sum)
            return intToMag(sum);
        }
        //else(sum<0)(overflow), return -intToMag(sum)
        return -intToMag(sum);
    }
    //if a and b negative
    if (a <= 0 && b <= 0) {
        //if sum <0
        if (sum < 0) {
            //return intToMag(sum)
            return intToMag(sum);
        }
        //else(sum>0)(overflow), return -intToMag(sum)
        return -intToMag(sum);
    }
    //if one positive and one negative, return intToMag(sum)
    //not overflow
    return intToMag(sum);
}

magnitude sub(magnitude a, magnitude b) {
    //change a and b to int
    a = magToInt(a);
    b = magToInt(b);
    //the difference of and b
    int differ = a - b;
    //if a >= 0  and b < 0
    if (a >= 0 && b < 0) {
        //return the result of a+(-b)
        return add(a, -b);
    }
    //if a < 0  and b >= 0
    if (a < 0 && b >= 0) {
        //if differ < 0
        if (differ < 0) {
            //return intToMag(differ)
            return intToMag(differ);
        }
        //else differ > 0,(overflow) return -intToMag(differ)
        return -intToMag(differ);
    }
    //if they both positive or negative, return intToMag(differ)
    //cant be overflow
    return intToMag(differ);
}

magnitude multi(magnitude a, magnitude b) {
    //mult it is magToInt(a) * magToInt(b)
    int mult = magToInt(a) * magToInt(b);
    //if one of them is positive and the other is negative
    if ((a >= 0 && b < 0) || (a < 0 && b >= 0)) {
        //if mult is positive(overflow) , return -intToMag(mult)
        if (mult >= 0) {
            return -intToMag(mult);
        }
        //if mult < 0, (not overflow)
        return intToMag(mult);
    }
    //if both of them is the same and mult<0
    if ((a >= 0 && b >= 0 && mult < 0) || (a < 0 && b < 0 && mult < 0)) {
        //(overflow) , return -intToMag(mult)
        return -intToMag(mult);
    }
    //else milt>0, return intToMag(mult)
    return intToMag(mult);
}

// true = 1, false = 0
int equal(magnitude a, magnitude b) {
    //return if magToInt(a) == magToInt(b)
    return magToInt(a) == magToInt(b);
}

int greater(magnitude a, magnitude b) {
    //return if magToInt(a) > magToInt(b)
    return magToInt(a) > magToInt(b);
}

