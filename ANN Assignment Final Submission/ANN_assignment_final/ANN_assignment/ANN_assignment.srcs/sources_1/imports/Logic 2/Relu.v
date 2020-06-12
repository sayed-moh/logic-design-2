`timescale 1ns / 1ps
module Relu(
input [(32*InpSize)-1:0] Yin,
output reg [(32*InpSize)-1:0]Yout
);
parameter InpSize=1; //Declare number of inputs
integer i;
integer j;
always @(*)
begin
for (i=(32*InpSize)-1; i>=0; i=i-32)
begin
if(Yin[i]==0)
begin
Yout[i]=Yin[i];
for (j=i-1; j>i-32; j=j-1)
begin
Yout[j]=Yin[j];
end
end
else
begin
for (j=i; j>i-31; j=j-1)
begin
Yout[j]=0;
end
end
end
end
endmodule

