module pcplus4(input [4:0]last_instr, output [4:0] next_instr);
  assign next_instr = last_instr + 4;
endmodule
