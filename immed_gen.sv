//generates sign-extended immediate values

module immed_gen (
    input logic [31:0] instruction,
    output logic [31:0] immed_val
);
    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin
        case (opcode)
            //U
            7'b0110111: begin
                immed_val[31:12] = instruction[31:12];
                immed_val[11:0] = 'b0;
            end
            //auipc
            7'b0010111: begin
                immed_val[31:12] = instruction[31:12];
                immed_val[11:0] = 'b0;
            end 
            //J
            //jal   
            7'b1101111: begin   
                immed_val[31:20] = {12{instruction[31]}}; //sign extend
                immed_val[19:12] = instruction[19:12];
                immed_val[11] = instruction[20];
                immed_val[10:1] = instruction[30:21];
                immed_val[0] = 1'b0;
            end
            //I
            //jalr
            7'b1100111: begin

            end 
            //B (all B types)
            7'b1100011: begin

            end 
            //I (half of I types)
            7'b0000011: begin

            end 
            //S (all S)
            7'b0100011: begin

            end 
            //I (part 2)
            7'b0010011: begin
            end 
            default: immed_val = 32'b0;
        endcase 

    end 

endmodule