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
//instruction step
always_ff(posedge clk) begin
    if (pc_wren) begin
        program_count = program_count + 1;
    end 
    
end 

//decoder, splits instruction and classifies
always_comb begin

end 
//next state logic, chooses next state based on current state and instruction
always_comb begin
end 

//output logic, sets control signals
always_comb begin
end 


//alu control, converts opcode and func3/7 into alu_op
always_comb begin
end 

endmodule