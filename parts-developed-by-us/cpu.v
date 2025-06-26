module cpu (
    input clk, reset
);

    wire [1:0] cs_mux_AluA;
    wire [31:0] pc_output;
    wire [31:0] reg_temp_A_output;
    wire [31:0] mux_AluA_out;
   

    Mux_AluA mux_AluA_(
    .control_signal(cs_mux_AluA),
    .pc_input(pc_output),
    .reg_temp_A_input(reg_temp_A_output),
    .output_alu_a(mux_AluA_out)
    );  
endmodule