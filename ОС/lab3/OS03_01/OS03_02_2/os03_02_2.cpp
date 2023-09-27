#include <iostream>
#include <Windows.h>

using namespace std;

void main() {
	cout << "========================= OS03_02_02 ========================\n";

	for (USHORT i = 0; i < 125; i++) {
		cout << i << ". PID = " << GetCurrentProcessId() << "\n";
		Sleep(1000);
	}

	const WCHAR* OS02_1 = L"";
}