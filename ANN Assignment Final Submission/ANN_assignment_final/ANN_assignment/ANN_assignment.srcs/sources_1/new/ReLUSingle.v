`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2020 12:12:00 AM
// Design Name: 
// Module Name: ReLUSingle
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


module ReLUSingle(
    input [31:0] Yin,
    output reg [31:0] Yout
    );
    
always @(Yin)
begin
    if(Yin[31] == 1'b0)
    begin
        Yout = Yin;
    end
    else
    begin
        Yout = 32'b0;
    end
end
endmodule
