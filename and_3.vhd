----------------------------------------------------------------------------------------------------
--
-- Entity: and3
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/17/2017
-- Description:
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity and_3 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in  std_logic;
    output   : out std_logic);
end and_3;

architecture structural of and_3 is

    component and_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    for and_2_0, and_2_1 : and_2 use entity work.and_2(structural);

    signal tmp_and_2_0 : std_logic;

begin

    and_2_0 : and_2 port map(input1, input2, tmp_and_2_0);
    and_2_1 : and_2 port map(input3, tmp_and_2_0, output);

end structural;

--------------------------------------------------------------------------------------------------
