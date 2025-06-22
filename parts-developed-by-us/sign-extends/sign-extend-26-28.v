module SignalExtension_26bit_to_28bit (
    input wire [25:0] immediate_value,
    output wire [27:0] extended_result
);

 // Estende 26 bits e desloca duas posições para a esquerda (instruções de salto)
    assign extended_result = {immediate_value, 2'b00};
endmodule