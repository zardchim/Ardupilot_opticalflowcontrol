/* ADNS2620 Example Sketch
*  Demonstrates how to use the ADNS2620 Library to interface with the mouse sensor
*  on the ADNS2620 evaluation board from SparkFun Electronics
*
*  More register definitions are located in the 'adns2620.h' file. Read the
*  ADNS2620 datasheet to understand how to use the registers.
*
*  After loading the sketch to the ADNS2620 evaluation board, open the serial terminal
*  using a baud rate of 9600 to see the output from the ADNS2620 sensor.
*
*  Written by Ryan Owens
*  11/4/10
*  SparkFun Electronics
*/

/*
#define CONFIGURATION_REG   0x40
#define STATUS_REG          0x41
#define DELTA_Y_REG         0x42
#define DELTA_X_REG         0x43
#define SQUAL_REG           0x44
#define MAXIMUM_PIXEL_REG   0x45
#define MINIMUM_PIXEL_REG   0x46
#define PIXEL_SUM_REG       0x47
#define PIXEL_DATA_REG      0x48
#define SHUTTER_UPPER_REG   0x49
#define SHUTTER_LOWER_REG   0x4A
#define FRAME_PERIOD	    0x4B
*/

//Add the ADNS2620 Library to the sketch.
#include "adns2620.h"

// original
//#define SDA 18
//#define SCL 19
//#define SDA 24
//#define SCL 23
#define SDA A1
#define SCL A0

#define MODE_POSITION_DISPLAY 0
#define MODE_SURFACE_QUALITY_DISPLAY 1


//Name the ADNS2620, and tell the sketch which pins are used for communication
ADNS2620 mouse(SDA,SCL);

//This value will be used to store information from the mouse registers.
//unsigned char value=0;
char value=0;
int i;
char x=0, y=0;  // latest x,y values back from sensor
int tot_x=0, tot_y=0;  // total x,y position
int surfQuality = 0;
int mode = MODE_POSITION_DISPLAY;

void displayPixels()
{
    Serial.println("Pixel Data:");
    for( x=0; x<ADNS2620_MAX_X; x++ ) {
        for( y=0; y<ADNS2620_MAX_Y; y++ ) {
            Serial.print(mouse.pixel_data[x][y],DEC);
            if( y < ADNS2620_MAX_Y-1 ) {
                Serial.print(",");
            }else{
                Serial.println();
            }
        }
    }
    Serial.println("----------------");
}

void setup()
{
    int x,y;
  
    //Create a serial output and display an opening message
    Serial.begin(9600);
    Serial.println("ADNS2620_Example ver 1.7"); 
    Serial.print("A0/SCL = ");
    Serial.print(SCL,DEC);
    Serial.print("  A1/SDA = ");
    Serial.println(SDA,DEC); 
    
    //Initialize the ADNS2620
    mouse.begin();
    delay(1000);
    
    //A sync is performed to make sure the ADNS2620 is communicating
    mouse.sync();
    
    //Put the ADNS2620 into 'always on' mode.
    mouse.write(CONFIGURATION_REG, 0x01);
    
    // get product id and print it
    Serial.print("Product ID: ");
    Serial.println(mouse.product_id());
    
    // get surface quality
    Serial.print("Surface Quality: ");
    Serial.println(mouse.surface_quality());
    
    // read a frame
    if( mouse.get_pixel_data() == ADNS2620_SUCCESS ) {
        displayPixels();
    }else{
        Serial.println("failed to read pixel data.");
    }
}

void loop()
{
    char c;
    int temp;
    byte fr = 0;
  
    while( Serial.available() )
    {
        c = Serial.read();
        
        if( c == 's' )
            mode = MODE_SURFACE_QUALITY_DISPLAY;
            
        if( c == ' ' || c == 'n' )
            mode = MODE_POSITION_DISPLAY;
            
        if( c == 'p' )
        {
            // read a frame
            if( mouse.get_pixel_data() == ADNS2620_SUCCESS ) {
                displayPixels();
            }else{
                Serial.println("failed to read pixel data.");
            }
        }
        
        if( c == '9' ) {
            fr = mouse.get_frame_period();
            Serial.print("frame rate old: ");
            Serial.print(fr,DEC);
            mouse.set_frame_period(FRAME_PERIOD_FAST);
            Serial.print("\t new: ");
            fr = mouse.get_frame_period();
            Serial.println(fr,DEC);
        }
        if( c == '5' ) {
            fr = mouse.get_frame_period();
            Serial.print("frame rate old: ");
            Serial.print(fr,DEC);
            mouse.set_frame_period(FRAME_PERIOD_NORMAL);
            Serial.print("\t new: ");
            fr = mouse.get_frame_period();
            Serial.println(fr,DEC);
        }          
        if( c == '0' ) {
            fr = mouse.get_frame_period();
            Serial.print("frame rate old: ");
            Serial.print(fr,DEC);
            mouse.set_frame_period(FRAME_PERIOD_SLOW);
            Serial.print("\t new: ");
            fr = mouse.get_frame_period();
            Serial.println(fr,DEC);
        }
        if( c == 'r' ) {
            tot_x = 0;
            tot_y = 0;
            Serial.println("Reset x and y totals.");
        }    
    }
  
    //Read the DELTA_X_REG register and store the result in 'value'
    x = mouse.read(DELTA_X_REG);
    y = mouse.read(DELTA_Y_REG);
    temp = mouse.surface_quality();
    
    // display the total x + y position (if something has changed)
    if( mode == MODE_POSITION_DISPLAY) {
        if( x != 0 || y != 0 ) {
            tot_x += x;
            tot_y += y;
            Serial.print("X:");
            Serial.print(tot_x);
            Serial.print("\tY:");
            Serial.print(tot_y);
            Serial.print("\t(");
            Serial.print(x,DEC);
            Serial.print(",");
            Serial.print(y,DEC);
            Serial.print(")");
            Serial.print(" sq:");
            Serial.print(temp);
            Serial.println();
        }      
    }
    
    // display the surface quality
    if( mode == MODE_SURFACE_QUALITY_DISPLAY ) {
        if( surfQuality != temp ) {
            Serial.print("SQ: ");
            Serial.println(temp);
            surfQuality = temp;
        }
    }

    delay(10);    
}
    
    


