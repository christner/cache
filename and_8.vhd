----------------------------------------------------------------------------------------------
--
-- Entity: and8
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/16/2017
-- Description: 8 input and gate
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity and_8 is port (
    input1: in  std_logic;
    input2: in  std_logic;
    input3: in  std_logic;
    input4: in  std_logic;
    input5: in  std_logic;
    input6: in  std_logic;
    input7: in  std_logic;
    input8: in  std_logic;
    output: out std_logic);
end and_8;

architecture structural of and_8 is

    component and_2 port (
        input1 : in std_logic;
        input2 : in std_logic;
        output: out std_logic);
    end component;

    component and_4 port (
        input1 : in std_logic;
        input2 : in std_logic;
        input3 : in std_logic;
        input4 : in std_logic;
        output: out std_logic);
    end component;

    for and_4_0, and_4_1  : and_4 use entity work.and_4(structural);

    for and_2_0 : and_2 use entity work.and_2(structural);

    signal tmp_and_4_0, tmp_and_4_1 : std_logic;

begin

    and_4_0 : and_4 port map(input1, input2, input3, input4, tmp_and_4_0);
    and_4_1 : and_4 port map(input5, input6, input7, input8, tmp_and_4_1);

    and_2_0 : and_2 port map(tmp_and_4_0, tmp_and_4_1, output);


end structural;
