`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2023 22:47:32
// Design Name: 
// Module Name: ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram (
  input wire clk,         // Clock signal
  input wire storeEnable,
  input wire loadEnable, 
  input wire [31:0] L1Bus,
//  input wire [3:0] cacheBusCount,
//  input wire cacheBusReset,
  input wire valid,
  input wire cacheAddressReceive,
  output reg memoryAddressReceive,
  output reg memoryBusReset,
  output reg [31:0] memoryBus,
  output reg ready,
  output reg [3:0]memoryBusCount,
  output reg cacheStoreComplete 
);
reg [31:0] mainMemory[0:2047];
integer i,j;

reg[31:0] receiveAddress;
initial $readmemh("mainMemory.mem", mainMemory);
//$write("mainMemory.mem", mainMemory);
always @(posedge clk) begin
    ready<=1'b1;
    memoryAddressReceive=0;
    cacheStoreComplete=1'b0;
    if (valid && loadEnable) begin
        ready=1'b1;
        receiveAddress=L1Bus;
        memoryAddressReceive=1'b1;
        if(memoryBusReset)begin
            memoryBusCount=0;
            memoryBus=0;
        end
        for(memoryBusCount=0;memoryBusCount<8;memoryBusCount=memoryBusCount+1)begin
            memoryBus=mainMemory[receiveAddress-receiveAddress%8+memoryBusCount];
        end
//        memoryAddressReceive=0;
        ready=1'b0;
    end
    else if(valid && storeEnable)begin 
        ready=1'b1;
        memoryAddressReceive=0;
        receiveAddress=L1Bus;
        memoryAddressReceive=1'b1;
        mainMemory[receiveAddress]=L1Bus;
        
        cacheStoreComplete=1;
        memoryAddressReceive=0;
        cacheStoreComplete=1;
    end   
 end

endmodule