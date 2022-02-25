export const OMNIDEF = {"userTimeZone":-480,"userProfile":"System Administrator","userName":"md@mtxlpi.demo","userId":"0055f000005s2GuAAI","userCurrencyCode":"USD","timeStamp":"2021-12-06T06:13:53.387Z","sOmniScriptId":"a3e5f000000VArgAAG","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"scrollBehavior":"auto","saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"sm","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"sm","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge","dispOutsideOmni":false}],"message":{},"mergeSavedData":false,"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"designTokenOverride":"","currentLanguage":"en_US","currencyCode":"","consoleTabTitle":"","consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"8e0b0d52-887b-99ff-34e0-2e044f25f5ee","labelMap":{"TextBlock4":"Step1:TextBlock4","TextBlock3":"Step1:TextBlock3","TextBlock1":"Approval:TextBlock1","TextBlock2":"Rejection:TextBlock2","Step1":"Step1","NavigateAction1":"NavigateAction1","IntegrationProcedureAction1":"IntegrationProcedureAction1","Approval":"Approval","IntegrationProcedureAction2":"IntegrationProcedureAction2","Rejection":"Rejection"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"recType","data":"Reject","condition":"="}],"operator":"AND"}},"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"","nextWidth":"5","nextLabel":"Yes, Continue!","message":{},"label":"Confirm Rejection","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"Rejection":""},"aggElements":{}},"offSet":0,"name":"Rejection","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text Block","rootIndex":0,"response":null,"propSetMap":{"textKey":"","text":"<p style=\"text-align: left; font-size: 16px;\">Are you sure you want to reject this record?</p>","show":null,"sanitize":false,"label":"TextBlock1","dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"TextBlock2","level":1,"JSONPath":"Rejection:TextBlock2","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc00-0"}],"bHasAttachment":false}],"bAccordionOpen":true,"bAccordionActive":true,"bStep":true,"isStep":true,"JSONPath":"Rejection","lwcId":"lwc0"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"toastComplete":false,"svgSprite":"","svgIcon":"","subLabel":"Text displayed on the Submit button","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"recType","data":"Reject","condition":"="}],"operator":"AND"}},"sendOnlyExtraPayload":true,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"remoteConfirmMsg":"Text of the confirmation prompt","redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"Ok","invokeMode":"noBlock","integrationProcedureKey":"BCD_setApplicantStatus","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"applicationStatus":"Rejected","applicationId":"%recId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":1,"confirm":"true","cancelLabel":"Text displayed on the Cancel button","businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"IntegrationProcedureAction2","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"IntegrationProcedureAction2","lwcId":"lwc1"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"recType","data":"Approve","condition":"="}],"operator":"AND"}},"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"","nextWidth":"5","nextLabel":"Yes, Continue!","message":{},"label":"Confirm Approval","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"Approval":""},"aggElements":{}},"offSet":0,"name":"Approval","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text Block","rootIndex":2,"response":null,"propSetMap":{"textKey":"","text":"<p style=\"text-align: left; font-size: 16px;\">Are you sure you want to approve this record?</p>","show":null,"sanitize":false,"label":"TextBlock1","dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"TextBlock1","level":1,"JSONPath":"Approval:TextBlock1","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc20-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"Approval","lwcId":"lwc2"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"toastComplete":false,"svgSprite":"","svgIcon":"","subLabel":"Text displayed on the Submit button","ssm":false,"showPersistentComponent":[true,false],"show":{"group":{"rules":[{"field":"recType","data":"Approve","condition":"="}],"operator":"AND"}},"sendOnlyExtraPayload":true,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"remoteConfirmMsg":"Text of the confirmation prompt","redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"Ok","invokeMode":"fireAndForget","integrationProcedureKey":"BCD_setApplicantStatus","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"applicationStatus":"Approved","applicationId":"%recId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"controlWidth":1,"confirm":"true","cancelLabel":"Text displayed on the Cancel button","businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"IntegrationProcedureAction1","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"IntegrationProcedureAction1","lwcId":"lwc3"},{"type":"Navigate Action","propSetMap":{"wpm":false,"variant":"brand","validationRequired":"Submit","targetUrl":"/s/pending-action","targetType":"Web Page","targetName":"/s/pending-action","targetLWCLayout":"lightning","targetLWC":"BCD/showMyApplicantsRecords/English","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":null,"replace":true,"recordAction":"view","pubsub":false,"objectAction":"home","message":{},"loginAction":"login","label":"NavigateAction1","iconVariant":"","iconPosition":"left","iconName":"","controlWidth":12,"businessEvent":"","businessCategory":"","HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateAction1","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateAction1","lwcId":"lwc4"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[true,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":"0","previousLabel":"","nextWidth":"0","nextLabel":"","message":{},"label":"Confirmation","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","businessEvent":"","businessCategory":"","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"Step1":""},"aggElements":{}},"offSet":0,"name":"Step1","level":0,"indexInParent":5,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text Block","rootIndex":5,"response":null,"propSetMap":{"textKey":"","text":"<p class=\"success_msg\" style=\"text-align: left; font-size: 16px; background: #DFF1E4; padding: 10px 10px;\">Record has been rejected successfully.</p>","show":{"group":{"rules":[{"field":"recType","data":"Reject","condition":"="}],"operator":"AND"}},"sanitize":false,"label":"TextBlock3","dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"TextBlock3","level":1,"JSONPath":"Step1:TextBlock3","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc50-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Text Block","rootIndex":5,"response":null,"propSetMap":{"textKey":"","text":"<p class=\"success_msg\" style=\"text-align: left; font-size: 16px; background: #DFF1E4; padding: 10px 10px;\">Record has been approved succesfully.</p>","show":{"group":{"rules":[{"field":"recType","data":"Approve","condition":"="}],"operator":"AND"}},"sanitize":false,"label":"TextBlock3","dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"TextBlock4","level":1,"JSONPath":"Step1:TextBlock4","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc51-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"Step1","lwcId":"lwc5"}],"bReusable":false,"bpVersion":2,"bpType":"BCD","bpSubType":"applicantsApprovalModal","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};