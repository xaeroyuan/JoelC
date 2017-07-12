
SET( CMAKE_MODULE_PATH
	${CMAKE_CURRENT_LIST_DIR}
	${CMAKE_MODULE_PATH}
)

INCLUDE_DIRECTORIES( ${WG_TOOLS_SOURCE_DIR}/core )
INCLUDE_DIRECTORIES( ${WG_TOOLS_SOURCE_DIR}/core/lib )

LIST( APPEND BW_LIBRARY_PROJECTS
	#WG Systems
	wg_types			core/lib/wg_types
	wg_memory			core/lib/wg_memory
	wg_pyscript			core/lib/wg_pyscript

	#NGT Systems
	core_common		        core/lib/core_common
	core_wgtf_app	        core/lib/core_wgtf_app
	core_variant		    core/lib/core_variant
	core_dependency_system	core/lib/core_dependency_system
	core_environment_system	core/lib/core_environment_system
	core_viewport			core/lib/core_viewport
	core_command_system		core/lib/core_command_system
	core_reflection_utils	core/lib/core_reflection_utils
	core_serialization		core/lib/core_serialization
	core_serialization_xml	core/lib/core_serialization_xml
	core_reflection			core/lib/core_reflection
	core_string_utils		core/lib/core_string_utils
	core_object				core/lib/core_object

	#Tools Common
	core_logging				core/lib/core_logging
	core_logging_system		    core/lib/core_logging_system
	core_generic_plugin		    core/lib/core_generic_plugin
	core_generic_plugin_manager	core/lib/core_generic_plugin_manager
	core_qt_common			    core/lib/core_qt_common
	core_data_model			    core/lib/core_data_model
	core_data_model_cmds		core/lib/core_data_model_cmds
	core_view_model				core/lib/core_view_model
	core_ui_framework		    core/lib/core_ui_framework
	core_python27				core/lib/core_python27
	core_base_editor			core/lib/core_base_editor
	qt_sharable					core/lib/qt_sharable

	# Interfaces
	common_include				core/interfaces/common_include
	core_python_script			core/interfaces/core_python_script
	core_script					core/interfaces/core_script
	core_splash					core/interfaces/core_splash
	version_control				core/interfaces/version_control
)

IF( WG_TOOLS_CORE_BINARY_PROJECTS )
	LIST( APPEND BW_BINARY_PROJECTS
		# Apps
		generic_app			core/app/generic_app
		qt_desktop			core/app/qt_desktop
	)

	IF ( BW_PLATFORM STREQUAL "win64" )
		LIST( APPEND BW_BINARY_PROJECTS
			maya_plugin		    core/app/maya_plugin
		)

		LIST( APPEND BW_PLUGIN_PROJECTS
			plg_maya_adapter    core/plugins/plg_maya_adapter
		)
	ENDIF()
ENDIF()

LIST( APPEND BW_PLUGIN_PROJECTS
	# Plugins
	plg_automation				core/plugins/plg_automation
	plg_reflection				core/plugins/plg_reflection
	plg_command_system			core/plugins/plg_command_system
	plg_environment_system		core/plugins/plg_environment_system
	plg_editor_interaction		core/plugins/plg_editor_interaction
	plg_history_ui				core/plugins/plg_history_ui
	plg_macros_ui				core/plugins/plg_macros_ui
	plg_qt_common				core/plugins/plg_qt_common
	plg_serialization			core/plugins/plg_serialization
	plg_logging_system			core/plugins/plg_logging_system
	plg_idedebug_logger			core/plugins/plg_idedebug_logger
	plg_alert_ui				core/plugins/plg_alert_ui
	plg_file_system				core/plugins/plg_file_system
	plg_perforce				core/plugins/plg_perforce
	plg_panel_manager			core/plugins/plg_panel_manager
	plg_progress_manager		core/plugins/plg_progress_manager
	plg_python27				core/plugins/plg_python27
	plg_curve_editor			core/plugins/plg_curve_editor
	plg_node_editor				core/plugins/plg_node_editor
	plg_qml_preferences			core/plugins/plg_qml_preferences
	plg_toolbox					core/plugins/plg_toolbox
	plg_grabber_manager			core/plugins/plg_grabber_manager
)
