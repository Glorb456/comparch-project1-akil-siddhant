`include "memory.sv"
`include "alu.sv"
`include "immed_gen.sv"
`include "controller.sv"
`include "register_file.sv"
//orchestrates all other modules together to form RV32I processor

module top (
    input logic clk, 
    output logic LED, 
    output logic RGB_R, 
    output logic RGB_G, 
    output logic RGB_B
);


    logic [2:0] funct3 = 3'b010; //initial vals need to go
    logic dmem_wren;
    logic [31:0] dmem_address = 31'd0; // here
    logic [31:0] dmem_data_in = 31'd0; // here
    logic [31:0] dmem_data_out;
    logic [31:0] imem_address = 31'h1000;
    logic [31:0] imem_data_out;

    logic reset;
    logic led;
    logic red;
    logic green;
    logic blue;

    logic [31:0] instruction_in;
    logic [31:0] instruction_out;
    logic [31:0] last_instruction_addr;
    logic [31:0] pre_sel_addr;

    logic pc_sel;
    logic rd_sel [1:0];
    logic sel_op1;
    logic sel_op2;
    logic reg_file_wren;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] rdv;
    logic [6:0] funct7;

    logic pc_wren;


    //program counter
    always_ff @(negedge clk) begin //why negedge and not posedge?
        if (pc_wren) begin
            imem_address <= last_instruction_addr;
        end 
    end

    //instruction register
    always_ff @(negedge clk) begin
        instruction_out <= instruction_in;
    end 

    //adder and selector logic
    always_comb begin
        pre_sel_addr = imem_address + 32'd4;
        if (pc_sel) begin
            last_instruction_addr = dmem_address;
        end 
        else begin
            last_instruction_addr = pre_sel_addr;
        end 
    end 

    //ALU and immediate gen output logic
    always_comb begin
    end 

    //rdv mux
    always_comb begin
        case (rd_sel)
            0: begin
                rdv = dmem_address;
            end 
            1: begin
                rdv = dmem_data_out;
            end 
            2: begin
                rdv = pre_sel_addr;
            end 
            3: begin
                rdv = immed_val;
            end 
        endcase
    end 

    immed_gen # (
    ) ui (
        .instruction (instruction),
        .immed_val (immed_val)
    );

    register_file #(
        
    ) ur (
        .clk (clk),
        .reg_file_wren (reg_file_wren),
        .rs1 (rs1),
        .rs2 (rs2),
        .rd (rd),
        .rdv (rdv),
        .rs1v (rs1v),
        .rs2v (rs2v)
    );
 
    controller #(

    ) u2 (
        .clk (clk),
        .instruction (imem_data_out),
        .pc_sel (pc_sel),
        .rd_sel (rd_sel),
        .sel_op1 (sel_op1),
        .sel_op2 (sel_op2),
        .reg_file_wren (reg_file_wren),
        .dmem_wren (dmem_wren),
        .pc_wren (pc_wren),
        .alu_op (alu_op)
    );


    memory #(
        .IMEM_INIT_FILE_PREFIX  ("rv32i_test")
    ) u1 (
        .clk            (clk), 
        .funct3         (funct3), 
        .dmem_wren      (dmem_wren), 
        .dmem_address   (dmem_address), 
        .dmem_data_in   (dmem_data_in), 
        .imem_address   (imem_address), 
        .imem_data_out  (imem_data_out), 
        .dmem_data_out  (dmem_data_out), 
        .reset          (reset), 
        .led            (led), 
        .red            (red), 
        .green          (green), 
        .blue           (blue)
    );

    assign LED = ~led;
    assign RGB_R = ~red;
    assign RGB_G = ~green;
    assign RGB_B = ~blue;

endmodule
