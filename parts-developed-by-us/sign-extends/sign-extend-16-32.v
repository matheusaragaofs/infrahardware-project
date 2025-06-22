module SignalExtension_16bit_to_32bit (
    input wire control_bit,
    input wire [15:0] immediate_value,
    input wire [7:0] memory_byte,
    output wire [31:0] extended_result
);
    wire [31:0] sign_extended_16bit, zero_extended_8bit;

    // Extensão de sinal para 16 bits, preservando o bit de sinal (imediato e deslocamentos)
    assign sign_extended_16bit = (immediate_value[15]) ? {{16{1'b1}}, immediate_value} : {{16{1'b0}}, immediate_value};

    // Extensão de 8 bits da memória, sempre preenche com zeros (instruções de exceção)
    assign zero_extended_8bit = {{24{1'b0}}, memory_byte};

    // Seleção entre as duas extensões usando lógica de multiplexador
    assign extended_result = (control_bit == 1'b0) ? sign_extended_16bit : zero_extended_8bit;

endmodule