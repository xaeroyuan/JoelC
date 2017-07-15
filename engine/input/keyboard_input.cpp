#include "keyboard_input.h"

namespace AJ
{
KeyboardInput::KeyboardInput()
{
}

KeyboardInput::KeyboardInput(const KeyboardInput& other)
{
}


KeyboardInput::~KeyboardInput()
{
}

void KeyboardInput::Initialize()
{
	int i;

	// Initialize all the keys to being released and not pressed.
	for (i = 0; i < 256; i++)
	{
		m_keys[i] = false;
	}

	return;
}


void KeyboardInput::KeyDown(unsigned int input)
{
	// If a key is pressed then save that state in the key array.
	m_keys[input] = true;
	return;
}

void KeyboardInput::KeyUp(unsigned int input)
{
	// If a key is released then clear that state in the key array.
	m_keys[input] = false;
	return;
}

bool KeyboardInput::IsKeyDown(unsigned int key)
{
	// Return what state the key is in (pressed/not pressed).
	return m_keys[key];
}
}
