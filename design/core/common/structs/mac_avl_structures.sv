`ifndef __MAC_AVL_STRUCTURES_SV__
`define __MAC_AVL_STRUCTURES_SV__


// Structure definitions for MAC Avalon Streaming interfaces

// The F-Tile Ethernet Intel® FPGA Hard IP TX client interface in MAC+PCS variations 
// employs the Avalon® -ST protocol. The Avalon® ST protocol is a synchronous 
// point-to-point, unidirectional interface that connects the producer of a data 
// stream (source) to a consumer of data (sink). The key properties of this interface 
// include:

// Start of packet (SOP) and end of packet (EOP) signals delimit frame transfers.
// The SOP must always be in the MSB, simplifying the interpretation and processing of 
// incoming data.
// A valid signal qualifies signals from source to sink.
// The sink applies backpressure to the source by using the ready signal. The source 
// typically responds to the deassertion of the ready signal from the sink by driving 
// the same data until the sink can accept it. The Ready latency defines the 
// relationship between assertion and deassertion of the ready signal, and cycles 
// which are considered to be ready for data transfer.

// The client acts as a source and the TX MAC acts as a sink in the transmit direction.
typedef struct packed {
    logic         valid;
    logic [511:0] data;
    logic         sop;
    logic         eop;
    logic [5:0]   empty;
    logic         error;
    logic         skip_crc;
    
} mac_avltx_t;


// The F-Tile Ethernet Intel® FPGA Hard IP RX client interface in MAC+PCS variations 
// employs the Avalon® streaming interface protocol. The Avalon® streaming interface 
// protocol is a synchronous point-to-point, unidirectional interface that connects the 
// producer of a data stream (source) to a consumer of data (sink). The key properties 
// of this interface include:

// Start of packet (SOP) and end of packet (EOP) signals delimit frame transfers.
// The SOP must always be in the MSB, simplifying the interpretation and processing of 
// data you receive on this interface.
// A valid signal qualifies signals from source to sink.
// The RX MAC acts as a source and the client acts as a sink in the receive direction.



typedef struct packed {
    logic         valid;
    logic [511:0] data;
    logic         sop;
    logic         eop;
    logic [5:0]   empty;
    logic [5:0]   errors;
    logic         rxstatus_valid;
    logic [39:0]  rxstatus_data;

} mac_avlrx_t;

`endif