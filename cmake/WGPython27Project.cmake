# INCLUDE( WGPython27Project ) in projects that #include or link to Python 2.7.
# Core
IF( FIND_CORE_PYTHON_PACKAGE )
	WG_FIND_PACKAGE( CorePython )
ENDIF()

IF( CORE_PYTHON_FOUND )
	SET( PYTHON_FOUND CORE_PYTHON_FOUND )
	SET( PYTHON_DEFINITIONS CORE_PYTHON_DEFINITIONS )
	SET( PYTHON_INCLUDE_DIRS CORE_PYTHON_INCLUDE_DIRS )

	INCLUDE_DIRECTORIES( ${CORE_PYTHON_INCLUDE_DIRS} )
ENDIF()

IF( NOT PYTHON_FOUND )
	# Use ADD_CUSTOM_TARGET because this target has no cpp files
	ADD_CUSTOM_TARGET( ${PROJECT_NAME} COMMENT "${PROJECT_NAME} disabled." )
	BW_PROJECT_CATEGORY( ${PROJECT_NAME} "Disabled" )
ENDIF()

FUNCTION( WGTFPy_REMOVE_COMPILE_FLAGS_FROM_VARIABLE _VARIABLE_NAME)
	SET( _ORIGINAL_FLAGS "${${_VARIABLE_NAME}}" )
	FOREACH( _FLAG IN LISTS ARGN )
		STRING( REGEX REPLACE "${_FLAG}" "" _ORIGINAL_FLAGS "${_ORIGINAL_FLAGS}"  )
	ENDFOREACH()
	SET( ${_VARIABLE_NAME} "${_ORIGINAL_FLAGS}" PARENT_SCOPE )
ENDFUNCTION()

MACRO( WGTFPy_REMOVE_LANGUAGE_COMPILE_FLAGS _LANGUAGE)
	SET(_BASE_VARIABLE_NAME "CMAKE_${_LANGUAGE}_FLAGS")
	WGTFPy_REMOVE_COMPILE_FLAGS_FROM_VARIABLE(${_BASE_VARIABLE_NAME} ${ARGN})

	FOREACH( _CONFIG ${CMAKE_CONFIGURATION_TYPES})
		STRING( TOUPPER ${_CONFIG} _CONFIG )
		SET(_VARIABLE_NAME "${_BASE_VARIABLE_NAME}_${_CONFIG}")
		WGTFPy_REMOVE_COMPILE_FLAGS_FROM_VARIABLE(${_VARIABLE_NAME} ${ARGN})
	ENDFOREACH()
ENDMACRO()

MACRO( WGTFPy_REMOVE_COMPILE_FLAGS )
	WGTFPy_REMOVE_LANGUAGE_COMPILE_FLAGS( C ${ARGN} )
	WGTFPy_REMOVE_LANGUAGE_COMPILE_FLAGS( CXX ${ARGN} )
ENDMACRO()

MACRO( WGTF_TARGET_LINK_PYTHON _TARGET )
	IF( CORE_PYTHON_FOUND )
		BW_TARGET_LINK_LIBRARIES( ${_TARGET} PRIVATE
			libpython-shared
		)
		ADD_DEFINITIONS( -DPy_ENABLE_SHARED )
		WGTFPy_REMOVE_COMPILE_FLAGS( "/D Py_BUILD_CORE" )
	ENDIF()
ENDMACRO()

