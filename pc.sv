module pc(
  input [4:0] next_instr, 
  input clk, 
  output reg [4:0] curr_instr 
);
  initial curr_instr = 0;

  always @(posedge clk) begin
    curr_instr = next_instr;
  end

endmodule