#pragma once

#pragma warning(disable: 4005)
/////////////
// LINKING //
/////////////
#pragma comment(lib, "dxgi.lib")
#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "d3dx11.lib")
#pragma comment(lib, "d3dx10.lib")

#include "d3d11.h"
#include "dxgi.h"
#include "d3dcommon.h"
#include "d3dx10math.h"

namespace AJ
{
////////////////////////////////////////////////////////////////////////////////
// Class name: DirectX11
////////////////////////////////////////////////////////////////////////////////
class DirectX11
{
public:
	DirectX11();
	DirectX11(const DirectX11&);
	~DirectX11();

	bool Initialize(int, int, bool, HWND, bool, float, float);
	void Shutdown();

	void BeginScene(float, float, float, float);
	void EndScene();

	ID3D11Device* GetDevice();
	ID3D11DeviceContext* GetDeviceContext();

	void GetProjectionMatrix(D3DXMATRIX&);
	void GetWorldMatrix(D3DXMATRIX&);
	void GetOrthoMatrix(D3DXMATRIX&);

	void GetVideoCardInfo(char*, int&);

private:
	bool m_vsync_enabled;
	int m_videoCardMemory;
	char m_videoCardDescription[128];
	// Direct3D device and swap chain.
	IDXGISwapChain* m_swapChain;
	ID3D11Device* m_device;
	ID3D11DeviceContext* m_deviceContext;

	// Render target view for the back buffer of the swap chain.
	ID3D11RenderTargetView* m_renderTargetView;
	// A texture to associate to the depth stencil view.
	ID3D11Texture2D* m_depthStencilBuffer;
	// Define the functionality of the depth/stencil stages.
	ID3D11DepthStencilState* m_depthStencilState;
	// Depth/stencil view for use as a depth buffer.
	ID3D11DepthStencilView* m_depthStencilView;
	// Define the functionality of the rasterizer stage.
	ID3D11RasterizerState* m_rasterState;
	D3DXMATRIX m_projectionMatrix;
	D3DXMATRIX m_worldMatrix;
	D3DXMATRIX m_orthoMatrix;
};
}
