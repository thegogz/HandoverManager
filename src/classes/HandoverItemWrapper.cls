public class HandoverItemWrapper {
	//Wrapper Class to hold handover Items and Related Functionality for Handover List
	//the Item held in this object
	public Handover_Item__c item{get; set;}
	//Checkbox for Mass Updating
	public Boolean checked{get; set;} 
	
	//constructor for object taking argument of an item
	public HandoverItemWrapper(Handover_Item__c item){
		this.item = item;
		this.checked = false; 
	} 
	
	public PageReference activate_deactivate(){
		if(item.active__c){
			item.active__c = false;
		} else {
			item.active__c = true;
		}
		update item;
		return null;
	}
	
	public PageReference primary_secondary_switch(){
		if(item.type__c == 'Primary'){
			item.type__c = 'Secondary';
			update item;
		} else if (item.type__c == 'Secondary'){
			item.type__c = 'Primary';
			update item;
		}
		return null;
	}
	
	public PageReference edit(){
		PageReference editItem = new ApexPages.StandardController(item).view();
		editItem.setRedirect(true);
		return editItem;
	}
	

}