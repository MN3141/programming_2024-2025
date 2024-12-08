library ieee;
use ieee.std_logic_1164.all; -- Include arrays

entity lab0 is
    port (
        a : in std_logic;
        b : in std_logic;
        s : in std_logic_vector(1 downto 0);
        y : out std_logic
    );
end lab0;

architecture arch_lab0 of lab0 is
begin
    with s select
        y <= not a     when "00",
             a and b   when "01",
             a or b    when "10",
             '0'       when others; -- Missing semicolon added here
end arch_lab0;