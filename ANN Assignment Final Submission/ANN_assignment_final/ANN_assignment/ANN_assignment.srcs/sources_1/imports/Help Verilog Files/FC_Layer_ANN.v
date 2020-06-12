`timescale 1ns / 1ns
module FC_Layer_ANN(
input_fc,weightCaches_fc, clk,start_FC,output_fc
);

parameter DATA_WIDTH = 32 ;
parameter num_fc_pe_rows=100;
parameter num_fc_pe_columns=32;
input [DATA_WIDTH-1:0] input_fc;
input start_FC, clk;
input  [(DATA_WIDTH*num_fc_pe_columns)-1:0] weightCaches_fc;
output [(num_fc_pe_columns*DATA_WIDTH )-1:0]output_fc;

genvar i;
generate 
	for (i=0; i < num_fc_pe_columns; i=i+1) 
	begin :PE 
	PE_FC_ANN PEs (
        .input_fc   (input_fc),
        .iweight_FC (weightCaches_fc[DATA_WIDTH*i+:DATA_WIDTH]),
        .clk(clk),.start_FC(start_FC),
        .output_fc(output_fc[DATA_WIDTH*i+:DATA_WIDTH])
	);
	end
endgenerate 

endmodule
