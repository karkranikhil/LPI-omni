let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","stateAction":{"eventName":"mtxlpi_fc_uploadApplicationDocumentFile_Child_Child","id":"flex-action-1626428550615","message":"data","subType":"PubSub","type":"Event"}},"channelname":"mtxlpi_fc_uploadApplicationDocumentFile_Child","displayLabel":"mtxlpi_fc_uploadApplicationDocumentFile_Child:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-0","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1628161290609","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchCannabisUploadFileData\",\"inputMap\":{\"applicationId\":\"{Parent.applicationID}\",\"fileType\":\"{Parent.fileType}\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.applicationID\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.fileType\",\"val\":\"\",\"id\":3}]}","type":"cardAction"}},"channelname":"pubsubreload","displayLabel":"pubsubreload:creload","element":"action","eventLabel":"pubsub","eventname":"creload","eventtype":"pubsub","key":"event-1","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"reload","id":"flex-action-1626388049127","type":"cardAction"}},"channelname":"updatedatasource","displayLabel":"updatedatasource:parentcardreload","element":"action","eventLabel":"pubsub","eventname":"parentcardreload","eventtype":"pubsub","key":"event-2","recordIndex":""},{"actionData":{"card":"{card}","stateAction":{"eventName":"updatedatasource","id":"flex-action-1628161473372","message":"{\"type\":\"DataRaptor\",\"value\":{\"bundle\":\"mtxlpi_dr_fetchCannabisUploadFileData\",\"inputMap\":{\"applicationId\":\"{Parent.applicationID}\",\"fileType\":\"{Parent.fileType}\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":false},\"contextVariables\":[{\"name\":\"Parent.applicationID\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.fileType\",\"val\":\"\",\"id\":3}]}","type":"cardAction"}},"channelname":"newreload","displayLabel":"newreload:reload","element":"action","eventLabel":"pubsub","eventname":"reload","eventtype":"pubsub","key":"event-3","recordIndex":""}],"globalCSS":true,"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfMtxlpi_fc_CannabisApplicationUploadDocumentsSearch_1_NM","Id":"0Rbr0000000LKe7CAG","ManageableState":"unmanaged","MasterLabel":"cfMtxlpi_fc_CannabisApplicationUploadDocumentsSearch_1_NM","NamespacePrefix":"c"},"osSupport":true,"states":[{"actions":[],"blankCardState":false,"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-0","name":"Text","property":{"card":"{card}","mergeField":"%3Cdiv%3E%7BName%7D%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_4-of-12 slds-small-size_4-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_4-of-12 slds-small-size_4-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"action","elementLabel":"Action-1","name":"Action","property":{"card":"{card}","record":"{record}","stateAction":{"Web Page":{"targetName":"{publicURL}"},"displayName":"View File","id":"flex-action-1634040641608","openUrlIn":"New Tab/Window","targetType":"Web Page","type":"Custom","vlocityIcon":"utility:preview"},"stateObj":"{record}"},"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_4-of-12 slds-small-size_4-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_4-of-12 slds-small-size_4-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"Action-2","name":"Action","property":{"card":"{card}","record":"{record}","stateAction":{"Web Page":{"targetName":"{downloadURL}"},"displayName":"Download File","id":"flex-action-1634040656247","openUrlIn":"New Tab/Window","targetType":"Web Page","type":"Custom","vlocityIcon":"utility:download"},"stateObj":"{record}"},"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_4-of-12 slds-small-size_4-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"4","medium":"4","small":"4"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_4-of-12 slds-small-size_4-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"State","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}}],"theme":"slds","title":"mtxlpi_fc_CannabisApplicationUploadDocumentsSearch","Id":"a6H5f000000LRLtEAO","vlocity_ins__GlobalKey__c":"mtxlpi_fc_CannabisApplicationUploadDocumentsSearch/NM/1/1634043290682"};
  export default definition