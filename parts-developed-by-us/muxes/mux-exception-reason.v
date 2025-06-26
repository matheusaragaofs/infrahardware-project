module Mux_ExceptionReason (  
    input wire [1:0] control_signal,
    output wire [31:0] exception_cause_code
);

// control_signal - Sinal de controle para selecionar o código da causa da exceção

// exception_cause_code  - Código da causa da exceção (valor a ser escrito no registrador Cause)

// output_exception_cause_code - Código da causa da exceção a ser escrito no registrador Cause


    assign exception_cause_code = (control_signal == 2'b00) ? 32'd253 : // Causa de exceção 253
                                  (control_signal == 2'b01) ? 32'd254 : // Causa de exceção 254
                                  (control_signal == 2'b10) ? 32'd255 : // Causa de exceção 255
                                  32'bx; // Sinaliza valor indefinido para seleções não utilizadas

endmodule