`timescale		1ns/1ns 

module	tb_top;

//=====================================================================\
// ********** Define Parameter and Internal Signals *************
//=====================================================================/
reg                             clk                             ;       
reg                             rst_n                           ;       
wire                            clk_5m                          ; 


//======================================================================
// ***************      Main    Code    ****************
//======================================================================
always  #5      clk    =       ~clk;


initial begin
	clk		<=		1'b1;
	rst_n	<=		1'b0;
	#100
	rst_n	<=		1'b1;

end


//例化
divider divider_inst(
        .clk                    (clk                    ),
        .rst_n                  (rst_n                  ),
        //
        .clk_5m                 (clk_5m                 )
);


endmodule
