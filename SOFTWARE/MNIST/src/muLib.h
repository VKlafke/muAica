
// Function to calculate the length of a string
int muStrlen(const char *str);

// Copies the source string into the destination buffer.
// Returns the number of characters copied (excluding the null terminator).
int muStrcpy(char* dest, const char* src);

// Converts an integer to a string and appends it to the buffer.
// Returns the number of characters written.
int muIntToString(char* buf, int value);

// Scans string for formatters (%d / %s / %%) and replaces them with data from 
// argument list
void muSprintf(char* buf, const char* format, ...);