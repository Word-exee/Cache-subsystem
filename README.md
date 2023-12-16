In this project, we have a 2 KB, 4 way set associative L1D cache. Each cache line is of 32 bytes each and processor
word size is of 4 bytes. Note that this size excludes the tag information present in each cache block. Just as in a
typical cache, just passing the address should give a word size value.
Whenever there is a cache miss in L1D cache, the memory request is sent to a 8 KB main memory, with each
location of 4 bytes each. Note that in case of cache miss, the cache line is fetched and not just the word missed. As
each cache line is of 32 bytes and processor size is of 4 bytes, the transfer happens as a stream of eight 4-byte
numbers. Make sure that the first data is multiple of 8, else wrong data may be passed as output. As the main
memory may not be available, a simple protocol consisting of four signals- CLK, VALID, READY and DATA. A
transfer takes place when both VALID and READY are asserted.
The data transfer in this case happens as a sequence of eight-four byte numbers. 
