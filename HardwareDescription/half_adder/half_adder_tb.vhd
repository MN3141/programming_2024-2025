-- Testbench for Half Adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is
    signal A     : STD_LOGIC := '0';
    signal B     : STD_LOGIC := '0';
    signal Sum   : STD_LOGIC;
    signal Carry : STD_LOGIC;

    -- Instantiate the Half Adder
    component half_adder
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            Sum   : out STD_LOGIC;
            Carry : out STD_LOGIC
        );
    end component;

begin
    -- Map the Half Adder to signals
    uut: half_adder Port Map (
        A => A,
        B => B,
        Sum => Sum,
        Carry => Carry
    );

    -- Process to generate input stimulus
    stimulus: process
    begin
        A <= '0'; B <= '0'; wait for 10 ns;
        A <= '0'; B <= '1'; wait for 10 ns;
        A <= '1'; B <= '0'; wait for 10 ns;
        A <= '1'; B <= '1'; wait for 10 ns;
        wait;  -- end simulation
    end process;
end Behavioral;
