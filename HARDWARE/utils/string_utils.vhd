library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package string_utils is

  -- NOTE:
  -- All functions work only with 4 bits std_logic_vector, and 1 character

  ----------------------------------------------------------------
  --------- Convert CHAR to STD_LOGIC_VECTOR
  impure function
  ascii_hex_2_stdv (char_data : in character)
  return std_logic_vector;

  --------- Convert STD_LOGIC_VECTOR to ASCII CHAR
  impure function
  stdv_2_ascii (stdv_data : in std_logic_vector)
  return character;

  --------- Convert ASCII CHAR to STD_LOGIC_VECTOR
  impure function
  ascii_2_stdv (ascii_data : in character)
  return std_logic_vector;

end package string_utils;

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

package body string_utils is

  --------- Convert ASCII HEX VALUE to STD_LOGIC_VECTOR
  impure function ascii_hex_2_stdv (char_data : in character) return std_logic_vector is
    variable stdv_data : std_logic_vector(3 downto 0);
  begin
    CASE char_data is
      when '0'      => stdv_data := x"0";
      when '1'      => stdv_data := x"1";
      when '2'      => stdv_data := x"2";
      when '3'      => stdv_data := x"3";
      when '4'      => stdv_data := x"4";
      when '5'      => stdv_data := x"5";
      when '6'      => stdv_data := x"6";
      when '7'      => stdv_data := x"7";
      when '8'      => stdv_data := x"8";
      when '9'      => stdv_data := x"9";
      when 'A'|'a'  => stdv_data := x"A";
      when 'B'|'b'  => stdv_data := x"B";
      when 'C'|'c'  => stdv_data := x"C";
      when 'D'|'d'  => stdv_data := x"D";
      when 'E'|'e'  => stdv_data := x"E";
      when 'F'|'f'  => stdv_data := x"F";
      when others   => stdv_data := x"0";
    end CASE;
    return stdv_data;
  end function;

  --------- Convert STD_LOGIC_VECTOR to ASCII CHAR
  impure function stdv_2_ascii (stdv_data : in std_logic_vector) return character is
    variable int_data   : integer range 0 to 127;
    variable char_data  : character;
    variable ascii_str  : string(32 to 126) :=
    " !'#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
  begin
    int_data := to_integer(unsigned(stdv_data));

    if (int_data > 31) then
      char_data := ascii_str(int_data);
    else
      char_data := '_';
    end if;

    return char_data;
  end function;

  --------- Convert ASCII CHAR to STD_LOGIC_VECTOR
  impure function ascii_2_stdv (ascii_data : in character) return std_logic_vector is
    variable count      : integer := 32;
    variable stdv_data  : std_logic_vector(7 downto 0) := x"00";
    variable ascii_str  : string(32 to 126) :=
    " !'#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
  begin
    while (count < 127) loop
      if (ascii_data = ascii_str(count)) then
        stdv_data := std_logic_vector(to_unsigned(count , stdv_data'length));
        exit;
      end if;
      count := count + 1;
    end loop;

    return stdv_data;
  end function;

----------------------------------------------------------------
---------
end package body string_utils;
