library verilog;
use verilog.vl_types.all;
entity PCControl is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        zero            : in     vl_logic;
        flag            : in     vl_logic_vector(3 downto 0);
        BrTaken         : out    vl_logic
    );
end PCControl;
