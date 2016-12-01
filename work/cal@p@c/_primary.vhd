library verilog;
use verilog.vl_types.all;
entity calPC is
    port(
        PC              : in     vl_logic_vector(63 downto 0);
        PC_result       : out    vl_logic_vector(63 downto 0);
        CondAddr19      : in     vl_logic_vector(63 downto 0);
        BrAddr26        : in     vl_logic_vector(63 downto 0);
        ReadData2       : in     vl_logic_vector(63 downto 0);
        UncondBr        : in     vl_logic;
        BR              : in     vl_logic
    );
end calPC;
