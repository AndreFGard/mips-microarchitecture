module alu_scr_mux(
  input ALUSrc,
  input [31:0] RD2,
  input [31:0] SignImm,
  output [31:0] SrcB
);

 assign SrcB = ALUSrc ? SignImm : RD2;

endmodule;
