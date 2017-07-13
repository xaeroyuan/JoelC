#pragma once
#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
// Windows Header Files:
#include <windows.h>

class KeyboardInput;
class Graphics;

////////////////////////////////////////////////////////////////////////////////
// Class name: WinSystem
////////////////////////////////////////////////////////////////////////////////
class WinSystem
{
public:
	WinSystem();
	WinSystem(const WinSystem&);
	~WinSystem();

	bool Initialize();
	void Shutdown();
	void Run();

	LRESULT CALLBACK MessageHandler(HWND, UINT, WPARAM, LPARAM);

private:
	bool Frame();
	void InitializeWindows(int&, int&);
	void ShutdownWindows();

private:
	LPCSTR m_applicationName;
	HINSTANCE m_hinstance;
	HWND m_hwnd;

	KeyboardInput* m_Input;
	Graphics* m_Graphics;
};


/////////////////////////
// FUNCTION PROTOTYPES //
/////////////////////////
static LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);


/////////////
// GLOBALS //
/////////////
static WinSystem* ApplicationHandle = 0;