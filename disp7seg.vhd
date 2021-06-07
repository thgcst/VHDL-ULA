LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY disp7seg IS PORT (
  hex_digit : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Binário a ser exibido como Hexadecimal
  segment_7dis : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Display a exibir o valor absoluto
  minus : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- Display a exibir o sinal de negativo (caso seja)
);
END disp7seg;

ARCHITECTURE arch_dec OF disp7seg IS
  SIGNAL segment_data : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
  PROCESS (hex_digit)
  BEGIN
    IF (hex_digit(3) = '1') THEN -- Caso seja negativo
      minus <= "0111111"; -- Exibe o sinal de negativo no display correspondente
    ELSE
      minus <= "1111111"; -- Não exibe nada
    END IF;

    CASE hex_digit IS -- Exibe o valor absoluto no display de 7 segmentos
      WHEN "0000" => segment_data <= "1000000";
      WHEN "0001" => segment_data <= "1111001";
      WHEN "0010" => segment_data <= "0100100";
      WHEN "0011" => segment_data <= "0110000";
      WHEN "0100" => segment_data <= "0011001";
      WHEN "0101" => segment_data <= "0010010";
      WHEN "0110" => segment_data <= "0000010";
      WHEN "0111" => segment_data <= "1111000";
      WHEN "1000" => segment_data <= "0000000";
      WHEN "1001" => segment_data <= "1111000";
      WHEN "1010" => segment_data <= "0000010";
      WHEN "1011" => segment_data <= "0010010";
      WHEN "1100" => segment_data <= "0011001";
      WHEN "1101" => segment_data <= "0110000";
      WHEN "1110" => segment_data <= "0100100";
      WHEN "1111" => segment_data <= "1111001";
      WHEN OTHERS => segment_data <= "1111111";
    END CASE;

  END PROCESS;
  segment_7dis <= segment_data;
END arch_dec;