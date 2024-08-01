#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>
#include <sstream>

using namespace std;

int main (int argc, char *argv[]) {

    unsigned int word, fileSize;
    unsigned int pad = 0;

    if (argc == 1) {
        cout << "Sintaxe: " << argv[0] << " <filename> [pad]" << endl;
        return 0;
    }

    if (argv[2] != NULL) {
        stringstream str(argv[2]);
        str >> pad;
    }

    ifstream rf(argv[1], ios::out | ios::binary | ios::ate);

    if(!rf) {
        cout << "Cannot open file!" << endl;
        return 1;
    }

    fileSize = rf.tellg();

    rf.seekg (0, ios::beg);
    while(rf.read(reinterpret_cast<char *>(&word), sizeof(word))) {
        cout << setfill('0') << setw(8) << hex << word  << endl;

        if (pad > 0)
            pad--;

        word = 0;
    }

    if (fileSize % 4) {
        cout << setfill('0') << setw(8) << hex << word << endl;

        if (pad > 0)
            pad--;
    }



    rf.close();

    if (pad > 0)
        while(pad--)
            cout << "00000000" << endl;

    return 0;
}
