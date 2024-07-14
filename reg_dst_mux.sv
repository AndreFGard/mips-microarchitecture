module reg_dst_mux(
  input RegDst,
  input [4:0] inst_20_16,
  input [4:0] inst_15_11,
  output [4:0] WriteReg
);

 assign WriteReg = RegDst ? inst_15_11 : inst_20_16;

endmodule;
