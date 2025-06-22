module Mux_AluB (  
    input wire [1:0] control_signal,
    input wire [31:0] reg_temp_B_input, sign_extended_input, shifted_immediate_input,
    output wire [31:0] result_data
);

// reg_temp_B_input - Dados do registrador temporário B
// sign_extended_input - Imediato com extensão de sinal de 16-32 bits
// shifted_immediate_input - Imediato com extensão de sinal de 16-32 bits + deslocamento à esquerda por 2


    assign result_data = (control_signal == 2'b00) ? reg_temp_B_input :
                         (control_signal == 2'b01) ? 32'd4 : //immediate_4_input
                         (control_signal == 2'b10) ? sign_extended_input :
                         (control_signal == 2'b11) ? shifted_immediate_input :
                         2'bxx;
                      
endmodule
