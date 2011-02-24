public class ItemListWrapper {
	public List<HandOverItemWrapper> MaintainanceItems{get; set;}
	public List<HandOverItemWrapper> NoticeBoardItems{get; set;}
	public List<HandOverItemWrapper> PrimaryItems{get; set;}
	public List<HandOverItemWrapper> SecondaryItems{get; set;}
	public List<HandOverItemWrapper> InactiveItems{get; set;}
	
	public ItemListWrapper(){
		/*if(i.type__c == 'Maintainance' && i.active__c){
			system.debug('##### Maintainance');
			this.hasMaintainanceItems = true;
		} else if(i.type__c == 'Notice Board' && i.active__c){
			this.hasNoticeBoardItems = true;
		} else if(i.type__c == 'Primary' && i.active__c){
			this.hasPrimaryItems = true;
		} else if(i.type__c == 'Secondary' && i.active__c){
			this.hasSecondaryItems = true;
		} else {
			this.hasInactiveItems = true; 
		} */
	} 
}