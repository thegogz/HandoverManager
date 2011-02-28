public class ItemListWrapper {
	public string ItemType{get; set;}
	public List<HandOverItemWrapper> handoveritems{get;set;}
	public boolean hasactivate{get{if(hasactivate == null){return false;}else{return hasactivate;}}set;}
	public boolean hasSetPrimary{get{if(hasSetPrimary == null){return false;}else{return hasSetPrimary;}}set;}
	public boolean hasSetSecondary{get{if(hasSetSecondary == null){return false;}else{return hasSetSecondary;}}set;}
	
	
	public ItemListWrapper(string itemtype, List<HandoverItemWrapper> hi){
		this.handoveritems = hi;
		this.ItemType = itemtype;
		if(this.ItemType == 'Inactive'){
			this.hasActivate = true;
		}
		if(this.ItemType == 'Secondary'){
			this.hasSetPrimary = true;
		}
		if(this.ItemType == 'Primary'){
			this.hasSetSecondary = true;
		}
	}
	
}