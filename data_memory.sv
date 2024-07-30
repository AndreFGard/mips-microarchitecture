module data_memory (
  input clk,
  input [31:0] A,
  input [31:0] WD,
  input WE,
  output reg [31:0] RD
);
  reg [31:0] Mem [31:0];

  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) 
      Mem[i] = 32'd0;
  end
  
  always @ (posedge clk) begin
    if (WE)
      Mem[A] <= WD; 
    else
      RD <= Mem[A];
  end
endmodule;
