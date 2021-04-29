LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Módulo Half Adder
ENTITY halfAdder IS
  PORT (
    a : IN STD_LOGIC;
    b : IN STD_LOGIC;
    sum : OUT STD_LOGIC;
    carry : OUT STD_LOGIC);
END halfAdder;

ARCHITECTURE Behavioral OF halfAdder IS

BEGIN
  sum <= a XOR b;
  carry <= a AND b;
END Behavioral;