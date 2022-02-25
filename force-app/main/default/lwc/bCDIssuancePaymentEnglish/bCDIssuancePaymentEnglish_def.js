export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-03T11:11:25.805Z","sOmniScriptId":"a3e5f000000V9aqAAC","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currentLanguage":"en_US","currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"23097163-ca26-7a04-d224-d13b8e7b5436","labelMap":{"Final Fee Message":"IssuancePayment:Final Fee Message","LineBreak1":"IssuancePayment:LineBreak1","Mode":"IssuancePayment:Mode","Payment Required Error":"Payment Required Error","SetPaymentError":"SetPaymentError","AuthorizePayment":"AuthorizePayment","CreateTransactionLog":"CreateTransactionLog","IssuancePayment":"IssuancePayment","Payment Process":"Payment Process","Set Application Variables":"Set Application Variables"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"SetValues1","elementValueMap":{"applicationId":"%applicationId%"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"Set Application Variables","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"Set Application Variables","lwcId":"lwc0"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[true,false],"show":null,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"IntegrationProcedureAction1","integrationProcedureKey":"BCD_issuancePaymentProcess","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"Payment Process","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"Payment Process","lwcId":"lwc1"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"Previous","nextWidth":"5","nextLabel":"PAY","message":{},"label":"Issuance Payment","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":"Issuance Payment","cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"IssuancePayment":"","Mode":""},"aggElements":{}},"offSet":0,"name":"IssuancePayment","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Select","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":{"group":{"rules":[{"field":"paymentData:FeeRecord","data":null,"condition":"="}],"operator":"AND"}},"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"options":[{"value":"Credit Card (Visa or Mastercard)","name":"card","autoAdv":null},{"value":"E-Check","name":"echeck","autoAdv":null}],"optionSource":{"type":"","source":""},"label":"Mode of Payment","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"controllingField":{"type":"","source":"","element":""},"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"Mode","level":1,"JSONPath":"IssuancePayment:Mode","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bSelect":true,"lwcId":"lwc20-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Line Break","rootIndex":2,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak1","HTMLTemplateId":""},"name":"LineBreak1","level":1,"JSONPath":"IssuancePayment:LineBreak1","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc21-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Text Block","rootIndex":2,"response":null,"propSetMap":{"textKey":"","text":"<h2 style=\"text-align: left;\"><span style=\"color: #169179;\"><span style=\"color: #000000;\">The amount to be paid is</span> <span style=\"color: #00930f;\"> $%Fee%. </span></span></h2>\n<p style=\"text-align: left;\"><span style=\"color: #424242;\">Please click the PAY button to proceed with the payment.</span></p>","show":{"group":{"rules":[{"field":"paymentData:FeeRecord","data":null,"condition":"="},{"field":"Mode","data":null,"condition":"<>"}],"operator":"AND"}},"sanitize":false,"label":"TextBlock1","dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"Final Fee Message","level":1,"JSONPath":"IssuancePayment:Final Fee Message","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc22-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"IssuancePayment","lwcId":"lwc2"},{"type":"DataRaptor Post Action","propSetMap":{"wpm":false,"validationRequired":"Submit","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"FeeDataExists","data":"false","condition":"="},{"field":"Mode","data":null,"condition":"<>"}],"operator":"AND"}},"sendJSONPath":"","sendJSONNode":"","remoteTimeout":30000,"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"postTransformBundle":"","postMessage":"Done","message":{},"label":"Create Transaction Log","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":12,"businessEvent":"","businessCategory":"","bundle":"mtxlpi_dr_transactionLogPayments","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"CreateTransactionLog","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bDataRaptorPostAction":true,"JSONPath":"CreateTransactionLog","lwcId":"lwc3"},{"type":"Navigate Action","propSetMap":{"wpm":false,"variant":"success","validationRequired":"Submit","targetUrl":"../CyberSourcePayment?mode=%Mode%&tid=%DRId_Transaction_Log__c%","targetType":"Web Page","targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"FeeDataExists","data":"false","condition":"="},{"field":"Mode","data":null,"condition":"<>"}],"operator":"AND"}},"replace":false,"recordAction":"view","pubsub":false,"objectAction":"home","message":{},"loginAction":"login","label":"PAY","iconVariant":"","iconPosition":"left","iconName":"","controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"AuthorizePayment","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"AuthorizePayment","lwcId":"lwc4"},{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[true,false],"show":null,"pubsub":false,"message":{},"label":"SetPaymentError","elementValueMap":{"PaymentComplete":"=IF(%paymentData:FeeRecord% == NULL, false, true)"},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetPaymentError","level":0,"indexInParent":5,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetPaymentError","lwcId":"lwc5"},{"type":"Set Errors","propSetMap":{"wpm":false,"validationRequired":"Step","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"PaymentComplete","data":"false","condition":"="}],"operator":"AND"}},"pubsub":false,"message":{},"label":"Payment Required Error","elementErrorMap":{"PaymentError":"."},"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"Payment Required Error","level":0,"indexInParent":6,"bHasAttachment":false,"bEmbed":false,"bSetErrors":true,"JSONPath":"Payment Required Error","lwcId":"lwc6"}],"bReusable":false,"bpVersion":1,"bpType":"BCD","bpSubType":"issuancePayment","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};