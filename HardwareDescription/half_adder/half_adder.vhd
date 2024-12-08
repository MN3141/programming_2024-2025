-- Half Adder VHDL Code
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for Half Adder
entity half_adder is
    Port (
        A     : in  STD_LOGIC;  -- First input bit
        B     : in  STD_LOGIC;  -- Second input bit
        Sum   : out STD_LOGIC;  -- Sum output
        Carry : out STD_LOGIC   -- Carry output
    );
end half_adder;

-- Architecture definition
architecture Behavioral of half_adder is
begin
    -- Define the behavior for Sum and Carry outputs
    Sum   <= A XOR B;         -- Sum is the XOR of A and B
    Carry <= A AND B;         -- Carry is the AND of A and B
end Behavioral;
