`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2025 10:18:22 AM
// Design Name: 
// Module Name: vt_seq_detect_100110_novl
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


module vt_seq_detect_100110_novl(
							i_SI,
							i_clk,
							o_f);
	input					i_clk,i_SI;
	output	reg				o_f;
	
	reg[3:0]						next_state;
	reg[3:0]						present_state;
	
	`define r 4'b0000
	`define s0 4'b0001
	`define s1 4'b0010
	`define s3 4'b0100
	`define s4 4'b1000
	`define s5 4'b1001
	`define s6 4'b1010
	`define s7 4'b1011
	`define s8 4'b1100
	`define s9 4'b1101
	`define s10 4'b1110
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
			`r: next_state = i_SI ? `s1 : `s0;
			`s0 : next_state = `s3;
			`s1 : next_state = i_SI ? `s3 : `s4;
			`s3 : next_state = `s5;
			`s4 : next_state = i_SI ? `s5 : `s6;
			`s5 : next_state = `s7;
			`s6 : next_state = i_SI ? `s8 : `s7;
			`s7 : next_state = `s9;
			`s8 : next_state = i_SI ? `s10 : `s9;
			`s9 : next_state = `r;
			`s10 : next_state = `r;
		endcase
	end
	always@(present_state or i_SI)begin
		if(present_state == `s10 && i_SI == 0)
			o_f = 1'b1;
		else
			o_f = 1'b0;
	end
endmodule

