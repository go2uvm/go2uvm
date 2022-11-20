//* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
//* http://www.verifworks.com 
//* Contact: support@verifworks.com 
//* 
//* This program is part of Go2UVM at www.go2uvm.org
//* Some portions of Go2UVM are free software.
//* You can redistribute it and/or modify  
//* it under the terms of the GNU Lesser General Public License as   
//* published by the Free Software Foundation, version 3.
//*
//* VerifWorks reserves the right to obfuscate part or full of the code
//* at any point in time. 
//* We also support a comemrical licensing option for an enhanced version
//* of Go2UVM, please contact us via support@verifworks.com
//
//* This program is distributed in the hope that it will be useful, but 
//* WITHOUT ANY WARRANTY; without even the implied warranty of 
//* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
//* Lesser General Lesser Public License for more details.
//*
//* You should have received a copy of the GNU Lesser General Public License
//* along with this program. If not, see <http://www.gnu.org/licenses/>.

import uvm_pkg::*;
`include "uvm_macros.svh"

package vl_ahb_pkg;

  parameter AHB_DATA_WIDTH = 16;
  parameter AHB_ADDR_WIDTH = 16;

 typedef enum bit[2:0]  {
		BYTE = 0,
		HALFWORD = 1,
		WORD = 2,
		TWO_WORDS = 3,
		FOUR_WORDS = 4,
		EIGHT_WORDS = 5,
		SIXTEEN_WORDS = 6,
		K_BITS = 7
} ahb_transfer_size_e;
typedef enum bit[1:0]  {
		IDLE = 0,
		BUSY = 1,
		NONSEQ = 2,
		SEQ = 3
} ahb_transfer_kind_e;
typedef enum bit[1:0]  {
		OKAY = 0,
		ERROR = 1,
		RETRY = 2,
		SPLIT = 3
} ahb_response_kind_e;
typedef enum bit  {
		READ = 0,
		WRITE = 1
} ahb_dir_e;
typedef enum bit[2:0]  {
		SINGLE = 0,
		INCR = 1,
		WRAP4 = 2,
		INCR4 = 3,
		WRAP8 = 4,
		INCR8 = 5,
		WRAP16 = 6,
		INCR16 = 7
} ahb_burst_kind_e;
 
 
      
endpackage : vl_ahb_pkg
