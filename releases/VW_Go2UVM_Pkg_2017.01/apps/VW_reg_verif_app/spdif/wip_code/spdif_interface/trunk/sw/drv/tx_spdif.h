/* 
* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at www.go2uvm.org
* Some portions of Go2UVM are free software.
* You can redistribute it and/or modify  
* it under the terms of the GNU Lesser General Public License as   
* published by the Free Software Foundation, version 3.
*
* VerifWorks reserves the right to obfuscate part or full of the code
* at any point in time. 
* We also support a comemrical licensing option for an enhanced version
* of Go2UVM, please contact us via support@verifworks.com

* This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
* Lesser General Lesser Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/


#ifndef _tx_spdif_
#define _tx_spdif_

/*** Register definitions ********************************************/

#define TX_VERSION  0x00  /* Version register */
#define TX_CONFIG   0x01  /* Configuration register */
#define TX_CHSTAT   0x02  /* Channel status control register */
#define TX_INTMASK  0x03  /* interrupt mask register */
#define TX_INSTAT   0x04  /* Interrupt event register */
#define TX_UD_BASE  0x20  /* User data buffer base address */
#define TX_CS_BASE  0x40  /* Channel status buffer base address */


#endif

