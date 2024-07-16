module pc_src_mux (
  input PCSrc,
  input [4:0] PCPlus4,
  input [4:0] PCBranch,
  output [4:0] Result
);

 assign Result = PCSrc ? PCBranch : PCPlus4;
  
endmodule;
