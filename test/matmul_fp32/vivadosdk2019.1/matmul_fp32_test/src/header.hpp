/*
 * header.hpp
 *
 *  Created on: 27 Sep 2022
 *      Author: vv_fa
 */

#ifndef SRC_HEADER_HPP_
#define SRC_HEADER_HPP_

typedef float T;
int const DIM = 4;
int const SIZE = DIM*DIM;

#define IN_LEN 2*SIZE
#define OUT_LEN SIZE

template <typename T, int DIM>
void mmult_hw(T a[DIM][DIM], T b[DIM][DIM], T out[DIM][DIM])
{

//	int const FACTOR = DIM/2;
//	#pragma HLS INLINE
	//#pragma HLS array_partition variable=a block factor=FACTOR dim=2
	//#pragma HLS array_partition variable=b block factor=FACTOR dim=1
	// matrix multiplication of a A*B matrix
	for (int ia = 0; ia < DIM; ++ia)
		for (int ib = 0; ib < DIM; ++ib)
		{
			//#pragma HLS PIPELINE II=1
			T sum = 0;
			for (int id = 0; id < DIM; ++id)
				sum += a[ia][id] * b[id][ib];
			out[ia][ib] = sum;
		}
//		return;
}

int axis_stream(T in_stream[2*SIZE], T out_stream[SIZE], T output_ref[OUT_LEN]);



#endif /* SRC_HEADER_HPP_ */
