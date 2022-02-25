export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-06T06:25:58.460Z","sOmniScriptId":"a3e5f000000VAycAAG","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currentLanguage":"en_US","currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"549c3bd8-e333-3dd1-e78b-c4c4f3c82203","labelMap":{"GetUsers":"GetUsers","Inspector":"ScheduleInspection:Block2:Inspector","SelectInspector-Block":"ScheduleInspection:Block2:SelectInspector-Block","AutoAssignInspector":"ScheduleInspection:Block2:AutoAssignInspector","SpecialInstruction":"ScheduleInspection:Block2:SpecialInstruction","EndDateTime":"ScheduleInspection:Block2:EndDateTime","StartDateTime":"ScheduleInspection:Block2:StartDateTime","LicenseeName":"ScheduleInspection:Block1:LicenseeName","LicenseName":"ScheduleInspection:Block1:LicenseName","Address":"ScheduleInspection:Block1:Address","SelectedInspectorId":"ScheduleInspection:SelectedInspectorId","Block2":"ScheduleInspection:Block2","Block1":"ScheduleInspection:Block1","NavigateAction1":"NavigateAction1","SaveInspectionDetails":"SaveInspectionDetails","SetLocation":"SetLocation","SaveAddressDetails":"SaveAddressDetails","InspectorError":"InspectorError","ScheduleInspection":"ScheduleInspection","LicenseDetails":"LicenseDetails","FetchInspectionDetails":"FetchInspectionDetails","CaseDetail":"CaseDetail","SelectInspector":"ScheduleInspection:Block2:SelectInspector-Block:SelectInspector"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"CaseDetail","elementValueMap":{"CaseId":"%Id%"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"CaseDetail","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"CaseDetail","lwcId":"lwc0"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"FetchInspectionDetails","integrationProcedureKey":"BCD_FetchInspectionDetails","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"FetchInspectionDetails","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"FetchInspectionDetails","lwcId":"lwc1"},{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"LicenseDetails","elementValueMap":{"LicenseeName":"%LicenseData:LicenseeName%","LicenseName":"%LicenseData:LicenseName%","LicenseId":"%LicenseData:LicenseId%","InspectorId":"%UserId%","Inspector":"%UserName%","ContactId":"%LicenseData:ContactId%","Address":"=CONCATENATE(IF(%LicenseData:Address% <> '' ,CONCATENATE(%LicenseData:Address%,', '),''), IF(%LicenseData:City% <> '' ,CONCATENATE(%LicenseData:City%,', '),''),IF(%LicenseData:State% <> '' ,CONCATENATE(%LicenseData:State%,', '),''),'US, ',IF(%LicenseData:Zip% <> '' ,%LicenseData:Zip%,''))","ActionPlanVersion":"%LicenseData:ActionPlanVersion%","AccountId":"%LicenseData:AccountId%"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"LicenseDetails","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"LicenseDetails","lwcId":"lwc2"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":3,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Save","message":{},"label":"Schedule Inspection","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"ScheduleInspection":"","Address":"","LicenseName":"","LicenseeName":"","Block1":"","StartDateTime":"","EndDateTime":"","SpecialInstruction":"","AutoAssignInspector":"","SelectInspector":"","SelectInspector-Block":"","Inspector":"","Block2":""},"aggElements":{"SelectedInspectorId":""}},"offSet":0,"name":"ScheduleInspection","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Block","rootIndex":3,"response":null,"propSetMap":{"bus":true,"show":null,"repeatLimit":null,"repeatClone":false,"repeat":false,"label":"User Information","hide":false,"controlWidth":12,"conditionType":"Hide if False","collapse":false,"accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Block1","level":1,"JSONPath":"ScheduleInspection:Block1","indexInParent":0,"index":0,"children":[{"response":null,"level":2,"indexInParent":0,"eleArray":[{"type":"Text Area","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"label":"Address","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"","debounceValue":0,"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Address","level":2,"JSONPath":"ScheduleInspection:Block1|1:Address","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTextarea":true,"lwcId":"lwc3000-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":1,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Name of License","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"LicenseName","level":2,"JSONPath":"ScheduleInspection:Block1|1:LicenseName","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc3001-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":2,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Licensee Name","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"LicenseeName","level":2,"JSONPath":"ScheduleInspection:Block1|1:LicenseeName","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc3002-0"}],"bHasAttachment":false}],"bHasAttachment":false,"bBlock":true,"lwcId":"lwc30-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Block","rootIndex":3,"response":null,"propSetMap":{"bus":true,"show":null,"repeatLimit":null,"repeatClone":false,"repeat":false,"label":"Schedule Inspection","hide":false,"controlWidth":12,"conditionType":"Hide if False","collapse":false,"accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Block2","level":1,"JSONPath":"ScheduleInspection:Block2","indexInParent":1,"index":0,"children":[{"response":null,"level":2,"indexInParent":0,"eleArray":[{"type":"Date/Time (Local)","rootIndex":3,"response":null,"propSetMap":{"timezone":"User","timePlaceholder":"Enter Start Time","timeInterval":30,"timeFormat":"hh:mm a","showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"minDate":"TODAY()","maxDate":"","label":"Start Date & Time","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"datePlaceholder":"Enter Start Date","dateFormat":"MM-dd-yyyy","controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"StartDateTime","level":2,"JSONPath":"ScheduleInspection:Block2|1:StartDateTime","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bDateTime":true,"lwcId":"lwc3100-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":1,"eleArray":[{"type":"Date/Time (Local)","rootIndex":3,"response":null,"propSetMap":{"timezone":"User","timePlaceholder":"Enter End Time","timeInterval":30,"timeFormat":"hh:mm a","showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"minDate":"TODAY()","maxDate":"","label":"End Date & Time","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"datePlaceholder":"Enter End Date","dateFormat":"MM-dd-yyyy","controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"EndDateTime","level":2,"JSONPath":"ScheduleInspection:Block2|1:EndDateTime","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bDateTime":true,"lwcId":"lwc3101-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":2,"eleArray":[{"type":"Text Area","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"label":"Special Instruction","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"","debounceValue":0,"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"SpecialInstruction","level":2,"JSONPath":"ScheduleInspection:Block2|1:SpecialInstruction","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bTextarea":true,"lwcId":"lwc3102-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":3,"eleArray":[{"type":"Checkbox","rootIndex":3,"response":null,"propSetMap":{"show":null,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"label":"Checkbox1","hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":true,"controlWidth":6,"conditionType":"Hide if False","checkLabel":"Auto Assign Inspector","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"AutoAssignInspector","level":2,"JSONPath":"ScheduleInspection:Block2|1:AutoAssignInspector","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bCheckbox":true,"lwcId":"lwc3103-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":4,"eleArray":[{"type":"Type Ahead Block","rootIndex":3,"response":null,"propSetMap":{"useDataJson":false,"typeAheadKey":"Name","showInputWidth":false,"show":{"group":{"rules":[{"field":"AutoAssignInspector","data":"false","condition":"="}],"operator":"AND"}},"required":true,"readOnly":false,"newItemLabel":"","minLength":0,"maxLength":255,"label":"Inspector","inputWidth":12,"hideMap":true,"hideEditButton":true,"helpText":"","help":false,"googleTransformation":{"street":"","postal_code":"","locality":"","country":"","administrative_area_level_2":"","administrative_area_level_1":""},"googleMapsAPIKey":"","googleAddressCountry":"all","enableLookup":false,"enableGoogleMapsAutocomplete":false,"editMode":false,"disableDataFilter":false,"debounceValue":0,"dataProcessorFunction":"","dataJsonPath":"","controlWidth":6,"conditionType":"Hide if False","callFrequency":300,"accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"SelectInspector-Block","level":2,"JSONPath":"ScheduleInspection:Block2|1:SelectInspector-Block","indexInParent":4,"index":0,"children":[{"response":null,"level":3,"indexInParent":0,"eleArray":[{"type":"Type Ahead","rootIndex":4,"response":null,"propSetMap":{"taAction":{"type":"DataRaptor Extract Action","rootIndex":3,"response":null,"propSetMap":{"_di":1,"repeat":false,"readOnly":false,"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":null,"responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"GetUsers","inProgressMessage":"In Progress","ignoreCache":false,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_GetUsers","HTMLTemplateId":""},"name":"GetUsers","level":3,"JSONPath":"ScheduleInspection:Block2|1:SelectInspector-Block:SelectInspector","indexInParent":0,"index":0,"children":[],"bHasAttachment":false},"useDataJson":false,"typeAheadKey":"Name","showInputWidth":false,"show":{"group":{"rules":[{"field":"AutoAssignInspector","data":"false","condition":"="}],"operator":"AND"}},"required":true,"readOnly":false,"newItemLabel":"","minLength":0,"maxLength":255,"label":"Inspector","inputWidth":12,"hideMap":true,"hideEditButton":true,"helpText":"","help":false,"googleTransformation":{"street":"","postal_code":"","locality":"","country":"","administrative_area_level_2":"","administrative_area_level_1":""},"googleMapsAPIKey":"","googleAddressCountry":"all","enableLookup":false,"enableGoogleMapsAutocomplete":false,"editMode":false,"disableDataFilter":false,"debounceValue":0,"dataProcessorFunction":"","dataJsonPath":"","controlWidth":12,"conditionType":"Hide if False","callFrequency":300,"accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"SelectInspector","level":3,"JSONPath":"ScheduleInspection:Block2|1:SelectInspector-Block:SelectInspector","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTypeahead":true,"lwcId":"lwc310400-0"}],"bHasAttachment":false}],"bHasAttachment":false,"bTypeaheadBlock":true,"lwcId":"lwc3104-0"}],"bHasAttachment":false},{"response":null,"level":2,"indexInParent":5,"eleArray":[{"type":"Text","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":{"group":{"rules":[{"field":"AutoAssignInspector","data":"true","condition":"="}],"operator":"AND"}},"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":true,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Inspector","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Inspector","level":2,"JSONPath":"ScheduleInspection:Block2|1:Inspector","indexInParent":5,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc3105-0"}],"bHasAttachment":false}],"bHasAttachment":false,"bBlock":true,"lwcId":"lwc31-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Aggregate","rootIndex":3,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"mask":null,"label":"Aggregate1","inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"IF(%Block2:SelectInspector-Block:Id%,%Block2:SelectInspector-Block:Id%,%Block2:SelectInspector-Block:Id%)","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":null,"controlWidth":12,"HTMLTemplateId":""},"name":"SelectedInspectorId","level":1,"JSONPath":"ScheduleInspection:SelectedInspectorId","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bAggregate":true,"lwcId":"lwc32-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"ScheduleInspection","lwcId":"lwc3"},{"type":"Set Errors","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"ScheduleInspection:Block2:AutoAssignInspector","data":"true","condition":"="},{"group":{"rules":[{"field":"InspectorId","data":null,"condition":"="},{"field":"InspectorId","data":"\"\"","condition":"="}],"operator":"OR"}}],"operator":"AND"}},"pubsub":false,"message":{},"label":"InspectorError","elementErrorMap":{"Inspector":"No Inspector assigned. Please assign an Inspector."},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"InspectorError","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bSetErrors":true,"JSONPath":"InspectorError","lwcId":"lwc4"},{"type":"DataRaptor Post Action","propSetMap":{"wpm":false,"validationRequired":"Submit","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"LocationId","data":null,"condition":"="}],"operator":"AND"}},"sendJSONPath":"","sendJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postTransformBundle":"","postMessage":"Done","message":{},"label":"SaveAddressDetails","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_SaveAddressForInspection","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SaveAddressDetails","level":0,"indexInParent":5,"bHasAttachment":false,"bEmbed":false,"bDataRaptorPostAction":true,"JSONPath":"SaveAddressDetails","lwcId":"lwc5"},{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"LocationId","data":null,"condition":"="}],"operator":"AND"}},"pubsub":false,"message":{},"label":"SetLocation","elementValueMap":{"LocationId":"%DRId_Location%"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetLocation","level":0,"indexInParent":6,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetLocation","lwcId":"lwc6"},{"type":"DataRaptor Post Action","propSetMap":{"wpm":false,"validationRequired":"Submit","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postTransformBundle":"","postMessage":"Done","message":{},"label":"SaveInspectionDetails","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_SaveInspection","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SaveInspectionDetails","level":0,"indexInParent":7,"bHasAttachment":false,"bEmbed":false,"bDataRaptorPostAction":true,"JSONPath":"SaveInspectionDetails","lwcId":"lwc7"},{"type":"Navigate Action","propSetMap":{"wpm":false,"variant":"brand","validationRequired":"Submit","targetType":"Record","targetName":"Visit","targetLWCLayout":"lightning","targetId":"%DRId_Visit%","targetFilter":"Recent","ssm":false,"show":null,"replace":false,"recordAction":"view","pubsub":false,"objectAction":"home","message":{},"loginAction":"login","label":"NavigateAction1","iconVariant":"","iconPosition":"left","iconName":"","controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateAction1","level":0,"indexInParent":8,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateAction1","lwcId":"lwc8"}],"bReusable":false,"bpVersion":1,"bpType":"BCD","bpSubType":"ScheduleInspection","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};