module controller(
    input logic clk,
    input logic [31:0] instruction,
    output logic pc_sel,
    output logic [1:0] rd_sel,
    output logic sel_op1,
    output logic sel_op2,
    output logic reg_file_wren,
    output logic dmem_wren,
    output logic pc_wren,
    output logic alu_op

);

logic [31:0] program_count;

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[24:20];

    logic isR = 1'b0;
    logic isI = 1'b0;
    logic isload = 1'b0;
    logic isstore = 1'b0;
    logic isbranch = 1'b0;
    logic isjalr = 1'b0;
    logic isjal = 1'b0;
    logic islui = 1'b0;
    logic isauipc = 1'b0;
    


//instruction step
always_ff @(posedge clk) begin
    if (pc_wren) begin
        program_count = program_count + 1;
    end
end 

//decoder, splits instruction and classifies
always_comb begin
    case(opcode)
        //R type
        0110011: begin
            isR = 1'b1;
        end 

        // I-type arithmetic
        7'b0010011: begin
            isI = 1'b1;
        end

        // Loads
        7'b0000011: begin
            isload = 1'b1;
        end

        // Stores
        7'b0100011: begin
            isstore = 1'b1;
        end

        // Branches
        7'b1100011: begin
            isbranch = 1'b1;
        end

        // JALR
        7'b1100111: begin
            isjalr = 1'b1;
        end

        // JAL
        7'b1101111: begin
            isjal = 1'b1;
        end

        // LUI
        7'b0110111: begin
            islui = 1'b1;
        end

        // AUIPC
        7'b0010111: begin
            isauipc = 1'b1;
        end

        default: begin
        end
    endcase 
end 
//next state logic, chooses next state based on current state and instruction
always_comb begin
//which instructions need which state
// I ALU: F, D, E, W
// Load: F, D, E, M, W
// Store: F, D, E, M
// Branch: F, D, E, W
// Jal: F, D, E, W
// Jalr: F, D, E, W
// Lui: F, D, E, W
// AUIPC: F, D, E, W
end 

//output logic, sets control signals
always_comb begin
end 


//alu control, converts opcode and func3/7 into alu_op TODO
always_comb begin
end 

endmodule