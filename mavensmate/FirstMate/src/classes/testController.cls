public with sharing class testController {
	
	public String selectedValue{	
		get;
		set{editMode = (value!=null);
		}
	}
	
	public Boolean editMode{get; private set;}

}