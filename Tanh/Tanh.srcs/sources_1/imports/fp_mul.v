`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2020 04:21:16 PM
// Design Name: 
// Module Name: FLP_Mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fp_mul(
    input wire [31:0] flp_a,
    input wire [31:0] flp_b,
    output reg [31:0] flp_res
    );

reg[47:0] mant_mul;

reg sign;
reg[8:0] sum_exp;
reg [22:0] mantis;

always @(flp_a or flp_b)
begin
    sign = flp_a[31] ^ flp_b[31];
    
    
    
    mant_mul = {1'b1,flp_a[22:0]} * {1'b1,flp_b[22:0]};
    
    sum_exp = flp_a[30:23] + flp_b[30:23] - 8'd127;
    //normalization:
    
    
    if(mant_mul[47] == 1)
    begin
        sum_exp = sum_exp + 1;
		mantis = mant_mul[46:24];
    end
	else
	begin
		mantis = mant_mul[45:23];
	end
    
    
    flp_res = {sign, sum_exp[7:0], mantis};
end
    
endmodule
