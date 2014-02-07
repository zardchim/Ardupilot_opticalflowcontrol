/* Arduino ADNS2620 Library
 * Copyright 2010 SparkFun Electronic
 * Written by Ryan Owens
*/

#ifndef adns2620_h
#define adns2620_h

#include <avr/pgmspace.h>
#include "WProgram.h"

// Register Map for the ADNS2620 Optical Mouse Sensor
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
#define FRAME_PERIOD		0x4B

// Config register values
//#define CONFIG_RESET 0x80
//#define CONFIG_POWERDOWN_NORMAL
//#define CONFIG_POWERDOWN_NOW
//#define CONFIG_LEDSHUTTERMODE_ALWAYSON
//#define CONFIG_LEDSHUTTERMODE_NORMAL

// Number of pixels in image capture by sensor
#define ADNS2620_MAX_X 18
#define ADNS2620_MAX_Y 18

// ON/OFF settings for LED
#define ADNS2620_LED_OFF 0
#define ADNS2620_LED_ON 1

// SUCCESS / FAIL return value
#define ADNS2620_FAIL    0
#define ADNS2620_SUCCESS 1

// FRAME RATES
#define FRAME_PERIOD_SLOW 0xE0
#define FRAME_PERIOD_NORMAL 0xC2
#define FRAME_PERIOD_FAST 0x02

class ADNS2620
{
	private:
		int _sda;
		int _scl;

	public:
		char pixel_data[ADNS2620_MAX_X][ADNS2620_MAX_Y];
		ADNS2620(int sda, int scl);
		void begin();
		void sync();
		char read(char address);
		void write(char address, char value);
		int product_id();
		int surface_quality();
		void wakeup();
		void sleep();
		char get_frame_period();
		void set_frame_period(char value);
		int get_pixel_data();  // reads pixel data into pixel_data array.  returns 1 on success

};

#endif