library verilog;
use verilog.vl_types.all;
entity DFF_REG_testbench is
    generic(
        CLOCK_PERIOD    : integer := 100
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_PERIOD : constant is 1;
end DFF_REG_testbench;
