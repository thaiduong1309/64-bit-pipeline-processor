library verilog;
use verilog.vl_types.all;
entity D_FF1 is
    port(
        \out\           : out    vl_logic;
        \in\            : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic
    );
end D_FF1;
