`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2024 12:35:14
// Design Name: 
// Module Name: Fir_Filter_Tb1
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


module Fir_Filter_Tb1;
parameter N=16;
reg clk ,reset;
reg [N-1:0] data_in;
wire [N-1:0] data_out;

Fir_Filter inst0(clk,reset,data_in,data_out);

// input sin wave data
initial
$readmemb("signal.data",RAMM);

// create the RAM
reg [N-1:0] RAMM[31:0];

// create a clock
initial
clk=0;
always
#10 clk=~clk;

// read RAMM data and give to design

always@(posedge clk)
data_in <= RAMM[Address];

// Address Counter
reg[4:0] Address;
initial
Address = 1;
always@(posedge clk)
begin
    if(Address==31)
       Address=0;
     else
       Address = Address +1;
end

endmodule

   

