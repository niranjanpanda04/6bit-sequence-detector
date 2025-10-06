`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2025 10:00:28 AM
// Design Name: 
// Module Name: vt_sqd_tb
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


module vt_sqd_tb();
 
   
	reg     r_clk;
	reg     r_si;
	
	wire    w_qout_ov;
	wire    w_qout_nov;
	
	
    parameter     CP=10;
	
	
	vt_seq_detect_100110_ovl inst_0(
										.i_SI(r_si),
										.i_clk(r_clk),
										.o_f(w_qout_ov));
								  
	vt_seq_detect_100110_novl inst_1(
                                        .i_SI(r_si),
										.i_clk(r_clk),
										.o_f(w_qout_nov));
											
	initial $monitor($time,"\t %b \t %b \t %b \t %b",r_si,r_clk,w_qout_ov,w_qout_nov);
	//Clock Initialization
	initial begin
	    r_clk=1'b0;
	end
	//input signal
	always begin
	#(CP/2)    r_clk=~r_clk;
	end
	
	initial begin
					r_si=1'b1;
	#(CP+2)         r_si=1'b0;
	#CP       		r_si=1'b0;
	#CP      		r_si=1'b1;
	#CP           	r_si=1'b1;
	#CP           	r_si=1'b0;
	#CP;
	end	
	
	initial #(CP*8) $finish;
endmodule
