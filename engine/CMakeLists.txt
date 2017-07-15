cmake_minimum_required (VERSION 3.2)

INCLUDE_DIRECTORIES( $ENV{DXSDK_DIR}/Include )
LINK_DIRECTORIES( $ENV{DXSDK_DIR}/Lib/x64 )


set (SRC
	win_main.cpp
	graphics.cpp
	graphics.h
)
source_group("" FILES ${SRC})

set (SYSTEM
	system/win_system.cpp
	system/win_system.h
)
source_group("System" FILES ${SYSTEM})

set (INPUT
	input/keyboard_input.cpp
	input/keyboard_input.h
)
source_group("Input" FILES ${INPUT})

set (RENDER
	render/directx3d11.cpp
	render/directx3d11.h
	render/model.cpp
	render/model.h
	render/shader.cpp
	render/shader.h
	render/camera.cpp
	render/camera.h
)
source_group("Render" FILES ${RENDER})

set (ALL_SRC
	${SRC}
	${SYSTEM}
	${INPUT}
	${RENDER}
)

# Adds sources to the Solution Explorer
add_executable (engine WIN32 ${ALL_SRC})
 
# Properties->Linker->Input->Additional Dependencies
#target_link_libraries (ysc engine)
 
# Creates a folder "executables" and adds target 
# project (ysc.vcproj) under it
set_property(TARGET engine PROPERTY FOLDER "executables")
 
# Properties->General->Output Directory
set_target_properties(engine PROPERTIES
                      RUNTIME_OUTPUT_DIRECTORY ${AJ_ENGINE_BIN_DIR})