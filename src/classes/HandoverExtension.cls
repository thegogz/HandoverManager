public class HandoverExtension {
    public Handover__c currentHandover {get; set;}
    public Handover__c newhandover{get;set;}
    public List<ItemListWrapper> imap {get{return populateItemLists();}set;}
    //is new handover definition
    public boolean isnewHandover{get; set;}
    //Extension Constructor
    public HandoverExtension(ApexPages.StandardController cont){
        this.currentHandover = (Handover__c)cont.getRecord();
        this.isnewHandover = false;
        this.imap = populateItemLists();
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
    public PageReference newsave(){
    	system.debug(newhandover); 
    	newhandover.Current__c = true;
    	currenthandover.Current__c = false;
    	update currenthandover;
    	insert newhandover;
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
    public List<ItemListWrapper> populateItemLists(){
        Map<String, List<HandOverItemWrapper>> Items = new Map<String, List<HandOverItemWrapper>>();
        for(Handover_Item__c i: [Select h.Work_Item_IR__c, h.OwnerId, h.Name, h.type__c, h.LastModifiedDate, h.LastModifiedById, h.Id, h.CreatedDate, h.CreatedById, h.Active__c, h.Summary__c From Handover_Item__c h where (h.Active__c = true OR h.LastModifiedDate >= LAST_N_DAYS:3)]){
			if(i.type__c == 'Maintainance' && i.active__c){
				if(!items.containsKey('Maintainance')){
					items.put('Maintainance',new List<HandOverItemWrapper>());
					items.get('Maintainance').add(new HandoverItemWrapper(i));
				} else{
					items.get('Maintainance').add(new HandoverItemWrapper(i));
				}
			} else if(i.type__c == 'Notice Board' && i.active__c){
				if(!items.containsKey('Notice Board')){
					items.put('Notice Board',new List<HandOverItemWrapper>());
					items.get('Notice Board').add(new HandoverItemWrapper(i));
				} else{
					items.get('Notice Board').add(new HandoverItemWrapper(i));
				}
			} else if(i.type__c == 'Primary' && i.active__c){
				if(!items.containsKey('Primary')){
					items.put('Primary',new List<HandOverItemWrapper>());
					items.get('Primary').add(new HandoverItemWrapper(i));
				} else{
					items.get('Primary').add(new HandoverItemWrapper(i));
				}
			} else if(i.type__c == 'Secondary' && i.active__c){
				if(!items.containsKey('Secondary')){
					items.put('Secondary',new List<HandOverItemWrapper>());
					items.get('Secondary').add(new HandoverItemWrapper(i));
				} else{
					items.get('Secondary').add(new HandoverItemWrapper(i));
				}
			} else {
				if(!items.containsKey('Inactive')){
					items.put('Inactive',new List<HandOverItemWrapper>());
					items.get('Inactive').add(new HandoverItemWrapper(i));
				} else{
					items.get('Inactive').add(new HandoverItemWrapper(i));
				}
			}
        }
        List<ItemListWrapper> lilw = new List<ItemListWrapper>();
        for(String s:items.keyset()){
        	ItemListWrapper i = new ItemListWrapper(s,items.get(s));
        	lilw.add(i);
        }
        return lilw;     	
    }   
}