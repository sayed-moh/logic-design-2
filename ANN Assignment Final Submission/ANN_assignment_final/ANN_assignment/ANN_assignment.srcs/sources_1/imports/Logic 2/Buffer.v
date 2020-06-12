module Buffer(
input [(32*InpSize)-1:0] Yin,
input clk,
input enable,
input rst,
output reg [(32*InpSize)-1:0]Yout
);
parameter InpSize=1; //Declare number of inputs
integer i;
always @(posedge clk)
begin
	if(rst == 1'b1)
	begin
		for (i=0; i<32*InpSize; i=i+1)
		begin
			Yout[i]=32'b0;
		end
	end
	else
	begin
	    if(enable == 1'b1)
	    begin
            for (i=0; i<32*InpSize; i=i+1)
            begin
                Yout[i]=Yin[i];
            end
        end
	end
end
endmodule