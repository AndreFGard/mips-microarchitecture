module pcplus4(
  input [INSTRSIZE:0]last_instr, 
  output [INSTRSIZE:0] next_instr
);
  parameter INSTRSIZE = 4;
  
  assign next_instr = last_instr + INSTRSIZE;

endmodule
