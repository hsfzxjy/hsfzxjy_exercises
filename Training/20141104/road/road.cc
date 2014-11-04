/*
Jiangsu Olympiad in Informatics
Training Problem
Standard Program

Task:            Road Construction
Author:          Wenyuan Dai
Algorithm:       Prim Algorithm
Complex:         O(n^2)
Code:            Wenyuan Dai
Date:            3-21-2002
Time Limit:      5 seconds(Pentium IV 1.5G & 128MB RAM)
*/
#include <fstream.h>
#include <string.h>
#include <math.h>

ifstream fin("road.in");
ofstream fout("road.out");

class point {
    double x, y;
  public:
    friend double distance(const point&, const point&);
    friend istream& operator >> (istream&, point&);
};

inline double distance(const point& a, const point& b) {
  double dx = a.x - b.x, dy = a.y - b.y;
  return sqrt(dx * dx + dy * dy);
}

inline istream& operator >> (istream& is, point& p) {
  return is >> p.x >> p.y;
}

const int MAX = 5000+10;

point p[MAX];
double l[MAX];
int u[MAX];

main() {
  int n;
  fin >> n;
  for (int i = 0; i < n; fin >> p[i++]);

  memset(l, 0x7F, sizeof(l)); l[0] = 0;
  memset(u, 1, sizeof(u));

  for (int i = 0; i < n; i++) {
    int k = n;
    for (int j = 0; j < n; j++)
      if (u[j] && l[j] < l[k])
        k = j;

    u[k] = 0;

    double temp;
    for (int j = 0; j < n; j++)
      if (u[j] && (temp = distance(p[j], p[k])) < l[j])
        l[j] = temp;
  }

  double sum = 0;
  for (int i = 0; i < n; sum += l[i++]);

  fout.precision(2);
  fout.setf(ios::fixed, ios::floatfield);
  fout << sum << endl;

  return 0;
}
