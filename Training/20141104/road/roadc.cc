/*
Jiangsu Olympiad in Informatics
Training Problem
Testdata Creator Program

Task:            Road Construction
Author:          Wenyuan Dai
Algorithm:       Prim Algorithm
Complex:         O(n^2)
Code:            Wenyuan Dai
Date:            3-21-2002
Time Limit:      5 seconds(Pentium IV 1.5G & 128MB RAM)
*/
#include <fstream.h>
#include <stdlib.h>
#include <time.h>

ofstream fin("road.in");

main() {
  cout << "Enter the number of cities:";
  int n;
  cin >> n;

  srand(time(0));

  fin << n << endl;
  for (int i = 0; i < n; i++)
    fin << rand()%2000001 - 1000000 << ' ' << rand()%2000001 - 1000000 << endl;

  return 0;
}
