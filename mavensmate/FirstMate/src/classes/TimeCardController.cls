public class TimeCardController{ 

/*
    private ApexPages.StandardController controller;

    public TimeCardController(ApexPages.StandardController controller) {
    this.controller = controller;

    }
*/
   

private Time_Card__c timeCard;

Boolean showEdit;
Integer mTotal = 0;
Integer tTotal = 0;
Integer wTotal = 0;
Integer thTotal = 0;
Integer fTotal = 0;
Integer sTotal = 0;
Integer suTotal = 0;

public TimeCardController() {
            timeCard = [select 
                            name,Total_Hours_Week__c,Employee_Name__c,Complete__c,Week_Ending__c,Monday__c,Monday_Breakfast__c,Monday_Lunch__c,Monday_Dinner__c,
                            Tuesday__c,Tuesday_Breakfast__c,Tuesday_Lunch__c,Tuesday_Dinner__c,Wednesday__c,Wednesday_Breakfast__c,Wednesday_Lunch__c,Wednesday_Dinner__c,
                            Thursday__c,Thursday_Breakfast__c,Thursday_Lunch__c,Thursday_Dinner__c,Friday__c,Friday_Breakfast__c,Friday_Lunch__c,Friday_Dinner__c,
                            Saturday__c,Saturday_Breakfast__c,Saturday_Lunch__c,Saturday_Dinner__c,Sunday__c,Sunday_Breakfast__c,Sunday_Lunch__c,Sunday_Dinner__c,
                            Install_Project__r.Job_Number__c, status__c, Total_PerDiem__c, Monday_PerDiem__c , Tuesday_PerDiem__c, Wednesday_PerDiem__c, Thursday_PerDiem__c,
                            Friday_PerDiem__c, Saturday_PerDiem__c, Sunday_PerDiem__c , id 
                            from Time_Card__c where id =:ApexPages.currentPage().getParameters().get('id')];
                            
                            /*
                            if(timeCard.Status__c == ''){
                            showEdit=true;
                             system.debug('######## showEdit = true -  '  + timeCard.Status__c == '');
                            }else{
                             system.debug('######## Status not blank #########');
                             system.debug('######## '  + timeCard.Status__c == '');
                            }
                            */
                            // showContent = true;
                             showEdit= true;
                            if(timeCard.Status__c=='Submitted'){showEdit=False;}
                            
                            // timeCard.Complete__c = false;                               
                           //  if(timeCard.Complete__c){ showContent = false; }
                            }

    public Time_Card__c getTimeCard() { return timeCard;}      
 
    //public Boolean getMarkComplete(){return true;}
    
    public PageReference autoRun(){
     system.debug('######## AUTORUN #########');
     return null;
    }
    
    public PageReference submit(){
         timeCard.Status__c = 'Submitted';
         showEdit=false;
         save();
         return null;
    }
    
     public PageReference markComplete(){
         timeCard.Status__c = 'Complete';
         showEdit=false;
         save();
         return null;
    }
    
    private Integer getMondayPerDiem(){
         mTotal = 0;
         if(timeCard.Monday_Breakfast__c){mTotal = mTotal+8;}         
         if(timeCard.Monday_Lunch__c){mTotal = mTotal+12;}         
         if(timeCard.Monday_Dinner__c){mTotal = mTotal+20;}
         return mTotal;
    }
    
    private Integer getTuesdayPerDiem(){
           tTotal = 0;
         if(timeCard.Tuesday_Breakfast__c){tTotal = tTotal+8;}         
         if(timeCard.Tuesday_Lunch__c){tTotal = tTotal+12;}         
         if(timeCard.Tuesday_Dinner__c){tTotal = tTotal+20;}
         return tTotal;
    }
    
    private Integer getWednesdayPerDiem(){
        wTotal = 0;
         if(timeCard.Wednesday_Breakfast__c){wTotal = wTotal+8;}         
         if(timeCard.Wednesday_Lunch__c){wTotal = wTotal+12;}         
         if(timeCard.Wednesday_Dinner__c){wTotal = wTotal+20;}
         return wTotal;
    }
    private Integer getThursdayPerDiem(){
        thTotal = 0;
         if(timeCard.Thursday_Breakfast__c){thTotal = thTotal+8;}         
         if(timeCard.Thursday_Lunch__c){thTotal = thTotal+12;}         
         if(timeCard.Thursday_Dinner__c){thTotal = thTotal+20;}
         return thTotal;
    }
    private Integer getFridayPerDiem(){
        fTotal = 0;
         if(timeCard.Friday_Breakfast__c){fTotal = fTotal+8;}         
         if(timeCard.Friday_Lunch__c){fTotal = fTotal+12;}         
         if(timeCard.Friday_Dinner__c){fTotal = fTotal+20;}
         return fTotal;
    }
    private Integer getSaturdayPerDiem(){
        sTotal = 0;
         if(timeCard.Saturday_Breakfast__c){sTotal = sTotal+8;}         
         if(timeCard.Saturday_Lunch__c){sTotal = sTotal+12;}         
         if(timeCard.Saturday_Dinner__c){sTotal = sTotal+20;}
         return sTotal;
    }
    private Integer getSundayPerDiem(){
        suTotal = 0;
         if(timeCard.Sunday_Breakfast__c==true){suTotal = suTotal+8;}         
         if(timeCard.Sunday_Lunch__c){suTotal = suTotal+12;}         
         if(timeCard.Sunday_Dinner__c){suTotal = suTotal+20;}
         return suTotal;
    }
    
    private Integer getTotalPerDiem(){
        Integer total= mTotal + tTotal + wTotal + thTotal + fTotal + sTotal + suTotal;  
        timeCard.Total_PerDiem__c =  total;     
        return total;    
    }    
    
    public PageReference save() {
         system.debug('######## SAVE #########');
         timeCard.Monday_PerDiem__c = getMondayPerDiem();
         timeCard.Tuesday_PerDiem__c = getTuesdayPerDiem();
         timeCard.Wednesday_PerDiem__c = getWednesdayPerDiem();
         timeCard.Thursday_PerDiem__c = getThursdayPerDiem();
         timeCard.Friday_PerDiem__c = getFridayPerDiem();
         timeCard.Saturday_PerDiem__c = getSaturdayPerDiem();
         timeCard.Sunday_PerDiem__c = getSundayPerDiem();
         timeCard.Total_PerDiem__c = getTotalPerDiem();
          system.debug('######## Total PerDiem ######### ' + getTotalPerDiem() );
          system.debug('######## Total PerDiem 2 ######### ' + timeCard.Total_PerDiem__c);
          
         // https://na14.salesforce.com/a07/o
         //a07d0000003bVVh
         UPDATE timeCard;
         
        //pageReference goBack = new  pageReference('/a07/o');
        //goBack.setRedirect(true);
       //  return goBack;
        //return ApexPages.currentPage().getParameters().get('id');
        return null;
    } 
    
    public Boolean getShowEdit(){return showEdit;}
    
    public void setShowEdit(Boolean value){
        this.showEdit=value;
    }
 /*   
    public void getChangePerDiem(){
        system.debug('######## changePerDiem #########');
        timeCard.Monday_PerDiem__c = getMondayPerDiem();
    }
 */  

 public Boolean showContent { get; set; }  
 
 /*  
   public PageReference editContent(){
     if(timeCard.Complete__c){
            showEdit = false; 
            }else{
            showEdit = true;
           }
           return null;      
   } 
  */
   
 }