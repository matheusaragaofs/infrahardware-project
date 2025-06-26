module LoadSize (
    input wire [1:0] control_signal,
    input wire [31:0] raw_memory_data_input,
    output wire [31:0] formatted_load_data
);

// control_signal    - Sinal de controle para selecionar o formato de extensão dos dados carregados
// raw_memory_data_input - Dados brutos lidos da memória
// formatted_load_data   - Dados formatados e estendidos para uso no caminho de dados

    assign formatted_load_data = (control_signal == 2'b00) ? raw_memory_data_input : // Nenhuma extensão (assume palavra completa - 32 bits)
                                 (control_signal == 2'b01) ? {16'b0, raw_memory_data_input[15:0]} : // Extensão de zero para meia palavra (16 bits)
                                 (control_signal == 2'b10) ? {24'b0, raw_memory_data_input[7:0]} : // Extensão de zero para byte (8 bits)
                                 32'bx; // Sinaliza valor indefinido para seleções não utilizadas

endmodule