module Mux_PCSource (  
    input wire [1:0] control_signal,
    input wire [31:0] alu_result_input, alu_out_input, sign_extended_shifted_address, exception_program_counter,
    output wire [31:0] output_next_pc_address
);

// control_signal - Sinal de controle para selecionar o próximo endereço do PC

// alu_result_input - Resultado da Unidade Lógica e Aritmética (ALU)
// alu_out_input - Saída temporária da ALU (ALUOUT)
// sign_extended_shifted_address - Endereço estendido e deslocado (proveniente da instrução [25-0])
// exception_program_counter - Endereço do Contador de Programa para Exceções (EPC)

// output_next_pc_address - Próximo endereço do PC a ser escrito no banco de registradores

    assign output_next_pc_address = (control_signal == 2'b00) ? alu_result_input :
                             (control_signal == 2'b01) ? alu_out_input :
                             (control_signal == 2'b10) ? sign_extended_shifted_address :
                             (control_signal == 2'b11) ? exception_program_counter :
                             32'bx; // Sinaliza valor indefinido para seleções não utilizadas
                                     
endmodule