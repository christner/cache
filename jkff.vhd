----------------------------------------------------------------------------------------------
--
-- Entity: jkff
-- Architecture : structural
-- Author: katieb5
-- Created On: 11/10/2017
-- Description: jk flip flop
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity jkff is port (
    J   : in  std_logic;
    K   : in  std_logic;
    Clk : in  std_logic;
    Q   : out std_logic);
end jkff;

architecture structural of jkff is

signal temp : std_logic;

begin
  Q <= temp;
  jk_flipflop: process (J, K, Clk)
  begin
    if  falling_edge(Clk) then
     if    (J='0' and K='0') then
       temp <= temp;
     elsif (J='0' and K='1') then
       temp <= '0';
     elsif (J='1' and K='1') then
       temp <= not (temp);
     elsif (J='1' and K='0') then
       temp <= '1';
     end if;
   end if;
 end process jk_flipflop;


end structural;

----------------------------------------------------------------------------------------------
