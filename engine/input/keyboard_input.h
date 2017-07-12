#pragma once

////////////////////////////////////////////////////////////////////////////////
// Class name: KeyboardInput
////////////////////////////////////////////////////////////////////////////////
class KeyboardInput
{
public:
	KeyboardInput();
	KeyboardInput(const KeyboardInput&);
	~KeyboardInput();

	void Initialize();

	void KeyDown(unsigned int);
	void KeyUp(unsigned int);

	bool IsKeyDown(unsigned int);

private:
	bool m_keys[256];
};

