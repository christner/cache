----------------------------------------------------------------------------------------------
--
-- Entity: adder4
-- Architecture : structural
-- Author: cpatel2
-- Created On: 10/21/2004
-- Description:
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity xnor_2 is port (
input1 : in std_logic;
input2 : in std_logic;
output : out std_logic);
end xnor_2;

architecture structural of xnor_2 is
  component xor_2 port (
  input1 : in std_logic;
  input2 : in std_logic;
  output : out std_logic
  ); end component;

  component inverter port (
  input : in std_logic;
  output: out std_logic
  ); end component;

for inv1 : inverter use entity work.inverter(structural);
for xor1 : xor_2 use entity work.xor_2(structural);

signal t : std_logic;
begin
  xor1 : xor_2 port map (input1, input2, t);
  inv1 : inverter port map (t, output);


end structural;
