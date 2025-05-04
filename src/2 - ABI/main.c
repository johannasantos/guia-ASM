#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10);

	assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	assert(alternate_sum_8(1, 1, 2, 2, 3, 3, 4, 4) == 0);

	assert(alternate_sum_8(8, 7, 6, 5, 4, 3, 2, 1) == 4);
	
	printf("all good\n");

	return 0;
}
