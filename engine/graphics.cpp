#include "graphics.h"


namespace AJ
{
Graphics::Graphics()
	: m_pD3D11(nullptr)
{
}


Graphics::Graphics(const Graphics& other)
{
}


Graphics::~Graphics()
{
}


bool Graphics::Initialize(int screenWidth, int screenHeight, HWND hwnd)
{
	// Create the Direct3D object.
	m_pD3D11.reset(new DirectX11);
	if (!m_pD3D11)
	{
		return false;
	}
	// Initialize the Direct3D object.
	if(!m_pD3D11->Initialize(screenWidth, screenHeight, VSYNC_ENABLED, hwnd, FULL_SCREEN, SCREEN_DEPTH, SCREEN_NEAR))
	{
		MessageBox(hwnd, "Could not initialize Direct3D", "Error", MB_OK);
		return false;
	}

	return true;
}


void Graphics::Shutdown()
{
	if (m_pD3D11)
	{
		m_pD3D11->Shutdown();
		m_pD3D11 = nullptr;
	}
}


bool Graphics::Frame()
{
	if (!Render())
	{
		return false;
	}
	return true;
}


bool Graphics::Render()
{
	// Clear the buffers to begin the scene.
	m_pD3D11->BeginScene(0.5f, 0.5f, 0.5f, 1.0f);

	// Present the rendered scene to the screen.
	m_pD3D11->EndScene();
	return true;
}
}
