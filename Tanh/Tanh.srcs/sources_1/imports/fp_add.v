`timescale 1ns / 1ps
module fp_add (
input [31:0] A_FP, 
input [31:0] B_FP, 
output [31:0] res);

//variables used in an always block
//are declared as registers
reg sign_a, sign_b,sign_c;
reg [7:0] e_A, e_B, exponent;
reg[22:0] mantissa;
reg [23:0] fract_a, fract_b;//frac = 1 . mantissa
reg [24:0] fract_c;
wire [24:0] fract_d; 
wire [7:0] exp_res;
reg [7:0] shift_cnt;
reg cout;
reg sign;
reg is_sub;

always @ (A_FP, B_FP, exp_res, fract_d)
begin
	sign_a  = A_FP [31];
	sign_b  = B_FP [31];
	e_A      = A_FP [30:23];
	e_B      = B_FP [30:23];
	fract_a  = {1'b1,A_FP [22:0]};
	fract_b  = {1'b1,B_FP [22:0]};

	//align fractions
	if (e_A < e_B)
    begin
    
        shift_cnt  = e_B - e_A;
        fract_a   = fract_a >> shift_cnt;
        e_A       = e_A + shift_cnt; 
    end 
    
	if (e_B < e_A)
    begin
        shift_cnt  = e_A - e_B;
        fract_b  = fract_b >> shift_cnt;
        e_B  = e_B + shift_cnt;
   end 
   
	//add fractions
	if(sign_a == 1'b1 && sign_b == 1'b0)
	begin
		//a -ve
		fract_c = fract_b - fract_a;
		is_sub = 1'b1;
	end
	else if(sign_a == 1'b0 && sign_b == 1'b1)
	begin
		//b -ve
		fract_c = fract_a - fract_b;
        is_sub = 1'b1;
	end
	else
	begin
		//same sign, normal addition
		fract_c  = fract_a + fract_b;
        is_sub = 1'b0;
	end
	
	//carry
    cout = fract_c[24];
	
	if(is_sub == 1'b1)
	begin
	   sign = cout;
	   if(cout == 1'b1)
	       fract_c = -fract_c;
	       
	end
	else
	begin
	   sign = sign_a;
	end
	
	exponent  = exp_res;
	mantissa  = fract_d[22:0];
end

flp_postnorm normalizer(
    .mant_ext(fract_c),
    .exp(e_B),
    .mant_ext_res(fract_d),
    .exp_res(exp_res)
);

assign res = {sign, exponent, mantissa};
endmodule
