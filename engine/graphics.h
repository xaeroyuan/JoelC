#pragma once
#include "render/directx3d11.h"
#include "render/camera.h"
#include "render/model.h"
#include "render/shader.h"
#include <memory>

namespace AJ
{

const bool FULL_SCREEN = false;
const bool VSYNC_ENABLED = true;
const float SCREEN_DEPTH = 1000.0f;
const float SCREEN_NEAR = 0.1f;

////////////////////////////////////////////////////////////////////////////////
// Class name: Graphics
////////////////////////////////////////////////////////////////////////////////
class Graphics
{
public:
	Graphics();
	Graphics(const Graphics&);
	~Graphics();

	bool Initialize(int, int, HWND);
	void Shutdown();
	bool Frame();

private:
	bool Render();

private:
	std::unique_ptr<DirectX11> m_pD3D11;
	std::unique_ptr<Camera> m_pCamera;
	std::unique_ptr<Model> m_pModel;
	std::unique_ptr<Shader> m_pShader;
};
}
