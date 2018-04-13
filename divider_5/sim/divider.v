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
        output  wire            clk_10m 
);
//=====================================================================\
// ********** Define Parameter and Internal Signals *************
//=====================================================================/
//对于50%奇数分频器的设计，用到的思维是错位半个时钟并相或运算.
//具体实现步骤如下：分别利用待分频时钟的上升沿与下降沿进行((N-1)/2)分频，
//最后将这两个时钟进行或运算即可,本例程是5分频。
parameter   COUNT_10M    =      2                               ; 
//cnt的位宽要与COUNT_5M匹配
reg     [ 1: 0]                 cnt0                            ;
wire                            add_cnt0                        ;
wire                            end_cnt0                        ;

reg     [ 1: 0]                 cnt1                            ;
wire                            add_cnt1                        ;
wire                            end_cnt1                        ;

reg                             clk0                            ;
reg                             clk1                            ; 
//======================================================================
// ***************      Main    Code    ****************
//======================================================================
//cnt0
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
end

assign  add_cnt0        =       1'b1;       
assign  end_cnt0        =       add_cnt0 && cnt0 == COUNT_10M - 1;

//clk0
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        clk0  <=  1'b0;
    end
    else if(end_cnt0)begin
        clk0  <=  ~clk0;
    end
end


//cnt1
always @(negedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end

assign  add_cnt1        =       1'b1;       
assign  end_cnt1        =       add_cnt1 && cnt1 == COUNT_10M - 1;

//clk1
always  @(negedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        clk1    <=      1'b0;
    end
    else if(end_cnt1)begin
        clk1    <=      ~clk1;
    end
end

//clk_10m
assign  clk_10m         =       clk0 | clk1;

endmodule
