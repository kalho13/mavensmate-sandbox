public interface TriggerInterface {
	
	void MainEntry(
		String TriggerObject,
		Boolean IsBefore,
		Boolean IsDelete,
		Boolean IsAfter,
		Boolean IsInsert,
		Boolean IsUpdate,
		Boolean IsExecuting,
		List<SObject> newList,
		Map<ID, SObject> newMap,
		List<SObject> oldList,
		Map<ID, SObject> oldMap	
	);
	
	
	void InProgressEntry(
		String TriggerObject,
		Boolean IsBefore,
		Boolean IsDelete,
		Boolean IsAfter,
		Boolean IsInsert,
		Boolean IsUpdate,
		Boolean IsExecuting,
		List<SObject> newList,
		Map<ID, SObject> newMap,
		List<SObject> oldList,
		Map<ID, SObject> oldMap	
	);
}