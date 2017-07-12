SET( WG_UNIT_TESTS_ENABLED ON )
SET( BW_SINGLETON_MANAGER_SUPPORT ON )
SET( NGT_SUPPORT ON )
SET( CORE_PYTHON_SUPPORT ON )
SET( Maya_SUPPORT ON )
SET( Perforce_SUPPORT ON )
SET( DEPLOY_QT_SUPPORT ON )
SET( DEPLOY_PYTHON_SUPPORT OFF )
SET( WG_TOOLS_CORE_BINARY_PROJECTS ON )

ADD_DEFINITIONS( -DEDITOR_ENABLED )
ADD_DEFINITIONS( -DALLOW_STACK_CONTAINER )
ADD_DEFINITIONS( -DBW_SHARED_LIBS )

SET( TARGET_PLUGIN_APP_FOLDER_NAME generic_app_test )
SET( BW_BUNDLE_NAME generic_app )

INCLUDE( projects/core/WGToolsCore )
INCLUDE( projects/core/WGToolsCoreTests )
