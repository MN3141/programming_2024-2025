library ieee;
use ieee.std_logic_1164.all; --include arrays

entity notgate is
    Port( 
    A : in std_logic;
    Y : out std_logic
    );
    end notgate;
    architecture Behavioral of notgate is
    begin
    Y<= not A ;
    end Behavioral;