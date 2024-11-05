library ieee;
use ieee.std_logic_1164.all;

entity mux_tb is
end mux_tb;

architecture behavior of mux_tb is

    -- Signal Declarations for connecting to the DUT
    signal A : std_logic := '0';
    signal B : std_logic := '0';
    signal S : std_logic := '0';
    signal Y : std_logic;

    -- Component Declaration for the Unit Under Test (UUT)
    component mux
        port(
            A : in std_logic;
            B : in std_logic;
            S : in std_logic;
            Y : out std_logic
        );
    end component;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: mux port map (
        A => A,
        B => B,
        S => S,
        Y => Y
    );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: S = '0', A = '0', B = '0' => Y should be '0'
        A <= '0';
        B <= '0';
        S <= '0';
        wait for 10 ns;
        assert (Y = '0')
            report "Test Case 1 Failed: S=0, A=0, B=0, Expected Y=0"
            severity error;

        -- Test Case 2: S = '0', A = '1', B = '0' => Y should be '1'
        A <= '1';
        B <= '0';
        S <= '0';
        wait for 10 ns;
        assert (Y = '1')
            report "Test Case 2 Failed: S=0, A=1, B=0, Expected Y=1"
            severity error;

        -- Test Case 3: S = '1', A = '0', B = '1' => Y should be '1'
        A <= '0';
        B <= '1';
        S <= '1';
        wait for 10 ns;
        assert (Y = '1')
            report "Test Case 3 Failed: S=1, A=0, B=1, Expected Y=1"
            severity error;

        -- Test Case 4: S = '1', A = '1', B = '1' => Y should be '1'
        A <= '1';
        B <= '1';
        S <= '1';
        wait for 10 ns;
        assert (Y = '1')
            report "Test Case 4 Failed: S=1, A=1, B=1, Expected Y=1"
            severity error;

        -- Test Case 5: S = '0', A = '0', B = '1' => Y should be '0'
        A <= '0';
        B <= '1';
        S <= '0';
        wait for 10 ns;
        assert (Y = '0')
            report "Test Case 5 Failed: S=0, A=0, B=1, Expected Y=0"
            severity error;

        -- Test Case 6: S = '1', A = '0', B = '0' => Y should be '0'
        A <= '0';
        B <= '0';
        S <= '1';
        wait for 10 ns;
        assert (Y = '0')
            report "Test Case 6 Failed: S=1, A=0, B=0, Expected Y=0"
            severity error;

        -- End of testbench
        report "All test cases passed." severity note;
        wait;
    end process;

end behavior;
