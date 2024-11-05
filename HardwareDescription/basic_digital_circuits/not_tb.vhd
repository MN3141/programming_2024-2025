library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity not_tb is
--  Port ( );
end not_tb;

architecture notLogic of not_tb is
--Component name and entity's name must be same
--ports must be same 
    component notGate is
    Port (A:in std_logic;
    Y: out std_logic );
end component;

--inputs
signal a: std_logic:= '0';
--outputs
signal y : std_logic;

begin
    uut: notGate PORT MAP(a=>A,y=>Y);
    --Stimulus Process
    stim_proc:process
begin

    wait for 10 ns;
    a<='1';
    wait for 10 ns;
    a<='0';
    wait for 10 ns;

    wait;  -- Halts the process and effectively ends the simulation
    end process;

end notLogic;