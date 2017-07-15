#include <memory>
#include "system/win_system.h"

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
	std::unique_ptr<AJ::WinSystem> system(new AJ::WinSystem);

	if (!system)
	{
		return 0;
	}

	// Initialize and run the system object.
	if (system->Initialize())
	{
		system->Run();
	}

	// Shutdown and release the system object.
	system->Shutdown();
	return 0;
}