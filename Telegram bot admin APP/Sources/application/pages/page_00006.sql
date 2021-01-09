prompt --application/pages/page_00006
begin
--   Manifest
--     PAGE: 00006
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>24762787089631659109
,p_default_application_id=>125200
,p_default_id_offset=>24780283239974408955
,p_default_owner=>'WKSP_TELEGRAMBOT'
);
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(24800428306937463723)
,p_name=>'Bot settings'
,p_step_title=>'Bot settings'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20180619093416'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24806142925345641144)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(24800363792117463652)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(24800307759494463597)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(24800407210516463696)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24811042421641043229)
,p_plug_name=>'Global parametrs'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(24800354379024463646)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24800483075410496196)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(24811042421641043229)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_api.id(24800406471566463695)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save settings'
,p_button_position=>'REGION_TEMPLATE_CREATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800247706292629008)
,p_name=>'P6_REST_URL'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(24811042421641043229)
,p_use_cache_before_default=>'NO'
,p_item_default=>'FHOST||''/telegram'''
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'REST URL'
,p_source=>'FREST_URL'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800483468750496196)
,p_name=>'P6_TOKEN'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(24811042421641043229)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Token'
,p_source=>'FTOKEN'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800483817303496197)
,p_name=>'P6_HOOK_URL'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(24811042421641043229)
,p_use_cache_before_default=>'NO'
,p_item_default=>'FHOST||''/telegram/webhook'''
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Webhook URL'
,p_source=>'FWEBHOOK_URL'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800484202791496197)
,p_name=>'P6_DEBUG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(24811042421641043229)
,p_item_default=>'0'
,p_prompt=>'Debug mode'
,p_source=>'FDEBUG'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'CUSTOM'
,p_attribute_02=>'1'
,p_attribute_03=>'On'
,p_attribute_04=>'0'
,p_attribute_05=>'Off'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24800485279678496198)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save settings'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_ex int;',
'r_ bot_setting%ROWTYPE;',
'',
'begin',
'',
'',
'select count(*) into v_ex from  bot_setting;',
'',
'',
'if v_ex =1 then',
'select * into r_ from bot_setting ;',
'end if;',
'',
'r_.token := :P6_TOKEN;',
'r_.webhook_url := :P6_HOOK_URL;',
'r_.debug := :P6_DEBUG;',
'r_.rest_url := :P6_REST_URL;',
'',
'if v_ex = 0 then',
'insert into bot_setting values r_;',
'else',
'update bot_setting set row = r_;',
'end if;',
'',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(24800483075410496196)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24800485688545496199)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set webhook'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'begin',
'telegram.setwebhook(:P6_HOOK_URL);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(24800483075410496196)
);
wwv_flow_api.component_end;
end;
/
