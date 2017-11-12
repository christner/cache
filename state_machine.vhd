library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity state_machine is port (
  START : in std_logic;
  RESET : in std_logic;
  HitMiss : in std_logic;
  RdWr : in std_logic;
  Ready : in std_logic;

  BUSY : out std_logic
); end state_machine;

architecture structural of state_machine is
component and_2 port (
input1   : in  std_logic;
input2   : in  std_logic;
output   : out std_logic);
end component;

component nand_2 port (
input1   : in  std_logic;
input2   : in  std_logic;
output   : out std_logic);
end component;

component or2 port (
input1   : in  std_logic;
input2   : in  std_logic;
output   : out std_logic);
end component;

for and1, and2, and3, and4, and5, and6, and7, and8, and9, and10, and11: and_2 use entity work.and_2(structural);
for and_3_1: and_3 use entity work.and_3(structural);
for or1, or2, or3 : or2 use entity work.or2(structural);
for nand1 : nand_2 use entity work.nand_2(structural);
for inv1 : inverter use entity work.inverter(structual);

signal Ja_o, Ja1, Ja2, Ja3, Ja4 : std_logic;
signal Ka_o, Ka1, Ka2 : std_logic;
signal currstate, nextstate : std_logic_vector(2 downto 0);
begin
  -- J Logic NextState(2)
  nand1: nand_2 port map (START, RdWr, Ja1);
  and1: and port map (currstate(2), Ja1, Ja2);
  or1 : or2 port map (currstate(1), Ja2, Ja3);
  inv1: inverter port map (REST, Ja4);
  and_3_1 : and_3 port map (Ja3, Ready, Ja4, Ja_o);

  -- K Logic NextState(2)
  or2: or2 port map (currstate(1), currstate(0), Ka1);
  and2: and port map (Ka1, Ready, Ka2);
  or3: or2 port map (Ka2, RESET, Ka_o);

  -- J Logic NextState(1)
  and3: and port map ();
  and4: and port map ();
  and5: and port map ();
  and6: and port map ();

  and7: and port map ();

  and8: and port map ();
  and9: and port map ();
  and10: and port map ();

  and11: and port map ();

end structural;
