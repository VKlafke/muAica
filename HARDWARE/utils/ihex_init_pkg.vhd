library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

--use work.cache_pkg.all; -- note: package with the string "filepath"


package ihex_init_pkg is

  constant  path        : string := "";--"text_file/ihex/";
  constant  bootloader  : string := path&"bootloader.hex";
  constant  filepath    : string := bootloader;

----------------------------------------------------------------
--------- Memory to be used and iHex file information
  constant  kb_bram     : integer := 2;                   -- each Block RAM has 2kB
  constant  n_bram      : integer := 16;                  -- num of Block RAMs, each has 2kB
  constant  mem_size    : integer := n_bram*kb_bram*1024; -- in bytes
  constant  mem_nvalid  : integer := 1;                   -- mem_nvalid, valid bit
  constant  mem_naddr   : integer := 32;                  -- mem_naddr, address length
  constant  mem_ndata   : integer := 8;                   -- mem_ndata, data length
  constant  mem_n       : integer := mem_nvalid+mem_naddr+mem_ndata;

  -- data memory, keeps the ihex file data: valid:address:data
  type      mem_type is array (0 to mem_size-1) of std_logic_vector(mem_n-1 downto 0);

  -- ihex file format constants
  constant  TT_data : string(1 to 2) := "00";   --data
  constant  TT_eof  : string(1 to 2) := "01";   --end of file
  constant  TT_esa  : string(1 to 2) := "02";   --extended segment address
  constant  TT_ssa  : string(1 to 2) := "03";   --start segment address
  constant  TT_ela  : string(1 to 2) := "04";   --extended linear address
  constant  TT_sla  : string(1 to 2) := "05";   --start linear address

----------------------------------------------------------------
--------- Convert ASCII HEX VALUE to STD_LOGIC_VECTOR
  impure function
  ascii_hex_2_stdv	(char_data : in character)
  return std_logic_vector;

----------------------------------------------------------------
--------- Read a  iHex file and outputs its information
  impure function
  read_ihex (ihex_filename : in string)
  return mem_type;

  impure function
  ihex_tt	(addr_in : in std_logic_vector; TT_string : in string)
  return std_logic_vector;

  --------- Constant with the ihex file output
  constant  ihex_mem : mem_type := read_ihex(filepath);

end package ihex_init_pkg;

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

package body ihex_init_pkg is

----------------------------------------------------------------
--------- Convert ASCII HEX VALUE to STD_LOGIC_VECTOR
  -- check only for 0-9, a-f and A-F
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

----------------------------------------------------------------
--------- Read a iHex file in to a RAM with 1byte per address
  impure function read_ihex (ihex_filename: in string) return mem_type is
    FILE      ihexfile      : text is in ihex_filename;
    variable  ihexfile_line : line;
    -- line data
    variable  line_char     : character;
    variable  line_stdv     : std_logic_vector(3 downto 0);
    variable  line_str      : string(1 to 400) := (others => ' ');
    variable  line_length   : integer := 0;
    variable  line_count    : integer := 0;
    variable  byte_count    : integer := 0;
    -- ihex fields
    variable  LL_stdv       : std_logic_vector(7 downto 0) := (others => '0');
    variable  LL            : integer := 0;
    variable  AAAA_ext      : std_logic_vector(31 downto 0) := (others => '0');
    variable  AAAA_stdv     : std_logic_vector(15 downto 0) := (others => '0');
    variable  AAAA_lower    : std_logic_vector(15 downto 0) := (others => '0');
    variable  AAAA          : std_logic_vector(31 downto 0) := (others => '0');
    variable  TT_string     : string(1 to 2) := "00";
    variable  DD_stdv       : std_logic_vector(7 downto 0) := (others => '0');
    -- mem type
    variable  mem           : mem_type := (others => (others => '0'));
    variable  mem_line      : std_logic_vector(mem_n-1 downto 0);
  begin
    -------------------------------------------------------
    -------------------------------------------------------
    line_access: while (TT_string /= TT_eof AND (not endfile(ihexfile))) loop
      ---------------------------
      -- Read Line
      line_str    := (others => ' ');                   -- empty the current string
      readline(ihexfile, ihexfile_line);                -- read line
      line_count  := line_count + 1;                    -- increase the line counter
      line_length := ihexfile_line'length;              -- get line length
      read(ihexfile_line, line_str(1 to line_length));  -- since the first ascii char is ':', we ignore it

      report LF & "ihex line " & integer'image(line_count) & " => " & line_str;

      ---------------------------
      -- Num of Bytes (LL):
      for i in 0 to 1 loop
        line_char := line_str(2+i);
        line_stdv := ascii_hex_2_stdv(line_char);
        LL_stdv(7-i*4 downto 4-i*4) := line_stdv;
      end loop;
      
      LL := to_integer(unsigned(LL_stdv));
      ---------------------------
      -- Start Address (AAAA):
      for i in 0 to 3 loop
        line_char := line_str(4+i);
        line_stdv := ascii_hex_2_stdv(line_char);
        AAAA_stdv(15-i*4 downto 12-i*4) := line_stdv;
      end loop;

      ---------------------------
      -- Record Field (TT):
      TT_string := line_str(8 to 9);

      if (TT_string = TT_eof) then
        report LF & "TT (record type): End of Files" & LF severity note;
        exit line_access;
      end if;
      ---------------------------
      -- Data Field (DD):
      DD_loop: for i in 0 to LL-1 loop

        if (TT_string = TT_data) then   -- data record
          -------------------------------------------------
          -- read data
          for j in 0 to 1 loop
            line_char := line_str(10+(i*2)+j);
            DD_stdv(7-j*4 downto 4-j*4) := ascii_hex_2_stdv(line_char);
          end loop;

          mem_line(7 downto 0) := DD_stdv;
          -------------------------------------------------
          -- read address
          AAAA_lower  := std_logic_vector(unsigned(AAAA_stdv) + i);
          AAAA        := std_logic_vector(unsigned(AAAA_ext) + unsigned(AAAA_lower));
          mem_line(mem_n-1 downto 8) := '1' & AAAA;

          -------------------------------------------------
          -- mem line output
          mem(byte_count) := mem_line;
          byte_count      := byte_count + 1;

        else	-- extended address record => TT_string /= "00"
          for j in 0 to 1 loop
            line_char := line_str(10+(i*2)+j);
            if (i = 0) then
              AAAA_ext(31-j*4 downto 28-j*4) := ascii_hex_2_stdv(line_char);
            else
              AAAA_ext(23-j*4 downto 20-j*4) := ascii_hex_2_stdv(line_char);
            end if;
          end loop;

          if (i = LL-1) then  -- end of ext address
            AAAA_ext := ihex_tt(AAAA_ext , TT_string);

            assert (TT_string /= TT_esa) report LF & "TT (record type): Extended Segment Address detected => 0x" & line_str(10 to 10+(LL*2)-1) & LF severity note;
            assert (TT_string /= TT_ssa) report LF & "TT (record type): Start Segment Address ignored => 0x" & line_str(10 to 10+(LL*2)-1) & LF severity warning;
            assert (TT_string /= TT_ela) report LF & "TT (record type): Extended Linear Address detected => 0x" & line_str(10 to 10+(LL*2)-1) & LF severity note;
            assert (TT_string /= TT_sla) report LF & "TT (record type): Start Linear Address ignored => 0x" & line_str(10 to 10+(LL*2)-1) & LF severity warning;
          end if;

        end if;

      end loop DD_loop;
      ---------------------------

    end loop line_access;
    -------------------------------------------------------
    -------------------------------------------------------
    report LF & "Line Count => " & integer'image(line_count) & LF severity note;
    report LF & "Byte Count => " & integer'image(byte_count) & LF severity note;

    return	mem;
  end function;

----------------------------------------------------------------
--------- Read a iHex TT field, if a extended segment address record type (or start)
  impure function ihex_tt (addr_in : in std_logic_vector; TT_string : in string) return std_logic_vector is
    variable  addr_out : std_logic_vector(31 downto 0) := (others => '0');
  begin
    ------------------
    if (TT_string = TT_esa) then    -- extended segment address
      addr_out(31 downto 20) := (others => '0');
      addr_out(19 downto 4)  := addr_in(31 downto 16);
      addr_out(3 downto 0)   := (others => '0');
    ------------------
    elsif (TT_string = TT_ssa) then -- start segment address (ignored)
      null;
    ------------------
    elsif (TT_string = TT_ela) then	-- extended linear address
      addr_out(31 downto 16):= addr_in(31 downto 16);
      addr_out(15 downto 0) := (others => '0');
    ------------------
    elsif (TT_string = TT_sla) then	-- start linear address (ignored)
      null;
    ------------------
    else
      report LF & "ERROR: invalid TT (record type) detected" severity error;
    end if;
  
    return addr_out;
  end function;

----------------------------------------------------------------
---------
end package body ihex_init_pkg;
