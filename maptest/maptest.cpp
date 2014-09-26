#include <iostream>
#include <algorithm>
#include <set>
#include <string>

using namespace std;

int main() {
	set<int> s;
	s.insert(12);
	s.insert(23);
	s.insert(12);
	for (set<int>::iterator it=s.begin(); it != s.end(); ++it) {
		cout<< *it << endl;
	}
	return 0;
}
