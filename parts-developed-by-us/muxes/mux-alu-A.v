module Mux_AluA (  
    input wire [1:0] control_signal,
    input wire [31:0] pc_input, reg_temp_A_input,   
    output wire [31:0] result_data
);

// pc_input - Dados do PC
// reg_temp_A_input - Dados do registrador temporário A


    assign result_data = (control_signal == 2'b00) ? pc_input :
                         (control_signal == 2'b01) ? reg_temp_A_input:
                         (control_signal == 2'b10) ? 32'd0:
                         2'bxx;

endmodule