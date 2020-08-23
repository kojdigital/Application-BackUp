set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.3.00.05'
,p_default_workspace_id=>5369753188045157
,p_default_application_id=>2019
,p_default_owner=>'TSPRDDB'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/mit_apex_plugin_ext_execute_plsql_code
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(577019119151621083)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'MIT.APEX.PLUGIN.EXT_EXECUTE_PLSQL_CODE'
,p_display_name=>'Execute PL/SQL Code - Extended'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION execute_custom_plsql (p_dynamic_action IN apex_plugin.t_dynamic_action, p_plugin IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_dynamic_action_render_result',
'IS',
'  l_result                  apex_plugin.t_dynamic_action_render_result;',
'  l_items_to_submit         p_dynamic_action.attribute_01%TYPE := p_dynamic_action.attribute_02;',
'  l_items_to_return         p_dynamic_action.attribute_01%TYPE := p_dynamic_action.attribute_03;',
'  l_suppress_change_event   p_dynamic_action.attribute_01%TYPE := p_dynamic_action.attribute_04;',
'BEGIN',
'  apex_javascript.add_library (p_name => ''mit_apex_execute_plsql_extended#MIN#'', p_directory => p_plugin.file_prefix, p_version => NULL);',
'',
'  IF l_items_to_submit IS NOT NULL',
'  THEN',
'    l_items_to_submit   := ''#'' || REPLACE (l_items_to_submit, '','', '',#'');',
'  END IF;',
'',
'  IF l_items_to_return IS NOT NULL',
'  THEN',
'    l_items_to_return   := ''#'' || REPLACE (l_items_to_return, '','', '',#'');',
'  END IF;',
'',
'  l_result.javascript_function   := ''mit_exec_plsql_ext'';',
'  l_result.ajax_identifier       := apex_plugin.get_ajax_identifier;',
'  l_result.attribute_01          := l_items_to_submit;',
'  l_result.attribute_02          := l_items_to_return;',
'  l_result.attribute_03          := l_suppress_change_event;',
'  RETURN l_result;',
'END execute_custom_plsql;',
'',
'FUNCTION ajax_execute_custom_plsql (p_dynamic_action IN apex_plugin.t_dynamic_action, p_plugin IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_dynamic_action_ajax_result',
'IS',
'  l_plsql             p_dynamic_action.attribute_01%TYPE := p_dynamic_action.attribute_01;',
'  l_items_to_return   p_dynamic_action.attribute_01%TYPE := p_dynamic_action.attribute_03;',
'',
'  l_items_table       apex_application_global.vc_arr2;',
'  l_response          VARCHAR2 (32000);',
'  l_return            apex_plugin.t_dynamic_action_ajax_result;',
'BEGIN',
'  BEGIN',
'    apex_plugin_util.execute_plsql_code (l_plsql);',
'',
'    l_items_table   := apex_util.string_to_table (l_items_to_return, '','');',
'',
'    -- Write header for the JSON stream.',
'    apex_plugin_util.print_json_http_header;',
'',
'    -- initialize the JSON structure',
'    l_response      := ''{"item":['';',
'',
'    -- loop through the value array',
'    FOR i IN 1 .. l_items_table.COUNT',
'    LOOP',
'      -- add array entry',
'      l_response   :=',
'           l_response',
'        || CASE WHEN i > 1 THEN '','' END',
'        || ''{''',
'        || apex_javascript.add_attribute (''id'',',
'                                          sys.HTF.escape_sc (l_items_table (i)),',
'                                          FALSE,',
'                                          TRUE)',
'        || apex_javascript.add_attribute (''value'',',
'                                          sys.HTF.escape_sc (v (l_items_table (i))),',
'                                          FALSE,',
'                                          FALSE)',
'        || ''}'';',
'    END LOOP;',
'',
'    -- close the JSON structure',
'    l_response      := l_response || '']}'';',
'    HTP.p (l_response);',
'  EXCEPTION',
'    WHEN OTHERS',
'    THEN',
'      HTP.p (   ''{''',
'             || apex_javascript.add_attribute (''error'',',
'                                               sys.HTF.escape_sc (SQLERRM),',
'                                               FALSE,',
'                                               FALSE)',
'             || ''}'');',
'  END;',
'',
'  RETURN l_return;',
'END ajax_execute_custom_plsql;'))
,p_api_version=>1
,p_render_function=>'execute_custom_plsql'
,p_ajax_function=>'ajax_execute_custom_plsql'
,p_standard_attributes=>'STOP_EXECUTION_ON_ERROR:WAIT_FOR_RESULT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div>',
'	&quot;Execute PL/SQL Code - Extended&quot; plugin offers standard capabilities of the APEX &quot;native&quot; plugin &quot;Execute PL/SQL Code&quot;:</div>',
'<div>',
'	&nbsp;- PL/SQL Code</div>',
'<div>',
'	&nbsp;- Page Items to Submit</div>',
'<div>',
'	&nbsp;- Page Items to Return</div>',
'<div>',
'	&nbsp;- Suppress Change Event</div>',
'<div>',
'	with additional capability of utilization apex_application parameters x01 - x10 and the arrays f01 - f20.</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	Parameters x01 - x10 are passed to the plugin via html attribute of the triggering element &quot;data-params&quot;.</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	example:</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	&lt;a href=&quot;#&quot; id=&quot;my_id&quot; data-params=&quot;x01:Val1,x02:Val2,...,x10:Val10&quot;&gt;my_trigger&lt;/a&gt;</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	Arrays f01 - f20 are automatically passed to the server conditionally (only if elements with html attribute name=&quot;fnn&quot; are actually rendered on page).</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	Parameters x01 - x10 and the arrays f01 - f20 are ready to use in &quot;PL/SQL Code&quot; block of the plugin as apex_application.g_xnn and apex_application.g_fnn.</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	example:</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	begin</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	&nbsp; htp.p (apex_application.g_x01);</div>',
'<div>',
'	&nbsp;</div>',
'<div>',
'	&nbsp; for i in 1 .. apex_application.g_f01.count</div>',
'<div>',
'	&nbsp; loop</div>',
'<div>',
'	&nbsp; &nbsp; htp.p (apex_application.g_f01 (i));</div>',
'<div>',
'	&nbsp; end loop;</div>',
'<div>',
'	&nbsp;&nbsp;</div>',
'<div>',
'	end; &nbsp;</div>',
''))
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(577022007826763069)
,p_plugin_id=>wwv_flow_api.id(577019119151621083)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'PL/SQL Code'
,p_attribute_type=>'PLSQL'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Specify an execution only PL/SQL anonymous block, that will be executed on the server.',
'',
'You can reference other page or application items from within your application here using bind syntax (for example :P1_MY_ITEM), but if you do you will need to include them in the ''Page Items to Submit'' attribute also.',
'',
'For example:',
'',
'begin',
'  ',
'  setCommission(:P1_SAL,:P1_JOB);',
'',
'end;',
'',
'In this example, you would also need to include P1_SAL,P1_JOB in the ''Page Items to Submit'' attribute.',
'',
'Optional to use apex_application x01 - x10 parameters and f01 - f20 arrays',
'',
'example:',
'',
'begin',
'',
'  htp.p (apex_application.g_x01);',
'',
'  for i in 1 .. apex_application.g_f01.count',
'  loop',
'    htp.p (apex_application.g_f01 (i));',
'  end loop;',
'',
'end;',
'',
'x01 - x10 parameters must bi passed as html attribute of the triggering element "data-params".',
'',
'example:',
'',
'<a href="#" id="my_id" data-params="x01:Val1,x02:Val2,...,x10:Val10">my_trigger</a>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(577022304159764830)
,p_plugin_id=>wwv_flow_api.id(577019119151621083)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Page Items to Submit'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Specify a comma separated list of page items that will be submitted to the server and thus, available for use from within your ''PL/SQL Code''.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(577022900709766390)
,p_plugin_id=>wwv_flow_api.id(577019119151621083)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Page Items to Return'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Specify a comma separated list of page items that will be set on the page when the call to the server returns, based on their current value in session state.',
'',
'This could be useful if you had set 1 or more page item''s values in session state from within your ''PL/SQL Code'', using:',
'',
'    apex_util.set_session_state(''P1_MY_ITEM'', ''New Value'');',
'In this example, you would need to define ''P1_MY_ITEM'' in this property in order for ''New Value'' to be displayed in that item on your page.',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(577156913949008460)
,p_plugin_id=>wwv_flow_api.id(577019119151621083)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Suppress Change Event'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(577022900709766390)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_NULL'
,p_help_text=>'Set Suppress Change Event to Yes, in the case where you want to prevent subsequent ''Change'' based Dynamic Actions from firing, for the ''Page Items to Return''.'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E206D69745F657865635F706C73716C5F6578742829207B0D0A2020202076617220506C7567696E203D20746869732C0D0A20202020202020206C506167654974656D73546F5375626D6974203D20506C7567696E2E616374696F6E2E';
wwv_flow_api.g_varchar2_table(2) := '61747472696275746530312C0D0A20202020202020206C506167654974656D73546F52657475726E203D20506C7567696E2E616374696F6E2E61747472696275746530322C0D0A20202020202020206C53757070726573734368616E67654576656E7420';
wwv_flow_api.g_varchar2_table(3) := '3D2028506C7567696E2E616374696F6E2E6174747269627574653033203D3D3D20225922292C0D0A20202020202020206C6461746141747472203D202428746869732E74726967676572696E67456C656D656E74292E617474722827646174612D706172';
wwv_flow_api.g_varchar2_table(4) := '616D7327292C0D0A20202020202020206C446174614A534F4E203D207B7D2C6C417272203D5B5D2C206C4172724E616D65203D2027273B0D0A202020200D0A20202020666F72202869203D20313B2069203C2032313B20692B2B29207B200D0A20202020';
wwv_flow_api.g_varchar2_table(5) := '202020206C417272203D5B5D3B0D0A20202020202020206C4172724E616D65203D202766272B2822303022202B2069292E736C696365282D32293B0D0A2020202020202020696620282428275B6E616D653D22272B6C4172724E616D652B27225D27292E';
wwv_flow_api.g_varchar2_table(6) := '6C656E677468203E203029207B0D0A0D0A2020202020202020202020202428275B6E616D653D22272B6C4172724E616D652B27225D27292E656163682866756E6374696F6E28297B0D0A202020202020202020202020202020206C4172722E7075736828';
wwv_flow_api.g_varchar2_table(7) := '2722272B242874686973292E76616C28292B272227290D0A2020202020202020202020207D293B0D0A202020202020202020202020242E657874656E64286C446174614A534F4E2C20242E70617273654A534F4E28277B22272B6C4172724E616D652B27';
wwv_flow_api.g_varchar2_table(8) := '223A5B272B6C4172722B275D7D2729293B0D0A20202020202020207D0D0A202020207D0D0A202020200D0A20202020696620286C646174614174747220213D20756E646566696E656429207B0D0A20202020202020207472797B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(9) := '20202020242E657874656E64286C446174614A534F4E2C20242E70617273654A534F4E28277B2227202B206C64617461417474722E7265706C616365282F3A2F672C27223A2227292E7265706C616365282F2C2F672C2027222C222729202B2027227D27';
wwv_flow_api.g_varchar2_table(10) := '29293B202020200D0A20202020202020207D0D0A202020202020202063617463682865727229207B0D0A202020202020202020202020616C657274282754726967676572696E6720456C656D656E74206174747269627574652028646174612D70617261';
wwv_flow_api.g_varchar2_table(11) := '6D733D2227202B206C6461746141747472202B2027222920696E2062616420666F726D61742E204578616D706C652028646174612D706172616D733D227830313A56616C312C2E2E2E2C7831303A56616C33222927293B0D0A20202020202020207D0D0A';
wwv_flow_api.g_varchar2_table(12) := '202020207D0D0A20202020696620286C506167654974656D73546F5375626D697420213D20272729207B0D0A2020202020202020242E657874656E64286C446174614A534F4E2C20242E70617273654A534F4E28277B22706167654974656D73223A2227';
wwv_flow_api.g_varchar2_table(13) := '202B206C506167654974656D73546F5375626D6974202B2027227D2729293B0D0A202020207D0D0A0D0A2020202066756E6374696F6E205F636C6561722829207B0D0A202020202020202024286C506167654974656D73546F52657475726E2C20617065';
wwv_flow_api.g_varchar2_table(14) := '782E6750616765436F6E7465787424292E656163682866756E6374696F6E2829207B0D0A202020202020202020202020247328746869732C2022222C206E756C6C2C2074727565293B0D0A20202020202020207D293B0D0A202020207D0D0A0D0A202020';
wwv_flow_api.g_varchar2_table(15) := '2066756E6374696F6E205F7375636365737328704461746129207B0D0A2020202020202020766172206C4974656D436F756E742C206C4974656D41727261793B0D0A0D0A202020202020202069662028704461746120213D3D206E756C6C29207B0D0A20';
wwv_flow_api.g_varchar2_table(16) := '20202020202020202020206C4974656D436F756E74203D2070446174612E6974656D2E6C656E6774683B0D0A2020202020202020202020206C4974656D4172726179203D2070446174612E6974656D3B0D0A202020202020202020202020666F72202876';
wwv_flow_api.g_varchar2_table(17) := '6172206C4974656D4974657261746F72203D20303B206C4974656D4974657261746F72203C206C4974656D436F756E743B206C4974656D4974657261746F722B2B29207B0D0A202020202020202020202020202020202473286C4974656D41727261795B';
wwv_flow_api.g_varchar2_table(18) := '6C4974656D4974657261746F725D2E69642C206C4974656D41727261795B6C4974656D4974657261746F725D2E76616C75652C206E756C6C2C206C53757070726573734368616E67654576656E74293B0D0A2020202020202020202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(19) := '20202020207D0D0A0D0A2020202020202020617065782E64612E726573756D6528506C7567696E2E726573756D6543616C6C6261636B2C2066616C7365293B0D0A202020207D0D0A0D0A2020202066756E6374696F6E205F6572726F722820706A715848';
wwv_flow_api.g_varchar2_table(20) := '522C2070546578745374617475732C20704572726F725468726F776E2029207B0D0A2020202020202020617065782E64612E68616E646C65416A61784572726F72732820706A715848522C2070546578745374617475732C20704572726F725468726F77';
wwv_flow_api.g_varchar2_table(21) := '6E2C20506C7567696E2E726573756D6543616C6C6261636B293B0D0A202020207D0D0A0D0A20202020617065782E7365727665722E706C7567696E28506C7567696E2E616374696F6E2E616A61784964656E7469666965722C0D0A20202020202020206C';
wwv_flow_api.g_varchar2_table(22) := '446174614A534F4E2C207B0D0A202020202020202020202020636C6561723A205F636C6561722C0D0A202020202020202020202020737563636573733A205F737563636573732C0D0A2020202020202020202020206572726F723A205F6572726F722C0D';
wwv_flow_api.g_varchar2_table(23) := '0A2020202020202020202020206173796E633A2021506C7567696E2E616374696F6E2E77616974466F72526573756C740D0A20202020202020207D0D0A20202020293B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(579945726356051200)
,p_plugin_id=>wwv_flow_api.id(577019119151621083)
,p_file_name=>'mit_apex_execute_plsql_extended.js'
,p_mime_type=>'application/javascript'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E206D69745F657865635F706C73716C5F65787428297B76617220506C7567696E3D746869732C6C506167654974656D73546F5375626D69743D506C7567696E2E616374696F6E2E61747472696275746530312C6C506167654974656D';
wwv_flow_api.g_varchar2_table(2) := '73546F52657475726E3D506C7567696E2E616374696F6E2E61747472696275746530322C6C53757070726573734368616E67654576656E743D28506C7567696E2E616374696F6E2E61747472696275746530333D3D3D225922292C6C6461746141747472';
wwv_flow_api.g_varchar2_table(3) := '3D2428746869732E74726967676572696E67456C656D656E74292E617474722827646174612D706172616D7327292C6C446174614A534F4E3D7B7D2C6C4172723D5B5D2C6C4172724E616D653D27273B666F7228693D313B693C32313B692B2B297B6C41';
wwv_flow_api.g_varchar2_table(4) := '72723D5B5D3B6C4172724E616D653D2766272B28223030222B69292E736C696365282D32293B6966282428275B6E616D653D22272B6C4172724E616D652B27225D27292E6C656E6774683E30297B2428275B6E616D653D22272B6C4172724E616D652B27';
wwv_flow_api.g_varchar2_table(5) := '225D27292E656163682866756E6374696F6E28297B6C4172722E70757368282722272B242874686973292E76616C28292B272227297D293B242E657874656E64286C446174614A534F4E2C242E70617273654A534F4E28277B22272B6C4172724E616D65';
wwv_flow_api.g_varchar2_table(6) := '2B27223A5B272B6C4172722B275D7D2729297D7D6966286C6461746141747472213D756E646566696E6564297B7472797B242E657874656E64286C446174614A534F4E2C242E70617273654A534F4E28277B22272B6C64617461417474722E7265706C61';
wwv_flow_api.g_varchar2_table(7) := '6365282F3A2F672C27223A2227292E7265706C616365282F2C2F672C27222C2227292B27227D2729297D636174636828657272297B616C657274282754726967676572696E6720456C656D656E74206174747269627574652028646174612D706172616D';
wwv_flow_api.g_varchar2_table(8) := '733D22272B6C64617461417474722B27222920696E2062616420666F726D61742E204578616D706C652028646174612D706172616D733D227830313A56616C312C2E2E2E2C7831303A56616C33222927297D7D6966286C506167654974656D73546F5375';
wwv_flow_api.g_varchar2_table(9) := '626D6974213D2727297B242E657874656E64286C446174614A534F4E2C242E70617273654A534F4E28277B22706167654974656D73223A22272B6C506167654974656D73546F5375626D69742B27227D2729297D66756E6374696F6E205F636C65617228';
wwv_flow_api.g_varchar2_table(10) := '297B24286C506167654974656D73546F52657475726E2C617065782E6750616765436F6E7465787424292E656163682866756E6374696F6E28297B247328746869732C22222C6E756C6C2C74727565297D297D66756E6374696F6E205F73756363657373';
wwv_flow_api.g_varchar2_table(11) := '287044617461297B766172206C4974656D436F756E742C6C4974656D41727261793B6966287044617461213D3D6E756C6C297B6C4974656D436F756E743D70446174612E6974656D2E6C656E6774683B6C4974656D41727261793D70446174612E697465';
wwv_flow_api.g_varchar2_table(12) := '6D3B666F7228766172206C4974656D4974657261746F723D303B6C4974656D4974657261746F723C6C4974656D436F756E743B6C4974656D4974657261746F722B2B297B2473286C4974656D41727261795B6C4974656D4974657261746F725D2E69642C';
wwv_flow_api.g_varchar2_table(13) := '6C4974656D41727261795B6C4974656D4974657261746F725D2E76616C75652C6E756C6C2C6C53757070726573734368616E67654576656E74297D7D617065782E64612E726573756D6528506C7567696E2E726573756D6543616C6C6261636B2C66616C';
wwv_flow_api.g_varchar2_table(14) := '7365297D66756E6374696F6E205F6572726F7228706A715848522C70546578745374617475732C704572726F725468726F776E297B617065782E64612E68616E646C65416A61784572726F727328706A715848522C70546578745374617475732C704572';
wwv_flow_api.g_varchar2_table(15) := '726F725468726F776E2C506C7567696E2E726573756D6543616C6C6261636B297D617065782E7365727665722E706C7567696E28506C7567696E2E616374696F6E2E616A61784964656E7469666965722C6C446174614A534F4E2C7B636C6561723A5F63';
wwv_flow_api.g_varchar2_table(16) := '6C6561722C737563636573733A5F737563636573732C6572726F723A5F6572726F722C6173796E633A21506C7567696E2E616374696F6E2E77616974466F72526573756C747D297D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(579946304015051848)
,p_plugin_id=>wwv_flow_api.id(577019119151621083)
,p_file_name=>'mit_apex_execute_plsql_extended.min.js'
,p_mime_type=>'application/javascript'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
