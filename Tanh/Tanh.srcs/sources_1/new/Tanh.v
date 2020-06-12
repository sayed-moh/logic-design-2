`timescale 1ns / 1ps
module Tanh(
     X,Clk,OUT
    );
    parameter DATA_WIDTH = 32 ; // full or half percision
    input [(DATA_WIDTH-1):0] X; //input
    input Clk;
    output reg[(DATA_WIDTH-1):0] OUT ;//Tanh X
    wire[(DATA_WIDTH-1):0] mul_res_fc;//storage of the multiplication
    wire[(DATA_WIDTH-1):0] add_res_fc;//storage of the addition
       
    integer i=0; //check cases
    integer j;//check which case
    integer z;//counter of clocks
    reg [(DATA_WIDTH-1):0]var1;
    reg [(DATA_WIDTH-1):0]temp1;//first parameter in addition
    reg [(DATA_WIDTH-1):0]temp2;//second parameter in addition
    reg [(DATA_WIDTH-1):0]MUL1;//first parameter of multiplication
    reg [(DATA_WIDTH-1):0]MUL2;//second parameter of multiplication
    reg [(DATA_WIDTH-1):0] First   = 32'b10111110101010101010101010101011;//(1/3)first constant
    reg [(DATA_WIDTH-1):0] Second  = 32'b00111110000010001000100010001001;//(2/15)second constant
    reg [(DATA_WIDTH-1):0] Third   = 32'b10111101010111010000110111010001;//(17/315)third constant 
  
         
    initial
    begin//initialization for integers
        z=0;
        i=0;
        j=0;
    end
    
    always@(posedge Clk)
begin       
            if(j==0)
                begin
                    if(i==0)
                    begin
                        MUL1=X;
                        MUL2=X;
                        i=i+1;
                    end
                    else if(i==1)
                    begin
                        MUL1=mul_res_fc;
                        MUL2=X;
                        i=i+1;
                    end
                  else if(i==2)
                    begin
                        var1=mul_res_fc;
                        MUL1=mul_res_fc;
                        MUL2=First;
                        i=i+1;
                    end
                   else if(i==3)
                    begin
                        temp1=mul_res_fc;
                        temp2=X;
                        j=j+1;
                        i=0;
                        
                    end 
                        
                end
//////////////////////////////////////////////////////////////////////////////two terms (adding x with -(1/3)*x^3)
                else if(j==1)
                begin
                      if(i==0)
                   begin
                       MUL1=var1;
                       MUL2=X;
                       i=i+1;
                   end
                    else if(i==1)
                      begin
                          MUL1=mul_res_fc;
                          MUL2=X;
                          i=i+1;
                      end
                   else if(i==2)
                     begin
                         var1=mul_res_fc;
                         MUL1=mul_res_fc;
                         MUL2=Second;
                         i=i+1;
                     end
                      else if(i==3)
                        begin
                            temp1=mul_res_fc;
                            temp2=add_res_fc;
                            j=j+1;
                            i=0;
                        end
                end
/////////////////////////////////////////////////////////////////////////three terms
                else if(j==2)
                begin
                        if(i==0)
                         begin
                             MUL1=var1;
                             MUL2=X;
                             i=i+1;
                         end
                       else if(i==1)
                            begin
                                MUL1=mul_res_fc;
                                MUL2=X;
                                i=i+1;
                            end
                          else if(i==2)
                           begin
                               MUL1=mul_res_fc;
                               MUL2=Third;
                               i=i+1;
                           end
                         else if(i==3)
                          begin
                              temp1=mul_res_fc;
                              temp2=add_res_fc;
                              i=i+1;
                          end
                          else if(i==4)
                          begin  
                                  j=0;
                                  i=0;
                            end
    end
end
   always@(posedge Clk)//four terms but checking if the input > 1 it will give output 1
   begin
        if(z==12)
            begin
                if(add_res_fc[30:23]>8'b01111110 )
                            begin
                                if(add_res_fc[31]==1'b1)
                                    begin
                                        OUT=32'b00111111100000000000000000000000;
                                    end
                                else
                                    begin
                                        OUT=32'b10111111100000000000000000000000;
                                    end
                            end
                    else if(add_res_fc[30:23]==8'b01111110 && add_res_fc[22:0]>23'b10001001001101110100110 )
                        begin
                            if(add_res_fc[31]==1'b1)
                                begin
                                    OUT=32'b00111111100000000000000000000000;
                                end
                            else
                                begin
                                    OUT=32'b10111111100000000000000000000000;
                                end
                        end
                            else
                                begin
                                    OUT= add_res_fc;
                                end
                       z=0;   
            end
   else
       begin
           z=z+1; 
       end
    end
/////////////////////////////////////////////////////////////////
 fp_mul inst1 (
.flp_a(MUL1),
.flp_b(MUL2),
.flp_res(mul_res_fc)
); 
fp_add add1 (
.A_FP(temp1),
.B_FP(temp2),
.res(add_res_fc)
);
     
endmodule
