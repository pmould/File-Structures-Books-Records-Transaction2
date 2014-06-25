
#ifndef DBASE
#define DBASE

#include "cd.h"
#include "delim.h"
#include <ctime>
#include <fstream>

struct AvailInfo
{
	int offset, size;
};

class Dbase
{
	public :
		     Dbase(); 
		void Start_Timer();
		void Timer() const;
	        void Reset();
		void Insert(CD myCD);
		bool Search(String key);
		CD Retrieve(String key);
		void Delete(String key);
	private :
		int deleteCounter;
		int recCount; //Counts the number of records that are inserted into tha dataFile
		clock_t start_time;
                DelimFieldBuffer Buff;  
		fstream dataFile;
                fstream indexFile;
		fstream stackFile;
                AvailInfo AvailSearch(int newSize);
                void UpdateIndex (CD myCD, AvailInfo FirstFit);
                void UpdateAvailList (CD myCD, AvailInfo FirstFit);
};
#endif
