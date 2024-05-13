#include "muAica.h"
#include <stdarg.h>
#include <stdio.h>

volatile int global_Vector[12] = {0, 0, 0};
volatile int testGlobal = 123;

// Converts an integer to a string and appends it to the buffer.
// Returns the number of characters written.
int muIntToString(char* buf, int value) 
{
	char temp[32]; // Temporary buffer to hold the integer characters in reverse order
	int i = 0, j, len = 0;
	int isNegative = value < 0;

	if (isNegative) 
	{
		value = -value; // Make the value positive for processing
	}

	// Extract digits
	do 
	{
		temp[i++] = (value % 10) + '0'; // Convert integer to character
		value /= 10;
	} while (value);

	if (isNegative) 
	{
		temp[i++] = '-';
	}

	len = i;
	// Reverse the string into the output buffer
	for (j = 0; j < len; j++) 
	{
		buf[j] = temp[len - 1 - j];
	}
	buf[len] = '\0'; // Null-terminate the string

	return len; // Return the length of the string, excluding the null terminator
}

// Copies the source string into the destination buffer.
// Returns the number of characters copied (excluding the null terminator).
int muStrcpy(char* dest, const char* src) 
{
	int count = 0;
	while (*src) 
	{
		*dest++ = *src++;
		count++;
	}
	*dest = '\0'; // Null-terminate the destination string

	return count;
}

// Scans string for formatters (%d / %s / %%) and replaces them with data from 
// argument list
void muSprintf(char* buf, const char* format, ...) 
{
	va_list args;
	va_start(args, format);

	const char* p = format;
	char* buf_ptr = buf;
	while (*p) 
	{
		if (*p == '%') 
		{
			switch (*++p) 
			{ // Move to the specifier character
			case 'd': 
			{ // Integer
				int i = va_arg(args, int);
				buf_ptr += muIntToString(buf_ptr, i);
				break;
			}
			case 's': 
			{ // String
				char* s = va_arg(args, char*);
				buf_ptr += muStrcpy(buf_ptr, s);
				break;
			}
			case '%': 
			{ // Percent sign
				*buf_ptr++ = '%';
				break;
			}
			default: // Unsupported format
				*buf_ptr++ = '%';
				*buf_ptr++ = *p;
				break;
			}
		}
		else 
		{
			*buf_ptr++ = *p; // Copy regular character
		}
		p++;
	}

	*buf_ptr = '\0'; // Null-terminate the buffer
	va_end(args);
}



int main()
{	    
    int b = 10;
    int c = 12;
    char buf[128];
    
    for(int i = 1; i < 30; i++)
    {
       b /= i;
       c *= i;
       
       muSprintf(buf, "[%d] %d %d\n", i, b, c);
       
       UART_Print(buf); 
       
    }
        
	return b;
}
