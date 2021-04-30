LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

-- LEDG(0) : Overflow;
-- LEDG(1) : Carry Out;
-- LEDG(2) : Negative;
-- LEDG(3) : Zero;

ENTITY flagsHandle IS PORT (
  A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  sum_result : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  sum_carry : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  subtract_result : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  subtract_carry : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  selection : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  LEDG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END flagsHandle;

ARCHITECTURE behav OF flagsHandle IS

  SIGNAL B_TWO_COMPLIMENT : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Complemento a 2 de B

BEGIN
  PROCESS (A,B,sum_result, sum_carry, subtract_result, subtract_carry, B_TWO_COMPLIMENT,selection)
  BEGIN
    LEDG <= "0000";
    B_TWO_COMPLIMENT <= ((NOT B) + "0001");

    IF (selection = "000") THEN -- Se a operação é Soma...
      -- Sum operation Overflow:
      IF (A(3) = '0') AND (B(3) = '0') AND (sum_result(3) = '1') THEN
        LEDG(0) <= '1';
      END IF;
      IF (A(3) = '1') AND (B(3) = '1') AND (sum_result(3) = '0') THEN
        LEDG(0) <= '1';
      END IF;

      -- Sum operation Carry:
      IF (sum_carry(3) = '1') THEN
        LEDG(1) <= '1';
      END IF;

      -- Sum operation Negative:
      IF (sum_result(3) = '1') THEN
        LEDG(2) <= '1';
      END IF;

      -- Sum operation Zero:
      IF (sum_result = "0000") THEN
        LEDG(3) <= '1';
      END IF;
    END IF;

    IF (selection = "001") THEN -- Se a operação é subtração...

      -- Subtract operation Overflow:
      IF (A(3) = '0') AND (B_TWO_COMPLIMENT(3) = '0') AND (subtract_result(3) = '1') THEN
        LEDG(0) <= '1';
      END IF;
      IF (A(3) = '1') AND (B_TWO_COMPLIMENT(3) = '1') AND (subtract_result(3) = '0') THEN
        LEDG(0) <= '1';
      END IF;

      -- Subtract operation Carry:
      IF (subtract_carry(3) = '1') THEN
        LEDG(1) <= '1';
      END IF;

      -- Subtract operation Negative:
      IF (subtract_result(3) = '1') THEN
        LEDG(2) <= '1';
      END IF;

      -- Subtract operation Zero:
      IF (subtract_result = "0000") THEN
        LEDG(3) <= '1';
      END IF;
    END IF;


  END PROCESS;
END behav;