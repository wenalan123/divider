/************************************************************************
 * Author        : Wen Chunyang
 * Email         : 1494640955@qq.com
 * Create time   : 2018-04-13 10:17
 * Last modified : 2018-04-13 10:17
 * Filename      : divider.v
 * Description   : 
 * *********************************************************************/
module  divider(
        input                   clk                     ,
        input                   rst_n                   ,
        //
        output  reg             clk_5m 
);
//=====================================================================\
// ********** Define Parameter and Internal Signals *************
//=====================================================================/
//若需要N分频器（N为偶数），计数器从0计数到N/2-1时，将输出时钟进行翻转
parameter   COUNT_5M    =       5                               ; 
//cnt的位宽要与COUNT_5M匹配
reg     [ 2: 0]                 cnt                             ;
wire                            add_cnt                         ;
wire                            end_cnt                         ; 

//======================================================================
// ***************      Main    Code    ****************
//======================================================================
//cnt
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end

assign  add_cnt     =       1'b1;       
assign  end_cnt     =       add_cnt && cnt == COUNT_5M - 1;   

//clk_5m
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        clk_5m  <=  1'b0;
    end
    else if(end_cnt)begin
        clk_5m  <=  ~clk_5m;
    end
end


endmodule
