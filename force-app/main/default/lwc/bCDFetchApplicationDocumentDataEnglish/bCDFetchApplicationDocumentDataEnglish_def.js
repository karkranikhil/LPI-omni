export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-08T06:48:55.171Z","sOmniScriptId":"a3e5f000000VEqvAAG","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currentLanguage":"en_US","currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":true,"allowCancel":true},"prefillJSON":"{}","lwcId":"1ad4567a-a3f3-dd08-acc9-15db6baebcfa","labelMap":{"CustomLWC2":"Step1:CustomLWC2","CustomLWC1":"Step1:CustomLWC1","Messaging1":"Step1:Messaging1","SetErrors1":"SetErrors1","IntegrationProcedureAction1":"IntegrationProcedureAction1","Step1":"Step1","DataRaptorExtractAction2":"DataRaptorExtractAction2"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"DataRaptor Extract Action","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":null,"responseJSONPath":"","responseJSONNode":"userInfo","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"DataRaptorExtractAction2","inProgressMessage":"In Progress","ignoreCache":true,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[{"inputParam":"userId","element":"userId"},{"inputParam":"appId","element":"ContextId"}],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_fetchDataFromLoggedInUser","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"DataRaptorExtractAction2","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bDataRaptorExtractAction":true,"JSONPath":"DataRaptorExtractAction2","lwcId":"lwc0"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":3,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Next","message":{},"label":"","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"Step1":""},"aggElements":{"CustomLWC1":"","CustomLWC2":""}},"offSet":0,"name":"Step1","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":1,"response":null,"propSetMap":{"validateExpression":{"group":{"rules":[{"field":"IPResult:OutputMessage:isNotPresent","data":"NotPresent","condition":"="},{"field":"IPResult","data":null,"condition":"<>"}],"operator":"AND"}},"show":null,"messages":[{"value":true,"type":"Warning","text":"Please upload the file for all the documents","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":"Messaging1","hideLabel":true,"controlWidth":12,"HTMLTemplateId":""},"name":"Messaging1","level":1,"JSONPath":"Step1:Messaging1","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc10-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":1,"response":null,"propSetMap":{"show":null,"lwcName":"cfMtxlpi_fc_uploadApplicationDocumentFile","label":"CustomLWC1","hide":false,"customAttributes":[],"controlWidth":12,"conditionType":"Hide if False","bStandalone":true},"name":"CustomLWC1","level":1,"JSONPath":"Step1:CustomLWC1","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent1":true,"lwcId":"lwc11-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":1,"response":null,"propSetMap":{"show":null,"lwcName":"cfMtxlpi_fc_uploadApplicationDocumentFile_Child","label":"CustomLWC1","hide":false,"customAttributes":[{"source":"%userInfo%","name":"parent-attribute"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":true},"name":"CustomLWC2","level":1,"JSONPath":"Step1:CustomLWC2","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent2":true,"lwcId":"lwc12-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"Step1","lwcId":"lwc1"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"IPResult","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"Next","integrationProcedureKey":"BCD_mtxlpi_ip_ConfigureApplicationDocumentFile","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"locale":"%userInfo:locale%","appId":"%ContextId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"IntegrationProcedureAction1","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"IntegrationProcedureAction1","lwcId":"lwc2"},{"type":"Set Errors","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"IPResult:OutputMessage:isNotPresent","data":"NotPresent","condition":"="}],"operator":"AND"}},"pubsub":false,"message":{},"label":"SetErrors1","elementErrorMap":{"CustomLWC1":"."},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetErrors1","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bSetErrors":true,"JSONPath":"SetErrors1","lwcId":"lwc3"}],"bReusable":false,"bpVersion":6,"bpType":"BCD","bpSubType":"fetchApplicationDocumentData","bpLang":"English","bHasAttachment":false,"lwcVarMap":{"userInfo":null}};