#include <windows.h>
#include <string>
#include <ctime>
#include <iostream>
#include <fstream>

using namespace std;

#define EXPORT extern "C" __declspec(dllexport)
#define dword unsigned int
#define byte unsigned char
// #define PTR void*

BOOL APIENTRY DllMain(
        HMODULE hModule,
        DWORD ul_reason_for_call,
        LPVOID lpReserved
) {
    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            srand((int)time(0));
            break;
        case DLL_THREAD_ATTACH:
        case DLL_THREAD_DETACH:
        case DLL_PROCESS_DETACH:
            break;
    }
    return TRUE;
}

template<class T> T* pointer(T value) { return &value; }

int Rnd(int min, int max) {
    static const double fraction = 1.0 / (RAND_MAX + 1.0);
    return (int)(rand() * fraction * (max - min + 1) + min);
}

void LOG(string s) {
    string filename = "DenUtilities.log";
    ofstream file(filename, ios::out);
    file << s;
    file.close();
}

EXPORT dword test(dword arg1, dword arg2, dword arg3, dword arg4, dword arg5) { return 0; }

EXPORT dword GetDword(dword* ptr) { return *ptr; }
EXPORT dword SetDword(dword* ptr, dword value) { return *ptr = value; }

EXPORT float GetFloat(float* ptr) { return *ptr; }
EXPORT float SetFloat(float* ptr, float value) { return *ptr = value; }

EXPORT float GetDouble(double* ptr) { return (float)*ptr; }
EXPORT float SetDouble(double* ptr, float value) { return (float)(*ptr = (double)value); }

EXPORT dword GetByte(byte* ptr) { return *(byte*)ptr; }
EXPORT dword SetByte(byte* ptr, dword value) { return *(byte*)ptr = value; }

// WStr - широкая строка, два байта на символ, нуль-терминатор. Используется в игре повсеместно, в том числе в переменных-строках
// CStr - C-строка, один байт на символ, нуль-терминатор. Возможно, используется где-то в игре, так что я реализовал и этот вариант
// копирует WStr и возвращает указатель
EXPORT byte* WStr_to_WStr(byte* wstr_0) {
    int len = 0;
    while (wstr_0[len] || wstr_0[len + 1]) len += 2;
    byte* wstr_1 = new byte[2 * (len + 1)];
    for (int i = 0; i <= len; i++) {
        wstr_1[2 * i] = wstr_0[2 * i];
        wstr_1[2 * i + 1] = wstr_0[2 * i + 1];
    }
    return wstr_1;
}

// преобразует CStr в WStr и возвращает указатель
EXPORT byte* CStr_to_WStr(byte* cstr) {
    int len = 0;
    while (cstr[len]) len++;
    byte* wstr = new byte[2 * (len + 1)];
    for (int i = 0; i <= len; i++){
        wstr[2 * i] = cstr[i];
        wstr[2 * i + 1] = 0;
    }
    return wstr;
}

// преобразует WStr в CStr и возвращает указатель
// !!! теряются данные, если некоторые символы были не из ASCII !!!
EXPORT byte* WStr_to_CStr(byte* wstr) {
    int len = 0;
    while (wstr[len] || wstr[len + 1]) len += 2;
    byte* cstr = new byte[len + 1];
    for (int i = 0; i <= len; i++){
        cstr[i] = wstr[2 * i];
    }
    return cstr;
}


EXPORT byte* AllocateMemory(int size) {
    byte* ptr = new byte[size];
    for (int i = 0; i < size; i++)
        ptr[i] = 0;
    return ptr;
}

EXPORT dword FreeMemory(byte* ptr) {
    delete[] ptr; return 0;
}

EXPORT byte* ReAllocateMemory(byte* ptr, int size, int new_size) {
    byte* new_ptr = new byte[new_size];
    for (int i = 0; i < new_size; i++)
        new_ptr[i] = 0;
    for (int i = 0; i < min(size, new_size); i++)
        new_ptr[i] = ptr[i];
    return new_ptr;
}

EXPORT dword CopyMem(byte* from, byte* to, int size) {
    for (int i = 0; i < size; i++)
        to[i] = from[i];
    return 0;
}