module Sign_Extend(
  input [15:0] instr,
  output reg [31:0] SignImm
);
  
  always @* begin
    if (instr[15] == 1'b0)
      SignImm = {16'b0, instr}; 
    else
      SignImm = {16'b1111111111111111, instr};
  end
  
endmodule;
