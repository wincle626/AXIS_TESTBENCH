#include <iostream>
#include <assert.h>
#include <ap_axi_sdata.h>
//#include "ap_axi_sdata.h"
//#include "hls_stream.h"
#define ROW (unsigned int)16
#define COL (unsigned int)8
#define DIM (unsigned int)256
#define MAX_ITER 5
template <typename T, int U, int TI, int TD>
T pop_stream(ap_axiu <sizeof(T)*8,U,TI,TD> const &e)
{
#pragma HLS INLINE off

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
#pragma HLS INLINE off
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
template<class T, int M>
T VECVEC_MUL( T V1[M], T V2[M]){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
// #pragma HLS ARRAY_PARTITION variable=V2 block factor=2 dim=1
	T result = (T) 0;
	for( int i=0; i<M; i++ ){
// #pragma HLS PIPELINE II=1
        T a_val = V1[i];
        T b_val = V2[i];
		T tmp = a_val * b_val;
#pragma HLS RESOURCE variable=tmp core=FMul_fulldsp
		result += (T) tmp;
		//printf("%f\t", (float)tmp);
	}
	return result;
}
template<class T, int M>
void VEC2VEC(T V1[M], T V2[M]){
#pragma HLS INLINE off
	for(int i=0;i<M;i++){
//#pragma HLS PIPELINE II=1
		T tmp = V1[i];
		V2[i] = (T) tmp;
	}
}
template<class T, int M, int N>
void MATROW(T A[M][N], T B[N], int row){
#pragma HLS INLINE off
	for(int i=0;i<N;i++){
		B[i] = A[row][i];
	}
}
template<class T, int M, int N>
void MATCOL(T A[M][N], T B[N], int col){
#pragma HLS INLINE off
	for(int i=0;i<M;i++){
		B[i] = A[i][col];
	}
}
template<class T, int M, int N>
void MAT_VEC_MUL(T A[M][N],
				  T B[N],
				  T C[M]){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=A block factor=2 dim=1
// #pragma HLS ARRAY_PARTITION variable=B block factor=2 dim=1
	for ( int i=0; i<M; i++ ){
 #pragma HLS PIPELINE II=1
		C[i] = 0;
		for ( int j=0; j<N; j++ ){
 #pragma HLS PIPELINE II=1
//			T tmp = A[i][j] * B[j];
//			T tmp1 = tmp + C[i];
//#pragma HLS RESOURCE variable=tmp core=DMul_fulldsp
//#pragma HLS RESOURCE variable=tmp1 core=DAddSub_fulldsp
//			C[i] = tmp1;
            // Get previous sum
            T last = C[i];
            // Update current sum
            // Handle boundary conditions
            T a_val = A[i][j];
            T b_val = B[j];
			T tmp = a_val * b_val;
            T result = last + tmp;
//#pragma HLS RESOURCE variable=tmp core=FMul_fulldsp
//#pragma HLS RESOURCE variable=result core=FAddSub_fulldsp
            // Write back results
            C[i] = result;
		}
	}
}
template<class T, int M, int N>
void MAT_VEC_MUL1(T A[M][N],
				  T B[N],
				  T C[M]){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=A block factor=2 dim=1
// #pragma HLS ARRAY_PARTITION variable=B block factor=2 dim=1
	for ( int i=0; i<M; i++ ){
// #pragma HLS PIPELINE II=1
		float Arow[ROW];
		MATROW<float, ROW, ROW>(A, Arow, i);
		C[i] = VECVEC_MUL<float, ROW>(Arow, B);
	}
}
template<class T, int M>
void VEC_SUB( T V1[M], T V2[M], T V3[M] ){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
// #pragma HLS ARRAY_PARTITION variable=V2 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
 #pragma HLS PIPELINE II=1
        T a_val = V1[i];
        T b_val = V2[i];
		T tmp = a_val - b_val;
#pragma HLS RESOURCE variable=tmp core=FAddSub_fulldsp
		V3[i] = tmp;
	}
}
template<class T, int M>
void VEC_SCALAR_MUL( T V1[M], T S, T V3[M] ){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
 #pragma HLS PIPELINE II=1
        T a_val = V1[i];
		T tmp = a_val * S;
#pragma HLS RESOURCE variable=tmp core=FMul_fulldsp
		V3[i] = tmp;
	}
}
template<class T, int M>
void VEC_ADD( T V1[M], T V2[M], T V3[M] ){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
// #pragma HLS ARRAY_PARTITION variable=V2 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
// #pragma HLS PIPELINE II=1
        T a_val = V1[i];
        T b_val = V2[i];
		T tmp = a_val + b_val;
#pragma HLS RESOURCE variable=tmp core=FAddSub_fulldsp
		V3[i] = tmp;
	}
}
template<class T, int M>
void VEC_SCALAR_SUB( T V1[M], T S, T V3[M] ){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
 #pragma HLS PIPELINE II=1
        T a_val = V1[i];
		T tmp = a_val - S;
#pragma HLS RESOURCE variable=tmp core=FAddSub_fulldsp
		V3[i] = tmp;
	}
}
template<class T, int M>
void VEC_SCALAR_ADD( T V1[M], T S, T V3[M] ){
 #pragma HLS INLINE off
// #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
 #pragma HLS PIPELINE II=1
        T a_val = V1[i];
		T tmp = a_val + S;
#pragma HLS RESOURCE variable=tmp core=FAddSub_fulldsp
		V3[i] = tmp;
	}
}
template<class T, int M>
void VEC_MINUS( T V1[M], T V2[M] ){
  #pragma HLS INLINE off
// // #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
#pragma HLS PIPELINE II=1
        T a_val = V1[i];
		V2[i] = -a_val;
	}
}
template<class T, int M>
void VEC_SCALAR_MAX( T V1[M], T S, T V3[M] ){
  #pragma HLS INLINE off
// // #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
	for( int i=0; i<M; i++ ){
#pragma HLS PIPELINE II=1
        T a_val = V1[i];
		V3[i] = a_val> S ? a_val : S;
	}
}
template<class T, int M>
void VEC_SCALAR_MAX( T S, T V1[M], T V3[M] ){
#pragma HLS INLINE off
	for( int i=0; i<M; i++ ){
		V3[i] = V1[i] > S ? S: V1[i];
	}
}
//template<class T, int M>
//void VEC_EQ( T V1[M], T V2[M] ){
//// // #pragma HLS INLINE off
//// // #pragma HLS ARRAY_PARTITION variable=V1 block factor=2 dim=1
//	for( int i=0; i<M; i++ ){
//// // #pragma HLS PIPELINE II=1
//        T a_val = V1[i];
//		V2[i] = a_val;
//	}
//}
//template<class T, int M>
//void ZEROS_VEC( T V[M] ){
//	for( int i=0; i<M; i++ ){
//		V[i] = 0;
//	}
//}
//template<class T, int M>
//void VEC_SCALAR_NZERODIV( T V1[M], T V3[M] ){
//	for( int i=0; i<M; i++ ){
//		V3[i] = (V1[i] != (T)0 ? V1[i] : (T)1);
//	}
//}
//template<class T, int M>
//void VEC_DIV( T V1[M], T V2[M], T V3[M]){
//	for( int i=0; i<M; i++ ){
//		V3[i] = V1[i]/V2[i];
//	}
//}
//template<class T, int M, int N, int P>
//void MAT_MUL(T A[M][N],
//             T B[N][P],
//             T C[M][P]){
//    for ( int i=0; i<M; i++ ){
//        for ( int j=0; j<P; j++ ){
//            C[i][j] = 0;
//            for ( int k=0; k<N; k++ ){
//                C[i][j] += A[i][k] * B[k][j];
//            }
//        }
//    }
//}


float pgd_f32(float A[ROW][ROW], float b[ROW],
		float beta, float gamma, float lambda,
		float x_out[ROW]);
void pgdstr(float input[ROW+1],
		float output[ROW+1]);
