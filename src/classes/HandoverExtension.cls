public class HandoverExtension {
	public Handover__c currentHandover {get; set;}
	public Handover__c newhandover{get;set;}
	public List<ItemListWrapper> items{get;set;}
	//is new handover definition
	public boolean isnewHandover{get; set;}
	//Extension Constructor
	public HandoverExtension(ApexPages.StandardController cont){
		this.currentHandover = (Handover__c)cont.getRecord();
 		this.isnewHandover = false;
 		this.items = new List<ItemListWrapper>();
	}
	List<integer> mylist = new List<integer>();
	
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
	
	//create Item list
	public static List<ItemListWrapper> populateItemLists(){
		for(Handover_Item__c i: [Select h.Work_Item_IR__c, h.OwnerId, h.Name, h.type__c, h.LastModifiedDate, h.LastModifiedById, h.Id, h.Description_Notes__c, h.CreatedDate, h.CreatedById, h.Active__c From Handover_Item__c h where (h.Active__c = true OR h.LastModifiedDate >= LAST_N_DAYS:3)]){
			 itemlistwrapper iw = new itemlistwrapper();
			 
		}
		return null;
	}	
}