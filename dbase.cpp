#include"dbase.h"
#include <iomanip>
#include <string.h>
#include <stdlib.h> 
Dbase::Dbase()
{
	recCount = 0;
	deleteCounter = 0;

}

void Dbase:: Start_Timer()
{
	start_time = clock();

}

void Dbase::  Timer() const
{
	clock_t end_time;
	double elapsed_time;

	end_time = clock();

	elapsed_time = ((double) (end_time - start_time))/ CLOCKS_PER_SEC;
	cout << "It has been "  << elapsed_time << " seconds."
        << endl;

}

void Dbase::Reset()
{
	dataFile.open( "cdv.dat", ios::in | ios::out | ios::binary );
	stackFile.open( "cdv.sta", ios::in | ios::out );
	indexFile.open( "cdv.ind", ios::in | ios::out);
	indexFile.setf(ios::left, ios::adjustfield);
	stackFile.setf(ios::left, ios::adjustfield);
	indexFile.clear();
	stackFile.clear();
	
	indexFile.seekg(0, ios::end);
	stackFile.seekg(0, ios::end);
	if (indexFile.tellg()== 0)
	{
	
//	cout << "In Reset statement"<< endl;
		indexFile << setw(5) << 0<< "*";

	}
	if (stackFile.tellg() == 0)
	{
		stackFile << setw(5) << 0;
//	cout << "In Reset statement"<< endl;
	}

	Buff.SetDefaultDelim('|');
	Buff.WriteHeader(dataFile);

}

void Dbase::Insert(CD myCD)
{

	long bufferOffset;
	int firstRec; char firstRecC[6];
	Buff.Clear();
	myCD.Pack(Buff);

//	cout << "tellg: " << indexFile.tellg()<< endl;
	indexFile.seekg(0, ios::beg);
//	cout << "Beg: tellg: " << indexFile.tellg()<< endl;
	indexFile.getline(firstRecC,5, '\n');
//	cout <<"firsRecC: "<< firstRecC << endl;	
	firstRec =atoi(firstRecC);

//	cout << "firstRec: " << firstRec<< endl;
	indexFile.clear();
		
	dataFile.seekg(firstRec);
	if ( firstRec == 0)
		dataFile.seekg(17);
	bufferOffset = Buff.Write(dataFile);
        firstRec =  dataFile.tellg();
	recCount++;
	indexFile.seekg(0, ios::beg);
        indexFile << setw(5) << firstRec;
        indexFile.seekg(-1, ios::end);
        indexFile << myCD.getUPC()
		  << setw(5) <<bufferOffset 
                  << setw(5) << dataFile.tellg()- bufferOffset << "+*";

}

CD Dbase:: Retrieve(String key)
{

	string keyS = 	key;
//	cout << "keyS: " << keyS << endl;
//	cout << "key: " << key << endl;
	fstream outFile( "file.out", ios::in | ios::out );
	CD aCD;

	dataFile.seekg(17,ios::beg);
	int count = 0;
	while ( keyS != aCD.getUPC())
	{
	count++;
//	cout << "keyUPC: " << aCD.getUPC() << endl;
//	cout << "keyS: " << keyS << endl;
//	cout << endl;


	Buff.Clear();
	Buff.Read(dataFile);
	Buff.Write(outFile);

	aCD.Unpack(Buff);
//	cout << "A CD: " << endl;
//	cout << aCD << endl;

//	if ( keyS == aCD.getUPC())
//		cout << "FOUND!!!!" << endl;
	}

	
	return aCD;

}

void Dbase :: UpdateIndex( CD myCD, AvailInfo FirstFit)
{
	
}

bool Dbase:: Search(String key)
{
	int offset=0;
	char UPCstr[13];
	char endChar;
	indexFile.seekg(5, ios::beg);
	offset = 6;
	while ( indexFile.peek() != 42)
	{

		offset = indexFile.tellg();
		indexFile.getline(UPCstr,13, '\n');
		indexFile.clear();

		
		if( strncmp( UPCstr, key, 12) == 0)
		{
			indexFile.seekg(10, ios::cur);
			char deleteChar;
			indexFile >> deleteChar;
			if ( deleteChar == '+')
	 		return true;
		}
		offset += 23;
		indexFile.seekg(offset);
	}
		return false;
}



AvailInfo Dbase:: AvailSearch( int newSize)
{
        AvailInfo FirstFit;
        int sizeInt;
        int offsetInt;
        stackFile.seekg(0, ios::beg);
        stackFile >> sizeInt;
        while ( stackFile.eof() != true )
        {
                stackFile >> offsetInt;
                stackFile >> sizeInt;
                if ( sizeInt == newSize)
                {
                        FirstFit.size = sizeInt;
                        FirstFit.offset = offsetInt;
                        return FirstFit;
		}
        }
        FirstFit.size = newSize;
        dataFile.seekg(0, ios::end);
        FirstFit.offset = dataFile.tellg();
	
        return FirstFit;

}




void Dbase:: UpdateAvailList(CD myCD, AvailInfo FirstFit)
{
        stackFile.seekg(0, ios::beg);
        deleteCounter++;
        stackFile.seekg(0, ios::beg);
        stackFile << setw(5) << deleteCounter;
        stackFile  <<  setw(5) << FirstFit.offset;
           stackFile  << setw(5) << FirstFit.size;
}


void Dbase:: Delete(String key)
{	
	int end = false;
	if  (Search(key) == false)
	{
	}

	else
	{

		int offset=0;
		char UPCstr[13];
		char offsetSize[11];
		char endChar;
		indexFile.seekg(5, ios::beg);
		offset = 6;
		while ( indexFile.peek() != 42 && end == false)
		{
	
			offset = indexFile.tellg();
			indexFile.getline(UPCstr,13, '\n');
			indexFile.clear();
	
			
			if( strncmp( UPCstr, key, 12) == 0)
			{
			
				indexFile.getline(offsetSize,11, '\n');
				indexFile.clear();
       				 deleteCounter++;
 		     	         stackFile.seekg(0, ios::beg);
       				 stackFile << setw(5) << deleteCounter;
 		     	         stackFile.seekg(0, ios::end);
      				  stackFile  <<  offsetSize;
				





				recCount--;
				offset += 22;
				indexFile.seekg(offset);
				indexFile.put('-');
				end = true;

		 		
			}
			offset += 23;
			indexFile.seekg(offset);
		}
	}
}


