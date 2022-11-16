#include <stdio.h>
#include "ex1.h"
#include "ex1.c"

int main() {

	printf("%d\n", is_big_endian());
    //printf("%d, %d\n", sizeof(unsigned long long), sizeof(unsigned long ));
	printf("0x%lx\n", merge_bytes(0x89ABCDEF12893456, 0x76543210ABCDEF19));
//0x89ABCDEFABCDEF19.
	printf("0x%lx\n", put_byte(0x12345678CDEF3456, 0xAB, 2));
    //0x1234AB78CDEF3456
	printf("0x%lx\n", put_byte(0x12345678CDEF3456, 0xAB, 0));
    // 0xAB345678CDEF3456

	return 0;
}
