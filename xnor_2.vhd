----------------------------------------------------------------------------------------------------
--
-- Entity: xnor_2
-- Architecture : structural
-- Author: katieb5/danielc3
-- Created On: 11/11/2017
-- Description: 2 input xnor gate
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity xnor_2 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end xnor_2;

architecture structural of xnor_2 is

  component inverter port (
      input : in std_logic;
      output: out std_logic);
  end component;

  component xor_2 port (
      input1   : in  std_logic;
      input2   : in  std_logic;
      output   : out std_logic);
  end component;

    for inverter_0 : inverter use entity work.inverter(structural);

    for xor_2_0 : xor_2 use entity work.xor_2(structural);

    signal tmp : std_logic;

begin

    xor_2_0 : xor_2 port map (input1, input2, tmp);

    inverter_0 : inverter port map (tmp, output);

end structural;

----------------------------------------------------------------------------------------------------
