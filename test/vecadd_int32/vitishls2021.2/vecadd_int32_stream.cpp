#include "vecadd_int32_stream.hpp"

void vecadd_fp32_stream(int inputs[LEN*2], int outputs[LEN]){
#pragma HLS INTERFACE mode=axis port=outputs
#pragma HLS INTERFACE mode=axis port=inputs

	int i=0;
	int a[LEN], b[LEN], c[LEN];

	for(i=0;i<LEN*2;i++){
		if(i<LEN)
			a[i] = inputs[i];
		else
			b[i-LEN] = inputs[i];
	}

	vecadd_fp32(a, b, c);

	for(i=0;i<LEN;i++){
		outputs[i] = c[i];
	}

}
