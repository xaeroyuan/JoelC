#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
// Windows Header Files:
#include <windows.h>

/**
 * The main application entry point for Windows platforms.
 *
 * @param hInInstance Handle to the current instance of the application.
 * @param hPrevInstance Handle to the previous instance of the application (always NULL).
 * @param lpCmdLine Command line for the application.
 * @param nShowCmd Specifies how the window is to be shown.
 * @return Application's exit value.
 */
int WINAPI WinMain( HINSTANCE hInInstance, HINSTANCE hPrevInstance, char* lpCmdLine, int nShowCmd )
{
	//const wchar_t* CmdLine = ::GetCommandLineW();

	int ErrorLevel = 0;

#if 0
		// call main
#else
	__try

		{
			ErrorLevel = 1;
			// call main
	}
	__except (GetExceptionCode())
	{
		ErrorLevel = 1;
	}
#endif
	return ErrorLevel;
}