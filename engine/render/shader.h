#pragma once
#pragma warning(disable: 4005)
#include "d3d11.h"
#include "d3dx10math.h"
#include "d3dx11async.h"
#include <fstream>

namespace AJ
{
////////////////////////////////////////////////////////////////////////////////
// Class name: Shader
////////////////////////////////////////////////////////////////////////////////
class Shader
{
public:
	Shader();
	Shader(const Shader&);
	~Shader();

	bool Initialize(ID3D11Device*, HWND);
	void Shutdown();
	bool Render(ID3D11DeviceContext*, int, D3DXMATRIX, D3DXMATRIX, D3DXMATRIX);

private:
	struct MatrixBufferType
	{
		D3DXMATRIX world;
		D3DXMATRIX view;
		D3DXMATRIX projection;
	};

	// Now we will start with one of the more important functions to this tutorial which is called InitializeShader.
	// This function is what actually loads the shader files and makes it usable to DirectX and the GPU.
	// You will also see the setup of the layout and how the vertex buffer data is going to look on the graphics pipeline in the GPU.
	// The layout will need the match the VertexType in the modelclass.h file as well as the one defined in the color.vs file.
	bool InitializeShader(ID3D11Device*, HWND, TCHAR*, TCHAR*);

	// ShutdownShader releases the four interfaces that were setup in the InitializeShader function.
	void ShutdownShader();

	// The OutputShaderErrorMessage writes out error messages that are generating when compiling either vertex shaders or pixel shaders.
	void OutputShaderErrorMessage(ID3D10Blob*, HWND, TCHAR*);

	// The SetShaderVariables function exists to make setting the global variables in the shader easier. 
	// The matrices used in this function are created inside the GraphicsClass, after which this function is called to send them from there into the vertex shader during the Render function call.
	bool SetShaderParameters(ID3D11DeviceContext*, D3DXMATRIX, D3DXMATRIX, D3DXMATRIX);
	// RenderShader is the second function called in the Render function. 
	// SetShaderParameters is called before this to ensure the shader parameters are setup correctly.
	void RenderShader(ID3D11DeviceContext*, int);

private:
	ID3D11VertexShader* m_vertexShader;
	ID3D11PixelShader* m_pixelShader;
	ID3D11InputLayout* m_layout;
	ID3D11Buffer* m_matrixBuffer;
};
}
