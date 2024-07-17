module data_memory (
  input clk,
  input [4:0] A,
  input [31:0] WD,
  input WE,
  output reg [31:0] RD
);
  reg [31:0] Mem [31:0];
  
  always @ (posedge clk) begin
    if (WE)
      Mem[A] <= WD; 
    else
      RD <= Mem[A];
  end
endmodule;
module reg_dst_mux(
  input RegDst,
  input [4:0] inst_20_16,
  input [4:0] inst_15_11,
  output [4:0] WriteReg
);

 assign WriteReg = RegDst ? inst_15_11 : inst_20_16;

endmodule;
module pc_src_mux (
  input PCSrc,
  input [4:0] PCPlus4,
  input [4:0] PCBranch,
  output [4:0] Result
);

 assign Result = PCSrc ? PCBranch : PCPlus4;
  
endmodule;
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
module pcplus4(
  input [INSTRSIZE:0]last_instr, 
  output [INSTRSIZE:0] next_instr
);
  parameter INSTRSIZE = 4;
  
  assign next_instr = last_instr + INSTRSIZE;

endmodule


module pc_multiplexer(
  input [4:0] plus4_instr, 
  input [4:0] branch, 
  input use_branch, 
  output [4:0] next_instr 
);

  assign next_instr = (use_branch) ? branch : plus4_instr;
endmodule


module pc(
  input [4:0] next_instr, 
  input clk, 
  output reg [4:0] curr_instr 
);

  always @(posedge clk) begin
    curr_instr = next_instr;
  end

endmodule


module ALU_decoder(
  input [1:0] aluop, 
  input [5:0] funct, 
  output [2:0] aluControl
);

  parameter ADD = 3'b010; 
  parameter SUBT = 3'b110; 
  parameter AND = 3'b000; 
  parameter OR = 3'b001; 
  parameter SETLESSTHAN = 3'b111;
  
  parameter FADD = 6'b100000; 
  parameter FSUBT = 6'b100010; 
  parameter FAND = 6'b100100; 
  parameter FOR = 6'b100101; 
  parameter FSLT = 6'b101010;
  
  assign aluControl = (aluop == 2'b00) ? (ADD) : 
                      (aluop == 2'b01) ? (SUBT) :   
                            (funct == FADD ) ? (ADD):
                            (funct == FSUBT ) ? (SUBT):
                            (funct == FOR ) ? (OR) :
                            (funct == FAND) ? (AND) : 
                            (funct == FSLT ) ? (SETLESSTHAN):
                            3'b000;
         
endmodule

module ALU(
  input [2:0] aluControl, 
  input [31:0] srcA, 
  input [31:0] srcB, 
  output zero, 
  output [31:0] aluResult 
);

  parameter ADD = 3'b010; 
  parameter SUBT = 3'b110; 
  parameter AND = 3'b000; 
  parameter OR = 3'b001; 
  parameter SETLESSTHAN = 3'b111;
  
  assign aluResult = (aluControl == ADD) ? (srcA + srcB): 
                     (aluControl == SUBT) ? (srcA - srcB): 
                     (aluControl == AND) ? (srcA && srcB): 
                     (aluControl == OR) ? (srcA || srcB): 
                     (aluControl == SETLESSTHAN) ? (srcA < srcB): 32'd0;
  
  assign zero = (aluResult == 0) ? 1 : 0;
  
endmodule
module instruction_memory(
  	input [4:0] A,        
    output reg [31:0] RD       
);
 	  reg [7:0] memoria [31:0];  // Declaração da memória de instruções

    initial begin
        memoria[0] = 8'b00100000;  // addi $a0, $zero, 10
        memoria[1] = 8'b00000010;  // 00000010
        memoria[2] = 8'b00000000;  // 00000000
        memoria[3] = 8'b00001010;  // 00001010
        
        memoria[4] = 8'b00100000;  // addi $t0, $zero, 1
        memoria[5] = 8'b00000100;  // 00000100
        memoria[6] = 8'b00000000;  // 00000000
        memoria[7] = 8'b00000001;  // 00000001
        
        memoria[8]  = 8'b00010001; // beq $t0, $a0, 3
        memoria[9]  = 8'b00000100; // 00000100
        memoria[10] = 8'b00000000; // 00000000
        memoria[11] = 8'b00000011; // 00000011
        
        memoria[12] = 8'b00100001; // addi $t0, $t0, 1
        memoria[13] = 8'b00001000; // 00001000
        memoria[14] = 8'b00000000; // 00000000
        memoria[15] = 8'b00000001; // 00000001
        
        memoria[16] = 8'b00001000; // j loop
        memoria[17] = 8'b00000000; // 00000000
        memoria[18] = 8'b00000000; // 00000000
        memoria[19] = 8'b00000001; // 00000001
        
        memoria[20] = 8'b00000000; // nop
        memoria[21] = 8'b00000000; // 00000000
        memoria[22] = 8'b00000000; // 00000000
        memoria[23] = 8'b00000000; // 00000000
    end

  always @(A) begin
        // Leitura dos 32 bits da memória baseado no endereço A
        RD[7:0]   = memoria[A];
        RD[15:8]  = memoria[A+1];
        RD[23:16] = memoria[A+2];
        RD[31:24] = memoria[A+3];
  end

endmodule
module mem_to_reg_mux(
  input MemtoReg,
  input [31:0] ALUResult,
  input [31:0] ReadData,
  output [31:0] Result
);

 assign Result = MemtoReg ? ReadData : ALUResult;

endmodule;
module register_file(a1, a2, a3, WD3, WE3, clk, RD1, RD2);

  input [4:0] a1; // data source
  input [4:0] a2; // data source
  
  input [4:0] a3; // write
  input [31:0] WD3; // write data
  
  input WE3; // write enable 
  input clk;
 
  output [31:0] RD1,RD2; // read data
 
  integer i;
  reg [31:0] registers [0:31];
  
  assign RD1 = (a1==0) ? 32'd0 : registers[a1];
  assign RD2 = (a2==0) ? 32'd0 : registers[a2];
  
  initial begin
    for(i=0; i<32; i=i+1) 
     registers[i] <= 32'd0;
  end
  
  always @(posedge clk) begin
    if (WE3) begin
      registers[a3] <= (a3==0) ? 32'd0 : WD3;
    end
  end
 
endmodule
# mips-architecturemodule alu_scr_mux(
  input ALUSrc,
  input [31:0] RD2,
  input [31:0] SignImm,
  output [31:0] SrcB
);

 assign SrcB = ALUSrc ? SignImm : RD2;

endmodule;
module control_unit(
    input [5:0] op,
    input [5:0] funct,
    output reg mentoreg,       // Saída: controle para armazenamento na ALU
    output reg menwrite,       // Saída: controle para escrita no registrador
    output reg branch,         // Saída: controle para desvio condicional
    output reg alusrc,         // Saída: controle para fonte do operando da ALU
    output reg regdst,         // Saída: controle para registrador de destino
    output reg regwrite,       // Saída: controle para escrever no registrador
    output [2:0] aluControl
);
    reg [1:0] aluop;           // Controle para a ALU

    // Inicializações padrão
    initial begin
        mentoreg = 0;
        menwrite = 0;
        branch = 0;
        alusrc = 0;
        regdst = 0;
        regwrite = 0;
        aluop = 2'b00;
    end

    // Decodificação do código de operação
    always @ (op) begin
        case (op)
            // SW (Store Word)
            6'b101011: begin
                mentoreg = 0;
                menwrite = 1;
                branch = 0;
                alusrc = 1;
                aluop = 2'b00;
                regdst = 0;
                regwrite = 0;
            end
            
            // LW (Load Word)
            6'b100011: begin
                mentoreg = 1;
                menwrite = 0;
                branch = 0;
                alusrc = 1;
                aluop = 2'b00;
                regdst = 0;
                regwrite = 1;
            end
            
            // R-type
            6'b000000: begin
                mentoreg = 0;
                menwrite = 0;
                branch = 0;
                aluop = 2'b10;        // Definir operação da ALU para R-type
                alusrc = 0;
                regdst = 1;      
                regwrite = 1;
            end
        endcase
    end

    // Definição dos parâmetros para controle da ALU
    parameter ADD = 3'b010;
    parameter SUBT = 3'b110;
    parameter AND = 3'b000;
    parameter OR = 3'b001;
    parameter SETLESSTHAN = 3'b111;
    parameter FADD = 6'b100000;
    parameter FSUBT = 6'b100010;
    parameter FAND = 6'b100100;
    parameter FOR = 6'b100101;
    parameter FSLT = 6'b101010;

    // Atribuição do controle da ALU baseado em aluop e funct
    assign aluControl = (aluop == 2'b00) ? ADD : 
                        (aluop == 2'b01) ? SUBT :   
                        (aluop == 2'b10) ? (
                            (funct == FADD) ? ADD :
                            (funct == FSUBT) ? SUBT :
                            (funct == FOR) ? OR :
                            (funct == FAND) ? AND : 
                            (funct == FSLT) ? SETLESSTHAN :
                            3'b000
                        ) : 3'b000;
endmodule
module pc_branch(
  
  // juntou <<2 e pcbranch
  input [4:0] SignImm,
  input [4:0] PCplus4,
  output [4:0] result
);
  
  assign result = PCplus4 + SignImm*4; 
endmodule;
