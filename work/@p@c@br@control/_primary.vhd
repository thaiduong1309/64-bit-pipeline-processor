library verilog;
use verilog.vl_types.all;
entity PCBrControl is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        q               : in     vl_logic;
        Dbzero          : in     vl_logic;
        negative        : in     vl_logic;
        overflow        : in     vl_logic;
        Taken           : out    vl_logic
    );
end PCBrControl;
