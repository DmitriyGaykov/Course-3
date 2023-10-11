#include <iostream>
#include <Windows.h>
#include <thread>
#include <chrono>

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
		thread thread1(os02_04_t1);
		thread thread2(os02_04_t2);

		for (short i = 1; i <= 100; ++i)
		{
			if (i == 10) {
				TerminateThread(thread2.native_handle(), -1);
			}

			cout
				<< i << ". main PID = " << GetCurrentProcessId()
				<< "\t\tTID = " << GetCurrentThreadId() << "\n\n";
			Sleep(1000);
		}

		cout << "Exit\n\n";

		WaitForSingleObject(thread1.native_handle(), INFINITE);
		WaitForSingleObject(thread2.native_handle(), INFINITE);
		CloseHandle(thread1.native_handle());
		CloseHandle(thread2.native_handle());

		system("pause");
		return 0;
	}
	catch (...) {
		cout << "Error\n";
	}
}