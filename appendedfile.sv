module alu_scr_mux(
  input ALUSrc,
  input [31:0] RD2,
  input [31:0] SignImm,
  output [31:0] SrcB
);

 assign SrcB = ALUSrc ? SignImm : RD2;

endmodule;
module pc_branch(
  
  // juntou <<2 e pcbranch
  input [31:0] SignImm,
  input [31:0] PCplus4,
  output [31:0] result
);
  
  assign result = PCplus4 + SignImm*4; 
endmodule;
module data_memory (
  input clk,
  input signed [31:0] A,
  input signed [31:0] WD,
  input WE,
  output reg signed [31:0] RD
);
  reg signed[31:0] Mem [31:0];
  
  always @ (clk) begin
    if (WE)
      Mem[A] <= WD; 
    else
      RD <= Mem[A];
  end
endmodule;

module instruction_memory(
  	input [31:0] A,        
    output reg [31:0] RD       
);
  reg [7:0] memoria [72:0];  // Declaração da memória de instruções

    initial begin
      // addi reg[1] (at), $zero, 10 (add valor 10 ao reg[1]) 001000 00000 00001  00000000 00001010
      memoria[0] = 8'b00100000;  //addi
      memoria[1] = 8'b00000001;  //addi
      memoria[2] = 8'b00000000;  //addi
      memoria[3] = 8'b00001010;  //addi

      memoria[4] = 8'b00100000;  //addi
      memoria[5] = 8'b00000010;  //addi
      memoria[6] = 8'b00000000;  //addi
      memoria[7] = 8'b00010100;  //addi

      memoria[8] = 8'b00100000;  //addi
      memoria[9] = 8'b00000011;  //addi
      memoria[10] = 8'b00000000;  //addi
      memoria[11] = 8'b00110010;  //addi

      memoria[12] = 8'b00100000;  //addi
      memoria[13] = 8'b00000100;  //addi
      memoria[14] = 8'b00000000;  //addi
      memoria[15] = 8'b00000000;  //addi

      memoria[16] = 8'b10101100;  //sw
      memoria[17] = 8'b00000001;  //sw
      memoria[18] = 8'b00000000;  //sw
      memoria[19] = 8'b00000001;  //sw

      memoria[20] = 8'b10101100;  //sw
      memoria[21] = 8'b00000010;  //sw
      memoria[22] = 8'b00000000;  //sw
      memoria[23] = 8'b00000010;  //sw

      memoria[24] = 8'b10101100;  //sw
      memoria[25] = 8'b00000011;  //sw
      memoria[26] = 8'b00000000;  //sw
      memoria[27] = 8'b00000011;  //sw

      memoria[28] = 8'b10101100;  //sw
      memoria[29] = 8'b00000100;  //sw
      memoria[30] = 8'b00000000;  //sw
      memoria[31] = 8'b00000100;  //sw

      memoria[32] = 8'b10001100;  //lw
      memoria[33] = 8'b00000001;  //lw
      memoria[34] = 8'b00000000;  //lw
      memoria[35] = 8'b00000001;  //lw

      memoria[36] = 8'b10001100;  //lw
      memoria[37] = 8'b00000010;  //lw
      memoria[38] = 8'b00000000;  //lw
      memoria[39] = 8'b00000010;  //lw

      memoria[40] = 8'b10001100;  //lw
      memoria[41] = 8'b00000011;  //lw
      memoria[42] = 8'b00000000;  //lw
      memoria[43] = 8'b00000011;  //lw

      memoria[44] = 8'b10001100;  //lw
      memoria[45] = 8'b00000100;  //lw
      memoria[46] = 8'b00000000;  //lw
      memoria[47] = 8'b00000100;  //lw

      memoria[48] = 8'b00000000;  //add
      memoria[49] = 8'b00100010;  //add
      memoria[50] = 8'b00001000;  //add
      memoria[51] = 8'b00100000;  //add

      memoria[52] = 8'b00100000;  //addi
      memoria[53] = 8'b10000100;  //addi
      memoria[54] = 8'b00000000;  //addi
      memoria[55] = 8'b00000001;  //addi

      memoria[56] = 8'b10101100;  //sw
      memoria[57] = 8'b00000001;  //sw
      memoria[58] = 8'b00000000;  //sw
      memoria[59] = 8'b00000001;  //sw

      memoria[60] = 8'b10101100;  //sw
      memoria[61] = 8'b00000100;  //sw
      memoria[62] = 8'b00000000;  //sw
      memoria[63] = 8'b00000100;  //sw

      memoria[64] = 8'b00010000;  //beq
      memoria[65] = 8'b00100011;  //beq
      memoria[66] = 8'b00000000;  //beq
      memoria[67] = 8'b11111111;  //beq


      memoria[68] = 8'b00010000;  //beq
      memoria[69] = 8'b00000000;  //beq
      memoria[70] = 8'b11111111;  //beq
      memoria[71] = 8'b11110110;  //beq

    end

  always @(A) begin
        // Leitura dos 32 bits da memória baseado no endereço A
        RD[7:0]   = memoria[A+3];
        RD[15:8]  = memoria[A+2];
        RD[23:16] = memoria[A+1];
        RD[31:24] = memoria[A];
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
module ALU(
  input [2:0] aluControl, 
  input signed [31:0] srcA, 
  input signed [31:0] srcB, 
  output zero, 
  output signed [31:0] aluResult 
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

            // ADDI
            6'b001000: begin
                mentoreg = 0;
                menwrite = 0;
                branch = 0;
                aluop = 2'b00; 
                alusrc = 1;
                regdst = 0;      
                regwrite = 1;
            end

            // BEQ
            6'b000100: begin
                mentoreg = 0;
                menwrite = 0;
                branch = 1;
                aluop = 2'b01; 
                alusrc = 0;
                regdst = 0;      
                regwrite = 0;
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
module register_file(
  input [4:0] a1,        // endereço da leitura 1
  input [4:0] a2,        // endereço da leitura 2
  input [4:0] a3,        // endereço da escrita
  input signed [31:0] WD3,      // dados para escrita
  input WE3,             // habilitação para escrita
  input clk,             // sinal de clock
  output signed [31:0] RD1,    // dados lidos 1
  output signed [31:0] RD2     // dados lidos 2
);

  reg signed [31:0] registers [0:31];  // array de registradores de 32 bits

  // Leitura dos registradores
  assign RD1 = (a1 == 0) ? 32'd0 : registers[a1];
  assign RD2 = (a2 == 0) ? 32'd0 : registers[a2];

  // Inicialização dos registradores (para simulação)
  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) 
      registers[i] = 32'd0;
  end

  // Escrita nos registradores
  always @(posedge clk) begin
    if (WE3 && (a3 != 0)) begin
      registers[a3] <= WD3;
    end
  end

endmodule

module pc_src_mux (
  input PCSrc,
  input [31:0] PCPlus4,
  input [31:0] PCBranch,
  output [31:0] Result
);

 assign Result = PCSrc ? PCBranch : PCPlus4;
  
endmodule;
module reg_dst_mux(
  input RegDst,
  input [4:0] inst_20_16,
  input [4:0] inst_15_11,
  output [4:0] WriteReg
);

 assign WriteReg = RegDst ? inst_15_11 : inst_20_16;

endmodule;
module Sign_Extend(
  input signed [15:0] instr,
  output signed [31:0] SignImm
);
  
  assign SignImm = instr[15] ? {16'b1111111111111111, instr} : {16'b0, instr};
  
endmodule


module pc(
  input [31:0] next_instr, 
  input clk, 
  output reg [31:0] curr_instr 
);
  initial curr_instr = 0;

  always @(posedge clk) begin
    curr_instr = next_instr;
  end

endmodule

module pc_mux (
  input [31:0] plus4_instr, 
  input [31:0] branch, 
  input use_branch, 
  output [31:0] next_instr 
);

  assign next_instr = (use_branch) ? branch : plus4_instr;
endmodule
module pcplus4(
  input [INSTRSIZE:0]last_instr, 
  output [INSTRSIZE:0] next_instr
);
  parameter INSTRSIZE = 31;
  
  assign next_instr = last_instr + 4;

endmodule
