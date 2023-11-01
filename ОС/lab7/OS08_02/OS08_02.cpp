#include <Windows.h>
#include <iostream>
#include <ctime>

using namespace std;

clock_t to_second(clock_t time) {
	return time / CLOCKS_PER_SEC;
}

void main() 
{
	clock_t 
		start, 
		point;

	bool isFinish = false;

	start = clock();
	for (ULONGLONG i = 0; !isFinish; i++) {
		point = clock();
		switch (to_second(point - start)) {
		case 5: case 10:
			cout << i << endl;
			break;
		case 15:
			isFinish = true;
		}
	}
}