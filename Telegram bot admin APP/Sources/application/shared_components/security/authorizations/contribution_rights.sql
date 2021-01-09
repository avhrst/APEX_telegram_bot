prompt --application/shared_components/security/authorizations/contribution_rights
begin
--   Manifest
--     SECURITY SCHEME: Contribution Rights
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>24762787089631659109
,p_default_application_id=>125200
,p_default_id_offset=>24780283239974408955
,p_default_owner=>'WKSP_TELEGRAMBOT'
);
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(24800477409283492121)
,p_name=>'Contribution Rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if apex_acl.has_user_role (',
'  p_application_id=>:APP_ID, ',
'  p_user_name => :APP_USER, ',
'  p_role_static_id => ''ADMINISTRATOR'') or',
'  apex_acl.has_user_role (',
'    p_application_id=>:APP_ID,',
'    p_user_name=> :APP_USER,',
'    p_role_static_id=> ''CONTRIBUTOR'') then',
'    return true;',
'else',
'    return false;',
'end if;'))
,p_error_message=>'Insufficient privileges, user is not a Contributor'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_api.component_end;
end;
/
