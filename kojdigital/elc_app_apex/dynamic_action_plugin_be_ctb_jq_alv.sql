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
prompt --application/shared_components/plugins/dynamic_action/be_ctb_jq_alv
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(564406701023238513)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'BE.CTB.JQ.ALV'
,p_display_name=>'Live Validation'
,p_category=>'COMPONENT'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render(p_dynamic_action in apex_plugin.t_dynamic_action',
'              , p_plugin         in apex_plugin.t_plugin)',
'return apex_plugin.t_dynamic_action_render_result is',
'  l_validation           varchar2(4000) := p_dynamic_action.attribute_01;',
'  l_item_type            varchar2(4000) := p_dynamic_action.attribute_02;',
'  l_items_to_validate    varchar2(4000) := p_dynamic_action.attribute_03;',
'  l_triggering_event     varchar2(4000) := p_dynamic_action.attribute_04;',
'  l_condition            varchar2(4000) := p_dynamic_action.attribute_05;',
'  l_equal                varchar2(4000) := p_dynamic_action.attribute_06;',
'  l_regex                varchar2(4000) := p_dynamic_action.attribute_07;',
'  l_minimum_item         varchar2(4000) := p_dynamic_action.attribute_08;',
'  l_maximum_item         varchar2(4000) := p_dynamic_action.attribute_09;',
'  l_minimum              varchar2(4000) := p_dynamic_action.attribute_10;',
'  l_maximum              varchar2(4000) := p_dynamic_action.attribute_11;',
'  l_forms_to_validate    varchar2(4000) := p_dynamic_action.attribute_12;',
'  l_form_submit_elements varchar2(4000) := p_dynamic_action.attribute_13;',
'  l_error_msg            varchar2(4000) := p_dynamic_action.attribute_14;',
'  l_error_msg_location   varchar2(4000) := p_dynamic_action.attribute_15;',
'',
'  l_date_format        varchar2(4000);',
'  l_numeric_characters varchar2(4000);',
'',
'  l_render_result      apex_plugin.t_dynamic_action_render_result;',
'begin',
'  apex_javascript.add_library(',
'    p_name      => ''jquery.alv'',',
'    p_directory => p_plugin.file_prefix,',
'    p_version   => null',
'  );',
'  apex_css.add_file(',
'    p_name      => ''style.alv'',',
'    p_directory => p_plugin.file_prefix,',
'    p_version   => null',
'  );',
'',
'  select value',
'  into l_date_format',
'  from nls_session_parameters',
'  where parameter = ''NLS_DATE_FORMAT'';',
'',
'  select value',
'  into l_numeric_characters',
'  from nls_session_parameters',
'  where parameter = ''NLS_NUMERIC_CHARACTERS'';',
'',
'  l_render_result.attribute_01 := l_validation;',
'  l_render_result.attribute_02 := apex_plugin_util.page_item_names_to_jquery(l_items_to_validate);',
'  l_render_result.attribute_03 := l_triggering_event;',
'  l_render_result.attribute_04 := l_condition;',
'  l_render_result.attribute_05 := l_forms_to_validate;',
'  l_render_result.attribute_06 := l_item_type;',
'  l_render_result.attribute_07 := l_form_submit_elements;',
'  if l_minimum_item is not null then',
'    l_minimum_item := apex_plugin_util.page_item_names_to_jquery(l_minimum_item);',
'  end if;',
'  if l_maximum_item is not null then',
'    l_maximum_item := apex_plugin_util.page_item_names_to_jquery(l_maximum_item);',
'  end if;',
'  l_render_result.attribute_10 := nvl(l_minimum_item, l_minimum);',
'  l_render_result.attribute_11 := nvl(l_maximum_item, l_maximum);',
'  l_render_result.attribute_12 := apex_plugin_util.page_item_names_to_jquery(l_equal);',
'  l_render_result.attribute_13 := l_regex;',
'  l_render_result.attribute_14 := l_error_msg;',
'  l_render_result.attribute_15 := l_error_msg_location;',
'',
'  l_render_result.javascript_function := ''',
'    function() {',
'      var render = this;',
'      var action = render.action;',
'      var l_allowWhitespace = true;',
'',
'      if (!action.attribute14) { action.attribute14 = ""; }',
'',
'      if (action.attribute01 !== "form") {',
'        // item validation',
'        if (action.attribute01 === "notBlank") {',
'          action.attribute01 = "notEmpty";',
'          l_allowWhitespace = false;',
'        }',
'        if (!action.attribute04) { action.attribute04 = ""; }',
'        if (!action.attribute10) { action.attribute10 = ""; }',
'        if (!action.attribute11) { action.attribute11 = ""; }',
'',
'        $(action.attribute02).alv({',
'          validate: action.attribute01,',
'          triggeringEvent: action.attribute03,',
'          condition: action.attribute04,',
'          errorMsg: action.attribute14,',
'          errorMsgLocation: action.attribute15,',
'          allowWhitespace: l_allowWhitespace,',
'          itemType: action.attribute06,',
'          dateFormat: "'' || l_date_format || ''",',
'          numericCharacters: "'' || l_numeric_characters || ''",',
'          min: action.attribute10,',
'          max: action.attribute11,',
'          equal: action.attribute12,',
'          regex: action.attribute13',
'        });',
'      } else {',
'        // form validation',
'        $(action.attribute07).alv("validateForm", {',
'          formsToSubmit: action.attribute05,',
'          errorMsg: action.attribute14',
'        });',
'      }',
'    }',
'  '';',
'',
'  return l_render_result;',
'end render;'))
,p_api_version=>1
,p_render_function=>'render'
,p_standard_attributes=>'STOP_EXECUTION_ON_ERROR'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.5'
,p_about_url=>'http://apex.oracle.com/pls/apex/f?p=59381:1'
,p_files_version=>7
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564414810636260200)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Validation'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'notEmpty'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select the type of validation you want to perform.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564427086525262726)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>10
,p_display_value=>'Required'
,p_return_value=>'notEmpty'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564431394144264879)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>20
,p_display_value=>'Required (Trim Whitespace)'
,p_return_value=>'notBlank'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564435700377266810)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>30
,p_display_value=>'Item Type'
,p_return_value=>'itemType'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564440004879268061)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>40
,p_display_value=>'Equality'
,p_return_value=>'equal'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564444309035269201)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>50
,p_display_value=>'Match Regex'
,p_return_value=>'regex'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564448613883270622)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>60
,p_display_value=>'Character Length'
,p_return_value=>'charLength'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564485387480281946)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>70
,p_display_value=>'Number Size'
,p_return_value=>'numberSize'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564489702025286131)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>80
,p_display_value=>'Date Order'
,p_return_value=>'dateOrder'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564494005488287104)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>90
,p_display_value=>'Checkboxes'
,p_return_value=>'totalChecked'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564498312068289035)
,p_plugin_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_display_sequence=>100
,p_display_value=>'Form'
,p_return_value=>'form'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564510509129326052)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Item Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'number'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'itemType'
,p_lov_type=>'STATIC'
,p_help_text=>'Define what kind of item type validation should be applied.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564514913284327250)
,p_plugin_attribute_id=>wwv_flow_api.id(564510509129326052)
,p_display_sequence=>10
,p_display_value=>'Number'
,p_return_value=>'number'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564519183633328187)
,p_plugin_attribute_id=>wwv_flow_api.id(564510509129326052)
,p_display_sequence=>20
,p_display_value=>'Only Digits'
,p_return_value=>'digit'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564523486403328909)
,p_plugin_attribute_id=>wwv_flow_api.id(564510509129326052)
,p_display_sequence=>30
,p_display_value=>'Alphanumeric'
,p_return_value=>'alphanumeric'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564527788481329608)
,p_plugin_attribute_id=>wwv_flow_api.id(564510509129326052)
,p_display_sequence=>40
,p_display_value=>'Date'
,p_return_value=>'date'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564532091252330345)
,p_plugin_attribute_id=>wwv_flow_api.id(564510509129326052)
,p_display_sequence=>50
,p_display_value=>'E-mail'
,p_return_value=>'email'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564536393676331049)
,p_plugin_attribute_id=>wwv_flow_api.id(564510509129326052)
,p_display_sequence=>60
,p_display_value=>'URL'
,p_return_value=>'url'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564548595192340910)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Page Item(s)'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_IN_LIST'
,p_depending_on_expression=>'form'
,p_help_text=>'The page item(s) for which you want the above validation to apply. Separate multiple page items with a comma.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564556890821349161)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Triggering Event'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'blur'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_IN_LIST'
,p_depending_on_expression=>'form'
,p_lov_type=>'STATIC'
,p_help_text=>'Specify the JavaScript event that will cause the validation to fire.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564561294284350141)
,p_plugin_attribute_id=>wwv_flow_api.id(564556890821349161)
,p_display_sequence=>10
,p_display_value=>'Blur'
,p_return_value=>'blur'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564565598786351474)
,p_plugin_attribute_id=>wwv_flow_api.id(564556890821349161)
,p_display_sequence=>20
,p_display_value=>'FocusOut'
,p_return_value=>'focusout'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564569904673353143)
,p_plugin_attribute_id=>wwv_flow_api.id(564556890821349161)
,p_display_sequence=>30
,p_display_value=>'Change'
,p_return_value=>'change'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564574207444353993)
,p_plugin_attribute_id=>wwv_flow_api.id(564556890821349161)
,p_display_sequence=>40
,p_display_value=>'KeyUp'
,p_return_value=>'keyup'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564586400995361556)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Condition'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_IN_LIST'
,p_depending_on_expression=>'form'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Optionally specify a JavaScript expression to support conditional execution of your validation. The validation will fire when the expression evaluates to true.',
'',
'For example: $(''#P5_COUNTRY'').val() === "Belgium"'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564594702989381038)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Must Equal'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'equal'
,p_help_text=>'Select the page item that you want the value to be equal to. Frequently used to validate that two password fields are equal.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564614694462388035)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Regex'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'regex'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This field allows specifying a regular expression that has to match the entered value.',
'',
'For example: #[A-Fa-f0-9]{6}'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564623015933394316)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Minimum Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'numberSize,dateOrder'
,p_help_text=>'The page item that contains the minimum value. Overrides the ''Minimum'' setting if filled in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564627401519399570)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Maximum Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'numberSize,dateOrder'
,p_help_text=>'The page item that contains the maximum value. Overrides the ''Maximum'' setting if filled in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564647408108477181)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Minimum'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>30
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'charLength,numberSize,dateOrder,totalChecked'
,p_help_text=>'A fixed minimum value. Gets overridden by the ''Minimum Item'' setting if filled in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564651802698485171)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Maximum'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>30
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'charLength,numberSize,dateOrder,totalChecked'
,p_help_text=>'A fixed maximum value. Gets overridden by the ''Maximum Item'' setting if filled in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564660092786491737)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Form(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'form'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A jQuery selector to determine the form region(s) you want to validate before the page is submitted. Use a comma to separate multiple elements.',
'',
'For example: #empForm,#deptForm'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564668413911497802)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Form Submit Element(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'form'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A jQuery ID selector to determine the buttons that submit the form. Use a comma to separate multiple elements.',
'',
'For example: #createBtn,#saveBtn'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564676696034502227)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Error Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_help_text=>'Specifying an error message overrides the default error message. Use &1, &2, &n for substitution values.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(564681113349507105)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_prompt=>'Error Message Location'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'after'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(564414810636260200)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_IN_LIST'
,p_depending_on_expression=>'form'
,p_lov_type=>'STATIC'
,p_help_text=>'You can choose to show the error message before or after the input item.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564685486815508963)
,p_plugin_attribute_id=>wwv_flow_api.id(564681113349507105)
,p_display_sequence=>10
,p_display_value=>'After Item'
,p_return_value=>'after'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(564689792702510697)
,p_plugin_attribute_id=>wwv_flow_api.id(564681113349507105)
,p_display_sequence=>20
,p_display_value=>'Before Item'
,p_return_value=>'before'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(560144958104688573)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_name=>'alvformfail'
,p_display_name=>'Form Failure'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(560140648061685682)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_name=>'alvformsuccess'
,p_display_name=>'Form Success'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(560136473903683692)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_name=>'alvitemfail'
,p_display_name=>'Item Failure'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(560132268016682030)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_name=>'alvitemsuccess'
,p_display_name=>'Item Success'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220616C763D7B7D3B616C762E7574696C3D7B7472696D3A66756E6374696F6E2861297B72657475726E20612E7265706C616365282F5E5C732B7C5C732B242F672C2222297D2C7265706C61636543686172496E537472696E673A66756E6374696F';
wwv_flow_api.g_varchar2_table(2) := '6E28612C622C63297B72657475726E20612E73756273747228302C62292B28632B2222292B612E73756273747228622B28632B2222292E6C656E677468297D2C676574506167654974656D56616C75653A66756E6374696F6E2861297B72657475726E22';
wwv_flow_api.g_varchar2_table(3) := '2350223D3D3D28612B2222292E737562737472696E6728302C32293F242861292E76616C28293A617D2C676574436F6E646974696F6E526573756C743A66756E6374696F6E287045787072657373696F6E297B7661722065787072657373696F6E526573';
wwv_flow_api.g_varchar2_table(4) := '756C743D21303B72657475726E207045787072657373696F6E2E6C656E67746826262865787072657373696F6E526573756C743D6576616C287045787072657373696F6E29292C65787072657373696F6E526573756C747D2C6765744E756D6265724672';
wwv_flow_api.g_varchar2_table(5) := '6F6D537472696E673A66756E6374696F6E2861297B72657475726E28612B2222292E6C656E6774683F4E756D6265722861293A22227D2C6765744461746546726F6D537472696E673A66756E6374696F6E2861297B76617220623D612E73706C69742822';
wwv_flow_api.g_varchar2_table(6) := '2F22292C633D7061727365496E7428625B325D292C643D7061727365496E7428625B315D2C3130292C653D7061727365496E7428625B305D2C3130293B72657475726E206E6577204461746528632C642D312C65297D2C636F6E76657274446174653A66';
wwv_flow_api.g_varchar2_table(7) := '756E6374696F6E28612C62297B76617220632C642C652C663D622E746F55707065724361736528292C673D662E7265706C616365282F5B412D5A5D2B2F672C2222292C683D612E7265706C616365282F5C642B2F672C2222293B72657475726E20612E6C';
wwv_flow_api.g_varchar2_table(8) := '656E6774683D3D3D622E6C656E6774682626683D3D3D67262628633D2D313D3D3D662E696E6465784F662822444422293F227878223A612E737562737472696E6728662E696E6465784F662822444422292C662E696E6465784F662822444422292B3229';
wwv_flow_api.g_varchar2_table(9) := '2C643D2D313D3D3D662E696E6465784F6628224D4D22293F227878223A612E737562737472696E6728662E696E6465784F6628224D4D22292C662E696E6465784F6628224D4D22292B32292C653D2D313D3D3D662E696E6465784F662822595959592229';
wwv_flow_api.g_varchar2_table(10) := '3F2D313D3D3D662E696E6465784F6628225252525222293F2D313D3D3D662E696E6465784F662822595922293F2D313D3D3D662E696E6465784F662822525222293F2278787878223A612E737562737472696E6728662E696E6465784F66282252522229';
wwv_flow_api.g_varchar2_table(11) := '2C662E696E6465784F662822525222292B32293A612E737562737472696E6728662E696E6465784F662822595922292C662E696E6465784F662822595922292B32293A612E737562737472696E6728662E696E6465784F6628225252525222292C662E69';
wwv_flow_api.g_varchar2_table(12) := '6E6465784F6628225252525222292B34293A612E737562737472696E6728662E696E6465784F6628225959595922292C662E696E6465784F6628225959595922292B3429292C632B222F222B642B222F222B657D7D2C616C762E76616C696461746F7273';
wwv_flow_api.g_varchar2_table(13) := '3D7B7574696C3A616C762E7574696C2C6973456D7074793A66756E6374696F6E2861297B72657475726E22223D3D3D617D2C6973457175616C3A66756E6374696F6E28612C62297B72657475726E20613D3D3D627D2C72656765783A66756E6374696F6E';
wwv_flow_api.g_varchar2_table(14) := '28612C62297B72657475726E205265674578702862292E746573742861297C7C746869732E6973456D7074792861297D2C6973416C7068616E756D657269633A66756E6374696F6E2861297B72657475726E20746869732E726567657828612C2F5E5B61';
wwv_flow_api.g_varchar2_table(15) := '2D7A302D395D2B242F69297D2C69734E756D6265723A66756E6374696F6E28612C62297B72657475726E222C2E223D3D3D623F746869732E726567657828612C2F5E2D3F283F3A5C642B7C5C647B312C337D283F3A2E5C647B337D292B293F283F3A5C2C';
wwv_flow_api.g_varchar2_table(16) := '5C642B293F242F293A746869732E726567657828612C2F5E2D3F283F3A5C642B7C5C647B312C337D283F3A2C5C647B337D292B293F283F3A5C2E5C642B293F242F297D2C697344696769743A66756E6374696F6E2861297B72657475726E20746869732E';
wwv_flow_api.g_varchar2_table(17) := '726567657828612C2F5E5C642B242F297D2C6973456D61696C3A66756E6374696F6E2861297B72657475726E20746869732E726567657828612C2F5E5B5E5C73405D2B405B5E5C73405D2B5C2E5B5E5C73405D2B242F297D2C697355726C3A66756E6374';
wwv_flow_api.g_varchar2_table(18) := '696F6E2861297B72657475726E20746869732E726567657828612C2F28687474707C6674707C6874747073293A5C2F5C2F5B5C772D5D2B285C2E5B5C772D5D2B292B285B5C772E2C403F5E3D2526616D703B3A5C2F7E2B232D5D2A5B5C77403F5E3D2526';
wwv_flow_api.g_varchar2_table(19) := '616D703B5C2F7E2B232D5D293F2F297D2C6973446174653A66756E6374696F6E28612C62297B76617220633D52656745787028225E28335B30315D7C5B31325D5B302D395D7C303F5B312D395D292F28315B302D325D7C303F5B312D395D292F283F3A5B';
wwv_flow_api.g_varchar2_table(20) := '302D395D7B327D293F5B302D395D7B327D2422292C643D746869732E7574696C2E636F6E766572744461746528612C62293B696628642E6D61746368286329297B76617220653D642E73706C697428222F22292C663D7061727365496E7428655B325D29';
wwv_flow_api.g_varchar2_table(21) := '2C673D7061727365496E7428655B315D2C3130292C683D7061727365496E7428655B305D2C3130292C693D6E6577204461746528662C672D312C68293B696628692E6765744D6F6E746828292B313D3D3D672626692E6765744461746528293D3D3D6826';
wwv_flow_api.g_varchar2_table(22) := '26692E67657446756C6C5965617228293D3D3D662972657475726E21307D72657475726E20746869732E6973456D7074792861297D2C6D696E4C656E6774683A66756E6374696F6E28612C62297B72657475726E20612E6C656E6774683E3D627C7C7468';
wwv_flow_api.g_varchar2_table(23) := '69732E6973456D7074792861297D2C6D61784C656E6774683A66756E6374696F6E28612C62297B72657475726E20623E3D612E6C656E6774687C7C746869732E6973456D7074792861297D2C72616E67654C656E6774683A66756E6374696F6E28612C62';
wwv_flow_api.g_varchar2_table(24) := '2C63297B72657475726E20746869732E6D696E4C656E67746828612C62292626746869732E6D61784C656E67746828612C63297C7C746869732E6973456D7074792861297D2C6D696E4E756D6265723A66756E6374696F6E28612C622C63297B72657475';
wwv_flow_api.g_varchar2_table(25) := '726E21746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E69734E756D62657228612C63292626746869732E69734E756D62657228622C63293F613E3D623A21307D2C6D61784E756D6265723A66756E63';
wwv_flow_api.g_varchar2_table(26) := '74696F6E28612C622C63297B72657475726E21746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E69734E756D62657228612C63292626746869732E69734E756D62657228622C63293F623E3D613A2130';
wwv_flow_api.g_varchar2_table(27) := '7D2C72616E67654E756D6265723A66756E6374696F6E28612C622C632C64297B72657475726E20746869732E6973456D7074792861297C7C746869732E6973456D7074792862297C7C746869732E6973456D7074792863297C7C2128746869732E69734E';
wwv_flow_api.g_varchar2_table(28) := '756D62657228612C64292626746869732E69734E756D62657228622C64292626746869732E69734E756D62657228632C6429297C7C623E633F21303A746869732E6D696E4E756D62657228612C622C64292626746869732E6D61784E756D62657228612C';
wwv_flow_api.g_varchar2_table(29) := '632C64297D2C6D696E436865636B3A66756E6374696F6E28612C622C63297B76617220643D242861292E66696C74657228223A636865636B656422292E6C656E6774683B72657475726E20633F746869732E6D696E4E756D62657228642C622C6E756C6C';
wwv_flow_api.g_varchar2_table(30) := '297C7C303D3D3D643A746869732E6D696E4E756D62657228642C622C6E756C6C297D2C6D6178436865636B3A66756E6374696F6E28612C62297B76617220633D242861292E66696C74657228223A636865636B656422292E6C656E6774683B7265747572';
wwv_flow_api.g_varchar2_table(31) := '6E20746869732E6D61784E756D62657228632C622C6E756C6C297C7C303D3D3D637D2C72616E6765436865636B3A66756E6374696F6E28612C622C63297B76617220643D242861292E66696C74657228223A636865636B656422292E6C656E6774683B72';
wwv_flow_api.g_varchar2_table(32) := '657475726E20746869732E72616E67654E756D62657228642C622C632C6E756C6C297C7C303D3D3D647D2C6D696E446174653A66756E6374696F6E28612C622C63297B76617220643D6E657720446174652C653D6E657720446174653B72657475726E21';
wwv_flow_api.g_varchar2_table(33) := '746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E69734461746528612C63292626746869732E69734461746528622C63293F28643D746869732E7574696C2E6765744461746546726F6D537472696E67';
wwv_flow_api.g_varchar2_table(34) := '28746869732E7574696C2E636F6E766572744461746528612C6329292C653D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528622C6329292C643E3D65293A21307D2C6D6178';
wwv_flow_api.g_varchar2_table(35) := '446174653A66756E6374696F6E28612C622C63297B76617220643D6E657720446174652C653D6E657720446174653B72657475726E21746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E697344617465';
wwv_flow_api.g_varchar2_table(36) := '28612C63292626746869732E69734461746528622C63293F28643D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528612C6329292C653D746869732E7574696C2E6765744461';
wwv_flow_api.g_varchar2_table(37) := '746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528622C6329292C653E3D64293A21307D2C72616E6765446174653A66756E6374696F6E28612C622C632C64297B76617220653D6E657720446174652C663D6E657720';
wwv_flow_api.g_varchar2_table(38) := '446174652C673D6E657720446174653B72657475726E20746869732E6973456D7074792861297C7C746869732E6973456D7074792862297C7C746869732E6973456D7074792863297C7C2128746869732E69734461746528612C64292626746869732E69';
wwv_flow_api.g_varchar2_table(39) := '734461746528622C64292626746869732E69734461746528632C6429297C7C28653D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528612C6429292C663D746869732E757469';
wwv_flow_api.g_varchar2_table(40) := '6C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528622C6429292C673D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528';
wwv_flow_api.g_varchar2_table(41) := '632C6429292C663E67293F21303A653E3D662626673E3D657D7D2C66756E6374696F6E28242C7574696C2C76616C696461746F7273297B2275736520737472696374223B242E666E2E616C763D66756E6374696F6E286D6574686F642C6F7074696F6E73';
wwv_flow_api.g_varchar2_table(42) := '297B66756E6374696F6E20726573746F7265506C7567696E53657474696E67732861297B76617220623D242861293B72657475726E20766F69642030213D3D622E6461746128636F6E7374616E74732E706C7567696E4964293F28242E657874656E6428';
wwv_flow_api.g_varchar2_table(43) := '73657474696E67732C622E6461746128636F6E7374616E74732E706C7567696E496429292C2130293A21317D66756E6374696F6E20657874656E6453657474696E67732861297B612626242E657874656E642873657474696E67732C61297D66756E6374';
wwv_flow_api.g_varchar2_table(44) := '696F6E2062696E6453657474696E677328612C62297B657874656E6453657474696E67732862292C242861292E6461746128636F6E7374616E74732E706C7567696E49642C73657474696E6773297D66756E6374696F6E20696E69742861297B76617220';
wwv_flow_api.g_varchar2_table(45) := '623D242861292C633D2223222B622E617474722822696422292C643D242822626F647922292C653D73657474696E67732E74726967676572696E674576656E742B222E222B636F6E7374616E74732E706C7567696E5072656669782C663D226368616E67';
wwv_flow_api.g_varchar2_table(46) := '652E222B636F6E7374616E74732E706C7567696E5072656669783B7377697463682873657474696E67732E76616C6964617465297B63617365226E6F74456D707479223A28622E686173436C61737328636F6E7374616E74732E61706578436865636B62';
wwv_flow_api.g_varchar2_table(47) := '6F78436C617373297C7C622E686173436C61737328636F6E7374616E74732E61706578526164696F436C617373297C7C622E686173436C61737328636F6E7374616E74732E6170657853687574746C65436C617373297C7C2253454C454354223D3D3D62';
wwv_flow_api.g_varchar2_table(48) := '2E70726F7028227461674E616D6522297C7C2266696C65223D3D3D622E6174747228227479706522297C7C622E686173436C61737328636F6E7374616E74732E61706578446174657069636B6572436C61737329292626226368616E676522213D3D7365';
wwv_flow_api.g_varchar2_table(49) := '7474696E67732E74726967676572696E674576656E74262628653D652B2220222B66292C642E64656C656761746528632C652C6973456D70747948616E646C6572293B627265616B3B63617365226974656D54797065223A2264617465223D3D3D736574';
wwv_flow_api.g_varchar2_table(50) := '74696E67732E6974656D547970652626226368616E676522213D3D73657474696E67732E74726967676572696E674576656E74262628653D652B2220222B66292C642E64656C656761746528632C652C6974656D5479706548616E646C6572293B627265';
wwv_flow_api.g_varchar2_table(51) := '616B3B6361736522657175616C223A642E64656C656761746528632C652C6973457175616C48616E646C6572293B627265616B3B63617365227265676578223A642E64656C656761746528632C652C726567657848616E646C6572293B627265616B3B63';
wwv_flow_api.g_varchar2_table(52) := '61736522636861724C656E677468223A642E64656C656761746528632C652C636861724C656E67746848616E646C6572293B627265616B3B63617365226E756D62657253697A65223A642E64656C656761746528632C652C6E756D62657253697A654861';
wwv_flow_api.g_varchar2_table(53) := '6E646C6572293B627265616B3B6361736522646174654F72646572223A226368616E676522213D3D73657474696E67732E74726967676572696E674576656E74262628653D652B2220222B66292C642E64656C656761746528632C652C646174654F7264';
wwv_flow_api.g_varchar2_table(54) := '657248616E646C6572293B627265616B3B6361736522746F74616C436865636B6564223A642E64656C656761746528632C662C746F74616C436865636B656448616E646C6572297D72657475726E2061646456616C69646174696F6E4576656E7428622C';
wwv_flow_api.g_varchar2_table(55) := '65292C617D66756E6374696F6E2061646456616C69646174696F6E4576656E7428612C62297B76617220633D242861292C643D632E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E7473292C653D21313B766F69642030213D3D';
wwv_flow_api.g_varchar2_table(56) := '643F28242E6561636828642E73706C697428222022292C66756E6374696F6E28612C63297B633D3D3D62262628653D2130297D292C657C7C632E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E74732C642B2220222B6229293A';
wwv_flow_api.g_varchar2_table(57) := '632E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E74732C62297D66756E6374696F6E206973456D70747948616E646C657228297B76617220612C623D7365744D73672873657474696E67732E6572726F724D73672C2276616C';
wwv_flow_api.g_varchar2_table(58) := '756520726571756972656422293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E6E6F74456D707479436C61737329262628613D242874686973292E686173436C61737328636F6E7374616E74732E61706578436865636B';
wwv_flow_api.g_varchar2_table(59) := '626F78436C617373297C7C242874686973292E686173436C61737328636F6E7374616E74732E61706578526164696F436C617373293F2176616C696461746F72732E6D696E436865636B28242874686973292E66696E6428223A636865636B626F782C20';
wwv_flow_api.g_varchar2_table(60) := '3A726164696F22292C312C2131293A242874686973292E686173436C61737328636F6E7374616E74732E6170657853687574746C65436C617373293F21242874686973292E66696E64282273656C6563742E73687574746C655F726967687422292E6368';
wwv_flow_api.g_varchar2_table(61) := '696C6472656E28292E6C656E6774683A76616C696461746F72732E6973456D707479282253454C454354223D3D3D242874686973292E70726F7028227461674E616D6522297C7C2266696C65223D3D3D242874686973292E617474722822747970652229';
wwv_flow_api.g_varchar2_table(62) := '3F746869732E76616C75653A73657474696E67732E616C6C6F77576869746573706163653F746869732E76616C75653A7574696C2E7472696D28746869732E76616C756529292C6126267574696C2E676574436F6E646974696F6E526573756C74287365';
wwv_flow_api.g_varchar2_table(63) := '7474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6E6F74456D707479436C6173732C223022292C73686F774D65737361676528746869732C6229293A286164';
wwv_flow_api.g_varchar2_table(64) := '6456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6E6F74456D707479436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E206973457175616C48616E646C65722829';
wwv_flow_api.g_varchar2_table(65) := '7B76617220613D7365744D73672873657474696E67732E6572726F724D73672C2276616C75657320646F206E6F7420657175616C22293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E657175616C436C61737329262676';
wwv_flow_api.g_varchar2_table(66) := '616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E677468292626282176616C696461746F72732E6973457175616C28746869732E76616C75652C242873657474';
wwv_flow_api.g_varchar2_table(67) := '696E67732E657175616C292E76616C28292926267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E';
wwv_flow_api.g_varchar2_table(68) := '74732E657175616C436C6173732C223022292C73686F774D65737361676528746869732C6129293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E657175616C436C6173732C223122292C686964654D';
wwv_flow_api.g_varchar2_table(69) := '65737361676528746869732929297D66756E6374696F6E20726567657848616E646C657228297B76617220613D7365744D73672873657474696E67732E6572726F724D73672C22696E76616C69642076616C756522293B616C6C6F7756616C6964617469';
wwv_flow_api.g_varchar2_table(70) := '6F6E28746869732C636F6E7374616E74732E7265676578436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E677468292626282176616C69';
wwv_flow_api.g_varchar2_table(71) := '6461746F72732E726567657828746869732E76616C75652C73657474696E67732E72656765782926267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E52';
wwv_flow_api.g_varchar2_table(72) := '6573756C7428242874686973292C636F6E7374616E74732E7265676578436C6173732C223022292C73686F774D65737361676528746869732C6129293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E';
wwv_flow_api.g_varchar2_table(73) := '7265676578436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E206974656D5479706548616E646C657228297B76617220612C623B696628616C6C6F7756616C69646174696F6E28746869732C636F6E7374';
wwv_flow_api.g_varchar2_table(74) := '616E74732E6974656D54797065436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E67746829297B7377697463682873657474696E67732E';
wwv_flow_api.g_varchar2_table(75) := '6974656D54797065297B6361736522616C7068616E756D65726963223A613D76616C696461746F72732E6973416C7068616E756D6572696328746869732E76616C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F74';
wwv_flow_api.g_varchar2_table(76) := '20616E20616C7068616E756D657269632076616C756522293B627265616B3B63617365226E756D626572223A613D76616C696461746F72732E69734E756D62657228746869732E76616C75652C73657474696E67732E6E756D6572696343686172616374';
wwv_flow_api.g_varchar2_table(77) := '657273292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C6964206E756D62657222293B627265616B3B63617365226469676974223A613D76616C696461746F72732E6973446967697428746869732E7661';
wwv_flow_api.g_varchar2_table(78) := '6C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C696420646967697420636F6D62696E6174696F6E22293B627265616B3B6361736522656D61696C223A613D76616C696461746F72732E6973456D';
wwv_flow_api.g_varchar2_table(79) := '61696C28746869732E76616C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C696420652D6D61696C206164647265737322293B627265616B3B636173652275726C223A613D76616C696461746F72';
wwv_flow_api.g_varchar2_table(80) := '732E697355726C28746869732E76616C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C69642055524C22293B627265616B3B636173652264617465223A613D76616C696461746F72732E69734461';
wwv_flow_api.g_varchar2_table(81) := '746528746869732E76616C75652C73657474696E67732E64617465466F726D6174292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C69642064617465202826312922';
wwv_flow_api.g_varchar2_table(82) := '292C73657474696E67732E64617465466F726D6174297D216126267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C';
wwv_flow_api.g_varchar2_table(83) := '636F6E7374616E74732E6974656D54797065436C6173732C223022292C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6974656D54797065436C61';
wwv_flow_api.g_varchar2_table(84) := '73732C223122292C686964654D657373616765287468697329297D7D66756E6374696F6E20636861724C656E67746848616E646C657228297B76617220612C623B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E63686172';
wwv_flow_api.g_varchar2_table(85) := '4C656E677468436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E6774682926262876616C696461746F72732E6973456D70747928736574';
wwv_flow_api.g_varchar2_table(86) := '74696E67732E6D6178293F28613D76616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E6D696E292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73';
wwv_flow_api.g_varchar2_table(87) := '672C2276616C7565206C656E67746820746F6F2073686F7274202D206D696E2E20263122292C73657474696E67732E6D696E29293A76616C696461746F72732E6973456D7074792873657474696E67732E6D696E293F28613D76616C696461746F72732E';
wwv_flow_api.g_varchar2_table(88) := '6D61784C656E67746828746869732E76616C75652C73657474696E67732E6D6178292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C2276616C7565206C656E67746820746F6F206C6F6E6720';
wwv_flow_api.g_varchar2_table(89) := '2D206D61782E20263122292C73657474696E67732E6D617829293A28613D76616C696461746F72732E72616E67654C656E67746828746869732E76616C75652C73657474696E67732E6D696E2C73657474696E67732E6D6178292C623D7265706C616365';
wwv_flow_api.g_varchar2_table(90) := '4D736756617273287365744D73672873657474696E67732E6572726F724D73672C22696E76616C69642076616C7565206C656E677468202D206265747765656E20263120616E64202632206F6E6C7922292C73657474696E67732E6D696E2C7365747469';
wwv_flow_api.g_varchar2_table(91) := '6E67732E6D617829292C216126267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E636861';
wwv_flow_api.g_varchar2_table(92) := '724C656E677468436C6173732C223022292C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E636861724C656E677468436C6173732C223122292C68';
wwv_flow_api.g_varchar2_table(93) := '6964654D65737361676528746869732929297D66756E6374696F6E206E756D62657253697A6548616E646C657228297B76617220612C622C633D7574696C2E6765744E756D62657246726F6D537472696E6728746869732E76616C7565292C643D757469';
wwv_flow_api.g_varchar2_table(94) := '6C2E6765744E756D62657246726F6D537472696E67287574696C2E676574506167654974656D56616C75652873657474696E67732E6D696E29292C653D7574696C2E6765744E756D62657246726F6D537472696E67287574696C2E676574506167654974';
wwv_flow_api.g_varchar2_table(95) := '656D56616C75652873657474696E67732E6D617829293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E6E756D62657253697A65436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E7661';
wwv_flow_api.g_varchar2_table(96) := '6C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E6774682926262876616C696461746F72732E6973456D7074792873657474696E67732E6D6178293F28613D76616C696461746F72732E6D696E4E756D62657228632C642C736574';
wwv_flow_api.g_varchar2_table(97) := '74696E67732E6E756D6572696343686172616374657273292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C226E756D62657220746F6F20736D616C6C202D206D696E2E20263122292C642929';
wwv_flow_api.g_varchar2_table(98) := '3A76616C696461746F72732E6973456D7074792873657474696E67732E6D696E293F28613D76616C696461746F72732E6D61784E756D62657228632C652C73657474696E67732E6E756D6572696343686172616374657273292C623D7265706C6163654D';
wwv_flow_api.g_varchar2_table(99) := '736756617273287365744D73672873657474696E67732E6572726F724D73672C226E756D62657220746F6F206C61726765202D206D61782E20263122292C6529293A28613D76616C696461746F72732E72616E67654E756D62657228632C642C652C7365';
wwv_flow_api.g_varchar2_table(100) := '7474696E67732E6E756D6572696343686172616374657273292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22696E76616C6964206E756D6265722073697A65202D206265747765656E2026';
wwv_flow_api.g_varchar2_table(101) := '3120616E64202632206F6E6C7922292C642C6529292C216126267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C63';
wwv_flow_api.g_varchar2_table(102) := '6F6E7374616E74732E6E756D62657253697A65436C6173732C223022292C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6E756D62657253697A65';
wwv_flow_api.g_varchar2_table(103) := '436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E20746F74616C436865636B656448616E646C657228297B76617220612C622C633D242874686973292E66696E6428223A636865636B626F782C203A7261';
wwv_flow_api.g_varchar2_table(104) := '64696F22293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E746F74616C436865636B6564436C6173732926262876616C696461746F72732E6973456D7074792873657474696E67732E6D6178293F28613D76616C696461';
wwv_flow_api.g_varchar2_table(105) := '746F72732E6D696E436865636B28632C73657474696E67732E6D696E2C2130292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22706C656173652073656C656374206174206C656173742026';
wwv_flow_api.g_varchar2_table(106) := '312063686F69636528732922292C73657474696E67732E6D696E29293A76616C696461746F72732E6973456D7074792873657474696E67732E6D696E293F28613D76616C696461746F72732E6D6178436865636B28632C73657474696E67732E6D617829';
wwv_flow_api.g_varchar2_table(107) := '2C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22706C656173652073656C656374206E6F206D6F7265207468616E2026312063686F69636528732922292C73657474696E67732E6D61782929';
wwv_flow_api.g_varchar2_table(108) := '3A28613D76616C696461746F72732E72616E6765436865636B28632C73657474696E67732E6D696E2C73657474696E67732E6D6178292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22706C';
wwv_flow_api.g_varchar2_table(109) := '656173652073656C656374206265747765656E20263120616E642026322063686F69636528732922292C73657474696E67732E6D696E2C73657474696E67732E6D617829292C216126267574696C2E676574436F6E646974696F6E526573756C74287365';
wwv_flow_api.g_varchar2_table(110) := '7474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E746F74616C436865636B6564436C6173732C223022292C73686F774D65737361676528746869732C622929';
wwv_flow_api.g_varchar2_table(111) := '3A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E746F74616C436865636B6564436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E20646174654F726465';
wwv_flow_api.g_varchar2_table(112) := '7248616E646C657228297B76617220612C622C633D7574696C2E676574506167654974656D56616C75652873657474696E67732E6D696E292C643D7574696C2E676574506167654974656D56616C75652873657474696E67732E6D6178293B616C6C6F77';
wwv_flow_api.g_varchar2_table(113) := '56616C69646174696F6E28746869732C636F6E7374616E74732E646174654F72646572436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E';
wwv_flow_api.g_varchar2_table(114) := '6774682926262876616C696461746F72732E6973456D7074792873657474696E67732E6D6178293F28613D76616C696461746F72732E6D696E4461746528746869732E76616C75652C632C73657474696E67732E64617465466F726D6174292C623D7265';
wwv_flow_api.g_varchar2_table(115) := '706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C227468697320646174652073686F756C64206C696520616674657220263122292C6329293A76616C696461746F72732E6973456D7074792873657474696E';
wwv_flow_api.g_varchar2_table(116) := '67732E6D696E293F28613D76616C696461746F72732E6D61784461746528746869732E76616C75652C642C73657474696E67732E64617465466F726D6174292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E657272';
wwv_flow_api.g_varchar2_table(117) := '6F724D73672C227468697320646174652073686F756C64206C6965206265666F726520263122292C6429293A28613D76616C696461746F72732E72616E67654461746528746869732E76616C75652C632C642C73657474696E67732E64617465466F726D';
wwv_flow_api.g_varchar2_table(118) := '6174292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C227468697320646174652073686F756C64206C6965206265747765656E20263120616E6420263222292C632C6429292C216126267574';
wwv_flow_api.g_varchar2_table(119) := '696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E646174654F72646572436C6173732C22302229';
wwv_flow_api.g_varchar2_table(120) := '2C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E646174654F72646572436C6173732C223122292C686964654D6573736167652874686973292929';
wwv_flow_api.g_varchar2_table(121) := '7D66756E6374696F6E2073686F774D65737361676528612C62297B76617220633D242861292C643D273C7370616E20636C6173733D22272B636F6E7374616E74732E6572726F724D7367436C6173732B2220222B612E69642B27223E272B622B223C2F73';
wwv_flow_api.g_varchar2_table(122) := '70616E3E223B696628632E686173436C61737328636F6E7374616E74732E6974656D4572726F72436C61737329297B76617220653D2428227370616E2E222B636F6E7374616E74732E6572726F724D7367436C6173732B222E222B612E6964292C663D65';
wwv_flow_api.g_varchar2_table(123) := '2E696E64657828292C673D632E696E64657828293B673E662626226265666F7265223D3D3D73657474696E67732E6572726F724D73674C6F636174696F6E3F652E746578742862293A673E662626226166746572223D3D3D73657474696E67732E657272';
wwv_flow_api.g_varchar2_table(124) := '6F724D73674C6F636174696F6E3F28652E72656D6F766528292C632E6166746572286429293A663E672626226166746572223D3D3D73657474696E67732E6572726F724D73674C6F636174696F6E3F652E746578742862293A28652E72656D6F76652829';
wwv_flow_api.g_varchar2_table(125) := '2C632E6265666F7265286429297D656C736520632E616464436C61737328636F6E7374616E74732E6974656D4572726F72436C617373292C2428225B666F723D222B612E69642B225D22292E616464436C61737328636F6E7374616E74732E6C6162656C';
wwv_flow_api.g_varchar2_table(126) := '4572726F72436C617373292C226265666F7265223D3D3D73657474696E67732E6572726F724D73674C6F636174696F6E3F632E6265666F72652864293A632E61667465722864297D66756E6374696F6E20686964654D6573736167652861297B76617220';
wwv_flow_api.g_varchar2_table(127) := '623D242861293B622E686173436C61737328636F6E7374616E74732E6974656D4572726F72436C61737329262628622E72656D6F7665436C61737328636F6E7374616E74732E6974656D4572726F72436C617373292C2428225B666F723D222B612E6964';
wwv_flow_api.g_varchar2_table(128) := '2B225D22292E72656D6F7665436C61737328636F6E7374616E74732E6C6162656C4572726F72436C617373292C2428227370616E2E222B636F6E7374616E74732E6572726F724D7367436C6173732B222E222B612E6964292E72656D6F76652829297D66';
wwv_flow_api.g_varchar2_table(129) := '756E6374696F6E207365744D736728612C62297B72657475726E2076616C696461746F72732E6973456D7074792861293F623A617D66756E6374696F6E207265706C6163654D7367566172732861297B666F722876617220623D612C633D312C643D6172';
wwv_flow_api.g_varchar2_table(130) := '67756D656E74732E6C656E6774683B643E633B632B2B29623D622E7265706C616365282226222B632C617267756D656E74735B635D293B72657475726E20627D66756E6374696F6E20616C6C6F7756616C69646174696F6E28612C62297B76617220633D';
wwv_flow_api.g_varchar2_table(131) := '21302C643D242861292C653D642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C7473293B72657475726E20766F69642030213D3D652626282D313D3D3D652E696E6465784F662862293F242E6561636828652E73706C6974';
wwv_flow_api.g_varchar2_table(132) := '28222022292C66756E6374696F6E28612C62297B633D3D3D21302626223122213D3D622E736C696365282D3129262628633D2131297D293A642E72656D6F76654461746128636F6E7374616E74732E76616C69646174696F6E526573756C747329292C63';
wwv_flow_api.g_varchar2_table(133) := '7D66756E6374696F6E2061646456616C69646174696F6E526573756C7428612C622C63297B76617220643D242861292C653D642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C7473292C663D21312C673D622B223A222B63';
wwv_flow_api.g_varchar2_table(134) := '3B766F69642030213D3D653F28242E6561636828652E73706C697428222022292C66756E6374696F6E28612C67297B696628672E73756273747228302C672E696E6465784F6628223A2229293D3D3D62297B76617220683D652E696E6465784F66286729';
wwv_flow_api.g_varchar2_table(135) := '2B672E6C656E6774682D313B653D7574696C2E7265706C61636543686172496E537472696E6728652C682C63292C642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C74732C65292C663D21307D7D292C667C7C642E646174';
wwv_flow_api.g_varchar2_table(136) := '6128636F6E7374616E74732E76616C69646174696F6E526573756C74732C652B2220222B6729293A642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C74732C67292C2231223D3D3D633F2873657474696E67732E6974656D';
wwv_flow_api.g_varchar2_table(137) := '537563636573732E63616C6C2874686973292C642E747269676765722822616C766974656D737563636573732229293A2873657474696E67732E6974656D4661696C2E63616C6C2874686973292C642E747269676765722822616C766974656D6661696C';
wwv_flow_api.g_varchar2_table(138) := '2229297D66756E6374696F6E20666F726D4861734572726F72732861297B76617220622C633D21312C643D242861292E66696E642822696E7075742C2074657874617265612C2073656C6563742C206669656C6473657422293B72657475726E20242E65';
wwv_flow_api.g_varchar2_table(139) := '61636828642C66756E6374696F6E28297B623D242874686973292C766F69642030213D3D622E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E7473292626242E6561636828622E6461746128636F6E7374616E74732E76616C69';
wwv_flow_api.g_varchar2_table(140) := '646174696F6E4576656E7473292E73706C697428222022292C66756E6374696F6E28612C63297B622E747269676765722863297D297D292C642E686173436C61737328636F6E7374616E74732E6974656D4572726F72436C61737329262628242864292E';
wwv_flow_api.g_varchar2_table(141) := '66696C74657228222E222B636F6E7374616E74732E6974656D4572726F72436C617373292E666972737428292E666F63757328292C633D2130292C637D66756E6374696F6E2076616C6964617465466F726D4265666F72655375626D6974287046697269';
wwv_flow_api.g_varchar2_table(142) := '6E67456C656D297B76617220666972696E67456C656D3D242870466972696E67456C656D292C6F726967436C69636B4576656E742C6669784572726F72734D73673D7365744D73672873657474696E67732E6572726F724D73672C22506C656173652066';
wwv_flow_api.g_varchar2_table(143) := '697820616C6C206572726F7273206265666F726520636F6E74696E75696E6722292C626F6479456C656D3D242822626F647922292C6D657373616765426F7849643D2223616C762D6D73672D626F78222C6D7367426F783D273C64697620636C6173733D';
wwv_flow_api.g_varchar2_table(144) := '22616C762D616C6572742D6D7367223E3C6120687265663D22232220636C6173733D22616C762D636C6F736522206F6E636C69636B3D2224285C27272B6D657373616765426F7849642B2227292E6368696C6472656E28292E666164654F757428293B72';
wwv_flow_api.g_varchar2_table(145) := '657475726E2066616C73653B5C223E783C2F613E3C703E222B6669784572726F72734D73672B223C2F703E3C2F6469763E223B666972696E67456C656D2E6C656E6774682626282241223D3D3D666972696E67456C656D2E70726F7028227461674E616D';
wwv_flow_api.g_varchar2_table(146) := '6522293F286F726967436C69636B4576656E743D666972696E67456C656D2E6174747228226872656622292C666972696E67456C656D2E6461746128636F6E7374616E74732E6F726967436C69636B4576656E742C6F726967436C69636B4576656E7429';
wwv_flow_api.g_varchar2_table(147) := '2C666972696E67456C656D2E72656D6F7665417474722822687265662229293A286F726967436C69636B4576656E743D666972696E67456C656D2E6174747228226F6E636C69636B22292C666972696E67456C656D2E6461746128636F6E7374616E7473';
wwv_flow_api.g_varchar2_table(148) := '2E6F726967436C69636B4576656E742C6F726967436C69636B4576656E74292C666972696E67456C656D2E72656D6F76654174747228226F6E636C69636B2229292C626F6479456C656D2E64656C6567617465282223222B666972696E67456C656D2E61';
wwv_flow_api.g_varchar2_table(149) := '7474722822696422292C22636C69636B222C66756E6374696F6E28297B666F726D4861734572726F72732873657474696E67732E666F726D73546F5375626D6974293F2873657474696E67732E666F726D4661696C2E63616C6C2874686973292C666972';
wwv_flow_api.g_varchar2_table(150) := '696E67456C656D2E747269676765722822616C76666F726D6661696C22292C24286D657373616765426F784964292E6C656E6774687C7C626F6479456C656D2E617070656E6428273C6469762069643D22272B6D657373616765426F7849642E73756273';
wwv_flow_api.g_varchar2_table(151) := '7472696E672831292B27223E3C2F6469763E27292C24286D657373616765426F784964292E68746D6C286D7367426F7829293A2873657474696E67732E666F726D537563636573732E63616C6C2874686973292C666972696E67456C656D2E7472696767';
wwv_flow_api.g_varchar2_table(152) := '65722822616C76666F726D7375636365737322292C6576616C28242874686973292E6461746128636F6E7374616E74732E6F726967436C69636B4576656E742929297D29297D76617220636F6E7374616E74733D7B706C7567696E49643A2262652E6374';
wwv_flow_api.g_varchar2_table(153) := '622E6A712E616C76222C706C7567696E4E616D653A2241504558204C6976652056616C69646174696F6E222C706C7567696E5072656669783A22616C76222C61706578436865636B626F78436C6173733A22636865636B626F785F67726F7570222C6170';
wwv_flow_api.g_varchar2_table(154) := '6578526164696F436C6173733A22726164696F5F67726F7570222C6170657853687574746C65436C6173733A2273687574746C65222C61706578446174657069636B6572436C6173733A22646174657069636B6572227D3B242E657874656E6428636F6E';
wwv_flow_api.g_varchar2_table(155) := '7374616E74732C7B76616C69646174696F6E4576656E74733A636F6E7374616E74732E706C7567696E5072656669782B222D76616C4576656E7473222C76616C69646174696F6E526573756C74733A636F6E7374616E74732E706C7567696E5072656669';
wwv_flow_api.g_varchar2_table(156) := '782B222D76616C526573756C7473222C6F726967436C69636B4576656E743A636F6E7374616E74732E706C7567696E5072656669782B222D6F726967436C69636B4576656E74222C6E6F74456D707479436C6173733A636F6E7374616E74732E706C7567';
wwv_flow_api.g_varchar2_table(157) := '696E5072656669782B222D6E6F74456D707479222C6974656D54797065436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D6974656D54797065222C657175616C436C6173733A636F6E7374616E74732E706C7567696E507265';
wwv_flow_api.g_varchar2_table(158) := '6669782B222D657175616C222C7265676578436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D7265676578222C636861724C656E677468436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D636861';
wwv_flow_api.g_varchar2_table(159) := '724C656E677468222C6E756D62657253697A65436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D6E756D62657253697A65222C646174654F72646572436C6173733A636F6E7374616E74732E706C7567696E5072656669782B';
wwv_flow_api.g_varchar2_table(160) := '222D646174654F72646572222C746F74616C436865636B6564436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D746F74616C436865636B6564222C6974656D4572726F72436C6173733A636F6E7374616E74732E706C756769';
wwv_flow_api.g_varchar2_table(161) := '6E5072656669782B222D6974656D2D6572726F72222C6C6162656C4572726F72436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D6C6162656C2D6572726F72222C6572726F724D7367436C6173733A636F6E7374616E74732E';
wwv_flow_api.g_varchar2_table(162) := '706C7567696E5072656669782B222D6572726F722D6D7367227D293B7661722073657474696E67733D7B76616C69646174653A226E6F74456D707479222C74726967676572696E674576656E743A22626C7572222C636F6E646974696F6E3A22222C7661';
wwv_flow_api.g_varchar2_table(163) := '6C69646174696F6E4D696E4C656E6774683A302C6572726F724D73673A22222C6572726F724D73674C6F636174696F6E3A226166746572222C616C6C6F77576869746573706163653A21302C6974656D547970653A22222C64617465466F726D61743A22';
wwv_flow_api.g_varchar2_table(164) := '222C6E756D65726963436861726163746572733A22222C6D696E3A22222C6D61783A22222C657175616C3A22222C72656765783A22222C666F726D73546F5375626D69743A22222C6974656D537563636573733A66756E6374696F6E28297B7D2C697465';
wwv_flow_api.g_varchar2_table(165) := '6D4661696C3A66756E6374696F6E28297B7D2C666F726D537563636573733A66756E6374696F6E28297B7D2C666F726D4661696C3A66756E6374696F6E28297B7D7D2C6D6574686F64733D7B696E69743A66756E6374696F6E2861297B76617220623D24';
wwv_flow_api.g_varchar2_table(166) := '2874686973293B62696E6453657474696E677328622C61292C696E69742862297D2C76616C6964617465466F726D3A66756E6374696F6E2861297B76617220623D242874686973293B62696E6453657474696E677328622C61292C76616C696461746546';
wwv_flow_api.g_varchar2_table(167) := '6F726D4265666F72655375626D69742862297D2C72656D6F76653A66756E6374696F6E28297B76617220613D242874686973293B726573746F7265506C7567696E53657474696E677328612926266D6574686F6428297D7D3B72657475726E2024287468';
wwv_flow_api.g_varchar2_table(168) := '6973292E656163682866756E6374696F6E28297B72657475726E206D6574686F64735B6D6574686F645D3F6D6574686F64735B6D6574686F645D2E63616C6C28242874686973292C6F7074696F6E73293A226F626A65637422213D747970656F66206D65';
wwv_flow_api.g_varchar2_table(169) := '74686F6426266D6574686F643F28242E6572726F7228224D6574686F6420222B6D6574686F642B2220646F6573206E6F74206578697374206F6E206A51756572792E20222B636F6E7374616E74732E706C7567696E4E616D65292C2131293A6D6574686F';
wwv_flow_api.g_varchar2_table(170) := '64732E696E69742E63616C6C28242874686973292C6D6574686F64297D297D7D286A51756572792C616C762E7574696C2C616C762E76616C696461746F7273293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(247730712744888769)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_file_name=>'jquery.alv'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220616C763D7B7D3B616C762E7574696C3D7B7472696D3A66756E6374696F6E2861297B72657475726E20612E7265706C616365282F5E5C732B7C5C732B242F672C2222297D2C7265706C61636543686172496E537472696E673A66756E6374696F';
wwv_flow_api.g_varchar2_table(2) := '6E28612C622C63297B72657475726E20612E73756273747228302C62292B28632B2222292B612E73756273747228622B28632B2222292E6C656E677468297D2C676574506167654974656D56616C75653A66756E6374696F6E2861297B72657475726E22';
wwv_flow_api.g_varchar2_table(3) := '2350223D3D3D28612B2222292E737562737472696E6728302C32293F242861292E76616C28293A617D2C676574436F6E646974696F6E526573756C743A66756E6374696F6E287045787072657373696F6E297B7661722065787072657373696F6E526573';
wwv_flow_api.g_varchar2_table(4) := '756C743D21303B72657475726E207045787072657373696F6E2E6C656E67746826262865787072657373696F6E526573756C743D6576616C287045787072657373696F6E29292C65787072657373696F6E526573756C747D2C6765744E756D6265724672';
wwv_flow_api.g_varchar2_table(5) := '6F6D537472696E673A66756E6374696F6E2861297B72657475726E28612B2222292E6C656E6774683F4E756D6265722861293A22227D2C6765744461746546726F6D537472696E673A66756E6374696F6E2861297B76617220623D612E73706C69742822';
wwv_flow_api.g_varchar2_table(6) := '2F22292C633D7061727365496E7428625B325D292C643D7061727365496E7428625B315D2C3130292C653D7061727365496E7428625B305D2C3130293B72657475726E206E6577204461746528632C642D312C65297D2C636F6E76657274446174653A66';
wwv_flow_api.g_varchar2_table(7) := '756E6374696F6E28612C62297B76617220632C642C652C663D622E746F55707065724361736528292C673D662E7265706C616365282F5B412D5A5D2B2F672C2222292C683D612E7265706C616365282F5C642B2F672C2222293B72657475726E20612E6C';
wwv_flow_api.g_varchar2_table(8) := '656E6774683D3D3D622E6C656E6774682626683D3D3D67262628633D2D313D3D3D662E696E6465784F662822444422293F227878223A612E737562737472696E6728662E696E6465784F662822444422292C662E696E6465784F662822444422292B3229';
wwv_flow_api.g_varchar2_table(9) := '2C643D2D313D3D3D662E696E6465784F6628224D4D22293F227878223A612E737562737472696E6728662E696E6465784F6628224D4D22292C662E696E6465784F6628224D4D22292B32292C653D2D313D3D3D662E696E6465784F662822595959592229';
wwv_flow_api.g_varchar2_table(10) := '3F2D313D3D3D662E696E6465784F6628225252525222293F2D313D3D3D662E696E6465784F662822595922293F2D313D3D3D662E696E6465784F662822525222293F2278787878223A612E737562737472696E6728662E696E6465784F66282252522229';
wwv_flow_api.g_varchar2_table(11) := '2C662E696E6465784F662822525222292B32293A612E737562737472696E6728662E696E6465784F662822595922292C662E696E6465784F662822595922292B32293A612E737562737472696E6728662E696E6465784F6628225252525222292C662E69';
wwv_flow_api.g_varchar2_table(12) := '6E6465784F6628225252525222292B34293A612E737562737472696E6728662E696E6465784F6628225959595922292C662E696E6465784F6628225959595922292B3429292C632B222F222B642B222F222B657D7D2C616C762E76616C696461746F7273';
wwv_flow_api.g_varchar2_table(13) := '3D7B7574696C3A616C762E7574696C2C6973456D7074793A66756E6374696F6E2861297B72657475726E22223D3D3D617D2C6973457175616C3A66756E6374696F6E28612C62297B72657475726E20613D3D3D627D2C72656765783A66756E6374696F6E';
wwv_flow_api.g_varchar2_table(14) := '28612C62297B72657475726E205265674578702862292E746573742861297C7C746869732E6973456D7074792861297D2C6973416C7068616E756D657269633A66756E6374696F6E2861297B72657475726E20746869732E726567657828612C2F5E5B61';
wwv_flow_api.g_varchar2_table(15) := '2D7A302D395D2B242F69297D2C69734E756D6265723A66756E6374696F6E28612C62297B72657475726E222C2E223D3D3D623F746869732E726567657828612C2F5E2D3F283F3A5C642B7C5C647B312C337D283F3A2E5C647B337D292B293F283F3A5C2C';
wwv_flow_api.g_varchar2_table(16) := '5C642B293F242F293A746869732E726567657828612C2F5E2D3F283F3A5C642B7C5C647B312C337D283F3A2C5C647B337D292B293F283F3A5C2E5C642B293F242F297D2C697344696769743A66756E6374696F6E2861297B72657475726E20746869732E';
wwv_flow_api.g_varchar2_table(17) := '726567657828612C2F5E5C642B242F297D2C6973456D61696C3A66756E6374696F6E2861297B72657475726E20746869732E726567657828612C2F5E5B5E5C73405D2B405B5E5C73405D2B5C2E5B5E5C73405D2B242F297D2C697355726C3A66756E6374';
wwv_flow_api.g_varchar2_table(18) := '696F6E2861297B72657475726E20746869732E726567657828612C2F28687474707C6674707C6874747073293A5C2F5C2F5B5C772D5D2B285C2E5B5C772D5D2B292B285B5C772E2C403F5E3D2526616D703B3A5C2F7E2B232D5D2A5B5C77403F5E3D2526';
wwv_flow_api.g_varchar2_table(19) := '616D703B5C2F7E2B232D5D293F2F297D2C6973446174653A66756E6374696F6E28612C62297B76617220633D52656745787028225E28335B30315D7C5B31325D5B302D395D7C303F5B312D395D292F28315B302D325D7C303F5B312D395D292F283F3A5B';
wwv_flow_api.g_varchar2_table(20) := '302D395D7B327D293F5B302D395D7B327D2422292C643D746869732E7574696C2E636F6E766572744461746528612C62293B696628642E6D61746368286329297B76617220653D642E73706C697428222F22292C663D7061727365496E7428655B325D29';
wwv_flow_api.g_varchar2_table(21) := '2C673D7061727365496E7428655B315D2C3130292C683D7061727365496E7428655B305D2C3130292C693D6E6577204461746528662C672D312C68293B696628692E6765744D6F6E746828292B313D3D3D672626692E6765744461746528293D3D3D6826';
wwv_flow_api.g_varchar2_table(22) := '26692E67657446756C6C5965617228293D3D3D662972657475726E21307D72657475726E20746869732E6973456D7074792861297D2C6D696E4C656E6774683A66756E6374696F6E28612C62297B72657475726E20612E6C656E6774683E3D627C7C7468';
wwv_flow_api.g_varchar2_table(23) := '69732E6973456D7074792861297D2C6D61784C656E6774683A66756E6374696F6E28612C62297B72657475726E20623E3D612E6C656E6774687C7C746869732E6973456D7074792861297D2C72616E67654C656E6774683A66756E6374696F6E28612C62';
wwv_flow_api.g_varchar2_table(24) := '2C63297B72657475726E20746869732E6D696E4C656E67746828612C62292626746869732E6D61784C656E67746828612C63297C7C746869732E6973456D7074792861297D2C6D696E4E756D6265723A66756E6374696F6E28612C622C63297B72657475';
wwv_flow_api.g_varchar2_table(25) := '726E21746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E69734E756D62657228612C63292626746869732E69734E756D62657228622C63293F613E3D623A21307D2C6D61784E756D6265723A66756E63';
wwv_flow_api.g_varchar2_table(26) := '74696F6E28612C622C63297B72657475726E21746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E69734E756D62657228612C63292626746869732E69734E756D62657228622C63293F623E3D613A2130';
wwv_flow_api.g_varchar2_table(27) := '7D2C72616E67654E756D6265723A66756E6374696F6E28612C622C632C64297B72657475726E20746869732E6973456D7074792861297C7C746869732E6973456D7074792862297C7C746869732E6973456D7074792863297C7C2128746869732E69734E';
wwv_flow_api.g_varchar2_table(28) := '756D62657228612C64292626746869732E69734E756D62657228622C64292626746869732E69734E756D62657228632C6429297C7C623E633F21303A746869732E6D696E4E756D62657228612C622C64292626746869732E6D61784E756D62657228612C';
wwv_flow_api.g_varchar2_table(29) := '632C64297D2C6D696E436865636B3A66756E6374696F6E28612C622C63297B76617220643D242861292E66696C74657228223A636865636B656422292E6C656E6774683B72657475726E20633F746869732E6D696E4E756D62657228642C622C6E756C6C';
wwv_flow_api.g_varchar2_table(30) := '297C7C303D3D3D643A746869732E6D696E4E756D62657228642C622C6E756C6C297D2C6D6178436865636B3A66756E6374696F6E28612C62297B76617220633D242861292E66696C74657228223A636865636B656422292E6C656E6774683B7265747572';
wwv_flow_api.g_varchar2_table(31) := '6E20746869732E6D61784E756D62657228632C622C6E756C6C297C7C303D3D3D637D2C72616E6765436865636B3A66756E6374696F6E28612C622C63297B76617220643D242861292E66696C74657228223A636865636B656422292E6C656E6774683B72';
wwv_flow_api.g_varchar2_table(32) := '657475726E20746869732E72616E67654E756D62657228642C622C632C6E756C6C297C7C303D3D3D647D2C6D696E446174653A66756E6374696F6E28612C622C63297B76617220643D6E657720446174652C653D6E657720446174653B72657475726E21';
wwv_flow_api.g_varchar2_table(33) := '746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E69734461746528612C63292626746869732E69734461746528622C63293F28643D746869732E7574696C2E6765744461746546726F6D537472696E67';
wwv_flow_api.g_varchar2_table(34) := '28746869732E7574696C2E636F6E766572744461746528612C6329292C653D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528622C6329292C643E3D65293A21307D2C6D6178';
wwv_flow_api.g_varchar2_table(35) := '446174653A66756E6374696F6E28612C622C63297B76617220643D6E657720446174652C653D6E657720446174653B72657475726E21746869732E6973456D707479286129262621746869732E6973456D7074792862292626746869732E697344617465';
wwv_flow_api.g_varchar2_table(36) := '28612C63292626746869732E69734461746528622C63293F28643D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528612C6329292C653D746869732E7574696C2E6765744461';
wwv_flow_api.g_varchar2_table(37) := '746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528622C6329292C653E3D64293A21307D2C72616E6765446174653A66756E6374696F6E28612C622C632C64297B76617220653D6E657720446174652C663D6E657720';
wwv_flow_api.g_varchar2_table(38) := '446174652C673D6E657720446174653B72657475726E20746869732E6973456D7074792861297C7C746869732E6973456D7074792862297C7C746869732E6973456D7074792863297C7C2128746869732E69734461746528612C64292626746869732E69';
wwv_flow_api.g_varchar2_table(39) := '734461746528622C64292626746869732E69734461746528632C6429297C7C28653D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528612C6429292C663D746869732E757469';
wwv_flow_api.g_varchar2_table(40) := '6C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528622C6429292C673D746869732E7574696C2E6765744461746546726F6D537472696E6728746869732E7574696C2E636F6E766572744461746528';
wwv_flow_api.g_varchar2_table(41) := '632C6429292C663E67293F21303A653E3D662626673E3D657D7D2C66756E6374696F6E28242C7574696C2C76616C696461746F7273297B2275736520737472696374223B242E666E2E616C763D66756E6374696F6E286D6574686F642C6F7074696F6E73';
wwv_flow_api.g_varchar2_table(42) := '297B66756E6374696F6E20726573746F7265506C7567696E53657474696E67732861297B76617220623D242861293B72657475726E20766F69642030213D3D622E6461746128636F6E7374616E74732E706C7567696E4964293F28242E657874656E6428';
wwv_flow_api.g_varchar2_table(43) := '73657474696E67732C622E6461746128636F6E7374616E74732E706C7567696E496429292C2130293A21317D66756E6374696F6E20657874656E6453657474696E67732861297B612626242E657874656E642873657474696E67732C61297D66756E6374';
wwv_flow_api.g_varchar2_table(44) := '696F6E2062696E6453657474696E677328612C62297B657874656E6453657474696E67732862292C242861292E6461746128636F6E7374616E74732E706C7567696E49642C73657474696E6773297D66756E6374696F6E20696E69742861297B76617220';
wwv_flow_api.g_varchar2_table(45) := '623D242861292C633D2223222B622E617474722822696422292C643D242822626F647922292C653D73657474696E67732E74726967676572696E674576656E742B222E222B636F6E7374616E74732E706C7567696E5072656669782C663D226368616E67';
wwv_flow_api.g_varchar2_table(46) := '652E222B636F6E7374616E74732E706C7567696E5072656669783B7377697463682873657474696E67732E76616C6964617465297B63617365226E6F74456D707479223A28622E686173436C61737328636F6E7374616E74732E61706578436865636B62';
wwv_flow_api.g_varchar2_table(47) := '6F78436C617373297C7C622E686173436C61737328636F6E7374616E74732E61706578526164696F436C617373297C7C622E686173436C61737328636F6E7374616E74732E6170657853687574746C65436C617373297C7C2253454C454354223D3D3D62';
wwv_flow_api.g_varchar2_table(48) := '2E70726F7028227461674E616D6522297C7C2266696C65223D3D3D622E6174747228227479706522297C7C622E686173436C61737328636F6E7374616E74732E61706578446174657069636B6572436C61737329292626226368616E676522213D3D7365';
wwv_flow_api.g_varchar2_table(49) := '7474696E67732E74726967676572696E674576656E74262628653D652B2220222B66292C642E64656C656761746528632C652C6973456D70747948616E646C6572293B627265616B3B63617365226974656D54797065223A2264617465223D3D3D736574';
wwv_flow_api.g_varchar2_table(50) := '74696E67732E6974656D547970652626226368616E676522213D3D73657474696E67732E74726967676572696E674576656E74262628653D652B2220222B66292C642E64656C656761746528632C652C6974656D5479706548616E646C6572293B627265';
wwv_flow_api.g_varchar2_table(51) := '616B3B6361736522657175616C223A642E64656C656761746528632C652C6973457175616C48616E646C6572293B627265616B3B63617365227265676578223A642E64656C656761746528632C652C726567657848616E646C6572293B627265616B3B63';
wwv_flow_api.g_varchar2_table(52) := '61736522636861724C656E677468223A642E64656C656761746528632C652C636861724C656E67746848616E646C6572293B627265616B3B63617365226E756D62657253697A65223A642E64656C656761746528632C652C6E756D62657253697A654861';
wwv_flow_api.g_varchar2_table(53) := '6E646C6572293B627265616B3B6361736522646174654F72646572223A226368616E676522213D3D73657474696E67732E74726967676572696E674576656E74262628653D652B2220222B66292C642E64656C656761746528632C652C646174654F7264';
wwv_flow_api.g_varchar2_table(54) := '657248616E646C6572293B627265616B3B6361736522746F74616C436865636B6564223A642E64656C656761746528632C662C746F74616C436865636B656448616E646C6572297D72657475726E2061646456616C69646174696F6E4576656E7428622C';
wwv_flow_api.g_varchar2_table(55) := '65292C617D66756E6374696F6E2061646456616C69646174696F6E4576656E7428612C62297B76617220633D242861292C643D632E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E7473292C653D21313B766F69642030213D3D';
wwv_flow_api.g_varchar2_table(56) := '643F28242E6561636828642E73706C697428222022292C66756E6374696F6E28612C63297B633D3D3D62262628653D2130297D292C657C7C632E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E74732C642B2220222B6229293A';
wwv_flow_api.g_varchar2_table(57) := '632E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E74732C62297D66756E6374696F6E206973456D70747948616E646C657228297B76617220612C623D7365744D73672873657474696E67732E6572726F724D73672C2276616C';
wwv_flow_api.g_varchar2_table(58) := '756520726571756972656422293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E6E6F74456D707479436C61737329262628613D242874686973292E686173436C61737328636F6E7374616E74732E61706578436865636B';
wwv_flow_api.g_varchar2_table(59) := '626F78436C617373297C7C242874686973292E686173436C61737328636F6E7374616E74732E61706578526164696F436C617373293F2176616C696461746F72732E6D696E436865636B28242874686973292E66696E6428223A636865636B626F782C20';
wwv_flow_api.g_varchar2_table(60) := '3A726164696F22292C312C2131293A242874686973292E686173436C61737328636F6E7374616E74732E6170657853687574746C65436C617373293F21242874686973292E66696E64282273656C6563742E73687574746C655F726967687422292E6368';
wwv_flow_api.g_varchar2_table(61) := '696C6472656E28292E6C656E6774683A76616C696461746F72732E6973456D707479282253454C454354223D3D3D242874686973292E70726F7028227461674E616D6522297C7C2266696C65223D3D3D242874686973292E617474722822747970652229';
wwv_flow_api.g_varchar2_table(62) := '3F746869732E76616C75653A73657474696E67732E616C6C6F77576869746573706163653F746869732E76616C75653A7574696C2E7472696D28746869732E76616C756529292C6126267574696C2E676574436F6E646974696F6E526573756C74287365';
wwv_flow_api.g_varchar2_table(63) := '7474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6E6F74456D707479436C6173732C223022292C73686F774D65737361676528746869732C6229293A286164';
wwv_flow_api.g_varchar2_table(64) := '6456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6E6F74456D707479436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E206973457175616C48616E646C65722829';
wwv_flow_api.g_varchar2_table(65) := '7B76617220613D7365744D73672873657474696E67732E6572726F724D73672C2276616C75657320646F206E6F7420657175616C22293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E657175616C436C61737329262676';
wwv_flow_api.g_varchar2_table(66) := '616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E677468292626282176616C696461746F72732E6973457175616C28746869732E76616C75652C242873657474';
wwv_flow_api.g_varchar2_table(67) := '696E67732E657175616C292E76616C28292926267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E';
wwv_flow_api.g_varchar2_table(68) := '74732E657175616C436C6173732C223022292C73686F774D65737361676528746869732C6129293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E657175616C436C6173732C223122292C686964654D';
wwv_flow_api.g_varchar2_table(69) := '65737361676528746869732929297D66756E6374696F6E20726567657848616E646C657228297B76617220613D7365744D73672873657474696E67732E6572726F724D73672C22696E76616C69642076616C756522293B616C6C6F7756616C6964617469';
wwv_flow_api.g_varchar2_table(70) := '6F6E28746869732C636F6E7374616E74732E7265676578436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E677468292626282176616C69';
wwv_flow_api.g_varchar2_table(71) := '6461746F72732E726567657828746869732E76616C75652C73657474696E67732E72656765782926267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E52';
wwv_flow_api.g_varchar2_table(72) := '6573756C7428242874686973292C636F6E7374616E74732E7265676578436C6173732C223022292C73686F774D65737361676528746869732C6129293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E';
wwv_flow_api.g_varchar2_table(73) := '7265676578436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E206974656D5479706548616E646C657228297B76617220612C623B696628616C6C6F7756616C69646174696F6E28746869732C636F6E7374';
wwv_flow_api.g_varchar2_table(74) := '616E74732E6974656D54797065436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E67746829297B7377697463682873657474696E67732E';
wwv_flow_api.g_varchar2_table(75) := '6974656D54797065297B6361736522616C7068616E756D65726963223A613D76616C696461746F72732E6973416C7068616E756D6572696328746869732E76616C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F74';
wwv_flow_api.g_varchar2_table(76) := '20616E20616C7068616E756D657269632076616C756522293B627265616B3B63617365226E756D626572223A613D76616C696461746F72732E69734E756D62657228746869732E76616C75652C73657474696E67732E6E756D6572696343686172616374';
wwv_flow_api.g_varchar2_table(77) := '657273292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C6964206E756D62657222293B627265616B3B63617365226469676974223A613D76616C696461746F72732E6973446967697428746869732E7661';
wwv_flow_api.g_varchar2_table(78) := '6C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C696420646967697420636F6D62696E6174696F6E22293B627265616B3B6361736522656D61696C223A613D76616C696461746F72732E6973456D';
wwv_flow_api.g_varchar2_table(79) := '61696C28746869732E76616C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C696420652D6D61696C206164647265737322293B627265616B3B636173652275726C223A613D76616C696461746F72';
wwv_flow_api.g_varchar2_table(80) := '732E697355726C28746869732E76616C7565292C623D7365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C69642055524C22293B627265616B3B636173652264617465223A613D76616C696461746F72732E69734461';
wwv_flow_api.g_varchar2_table(81) := '746528746869732E76616C75652C73657474696E67732E64617465466F726D6174292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C226E6F7420612076616C69642064617465202826312922';
wwv_flow_api.g_varchar2_table(82) := '292C73657474696E67732E64617465466F726D6174297D216126267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C';
wwv_flow_api.g_varchar2_table(83) := '636F6E7374616E74732E6974656D54797065436C6173732C223022292C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6974656D54797065436C61';
wwv_flow_api.g_varchar2_table(84) := '73732C223122292C686964654D657373616765287468697329297D7D66756E6374696F6E20636861724C656E67746848616E646C657228297B76617220612C623B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E63686172';
wwv_flow_api.g_varchar2_table(85) := '4C656E677468436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E6774682926262876616C696461746F72732E6973456D70747928736574';
wwv_flow_api.g_varchar2_table(86) := '74696E67732E6D6178293F28613D76616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E6D696E292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73';
wwv_flow_api.g_varchar2_table(87) := '672C2276616C7565206C656E67746820746F6F2073686F7274202D206D696E2E20263122292C73657474696E67732E6D696E29293A76616C696461746F72732E6973456D7074792873657474696E67732E6D696E293F28613D76616C696461746F72732E';
wwv_flow_api.g_varchar2_table(88) := '6D61784C656E67746828746869732E76616C75652C73657474696E67732E6D6178292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C2276616C7565206C656E67746820746F6F206C6F6E6720';
wwv_flow_api.g_varchar2_table(89) := '2D206D61782E20263122292C73657474696E67732E6D617829293A28613D76616C696461746F72732E72616E67654C656E67746828746869732E76616C75652C73657474696E67732E6D696E2C73657474696E67732E6D6178292C623D7265706C616365';
wwv_flow_api.g_varchar2_table(90) := '4D736756617273287365744D73672873657474696E67732E6572726F724D73672C22696E76616C69642076616C7565206C656E677468202D206265747765656E20263120616E64202632206F6E6C7922292C73657474696E67732E6D696E2C7365747469';
wwv_flow_api.g_varchar2_table(91) := '6E67732E6D617829292C216126267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E636861';
wwv_flow_api.g_varchar2_table(92) := '724C656E677468436C6173732C223022292C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E636861724C656E677468436C6173732C223122292C68';
wwv_flow_api.g_varchar2_table(93) := '6964654D65737361676528746869732929297D66756E6374696F6E206E756D62657253697A6548616E646C657228297B76617220612C622C633D7574696C2E6765744E756D62657246726F6D537472696E6728746869732E76616C7565292C643D757469';
wwv_flow_api.g_varchar2_table(94) := '6C2E6765744E756D62657246726F6D537472696E67287574696C2E676574506167654974656D56616C75652873657474696E67732E6D696E29292C653D7574696C2E6765744E756D62657246726F6D537472696E67287574696C2E676574506167654974';
wwv_flow_api.g_varchar2_table(95) := '656D56616C75652873657474696E67732E6D617829293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E6E756D62657253697A65436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E7661';
wwv_flow_api.g_varchar2_table(96) := '6C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E6774682926262876616C696461746F72732E6973456D7074792873657474696E67732E6D6178293F28613D76616C696461746F72732E6D696E4E756D62657228632C642C736574';
wwv_flow_api.g_varchar2_table(97) := '74696E67732E6E756D6572696343686172616374657273292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C226E756D62657220746F6F20736D616C6C202D206D696E2E20263122292C642929';
wwv_flow_api.g_varchar2_table(98) := '3A76616C696461746F72732E6973456D7074792873657474696E67732E6D696E293F28613D76616C696461746F72732E6D61784E756D62657228632C652C73657474696E67732E6E756D6572696343686172616374657273292C623D7265706C6163654D';
wwv_flow_api.g_varchar2_table(99) := '736756617273287365744D73672873657474696E67732E6572726F724D73672C226E756D62657220746F6F206C61726765202D206D61782E20263122292C6529293A28613D76616C696461746F72732E72616E67654E756D62657228632C642C652C7365';
wwv_flow_api.g_varchar2_table(100) := '7474696E67732E6E756D6572696343686172616374657273292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22696E76616C6964206E756D6265722073697A65202D206265747765656E2026';
wwv_flow_api.g_varchar2_table(101) := '3120616E64202632206F6E6C7922292C642C6529292C216126267574696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C63';
wwv_flow_api.g_varchar2_table(102) := '6F6E7374616E74732E6E756D62657253697A65436C6173732C223022292C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E6E756D62657253697A65';
wwv_flow_api.g_varchar2_table(103) := '436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E20746F74616C436865636B656448616E646C657228297B76617220612C622C633D242874686973292E66696E6428223A636865636B626F782C203A7261';
wwv_flow_api.g_varchar2_table(104) := '64696F22293B616C6C6F7756616C69646174696F6E28746869732C636F6E7374616E74732E746F74616C436865636B6564436C6173732926262876616C696461746F72732E6973456D7074792873657474696E67732E6D6178293F28613D76616C696461';
wwv_flow_api.g_varchar2_table(105) := '746F72732E6D696E436865636B28632C73657474696E67732E6D696E2C2130292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22706C656173652073656C656374206174206C656173742026';
wwv_flow_api.g_varchar2_table(106) := '312063686F69636528732922292C73657474696E67732E6D696E29293A76616C696461746F72732E6973456D7074792873657474696E67732E6D696E293F28613D76616C696461746F72732E6D6178436865636B28632C73657474696E67732E6D617829';
wwv_flow_api.g_varchar2_table(107) := '2C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22706C656173652073656C656374206E6F206D6F7265207468616E2026312063686F69636528732922292C73657474696E67732E6D61782929';
wwv_flow_api.g_varchar2_table(108) := '3A28613D76616C696461746F72732E72616E6765436865636B28632C73657474696E67732E6D696E2C73657474696E67732E6D6178292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C22706C';
wwv_flow_api.g_varchar2_table(109) := '656173652073656C656374206265747765656E20263120616E642026322063686F69636528732922292C73657474696E67732E6D696E2C73657474696E67732E6D617829292C216126267574696C2E676574436F6E646974696F6E526573756C74287365';
wwv_flow_api.g_varchar2_table(110) := '7474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E746F74616C436865636B6564436C6173732C223022292C73686F774D65737361676528746869732C622929';
wwv_flow_api.g_varchar2_table(111) := '3A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E746F74616C436865636B6564436C6173732C223122292C686964654D65737361676528746869732929297D66756E6374696F6E20646174654F726465';
wwv_flow_api.g_varchar2_table(112) := '7248616E646C657228297B76617220612C622C633D7574696C2E676574506167654974656D56616C75652873657474696E67732E6D696E292C643D7574696C2E676574506167654974656D56616C75652873657474696E67732E6D6178293B616C6C6F77';
wwv_flow_api.g_varchar2_table(113) := '56616C69646174696F6E28746869732C636F6E7374616E74732E646174654F72646572436C61737329262676616C696461746F72732E6D696E4C656E67746828746869732E76616C75652C73657474696E67732E76616C69646174696F6E4D696E4C656E';
wwv_flow_api.g_varchar2_table(114) := '6774682926262876616C696461746F72732E6973456D7074792873657474696E67732E6D6178293F28613D76616C696461746F72732E6D696E4461746528746869732E76616C75652C632C73657474696E67732E64617465466F726D6174292C623D7265';
wwv_flow_api.g_varchar2_table(115) := '706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C227468697320646174652073686F756C64206C696520616674657220263122292C6329293A76616C696461746F72732E6973456D7074792873657474696E';
wwv_flow_api.g_varchar2_table(116) := '67732E6D696E293F28613D76616C696461746F72732E6D61784461746528746869732E76616C75652C642C73657474696E67732E64617465466F726D6174292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E657272';
wwv_flow_api.g_varchar2_table(117) := '6F724D73672C227468697320646174652073686F756C64206C6965206265666F726520263122292C6429293A28613D76616C696461746F72732E72616E67654461746528746869732E76616C75652C632C642C73657474696E67732E64617465466F726D';
wwv_flow_api.g_varchar2_table(118) := '6174292C623D7265706C6163654D736756617273287365744D73672873657474696E67732E6572726F724D73672C227468697320646174652073686F756C64206C6965206265747765656E20263120616E6420263222292C632C6429292C216126267574';
wwv_flow_api.g_varchar2_table(119) := '696C2E676574436F6E646974696F6E526573756C742873657474696E67732E636F6E646974696F6E293F2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E646174654F72646572436C6173732C22302229';
wwv_flow_api.g_varchar2_table(120) := '2C73686F774D65737361676528746869732C6229293A2861646456616C69646174696F6E526573756C7428242874686973292C636F6E7374616E74732E646174654F72646572436C6173732C223122292C686964654D6573736167652874686973292929';
wwv_flow_api.g_varchar2_table(121) := '7D66756E6374696F6E2073686F774D65737361676528612C62297B76617220633D242861292C643D273C7370616E20636C6173733D22272B636F6E7374616E74732E6572726F724D7367436C6173732B2220222B612E69642B27223E272B622B223C2F73';
wwv_flow_api.g_varchar2_table(122) := '70616E3E223B696628632E686173436C61737328636F6E7374616E74732E6974656D4572726F72436C61737329297B76617220653D2428227370616E2E222B636F6E7374616E74732E6572726F724D7367436C6173732B222E222B612E6964292C663D65';
wwv_flow_api.g_varchar2_table(123) := '2E696E64657828292C673D632E696E64657828293B673E662626226265666F7265223D3D3D73657474696E67732E6572726F724D73674C6F636174696F6E3F652E746578742862293A673E662626226166746572223D3D3D73657474696E67732E657272';
wwv_flow_api.g_varchar2_table(124) := '6F724D73674C6F636174696F6E3F28652E72656D6F766528292C632E6166746572286429293A663E672626226166746572223D3D3D73657474696E67732E6572726F724D73674C6F636174696F6E3F652E746578742862293A28652E72656D6F76652829';
wwv_flow_api.g_varchar2_table(125) := '2C632E6265666F7265286429297D656C736520632E616464436C61737328636F6E7374616E74732E6974656D4572726F72436C617373292C2428225B666F723D222B612E69642B225D22292E616464436C61737328636F6E7374616E74732E6C6162656C';
wwv_flow_api.g_varchar2_table(126) := '4572726F72436C617373292C226265666F7265223D3D3D73657474696E67732E6572726F724D73674C6F636174696F6E3F632E6265666F72652864293A632E61667465722864297D66756E6374696F6E20686964654D6573736167652861297B76617220';
wwv_flow_api.g_varchar2_table(127) := '623D242861293B622E686173436C61737328636F6E7374616E74732E6974656D4572726F72436C61737329262628622E72656D6F7665436C61737328636F6E7374616E74732E6974656D4572726F72436C617373292C2428225B666F723D222B612E6964';
wwv_flow_api.g_varchar2_table(128) := '2B225D22292E72656D6F7665436C61737328636F6E7374616E74732E6C6162656C4572726F72436C617373292C2428227370616E2E222B636F6E7374616E74732E6572726F724D7367436C6173732B222E222B612E6964292E72656D6F76652829297D66';
wwv_flow_api.g_varchar2_table(129) := '756E6374696F6E207365744D736728612C62297B72657475726E2076616C696461746F72732E6973456D7074792861293F623A617D66756E6374696F6E207265706C6163654D7367566172732861297B666F722876617220623D612C633D312C643D6172';
wwv_flow_api.g_varchar2_table(130) := '67756D656E74732E6C656E6774683B643E633B632B2B29623D622E7265706C616365282226222B632C617267756D656E74735B635D293B72657475726E20627D66756E6374696F6E20616C6C6F7756616C69646174696F6E28612C62297B76617220633D';
wwv_flow_api.g_varchar2_table(131) := '21302C643D242861292C653D642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C7473293B72657475726E20766F69642030213D3D652626282D313D3D3D652E696E6465784F662862293F242E6561636828652E73706C6974';
wwv_flow_api.g_varchar2_table(132) := '28222022292C66756E6374696F6E28612C62297B633D3D3D21302626223122213D3D622E736C696365282D3129262628633D2131297D293A642E72656D6F76654461746128636F6E7374616E74732E76616C69646174696F6E526573756C747329292C63';
wwv_flow_api.g_varchar2_table(133) := '7D66756E6374696F6E2061646456616C69646174696F6E526573756C7428612C622C63297B76617220643D242861292C653D642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C7473292C663D21312C673D622B223A222B63';
wwv_flow_api.g_varchar2_table(134) := '3B766F69642030213D3D653F28242E6561636828652E73706C697428222022292C66756E6374696F6E28612C67297B696628672E73756273747228302C672E696E6465784F6628223A2229293D3D3D62297B76617220683D652E696E6465784F66286729';
wwv_flow_api.g_varchar2_table(135) := '2B672E6C656E6774682D313B653D7574696C2E7265706C61636543686172496E537472696E6728652C682C63292C642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C74732C65292C663D21307D7D292C667C7C642E646174';
wwv_flow_api.g_varchar2_table(136) := '6128636F6E7374616E74732E76616C69646174696F6E526573756C74732C652B2220222B6729293A642E6461746128636F6E7374616E74732E76616C69646174696F6E526573756C74732C67292C2231223D3D3D633F2873657474696E67732E6974656D';
wwv_flow_api.g_varchar2_table(137) := '537563636573732E63616C6C2874686973292C642E747269676765722822616C766974656D737563636573732229293A2873657474696E67732E6974656D4661696C2E63616C6C2874686973292C642E747269676765722822616C766974656D6661696C';
wwv_flow_api.g_varchar2_table(138) := '2229297D66756E6374696F6E20666F726D4861734572726F72732861297B76617220622C633D21312C643D242861292E66696E642822696E7075742C2074657874617265612C2073656C6563742C206669656C6473657422293B72657475726E20242E65';
wwv_flow_api.g_varchar2_table(139) := '61636828642C66756E6374696F6E28297B623D242874686973292C766F69642030213D3D622E6461746128636F6E7374616E74732E76616C69646174696F6E4576656E7473292626242E6561636828622E6461746128636F6E7374616E74732E76616C69';
wwv_flow_api.g_varchar2_table(140) := '646174696F6E4576656E7473292E73706C697428222022292C66756E6374696F6E28612C63297B622E747269676765722863297D297D292C642E686173436C61737328636F6E7374616E74732E6974656D4572726F72436C61737329262628242864292E';
wwv_flow_api.g_varchar2_table(141) := '66696C74657228222E222B636F6E7374616E74732E6974656D4572726F72436C617373292E666972737428292E666F63757328292C633D2130292C637D66756E6374696F6E2076616C6964617465466F726D4265666F72655375626D6974287046697269';
wwv_flow_api.g_varchar2_table(142) := '6E67456C656D297B76617220666972696E67456C656D3D242870466972696E67456C656D292C6F726967436C69636B4576656E742C6669784572726F72734D73673D7365744D73672873657474696E67732E6572726F724D73672C22506C656173652066';
wwv_flow_api.g_varchar2_table(143) := '697820616C6C206572726F7273206265666F726520636F6E74696E75696E6722292C626F6479456C656D3D242822626F647922292C6D657373616765426F7849643D2223616C762D6D73672D626F78222C6D7367426F783D273C64697620636C6173733D';
wwv_flow_api.g_varchar2_table(144) := '22616C762D616C6572742D6D7367223E3C6120687265663D22232220636C6173733D22616C762D636C6F736522206F6E636C69636B3D2224285C27272B6D657373616765426F7849642B2227292E6368696C6472656E28292E666164654F757428293B72';
wwv_flow_api.g_varchar2_table(145) := '657475726E2066616C73653B5C223E783C2F613E3C703E222B6669784572726F72734D73672B223C2F703E3C2F6469763E223B666972696E67456C656D2E6C656E6774682626282241223D3D3D666972696E67456C656D2E70726F7028227461674E616D';
wwv_flow_api.g_varchar2_table(146) := '6522293F286F726967436C69636B4576656E743D666972696E67456C656D2E6174747228226872656622292C666972696E67456C656D2E6461746128636F6E7374616E74732E6F726967436C69636B4576656E742C6F726967436C69636B4576656E7429';
wwv_flow_api.g_varchar2_table(147) := '2C666972696E67456C656D2E72656D6F7665417474722822687265662229293A286F726967436C69636B4576656E743D666972696E67456C656D2E6174747228226F6E636C69636B22292C666972696E67456C656D2E6461746128636F6E7374616E7473';
wwv_flow_api.g_varchar2_table(148) := '2E6F726967436C69636B4576656E742C6F726967436C69636B4576656E74292C666972696E67456C656D2E72656D6F76654174747228226F6E636C69636B2229292C626F6479456C656D2E64656C6567617465282223222B666972696E67456C656D2E61';
wwv_flow_api.g_varchar2_table(149) := '7474722822696422292C22636C69636B222C66756E6374696F6E28297B666F726D4861734572726F72732873657474696E67732E666F726D73546F5375626D6974293F2873657474696E67732E666F726D4661696C2E63616C6C2874686973292C666972';
wwv_flow_api.g_varchar2_table(150) := '696E67456C656D2E747269676765722822616C76666F726D6661696C22292C24286D657373616765426F784964292E6C656E6774687C7C626F6479456C656D2E617070656E6428273C6469762069643D22272B6D657373616765426F7849642E73756273';
wwv_flow_api.g_varchar2_table(151) := '7472696E672831292B27223E3C2F6469763E27292C24286D657373616765426F784964292E68746D6C286D7367426F7829293A2873657474696E67732E666F726D537563636573732E63616C6C2874686973292C666972696E67456C656D2E7472696767';
wwv_flow_api.g_varchar2_table(152) := '65722822616C76666F726D7375636365737322292C6576616C28242874686973292E6461746128636F6E7374616E74732E6F726967436C69636B4576656E742929297D29297D76617220636F6E7374616E74733D7B706C7567696E49643A2262652E6374';
wwv_flow_api.g_varchar2_table(153) := '622E6A712E616C76222C706C7567696E4E616D653A2241504558204C6976652056616C69646174696F6E222C706C7567696E5072656669783A22616C76222C61706578436865636B626F78436C6173733A22636865636B626F785F67726F7570222C6170';
wwv_flow_api.g_varchar2_table(154) := '6578526164696F436C6173733A22726164696F5F67726F7570222C6170657853687574746C65436C6173733A2273687574746C65222C61706578446174657069636B6572436C6173733A22646174657069636B6572227D3B242E657874656E6428636F6E';
wwv_flow_api.g_varchar2_table(155) := '7374616E74732C7B76616C69646174696F6E4576656E74733A636F6E7374616E74732E706C7567696E5072656669782B222D76616C4576656E7473222C76616C69646174696F6E526573756C74733A636F6E7374616E74732E706C7567696E5072656669';
wwv_flow_api.g_varchar2_table(156) := '782B222D76616C526573756C7473222C6F726967436C69636B4576656E743A636F6E7374616E74732E706C7567696E5072656669782B222D6F726967436C69636B4576656E74222C6E6F74456D707479436C6173733A636F6E7374616E74732E706C7567';
wwv_flow_api.g_varchar2_table(157) := '696E5072656669782B222D6E6F74456D707479222C6974656D54797065436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D6974656D54797065222C657175616C436C6173733A636F6E7374616E74732E706C7567696E507265';
wwv_flow_api.g_varchar2_table(158) := '6669782B222D657175616C222C7265676578436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D7265676578222C636861724C656E677468436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D636861';
wwv_flow_api.g_varchar2_table(159) := '724C656E677468222C6E756D62657253697A65436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D6E756D62657253697A65222C646174654F72646572436C6173733A636F6E7374616E74732E706C7567696E5072656669782B';
wwv_flow_api.g_varchar2_table(160) := '222D646174654F72646572222C746F74616C436865636B6564436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D746F74616C436865636B6564222C6974656D4572726F72436C6173733A636F6E7374616E74732E706C756769';
wwv_flow_api.g_varchar2_table(161) := '6E5072656669782B222D6974656D2D6572726F72222C6C6162656C4572726F72436C6173733A636F6E7374616E74732E706C7567696E5072656669782B222D6C6162656C2D6572726F72222C6572726F724D7367436C6173733A636F6E7374616E74732E';
wwv_flow_api.g_varchar2_table(162) := '706C7567696E5072656669782B222D6572726F722D6D7367227D293B7661722073657474696E67733D7B76616C69646174653A226E6F74456D707479222C74726967676572696E674576656E743A22626C7572222C636F6E646974696F6E3A22222C7661';
wwv_flow_api.g_varchar2_table(163) := '6C69646174696F6E4D696E4C656E6774683A302C6572726F724D73673A22222C6572726F724D73674C6F636174696F6E3A226166746572222C616C6C6F77576869746573706163653A21302C6974656D547970653A22222C64617465466F726D61743A22';
wwv_flow_api.g_varchar2_table(164) := '222C6E756D65726963436861726163746572733A22222C6D696E3A22222C6D61783A22222C657175616C3A22222C72656765783A22222C666F726D73546F5375626D69743A22222C6974656D537563636573733A66756E6374696F6E28297B7D2C697465';
wwv_flow_api.g_varchar2_table(165) := '6D4661696C3A66756E6374696F6E28297B7D2C666F726D537563636573733A66756E6374696F6E28297B7D2C666F726D4661696C3A66756E6374696F6E28297B7D7D2C6D6574686F64733D7B696E69743A66756E6374696F6E2861297B76617220623D24';
wwv_flow_api.g_varchar2_table(166) := '2874686973293B62696E6453657474696E677328622C61292C696E69742862297D2C76616C6964617465466F726D3A66756E6374696F6E2861297B76617220623D242874686973293B62696E6453657474696E677328622C61292C76616C696461746546';
wwv_flow_api.g_varchar2_table(167) := '6F726D4265666F72655375626D69742862297D2C72656D6F76653A66756E6374696F6E28297B76617220613D242874686973293B726573746F7265506C7567696E53657474696E677328612926266D6574686F6428297D7D3B72657475726E2024287468';
wwv_flow_api.g_varchar2_table(168) := '6973292E656163682866756E6374696F6E28297B72657475726E206D6574686F64735B6D6574686F645D3F6D6574686F64735B6D6574686F645D2E63616C6C28242874686973292C6F7074696F6E73293A226F626A65637422213D747970656F66206D65';
wwv_flow_api.g_varchar2_table(169) := '74686F6426266D6574686F643F28242E6572726F7228224D6574686F6420222B6D6574686F642B2220646F6573206E6F74206578697374206F6E206A51756572792E20222B636F6E7374616E74732E706C7567696E4E616D65292C2131293A6D6574686F';
wwv_flow_api.g_varchar2_table(170) := '64732E696E69742E63616C6C28242874686973292C6D6574686F64297D297D7D286A51756572792C616C762E7574696C2C616C762E76616C696461746F7273293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(247732580849949934)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_file_name=>'jquery.alv.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '696E7075742E616C762D6974656D2D6572726F722C0A74657874617265612E616C762D6974656D2D6572726F722C0A73656C6563742E616C762D6974656D2D6572726F727B626F726465723A31707820736F6C696420236239346134383B6261636B6772';
wwv_flow_api.g_varchar2_table(2) := '6F756E642D636F6C6F723A236635656165613B7D0A2E616C762D6C6162656C2D6572726F727B636F6C6F723A236239346134383B7D0A2E616C762D6572726F722D6D73677B646973706C61793A626C6F636B3B636F6C6F723A236239346134383B666F6E';
wwv_flow_api.g_varchar2_table(3) := '742D73697A653A313370783B6C696E652D6865696768743A323070783B666F6E742D73697A653A312E3172656D3B6C696E652D6865696768743A312E3672656D3B646973706C61793A626C6F636B3B6D617267696E2D746F703A3470783B2D7765626B69';
wwv_flow_api.g_varchar2_table(4) := '742D666C65782D62617369733A313030253B2D6D732D666C65782D7072656665727265642D73697A653A313030253B666C65782D62617369733A313030253B2D7765626B69742D6F726465723A353B2D6D732D666C65782D6F726465723A353B6F726465';
wwv_flow_api.g_varchar2_table(5) := '723A353B7D0A23616C762D6D73672D626F787B706F736974696F6E3A66697865643B746F703A303B6C6566743A3530253B77696474683A36303070783B6D617267696E2D6C6566743A2D33303070783B6D696E2D6865696768743A303B626F726465723A';
wwv_flow_api.g_varchar2_table(6) := '303B7A2D696E6465783A393939393B7D0A2E616C762D616C6572742D6D73677B6261636B67726F756E642D636F6C6F723A236632646564653B636F6C6F723A236239346134383B746578742D736861646F773A302031707820302072676261283235352C';
wwv_flow_api.g_varchar2_table(7) := '203235352C203235352C20302E35293B626F726465723A31707820736F6C696420236565643364373B70616464696E673A313470782033357078203134707820313470783B2D7765626B69742D626F726465722D7261646975733A302030203470782034';
wwv_flow_api.g_varchar2_table(8) := '70783B2D6D6F7A2D626F726465722D7261646975733A30203020347078203470783B626F726465722D7261646975733A30203020347078203470783B626F782D736861646F773A302032707820357078207267626128302C20302C20302C20302E31293B';
wwv_flow_api.g_varchar2_table(9) := '7D0A2E616C762D636C6F73657B666C6F61743A72696768743B706F736974696F6E3A72656C61746976653B746F703A2D3270783B72696768743A2D323170783B666F6E742D73697A653A313670783B666F6E742D7765696768743A626F6C643B6C696E65';
wwv_flow_api.g_varchar2_table(10) := '2D6865696768743A323070783B636F6C6F723A233030303030303B746578742D6465636F726174696F6E3A6E6F6E653B746578742D736861646F773A3020317078203020236666666666663B6F7061636974793A2E323B66696C7465723A616C70686128';
wwv_flow_api.g_varchar2_table(11) := '6F7061636974793D3230293B7D0A2E616C762D636C6F73653A686F7665727B636F6C6F723A233030303030303B746578742D6465636F726174696F6E3A6E6F6E653B6F7061636974793A2E353B66696C7465723A616C706861286F7061636974793D3530';
wwv_flow_api.g_varchar2_table(12) := '293B7D0A2E616C762D616C6572742D6D736720707B666F6E742D73697A653A313670783B666F6E742D7765696768743A626F6C643B6C696E652D6865696768743A323070783B6D617267696E3A303B7D0A406D6564696120286D61782D77696474683A39';
wwv_flow_api.g_varchar2_table(13) := '37397078297B23616C762D6D73672D626F787B77696474683A34303070783B6D617267696E2D6C6566743A2D32303070783B7D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(566568763433748735)
,p_plugin_id=>wwv_flow_api.id(564406701023238513)
,p_file_name=>'style.alv.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
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
