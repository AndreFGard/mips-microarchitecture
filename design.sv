module pcplus4(input [4:0]last_instr, output [4:0] next_instr);
  assign next_instr = last_instr + 4;
endmodule

module pcplus4(input [INSTRSIZE:0]last_instr, output [INSTRSIZE:0] next_instr);
  parameter INSTRSIZE = 3;
  assign next_instr = last_instr + INSTRSIZE;
endmodule

module pc_multiplexer(input [3:0] plus4_instr, input [3:0] branch, input use_branch, output [3:0] next_instr );

assign next_instr = (use_branch) ? branch : plus4_instr;
  
endmodule