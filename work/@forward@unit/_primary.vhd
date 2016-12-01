library verilog;
use verilog.vl_types.all;
entity ForwardUnit is
    port(
        instruction     : in     vl_logic_vector(31 downto 0);
        ReadRegister1   : in     vl_logic_vector(4 downto 0);
        ReadRegister2   : in     vl_logic_vector(4 downto 0);
        ExMemRd         : in     vl_logic_vector(4 downto 0);
        MemWBRd         : in     vl_logic_vector(4 downto 0);
        ExRegWrite      : in     vl_logic;
        MemRegWrite     : in     vl_logic;
        MemWri          : in     vl_logic;
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0);
        ForwardMem      : out    vl_logic_vector(1 downto 0)
    );
end ForwardUnit;
