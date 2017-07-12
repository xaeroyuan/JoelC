cmake_minimum_required (VERSION 3.2)

set (SRC
	main.cpp
)
source_group("" FILES ${SRC})

set (SYSTEM
	system/system.cpp
	system/system.h
)
source_group("System" FILES ${SYSTEM})

set (INPUT
	input/input.cpp
	input/input.h
)
source_group("Input" FILES ${INPUT})

set (RENDER
	render/graphics.cpp
	render/graphics.h
)
source_group("Graphics" FILES ${RENDER})

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
                      RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)