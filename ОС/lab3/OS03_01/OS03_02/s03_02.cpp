#include <iostream>
#include <Windows.h>

using namespace std;

void main() {
	cout << "========================= OS03_02 ========================\n";

	const WCHAR* OS03_1 = L"D:\\Course3\\��\\lab3\\OS03_01\\x64\\Debug\\OS03_02_1.exe";
	const WCHAR* OS03_2 = L"D:\\Course3\\��\\lab3\\OS03_01\\x64\\Debug\\OS03_02_2.exe";

	STARTUPINFO si1, si2;
	PROCESS_INFORMATION pi1, pi2;

	ZeroMemory(&si1, sizeof(STARTUPINFO));			// ��������� ������ STARTUPINFO
	ZeroMemory(&si2, sizeof(STARTUPINFO));

	si1.cb = sizeof(STARTUPINFO);					// ����� �������� ������� ��������� si � ������
	si1.dwFlags = STARTF_USEFILLATTRIBUTE;			// ���� ��� ����������� ������ dwFillAttribute
	si1.dwFillAttribute = (DWORD)FOREGROUND_GREEN;	// �������� ����� ������
	si1.lpReserved = NULL;							// lpReserved ������������� ���������� � null ����� ��������� si � CreateProcess
	
	si2.cb = sizeof(STARTUPINFO);
	si2.dwFlags = STARTF_USEFILLATTRIBUTE;
	si2.dwFillAttribute = (DWORD)FOREGROUND_RED;
	si1.lpReserved = NULL;

	if (CreateProcess(
		OS03_1,			// lpApplicationName:	��� ������������ ������ - exe ��� ������ ��� (MS-DOS ��� OS/2)
		NULL,				// lpCommandLine:		��������� ���������� ������
		NULL,				// lpProcessAttributes: ����� �� ������������ ���������� ���� ����������� ��������� ���������� (null - ������ �����������)
		NULL,				// lpThreadAttributes:	����� �� ������������ ���������� ���� ����������� ��������� �������� (null - ������ �����������)
		FALSE,				// bInheritHandles:		true - ������ ������������ ���������� ����������� �������� ���������; false - �� �����������
		CREATE_NEW_CONSOLE, // dwCreationFlags:		�����, ����������� ����������� � ����������� ��������; ��������� ���� ������� ����� ������� �������
		NULL,				// lpEnvironment:		���� ������������ ������ �������� (���� ����-��������); ���� null, �� ������������ ����������� �� ��������
		NULL,				// lpCurrentDirectory:	������ ���� ��������� ��������; ���� null, �� ������� ��������� � �������� ������������� ��������
		&si1,				// lpStartupInfo:		��������� STARTUPINFO (������� ��� ����)
		&pi1))				// lpProcessInfo:		��������� PROCESS_INFORMATION (����������� �������� � ���������� ������)
		cout << "[OK] Process OS03_02_1 was created.\n";

	if (CreateProcess(OS03_2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si2, &pi2))
		cout << "[OK] Process OS03_02_2 was created.\n\n";
	else cout << "[ERROR] Process OS03_02_2 was not created.\n\n";

	for (USHORT i = 0; i < 100; i++) {
		cout << i << ". PID = " << GetCurrentProcessId() << "\n";
		Sleep(1000);
	}

	WaitForSingleObject(pi1.hProcess, INFINITE);	// ���������� ����� ��������� ���������� ��������� �� �������, 
	WaitForSingleObject(pi2.hProcess, INFINITE);	// ���� ��� �������� �������� �� ������ ������ � ���������� ������
	CloseHandle(pi1.hThread);	// CloseHandle ��������� ����������� � ��������� PROCESS_INFORMATION
	CloseHandle(pi2.hThread);
	CloseHandle(pi1.hProcess);	// ���� ����������� ��������� ����� � �������
	CloseHandle(pi2.hProcess);
}