library ieee;
use ieee.std_logic_1164.all;

entity and_gate_tb is
end and_gate_tb;

architecture behavior of and_gate_tb is

    -- Signal Declarations for connecting to the DUT
    signal A : std_logic := '0';
    signal B : std_logic := '0';
    signal Y : std_logic;

    -- Component Declaration for the Unit Under Test (UUT)
    component and_gate
        port(
            A : in std_logic;
            B : in std_logic;
            Y : out std_logic
        );
    end component;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: and_gate port map (
        A => A,
        B => B,
        Y => Y
    );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: A = '0', B = '0' => Y should be '0'
        A <= '0';
        B <= '0';
        wait for 10 ns;
        assert (Y = '0')
            report "Test Case 1 Failed: A=0, B=0, Expected Y=0"
            severity error;

        -- Test Case 2: A = '0', B = '1' => Y should be '0'
        A <= '0';
        B <= '1';
        wait for 10 ns;
        assert (Y = '0')
            report "Test Case 2 Failed: A=0, B=1, Expected Y=0"
            severity error;

        -- Test Case 3: A = '1', B = '0' => Y should be '0'
        A <= '1';
        B <= '0';
        wait for 10 ns;
        assert (Y = '0')
            report "Test Case 3 Failed: A=1, B=0, Expected Y=0"
            severity error;

        -- Test Case 4: A = '1', B = '1' => Y should be '1'
        A <= '1';
        B <= '1';
        wait for 10 ns;
        assert (Y = '1')
            report "Test Case 4 Failed: A=1, B=1, Expected Y=1"
            severity error;

        -- End of testbench
        report "All test cases passed." severity note;
        wait;
    end process;

end behavior;
