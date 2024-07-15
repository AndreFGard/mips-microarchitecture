module tb_ALU_decoder;
    // Inputs
    reg [1:0] aluop;
    reg [5:0] funct;
    
    // Outputs
    wire [2:0] aluControl;

    // Instantiate the ALU_decoder
    ALU_decoder uut (
        .aluop(aluop),
        .funct(funct),
        .aluControl(aluControl)
    );

    // Parameters for expected results
    parameter ADD = 3'b010;
    parameter SUBT = 3'b110;
    parameter AND = 3'b000;
    parameter OR = 3'b001;
    parameter SETLESSTHAN = 3'b111;

    // Test cases
    initial begin
        // Initialize inputs
        aluop = 2'b00; funct = 6'b000000; #10;  // ADD (default)
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        aluop = 2'b01; funct = 6'b000000; #10;  // SUBT (default)
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        aluop = 2'b10; funct = 6'b100000; #10;  // ADD
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        aluop = 2'b10; funct = 6'b100010; #10;  // SUBT
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        aluop = 2'b10; funct = 6'b100100; #10;  // AND
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        aluop = 2'b10; funct = 6'b100101; #10;  // OR
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        aluop = 2'b10; funct = 6'b101010; #10;  // SETLESSTHAN
        $display("aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        
        // Additional test cases can be added here
        
        $stop;  // End simulation
    end
endmodule