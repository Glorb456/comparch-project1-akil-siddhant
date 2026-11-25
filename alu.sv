module ALU(
    //input logic [2:0] funct3,
    //input logic [6:0] funct7,
    input logic [3:0] alu_op, // operation code for MUX
    input logic [31:0] op1,
    input logic [31:0] op2,
    output logic [31:0] result
);
// Create variables for all operation results to be held
logic [31:0] add_result;
logic [31:0] sub_result;
logic [31:0] bitwise_and_result;
logic [31:0] bitwise_or_result;
logic [31:0] bitwise_xor_result;
logic [31:0] sll_result; // Shift left logical result
logic [31:0] srl_result; // Shift right logical result
logic [31:0] sra_result; // Shift right arithmetic result
logic [31:0] slt_result; // set less than result
logic [31:0] sltu_result; // set less than unsigned result

always_comb begin
    unique case (alu_op)
        4'b0000: // Addition result
            add_result = op1 + op2;
            result = add_result;
        4'b0001; // Subtraction result
            sub_result = op1 - op2;
            result = sub_result;
        4'b0010: // bitwise and result
            bitwise_and_result = op1 & op2;
            result = bitwise_and_result;
        4'b0011: // bitwise or result
            bitwise_or_result = op1 | op2;
            result = bitwise_or_result;
        4'b0100; // bitwise xor result
            bitwise_xor_result = op1 ^ op2;
            result = bitwise_xor_result;
        
    endcase 
end


endmodule 