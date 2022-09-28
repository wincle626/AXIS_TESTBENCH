#include <assert.h>
#include <ap_axi_sdata.h>

// THIS IS THE TOP LEVEL DESIGN THAT WILL BE SYNTHESIZED
int const DIM = 4;
#define MCR_SIZE DIM*DIM

template <typename T, int U, int TI, int TD>
T pop_stream(ap_axiu <sizeof(T)*8,U,TI,TD> const &e)
{
#pragma HLS INLINE

	assert(sizeof(T) == sizeof(int));
	union
	{
		int ival;
		T oval;
	} converter;
	converter.ival = e.data;
	T ret = converter.oval;

	volatile ap_uint<sizeof(T)> strb = e.strb;
	volatile ap_uint<sizeof(T)> keep = e.keep;
	volatile ap_uint<U> user = e.user;
	volatile ap_uint<1> last = e.last;
	volatile ap_uint<TI> id = e.id;
	volatile ap_uint<TD> dest = e.dest;

	return ret;
}
template <typename T, int U, int TI, int TD>
ap_axiu <sizeof(T)*8,U,TI,TD> push_stream(T const &v, bool last = false)
{
#pragma HLS INLINE
	ap_axiu<sizeof(T)*8,U,TI,TD> e;

	assert(sizeof(T) == sizeof(int));
	union
	{
		int oval;
		T ival;
	} converter;
	converter.ival = v;
	e.data = converter.oval;

	// set it to sizeof(T) ones
	e.strb = -1;
	e.keep = 15; //e.strb;
	e.user = 0;
	e.last = last ? 1 : 0;
	e.id = 0;
	e.dest = 0;
	return e;
}
template <typename T, int DIM>
void mmult_hw(T a[DIM][DIM], T b[DIM][DIM], T out[DIM][DIM])
{

	int const FACTOR = DIM/2;
	#pragma HLS INLINE
	//#pragma HLS array_partition variable=a block factor=FACTOR dim=2
	//#pragma HLS array_partition variable=b block factor=FACTOR dim=1
	// matrix multiplication of a A*B matrix
	L1:for (int ia = 0; ia < DIM; ++ia)
		L2:for (int ib = 0; ib < DIM; ++ib)
		{
			#pragma HLS PIPELINE II=1
			T sum = 0;
			L3:for (int id = 0; id < DIM; ++id)
				sum += a[ia][id] * b[id][ib];
			out[ia][ib] = sum;
		}
		return;
}
typedef ap_axiu<32,4,5,5> AXI_VAL;
template <typename T, int DIM, int SIZE, int U, int TI, int TD>
void wrapped_mmult_hw (
	AXI_VAL in_stream[2*SIZE],
	AXI_VAL out_stream[SIZE])
{
#pragma HLS INLINE off

	T a[DIM][DIM];
	T b[DIM][DIM];
	T out[DIM][DIM];
	assert(sizeof(T)*8 == 32);
	// stream in first matrix
	for(int i=0; i<DIM; i++)
		for(int j=0; j<DIM; j++)
		{
#pragma HLS PIPELINE II=1
			int k = i*DIM+j;
			a[i][j] = pop_stream<T,U,TI,TD>(in_stream[k]);

		}
		// stream in second matrix
		for(int i=0; i<DIM; i++)
			for(int j=0; j<DIM; j++)
			{
#pragma HLS PIPELINE II=1
				int k = i*DIM+j+SIZE;
				b[i][j] = pop_stream<T,U,TI,TD>(in_stream[k]);
			}
		// do HW multiplication
		mmult_hw<T, DIM>(a,b,out);
		// stream out result matrix
		for(int i=0; i<DIM; i++)
			for(int j=0; j<DIM; j++)
			{
				#pragma HLS PIPELINE II=1
				int k = i*DIM+j;
				out_stream[k] = push_stream<T,U,TI,TD>(out[i][j],k == (SIZE-1));
			}
		return;
}
