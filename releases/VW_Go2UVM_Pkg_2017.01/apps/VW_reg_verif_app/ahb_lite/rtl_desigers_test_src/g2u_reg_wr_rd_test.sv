
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

`define VL_CTRL_REG g2u_reg_env_0.g2u_reg_block_0.i2c_spec_TXR

`G2U_REG_TEST_BEGIN(g2u_reg_wr_rd_test, ahb_lite_reg_env)

task main();
/*
  int wr_data, rd_data;
  `g2u_display("Test is running...");

  wr_data = 'haa;

  `VL_CTRL_REG.write(status, wr_data);

  `g2u_display($sformatf("VL_CTRL_REG is written with Data 'h%0x ", wr_data))
 
  `VL_CTRL_REG.read(status, rd_data);

  `g2u_display( $sformatf("VL_CTRL_REG is reading with Data 'h%0x ", rd_data))

  a_wr_rd_chk : assert (wr_data == rd_data) else
    `g2u_error ($sformatf ("REG value mismatch: wr_data: 0x%0h rd_data: 0x%0h",
           wr_data, rd_data))

  `g2u_display("End of test ")
*/
endtask : main

`G2U_REG_TEST_END
