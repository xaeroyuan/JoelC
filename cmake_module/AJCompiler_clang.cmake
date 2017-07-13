# Enable MACOSX_RPATH by default
cmake_policy(SET CMP0042 NEW)

### CLANG COMPILER FLAGS ###

# Flags used by C and C++ compilers for all build types
SET( AJ_COMPILER_FLAGS
	-fvisibility-inlines-hidden
    #see https://developer.apple.com/library/mac/technotes/tn2185/_index.html
    # for detail
	-fvisibility-ms-compat
	)

# Flags used by C and C++ compilers for specific architectures	
IF( CMAKE_SIZEOF_VOID_P EQUAL 4 )
	LIST( APPEND AJ_COMPILER_FLAGS 
		)
ELSEIF( CMAKE_SIZEOF_VOID_P EQUAL 8 )
	LIST( APPEND AJ_COMPILER_FLAGS
		)
ENDIF()

# Flags used by C and C++ compilers for Debug builds
SET( AJ_COMPILER_FLAGS_DEBUG
	${AJ_COMPILER_FLAGS}
	#-Werror
	# Preprocessor definitions
	-D_DEBUG
	-g
	-O0
	)

# Flags used by C and C++ compilers for Release builds
SET( AJ_COMPILER_FLAGS_OPTIMIZED
	${AJ_COMPILER_FLAGS}
	# Optimization
	-O3
	)

# Flags used by C and C++ compilers for Release builds
SET( BW_COMPILER_FLAGS_RELEASE ${BW_COMPILER_FLAGS_OPTIMIZED} )

# Flags used by the C compiler 
SET( AJ_C_FLAGS $ENV{CFLAGS} ${AJ_COMPILER_FLAGS} )
SET( AJ_C_FLAGS_DEBUG ${AJ_COMPILER_FLAGS_DEBUG} )
SET( AJ_C_FLAGS_RELEASE ${AJ_COMPILER_FLAGS_RELEASE} )

# Flags used by the C++ compiler
SET( AJ_CXX_FLAGS $ENV{CXXFLAGS} ${AJ_COMPILER_FLAGS}
	)
SET( AJ_CXX_FLAGS_DEBUG ${AJ_COMPILER_FLAGS_DEBUG} )
SET( AJ_CXX_FLAGS_RELEASE ${AJ_COMPILER_FLAGS_RELEASE} )


# Flags used by the linker for all build types
SET( AJ_LINKER_FLAGS 

)

# Flags used by the linker for Debug builds
SET( AJ_LINKER_FLAGS_DEBUG
	-g
	)

# Flags used by the linker for optimized builds
SET( AJ_LINKER_FLAGS_OPTIMIZED
	)
SET( AJ_LINKER_RELEASE ${AJ_LINKER_FLAGS_OPTIMIZED} )

# Set up variables for EXE, MODULE, SHARED, and STATIC linking

# Flags used by the linker
SET( AJ_EXE_LINKER_FLAGS ${AJ_LINKER_FLAGS} )
SET( AJ_EXE_LINKER_FLAGS_DEBUG ${AJ_LINKER_FLAGS_DEBUG} )
SET( AJ_EXE_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_RELEASE} )

# Flags used by the linker for the creation of modules.
SET( AJ_MODULE_LINKER_FLAGS ${AJ_LINKER_FLAGS} )
SET( AJ_MODULE_LINKER_FLAGS_DEBUG ${AJ_LINKER_FLAGS_DEBUG} )
SET( AJ_MODULE_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_RELEASE} )

# Flags used by the linker for the creation of dynamic libraries.
SET( AJ_SHARED_LINKER_FLAGS ${AJ_LINKER_FLAGS} )
SET( AJ_SHARED_LINKER_FLAGS_DEBUG ${AJ_LINKER_FLAGS_DEBUG} )
SET( AJ_SHARED_LINKER_FLAGS_RELEASE ${AJ_LINKER_FLAGS_RELEASE} )

# Flags used by the linker for the creation of static libraries.
SET( AJ_STATIC_LINKER_FLAGS "" )
SET( AJ_STATIC_LINKER_FLAGS_DEBUG "" )
SET( AJ_STATIC_LINKER_FLAGS_RELEASE "" )
