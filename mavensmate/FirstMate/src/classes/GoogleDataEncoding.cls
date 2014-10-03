public class GoogleDataEncoding {
	//exceptions to handle any erroneous data
	public class EncodingException extends Exception{}
	public class UnsupportedEncodingTypeException extends Exception{}
	
	/*
		The encoding map which takes an integer key and returns the respective encoding value as defined by Google.
		This map is initialized in init()
	*/
	
	private Map<Integer, String> encodingMap{get;set;}
	
	/* The maximum encoding value supported for the given encoding type.  This value is set during init() 
	*/
	private Integer encodingMax{get;set;}
	private Integer encodingMin{get;set;}
	public enum EncodingType{TEXT, SIMPLE, EXTENDED}
	public Integer min{get; private set;}
	private Integer max{get; private set;}
	public EncodingType eType{get; private set;} //the encoding type defined by Google
	public String dataSet{get;set;}
	public String graph{get;set;}
	public String chartURL{get;set;}
	public Boolean displayChart{get;set;}
	
	public GoogleDataEncoding(){
		min=0;
		max=61;
		eType=EncodingType.SIMPLE;
		displayChart=false;
		init();		
	}
	
	public PageReference create(){
		String[] dataSetList = dataSet.split(',',0);
		String mappedValue='chd=s:';
		
		
			
		chartURL = 'http://chart.apis.google.com/chart?chs=600x300'
					+ '&amp;chtt=Time+vs|Distance&amp;chxt=x,y,x,y'
					+'&amp;chxr=0,0,10,1 | 1,0,65,5'
					+'&amp;chx1=2:|Seconds|3:|Meters';
					
					if(graph.compareTo('barChart')==0){
						chartURL += '&amp;cht=bvs';						
					}else if(graph.compareTo('lineChart')==0){
						chartURL+='&amp;cht=ls';
					}else{
						throw new EncodingException('An unsupported chart type was selected ' + graph + ' does not exist');
					}
					
		for(String dataPoint : dataSetList){
			System.debug('**************** The dataPoint is ' + getEncode(Integer.valueOf(dataPoint.trim())) + ' ******************');
			mappedValue+= getEncode(Integer.valueOf(dataPoint.trim()));
		}
		
		chartURL += '&amp;' + mappedValue;
		System.debug('**************** The mappedValue is ' + mappedValue + ' ******************');
		System.debug('**************** The chartURL is ' + chartURL + ' ******************');
		displayChart=true;
		
		return null;
	}
	
	
	public static String getEncodingDescriptot(EncodingType t){
		if(t==EncodingType.TEXT) return 't';
		else if(t==EncodingType.SIMPLE) return 's';
		else if(t==EncodingType.EXTENDED) return 'e';
		else return '';
	}

	
	public String getEncode(Integer d){
		if(d>max || d<min){
			throw new EncodingException('Value provided ' + d + ' was outside the declared min/max range ( ' + min + '/' + max + ')');
		}else{
			return encodingMap.get(d);
		}
	}
	
	
	public void init(){
		if(eType==EncodingType.SIMPLE){
			encodingMax=61;
			encodingMin=0;
			encodingMap = new Map<Integer, String>();
			encodingMap.put(0,'A');
			encodingMap.put(1,'B');
			encodingMap.put(2,'C');
			encodingMap.put(3,'D');
			encodingMap.put(4,'E');
			encodingMap.put(5,'F');
			encodingMap.put(6,'G');
			encodingMap.put(7,'H');
			encodingMap.put(8,'I');
			encodingMap.put(9,'J');
			encodingMap.put(10,'K');
			encodingMap.put(11,'L');
			encodingMap.put(12,'M');
			encodingMap.put(13,'N');
			encodingMap.put(14,'O');
			encodingMap.put(15,'P');
			encodingMap.put(16,'Q');
			encodingMap.put(17,'R');
			encodingMap.put(18,'S');
			encodingMap.put(19,'T');
			encodingMap.put(20,'U');
			encodingMap.put(21,'V');
			encodingMap.put(22,'W');
			encodingMap.put(23,'X');
			encodingMap.put(24,'Y');
			encodingMap.put(25,'Z');
			encodingMap.put(26,'a');
			encodingMap.put(27,'b');
			encodingMap.put(28,'c');
			encodingMap.put(29,'d');
			encodingMap.put(30,'e');
			encodingMap.put(31,'f');
			encodingMap.put(32,'g');
			encodingMap.put(33,'h');
			encodingMap.put(34,'i');
			encodingMap.put(35,'j');
			encodingMap.put(36,'k');
			encodingMap.put(37,'l');
			encodingMap.put(38,'m');
			encodingMap.put(39,'n');
			encodingMap.put(40,'o');
			encodingMap.put(41,'p');
			encodingMap.put(42,'q');
			encodingMap.put(43,'r');
			encodingMap.put(44,'s');
			encodingMap.put(45,'t');
			encodingMap.put(46,'u');
			encodingMap.put(47,'v');
			encodingMap.put(48,'w');
			encodingMap.put(49,'x');
			encodingMap.put(50,'y');
			encodingMap.put(51,'z');
			encodingMap.put(52,'0');
			encodingMap.put(53,'1');
			encodingMap.put(54,'2');
			encodingMap.put(55,'3');
			encodingMap.put(56,'4');
			encodingMap.put(57,'5');
			encodingMap.put(58,'6');
			encodingMap.put(59,'7');
			encodingMap.put(60,'8');
			encodingMap.put(61,'9');
		}
		
	}
	

}