

#include <iostream>
#include <cstring>
#include <ctime>
#include <climits>
#include <cstdlib>
using namespace std;

int main()
{
   clock_t start, end;
   double elapsed;

   start = clock();
   cout << "my current clock = " << clock << endl;
   for (int i=1; i <= INT_MAX/6;  i++) ;        // Delay Loop
   system("sleep 1s");
   sleep(1);
   end = clock();

   elapsed = ((double) (end - start)) / CLOCKS_PER_SEC;
   cout << "Clocks per sec + " << CLOCKS_PER_SEC << endl;
   cout << "Took "  << elapsed << " seconds to process "
        << endl;
   return 0;
}

