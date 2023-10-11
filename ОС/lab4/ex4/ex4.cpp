#include <iostream>
#include <Windows.h>

using namespace std;

#define THAPI DWORD WINAPI

THAPI os02_04_t1() {
	for (short i = 1; i <= 50; ++i)
	{
		cout
			<< i << ". T1 PID = " << GetCurrentProcessId()
			<< "\t\tTID = " << GetCurrentThreadId() << "\n\n";
		Sleep(1000);
	}

	return 0;
}

THAPI os02_04_t2() {
	for (short i = 1; i <= 125; ++i)
	{
		cout
			<< i << ". T2 PID = " << GetCurrentProcessId()
			<< "\t\tTID = " << GetCurrentThreadId() << "\n\n";
		Sleep(1000);
	}

	return 0;
}


int main()
{
	try {
		DWORD t1, t2;
		HANDLE h1, h2;

		h1 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)os02_04_t1, NULL, NULL, &t1);
		h2 = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)os02_04_t2, NULL, NULL, &t2);

		for (short i = 1; i <= 100; ++i)
		{
			if (i == 2) {
				Sleep(10000);
			}

			cout
				<< i << ". main PID = " << GetCurrentProcessId()
				<< "\t\tTID = " << GetCurrentThreadId() << "\n\n";
			Sleep(1000);
		}

		cout << "Exit\n\n";

		WaitForSingleObject(h1, INFINITE);
		WaitForSingleObject(h2, INFINITE);
		CloseHandle(h1);
		CloseHandle(h2);

		system("pause");
		return 0;
	}
	catch (...) {
		cout << "Error\n";
	}
}