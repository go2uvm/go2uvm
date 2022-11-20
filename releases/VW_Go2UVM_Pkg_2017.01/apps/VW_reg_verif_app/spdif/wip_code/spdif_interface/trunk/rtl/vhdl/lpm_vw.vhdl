-- Copyright (c) 2004-2017 VerifWorks, Bangalore, India
-- http://www.verifworks.com 
-- Contact: support@verifworks.com 
-- 
-- This program is part of Go2UVM at www.go2uvm.org
-- Some portions of Go2UVM are free software.
-- You can redistribute it and/or modify  
-- it under the terms of the GNU Lesser General Public License as   
-- published by the Free Software Foundation, version 3.
--
-- VerifWorks reserves the right to obfuscate part or full of the code
-- at any point in time. 
-- We also support a comemrical licensing option for an enhanced version
-- of Go2UVM, please contact us via support@verifworks.com
--
-- This program is distributed in the hope that it will be useful, but 
-- WITHOUT ANY WARRANTY; without even the implied warranty of 
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
-- Lesser General Lesser Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;
  entity lpm_ram_dp is
      generic (LPM_WIDTH              : positive;
                LPM_WIDTHAD           : positive;
                LPM_NUMWORDS          : natural := 0;
                LPM_INDATA            : string  := "REGISTERED";
                LPM_OUTDATA           : string  := "REGISTERED";
                LPM_RDADDRESS_CONTROL : string  := "REGISTERED";
                LPM_WRADDRESS_CONTROL : string  := "REGISTERED";
                LPM_FILE              : string  := "UNUSED";
                LPM_TYPE              : string  := "LPM_RAM_DP";
                LPM_HINT              : string  := "UNUSED");
      port (data                    : in  std_logic_vector(LPM_WIDTH-1 downto 0);
             rdaddress, wraddress   : in  std_logic_vector(LPM_WIDTHAD-1 downto 0);
             rdclock, wrclock       : in  std_logic := '0';
             rden, rdclken, wrclken : in  std_logic := '1';
             wren                   : in  std_logic;
             q                      : out std_logic_vector(LPM_WIDTH-1 downto 0));
   end entity;


