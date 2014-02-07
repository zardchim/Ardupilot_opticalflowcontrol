/*
 
 File     : Eeprom.pde
 Version  : v1.0, Dec 14, 2011
 Author(s): Randy Mackay
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>.

* ************************************************************** *
ChangeLog:


* ************************************************************** *
TODO:


* ************************************************************** */

// Utilities for writing and reading from the EEPROM
int eeprom_read_int(int address) {
  union intStore {
    byte intByte[4];
    int intVal;
  } intOut;
  
  for (int i = 0; i < 4; i++) 
    intOut.intByte[i] = EEPROM.read(address + i);
  return intOut.intVal;
}

void eeprom_write_int(int value, int address) {
  union intStore {
    byte intByte[4];
    float intVal;
  } intIn;
  
  intIn.intVal = value;
  for (int i = 0; i < 4; i++) 
    EEPROM.write(address + i, intIn.intByte[i]);
}

// Utilities for writing and reading from the EEPROM
long eeprom_read_long(int address) {
  union longStore {
    byte longByte[4];
    int longVal;
  } longOut;
  
  for (int i = 0; i < 4; i++) 
    longOut.longByte[i] = EEPROM.read(address + i);
  return longOut.longVal;
}

void eeprom_write_long(long value, int address) {
  union longStore {
    byte longByte[4];
    float longVal;
  } longIn;
  
  longIn.longVal = value;
  for (int i = 0; i < 4; i++) 
    EEPROM.write(address + i, longIn.longByte[i]);
}
