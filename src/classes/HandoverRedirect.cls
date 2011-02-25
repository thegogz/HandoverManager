public class HandoverRedirect {
	public PageReference redirect(){
		PageReference pg = Page.HandoverOverView;
		Id latesthandover = [Select id from Handover__c order by createddate desc Limit 1].id;
		pg.getParameters().put('id', latesthandover);
		pg.setredirect(true);
		return pg; 
	}

}