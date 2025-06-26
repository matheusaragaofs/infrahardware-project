module Mux_MemToReg (
    input wire [2:0] control_signal,
    input wire [31:0] alu_out_data, load_size_result, hi_register_data, lo_register_data, slt_result, shifted_value,
    output wire [31:0] output_data_to_register_destination
);

// control_signal - Sinal de controle para selecionar qual dado será escrito no banco de registradores

// alu_out_data        - Saída do registrador temporário da ALU (ALUOUT)
// load_size_result    - Resultado da operação de Load com ajuste de tamanho (byte, half-word)
// hi_register_data    - Dados do registrador HI (para operações de multiplicação/divisão)
// lo_register_data    - Dados do registrador LO (para operações de multiplicação/divisão)
// slt_result          - Resultado da instrução "Set on Less Than" (SLT) da ALU
// shifted_value       - Valor com shift left de 16 bits (provavelmente para LUI ou outras operações de constante)

// output_data_to_register_destination - Dado a ser escrito no banco de registradores

    assign output_data_to_register_destination = (control_signal == 3'b000) ? alu_out_data :
                              (control_signal == 3'b001) ? load_size_result :
                              (control_signal == 3'b010) ? hi_register_data :
                              (control_signal == 3'b011) ? lo_register_data :
                              (control_signal == 3'b100) ? slt_result :
                              (control_signal == 3'b101) ? 32'd227 : // Valor constante 227
                              (control_signal == 3'b110) ? shifted_value :
                              32'bx; // Sinaliza valor indefinido para seleções não utilizadas ou inválidas

endmodule