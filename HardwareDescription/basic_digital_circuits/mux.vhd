library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port(
        signal A,B,S:in std_logic;
        signal Y:out std_logic
    );
end mux;

architecture mux_arch of mux is
    begin
        with S select
            Y<=A when '0',
              B when others;
    end mux_arch;  