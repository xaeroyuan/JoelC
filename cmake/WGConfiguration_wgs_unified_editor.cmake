SET( BW_SINGLETON_MANAGER_SUPPORT ON )
SET( NGT_SUPPORT ON )
SET( DEPLOY_QT_SUPPORT ON )
SET( CORE_PYTHON_SUPPORT ON ) # If python path found build the python libraries and plugins
SET( Perforce_SUPPORT ON )
SET( WG_IS_WGS_APP ON ) # Used to add Despair Libraries to plg_wgs_core
SET( WG_TOOLS_CORE_BINARY_PROJECTS OFF )
SET( DEPLOY_PYTHON_SUPPORT ON )
SET( DEPLOY_QT_TARGET_PROJECT wgs_generic_app )
SET( WGS_CORE_PLUGIN_DIR ${BW_SOURCE_DIR}/wgs/plugins/plg_wgs_core )

ADD_DEFINITIONS( -DEDITOR_ENABLED )
ADD_DEFINITIONS( -DALLOW_STACK_CONTAINER )
ADD_DEFINITIONS( -DBW_SHARED_LIBS )
ADD_DEFINITIONS( -DDS_ASSERT_ENABLED )

INCLUDE( projects/core/WGToolsCore )
INCLUDE( projects/core/WGToolsCoreTests )

INCLUDE_DIRECTORIES( ${BW_SOURCE_DIR}/core )
INCLUDE_DIRECTORIES( ${BW_SOURCE_DIR}/core/lib )
INCLUDE_DIRECTORIES( ${BW_SOURCE_DIR}/bw )
INCLUDE_DIRECTORIES( ${BW_SOURCE_DIR}/bw/lib )

IF( WG_UNIT_TESTS_ENABLED )
	IF(MSVC)
		LIST( APPEND BW_BINARY_PROJECTS
			wgs_core_test 					wgs/testing/wgs_core_test
			wgs_core_unit_test  			wgs/plugins/plg_wgs_core/unit_test
			wgs_object_editor_unit_test 	wgs/plugins/plg_wgs_object_editor/unit_test
		)
		LIST( APPEND BW_LIBRARY_PROJECTS
			wgs_unit_test					wgs/plugins/plg_wgs_core/unit_test/wgs_unit_test
		)
	ENDIF()
ENDIF()

SET( TARGET_PLUGIN_APP_FOLDER_NAME wgs_unified_editor )

LIST( APPEND BW_LIBRARY_PROJECTS
	resource_db		wgs/interfaces/resource_db
)

LIST( APPEND BW_BINARY_PROJECTS
	#WGS Apps
	unified_editor			wgs/app/unified_editor
	particle_editor			wgs/app/particle_editor
	multi_edit				wgs/app/multi_edit
	wgs_generic_app			wgs/app/wgs_generic_app
)

LIST( APPEND BW_PLUGIN_PROJECTS
	#WGS plugins
	plg_despair_reflection_test						wgs/plugins/plg_despair_reflection_test
	plg_wgs_asset_browser							wgs/plugins/plg_wgs_asset_browser
	plg_wgs_behavior_editor							wgs/plugins/plg_wgs_behavior_editor
	plg_wgs_blueprint_editor						wgs/plugins/plg_wgs_blueprint_editor
	plg_wgs_core									wgs/plugins/plg_wgs_core
	plg_wgs_developer								wgs/plugins/plg_wgs_developer
	plg_wgs_excel									wgs/plugins/plg_wgs_excel
	plg_wgs_multi_edit								wgs/plugins/plg_wgs_multi_edit
	plg_wgs_editor_common							wgs/plugins/plg_wgs_editor_common
	plg_wgs_particle_editor_app						wgs/plugins/plg_wgs_particle_editor_app
	plg_wgs_particle_editor							wgs/plugins/plg_wgs_particle_editor
	plg_wgs_unified_editor_app						wgs/plugins/plg_wgs_unified_editor_app
	plg_wgs_version_control							wgs/plugins/plg_wgs_version_control
	plg_wgs_window									wgs/plugins/plg_wgs_window
	plg_wgs_material_editor							wgs/plugins/plg_wgs_material_editor
	plg_wgs_model_viewer							wgs/plugins/plg_wgs_model_viewer
	plg_wgs_object_editor							wgs/plugins/plg_wgs_object_editor
	plg_wgs_streaming_editor						wgs/plugins/plg_wgs_streaming_editor
	plg_wgs_action_choreographer_editor				wgs/plugins/plg_wgs_action_choreographer_editor
)
