module ShiftLeft_16 (
    input wire [31:0] input_value,
    output wire [31:0] shifted_result
);

// input_value  - O valor de entrada de 32 bits a ser deslocado
// shifted_result - O resultado do valor de entrada deslocado 16 bits para a esquerda

    assign shifted_result = input_value << 16;

endmodule