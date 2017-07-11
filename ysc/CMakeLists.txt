# Properties->C/C++->General->Additional Include Directories

 
# Set Properties->General->Configuration Type to Application(.exe)
# Creates ysc.exe with the listed sources (main.cxx)
# Adds sources to the Solution Explorer
add_executable (ysc WIN32 main.cpp)
 
# Properties->Linker->Input->Additional Dependencies
#target_link_libraries (ysc math)
 
# Creates a folder "executables" and adds target 
# project (ysc.vcproj) under it
set_property(TARGET ysc PROPERTY FOLDER "executables")
 
# Properties->General->Output Directory
set_target_properties(ysc PROPERTIES
                      RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)