`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2020 12:52:07 AM
// Design Name: 
// Module Name: PipeLined
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


module PipeLined();
parameter INPUT_WIDTH = 100;
parameter OUTPUT_WIDTH = 32;
//reg [31:0] input_FCs[INPUT_WIDTH-1:0];
//wire [31:0] output_FCs[OUTPUT_WIDTH-1:0];


parameter DATA_WIDTH = 32 ;
parameter num_fc_pe_rows_in=100;
parameter num_fc_pe_columns_in=32;

parameter num_fc_pe_columns_mid=10;

parameter num_fc_pe_columns_out=4;

parameter ADDR_WIDTH = 26 ;
reg clk;
reg start_fcIn;
wire readyIn;
reg [DATA_WIDTH-1:0] input_fc_x_in;
reg BInMidRst, BInMidEn;
wire [(num_fc_pe_columns_in*DATA_WIDTH )-1:0]output_fc_ys_relu_in;
wire [(num_fc_pe_columns_in*DATA_WIDTH )-1:0]output_fc_ys_relu_in_buf;

reg start_fcMid;
wire readyMid;
reg [DATA_WIDTH-1:0] input_fc_x_mid;
reg BMidOutRst, BMidOutEn;
wire [(num_fc_pe_columns_mid*DATA_WIDTH )-1:0]output_fc_ys_relu_mid;
wire [(num_fc_pe_columns_mid*DATA_WIDTH )-1:0]output_fc_ys_relu_mid_buf;

reg start_fcOut;
wire readyOut;
reg [DATA_WIDTH-1:0] input_fc_x_out;
reg BOutRst, BOutEn;
wire [(num_fc_pe_columns_out*DATA_WIDTH )-1:0]output_fc_ys_relu_out;
wire [(num_fc_pe_columns_out*DATA_WIDTH )-1:0]output_fc_ys_relu_mid_out;

SingleLayer
    #(
        .num_fc_pe_rows(100),
        .num_fc_pe_columns(32)
    ) LIn(
        .start_fc(start_fcIn),
        .clk(clk),
        .input_fc_x(input_fc_x_in),
        .ready(readyIn),
        .output_fc_ys_relu(output_fc_ys_relu_in)
        );
Buffer #(.InpSize(32)) BInMid(
        .Yin(output_fc_ys_relu_in),
        .clk(clk),
        .rst(BInMidRst),
        .enable(BInMidEn),
        .Yout(output_fc_ys_relu_in_buf)
        );
SingleLayer
    #(
        .num_fc_pe_rows(32),
        .num_fc_pe_columns(10)
    ) LMid(
        .start_fc(start_fcMid),
        .clk(clk),
        .input_fc_x(input_fc_x_mid),
        .ready(readyMid),
        .output_fc_ys_relu(output_fc_ys_relu_mid)
        );

Buffer #(.InpSize(10)) BMidOut(
    .Yin(output_fc_ys_relu_mid),
    .clk(clk),
    .rst(BMidOutRst),
    .enable(BMidOutEn),
    .Yout(output_fc_ys_relu_mid_buf)
    );
SingleLayer
    #(
        .num_fc_pe_rows(10),
        .num_fc_pe_columns(4)
    ) LOut(
        .start_fc(start_fcOut),
        .clk(clk),
        .input_fc_x(input_fc_x_out),
        .ready(readyOut),
        .output_fc_ys_relu(output_fc_ys_relu_out)
        );

Buffer #(.InpSize(10)) BOut(
    .Yin(output_fc_ys_relu_out),
    .clk(clk),
    .rst(BOutRst),
    .enable(BOutEn),
    .Yout(output_fc_ys_relu_out_buf)
    );
/*
SingleLayer
    #(
        .num_fc_pe_rows(10),
        .num_fc_pe_columns(4),
    ) LOut(
        .start_fc(start_fcIn),
        .clk(clk),
        .input_fc_x(input_fc_x_in),
        .ready(readyIn),
        .output_fc_ys_relu(output_fc_ys_relu_in)
        );
*/
endmodule
