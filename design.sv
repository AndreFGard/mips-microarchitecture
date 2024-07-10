module pcplus4(input [INSTRSIZE:0]last_instr, output [INSTRSIZE:0] next_instr);
  parameter INSTRSIZE = 4;
  assign next_instr = last_instr + INSTRSIZE;
endmodule


module pc_multiplexer(input [4:0] plus4_instr, input [4:0] branch, input use_branch, output [4:0] next_instr );

assign next_instr = (use_branch) ? branch : plus4_instr;
  
endmodule


module pc(input [4:0] next_instr, input clk, output reg [4:0] curr_instr );
  always @(posedge clk) begin
    curr_instr = next_instr;
  end
endmodule