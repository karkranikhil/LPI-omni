import { FlexCardMixin } from "vlocity_ins/flexCardMixin";
    import {interpolateWithRegex, interpolateKeyValue, fetchCustomLabels, loadCssFromStaticResource } from "vlocity_ins/flexCardUtility";
    
          import { LightningElement, api, track } from "lwc";
          
          import pubsub from "vlocity_ins/pubsub";
          import { OmniscriptBaseMixin } from "vlocity_ins/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfMtxlpi_fc_internalCreateApplicationDocument_4_NM extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfMtxlpi_fc_internalCreateApplicationDocument_4_NM';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              

              _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default
              
              pubsubEvent = [];
              customEvent = [];
              
              connectedCallback() {
                super.connectedCallback();
                this.registerEvents();
                this.setStyleDefinition(styleDef);
                data.Session = {} //reinitialize on reload
                
                
                
                this.setDefinition(data);
                
                
              }
              
              disconnectedCallback(){
                super.disconnectedCallback();
                    this.omniSaveState(this.records,this.omniSupportKey,true);
                    

                  this.unregisterEvents();
              }
                  
              executeAction(event) {
                let dataset = event.currentTarget.dataset;
                if (dataset && dataset.onchange === 'setValue' ) {
                  this.setValueOnToggle(event);
                }
                if(dataset && typeof dataset.actionIndex !== 'undefined') {
                  let actionIndex = dataset.actionIndex;
                  this.elementIndex = event.currentTarget && event.currentTarget.closest(".cf-vlocity-state") ? event.currentTarget.closest(".cf-vlocity-state").dataset.rindex : null;
                  if (this.records) {
                    this.record = this.records[this.elementIndex];
                  }
                  this.action = {};
                  this.action[actionIndex] = true;
                  this.template.querySelector('.execute-action').executeAction(event, this.card);
                }
                event.stopPropagation();
              }

              registerEvents() {
                
        this.pubsubEvent[0] = {
          data: this.handleEventAction.bind(this, data.events[0],0)
        };

        pubsub.register(`mtxlpi_fc_uploadApplicationDocumentFile_Child`,this.pubsubEvent[0]);

        this.pubsubEvent[1] = {
          creload: this.handleEventAction.bind(this, data.events[1],1)
        };

        pubsub.register(`pubsubreload`,this.pubsubEvent[1]);

        this.pubsubEvent[2] = {
          parentcardreload: this.handleEventAction.bind(this, data.events[2],2)
        };

        pubsub.register(`updatedatasource`,this.pubsubEvent[2]);

        this.pubsubEvent[3] = {
          appreload: this.handleEventAction.bind(this, data.events[3],3)
        };

        pubsub.register(`newreload`,this.pubsubEvent[3]);

              }

              unregisterEvents(){
                pubsub.unregister(`mtxlpi_fc_uploadApplicationDocumentFile_Child`,this.pubsubEvent[0]);
pubsub.unregister(`pubsubreload`,this.pubsubEvent[1]);
pubsub.unregister(`updatedatasource`,this.pubsubEvent[2]);
pubsub.unregister(`newreload`,this.pubsubEvent[3]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }

              handleEventAction(eventObj, eventIndex, event) {
                eventObj.actionList = eventObj.actionList || (eventObj.actionData ? [eventObj.actionData] : []);
                let stateIndex = 0;
                if (eventObj.eventtype === 'event' && event?.target){
                  if(this.elementIndex && event?.target?.classList.contains("execute-action")) {
                    stateIndex = this.elementIndex;
                  } else {
                    const stateElement = event.target.closest(".cf-vlocity-state")
                     ? event.target.closest(".cf-vlocity-state")
                     : null;
                    if (stateElement?.dataset.rindex) {
                    stateIndex = parseInt(stateElement.dataset.rindex, 10);
                    }
                  }
                }
                if(eventObj.actionList && eventObj.actionList.length > 0){
                  this.fireMultipleActionRecursively(eventObj, 0, null, eventIndex, event, stateIndex, data);
                }
              }
          }