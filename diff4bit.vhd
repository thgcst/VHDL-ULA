LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY diff4bit IS PORT (
  A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  carry : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END diff4bit;

ARCHITECTURE hardware OF diff4bit IS

  SIGNAL RESULT_AUX : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Sinal auxiliar de subtração
  SIGNAL CARRY_AUX : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Sinal auxiliar de Carry out

  -- Módulo Full Adder
  COMPONENT fullAdder IS
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      cin : IN STD_LOGIC;
      sum : OUT STD_LOGIC;
      cout : OUT STD_LOGIC);
  END COMPONENT;

BEGIN

  -- Full adders propagando o carry
  
  -- Como a operação é de subtração, o Carry In inicial é '1'
  -- e o operador B é negado
  bit0 : fullAdder port map (A(0), NOT b(0), '1', RESULT_AUX(0), CARRY_AUX(0));
  bit1 : fullAdder port map (A(1), NOT b(1), CARRY_AUX(0), RESULT_AUX(1), CARRY_AUX(1));
  bit2 : fullAdder port map (A(2), NOT b(2), CARRY_AUX(1), RESULT_AUX(2), CARRY_AUX(2));
  bit3 : fullAdder port map (A(3), NOT b(3), CARRY_AUX(2), RESULT_AUX(3), CARRY_AUX(3));
  

  result <= RESULT_AUX;
  carry <= CARRY_AUX;
END hardware;