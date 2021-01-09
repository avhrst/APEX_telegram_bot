prompt --application/pages/page_00005
begin
--   Manifest
--     PAGE: 00005
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
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(24800428306937463723)
,p_name=>'Bot User'
,p_page_mode=>'MODAL'
,p_step_title=>'Bot User'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20200229084612'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24800474337640492118)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(24800363792117463652)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(24800307759494463597)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(24800407210516463696)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24803204065577423397)
,p_plug_name=>'Bot User'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(24800332819128463629)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'BOT_USERS'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24803204750673423397)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(24800333822007463630)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24800472625774492116)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(24803204750673423397)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24800406471566463695)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24800473054022492116)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(24803204750673423397)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple'
,p_button_template_id=>wwv_flow_api.id(24800406471566463695)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P5_CHAT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24800473427760492117)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(24803204750673423397)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24800406471566463695)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_CHAT_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(24800473808347492117)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(24803204750673423397)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24800406471566463695)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_CHAT_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800469113572492112)
,p_name=>'P5_CHAT_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Chat ID'
,p_source=>'CHAT_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800406255748463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800469500502492113)
,p_name=>'P5_FIRST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'First Name'
,p_source=>'FIRST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800469989703492114)
,p_name=>'P5_LAST_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Last Name'
,p_source=>'LAST_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800470311986492114)
,p_name=>'P5_PHONE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Phone'
,p_source=>'PHONE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800470748922492114)
,p_name=>'P5_CRT'
,p_source_data_type=>'DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Crt'
,p_source=>'CRT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800471110871492115)
,p_name=>'P5_LOGIN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Login'
,p_source=>'LOGIN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800471553204492115)
,p_name=>'P5_MDF'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Mdf'
,p_source=>'MDF'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24800471948640492115)
,p_name=>'P5_PIN'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_item_source_plug_id=>wwv_flow_api.id(24803204065577423397)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Pin'
,p_source=>'PIN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24800405937952463693)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(24800476577694492120)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(24800472625774492116)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24800477052166492120)
,p_event_id=>wwv_flow_api.id(24800476577694492120)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24800474995196492119)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(24803204065577423397)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from BOT_USERS'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24800475350383492119)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(24803204065577423397)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process Row of BOT_USERS'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24800475719910492119)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(24800473054022492116)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(24800476147490492120)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.component_end;
end;
/
