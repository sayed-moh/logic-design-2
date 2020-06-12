module fp_add (
input [31:0] A_FP, 
input [31:0] B_FP,
output reg [31:0] res);

//variables used in an always block
//are declared as registers
reg sign_a, sign_b,sign_c;
reg [7:0] e_A, e_B;
reg [23:0] fract_a, fract_b,fract_c;//frac = 1 . mantissa 
reg [7:0] shift_cnt;
reg cout;

always @ (A_FP or B_FP)
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
        
        /*
        while (shift_cnt)
        begin
            fract_a <= fract_a >> 1;
            e_A     <= e_A + 1;
            shift_cnt <= shift_cnt - 1;
        end
        */
    end 
    
	if (e_B < e_A)
    begin
		shift_cnt  = e_A - e_B;
    	fract_b  = fract_b >> shift_cnt;
	   e_B  = e_B + shift_cnt;
   end 
/*                
	while (shift_cnt)
	begin
		fract_b <= fract_b >> 1;
		e_B <= e_B + 1;
		shift_cnt <= shift_cnt - 1;
	end
*/
	//add fractions
	{cout, fract_c}  = fract_a + fract_b;
	//normalize result
	if (cout == 1)
	begin
		{cout, fract_c}  = {cout, fract_c} >> 1;
		e_B  = e_B + 1;
	end
	/*
	sign  = sign_a;
	exponent  = e_B;
	mantissa  = fract_c[22:0];
	*/
	res = {sign_a, e_B, fract_c[22:0]};
end
endmodule
