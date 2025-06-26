module Mux_RegDest  (  
    input wire [1:0] control_signal,
    input wire [4:0] rt_register_address, rd_register_address,
    output wire [4:0] output_register_destination
);

// control_signal - Sinal de controle para selecionar o endereço do registrador de destino

// rt_register_address - Endereço do registrador de destino 'rt' (bits [20-16] da instrução)
// rd_register_address - Endereço do registrador de destino 'rd' (bits [15-11] da instrução)
// special_register_31 - Endereço fixo do registrador 31
// special_register_29 - Endereço fixo do registrador 29

// output_register_destination - Endereço do registrador de destino a ser escrito no banco de registradores

    assign output_register_destination = (control_signal == 2'b00) ? rt_register_address :
                                     (control_signal == 2'b01) ? rd_register_address :
                                     (control_signal == 2'b10) ? 5'd31 : // Seleciona o endereço 31
                                     (control_signal == 2'b11) ? 5'd29 : // Seleciona o endereço 29
                                     5'bx; // Sinaliza valor indefinido para seleções não utilizadas
                                     
endmodule