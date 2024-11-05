library ieee;
use ieee.std_logic_1164.all; --include arrays

entity  and_gate is
    port(
        A:in std_logic;
        B:in std_logic;
        Y:out std_logic
    );
end and_gate;

architecture and_arch of and_gate is
    begin
        Y<=A and B;
    end and_arch;