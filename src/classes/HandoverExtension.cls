public class HandoverExtension {
	public Handover__c currentHandover {get; set;}
	public Handover__c newhandover{get;set;}

	//is new handover definition
	public boolean isnewHandover{get; set;}
	//Extension Constructor
	public HandoverExtension(ApexPages.StandardController cont){
		this.currentHandover = (Handover__c)cont.getRecord();
 		this.isnewHandover = false;
	}
	
	//create new handover method. Automatically sets the From/To based on Current Region
	public pageReference createNew(){
		newhandover = new Handover__c(KPI_all_green__c=true);
		newhandover.Handover_From__c = currenthandover.Handover_To__c;
		if(newhandover.Handover_from__c == 'ASG'){
			newhandover.handover_to__c = 'SIN';
		} else if(newhandover.Handover_from__c == 'SIN'){
			newhandover.handover_to__c = 'DUB';
		} else {
			newhandover.handover_to__c = 'ASG';
		}
		isnewHandover = true;
		return null;
	} 
	
	//Ack method. 
	public pageReference ack(){
		currenthandover.Acknowledged__c = true;
		currenthandover.Acknowledged_By__c = Userinfo.getUserId();
		update currenthandover;
		return null;
	}
		
	//item wrapper list for use on page. 
	public List<HandoverItemWrapper> items {
		get{
			List<HandoverItemWrapper> handoveritems = new List<HandoverItemWrapper>();
			for(Handover_Item__c i: [Select h.Work_Item_IR__c, h.OwnerId, h.Name, h.type__c, h.LastModifiedDate, h.LastModifiedById, h.Id, h.Description_Notes__c, h.CreatedDate, h.CreatedById, h.Active__c From Handover_Item__c h where (h.Active__c = true OR h.LastModifiedDate >= LAST_N_DAYS:3)]){
				if(i.type__c == 'Maintainance' && i.active__c){
					hasMaintainanceItems = true;
				} else if(i.type__c == 'Notice Board' && i.active__c){
					hasNoticeBoardItems = true;
				} else if(i.type__c == 'Primary' && i.active__c){
					hasPrimaryItems = true;
				} else if(i.type__c == 'Secondary' && i.active__c){
					hasSecondaryItems = true;
				} else {
					hasInactiveItems = true; 
				}
				handoveritems.add(new HandoverItemWrapper(i));
			}
			return handoveritems;
		} 
		set;
	}
		
	//has maintainance items (show maintainance list)
	public boolean hasMaintainanceItems{
		get{
			if(hasMaintainanceItems == null){
				return false;
			} else {
				return true;
			}
		}
		set;
	}
	//has Notice Board items (show Notice Board list)
	public boolean hasNoticeBoardItems{
		get{
			if(hasNoticeBoardItems == null){
				return false;
			} else {
				return true;
			}
		}
		set;
	}
	//has Primary items (show Primary list)
	public boolean hasPrimaryItems{
		get{
			if(hasPrimaryItems == null){
				return false;
			} else {
				return true;
			}
		}
		set;
	}
	//has Secondary items (show Secondary list)
	public boolean hasSecondaryItems{
		get{
			if(hasSecondaryItems == null){
				return false;
			} else {
				return true;
			}
		}
		set;
	}
	//has Inactive items (show Inactive list)
	public boolean hasInactiveItems{
		get{
			if(hasInactiveItems == null){
				return false;
			} else {
				return true;
			}
		}
		set;
	}

}