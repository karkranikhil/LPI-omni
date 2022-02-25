let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","stateAction":{"eventName":"mtxlpi_fc_uploadApplicationDocumentFile_Child_Child","id":"flex-action-1626428550615","message":"data","subType":"PubSub","type":"Event"}},"channelname":"mtxlpi_fc_uploadApplicationDocumentFile_Child","displayLabel":"mtxlpi_fc_uploadApplicationDocumentFile_Child:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-0","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1628161290609","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchCannabisUploadFileData\",\"inputMap\":{\"applicationId\":\"{Parent.applicationID}\",\"fileType\":\"{Parent.fileType}\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.applicationID\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.fileType\",\"val\":\"\",\"id\":3}]}","type":"cardAction"}},"channelname":"pubsubreload","displayLabel":"pubsubreload:creload","element":"action","eventLabel":"pubsub","eventname":"creload","eventtype":"pubsub","key":"event-1","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"reload","id":"flex-action-1626388049127","type":"cardAction"}},"channelname":"updatedatasource","displayLabel":"updatedatasource:parentcardreload","element":"action","eventLabel":"pubsub","eventname":"parentcardreload","eventtype":"pubsub","key":"event-2","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1628161473372","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchCannabisUploadFileData\",\"inputMap\":{\"applicationId\":\"{Parent.applicationID}\",\"fileType\":\"{Parent.fileType}\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.applicationID\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.fileType\",\"val\":\"\",\"id\":3}]}","type":"cardAction"}},"channelname":"newreload","displayLabel":"newreload:reload","element":"action","eventLabel":"pubsub","eventname":"reload","eventtype":"pubsub","key":"event-3","recordIndex":""}],"globalCSS":true,"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfMtxlpi_fc_CannabisPremiseAddressSearch_1_NM","Id":"0Rbr0000000LKeHCAW","ManageableState":"unmanaged","MasterLabel":"cfMtxlpi_fc_CannabisPremiseAddressSearch_1_NM","NamespacePrefix":"c"},"osSupport":true,"states":[{"actions":[],"blankCardState":false,"childCards":["mtxlpi_fc_CannabisPremiseUploadDocumentsSearch"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Text-0","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"LicenseName","id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3EPremises%20License%3C/div%3E%0A%3Cdiv%3E%0A%3Ch3%3E%3Cspan%20style=%22color:%20#000000;%22%3E%7BLicenseName%7D%3C/span%3E%3C/h3%3E%0A%3C/div%3E","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Text-0-clone-0","key":"element_element_block_0_0_outputField_1_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"LicenseName","id":"state-new-condition-5","operator":"==","type":"custom","value":""},{"field":"RegulatoryName","id":"state-new-condition-0","logicalOperator":"&&","operator":"!=","type":"custom","value":"Cannabis Producer Microbusiness"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3EPremises%20License%0A%3Ch3%3E%3Cspan%20style=%22color:%20#000000;%22%3ELicense%20not%20issued%3C/span%3E%3C/h3%3E%0A%3C/div%3E","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Text-1-clone-0","key":"element_element_block_0_0_outputField_2_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"RegulatoryName","id":"state-new-condition-0","operator":"==","type":"custom","value":"Cannabis Producer Microbusiness"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3EPremises%20License%0A%3Ch3%3E%3Cspan%20style=%22color:%20#000000;%22%3EN/A%3C/span%3E%3C/h3%3E%0A%3C/div%3E","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-FlexCard-1","key":"element_element_block_0_0_childCardPreview_3_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"mtxlpi_fc_CannabisPremiseUploadDocumentsSearch","cardNode":"{record.PremisesDocuments}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"State"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":true,"data-conditions":{"group":[{"field":"FullAddress","id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"label":"\\{FullAddress}","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"State","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#AAAAAA","radius":"","style":"","type":[],"width":""},"class":"slds-card  slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"mtxlpi_fc_CannabisPremiseAddressSearch","Id":"a6H5f000000LRLmEAO","vlocity_ins__GlobalKey__c":"mtxlpi_fc_CannabisPremiseAddressSearch/NM/1/1634043624932"};
  export default definition