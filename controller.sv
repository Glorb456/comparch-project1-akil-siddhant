module controller(
    input logic clk,
    input logic [31:0] instruction,
    output logic pc_sel,
    output logic rd_sel,
    output logic sel_op1,
    output logic sel_op2,
    output logic reg_file_wren,
    output logic dmem_wren

);
endmodule