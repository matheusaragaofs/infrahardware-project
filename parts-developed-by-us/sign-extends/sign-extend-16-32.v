module SignalExtension_16_to_32_bits (
    input wire control_signal,
    input wire [15:0] immediate_value,
    input wire [7:0] memory_byte,
    output wire [31:0] output_extended_16_32_bits
);
    wire [31:0] sign_extended_16bit, zero_extended_8bit;

// control_signal - Sinal de controle para selecionar a extensão de sinal, isso aqui vai ser um

// immediate_value - 16 bits de entrada
// memory_byte - 8 bits de entrada
// output_extended_16_32_bits - 32 bits de saída

    // Extensão de sinal para 16 bits, preservando o bit de sinal (imediato e deslocamentos)
    assign sign_extended_16bit = (immediate_value[15]) ? {{16{1'b1}}, immediate_value} : {{16{1'b0}}, immediate_value};

    // Extensão de 8 bits da memória, sempre preenche com zeros (instruções de exceção)
    assign zero_extended_8bit = {{24{1'b0}}, memory_byte};

    // Seleção entre as duas extensões usando lógica de multiplexador
    assign output_extended_16_32_bits = (control_signal == 1'b0) ? sign_extended_16bit : zero_extended_8bit;

endmodule