library ieee;
use ieee.std_logic_1164.all;

-- Testbench entity
entity lab0_tb is
end lab0_tb;

architecture tb of lab0_tb is
    -- Signals to connect to the Device Under Test (DUT)
    signal a : std_logic := '0';
    signal b : std_logic := '0';
    signal s : std_logic_vector(1 downto 0) := "00";
    signal y : std_logic;

    -- Component declaration for the DUT
    component lab0
        port (
            a : in std_logic;
            b : in std_logic;
            s : in std_logic_vector(1 downto 0);
            y : out std_logic
        );
    end component;

begin
    -- Instantiate the DUT
    uut: lab0
        port map (
            a => a,
            b => b,
            s => s,
            y => y
        );

    -- Stimulus process to apply test cases
    stimulus: process
    begin
        -- Test Case 1: s = "00", a = 1, b = 0 -> y = not a
        a <= '1'; b <= '0'; s <= "00";
        wait for 10 ns;

        -- Test Case 2: s = "01", a = 1, b = 1 -> y = a and b
        a <= '1'; b <= '1'; s <= "01";
        wait for 10 ns;

        -- Test Case 3: s = "10", a = 0, b = 1 -> y = a or b
        a <= '0'; b <= '1'; s <= "10";
        wait for 10 ns;

        -- Test Case 4: s = "11", a = 0, b = 0 -> y = '0' (default)
        a <= '0'; b <= '0'; s <= "11";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;
end tb;
