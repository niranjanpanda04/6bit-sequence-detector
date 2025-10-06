`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2025 09:58:37 AM
// Design Name: 
// Module Name: vt_seq_detect_100110_ovl
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


module vt_seq_detect_100110_ovl(
							i_SI,
							i_clk,
							o_f);
	input					i_clk,i_SI;
	output	reg				o_f;
	
	reg[2:0]						next_state;
	reg[2:0]						present_state;
	
	`define r 3'b000
	`define s0 3'b001
	`define s1 3'b011
	`define s2 3'b010
	`define s3 3'b110
	`define s4 3'b111
	initial begin
			present_state = `r;
			next_state =    `r;
			end
	always@(posedge i_clk)begin
			present_state <= next_state;
			end
	//next_state evaluation
	always@(present_state or i_SI)begin
		case(present_state)
			`r: next_state = i_SI ? `s0 : `r;
			`s0: next_state = i_SI ? `s0 : `s1;
			`s1: next_state = i_SI ? `s0 : `s2;				
			`s2: next_state = i_SI ? `s3 : `r;
			`s3: next_state = i_SI ? `s4 : `s1;
			`s4: next_state = i_SI ? `s0 : `s1;
		endcase
	end
	always@(*)begin
		if(present_state == `s4 && i_SI == 0)
			o_f = 1'b1;
		else
			o_f = 1'b0;
	end
endmodule
