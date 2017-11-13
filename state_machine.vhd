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

component jkff port (
J : in std_logic;
K : in std_logic;
Clk : in std_logic;
Q : out std_logic );
end component;

for and1, and2, and3, and4, and5, and6, and7, and8, and9, and10, and11, and12: and_2 use entity work.and_2(structural);
for and_3_1: and_3 use entity work.and_3(structural);
for or1, or2, or3, or4, or5, or6, or7, or8, or9, or10 : or2 use entity work.or2(structural);
for nand1, nand2, nand3, nand4 : nand_2 use entity work.nand_2(structural);
for inv1, inv2, inv3 : inverter use entity work.inverter(structual);
for ffA, ffB, ffC : jkff use entity work.jkff(structural);

signal Ja_o, Ja1, Ja2, Ja3, Ja4 : std_logic;
signal Ka_o, Ka1, Ka2 : std_logic;
signal Jb_0, Jb1, Jb2, Jb3, Jb4, Jb5, Jb6 : std_logic;
signal Kb_o, Kb1, Kb2 : std_logic;
signal Jc_o, Jc1, Jc2, Jc3, Jc4, Jc5, Jc6, Jc7 : std_logic;
signal Kc_o, Kc1, Kc2, Kc3, Kc4 : std_logic;
signal currstate, nextstate : std_logic_vector(2 downto 0);
begin
  -- J Logic NextState(2)
  nand1: nand_2 port map (START, RdWr, Ja1);
  and1: and_2 port map (currstate(2), Ja1, Ja2);
  or1 : or2 port map (currstate(1), Ja2, Ja3);
  inv1: inverter port map (REST, Ja4);
  and_3_1 : and_3 port map (Ja3, Ready, Ja4, Ja_o);

  -- K Logic NextState(2)
  or2: or2 port map (currstate(1), currstate(0), Ka1);
  and2: and_2 port map (Ka1, Ready, Ka2);
  or3: or2 port map (Ka2, RESET, Ka_o);

  -- J Logic NextState(1)
  nand2 : nand_2 port map(currstate(2), RESET, Jb1);
  and3: and_2 port map (Jb1, Ready, Jb2);
  and4: and_2 port map (currstate(0), HitMiss, Jb3);
  nand3: nand_2 port map (currstate, RdWr, Jb4);
  and5: and_2 port map (Jb4, START, Jb5);
  or4: or2 port map (Jb5, Jb3, Jb6);
  and6: and_2 port map (Jb6, Jb2, Jb_o);

  -- K Logic NExtState(1)
  or5: or2 port map (currstate(0), currstate(2), Kb1);
  and7: and_2 port map (Kb1, Ready, Kb2);
  or6: or2 port map (Kb2, RESET, Kb_o);

  -- J Logic NextState(0)
  and8: and_2 port map (START, RdWr, Jc1);
  or7: or2 port map (Jc1, currstate(2), Jc2);
  inv2: inverter port map (currstate(1), Jc3);
  and9: and_2 port map (Jc3, Jc2, Jc4);
  and10: and_2 port map (currstate(1), HitMiss, Jc5);
  or8: or2 port map (Jc5, Jc4, Jc6);
  inv3: inverter port map (RESET, Jc7);
  and_3_1: and_3 port map (Jc6, Ready, Jc7,, Jc_o);

  -- K Logic NexState(0)
  nand4 : nand_2 port map (currstate(2), HitMiss, Kc1);
  and11: and_2 port map (currstate(1), currstate(0), Kc2);
  or9: or2 port map (Kc1, Kc2, Kc3);
  and12: and_2 port map (Kc3, Ready, Kc4);
  or10: or2 port map (Kc4, RESET, Kc_o);

  -- JK Flip Flops
  ffA : jkff port map (Ja_o, Ka_o, CLOCK, nextstate(2));
  ffB : jkff port map (Jb_o, Kb_o, CLOCK, nextstate(1));
  ffC : jkff port map (Jc_o, Kc_o, CLOCK, nextstate(0));

  -- TODO:
  -- need to latch nextstate to currstate
  -- handle "wait" state
end structural;
