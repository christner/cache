---------------------------------------------------------------------------------------------
--
-- Entity: adder1
-- Architecture : structural
-- Author: cpatel2
-- Created On: 10/21/2004
-- Description:
--
---------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity adder_1 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    carryin  : in  std_logic;
    sum      : out std_logic;
    carryout : out std_logic);
end adder_1;

architecture structural of adder_1 is

component xor_2 port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end component;

component and_2 port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end component;

component or_3 port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in  std_logic;
    output   : out std_logic);
end component;

for xor2_1, xor2_2: xor_2 use entity work.xor_2(structural);
for and2_1, and2_2, and2_3: and_2 use entity work.and_2(structural);
for or3_1: or_3 use entity work.or_3(structural);

signal temp1, temp2, temp3, temp4: std_logic;
begin

    xor2_1: xor_2 port map (input1, input2, temp1);
    xor2_2: xor_2 port map (carryin, temp1, sum);

    and2_1: and_2 port map (input1, input2, temp2);
    and2_2: and_2 port map (input1, carryin, temp3);
    and2_3: and_2 port map (input2, carryin, temp4);

    or3_1: or_3 port map (temp2, temp3, temp4, carryout);

end structural;

----------------------------------------------------------------------------------------------
