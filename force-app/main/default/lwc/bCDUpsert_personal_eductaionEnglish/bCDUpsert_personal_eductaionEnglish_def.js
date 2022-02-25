export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-06T06:33:31.704Z","sOmniScriptId":"a3e5f000000VB1gAAG","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":true,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currentLanguage":"en_US","currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"3ef71dee-6538-5aac-6df4-30b93558da32","labelMap":{"DegreeDateConferred":"PersonEducationUpsert:PersonEducationBlock:DegreeDateConferred","Degree":"PersonEducationUpsert:PersonEducationBlock:Degree","Major":"PersonEducationUpsert:PersonEducationBlock:Major","Location":"PersonEducationUpsert:PersonEducationBlock:Location","NameOfInstitute":"PersonEducationUpsert:PersonEducationBlock:NameOfInstitute","Messaging1":"SuccessBlock:Messaging1","PersonEducationBlock":"PersonEducationUpsert:PersonEducationBlock","SuccessBlock":"SuccessBlock","RelaodDataTable":"RelaodDataTable","IP_Upsert_Person_Education":"IP_Upsert_Person_Education","PersonEducationUpsert":"PersonEducationUpsert","FetchContactDetail":"FetchContactDetail"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"DataRaptor Extract Action","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":null,"responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"FetchContactDetail","inProgressMessage":"In Progress","ignoreCache":true,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_fetchUserContact","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"FetchContactDetail","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bDataRaptorExtractAction":true,"JSONPath":"FetchContactDetail","lwcId":"lwc0"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":3,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Save","message":{},"label":"Professional Education","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"PersonEducationUpsert":"","NameOfInstitute":"","Location":"","Major":"","Degree":"","DegreeDateConferred":"","PersonEducationBlock":""},"aggElements":{}},"offSet":0,"name":"PersonEducationUpsert","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Block","rootIndex":1,"response":null,"propSetMap":{"bus":true,"show":null,"repeatLimit":null,"repeatClone":false,"repeat":false,"label":"","hide":false,"controlWidth":12,"conditionType":"Hide if False","collapse":false,"accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PersonEducationBlock","level":1,"JSONPath":"PersonEducationUpsert:PersonEducationBlock","indexInParent":0,"index":0,"children":[{"response":null,"level":2,"indexInParent":0,"eleArray":[{"type":"Text","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Name of Institution (High School, GED, College, University, Technical or Vocational School)","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%NameOfInstitute%","debounceValue":0,"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"NameOfInstitute","level":2,"JSONPath":"PersonEducationUpsert:PersonEducationBlock|1:NameOfInstitute","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc1000-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":1,"eleArray":[{"type":"Text Area","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"label":"Location (City, State, Country)","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%Location%","debounceValue":0,"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Location","level":2,"JSONPath":"PersonEducationUpsert:PersonEducationBlock|1:Location","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bTextarea":true,"lwcId":"lwc1001-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":2,"eleArray":[{"type":"Text","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Major field of Study","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%Major%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Major","level":2,"JSONPath":"PersonEducationUpsert:PersonEducationBlock|1:Major","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc1002-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":3,"eleArray":[{"type":"Select","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"options":[{"value":"Associates Degrees","name":"Associates Degrees","autoAdv":null},{"value":"Bachelor's Art","name":"Bachelor's Art","autoAdv":null},{"value":"Bachelor's Science","name":"Bachelor's Science","autoAdv":null},{"value":"Certificate","name":"Certificate","autoAdv":null},{"value":"GED","name":"GED","autoAdv":null},{"value":"High School Diploma","name":"High School Diploma","autoAdv":null},{"value":"Masters","name":"Masters","autoAdv":null},{"value":"PhD","name":"PhD","autoAdv":null},{"value":"Vocational","name":"Vocational","autoAdv":null},{"value":"Other","name":"Other","autoAdv":null}],"optionSource":{"type":"","source":""},"label":"Degree","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"controllingField":{"type":"","source":"","element":""},"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Degree","level":2,"JSONPath":"PersonEducationUpsert:PersonEducationBlock|1:Degree","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bSelect":true,"lwcId":"lwc1003-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":4,"eleArray":[{"type":"Date","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"modelDateFormat":"yyyy-MM-dd","minDate":"","maxDate":"Today()","label":"Date Completed","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%DegreeCongreteDate%","dateType":"string","dateFormat":"MM/DD/YYYY","controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"DegreeDateConferred","level":2,"JSONPath":"PersonEducationUpsert:PersonEducationBlock|1:DegreeDateConferred","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bDate":true,"lwcId":"lwc1004-0"}],"bHasAttachment":false}],"bHasAttachment":false,"bBlock":true,"lwcId":"lwc10-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"PersonEducationUpsert","lwcId":"lwc1"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"IP_Upsert_Person_Education","integrationProcedureKey":"BCD_upsertPersonEducation","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"Id":"%Id%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"IP_Upsert_Person_Education","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"IP_Upsert_Person_Education","lwcId":"lwc2"},{"type":"Navigate Action","propSetMap":{"wpm":false,"variant":"brand","validationRequired":"Submit","targetType":"Current Page","targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":null,"replace":false,"recordAction":"view","pubsub":true,"objectAction":"home","message":{},"loginAction":"login","label":"RelaodDataTable","iconVariant":"","iconPosition":"left","iconName":"","controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"RelaodDataTable","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"RelaodDataTable","lwcId":"lwc3"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"Previous","nextWidth":3,"nextLabel":"Next","message":{},"label":"","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"SuccessBlock":""},"aggElements":{}},"offSet":0,"name":"SuccessBlock","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":4,"response":null,"propSetMap":{"validateExpression":null,"show":null,"messages":[{"value":true,"type":"Success","text":"Professional Education added successfully. Kindly close.","active":true},{"value":false,"type":"Requirement","text":"","active":true}],"label":"Messaging1","hideLabel":true,"controlWidth":12,"HTMLTemplateId":""},"name":"Messaging1","level":1,"JSONPath":"SuccessBlock:Messaging1","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc40-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"SuccessBlock","lwcId":"lwc4"}],"bReusable":false,"bpVersion":2,"bpType":"BCD","bpSubType":"upsert_personal_eductaion","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};