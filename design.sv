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


module ALU_decoder(input [1:0] aluop, input [5:0] funct, output [2:0] aluControl);
  parameter ADD = 3'b010; parameter SUBT = 3'b110; parameter AND = 3'b000; parameter OR = 3'b001; parameter SETLESSTHAN = 3'b111;
  parameter FADD = 6'b100000; parameter FSUBT =6'b100010; parameter FAND =6'b100100; parameter FOR =  6'b100101; parameter FSLT = 6'b101010;
  assign aluControl = (aluop == 2'b00) ? (ADD) : 
                      (aluop == 2'b01) ? (SUBT) :   
                            (funct == FADD ) ? (ADD):
                            (funct == FSUBT ) ? (SUBT):
                            (funct == FOR ) ? (OR) :
                            (funct == FAND) ? (AND) : 
                            (funct == FSLT ) ? (SETLESSTHAN):
                            3'b000;
         
endmodule

module ALU(input [2:0] aluControl, input [31:0] srcA, input [31:0] srcB, output zero, output [31:0] aluResult );
  parameter ADD = 3'b010; parameter SUBT = 3'b110; parameter AND = 3'b000; parameter OR = 3'b001; parameter SETLESSTHAN = 3'b111;
  assign aluResult = (aluControl == ADD) ? (srcA + srcB): 
                     (aluControl == SUBT) ? (srcA - srcB): 
                     (aluControl == AND) ? (srcA && srcB): 
                     (aluControl == OR) ? (srcA || srcB): 
                     (aluControl == SETLESSTHAN) ? (srcA < srcB): 32'd0;
  assign zero = (aluResult == 0) ? 1 : 0;
endmodule