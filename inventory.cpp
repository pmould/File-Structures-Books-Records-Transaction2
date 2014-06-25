#include <fstream>
#include <iomanip>
#include <cstring>
#include "cd.h"
#include "delim.h"
#include "dbase.h"
#include <iostream>
using namespace std;

int main(int argc, char ** argv)
{




	char upcVal[13];
	fstream transFile( argv[1], ios::in);

	Dbase newDbase;

	newDbase.Start_Timer();/* Beginning timing od the transaction processes*/


	newDbase.Reset();
	char transChar;
	string upcBuff;
        CD theCD6;
	CD CDtemp;
        while ( transFile >> transChar)
        {
		transFile.ignore();
                if(transChar == 'I')
                {
                        transFile >> theCD6; 
			newDbase.Insert(theCD6);
                }


		else 
		{
			transFile.getline(upcVal,13, '\n');	
			if (transChar == 'D')
			{
				if(newDbase.Search(upcVal) == true)
				{
					newDbase.Delete(upcVal);
				}
				else
				{
					cout << "\"" <<upcVal<< "\"" 
					     << " not found; not deleted" << endl;
				}
			
			}
			else if ( transChar == 'S')
			{
				if(newDbase.Search(upcVal) == true)
				{
					CDtemp = newDbase.Retrieve(upcVal);
					cout << CDtemp << endl;
				}
				else
					cout << "\""<< upcVal << "\"" << 
					" not found" << endl;
			}
		}
        }
          cout.setf(ios::fixed, ios::floatfield);
          cout.setf(ios::showpoint);
          cout.precision(2);

	
	newDbase.Timer();

	return 0;
}
