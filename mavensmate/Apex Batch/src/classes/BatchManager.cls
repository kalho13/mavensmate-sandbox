public class BatchManager {

	public String job;
	public BatchManager() {
		
	}

	public void RunBatch(){
		job = ApexPages.currentPage().getParameters().get('job');
		System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$ EXECUTE BATCH  for job ' + job + ' $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
		//MergeJobParts b = new MergeJobParts(job);
		//Database.execute(b, 10);
		Id batchInstanceId = Database.executeBatch(new MergeJobParts(job), 200); 
	


	}
}