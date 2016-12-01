library verilog;
use verilog.vl_types.all;
entity D_FF1_testbench is
    generic(
        CLOCK_PERIOD    : integer := 2500
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_PERIOD : constant is 1;
end D_FF1_testbench;
