`ifndef CORE_STRUCTURES_SV__
`define CORE_STRUCTURES_SV__

typedef struct packed {
    logic         valid;  // Valid bit
    logic [511:0] data;   // Data payload     
    logic         sop;    // Start of Packet
    logic         eop;    // End of Packet
    logic [5:0]   empty;  // Byte empty count
    logic         error;  // Error flag
    logic [11:0]  frm_dbg_id; // Frame Debug ID
    
} core_avl_t;

typedef struct packed {
    logic  [1:0]  stat_en;
    logic  [11:0] stat0_id;
    logic  [11:0] stat1_id;
} core_stats_t;

typedef struct packed {
    logic         valid;
    logic [3:0]   vs;     // Virtual Switch ID
    logic         lif;    // Logical Interface ID

    logic         mcast;  // Multicast
    logic         bcast;  // Broadcast
    logic         ldap;   // LDAP
    logic         stp;    // Spanning Tree Protocol
    logic         lacp;   // Link Aggregation Control Protocol
    logic [1:0]   cosidx; // Class of Service Index
    logic [3:0]   fcos;   // Frame Class of Service
    logic [1:0]   rcos;   // Relative Class of Service
    logic         drop;   // Drop
    logic [2:0]   drop_reason; // Track reasons for drops
    logic         mirror; // ingress Mirror

    logic [1:0]   color;
    logic         mtr_en;
    logic [2:0]   mtr_id;
    core_stats_t  stats;
    logic [11:0]  frm_dbg_id; // Frame Debug ID
} core_ingmeta_t;



`endif