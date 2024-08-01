#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>
#include <sstream>

using namespace std;

void WriteBigEndian(std::ofstream& file, int data) 
{
    char* bytePtr = reinterpret_cast<char*>(&data);

    for (size_t i = sizeof(data); i > 0; i--)
    {
        file.write(&bytePtr[i - 1], 1);
    }
}

int main(int argc, char* argv[])
{
    unsigned int word, fileSize;
    unsigned int i = 0;

    unsigned int* codeBuf;

    if (argc < 4) {
        cout << "Sintaxe: " << argv[0] << " <in code.bin> <in data.bin> <out serial.bin>" << endl;
        return 0;
    }


    // Open output file
    std::ofstream outF(argv[3], std::ios::out | std::ios::binary);

    if (!outF) 
    {
        cout << "Cannot open file for writing!" << std::endl;
        return 1;
    }


    // Open code section file for reading
    ifstream rf(argv[1], ios::out | ios::binary | ios::ate);

    if (!rf) 
    {
        cout << "Cannot open file!" << endl;
        return 1;
    }

    fileSize = rf.tellg();

    // Write .text section size, big-endian
    WriteBigEndian(outF, fileSize);

    rf.seekg(0, ios::beg);
    while (rf.read(reinterpret_cast<char*>(&word), sizeof(word))) 
    {
        // write contents of .text file
        WriteBigEndian(outF, word);
        word = 0;
    }


    rf.close();

    // Open data section file for reading
    ifstream rfData(argv[2], ios::out | ios::binary | ios::ate);

    if (!rfData)
    {
        cout << "Cannot open file!" << endl;
        return 1;
    }

    fileSize = rfData.tellg();

    // Write .data section size, big-endian
    WriteBigEndian(outF, fileSize);

    rfData.seekg(0, ios::beg);
    while (rfData.read(reinterpret_cast<char*>(&word), sizeof(word)))
    {
        // write contents of .data file
        WriteBigEndian(outF, word);
        word = 0;
    }

    rfData.close();
    outF.close();
}