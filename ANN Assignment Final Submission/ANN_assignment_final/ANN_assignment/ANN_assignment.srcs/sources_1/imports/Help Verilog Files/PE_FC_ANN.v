module PE_FC_ANN 
( input_fc,iweight_FC,clk,start_FC,output_fc
 );
parameter DATA_WIDTH = 32;
input [DATA_WIDTH-1:0]       input_fc ;
input [DATA_WIDTH-1:0]      iweight_FC; 
input     clk ,start_FC;
output reg[DATA_WIDTH-1:0] output_fc ;

wire[DATA_WIDTH-1:0] mul_res_fc;
wire[DATA_WIDTH-1:0] add_res_fc;

always@(posedge clk)
begin

	if (start_FC==1) 
			output_fc=32'h00000000;
	// Sequential MAC Units >>> Very Slow !
	// TODO1       : Convert to  Parallel MAC Units 
	// TODO2       : Do Single Precision Multiply and Single Precision Addition
	// COMPETITION1: Do two implementations to get the maximum scores  
	//               score1 = 80/#Cycles + 20/(#LUTs) + 10/(# of Slice Registers)  
	//               score2 = 20/#Cycles + 80/(#LUTs) + 40/(# of Slice Registers)  
	else 
		output_fc <=  add_res_fc;

end

fp_mul mul1 (
.flp_a(input_fc),
.flp_b(iweight_FC),
.flp_res(mul_res_fc)
);

fp_add add1 (
.A_FP(mul_res_fc),
.B_FP(output_fc),
.res(add_res_fc)
);
endmodule