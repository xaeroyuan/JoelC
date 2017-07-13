### MSVC COMPILER FLAGS ###

# Flags used by C and C++ compilers for all build types
SET( AJ_COMPILER_FLAGS
	# Preprocessor definitions
	/DWIN32
	/D_WINDOWS

	# General
	/W3		# Warning level 3
	/Zi		# Always generate debug information
	/MP		# Enable parallel builds
	/WX		# Enable warnings as errors
	
	# Code generation
	/Gy		# Enable function level linking

	/w34302 # Enable warning 'conversion': truncation from 'type1' to 'type2'
	/wd4251 # Disable warning 'type1' needs to have dll-interface to be used by clients of class 'type2'
	/d2Zi+	# Put local variables and inline functions into the PDB
	)

# Flags used by C and C++ compilers for specific architectures
IF( CMAKE_SIZEOF_VOID_P EQUAL 4 )
	LIST( APPEND AJ_COMPILER_FLAGS
		# Code generation
		/arch:SSE2	# Streaming SIMD extensions 2
		)
ELSEIF( CMAKE_SIZEOF_VOID_P EQUAL 8 )
	LIST( APPEND AJ_COMPILER_FLAGS
		# Preprocessor definitions
		/D_WIN64
		)
ENDIF()

# Flags used by C and C++ compilers for Debug builds
SET( AJ_COMPILER_FLAGS_DEBUG
	# Preprocessor definitions
	/D_DEBUG

	# Optimization
	/Od		# Disable optimization
	/Ob0	# Disable inline function expansion

	# Code generation
	/MDd	# Multi-threaded debug DLL runtime library
	/RTC1	# Basic runtime checks
	)

# Flags used by C and C++ compilers for Release builds
SET( AJ_COMPILER_FLAGS_OPTIMIZED
	# Optimization
	/Ox		# Full optimization
	/Ob2	# Any suitable inline function expansion
	/Oi		# Enable intrinsic functions
	/Ot		# Favor fast code

	# Code generation
	/GF		# Enable string pooling
	/MD		# Multi-threaded debug DLL runtime library
	)

# Flags used by C and C++ compilers for Release builds
SET( AJ_COMPILER_FLAGS_RELEASE ${AJ_COMPILER_FLAGS_OPTIMIZED} )

# Flags used by the C compiler
SET( AJ_C_FLAGS $ENV{CFLAGS} ${AJ_COMPILER_FLAGS} )
SET( AJ_C_FLAGS_DEBUG ${AJ_COMPILER_FLAGS_DEBUG} )
SET( AJ_C_FLAGS_RELEASE ${AJ_COMPILER_FLAGS_RELEASE} )

# Flags used by the C++ compiler
SET( AJ_CXX_FLAGS $ENV{CXXFLAGS} ${AJ_COMPILER_FLAGS}
	# Language
	/GR		# Enable Runtime Type Information

	# Code generation
	/EHsc	# Enable C++ exceptions

	# Additional options
	/w34263 # Enable virtual function is hidden warning at /W3

	# Fix for errors in Visual Studio 2012
	# "c1xx : fatal error C1027: Inconsistent values for /Ym between creation
	# and use of precompiled header"
	# http://www.ogre3d.org/forums/viewtopic.php?f=2&t=60015
	/Zm282
	)
SET( AJ_CXX_FLAGS_DEBUG ${AJ_COMPILER_FLAGS_DEBUG} )
SET( AJ_CXX_FLAGS_RELEASE ${AJ_COMPILER_FLAGS_RELEASE} )


### MSVC Linker Flags ###

# Flags used by the linker for all build types
SET( AJ_LINKER_FLAGS

	# Fix linker errors and warnings due to nvtt and new umbraruntime.lib
	# for nvtt disagreement on CRT libraries (built with libcmt, rest of libs built with msvcrt).
	# adding umbra seems to have changed linking order, which brings up this error?...
	/NODEFAULTLIB:libcmt
)

# Flags used by the linker for different arch types
IF( CMAKE_SIZEOF_VOID_P EQUAL 4 )
	LIST( APPEND AJ_LINKER_FLAGS
		/MACHINE:X86 )
ELSEIF( CMAKE_SIZEOF_VOID_P EQUAL 8 )
	LIST( APPEND AJ_LINKER_FLAGS
		/MACHINE:X64 )
ENDIF()

# Flags used by the linker for Debug builds
SET( AJ_LINKER_FLAGS_DEBUG
	# General
	/INCREMENTAL	# Enable incremental linking

	# Debugging
	/DEBUG			# Generate debug info
	)

# Flags used by the linker for optimized builds
SET( AJ_LINKER_FLAGS_OPTIMIZED
	# General
	/INCREMENTAL:NO	# Disable incremental linking

	# Debugging
	/DEBUG			# Generate debug info

	# Optimization
	/OPT:REF		# Eliminate unreferenced functions and data
	/OPT:ICF		# Enable COMDAT folding
	)
SET( AJ_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_OPTIMIZED} )

# Set up variables for EXE, MODULE, SHARED, and STATIC linking

# Flags used by the linker
SET( AJ_EXE_LINKER_FLAGS ${AJ_LINKER_FLAGS} )
SET( AJ_EXE_LINKER_FLAGS_DEBUG ${AJ_LINKER_FLAGS_DEBUG} )
SET( AJ_EXE_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_RELEASE} )

# Flags used by the linker for the creation of modules.
SET( AJ_MODULE_LINKER_FLAGS ${AJ_LINKER_FLAGS} )
SET( AJ_MODULE_LINKER_FLAGS_DEBUG ${AJ_LINKER_FLAGS_DEBUG} )
SET( AJ_MODULE_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_RELEASE} )

# Flags used by the linker for the creation of dll's.
SET( AJ_SHARED_LINKER_FLAGS ${AJ_LINKER_FLAGS} )
SET( AJ_SHARED_LINKER_FLAGS_DEBUG ${AJ_LINKER_FLAGS_DEBUG} )
SET( AJ_SHARED_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_RELEASE} )

# Flags used by the linker for the creation of static libraries.
SET( AJ_STATIC_LINKER_FLAGS "" )
SET( AJ_STATIC_LINKER_FLAGS_DEBUG "" )
SET( AJ_STATIC_LINKER_FLAGS_RELEASE "" )


### MSVC Resource Compiler Flags ###

# Flags for the resource compiler
	# comments from WoT:
	# cmake 2.8.12 happily allowed the nologo specificaion, but cmake 3.3.2 complains with
    # "RC : fatal error RC1106: invalid option: -ologo" errors.
    # The issue is due to /nologo being added twice to the command line for 'RC'.
    # I'm not sure which versions will work or not, but let's just distinguish between major
    # versions 2 and 3 in the knowledge that WoT has gone from versions 2.8.12.2 to 3.3.2.
IF (CMAKE_MAJOR_VERSION LESS 3)
	SET( AJ_RC_FLAGS
		/nologo		# Suppress startup banner
	)
ENDIF()

IF( ${CMAKE_GENERATOR} STREQUAL "Ninja" )
	# Force compiling against XP with Ninja
	# - see http://blogs.msdn.com/b/vcblog/archive/2012/10/08/windows-xp-targeting-with-c-in-visual-studio-2012.aspx
	ADD_DEFINITIONS( -D_USING_V110_SDK71_ )
	IF( ${BW_PLATFORM} STREQUAL "win32" )
		SET( CMAKE_CREATE_WIN32_EXE "/subsystem:windows,5.01" )
	ELSEIF( ${BW_PLATFORM} STREQUAL "win64" )
		SET( CMAKE_CREATE_WIN32_EXE "/subsystem:windows,5.02" )
	ENDIF()
ENDIF()

# Do compiler specific configuration. These are generally used to link
# against .libs for a specific version of MSVC.
IF( MSVC14 )
	SET( AJ_COMPILER_TOKEN "vc14" )
ELSE()
	MESSAGE( FATAL_ERROR "Compiler '${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}' not currently supported by Wargaming." )
ENDIF()


