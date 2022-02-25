export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-06T06:14:46.475Z","sOmniScriptId":"a3e5f000000VAs5AAG","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currentLanguage":"en_US","currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":true,"allowCancel":true},"prefillJSON":"{}","lwcId":"663ec575-1466-c22b-ab71-2a2ce8b5c9c3","labelMap":{"Messaging1":"Confirmation:Messaging1","Reason":"Inspection:Reason","LineBreak3":"Inspection:LineBreak3","ZipCode":"Inspection:ZipCode","State":"Inspection:State","City":"Inspection:City","Street2":"Inspection:Street2","Street1":"Inspection:Street1","LineBreak2":"Inspection:LineBreak2","SuggestedDateTime":"Inspection:SuggestedDateTime","LicenseNumber":"Inspection:LicenseNumber","License Type":"Inspection:License Type","LineBreak1":"Inspection:LineBreak1","Email":"Inspection:Email","PhoneNumber":"Inspection:PhoneNumber","Name":"Inspection:Name","NavigateAction2":"NavigateAction2","Confirmation":"Confirmation","FetchCaseNumber":"FetchCaseNumber","SetCase":"SetCase","CreateCase":"CreateCase","Inspection":"Inspection","ExtractBusinessLicenseData":"ExtractBusinessLicenseData","ExtractUserInfo":"ExtractUserInfo","SetData":"SetData"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"SetData","elementValueMap":{"recType":"Inspection_Request","BusinessLicenseId":"%Id%"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetData","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetData","lwcId":"lwc0"},{"type":"DataRaptor Extract Action","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":null,"responseJSONPath":"","responseJSONNode":"userData","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"ExtractUserInfo","inProgressMessage":"In Progress","ignoreCache":false,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_getLoggedInUserInfo","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"ExtractUserInfo","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bDataRaptorExtractAction":true,"JSONPath":"ExtractUserInfo","lwcId":"lwc1"},{"type":"DataRaptor Extract Action","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":null,"responseJSONPath":"","responseJSONNode":"BusinessData","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"ExtractBusinessLicenseData","inProgressMessage":"In Progress","ignoreCache":false,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[{"inputParam":"contactId","element":"userData:contactId"},{"inputParam":"BusinessLicenseId","element":"Id"}],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_fetchLicenseDetailsForInspection","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"ExtractBusinessLicenseData","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"bDataRaptorExtractAction":true,"JSONPath":"ExtractBusinessLicenseData","lwcId":"lwc2"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"","nextWidth":"4","nextLabel":"Submit","message":{},"label":"Inspection","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"Inspection":"","Name":"","PhoneNumber":"","Email":"","License Type":"","LicenseNumber":"","SuggestedDateTime":"","Street1":"","Street2":"","City":"","State":"","ZipCode":"","Reason":""},"aggElements":{}},"offSet":0,"name":"Inspection","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Name","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:ContactName%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Name","level":1,"JSONPath":"Inspection:Name","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc30-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Phone Number","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:PhoneNumber%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PhoneNumber","level":1,"JSONPath":"Inspection:PhoneNumber","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc31-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Email","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","label":"Email","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:Email%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Email","level":1,"JSONPath":"Inspection:Email","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bEmail":true,"lwcId":"lwc32-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Line Break","rootIndex":3,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak1","HTMLTemplateId":""},"name":"LineBreak1","level":1,"JSONPath":"Inspection:LineBreak1","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc33-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"LicenseType","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:LicenseType%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"License Type","level":1,"JSONPath":"Inspection:License Type","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc34-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":5,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"License Number","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:Name%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"LicenseNumber","level":1,"JSONPath":"Inspection:LicenseNumber","indexInParent":5,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc35-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":6,"eleArray":[{"type":"Date/Time (Local)","rootIndex":3,"response":null,"propSetMap":{"timezone":"User","timeInterval":15,"timeFormat":"hh:mm a","showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"minDate":"Today()","maxDate":"","label":"Suggested Date/Time","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"dateFormat":"MM-dd-yyyy","controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"SuggestedDateTime","level":1,"JSONPath":"Inspection:SuggestedDateTime","indexInParent":6,"index":0,"children":[],"bHasAttachment":false,"bDateTime":true,"lwcId":"lwc36-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":7,"eleArray":[{"type":"Line Break","rootIndex":3,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak1","HTMLTemplateId":""},"name":"LineBreak2","level":1,"JSONPath":"Inspection:LineBreak2","indexInParent":7,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc37-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":8,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Street1","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:Street1%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Street1","level":1,"JSONPath":"Inspection:Street1","indexInParent":8,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc38-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":9,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Street2","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:Street2%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Street2","level":1,"JSONPath":"Inspection:Street2","indexInParent":9,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc39-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":10,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"City","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:City%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"City","level":1,"JSONPath":"Inspection:City","indexInParent":10,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc310-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":11,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"State","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:State%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"State","level":1,"JSONPath":"Inspection:State","indexInParent":11,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc311-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":12,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"ZipCode","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"%BusinessData:ZipCode%","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"ZipCode","level":1,"JSONPath":"Inspection:ZipCode","indexInParent":12,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc312-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":13,"eleArray":[{"type":"Line Break","rootIndex":3,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak1","HTMLTemplateId":""},"name":"LineBreak3","level":1,"JSONPath":"Inspection:LineBreak3","indexInParent":13,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc313-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":14,"eleArray":[{"type":"Text Area","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"label":"Reason For Inspection","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Reason","level":1,"JSONPath":"Inspection:Reason","indexInParent":14,"index":0,"children":[],"bHasAttachment":false,"bTextarea":true,"lwcId":"lwc314-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"Inspection","lwcId":"lwc3"},{"type":"DataRaptor Post Action","propSetMap":{"wpm":false,"validationRequired":"Submit","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postTransformBundle":"","postMessage":"Done","message":{},"label":"Submit","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":3,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_createCaseForInspection","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"CreateCase","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bDataRaptorPostAction":true,"JSONPath":"CreateCase","lwcId":"lwc4"},{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"SetCase","elementValueMap":{"CaseValId":"%DRId_Case%"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetCase","level":0,"indexInParent":5,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetCase","lwcId":"lwc5"},{"type":"DataRaptor Extract Action","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":null,"responseJSONPath":"","responseJSONNode":"CaseData","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"FetchCaseNumber","inProgressMessage":"In Progress","ignoreCache":false,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[{"inputParam":"CaseId","element":"CaseValId"}],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_fetchCaseData","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"FetchCaseNumber","level":0,"indexInParent":6,"bHasAttachment":false,"bEmbed":false,"bDataRaptorExtractAction":true,"JSONPath":"FetchCaseNumber","lwcId":"lwc6"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"","nextWidth":"4","nextLabel":"Go to Home","message":{},"label":"Confirmation","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"Confirmation":""},"aggElements":{}},"offSet":0,"name":"Confirmation","level":0,"indexInParent":7,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":7,"response":null,"propSetMap":{"validateExpression":null,"show":null,"messages":[{"value":true,"type":"Success","text":"Your inspection request has been submitted successfully. Kindly refer submitted case %CaseData:CaseNumber%.","active":true},{"value":false,"type":"Requirement","text":"","active":true}],"label":"Messaging1","hideLabel":true,"controlWidth":12,"HTMLTemplateId":""},"name":"Messaging1","level":1,"JSONPath":"Confirmation:Messaging1","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc70-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"Confirmation","lwcId":"lwc7"},{"type":"Navigate Action","propSetMap":{"wpm":false,"variant":"brand","validationRequired":"Submit","targetUrl":"/bcd/s","targetType":"Community Named Page","targetName":"Home","targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":null,"replace":false,"recordAction":"view","pubsub":false,"objectAction":"home","message":{},"loginAction":"login","label":"NavigateAction2","iconVariant":"","iconPosition":"left","iconName":"","controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateAction2","level":0,"indexInParent":8,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateAction2","lwcId":"lwc8"}],"bReusable":false,"bpVersion":2,"bpType":"BCD","bpSubType":"inspectionRequest","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};