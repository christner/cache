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
begin

  output <= input3 and input2 and input1;

end structural;

--------------------------------------------------------------------------------------------------
