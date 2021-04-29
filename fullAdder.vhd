LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Módulo Full Adder composto por 2 Half Adders
ENTITY fullAdder IS
  PORT (
    a : IN STD_LOGIC;
    b : IN STD_LOGIC;
    cin : IN STD_LOGIC;
    sum : OUT STD_LOGIC;
    cout : OUT STD_LOGIC);
END fullAdder;

ARCHITECTURE Behavioral OF fullAdder IS

  COMPONENT halfAdder IS
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      sum : OUT STD_LOGIC;
      carry : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL s_s, c1, c2 : STD_LOGIC;

BEGIN
  HA1 : halfAdder port map (a, b, s_s, c1);
  HA2 : halfAdder port map (s_s, cin, sum, c2);
  cout <= c1 OR c2;
END Behavioral;