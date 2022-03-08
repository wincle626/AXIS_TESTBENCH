#include "PID.hpp"

void PID(float setpoint, float dt, float prevX,
         float &prevE, float &prevP, float &prevI, float &prevD,
         float Kp, float Ki, float Kd, float &PID){
#pragma HLS inline off
    // Update error
    float currE = setpoint - prevX;
    // Calculate proportional, derivative, and integration terms
    float currP = currE;                    // error of proportional term
    float currI = currE*dt + prevI;         // integration of the error
    float currD = (currE-prevE)/dt;         // derivative of the error
    // PID control output C(s)=Kp+Ki/s+Kd*s
    PID = Kp*currP+Ki*currI+Kd*currD;   // the three PID terms
    // Update intermediate terms
    prevE = currE;
    prevP = currP;
    prevI = currI;
    prevD = currD;

}
