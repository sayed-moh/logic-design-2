`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2020 07:31:22 AM
// Design Name: 
// Module Name: PE_FC_ANN_tb
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

`timescale 1ns/1ps

module PE_FC_ANN_tb;

parameter DATA_WIDTH = 32;
reg [DATA_WIDTH-1:0]       input_fc ;
reg [DATA_WIDTH-1:0]      iweight_FC; 
reg     clk,start_FC;
wire [DATA_WIDTH-1:0] output_fc ;

always
begin
    clk = 1;
    #5;
    clk = 0;
    #5;
end
initial
begin
   #0 start_FC = 1'b1;
   #20 start_FC = 1'b0;
   
   #20 input_fc = 32'h40000000;
   iweight_FC = 31'h40000000;
   #10;
   
end

PE_FC_ANN pe1(
.input_fc(input_fc),
.iweight_FC(iweight_FC),
.clk(clk),
.start_FC(start_FC),
.output_fc(output_fc)
);
endmodule