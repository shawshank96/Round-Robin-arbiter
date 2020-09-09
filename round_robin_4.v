//Code by Shashank Shivashankar - 09/08/2020
//4 requestor Round robin arbiter 
//Clks   0 - 100: 0>1>2>3
//Clks 100 - 200: 1>2>3>0
//Clks 200 - 300: 2>3>0>1
//Clks 300 - 400: 3>0>1>2

module rr_dut(clk, rst, en, req, gnt);
input clk, rst, en;
input [3:0] req;
output [3:0] gnt; 

reg [3:0] gnt; 

integer cnt = 0;

always@(posedge clk)
begin
//If design is Reset then grant and the counter is reset; 
  if(rst)
  begin
    gnt <= 4'b0000; 
    cnt = 0; 
  end
  else
  begin
    if(en)
    begin
//If Reset is inactive; Enable is active check for counter: if greater than 400 reset counter 
      if(cnt > 400)
        cnt = 0;
      else
      begin

        cnt = cnt + 1; 

//Requestor 0 has highest priority
        if(cnt >= 0 && cnt < 100)
        begin
          if(req[0] == 1'b1)
            gnt <= 4'b0001;
          else if(req[1:0] == 2'b10)
            gnt <= 4'b0010; 
          else if(req[2:0] == 3'b100)
            gnt <= 4'b0100;
          else if(req[3:0] == 4'b1000)
            gnt <= 4'b1000; 
        end
//Requestor 1 has highest priority
        else if(cnt >= 100 && cnt < 200)
        begin
          if(req[1] == 1'b1)
            gnt <= 4'b0010;
          else if(req[2:1] == 2'b10)
            gnt <= 4'b0100; 
          else if(req[3:1] == 3'b100)
            gnt <= 4'b1000;
          else if(req[3:0] == 4'b0001)
            gnt <= 4'b0001;
        end
//Requestor 2 has highest priority
        else if(cnt >= 200 && cnt < 300)
        begin
          if(req[2] == 1'b1)
            gnt <= 4'b0100;
          else if(req[3:2] == 2'b10)
            gnt <= 4'b1000; 
          else if(req[3:2] == 2'b00 && req[0] == 1)
            gnt <= 4'b0001;
          else if(req[3:0] == 4'b0010)
            gnt <= 4'b0010;
        end
//Requestor 3 has highest priority
        else if(cnt >= 300 && cnt < 400)
        begin
          if(req[3] == 1'b1)
            gnt <= 4'b1000;
          else if(req[3] == 1'b0 && req[0] == 1'b1)
            gnt <= 4'b0001; 
          else if(req[3] == 1'b0 && req[0] == 1'b0 && req[1] == 1'b1)
            gnt <= 4'b0010;
          else if(req[3:0] == 4'b0100)
            gnt <= 4'b0100;
        end
      end
     
    end
//If Reset & enable are both inactive save the state of the counter
    else 
    begin
      cnt = cnt; 
    end
  end
end
endmodule
