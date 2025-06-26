module Mux_AluA (  
    input wire [1:0] control_signal,
    input wire [31:0] pc_input, reg_temp_A_input,   
    output wire [31:0] output_alu_a
);

// control_signal - Sinal de controle para selecionar o valor do registrador A

// pc_input - Dados do PC
// reg_temp_A_input - Dados do registrador temporário A

// output_alu_a - Valor do registrador A a ser usado na ALU

    assign output_alu_a = (control_signal == 2'b00) ? pc_input :
                         (control_signal == 2'b01) ? reg_temp_A_input:
                         (control_signal == 2'b10) ? 32'd0:
                         2'bxx;

endmodule