//Code by Shashank Shivashankar - 09/08/2020
//Testbench for rr.v 

`timescale 1ns/100ps

module rr_tb();
reg clk, rst, en;
reg [3:0] req;
wire [3:0] gnt;

rr_dut DUT(.clk(clk), .rst(rst), .en(en), .req(req), .gnt(gnt));

always #1 clk = ~clk;

initial
begin
clk = 0; rst = 1; en = 1; #8; 
rst = 0; #4; 
@(negedge clk) req = 4'b0001;
@(negedge clk) req = 4'b0010;
@(negedge clk) req = 4'b0100;
@(negedge clk) req = 4'b1000;
@(negedge clk) req = 4'b1111; #200;
@(negedge clk) req = 4'b1111; #200;
@(negedge clk) req = 4'b1111; #200;
@(negedge clk) req = 4'b1111; #200; 
$finish;
end
endmodule
