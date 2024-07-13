module data_memory (
  input clk,
  input [4:0] A,
  input [31:0] WD,
  input WE,
  output reg [31:0] RD
);
  reg [31:0] Mem [31:0]; // temporário (substituir pelo módulo q manipula a memória DE DADOS)
  
  always @ (posedge clk) begin
    if (WE)
      Mem[A] <= WD; 
    else
      RD <= Mem[A];
  end
endmodule;
