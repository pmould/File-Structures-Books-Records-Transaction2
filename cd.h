#ifndef CDISC
#define CDISC

#include <cstring>
#include <string>
#include <fstream>
#include "iobuffer.h"
using namespace std;

const int UpTo = 50;
typedef char String[UpTo];

class CD
{
   public :
       CD (const CD& otherCD);
       CD (char upc [13] , char artist [24], char title [36]);
       CD ();
       CD & operator = (const CD& otherCD);
       friend istream & operator >> (istream & stream, CD & C);
       friend ostream & operator << (ostream & stream, CD & C);
       int Pack (IOBuffer & Buffer) const;
       int Unpack (IOBuffer & Buffer);
       string getUPC ();
       int recordSize();

   private :
  //     String UPC, Artist, Title;
  	char UPC [13];
	char Artist [24];
	char Title [36];
};
#endif
