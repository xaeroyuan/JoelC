#include "graphics.h"


namespace AJ
{
Graphics::Graphics()
	: m_pD3D11(nullptr)
	, m_pCamera(nullptr)
	, m_pModel(nullptr)
	, m_pShader(nullptr)
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
	bool result;
	// Create the Direct3D object.
	m_pD3D11.reset(new DirectX11);
	if (!m_pD3D11)
	{
		return false;
	}
	// Initialize the Direct3D object.
	result = m_pD3D11->Initialize(screenWidth, screenHeight, VSYNC_ENABLED, hwnd, FULL_SCREEN, SCREEN_DEPTH, SCREEN_NEAR);
	if(!result)
	{
		MessageBox(hwnd, "Could not initialize Direct3D", "Error", MB_OK);
		return false;
	}

	// Create the camera object.
	m_pCamera.reset(new Camera);
	if (!m_pCamera)
	{
		return false;
	}

	// Set the initial position of the camera.
	m_pCamera->SetPosition(0.0f, 0.0f, -10.0f);

	// Create the model object.
	m_pModel.reset(new Model);
	if (!m_pModel)
	{
		return false;
	}

	// Initialize the model object.
	result = m_pModel->Initialize(m_pD3D11->GetDevice());
	if (!result)
	{
		MessageBox(hwnd, "Could not initialize the model object.", "Error", MB_OK);
		return false;
	}

	// Create the color shader object.
	m_pShader.reset(new Shader);
	if (!m_pShader)
	{
		return false;
	}

	// Initialize the color shader object.
	result = m_pShader->Initialize(m_pD3D11->GetDevice(), hwnd);
	if (!result)
	{
		MessageBox(hwnd, "Could not initialize the color shader object.", "Error", MB_OK);
		return false;
	}

	return true;
}


void Graphics::Shutdown()
{
	// Release the color shader object.
	if (m_pShader)
	{
		m_pShader->Shutdown();
		m_pShader = nullptr;
	}

	// Release the model object.
	if (m_pModel)
	{
		m_pModel->Shutdown();
		m_pModel = nullptr;
	}

	// Release the camera object.
	if (m_pCamera)
	{
		m_pCamera = nullptr;
	}
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
	D3DXMATRIX viewMatrix, projectionMatrix, worldMatrix;
	bool result;


	// Clear the buffers to begin the scene.
	m_pD3D11->BeginScene(0.0f, 0.0f, 0.0f, 1.0f);

	// Generate the view matrix based on the camera's position.
	m_pCamera->Render();

	// Get the world, view, and projection matrices from the camera and d3d objects.
	m_pCamera->GetViewMatrix(viewMatrix);
	m_pD3D11->GetWorldMatrix(worldMatrix);
	m_pD3D11->GetProjectionMatrix(projectionMatrix);

	// Put the model vertex and index buffers on the graphics pipeline to prepare them for drawing.
	m_pModel->Render(m_pD3D11->GetDeviceContext());

	// Render the model using the color shader.
	result = m_pShader->Render(m_pD3D11->GetDeviceContext(), m_pModel->GetIndexCount(), worldMatrix, viewMatrix, projectionMatrix);
	if (!result)
	{
		return false;
	}

	// Present the rendered scene to the screen.
	m_pD3D11->EndScene();
	return true;
}
}
