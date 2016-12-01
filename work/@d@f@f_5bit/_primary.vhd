library verilog;
use verilog.vl_types.all;
entity DFF_5bit is
    port(
        q               : out    vl_logic_vector(4 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data            : in     vl_logic_vector(4 downto 0)
    );
end DFF_5bit;
