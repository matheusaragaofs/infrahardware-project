module SignalExtension_26_to_28_bits (
    input wire [25:0] immediate_value,
    output wire [27:0] output_extended_26_28_bits
);

 // Estende 26 bits e desloca duas posições para a esquerda 

// immediate_value - 26 bits de entrada
// output_extended_26_28_bits - 28 bits de saída

    assign output_extended_26_28_bits = {immediate_value, 2'b00};
endmodule