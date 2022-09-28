/*
 * Empty C++ Application
 */

#include "stdio.h"
#include "header.hpp"

void mmult_hw (T in_stream[2*SIZE], T out_stream[SIZE], T out_sctream_ref[SIZE])
{

	axis_stream(in_stream, out_stream, out_sctream_ref);

}

void mmult_sw(T a[DIM][DIM], T b[DIM][DIM], T out[DIM][DIM])
{
	// matrix multiplication of a A*B matrix
	for (int ia = 0; ia < DIM; ++ia)
		for (int ib = 0; ib < DIM; ++ib)
		{

			float sum = 0;

			for (int id = 0; id < DIM; ++id)

				sum += a[ia][id] * b[id][ib];

			out[ia][ib] = sum;
		}
}

int main()
{

	int i,j, err;

	T matOp1[DIM][DIM];
	T matOp2[DIM][DIM];
	T matMult_sw[DIM][DIM];
	T matMult_hw[DIM][DIM];

	/** Matrix Initiation */
	for(i = 0; i<DIM; i++)
		for(j = 0; j<DIM; j++)
			matOp1[i][j] = (float)(i+j);

	for(i = 0; i<DIM; i++)
		for(j = 0; j<DIM; j++)
			matOp2[i][j] = (float)(i*j);
	/** End of Initiation */

	/* reference Matrix Multiplication */
	mmult_sw(matOp1, matOp2, matMult_sw);

	T in_stream[2*SIZE];
	T out_stream_ref[SIZE];
	T out_stream[SIZE];
	for(int i=0; i<DIM; i++)
		for(int j=0; j<DIM; j++)
		{
			int k = i*DIM+j;
			in_stream[k] = matOp1[i][j];

		}
	for(int i=0; i<DIM; i++)
		for(int j=0; j<DIM; j++)
		{
			int k = i*DIM+j+SIZE;
			in_stream[k] = matOp2[i][j];
		}
	for(int i=0; i<DIM; i++)
		for(int j=0; j<DIM; j++)
		{
			int k = i*DIM+j;
			out_stream_ref[k] = matMult_sw[i][j];

		}

	mmult_hw(in_stream, out_stream, out_stream_ref);

	/** Matrix comparison */
	for(int i=0; i<DIM; i++)
		for(int j=0; j<DIM; j++)
		{
			int k = i*DIM+j;
			matMult_hw[i][j] = out_stream[k];
		}
	err = 0;
	for (i = 0; (i<DIM && !err); i++)
		for (j = 0; (j<DIM && !err); j++)
			if (matMult_sw[i][j] != matMult_hw[i][j])
				err++;

	if (err == 0)
		printf("Matrixes identical ... Test successful!\r\n");
	else
		printf("Test failed!\r\n");

	return err;
}
