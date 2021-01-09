prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 125200
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>24762787089631659109
,p_default_application_id=>125200
,p_default_id_offset=>24780283239974408955
,p_default_owner=>'WKSP_TELEGRAMBOT'
);
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(24800408679020463704)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(24800326667201463621)
,p_default_dialog_template=>wwv_flow_api.id(24800311660345463610)
,p_error_template=>wwv_flow_api.id(24800313108692463611)
,p_printer_friendly_template=>wwv_flow_api.id(24800326667201463621)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(24800313108692463611)
,p_default_button_template=>wwv_flow_api.id(24800406471566463695)
,p_default_region_template=>wwv_flow_api.id(24800354379024463646)
,p_default_chart_template=>wwv_flow_api.id(24800354379024463646)
,p_default_form_template=>wwv_flow_api.id(24800354379024463646)
,p_default_reportr_template=>wwv_flow_api.id(24800354379024463646)
,p_default_tabform_template=>wwv_flow_api.id(24800354379024463646)
,p_default_wizard_template=>wwv_flow_api.id(24800354379024463646)
,p_default_menur_template=>wwv_flow_api.id(24800363792117463652)
,p_default_listr_template=>wwv_flow_api.id(24800354379024463646)
,p_default_irr_template=>wwv_flow_api.id(24800353283083463645)
,p_default_report_template=>wwv_flow_api.id(24800376814886463664)
,p_default_label_template=>wwv_flow_api.id(24800405937952463693)
,p_default_menu_template=>wwv_flow_api.id(24800407210516463696)
,p_default_calendar_template=>wwv_flow_api.id(24800407391832463696)
,p_default_list_template=>wwv_flow_api.id(24800404006315463690)
,p_default_nav_list_template=>wwv_flow_api.id(24800396027013463683)
,p_default_top_nav_list_temp=>wwv_flow_api.id(24800396027013463683)
,p_default_side_nav_list_temp=>wwv_flow_api.id(24800395695254463682)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(24800333822007463630)
,p_default_dialogr_template=>wwv_flow_api.id(24800332819128463629)
,p_default_option_label=>wwv_flow_api.id(24800405937952463693)
,p_default_required_label=>wwv_flow_api.id(24800406255748463693)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(24800397071115463684)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.4/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_api.component_end;
end;
/
