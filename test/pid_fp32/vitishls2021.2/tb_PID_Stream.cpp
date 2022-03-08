#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "PID_Stream.hpp"

float Kp = 1.431564041947107;
float Ki = 2.594812307124872;
float Kd = 0.100000000000000;
float SetPoint = 1;
float Time = 5;
float dt = 0.005;
float n = Time/dt;

int main(int argc, char** argv){

	float P[1001];
	float I[1001];
	float D[1001];
	float PID[1001];
	float X[1001];
	float E[1001];
	float inputs[11], outputs[6];

	for(int i=0;i<11;i++){
		inputs[i] = 0.0;
	}
	for(int i=0;i<6;i++){
		outputs[i] = 0.0;
	}

	for(int i=0;i<n+1;i++){
		P[i] = 0.0;
		I[i] = 0.0;
		D[i] = 0.0;
		PID[i] = 0.0;
		X[i] = 0.0;
		E[i] = 0.0;
	}

	for(int i=0;i<n;i++){

		inputs[0] = SetPoint;
		inputs[1] = dt;
		inputs[2] = X[i];
		inputs[3] = E[i];
		inputs[4] = P[i];
		inputs[5] = I[i];
		inputs[6] = D[i];
		inputs[7] = PID[i];
		inputs[8] = Kp;
		inputs[9] = Ki;
		inputs[10] = Kd;
		for(int i=0;i<11;i++){
			printf("inputs[%d]=%f\n", i, inputs[i]);
		}

	    PIDS(inputs, outputs);

		E[i+1] = outputs[0];
		P[i+1] = outputs[1];
		I[i+1] = outputs[2];
		D[i+1] = outputs[3];
		X[i+1] = outputs[4];
		PID[i+1] = outputs[5];
		for(int i=0;i<6;i++){
			printf("outputs[%d]=%f\n", i, outputs[i]);
		}
		getchar();
	}

	FILE *fid = fopen("data1.txt","w+");
	for(int i=0;i<n+1;i++){
		fprintf(fid, "%f\n", X[i]);
	}
	fclose(fid);

	return 0;
}
