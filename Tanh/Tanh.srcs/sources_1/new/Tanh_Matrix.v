`timescale 1ns / 1ps
module Tanh_Matrix(
input [(32*InpSize)-1:0] Yin,
input clk,
output [(32*InpSize)-1:0]Yout
);
parameter InpSize=64; //Declare number of inputs
genvar i;
generate //for generate to call the number of input sizes in the tanh module to get n output as n = number of inputss
	for (i=0; i < InpSize; i=i+1) 
	begin 
	Tanh T1(
    .X(Yin[32*i+31:32*i]),
    .Clk(clk),
    .OUT(Yout[32*i+31:32*i])
    );
	end
endgenerate 
endmodule
