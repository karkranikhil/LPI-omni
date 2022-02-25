let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"DataRaptor","value":{"bundle":"mtxlpi_dr_fetchContinuingEducation_Renewal","dsDelay":0,"inputMap":{"applicationId":"{Parent.appId}"},"resultVar":""}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","stateAction":{"eventName":"reload","id":"flex-action-1631012011399","type":"cardAction"}},"channelname":"mtxlpi_fc_ContEduTableRowData_RenewalBnc","displayLabel":"mtxlpi_fc_ContEduTableRowData_RenewalBnc:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-0","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1625761737879","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchContinuingEducation_Renewal\",\"inputMap\":{\"applicationId\":\"{Parent.appId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.appId\",\"val\":\"\",\"id\":24}]}","type":"cardAction"}},"channelname":"pubsubreload","displayLabel":"pubsubreload:creload","element":"action","eventLabel":"pubsub","eventname":"creload","eventtype":"pubsub","key":"event-1","recordIndex":""}],"isFlex":true,"lwc":{"DeveloperName":"cfMtxlpi_fc_ContEduTableRowData_RenewalBnc_2_NM","Id":"0Rbr0000000LNXdCAO","ManageableState":"unmanaged","MasterLabel":"cfMtxlpi_fc_ContEduTableRowData_RenewalBnc_2_NM","NamespacePrefix":"c"},"osSupport":true,"sessionVars":[],"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Description","key":"element_element_block_0_0_outputField_0_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"Description","placeholder":"","record":"{record}","type":"text"},"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small tble_content","container":{"class":""},"customClass":"tble_content","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"CompletionDateCont","key":"element_element_block_0_0_outputField_1_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"CompletionDateCont","format":"MM/DD/YYYY","placeholder":"","record":"{record}","type":"date"},"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small tble_content","container":{"class":""},"customClass":"tble_content","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"TotalCEU","key":"element_element_block_0_0_outputField_2_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"TotalCEU","format":"M/D/YYYY","placeholder":"","record":"{record}","type":"text"},"size":{"default":"1","isResponsive":false,"large":"2","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small tble_content","container":{"class":""},"customClass":"tble_content","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"1","isResponsive":false,"large":"2","medium":"12","small":"12"},"sizeClass":"slds-size_1-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"Type","key":"element_element_block_0_0_outputField_3_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"Type","placeholder":"","record":"{record}","type":"text"},"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small tble_content","container":{"class":""},"customClass":"tble_content","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"TableDataRow-Field-4-clone-0","key":"element_element_block_0_0_outputField_4_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"TypeCode","placeholder":"","record":"{record}","type":"text"},"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small tble_content","container":{"class":""},"customClass":"tble_content","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"ProviderName","key":"element_element_block_0_0_outputField_5_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"ProviderName","placeholder":"","record":"{record}","type":"text"},"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small tble_content","container":{"class":""},"customClass":"tble_content","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false,"large":"2","medium":"12","small":"12"},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"action","elementLabel":"TableDataRow-Action-6","key":"element_element_block_0_0_action_6_0","name":"Action","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"Parent.mode","id":"state-new-condition-2","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"iconColor":"#EA0808","iconOnly":true,"record":"{record}","stateAction":{"displayName":"Delete","flyoutLwc":"b-c-d-delete-cont-education_-renewal-english","flyoutParams":{"ContextId":"{ContinuingEducationId}","vlocEvents":"mtxlpi_fc_ContEduTableRowData_RenewalBnc,mtxlpi_fc_calculateTotalCEU_Renewal"},"flyoutType":"OmniScripts","hasExtraParams":true,"id":"flex-action-1636620832577","layoutType":"lightning","openFlyoutIn":"Modal","openUrlIn":"Current Window","osName":"BCD/deleteContEducation_Renewal/English","type":"Flyout","vlocityIcon":"utility:delete"},"stateObj":"{record}"},"size":{"default":1,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"container":{"class":""},"elementStyleProperties":{"iconColor":"#EA0808"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":1,"isResponsive":false},"sizeClass":"slds-size_1-of-12","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"container":{"class":""},"elementStyleProperties":{"iconColor":"#EA0808"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":1,"isResponsive":false},"sizeClass":"slds-size_1-of-12","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"TableDataRow","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"ContinuingEducationId","id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small table_bordered mobile_view_container","container":{"class":""},"customClass":"table_bordered mobile_view_container","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"block","userUpdatedElementLabel":true}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"TableRow","omniscripts":[{"language":"English","subtype":"deleteContEducation_Renewal","type":"BCD"}],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"mtxlpi_fc_ContEduTableRowData_RenewalBnc","tracking":{"customFields":[]},"Id":"a6H5f000000LRQoEAO","vlocity_ins__GlobalKey__c":"mtxlpi_fc_ContEduTableRowData_RenewalBnc/NM/2/1636620369824"};
  export default definition