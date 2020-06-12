`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2020 08:12:59 AM
// Design Name: 
// Module Name: ANN
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
`timescale 1ns / 1ns


module SingleLayer(
        input start_fc,
        input clk,
        
        input [DATA_WIDTH-1:0] input_fc_x,
        //index,
        output reg ready,
        output reg [(num_fc_pe_columns*DATA_WIDTH )-1:0]output_fc_ys_relu
        
    );
parameter INPUT_WIDTH = 100;
parameter OUTPUT_WIDTH = 32;
//reg [31:0] input_FCs[INPUT_WIDTH-1:0];
//wire [31:0] output_FCs[OUTPUT_WIDTH-1:0];


parameter DATA_WIDTH = 32 ;
parameter num_fc_pe_rows=100;
parameter num_fc_pe_columns=32;

parameter ADDR_WIDTH = 26 ;

//input wire[ADDR_WIDTH-1:0] index; 

reg  [(DATA_WIDTH*num_fc_pe_columns)-1:0] weight_row;
wire [(num_fc_pe_columns*DATA_WIDTH )-1:0]output_fc_ys;
//wire [(num_fc_pe_columns*DATA_WIDTH )-1:0]output_fc_ys_relu;

reg [ADDR_WIDTH-1:0]          address_fc;
wire       read_en_MM_fc,enable_MM_out_fc;

wire [(DATA_WIDTH*num_fc_pe_columns-1):0]    dataMainMemo_fc;

/*
always
begin
    clk = 1;
    #5;
    clk = 0;
    #5;
end

initial
begin
    #4;
    read_en_MM_fc = 1'b1;
    enable_MM_out_fc = 1'b1;
    start_FC = 1'b1;
    address_fc = 26'b0;
    #5;
    #10
    weight_row = dataMainMemo_fc[(DATA_WIDTH*num_fc_pe_columns)-1:0];
    #10
    input_fc_x = dataMainMemo_fc[DATA_WIDTH-1:0];
    #30;
    start_FC = 1'b0;
    #40;
    $finish;
end
*/

assign {read_en_MM_fc,enable_MM_out_fc} = {1'b1, 1'b1};

always @(posedge clk)
begin
    if(start_FC == 1'b1)
    begin
        address_fc = 26'b0;
    end
    else
    begin
        if(address_fc == num_fc_pe_rows-1)
            ready = 1'b1;
        else
            ready = 1'b0;
        address_fc = address_fc + 1;
    end
    output_fc_ys_relu = output_fc_ys_relu_res;
end

FC_Layer_ANN #(.num_fc_pe_columns(32), .num_fc_pe_rows(100)) L1(
.input_fc(input_fc_x),
.weightCaches_fc(weight_row),
.clk(clk),
.start_FC(start_FC),
.output_fc(output_fc_ys)
);

Relu #(.InpSize(32)) r1(
    .Yin(output_fc_ys),
    .Yout(output_fc_ys_relu_res)
);

weights_fileReduced #(.ADDR_WIDTH(26), .fc_columns(32), .fc_rows(100)) mem1(
.clk(clk),
.address_fc(address_fc),
.read_en_MM_fc(read_en_MM_fc) ,
.dataMainMemo_fc(dataMainMemo_fc),
.enable_MM_out_fc(enable_MM_out_fc)
);

/*
FC_Layer_ANN #(.num_fc_pe_columns(10), .num_fc_pe_rows(32)) L2(
.input_fc(input_fc_x),
.weightCaches_fc(weight_row),
.clk(clk),
.start_FC(start_FC),
.output_fc(output_fc_ys)
);

weights_fileReduced #(.ADDR_WIDTH(26), .fc_columns(10), .fc_rows(32)) mem2(
.clk(clk),
.address_fc(address_fc),
.read_en_MM_fc(read_en_MM_fc) ,
.dataMainMemo_fc(dataMainMemo_fc),
.enable_MM_out_fc(enable_MM_out_fc)
);


FC_Layer_ANN #(.num_fc_pe_columns(4), .num_fc_pe_rows(10)) L3(
.input_fc(input_fc_x),
.weightCaches_fc(weight_row),
.clk(clk),
.start_FC(start_FC),
.output_fc(output_fc_ys)
);

weights_fileReduced #(.ADDR_WIDTH(26), .fc_columns(4), .fc_rows(10)) mem3(
.clk(clk),
.address_fc(address_fc),
.read_en_MM_fc(read_en_MM_fc) ,
.dataMainMemo_fc(dataMainMemo_fc),
.enable_MM_out_fc(enable_MM_out_fc)
);
*/

endmodule
