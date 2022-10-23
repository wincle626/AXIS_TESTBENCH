/*
 * axis_stream_main.cpp
 *
 *  Created on: 19 Oct 2022
 *      Author: udrc
 */

#include "axis_stream.h"

float input[IN_LEN] = {
		60, 80, 80, 60, 80, 60, 80, 60,
		138.295307159424,
		199.456977844238,
		180.363125801086,
		152.307105064392,
		194.237375259399,
		147.856597900391,
		193.458976745605,
		138.239808082581
	};
float output_ref[OUT_LEN] = {
		2.37091054946712,
		2.33161720417373,
		2.16524156336129,
		2.14323224188809,
		2.53494236229903,
		2.37152741319696,
		2.25350873312775,
		2.20971207064729,
		2.50283096831281,
		2.40363041976238,
		2.36146629135327,
		2.38881841727521,
		2.44391232711768,
		2.47209756290784,
		2.47473356340005,
		2.46141134742693

};
float output[OUT_LEN];

int main()
{
	float Status;

	printf("\r\n--- Entering main() --- \r\n");

	/* Run the poll example for simple transfer */
	Status = axis_stream(input, output, output_ref);

	if (Status != XST_SUCCESS) {
		printf("XAxiDma_SimplePoll Example Failed\r\n");
		return XST_FAILURE;
	}

	printf("Successfully ran XAxiDma_SimplePoll Example\r\n");

	printf("--- Exiting main() --- \r\n");

	return XST_SUCCESS;

}



