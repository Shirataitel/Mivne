//
// Created by shirataitel on 11/5/21.
//

int go(int A[10]) {
    int sum = 0;
    int i = 0;
    while (i < 10) {
        if (A[i] % 2 == 0) {
            int num = A[i] << i;
            sum += num;
        } else {
            sum += A[i];
        }
        i++;
    }
    return sum;
}
