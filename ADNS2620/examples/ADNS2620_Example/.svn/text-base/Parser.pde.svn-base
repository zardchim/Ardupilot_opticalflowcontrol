/*
 
 File     : Parser.pde
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

#define MOUSE_MSG_LEN 5
char mouse_buf[MOUSE_MSG_LEN];
int mouse_buf_ptr = 0;

void mouse_addChar(char newChar)
{
    int x,y,surface_quality;
    // add new character to buffer
    mouse_buf[mouse_buf_ptr++] = newChar;
    mouse_buf_ptr %= MOUSE_MSG_LEN;
    
    // check if full message received
    if( newChar == END_CHAR && mouse_buf[mouse_buf_ptr] == START_CHAR ) {
        x = (int)(mouse_buf[(mouse_buf_ptr+1) % MOUSE_MSG_LEN]);
        y = (int)(mouse_buf[(mouse_buf_ptr+2) % MOUSE_MSG_LEN]);
        surface_quality = (int)(mouse_buf[(mouse_buf_ptr+3) % MOUSE_MSG_LEN]);
        MAIN_SERIAL.print("decoded : ");
        MAIN_SERIAL.print(x);
        MAIN_SERIAL.print(",");
        MAIN_SERIAL.print(y);
        MAIN_SERIAL.print(",");
        MAIN_SERIAL.print(surface_quality);
        MAIN_SERIAL.println();
    }
}

