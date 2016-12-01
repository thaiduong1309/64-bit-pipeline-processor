library verilog;
use verilog.vl_types.all;
entity DFF_32bit is
    generic(
        WIDTH           : integer := 32
    );
    port(
        en              : in     vl_logic;
        q               : out    vl_logic_vector;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end DFF_32bit;
