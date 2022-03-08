#include "PID_Stream.hpp"

void PIDS(float inputs[11], float outputs[6]){
#pragma HLS inline off
#pragma HLS INTERFACE axis port=inputs
#pragma HLS INTERFACE axis port=outputs

	float inputfifo[11],outputfifo[6];

	int i;
	for(i=0;i<11;i++){
		inputfifo[i] = inputs[i];
	}

	float setpoint = inputfifo[0];
	float dt = inputfifo[1];
	float X = inputfifo[2];
	float E = inputfifo[3];
	float P = inputfifo[4];
	float I = inputfifo[5];
	float D = inputfifo[6];
	float PID = inputfifo[7];
	float Kp = inputfifo[8];
	float Ki = inputfifo[9];
	float Kd = inputfifo[10];
	MEP(setpoint, dt, X,
		 E, P, I, D, PID,
		 Kp, Ki, Kd);
	outputfifo[0] = E;
	outputfifo[1] = P;
	outputfifo[2] = I;
	outputfifo[3] = D;
	outputfifo[4] = X;
	outputfifo[5] = PID;

	for(i=0;i<6;i++){
		outputs[i] = outputfifo[i];
	}

}
