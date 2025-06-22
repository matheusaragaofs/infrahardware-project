module SignalExtension_1bit_to_32bit (
    input wire single_bit_input,
    output wire [31:0] extended_output
);
    // Converte 1 bit para 32 bits preenchendo com zeros à esquerda (instruções slt)
    assign extended_output = {31'b0, single_bit_input};
endmodule