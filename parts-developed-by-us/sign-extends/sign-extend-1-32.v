module SignalExtension_1_to_32_bits (
    input wire single_bit_input,
    output wire [31:0] output_extended_1_32_bits
);
//  (instruções SLT)

// single_bit_input - 1 bit de entrada
// output_extended_1_32_bits - 32 bits de saída

// Converte 1 bit para 32 bits preenchendo com zeros à esquerda 

    assign output_extended_1_32_bits = {31'b0, single_bit_input};
endmodule