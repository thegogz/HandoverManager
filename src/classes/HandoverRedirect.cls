public class HandoverRedirect {
	public PageReference redirect(){
		PageReference pg = Page.HandoverOverView;
		Id latesthandover = [Select id from Handover__c where current__c = true].id;
		pg.getParameters().put('id', latesthandover);
		pg.setredirect(true);
		return pg; 
	}

}