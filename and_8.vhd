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

entity and8 is port (
    input1: in  std_logic;
    input2: in  std_logic;
    input3: in  std_logic;
    input4: in  std_logic;
    input5: in  std_logic;
    input6: in  std_logic;
    input7: in  std_logic;
    input8: in  std_logic;
    output: out std_logic);
end and8;

architecture structural of and8 is
begin

output <= input8 and input7 and input6 and input5 and input4 and input3 and input2 and input1;

end structural;
