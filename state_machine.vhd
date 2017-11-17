library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity state_machine is port (
  START : in std_logic;
  RESET : in std_logic;
  HitMiss : in std_logic;
  RdWr : in std_logic;
  CLOCK : in std_logic;
  BUSY : out std_logic;
  CacheEnable : out std_logic;
  MemEnable : out std_logic
); end state_machine;

architecture structural of state_machine is
component and_2 port (
input1   : in  std_logic;
input2   : in  std_logic;
output   : out std_logic);
end component;

component and_3 port (
input1 : in std_logic;
input2 : in std_logic;
input3 : in std_logic;
output : out std_logic
); end component;

component and_4 port (
input1 : in std_logic;
input2 : in std_logic;
input3 : in std_logic;
input4 : in std_logic;
output : out std_logic
); end component;

component and_5 port (
input1 : in std_logic;
input2 : in std_logic;
input3 : in std_logic;
input4 : in std_logic;
input5 : in std_logic;
output : out std_logic
); end component;

component nand_2 port (
input1   : in  std_logic;
input2   : in  std_logic;
output   : out std_logic);
end component;

component nand_3 port (
input1 : in std_logic;
input2 : in std_logic;
input3 : in std_logic;
output : out std_logic
); end component;
-- TODO:
  -- need to latch nextstate to currstate
  -- handle "wait" state
component xor_2 port (
input1 : in std_logic;
input2 : in std_logic;
output : out std_logic
); end component;

component or_2 port (
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

component nor_2 port (
input1   : in  std_logic;
input2   : in  std_logic;
output   : out std_logic);
end component;

component xnor_2 port (
input1 : in std_logic;
input2 : in std_logic;
output : out std_logic
); end component;

component jkff port (
J : in std_logic;
K : in std_logic;
Clk : in std_logic;
rst : in std_logic;
Q : out std_logic );
end component;

component dlatch port (
d : in std_logic;
clk : in std_logic;
q : out std_logic;
qbar : out std_logic);
end component;

component inverter port (
input : in std_logic;
output: out std_logic
); end component;

for and2, and3, and4, and5, and6, and7, and11, and12: and_2 use entity work.and_2(structural);
for wblk2, and3_jc, and3_jc1, and3_jc2: and_3 use entity work.and_3(structural);
for and4_1 : and_4 use entity work.and_4(structural);
for and5_1 : and_5 use entity work.and_5(structural);
for or1, or2, or3, or4, or5, or6, or9, or10 : or_2 use entity work.or_2(structural);
for inv1, inv1a, inv1b, inv1c, inv2j, inv3j, inv4j, wblk1 : inverter use entity work.inverter(structural);
for ffA, ffB, ffC : jkff use entity work.jkff(structural);
for dl1, dl2, dl3 : dlatch use entity work.dlatch(structural);

for or_busy, or3_jc : or_3 use entity work.or_3(structural);
for and00, andjc : and_2 use entity work.and_2(structural);

-- counter gates
for and_crst : and_3 use entity work.and_3(structural);
for xor_crst1, xor_crst2, xor_crst3 : xor_2 use entity work.xor_2(structural);
for or_crst, or_crst_o : or_3 use entity work.or_3(structural);
for counter1, counter2, counter3, counter4 : jkff use entity work.jkff(structural);
for waitTime3a, waitTime1, waitTime0b : and_2 use entity work.and_2(structural);
for xnorrdy1, xnorrdy2, xnorrdy3, xnorrdy4 : xnor_2 use entity work.xnor_2(structural);
for andready : and_4 use entity work.and_4(structural);
for waitTime0 : or_2 use entity work.or_2(structural);
for waitTime2, invc1, invc2, invc3 : inverter use entity work.inverter(structural);
for waitTime3, waitTime0a, invclock : inverter use entity work.inverter(structural);

for nor1, nor2, nor3, nor5, nor6 : nor_2 use entity work.nor_2(structural);

signal wb0,b1 : std_logic;

signal Ja_o, Ja1, Ja2, Ja3, Ja4, Ja5, Ja6 : std_logic;
signal Ka_o, Ka1, Ka2 : std_logic;
signal Jb_o, Jb1, Jb2, Jb3, Jb4, Jb5, Jb6, Jc7 : std_logic;
signal Kb_o, Kb1, Kb2 : std_logic;
signal Jc_o, Jc1, Jc2, Jc3, Jc4, Jc5, Jc6 : std_logic;
signal Kc_o, Kc1, Kc2, Kc3, Kc4 : std_logic;
signal currstate, nextstate : std_logic_vector(2 downto 0);
signal w2, w3 : std_logic;

signal counterReset : std_logic;
signal Ready : std_logic;
signal waitTime : std_logic_vector(3 downto 0);
signal c_xor_n_1, c_xor_n_2, c_xor_n_3, c_or_n, notabc : std_logic;
signal c1, c2, c3 : std_logic;
signal outq1, outq2, outq3, outq4 : std_logic;
signal ready1, ready2, ready3, ready4 : std_logic;
signal wt1, wt2, wt3, wt4 : std_logic;
signal one : std_logic := '1';
signal zero : std_logic := '0';
signal invclk : std_logic;
begin
  -- CacheEnable Signal
  nor5 : nor_2 port map (currstate(2), currstate(0), CacheEnable);

  -- BUSY Signal
  or_busy : or_3 port map (currstate(2), currstate(1), currstate(0), BUSY);

  -- MemEnable Signal
  nor6 : nor_2 port map (currstate(0), currstate(1), w3);
  and00 : and_2 port map (w3, currstate(2), MemEnable);

  -- J Logic NextState(2)
  inv1: inverter port map (RESET, Ja1); -- ~RESET
  inv1a : inverter port map (currstate(0), Ja2); -- ~C
  inv1b : inverter port map (currstate(1), Ja3); -- ~B
  inv1c : inverter port map (HitMiss, Ja4); -- ~HitMiss

  and4_1 : and_4 port map (currstate(1), Ja2, Ja1, Ready, Ja5);
  and5_1 : and_5 port map (Ja3, currstate(0), Ja1, Ja4, Ready, Ja6);
  or1 : or_2 port map (Ja5, Ja6, Ja_o);



  -- K Logic NextState(2)
  or2: or_2 port map (currstate(1), currstate(0), Ka1);
  and2: and_2 port map (Ka1, Ready, Ka2);
  or3: or_2 port map (Ka2, RESET, Ka_o);

  -- J Logic NextState(1)
  nor2 : nor_2 port map(currstate(2), RESET, Jb1);
  and3: and_2 port map (Jb1, Ready, Jb2);
  and4: and_2 port map (currstate(0), HitMiss, Jb3);
  nor3: nor_2 port map (currstate(0), RdWr, Jb4);
  and5: and_2 port map (Jb4, START, Jb5);
  or4: or_2 port map (Jb5, Jb3, Jb6);
  and6: and_2 port map (Jb6, Jb2, Jb_o);

  -- K Logic NExtState(1)
  or5: or_2 port map (currstate(0), currstate(2), Kb1);
  and7: and_2 port map (Kb1, Ready, Kb2);
  or6: or_2 port map (Kb2, RESET, Kb_o);

  -- J Logic NextState(0)
  inv2j: inverter port map (currstate(1), Jc1); -- ~B
  inv3j: inverter port map (RESET, Jc2); -- ~RESET
  inv4j: inverter port map (currstate(2), Jc3); -- ~A
  and3_jc: and_3 port map (Jc1, START, RdWr, Jc4);
  and3_jc1: and_3 port map (Jc3, currstate(1), HitMiss, Jc5);
  andjc : and_2 port map (currstate(2), Jc1, Jc6);
  or3_jc : or_3 port map (Jc4, Jc5, Jc6, Jc7);
  and3_jc2: and_3 port map (Jc7, Jc2, Ready, Jc_o);


  -- K Logic NexState(0)
  nor1 : nor_2 port map (currstate(2), HitMiss, Kc1);
  and11: and_2 port map (currstate(1), currstate(0), Kc2);
  or9: or_2 port map (Kc1, Kc2, Kc3);
  and12: and_2 port map (Kc3, Ready, Kc4);
  or10: or_2 port map (Kc4, RESET, Kc_o);

  -- JK Flip Flops
  ffA : jkff port map (Ja_o, Ka_o, CLOCK, RESET, nextstate(2));
  ffB : jkff port map (Jb_o, Kb_o, CLOCK, RESET, nextstate(1));
  ffC : jkff port map (Jc_o, Kc_o, CLOCK, RESET, nextstate(0));

  -- Latch next state to current state
  dl1 : dlatch port map (nextstate(2), CLOCK, currstate(2));
  dl2 : dlatch port map (nextstate(1), CLOCK, currstate(1));
  dl3 : dlatch port map (nextstate(0), CLOCK, currstate(0));

  -- Set counterReset
  invclock : inverter port map (CLOCK, invclk);
  invc1 : inverter port map (currstate(0), c1);
  invc2 : inverter port map (currstate(1), c2);
  invc3 : inverter port map (currstate(2), c3);
  and_crst : and_3 port map (c1, c2, c3, notabc);
  xor_crst1 : xor_2 port map (currstate(0), nextstate(0), c_xor_n_1);
  xor_crst2 : xor_2 port map (currstate(1), nextstate(1), c_xor_n_2);
  xor_crst3 : xor_2 port map (currstate(2), nextstate(2), c_xor_n_3);
  or_crst : or_3 port map (c_xor_n_1, c_xor_n_2, c_xor_n_3, c_or_n);
  or_crst_o : or_3 port map (notabc, RESET, c_or_n, counterReset);

  counter1 : jkff port map (one, one, invclk, counterReset, outq1);
  counter2 : jkff port map (one, one, outq1, counterReset, outq2);
  counter3 : jkff port map (one, one, outq2, counterReset, outq3);
  counter4 : jkff port map (one, one, outq3, counterReset, outq4);

  xnorrdy1 : xnor_2 port map (outq4, waitTime(3), ready1);
  xnorrdy2 : xnor_2 port map (outq3, zero, ready2);
  xnorrdy3 : xnor_2 port map (outq2, waitTime(1), ready3);
  xnorrdy4 : xnor_2 port map (outq1, waitTime(0), ready4);

  andready : and_4 port map (ready1, ready2, ready3, ready4, Ready);

  waitTime3 : inverter port map (currstate(1), wt1);
  waitTime3a: and_2 port map (currstate(2), wt1, waitTime(3));
  waitTime2: inverter port map (one, waitTime(2));
  waitTime1: and_2 port map (currstate(2), currstate(1), waitTime(1));
  waitTime0: or_2 port map (currstate(1), currstate(0), wt3);
  waitTime0a: inverter port map (currstate(2), wt4);
  waitTime0b: and_2 port map (wt3, wt4, waitTime(0));
  -- End counter logic

end structural;
