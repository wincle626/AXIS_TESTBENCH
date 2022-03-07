#include "vecadd_int32.hpp"

void vecadd_fp32(int a[LEN], int b[LEN], int c[LEN]){
#pragma HLS INLINE off

	for(int i=0;i<LEN;i++){
		int temp = a[i] + b[i];
		c[i] = temp;
	}

}
