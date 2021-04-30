LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY main IS PORT (
  G_CLOCK_50 : IN STD_LOGIC;
  SW : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  LEDG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
  HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END main;

ARCHITECTURE hardware OF main IS

  SIGNAL RESULT : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Resultado das operações
  SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Operando A
  SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Operando B
  SIGNAL selection : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Operação selecionada
  SIGNAL sum_result : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Resultado da soma
  SIGNAL sum_carry : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Carry Out da soma
  SIGNAL subtract_result : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Resultado da subtração
  SIGNAL subtract_carry : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Carry Out da subtração

  -- Módulo Display de 7 segmentos
  COMPONENT dec7seg IS PORT (
    hex_digit : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    segment_7dis : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    minus : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
  END COMPONENT;

  -- Módulo soma de 4 bits
  COMPONENT sum4bit IS PORT (
    A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    carry : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  -- Módulo subtração de 4 bits
  COMPONENT diff4bit IS PORT (
    A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    carry : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  -- Módulo Clock que atualiza os operandos A e B
  COMPONENT clock IS PORT (
    G_CLOCK_50 : IN STD_LOGIC;
    numberA : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    numberB : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  -- Módulo que lida com as flags
  COMPONENT flagsHandle IS PORT (
    A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    sum_result : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    sum_carry : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    subtract_result : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    subtract_carry : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    selection : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    LEDG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

  -- Módulo que lida com os Leds vermelhos
  COMPONENT redLedsHandle IS PORT (
    A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    result : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
    );
  END COMPONENT;

BEGIN

  auto_clock : clock port map (G_CLOCK_50, A, B);
  selection <= SW(2 DOWNTO 0); -- A operação é selecionada nos 3 primeiros switches

  sum : sum4bit port map (A, B, sum_result, sum_carry);
  diff : diff4bit port map (A, B, subtract_result, subtract_carry);

  flags : flagsHandle port map (
    A,
    B,
    sum_result,
    sum_carry,
    subtract_result,
    subtract_carry,
    selection,
    LEDG
  );

  WITH selection SELECT RESULT <=
    sum_result WHEN "000",
    subtract_result WHEN "001",
    A AND B WHEN "010",
    A OR B WHEN "011",
    A XOR B WHEN "100",
    A XNOR B WHEN "101",
    NOT A WHEN "110",
    NOT B WHEN "111",
    "0000" WHEN OTHERS;

  digitRESULT_7segments : dec7seg port map (RESULT, HEX0, HEX1); -- Display Resultado
  HEX3 <= "0110111"; -- Display "="
  digitB_7segments : dec7seg port map (B, HEX4, HEX5); -- Display B
  digitA_7segments : dec7seg port map (A, HEX6, HEX7); -- Display A

  redLeds : redLedsHandle port map (A, B, RESULT, LEDR); -- Leds Vermelhos

END hardware;