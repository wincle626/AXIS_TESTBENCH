#include <stdio.h>
#include "vecadd_int32_stream.hpp"

int main(int argc, char** argv){

	int inputs[LEN*2] = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16
	};
	int outputs[LEN];

	vecadd_fp32_stream(inputs, outputs);

	for(int i=0;i<LEN;i++){
		printf("outputs[%d]=%d\n", i, outputs[i]);
	}

	return 0;
}
