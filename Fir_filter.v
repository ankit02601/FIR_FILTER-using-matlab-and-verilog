`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2024 12:01:11
// Design Name: 
// Module Name: Fir_Filter
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


module Fir_Filter( clk,reset,data_in,data_out);

parameter N=16;
input clk,reset;
input[N-1:0] data_in;
output reg [N-1:0] data_out;

// coefficients defination
// Moving Average Filter,7th order
// 8th coefficients; 1/(order+1) =1/8 =0.125
// 0.125*256(scaling Factor) =32=6'b100000

wire[5:0] c0 =6'b100000;
wire[5:0] c1 =6'b100000;
wire[5:0] c2 =6'b100000;
wire[5:0] c3 =6'b100000;
wire[5:0] c4 =6'b100000;
wire[5:0] c5 =6'b100000;
wire[5:0] c6 =6'b100000;
wire[5:0] c7 =6'b100000;

wire [N-1:0] x1,x2,x3,x4,x5,x6,x7;



// Creating delays like x[n-1] ,x[n-2] ,...,x[n-N]
//instantiate D flip flop
DFF Dff0(clk,0,data_in,x1); //x[n-1]
DFF Dff1(clk,0,x1,x2);
DFF Dff2(clk,0,x2,x3);
DFF Dff3(clk,0,x3,x4);
DFF Dff4(clk,0,x4,x5);
DFF Dff5(clk,0,x5,x6);
DFF Dff6(clk,0,x6,x7);





//Multiplication of coefficients and delay
wire [N-1:0] Mul0,Mul1,Mul2,Mul3,Mul4,Mul5,Mul6,Mul7;
assign Mul0 =data_in*c0;
assign Mul1 =x1*c1;
assign Mul2 =x2*c2;
assign Mul3 =x3*c3;
assign Mul4 =x4*c4;
assign Mul5 =x5*c5;
assign Mul6 =x6*c6;
assign Mul7 =x7*c7;




// Addition of all multiplication
wire [N-1:0] Add_final;
assign Add_final=Mul0 + Mul1 + Mul2+Mul3+Mul4+Mul5+Mul6+Mul7;

// Final CalCulation To output
always@(posedge clk)
data_out<=Add_final;
   
endmodule

// Dflip-flop for creating delay
module DFF(clk,reset,data_in,data_delayed);
parameter N=16;
input clk,reset;
input[N-1:0] data_in;
output reg [N-1:0] data_delayed;

always@(posedge clk, posedge reset)
begin
if(reset)
data_delayed<=0;
else
data_delayed<= data_in;
end
endmodule

