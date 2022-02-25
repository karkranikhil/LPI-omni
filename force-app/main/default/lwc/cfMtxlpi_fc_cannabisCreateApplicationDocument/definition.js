let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"DataRaptor","value":{"bundle":"mtxlpi_dr_fetchCannabisPremiseFileData","inputMap":{"PremiseLocationType":"Premise","applicationId":"0go350000004E8CAAU"},"resultVar":""}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1623396035012","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchApplicationDocuemntWithApplicationForOS\",\"inputMap\":{\"locale\":\"{Parent.locale}\",\"appId\":\"{Parent.appId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.locale\",\"val\":\"\",\"id\":8},{\"name\":\"Parent.appId\",\"val\":\"\",\"id\":9}]}","type":"cardAction"}},"channelname":"mtxlpi_fc_uploadApplicationDocumentFile_Child","displayLabel":"mtxlpi_fc_uploadApplicationDocumentFile_Child:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-0","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1623396804431","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchApplicationDocuemntWithApplicationForOS\",\"inputMap\":{\"locale\":\"{Parent.locale}\",\"appId\":\"{Parent.appId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.locale\",\"val\":\"\",\"id\":8},{\"name\":\"Parent.appId\",\"val\":\"\",\"id\":9}]}","type":"cardAction"}},"channelname":"pubsubreload","displayLabel":"pubsubreload:creload","element":"action","eventLabel":"pubsub","eventname":"creload","eventtype":"pubsub","key":"event-1","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"reload","id":"flex-action-1623398194620","type":"cardAction"}},"channelname":"updatedatasource","displayLabel":"updatedatasource:parentcardreload","element":"action","eventLabel":"pubsub","eventname":"parentcardreload","eventtype":"pubsub","key":"event-2","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1623741545535","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchApplicationDocuemntWithApplicationForOS\",\"inputMap\":{\"locale\":\"{Parent.locale}\",\"appId\":\"{Parent.appId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.locale\",\"val\":\"en_US\",\"id\":8},{\"name\":\"Parent.appId\",\"val\":\"0iT3500000000FREAY\",\"id\":9}]}","subType":"PubSub","type":"cardAction"}},"channelname":"newreload","displayLabel":"newreload:appreload","element":"action","eventLabel":"pubsub","eventname":"appreload","eventtype":"pubsub","key":"event-3","recordIndex":""}],"globalCSS":true,"isFlex":true,"lwc":{"DeveloperName":"cfMtxlpi_fc_cannabisCreateApplicationDocument_1_NM","Id":"0Rb35000000CqPbCAK","ManageableState":"unmanaged","MasterLabel":"cfMtxlpi_fc_cannabisCreateApplicationDocument_1_NM","NamespacePrefix":"c"},"osSupport":true,"states":[{"actions":[],"childCards":["mtxlpi_fc_internel_UploadApplicationDocumentFile_Child_Child"],"components":{"layer-0":{"children":[{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Field-3","key":"element_element_element_block_0_0_block_0_0_outputField_0_0","name":"Field","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","fieldName":"{premiseAddress1Producer}","label":"Address1","placeholder":"","record":"{record}","type":"text"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:xx-small","size":"xx-small","type":"left"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","key":"element_element_block_0_0_block_0_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"4","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 "},"type":"block"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Field-2","key":"element_element_element_block_0_0_block_1_0_outputField_0_0","name":"Field","parentElementKey":"element_element_block_0_0_block_1_0","property":{"card":"{card}","fieldName":"{premiseStateNumberProducer}","label":"Total Plants","placeholder":"","record":"{record}","type":"text"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","key":"element_element_block_0_0_block_1_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"4","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 "},"type":"block"},{"children":[{"class":"slds-col ","element":"action","elementLabel":"Action-3","key":"element_element_element_block_0_0_block_2_0_action_0_0","name":"Action","parentElementKey":"element_element_block_0_0_block_2_0","property":{"buttonVariant":"brand","card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"displayAsButton":false,"hideActionIcon":false,"iconOnly":true,"record":"{record}","stateAction":{"displayName":"Upload","flyoutLwc":"b-c-d-mtxlpi_fc_upload-application-document-internel-english","flyoutParams":{"applicationDocument":"{producerLocationId}","fileFormate":"{Formats}","vlocEvents":"mtxlpi_fc_uploadApplicationDocumentFile_Child"},"flyoutType":"OmniScripts","hasExtraParams":true,"id":"flex-action-1625833209563","layoutType":"lightning","openFlyoutIn":"Modal","openUrlIn":"Current Window","osName":"BCD/mtxlpi_fc_uploadApplicationDocumentInternel/English","type":"Flyout","vlocityIcon":"utility:upload"},"stateObj":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left display_none ","container":{"class":"display_none"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"left","color":""}},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-2","key":"element_element_block_0_0_block_2_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center slds-p-around_x-small ","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"center","color":""}},"type":"block"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-5","key":"element_element_element_block_0_0_block_3_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_element_block_0_0_block_3_0","property":{"cardName":"mtxlpi_fc_internel_UploadApplicationDocumentFile_Child_Child","cardNode":"{record.Documents}","data-conditions":{"group":[{"field":"{record.Documents}","id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false,"large":"3","medium":"3","small":"3"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-scrollable_y ","container":{"class":"slds-scrollable_y"},"customClass":"","elementStyleProperties":{},"height":"9em","inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"3","medium":"3","small":"3"},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n     height:9em;    ","text":{"align":"","color":""}},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3","key":"element_element_block_0_0_block_3_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"text-wrap slds-p-around_x-small ","container":{"class":"text-wrap"},"elementStyleProperties":{},"inlineStyle":"word-break: break-all;","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"     : #ccc 1px solid; \n         word-break: break-all;","text":{"align":"","color":""}},"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-4","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small mtx_table_tr","container":{"class":""},"customClass":"mtx_table_tr","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[{"language":"English","subtype":"mtxlpi_fc_uploadApplicationDocumentInternel","type":"BCD"}],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"mtxlpi_fc_cannabisCreateApplicationDocument","Id":"a6H5f000000LRQtEAO","vlocity_ins__GlobalKey__c":"mtxlpi_fc_cannabisCreateApplicationDocument/NM/1/1625830655619"};
  export default definition