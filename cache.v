`timescale 1ns / 1ps

module cache(
    input wire [31:0] inputAddress,
    input wire [31:0] inputData,
    input wire clk,
    input wire loadEnable,
    input wire storeEnable,
    input wire ready,
    input wire [31:0]memoryBus,
    input wire [3:0]memoryBusCount,
    input wire memoryBusReset,
    input wire cacheStoreComplete,
    output reg cacheAddressReceive,
    input wire memoryAddressReceive,
    output reg [31:0]L1Bus,
//    output reg cacheBusReset,
//    output reg [3:0]cacheBusCount,
    output reg valid,
    output reg [31:0] dataOut,
    output reg storeDone
);
parameter cacheSize = 2048;
parameter blockSize = 32;
parameter wordSize = 4;
parameter associativity = 4;
parameter noOfLines = 64;
parameter noOfSets = 16;
parameter indexBits = 4;
parameter offsetBits = 3;
parameter tagBits = 25;
reg [31:0] cache [0:noOfSets-1][0:associativity-1][0:7];
reg validBits [0:noOfSets-1][0:associativity-1];
reg [tagBits-1:0] tagRecord [0:noOfSets-1][0:associativity-1];
reg [31:0] BlockData;
integer i;
integer j;
wire [2:0] addrOffset;
wire [3:0] addrIndex;
wire [24:0] addrTag;
assign addrOffset = inputAddress[2:0];
assign addrIndex = inputAddress[6:3];
assign addrTag = inputAddress[31:7];
reg[31:0]dataReceive[7:0];
reg hit=1'b0;
initial $readmemh("cache.mem", cache);
initial $readmemb("validBits.mem", validBits);
initial $readmemb("tagRecord.mem", tagRecord);
always @(posedge clk) begin
    dataOut=8'b0;
    valid = 1'b0;
    storeDone=0;
    if(loadEnable && ~storeEnable)begin
        for (j = 0; j < associativity; j = j + 1) begin
            if (validBits[addrIndex][j] == 1'b1 && tagRecord[addrIndex][j] == addrTag) begin
                hit = 1'b1;
                dataOut= cache[addrIndex][j][addrOffset];
            end
        end 
        if (~hit) begin
            valid=1'b1;
            if(ready==1'b1)begin
                L1Bus=inputAddress;
                if(memoryAddressReceive)begin
                    for(i=0;i<8;i=i+1)begin
                        dataReceive[i]=memoryBus;
                    end
                    valid=0;
                    dataOut=dataReceive[addrOffset];
                end   
            end    
        end          
    end

    else if (~loadEnable && storeEnable)begin
        hit=0;
        for (j = 0; j < associativity; j = j + 1) begin
            if (validBits[addrIndex][j] == 1'b1 && tagRecord[addrIndex][j] == addrTag) begin
                
                hit = 1'b1;
                cache[addrIndex][j][addrOffset]=inputData;
                $write("cache.mem", cache);
           
            end
         end
         begin
                valid=1;
                if (ready&&~memoryAddressReceive)begin
                    L1Bus=inputAddress;
                if(memoryAddressReceive)begin
                    L1Bus=inputData;
                end
                valid=0;
            
         end
        end
        
     end
end

endmodule
