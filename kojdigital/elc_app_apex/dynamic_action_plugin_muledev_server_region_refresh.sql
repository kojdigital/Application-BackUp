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
prompt --application/shared_components/plugins/dynamic_action/muledev_server_region_refresh
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(541830516644934926)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'MULEDEV.SERVER_REGION_REFRESH'
,p_display_name=>'Execute PL/SQL Code and Return Content'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_it (',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'as',
'  l_js                    varchar2(32000);',
'  l_element_name          varchar2(4000) := p_dynamic_action.attribute_02;',
'  l_page_items_to_submit  varchar2(4000) := p_dynamic_action.attribute_03;',
'  l_interval              number := nvl(p_dynamic_action.attribute_04,0) * 1000;',
'  l_mode                  varchar2(255) := p_dynamic_action.attribute_05;',
'  l_js_callback           varchar2(4000) := p_dynamic_action.attribute_07;',
'  l_returnvalue           apex_plugin.t_dynamic_action_render_result;',
'begin',
'',
'',
'  l_js := ''function muledev_server_region_refresh() {',
'  ',
'    var lAjaxIdentifier = this.action.ajaxIdentifier;',
'    var lElementName = this.action.attribute02;',
'    var lPageItemsToSubmit = this.action.attribute03;',
'    var lInterval = parseInt(this.action.attribute04);',
'    var lMode = this.action.attribute05;',
'    ',
'    muledev_server_region_do_refresh (lAjaxIdentifier, lElementName, lPageItemsToSubmit, lInterval, lMode);',
'  ',
'  }',
'  ',
'  ',
'  function muledev_server_region_do_refresh (pAjaxIdentifier, pElementName, pPageItemsToSubmit, pInterval, pMode) {',
'',
'    var lAjaxRequest = new htmldb_Get(null, $v("pFlowId"), "PLUGIN=" + pAjaxIdentifier, $v("pFlowStepId"));',
'',
'    if (pPageItemsToSubmit != null) {',
'      apex.jQuery.each(',
'        pPageItemsToSubmit.split(","),',
'        function() {',
'          var lPageItem = apex.jQuery("#"+this)[0];',
'          if (lPageItem) {',
'            lAjaxRequest.add(this, $v(lPageItem));',
'          }',
'        }',
'      );',
'    }',
'',
'    lAjaxRequest.GetAsync (function (){',
'  ',
'      //alert(p.readyState); ',
'    ',
'     if(p.readyState == 1){ ',
'      }',
'      else if(p.readyState == 2){ ',
'      }',
'      else if(p.readyState == 3){ ',
'      }',
'      else if(p.readyState == 4){ ',
'        if (pMode == "APPEND_BEFORE") {',
'          $x(pElementName).innerHTML = p.responseText + $x(pElementName).innerHTML; ',
'        }',
'        else if (pMode == "APPEND_AFTER") {',
'          $x(pElementName).innerHTML = $x(pElementName).innerHTML + p.responseText; ',
'        }',
'        else {',
'          $x(pElementName).innerHTML = p.responseText; ',
'        }',
'      '' || l_js_callback || ''',
'      }',
'      else {return false;} ',
'    });',
'',
'  lAjaxRequest = null;',
'  ',
'  if (pInterval > 0) {',
'    setTimeout (function () {',
'      muledev_server_region_do_refresh(pAjaxIdentifier, pElementName, pPageItemsToSubmit, pInterval, pMode);',
'      }, pInterval);',
'',
'    }',
'  ',
'  }'';',
'',
'',
'  apex_javascript.add_inline_code (l_js, p_key => ''muledev_server_region_refresh'');',
'',
'  l_returnvalue.javascript_function := ''muledev_server_region_refresh'';',
'  l_returnvalue.ajax_identifier     := wwv_flow_plugin.get_ajax_identifier;',
'  l_returnvalue.attribute_01 := null; -- we don''t want to expose the PL/SQL source/statement to the client',
'  l_returnvalue.attribute_02 := l_element_name;',
'  l_returnvalue.attribute_03 := l_page_items_to_submit;',
'  l_returnvalue.attribute_04 := l_interval;',
'  l_returnvalue.attribute_05 := l_mode;',
'',
'  return l_returnvalue;',
'',
'end render_it;',
'',
'',
'function ajax_it (',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_ajax_result',
'as',
'  l_source      varchar2(32000) := p_dynamic_action.attribute_01;',
'  l_errmsg      varchar2(4000) := p_dynamic_action.attribute_06;',
'  l_returnvalue apex_plugin.t_dynamic_action_ajax_result;',
'begin',
'',
'  begin',
'    apex_plugin_util.execute_plsql_code (l_source);',
'  exception',
'    when others then',
'      htp.p(coalesce(l_errmsg, sqlerrm));',
'  end;',
'',
'  return l_returnvalue;',
'',
'end ajax_it;'))
,p_api_version=>1
,p_render_function=>'render_it'
,p_ajax_function=>'ajax_it'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(541830690802936948)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'PL/SQL Source'
,p_attribute_type=>'PLSQL'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(541831196689938723)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Page Element (DIV)'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(541831702576940353)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Page item(s) to submit'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(541838614809202375)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Interval (seconds)'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_default_value=>'0'
,p_is_translatable=>false
,p_help_text=>'Enter 0 for no interval.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(541865415652543542)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'REPLACE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(541866218422544362)
,p_plugin_attribute_id=>wwv_flow_api.id(541865415652543542)
,p_display_sequence=>10
,p_display_value=>'Replace'
,p_return_value=>'REPLACE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(541866590502545786)
,p_plugin_attribute_id=>wwv_flow_api.id(541865415652543542)
,p_display_sequence=>20
,p_display_value=>'Append after'
,p_return_value=>'APPEND_AFTER'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(541866992580546380)
,p_plugin_attribute_id=>wwv_flow_api.id(541865415652543542)
,p_display_sequence=>30
,p_display_value=>'Append before'
,p_return_value=>'APPEND_BEFORE'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(541868098252557409)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Error message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_help_text=>'Leave blank to return SQLERRM as error message.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(545840494314810101)
,p_plugin_id=>wwv_flow_api.id(541830516644934926)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Javascript Callback'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Specify a piece of Javascript code to be run when the PL/SQL (Ajax) call completes.'
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
