#pragma once
#pragma warning(disable: 4005)
#include "d3d11.h"
#include "d3dx10math.h"


namespace AJ
{

////////////////////////////////////////////////////////////////////////////////
// Class name: Model
////////////////////////////////////////////////////////////////////////////////
class Model
{
public:
	Model();
	Model(const Model&);
	~Model();

	bool Initialize(ID3D11Device*);
	void Shutdown();
	void Render(ID3D11DeviceContext*);

	int GetIndexCount();

private:
	struct VertexType
	{
		D3DXVECTOR3 position;
		D3DXVECTOR4 color;
	};

	bool InitializeBuffers(ID3D11Device*);
	void ShutdownBuffers();
	void RenderBuffers(ID3D11DeviceContext*);

	ID3D11Buffer *m_vertexBuffer, *m_indexBuffer;
	int m_vertexCount, m_indexCount;
};


}
