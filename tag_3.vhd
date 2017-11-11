----------------------------------------------------------------------------------------------
--
-- Entity: tag
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/10/2017
-- Description:
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity tag is port (
    enable  : in std_logic;
    r_w     : in std_logic;
    data_in : in std_logic_vector(2 downto 0);
    data_out: out std_logic_vector(2 downto 0));
end tag;

architecture structural of tag is
component tag port (
    enable  : in std_logic;
    r_w     : in std_logic;
    data_in : in std_logic_vector;
    data_out: out std_logic_vector);
end component;

for bit_1, bit_2, bit_3: dff use entity work.dff(structural);

signal ctemp: std_logic_vector(2 downto 0);

begin



end structural;

----------------------------------------------------------------------------------------------
