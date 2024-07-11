module register_file(a1, a2, a3, WD3, WE3, clk, RD1, RD2);

  input [4:0] a1; // data source
  input [4:0] a2; // data source
  
  input [4:0] a3; // write
  input [31:0] WD3; // write data
  
  input WE3; // write enable 
  input clk;
 
  output [31:0] RD1,RD2; // read data
 
  integer i;
  reg [31:0] registers [0:31];
  
  assign RD1 = (a1==0) ? 32'd0 : registers[a1];
  assign RD2 = (a2==0) ? 32'd0 : registers[a2];
  
  initial begin
    for(i=0; i<32; i=i+1) 
     registers[i] <= 32'd0;
  end
  
  always @(posedge clk) begin
    if (WE3) begin
      registers[a3] <= (a3==0) ? 32'd0 : WD3;
    end
  end
 
endmodule
