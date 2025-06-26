module StoreSize (
    input wire [1:0] control_signal,
    input wire [31:0] data_to_store_full_word, address_aligned_data_input,
    output wire [31:0] formatted_store_data
);

// control_signal          - Sinal de controle para selecionar o formato de armazenamento dos dados
// data_to_store_full_word    - Dados completos (32 bits) a serem armazenados (para store de palavra ou como fonte de bits inferiores)
// address_aligned_data_input - Dados que já estão alinhados pelo endereço de memória (para combinar com dados parciais)
// formatted_store_data       - Dados formatados para serem escritos na memória

    assign formatted_store_data = (control_signal == 2'b00) ? data_to_store_full_word : // Armazenamento de palavra completa (32 bits)
                                  (control_signal == 2'b01) ? {address_aligned_data_input[31:16], data_to_store_full_word[15:0]} : // Armazenamento de meia palavra (16 bits)
                                  (control_signal == 2'b10) ? {address_aligned_data_input[31:8], data_to_store_full_word[7:0]} : // Armazenamento de byte (8 bits)
                                  32'bx; // Sinaliza valor indefinido para seleções não utilizadas

endmodule