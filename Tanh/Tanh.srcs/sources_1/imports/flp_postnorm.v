`timescale 1ns / 1ps
module flp_postnorm(
			input [24:0] mant_ext,
			input [7:0] exp,
			output [24:0] mant_ext_res,
			output [7:0] exp_res
			);

reg [4:0] shift;

always @(mant_ext)
begin
	casex (mant_ext)
		25'b1xxxxxxxxxxxxxxxxxxxxxxxx :	begin
													// mant_ext;
									 				shift = -5'd1;
								 			  	end
		25'b01xxxxxxxxxxxxxxxxxxxxxxx :	begin
													// mant_ext;
									 				shift = 5'd0;
								 			  	end
		25'b001xxxxxxxxxxxxxxxxxxxxxx : 	begin						
										 			// mant_ext << 1;
									 				shift = 5'd1;
								 			  	end

		25'b0001xxxxxxxxxxxxxxxxxxxxx : 	begin						
										 			// mant_ext << 2;
									 				shift = 5'd2;
								 				end

		25'b00001xxxxxxxxxxxxxxxxxxxx : 	begin 							
													// mant_ext << 3;
								 	 				shift = 5'd3;
								 				end

		25'b000001xxxxxxxxxxxxxxxxxxx : 	begin						
									 				// mant_ext << 4;
								 	 				shift = 5'd4;
								 				end

		25'b0000001xxxxxxxxxxxxxxxxxx : 	begin						
									 				// mant_ext << 5;
								 	 				shift = 5'd5;
								 				end

		25'b00000001xxxxxxxxxxxxxxxxx : 	begin						// 24'h020000
									 				// mant_ext << 6;
								 	 				shift = 5'd6;
								 				end

		25'b000000001xxxxxxxxxxxxxxxx : 	begin						// 24'h010000
									 				// mant_ext << 7;
								 	 				shift = 5'd7;
								 				end

		25'b0000000001xxxxxxxxxxxxxxx : 	begin						// 24'h008000
									 				// mant_ext << 8;
								 	 				shift = 5'd8;
								 				end

		25'b00000000001xxxxxxxxxxxxxx : 	begin						// 24'h004000
									 				// mant_ext << 9;
								 	 				shift = 5'd9;
								 				end

		25'b000000000001xxxxxxxxxxxxx : 	begin						// 24'h002000
									 				// mant_ext << 10;
								 	 				shift = 5'd10;
								 				end

		25'b0000000000001xxxxxxxxxxxx : 	begin						// 24'h001000
									 				// mant_ext << 11;
								 	 				shift = 5'd11;
								 				end

		25'b00000000000001xxxxxxxxxxx : 	begin						// 24'h000800
									 				// mant_ext << 12;
								 	 				shift = 5'd12;
								 				end

		25'b000000000000001xxxxxxxxxx : 	begin						// 24'h000400
									 				// mant_ext << 13;
								 	 				shift = 5'd13;
								 				end

		25'b0000000000000001xxxxxxxxx : 	begin						// 24'h000200
									 				// mant_ext << 14;
								 	 				shift = 5'd14;
								 				end

		25'b00000000000000001xxxxxxxx : 	begin						// 24'h000100
									 				// mant_ext << 15;
								 	 				shift = 5'd15;
								 				end

		25'b000000000000000001xxxxxxx : 	begin						// 24'h000080
									 				// mant_ext << 16;
								 	 				shift = 5'd16;
								 				end

		25'b0000000000000000001xxxxxx : 	begin						// 24'h000040
											 		// mant_ext << 17;
										 	 		shift = 5'd17;
												end

		25'b00000000000000000001xxxxx : 	begin						// 24'h000020
									 				// mant_ext << 18;
								 	 				shift = 5'd18;
								 				end

		25'b000000000000000000001xxxx : 	begin						// 24'h000010
									 				// mant_ext << 19;
								 	 				shift = 5'd19;
												end

		25'b0000000000000000000001xxx :		begin						// 24'h000008
									 				// mant_ext << 20;
								 					shift = 5'd20;
								 				end

		25'b00000000000000000000001xx : 	begin						// 24'h000004
									 				// mant_ext << 21;
								 	 				shift = 5'd21;
								 				end

		25'b000000000000000000000001x : 	begin						// 24'h000002
									 				// mant_ext << 22;
								 	 				shift = 5'd22;
								 				end

		25'b0000000000000000000000001 : 	begin						// 24'h000001
									 				// mant_ext << 23;
								 	 				shift = 5'd23;
								 				end
		25'b0000000000000000000000000 : 	begin						// 24'h000001
									 				// mant_ext << 23;
								 	 				shift = -5'd2;
								 				end
		default : 	begin
						// 25'b00;
						shift = 5'd0;
					end

	endcase
end
assign mant_ext_res = (shift == -5'd1) ? mant_ext >> 1 : mant_ext << shift;
assign exp_res = (shift == -5'd2) ? 8'b0 : ( (shift == -5'd1) ? exp + 1 : exp - shift);

endmodule