module weights_fileReduced (clk,address_fc,read_en_MM_fc ,dataMainMemo_fc,enable_MM_out_fc) ;
parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 26 ;
parameter fc_columns=64;
parameter fc_rows    = 16;
parameter tot_weight_size=fc_rows*fc_columns;
input clk;
input [ADDR_WIDTH-1:0]          address_fc;
input       read_en_MM_fc,enable_MM_out_fc;
output  reg [(DATA_WIDTH*fc_columns-1):0]    dataMainMemo_fc;

parameter file = "D:/Logic 2/assignment 2/Logic 2 ANN Assignment Help Material -20200413T094012Z-001/Logic 2 ANN Assignment Help Material/Weight Files/weights1_converted.txt";
   
reg signed	[DATA_WIDTH-1:0] mem [0:tot_weight_size-1] ;
integer k;    

always @(negedge clk )
begin
    for(k=0;k < fc_columns;k=k+1)
    begin
        if (enable_MM_out_fc)
             dataMainMemo_fc[k*DATA_WIDTH+:DATA_WIDTH] <= read_en_MM_fc ? mem[address_fc*fc_columns+k] : 32'b0;
        else 
             dataMainMemo_fc[k*DATA_WIDTH+:DATA_WIDTH]<=32'bZ;
    end
end
initial begin
  $readmemh(file, mem); // memory_list is memory file
end

endmodule 
