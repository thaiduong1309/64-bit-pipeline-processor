library verilog;
use verilog.vl_types.all;
entity ZeroFlag is
    port(
        \out\           : out    vl_logic;
        \in\            : in     vl_logic_vector(63 downto 0)
    );
end ZeroFlag;
