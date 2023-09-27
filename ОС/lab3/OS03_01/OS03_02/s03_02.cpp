#include <iostream>
#include <Windows.h>

using namespace std;

void main() {
	cout << "========================= OS03_02 ========================\n";

	const WCHAR* OS03_1 = L"D:\\Course3\\ОС\\lab3\\OS03_01\\x64\\Debug\\OS03_02_1.exe";
	const WCHAR* OS03_2 = L"D:\\Course3\\ОС\\lab3\\OS03_01\\x64\\Debug\\OS03_02_2.exe";

	STARTUPINFO si1, si2;
	PROCESS_INFORMATION pi1, pi2;

	ZeroMemory(&si1, sizeof(STARTUPINFO));			// обнуление памяти STARTUPINFO
	ZeroMemory(&si2, sizeof(STARTUPINFO));

	si1.cb = sizeof(STARTUPINFO);					// явное указание размера структуры si в байтах
	si1.dwFlags = STARTF_USEFILLATTRIBUTE;			// флаг для возможности работы dwFillAttribute
	si1.dwFillAttribute = (DWORD)FOREGROUND_GREEN;	// параметр цвета текста
	si1.lpReserved = NULL;							// lpReserved рекомендуется установить в null перед передачей si в CreateProcess
	
	si2.cb = sizeof(STARTUPINFO);
	si2.dwFlags = STARTF_USEFILLATTRIBUTE;
	si2.dwFillAttribute = (DWORD)FOREGROUND_RED;
	si1.lpReserved = NULL;

	if (CreateProcess(
		OS03_1,			// lpApplicationName:	имя исполняемого модуля - exe иди другой тип (MS-DOS или OS/2)
		NULL,				// lpCommandLine:		параметры коммандной строки
		NULL,				// lpProcessAttributes: может ли возвращаемый дескриптор быть унаследован дочерними процессами (null - нельзя наследовать)
		NULL,				// lpThreadAttributes:	может ли возвращаемый дескриптор быть унаследован дочерними потоками (null - нельзя наследовать)
		FALSE,				// bInheritHandles:		true - каждый возвращаемый дескриптор наследуется дочерним процессом; false - не наследуется
		CREATE_NEW_CONSOLE, // dwCreationFlags:		флаги, управляющие приоритетом и параметрами процесса; конкретно этот создает новый инстанс консоли
		NULL,				// lpEnvironment:		блок конфигурации нового процесса (пары ключ-значение); если null, то конфигурация наследуется от родителя
		NULL,				// lpCurrentDirectory:	полный путь дочернего процесса; если null, то процесс создается в каталоге родительского процесса
		&si1,				// lpStartupInfo:		структура STARTUPINFO (внешний вид окна)
		&pi1))				// lpProcessInfo:		структура PROCESS_INFORMATION (дескрипторы процесса и первичного потока)
		cout << "[OK] Process OS03_02_1 was created.\n";

	if (CreateProcess(OS03_2, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, NULL, &si2, &pi2))
		cout << "[OK] Process OS03_02_2 was created.\n\n";
	else cout << "[ERROR] Process OS03_02_2 was not created.\n\n";

	for (USHORT i = 0; i < 100; i++) {
		cout << i << ". PID = " << GetCurrentProcessId() << "\n";
		Sleep(1000);
	}

	WaitForSingleObject(pi1.hProcess, INFINITE);	// бесконечно будет ожидаться завершение программы до момента, 
	WaitForSingleObject(pi2.hProcess, INFINITE);	// пока оба дочерних процесса не пошлют сигнал о завершении работы
	CloseHandle(pi1.hThread);	// CloseHandle закрывает дескрипторы в структуре PROCESS_INFORMATION
	CloseHandle(pi2.hThread);
	CloseHandle(pi1.hProcess);	// Явно закрываются первичный поток и процесс
	CloseHandle(pi2.hProcess);
}