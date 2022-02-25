let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"DataRaptor","value":{"bundle":"mtxlpi_dr_GetRelatedLicenseForApplication","dsDelay":0,"inputMap":{"ApplicationId":"{Parent.applicationId}","recordType":"Employee"},"resultVar":""}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1638182829577","message":"{\"type\":\"DataRaptor\",\"value\":{\"dsDelay\":0,\"bundle\":\"mtxlpi_dr_GetRelatedLicenseForApplication\",\"inputMap\":{\"ApplicationId\":\"{Parent.applicationId}\",\"recordType\":\"Employee\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"RelatedLicenseId\",\"val\":\"\",\"id\":8},{\"name\":\"Parent.applicationId\",\"val\":\"\",\"id\":2},{\"name\":\"Parent.LicenseName\",\"val\":\"\",\"id\":4}]}","type":"cardAction"}},"channelname":"mtxlpi_fc_DisplayRelatedLicenseListREC","displayLabel":"mtxlpi_fc_DisplayRelatedLicenseListREC:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-0","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1638182839982","message":"{\"type\":\"DataRaptor\",\"value\":{\"dsDelay\":0,\"bundle\":\"mtxlpi_dr_GetRelatedLicenseForApplication\",\"inputMap\":{\"ApplicationId\":\"{Parent.applicationId}\",\"recordType\":\"Employee\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"id\":13,\"name\":\"Parent.ApplicationId\",\"val\":\"0gor00000008OJcAAM\"},{\"name\":\"Parent.applicationId\",\"val\":\"\",\"id\":2},{\"name\":\"Parent.LicenseName\",\"val\":\"\",\"id\":4}]}","type":"cardAction"}},"channelname":"pubsubreload","displayLabel":"pubsubreload:creload","element":"action","eventLabel":"pubsub","eventname":"creload","eventtype":"pubsub","key":"event-1","recordIndex":""}],"isFlex":true,"lwc":{"DeveloperName":"cfMtxlpi_fc_DisplayRelatedLicenseListREC_1_NM","Id":"0Rb35000000DWgVCAW","ManageableState":"unmanaged","MasterLabel":"cfMtxlpi_fc_DisplayRelatedLicenseListREC_1_NM","NamespacePrefix":"c"},"osSupport":true,"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Field-0","key":"element_element_block_0_0_outputField_0_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"Name","placeholder":"","record":"{record}","type":"text"},"size":{"default":"5","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"5","isResponsive":false},"sizeClass":"slds-size_5-of-12 "},"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Field-1","key":"element_element_block_0_0_outputField_1_0","name":"Field","parentElementKey":"element_block_0_0","property":{"card":"{card}","fieldName":"BusinessLicenseName","placeholder":"","record":"{record}","type":"text"},"size":{"default":"5","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"5","isResponsive":false},"sizeClass":"slds-size_5-of-12 "},"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"Action-2","key":"element_element_block_0_0_action_2_0","name":"Action","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"Parent.HideAddBtn","id":"state-new-condition-0","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayAsButton":false,"hideActionIcon":false,"iconColor":"#F00606","iconOnly":true,"reRenderFlyout":true,"record":"{record}","stateAction":{"displayName":"Action","flyoutLwc":"b-c-d-mtxlpi_os_delete-related-license-record-english","flyoutParams":{"RelatedLicenseId":"{RelatedLicenseId}","recordType":"Employee","vlocEvents":"mtxlpi_fc_DisplayRelatedLicenseListREC"},"flyoutType":"OmniScripts","hasExtraParams":true,"id":"flex-action-1638177737284","layoutType":"lightning","openFlyoutIn":"Modal","openUrlIn":"Current Window","osName":"BCD/mtxlpi_os_deleteRelatedLicenseRecord/English","type":"Flyout","vlocityIcon":"utility:delete"},"stateObj":"{record}","styles":{"label":{"color":"","textAlign":"left"}}},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"container":{"class":""},"elementStyleProperties":{"iconColor":"#F00606","styles":{"label":{"color":"","textAlign":"left"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","text":{"align":"","color":""}},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small mtx_table_tr","container":{"class":""},"customClass":"mtx_table_tr","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[{"language":"English","subtype":"mtxlpi_os_deleteRelatedLicenseRecord","type":"BCD"}],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"mobile_view_container","container":{"class":""},"customClass":"mobile_view_container","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}},{"actions":[],"blankCardState":true,"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-0","name":"Text","property":{"card":"{card}","mergeField":"%3Cdiv%3ENo%20Related%20License%20Added!!%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"#FAECCB","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:small","size":"small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#FAECCB;     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"text"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"Nodata","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"mtxlpi_fc_DisplayRelatedLicenseListREC","Id":"a6H5f000000LRPIEA4","vlocity_ins__GlobalKey__c":"mtxlpi_fc_DisplayRelatedLicenseListREC/NM/1/1638177690936"};
  export default definition