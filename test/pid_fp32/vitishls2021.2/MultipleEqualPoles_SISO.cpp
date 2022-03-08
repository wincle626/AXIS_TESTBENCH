#include "MultipleEqualPoles_SISO.hpp"

void MEP(float setpoint, float dt, float &prevX,
         float &prevE, float &prevP, float &prevI, float &prevD, float &prevPID,
         float Kp, float Ki, float Kd){
#pragma HLS inline off

    float currPID = 0.0;
    PID(setpoint, dt, prevX,
         prevE, prevP, prevI, prevD,
         Kp, Ki, Kd, currPID);
    float X_Dot = -1*prevX + prevPID;
    prevX = prevX + X_Dot*dt;
    prevPID = currPID;

}
