public class ItemListWrapper {
	public string ItemType{get; set;}
	public List<HandOverItemWrapper> handoveritems{get;set;}
	
	public ItemListWrapper(string itemtype, List<HandoverItemWrapper> hi){
		this.handoveritems = hi;
		this.ItemType = itemtype;
	}
	
}