#include "cd.h"
#include <cstring>
using namespace std;

CD::CD()
{
       strcpy (UPC, "\0");  strcpy (Artist, "\0");
       strcpy (Title, "\0");
}

CD::CD (char upc[13], char artist[24], char title[36])
{
       strcpy (UPC, upc);  strcpy (Artist, artist);
       strcpy (Title, title); 
} 

CD & CD::operator = (const CD& otherCD)
{
       strcpy (UPC, otherCD.UPC);  strcpy (Artist, otherCD.Artist);
       strcpy (Title, otherCD.Title); 
	return *this;
}

CD::CD( const CD& otherCD)
{
       strcpy (UPC, otherCD.UPC);  strcpy (Artist, otherCD.Artist);
       strcpy (Title, otherCD.Title); 
}

int CD::Pack( IOBuffer& Buffer) const
{
	int result;
	result = Buffer.Pack(UPC);
	result = result && Buffer.Pack(Artist);
	result = result && Buffer.Pack(Title);
	return result;
}

int CD::Unpack(IOBuffer& Buffer) 
{
	Buffer.Clear();
	int numBytes;
        numBytes = Buffer.Unpack(UPC);
        if (numBytes == -1) return false;
          UPC[numBytes] = 0;
        numBytes = Buffer.Unpack(Artist);
        if (numBytes == -1) return false;
          Artist[numBytes] = 0;
        numBytes = Buffer.Unpack(Title);
        if (numBytes == -1) return false;
          Title[numBytes] = 0;
}

string CD::getUPC()
{
	return UPC;
}

istream & operator >> (istream & stream, CD & C)
{
       stream.getline(C.UPC,13, '\n');
       if (strlen(C.UPC) == 0)  return stream;
       stream.getline(C.Artist, 24, '\n');
       stream.getline(C.Title, 36, '\n');
       return stream;
}

ostream & operator << (ostream & stream, CD & C)
{
        stream << C.UPC << "|" << C.Artist << "|" <<C.Title << "|";
	return stream;
}

