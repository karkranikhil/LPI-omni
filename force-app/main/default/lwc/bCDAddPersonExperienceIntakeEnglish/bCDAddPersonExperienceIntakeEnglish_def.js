export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-08T10:43:56.903Z","sOmniScriptId":"a3e5f000000V9lYAAS","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currentLanguage":"en_US","currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"faf13cdd-d230-0e28-dea0-533240f2ff15","labelMap":{"TextBlock1":"SuccessMsgStep:TextBlock1","PhysicalZip":"PersonExperience:PhysicalZip","PhysicalState":"PersonExperience:PhysicalState","PhysicalCity":"PersonExperience:PhysicalCity","PhysicalStreet":"PersonExperience:PhysicalStreet","EmploymentToDate":"PersonExperience:EmploymentToDate","EmploymentFromDate":"PersonExperience:EmploymentFromDate","PositionHeld":"PersonExperience:PositionHeld","EmployerName":"PersonExperience:EmployerName","SuccessMsgStep":"SuccessMsgStep","NavigateAction1":"NavigateAction1","Update/Insert Person Education":"Update/Insert Person Education","SetErrors2":"SetErrors2","SetErrors1":"SetErrors1","PersonExperience":"PersonExperience","GetPersonExperience":"GetPersonExperience","SetValues1":"SetValues1"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"SetValues1","elementValueMap":{"experienceId":"%experienceId%","Today":"=DATE(TODAY())"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetValues1","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetValues1","lwcId":"lwc0"},{"type":"DataRaptor Extract Action","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"experienceId","data":null,"condition":"<>"}],"operator":"AND"}},"responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postMessage":"Done","message":{},"label":"DataRaptorExtractAction1","inProgressMessage":"In Progress","ignoreCache":false,"failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"dataRaptor Input Parameters":[{"inputParam":"experienceId","element":"experienceId"}],"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_GetPersonExperiences","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"GetPersonExperience","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bDataRaptorExtractAction":true,"JSONPath":"GetPersonExperience","lwcId":"lwc1"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":3,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Next","message":{},"label":"Person Experience","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"<p>%experienceId% experienceId</p>","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"PersonExperience":"","EmployerName":"","PositionHeld":"","EmploymentFromDate":"","EmploymentToDate":"","PhysicalStreet":"","PhysicalCity":"","PhysicalState":"","PhysicalZip":""},"aggElements":{}},"offSet":0,"name":"PersonExperience","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Employer Name","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"EmployerName","level":1,"JSONPath":"PersonExperience:EmployerName","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc20-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Text","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Position Held","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PositionHeld","level":1,"JSONPath":"PersonExperience:PositionHeld","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc21-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Date","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"modelDateFormat":"yyyy-MM-dd","minDate":"","maxDate":"{today}","label":"Dates of Employment from","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"dateType":"string","dateFormat":"MM-dd-yyyy","controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"EmploymentFromDate","level":1,"JSONPath":"PersonExperience:EmploymentFromDate","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bDate":true,"lwcId":"lwc22-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Date","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"modelDateFormat":"yyyy-MM-dd","minDate":"","maxDate":"","label":"Dates of Employment to","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"dateType":"string","dateFormat":"MM-dd-yyyy","controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"EmploymentToDate","level":1,"JSONPath":"PersonExperience:EmploymentToDate","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bDate":true,"lwcId":"lwc23-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Text","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Physical Street","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PhysicalStreet","level":1,"JSONPath":"PersonExperience:PhysicalStreet","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc24-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":5,"eleArray":[{"type":"Text","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Physical City","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":4,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PhysicalCity","level":1,"JSONPath":"PersonExperience:PhysicalCity","indexInParent":5,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc25-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":6,"eleArray":[{"type":"Select","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"options":[{"value":"Alabama","name":"AL","autoAdv":null},{"value":"Alaska","name":"AK","autoAdv":null},{"value":"American Samoa","name":"AS","autoAdv":null},{"value":"Arizona","name":"AZ","autoAdv":null},{"value":"Arkansas","name":"AR","autoAdv":null},{"value":"California","name":"CA","autoAdv":null},{"value":"Colorado","name":"CO","autoAdv":null},{"value":"Connecticut","name":"CT","autoAdv":null},{"value":"Delaware","name":"DE","autoAdv":null},{"value":"District of Columbia","name":"DC","autoAdv":null},{"value":"Federated States of Micronesia","name":"FM","autoAdv":null},{"value":"Florida","name":"FL","autoAdv":null},{"value":"Georgia","name":"GA","autoAdv":null},{"value":"Guam","name":"GU","autoAdv":null},{"value":"Hawaii","name":"HI","autoAdv":null},{"value":"Idaho","name":"ID","autoAdv":null},{"value":"Illinois","name":"IL","autoAdv":null},{"value":"Indiana","name":"IN","autoAdv":null},{"value":"Iowa","name":"IA","autoAdv":null},{"value":"Kansas","name":"KS","autoAdv":null},{"value":"Kentucky","name":"KY","autoAdv":null},{"value":"Louisiana","name":"LA","autoAdv":null},{"value":"Maine","name":"ME","autoAdv":null},{"value":"Marshall Islands","name":"MH","autoAdv":null},{"value":"Maryland","name":"MD","autoAdv":null},{"value":"Massachusetts","name":"MA","autoAdv":null},{"value":"Michigan","name":"MI","autoAdv":null},{"value":"Minnesota","name":"MN","autoAdv":null},{"value":"Mississippi","name":"MS","autoAdv":null},{"value":"Missouri","name":"MO","autoAdv":null},{"value":"Montana","name":"MT","autoAdv":null},{"value":"Nebraska","name":"NE","autoAdv":null},{"value":"Nevada","name":"NV","autoAdv":null},{"value":"New Hampshire","name":"NH","autoAdv":null},{"value":"New Jersey","name":"NJ","autoAdv":null},{"value":"New Mexico","name":"NM","autoAdv":null},{"value":"New York","name":"NY","autoAdv":null},{"value":"North Carolina","name":"NC","autoAdv":null},{"value":"North Dakota","name":"ND","autoAdv":null},{"value":"Northern Mariana Islands","name":"MP","autoAdv":null},{"value":"Ohio","name":"OH","autoAdv":null},{"value":"Oklahoma","name":"OK","autoAdv":null},{"value":"Oregon","name":"OR","autoAdv":null},{"value":"Palau","name":"PW","autoAdv":null},{"value":"Pennsylvania","name":"PA","autoAdv":null},{"value":"Puerto Rico","name":"PR","autoAdv":null},{"value":"Rhode Island","name":"RI","autoAdv":null},{"value":"South Carolina","name":"SC","autoAdv":null},{"value":"South Dakota","name":"SD","autoAdv":null},{"value":"Tennessee","name":"TN","autoAdv":null},{"value":"Texas","name":"TX","autoAdv":null},{"value":"Utah","name":"UT","autoAdv":null},{"value":"Vermont","name":"VT","autoAdv":null},{"value":"Virgin Islands","name":"VI","autoAdv":null},{"value":"Virginia","name":"VA","autoAdv":null},{"value":"Washington","name":"WA","autoAdv":null},{"value":"West Virginia","name":"WV","autoAdv":null},{"value":"Wisconsin","name":"WI","autoAdv":null},{"value":"Wyoming","name":"WY","autoAdv":null}],"optionSource":{"type":"","source":""},"label":"Physical State","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"controllingField":{"type":"","source":"","element":""},"controlWidth":4,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PhysicalState","level":1,"JSONPath":"PersonExperience:PhysicalState","indexInParent":6,"index":0,"children":[],"bHasAttachment":false,"bSelect":true,"lwcId":"lwc26-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":7,"eleArray":[{"type":"Text","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","placeholder":"","pattern":"","minLength":5,"maxLength":10,"mask":"","label":"Physical Zip","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":4,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"PhysicalZip","level":1,"JSONPath":"PersonExperience:PhysicalZip","indexInParent":7,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc27-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"PersonExperience","lwcId":"lwc2"},{"type":"Set Errors","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"EmploymentFromDate","data":"%Today%","condition":">="}],"operator":"AND"}},"pubsub":false,"message":{},"label":"SetErrors1","elementErrorMap":{"EmploymentFromDate":"Employment From Date cannot be greater than today"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetErrors1","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bSetErrors":true,"JSONPath":"SetErrors1","lwcId":"lwc3"},{"type":"Set Errors","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"EmploymentFromDate","data":"%EmploymentToDate%","condition":">="},{"field":"EmploymentFromDate","data":null,"condition":"<>"}],"operator":"AND"}},"pubsub":false,"message":{},"label":"SetErrors1","elementErrorMap":{"EmploymentToDate":"Employment To Date cannot be less than Employment From Date"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetErrors2","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bSetErrors":true,"JSONPath":"SetErrors2","lwcId":"lwc4"},{"type":"DataRaptor Post Action","propSetMap":{"wpm":false,"validationRequired":"Submit","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postTransformBundle":"","postMessage":"Done","message":{},"label":"DataRaptorPostAction1","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_updatePersonExperienceIntakeForm","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"Update/Insert Person Education","level":0,"indexInParent":5,"bHasAttachment":false,"bEmbed":false,"bDataRaptorPostAction":true,"JSONPath":"Update/Insert Person Education","lwcId":"lwc5"},{"type":"Navigate Action","propSetMap":{"wpm":false,"variant":"brand","validationRequired":"Submit","targetType":"Current Page","targetParams":"","targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":null,"replace":false,"recordAction":"view","pubsub":true,"objectAction":"home","message":{},"loginAction":"login","label":"NavigateAction1","iconVariant":"","iconPosition":"left","iconName":"","controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateAction1","level":0,"indexInParent":6,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateAction1","lwcId":"lwc6"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"Previous","nextWidth":"0","nextLabel":"Next","message":{},"label":"","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"SuccessMsgStep":""},"aggElements":{}},"offSet":0,"name":"SuccessMsgStep","level":0,"indexInParent":7,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text Block","rootIndex":7,"response":null,"propSetMap":{"textKey":"","text":"<div style=\"padding: 10px; background-color: #d7e9cd;\">\n<p>Close the window to return</p>\n</div>","show":null,"sanitize":false,"label":"TextBlock1","dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"TextBlock1","level":1,"JSONPath":"SuccessMsgStep:TextBlock1","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc70-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"SuccessMsgStep","lwcId":"lwc7"}],"bReusable":false,"bpVersion":2,"bpType":"BCD","bpSubType":"AddPersonExperienceIntake","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};