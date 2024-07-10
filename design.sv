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


module ALU(input [31:0] a, input [31:0] b, input [1:0] aluop, output [31:0] aluResult);
assign aluResult = (aluop == 2'b00) ? (a + b) : 
                (aluop == 2'b01) ? (a - b) :   
  				(aluop == 2'b10) ? (a & b) :   // TODO CODE THIS LATER (look at funct and ALUCONTROL)
                (aluop == 2'b11) ? (a | b) :  
                4'b0000;                       

endmodule