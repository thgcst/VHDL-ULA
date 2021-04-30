LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY redLedsHandle IS PORT (
  A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  result : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
END redLedsHandle;

ARCHITECTURE behav OF redLedsHandle IS

    SIGNAL SPACE : STD_LOGIC_VECTOR(2 downto 0);
BEGIN

    SPACE <= "000";

    LEDR <= A & SPACE & B & SPACE & result;
END behav;