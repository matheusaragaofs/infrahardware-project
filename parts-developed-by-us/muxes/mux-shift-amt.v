module Mux_ShiftAmount (  
    input wire [1:0] control_signal,
    input wire [4:0] register_B_lower_bits, instruction_shamt, memory_data_register_lower_bits,
    output wire [4:0] output_effective_shift_amount
);

// control_signal - Sinal de controle para selecionar o valor do montante de deslocamento

// register_B_lower_bits       - 5 bits menos significativos do registrador B (para deslocamento por registrador)
// instruction_shamt           - Campo "shamt" da instrução (bits [10-6]) para deslocamento imediato
// memory_data_register_lower_bits - 5 bits menos significativos do MDR (seja qual for o uso pretendido)

// output_effective_shift_amount      - Valor final do montante de deslocamento a ser usado pela ALU ou unidade de shift

    assign output_effective_shift_amount = (control_signal == 2'b00) ? register_B_lower_bits :
                                    (control_signal == 2'b01) ? instruction_shamt :
                                    (control_signal == 2'b10) ? memory_data_register_lower_bits :
                                    5'bx; // Sinaliza valor indefinido para seleções não utilizadas (agora incluindo 2'b11)
                                     
endmodule