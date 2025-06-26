module Mux_IorD (  
    input wire [2:0] control_signal,
    input wire [31:0] program_counter_input, exception_address_input, alu_out_result, alu_computed_result, temp_swap_address_1, temp_swap_address_2,
    output wire [31:0] output_address_to_memory
);

// control_signal - Sinal de controle para selecionar o endereço de memória

// program_counter_input - Contador de Programa (PC)
// exception_address_input - Endereço de Exceção
// alu_out_result - Saída da ALU_OUT (registrador temporário)
// alu_computed_result - Saída do resultado final da ALU
// temp_swap_address_1 - Endereço Temporário para Troca 1
// temp_swap_address_2 - Endereço Temporário para Troca 2

// output_address_to_memory - Endereço de memória a ser escrito no banco de registradores

    assign output_address_to_memory = (control_signal == 3'b000) ? program_counter_input :
                                     (control_signal == 3'b001) ? exception_address_input :
                                     (control_signal == 3'b010) ? alu_out_result :
                                     (control_signal == 3'b011) ? alu_computed_result :
                                     (control_signal == 3'b100) ? temp_swap_address_1 :
                                     (control_signal == 3'b101) ? temp_swap_address_2 :
                                     32'bx; // Sinaliza valor indefinido para seleções não utilizadas
                                     
endmodule