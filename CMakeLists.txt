cmake_minimum_required (VERSION 3.2)

# Set the engine source directory
SET( AJ_ENGINE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR} )

# Set serach location for CMake include files
SET( CMAKE_MODULE_PATH "${AJ_ENGINE_SOURCE_DIR}/cmake_module" )
 
# Override the default CMake configs: Debug Release MinSizeRel RelWithDebInfo
# This must appear before ENABLE_LANGUAGE to override the defaults
SET( CMAKE_CONFIGURATION_TYPES Debug;Release
	CACHE STRING "Semicolon separated list of supported configuration types"
	FORCE )

INCLUDE( AJPlatformOptions )

# Detect clang-cl
IF( ${CMAKE_C_COMPILER_ID} MATCHES "Clang" )
	SET( CLANG_CL 1 )
ENDIF()

# Set compiler and linker options
INCLUDE( AJGlobalCompilerAndLinkerOptions )


# Ensure we have a functioning compiler. Work around CMake failing to detect
# that the compiler is unknown, do this by making sure there's some flags
IF( NOT CMAKE_CXX_FLAGS )
	MESSAGE( FATAL_ERROR "CMake failed to find a valid compiler!" )
ENDIF()

MESSAGE( STATUS "Compiler: ${AJ_COMPILER_TOKEN}" )

# Maps to Visual Studio solution file (Tutorial.sln)
# The solution will have all targets (exe, lib, dll) 
# as Visual Studio projects (.vcproj)
PROJECT (Xaero_${AJ_PLATFORM})

# Binary output location
GET_FILENAME_COMPONENT( AJ_ENGINE_BIN_DIR "${AJ_ENGINE_SOURCE_DIR}/bin" REALPATH )

# Turn on the ability to create folders to organize projects (.vcproj)
# It creates "CMakePredefinedTargets" folder by default and adds CMake
# defined projects like INSTALL.vcproj and ZERO_CHECK.vcproj
SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)

INCLUDE_DIRECTORIES( ${AJ_ENGINE_SOURCE_DIR}/engine )

# Sub-directories where more CMakeLists.txt exist
add_subdirectory(engine)

# Turn on CMake testing capabilities
enable_testing()