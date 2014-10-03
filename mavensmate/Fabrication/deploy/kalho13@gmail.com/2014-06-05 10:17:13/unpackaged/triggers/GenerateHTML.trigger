trigger GenerateHTML on Opportunity (before update) {

	//query all of the related project types
	//use information from the project types to generate the html
	//how to breakout multiple courses in html?  Maybe and html field per or all of the data in a single field
	//single field sounds best as the page breaks can be added later

	String htmlBegin;
	String courseModel;
	String courseOverview;
	String courseDelivery;
	String courseInstallation;
	String courseElements;
	String courseSafetySystems;
	String courseType;
	String title;
	String overview;
	String mutant;
	List<String> listProjectTypes = new List<String>();
	List<String> listProjectElements = new List<String>();
	List<String> listTraining = new List<String>();
	List<String> listInstallation = new List<String>();
	List<String> listOverview = new List<String>();
	List<String> listSkyTrailOverview = new List<String>();
	List<String> listSkyRailOverview = new List<String>();
	List<String> listSkyTykesOverview = new List<String>();
	List<String> listCTSZipOverview = new List<String>();
	List<String> listOptions = new List<String>();
	List<String> listEntranceBarriers = new List<String>();

	 for(Opportunity opp : trigger.new){ 

	 	List<Project_Module__c> projectsModules = [
	 		SELECT 
	 			Additional_Bracing__c,
	 			Additional_Plan_Sets__c,
	 			Capacity__c,
	 			Ceiling_Height__c,
	 			Close_Date__c,
	 			Column_Color__c,
	 			Compression_Beam_Height__c,
	 			Concrete_Slab_Thickness__c,
	 			ConnectionReceivedId,
	 			ConnectionSentId,
	 			Course_Length__c,
	 			Course_Location__c,
	 			Course_Model__c,
	 			Course_Width__c,
	 			CTS_Zip_Trolleys__c,
	 			Days_On_Site__c,
				Deluxe_Track_Stops__c,	 			
	 			Engineering_Complete_Date__c,
	 			Engineering_Complete__c,
	 			Entrance_Barrier__c,
	 			Entrance_Clearances__c,
	 			Fabrication_Complete_Date__c,
	 			Fabrication_Complete__c,
	 			Final_Platform_Height__c,
	 			Finished_Floor_Material__c,
	 			Galvanized__c,
	 			Harness_Type__c,
	 			Id,
	 			Increased_Height__c,
	 			Installation_Budget__c,
	 			Installation_End_Date__c,
	 			Installation_Notes__c,
	 			Installation_Start_Date__c,
	 			Installed_By__c,
	 			Job_Number__c,
	 			Large__c,
	 			Medium__c,
	 			Mezzanine_Entrance__c,
	 			Module_Cost__c,
	 			Module_Revenue__c,
	 			Module_Type__c,
	 			Name,
	 			Number_of_Days_On_Site__c,
	 			Number_of_Elements__c,
	 			Number_of_Harness_Racks__c,
	 			Number_of_ETKs__c,
	 			Number_of_Inclines__c,
	 			Number_of_Installers__c,
	 			Number_of_Levels__c,
	 			Number_of_Poles__c,
	 			Number_of_Zip_Towers__c,
	 			Number_One_Way_Inclines__c,
	 			Number_Two_Way_Inclines__c,
	 			On_Site_Equipment__c,
	 			Operator_Sling_Lines__c,
	 			Opportunity__c,
	 			Overhead_Color__c,
	 			Paint_Complete_Date__c,
	 			Paint_Complete__c,
	 			Paint_Scheme__c,
	 			Paint_Type__c,
	 			Parallel_With_Course__c,
	 			Participant_Sling_Lines__c,
	 			Platform_Color__c,
	 			Price_Book__c,
	 			Primer_Type__c,
	 			Product__c,
	 			Queueing__c,
	 			RFID_Package__c,
	 			Sandblasted__c,
	 			Send_Weld_Reports__c,
	 			Serial_Number__c,
	 			Sky_Rail_Length__c,
	 			Select_Sky_Rail_Design__c,
	 			Sky_Tykes_StandAlone__c,
	 			Slider_Assembly__c,
	 			Sling_Line_Color__c,
	 			Sling_Line_Model__c,
	 			Small__c,
	 			Special_Element_Requests__c,
	 			StandAlone__c,
	 			State_Stamp__c,
	 			Status__c,
	 			Steel_Certifications_Required__c,
	 			SystemModstamp,
	 			Third_Party_NDT__c,
	 			Top_Of_Steel_Height__c,
	 			Training_Certificate_Date__c,
	 			Training_Course_s__c,
	 			Training_Date_End__c,
	 			Training_Date_Start__c,
	 			Training_Participants__c,
	 			Training_Site__c,
	 			Trolley_Model__c,
	 			Type_of_Training__c,
	 			Walk_the_Plank_Elements__c,
	 			Weight__c,
	 			Wire_Rope_Diamater__c,
	 			X_Small_Quantity__c,
	 			Zip_Line_Distance_s__c,
	 			Zip_Line_Tower_Height_s__c 
	 	 	FROM Project_Module__c WHERE Opportunity__r.Id =: opp.Id Order By Sort_Order__c];

	 	 	Map<String, Map<String, Integer>> modelDetails = new Map<String, Map<String, Integer>>();
	 	
	 	 	for(Project_Module__c p: projectsModules){ 				 

	 	 		if(p.Module_Type__c=='Sky Trail'){

	 	 			String header;

	 	 			if(p.Course_Model__c=='Sky Tykes'){
	 	 				header = '<b>'+  p.Course_Model__c +'&#8482 ' +  ' - ' + p.Number_of_Poles__c + ' Pole, ' + p.Number_of_Levels__c + ' Level';
	 	 			}else{
	 	 				header = '<b>'+  p.Module_Type__c + '&#174; ' + p.Course_Model__c +  ' - ' + p.Number_of_Poles__c + ' Pole, ' + p.Number_of_Levels__c + ' Level';	 	 				
	 	 			}
	 	 			
	 	 			String inclines = '';
	 	 			String elements;
	  				Integer elementCount = 0;
	 	 
	  				if(p.Number_One_Way_Inclines__c > 0){inclines = inclines + ' <b>'+ p.Number_One_Way_Inclines__c + '</b> One-Way Inclined Element(s), ';	}
	  				if(p.Number_Two_Way_Inclines__c > 0){inclines = inclines  + ' <b>'+ p.Number_Two_Way_Inclines__c + '</b> Two-Way Inclined Element(s), ';	}	 

	  				elements =header + '</b></br>The course has ' + inclines + '<b>'+p.Number_of_Elements__c + '</b>' + ' Standard Elements, for a total of ' + '<b>'+String.valueOf(elementCount)+'</b>'+
	  						 ' elements on the course.  ' + 'Maximum Capacity: ' + '<b>'+p.Capacity__c+'</b>' ;

	  				/* Now if it is a Sky Tykes tyhere is some different stuff than a Sky Trail */
	 	 			if(p.Course_Model__c=='Sky Tykes'){

	 	 					if(p.Sky_Tykes_StandAlone__c == true){ /*If it is a standalone the language is a little different */
	 	 						listSkyTykesOverview.add(header + ' Overview </b>' + '</br>The course will be built on ' + 
	 										p.Number_of_Poles__c + ' steel poles. </br>Overall Length: ' + p.Course_Length__c + ', Overall Width: ' + p.Course_Width__c + ', Top Of Steel Height: ' + 
	 										p.Top_Of_Steel_Height__c + 	'. </br>The color scheme is ' + p.Paint_Scheme__c + ': ' + p.Overhead_Color__c + ', ' + p.Column_Color__c + ', ' + p.Platform_Color__c + '.');
	 	 							

	 	 						}else{/*If it is a integrated the language is a little different */
	 	 							listSkyTykesOverview.add('<b>'+ 'Integrated ' + p.Number_of_Poles__c + ' Pole ' + p.Course_Model__c + ' Overview </b>' + '</br>The course will be built on ' + p.Number_of_Poles__c + 
	 										' steel poles. </br>Overall Length: ' + p.Course_Length__c + ' , Overall Width: ' + p.Course_Width__c + ' , Top Of Steel Height: ' + p.Top_Of_Steel_Height__c + '. </br>The color scheme is ' +
	 										p.Paint_Scheme__c + ': ' + p.Overhead_Color__c + ', ' + p.Column_Color__c + ', ' + p.Platform_Color__c + '.');
	 	 							
	 	 						}
	 	 				}else{	
	 	 					//as these are Sky Trail only the remainder of the courses need to be lumped into a single grouping.  This includes the sky rail as well

	 	 				/* Not a Sky Tykes so must be another model of the Sky Trail */
	 						listOverview.add('<b>'+ p.Module_Type__c + '&#174; ' + p.Course_Model__c + ' ' + p.Number_of_Poles__c + ' Pole ' +  p.Number_of_Levels__c + ' Level Overview</b></br>The course will be built on ' + 
	 										p.Number_of_Poles__c + ' steel poles. </br>Overall Length: ' + p.Course_Length__c + ', Overall Width: ' + p.Course_Width__c + ', Top Of Steel Height: ' + p.Top_Of_Steel_Height__c + 
	 										'. </br>The color scheme is ' + p.Paint_Scheme__c + ': ' + p.Overhead_Color__c + ', ' + p.Column_Color__c + ', ' + p.Platform_Color__c + '.');
	 						
	 				}

	  			
	  				listProjectElements.add(elements);	  				
	  				listEntranceBarriers.add(header + '</b></br>' + p.Entrance_Barrier__c + ' entrance barrier(s) are included in the  final purchase price (as shown in attached images).');	 

	  				String options = '';
	  				if(p.Queueing__c==true){options = options + '<li>Queueing</li>'; }
	  				if(p.Send_Weld_Reports__c==true){options = options + '<li>Send Weld Reports</li>';}
	  				if(p.Third_Party_NDT__c==true){options = options + '<li>Third Party Non-Destructive Testing</li>';}
	  				if(p.Walk_the_Plank_Elements__c > 0){options = options + '<li>' + p.Walk_the_Plank_Elements__c + ' Walk the Plank Elements</li>';}
	  				if(p.Galvanized__c==true){options = options + '<li>Galvanized</li>';}
	  				if(p.State_Stamp__c==true){options = options + '<li>State Engineering Stamp</li>';}
	  				if(p.Steel_Certifications_Required__c==true){options = options + '<li>Steel Certifications</li>';}
	  				if(p.Additional_Bracing__c==true){options = options + '<li>Additional Bracing</li>';}
	  				if(p.Deluxe_Track_Stops__c > 0){options = options + '<li>' + p.Deluxe_Track_Stops__c + ' Deluxe Track Stops</li>';}
	  				if(p.Sandblasted__c==true){options = options + '<li>Sandblasted</li>';}
	  				if(p.Mezzanine_Entrance__c==true){options = options + '<li>Mezzanine Entrance</li>';}
	  				if(p.Additional_Plan_Sets__c==true){options = options + '<li>Additional Plan Sets</li>';}
					if(p.Increased_Height__c==true){options = options + '<li>Increased Course Height</li>';}

					options = header + '</b></br>' + options;


					listOptions.add(options);
	  			
	  				/* Update all of the values if one of the modules is a Sky Rail */
	 	 		} else if(p.Module_Type__c=='Sky Rail'){
	 	 			String skyRailHeader;
	 	 			//in some cases the wording is slightly different for output vs. parallel Sky Rails

	 	 			if(p.Select_Sky_Rail_Design__c!='standAlone'){
		
	 	 				
	 	 			}else{
	 	 				skyRailHeader = '<b>Stand Alone ' + p.Module_Type__c + ' ~ ' + p.Sky_Rail_Length__c.round() + ' in length'; 	 			

	 	 			}	//These are the same whether Stand Alone or in parallel
	 					listProjectTypes.add(skyRailHeader);
	 					listSkyRailOverview.add(skyRailHeader+' Overview</b>. </br>The color scheme is ' + p.Paint_Scheme__c + ': ' + p.Overhead_Color__c + ', ' + p.Column_Color__c + ', ' + p.Platform_Color__c );
	 					listEntranceBarriers.add(skyRailHeader + '.</b></br>' + p.Entrance_Barrier__c + ' entrance barrier(s) are included in the final purchase price (as shown in attached images).');	


	 				/* Update all of the values if one of the modules is a CTS Zip */
	 			}else if(p.Module_Type__c=='CTS Zip Line'){

	 				listProjectTypes.add(p.Module_Type__c + ' ~ ' + p.Zip_Line_Distance_s__c + ' Feet');
	 				listEntranceBarriers.add('<b>' + p.Module_Type__c + ' ~ ' + p.Zip_Line_Distance_s__c + ' Feet</b></br>' + p.Entrance_Barrier__c + ' entrance barrier(s) are included in the final purchase price (as shown in attached images).');
	 			}else if(p.Module_Type__c=='Training'){	 				

	 				listTraining.add('Training conducted at ' + p.Training_Site__c +  ' location for ' + p.Training_Participants__c + ' participants ' );

	 			}else if(p.Module_Type__c=='Installation'){

	 				listInstallation.add('Installation performed by ' + p.Installed_By__c );

	 			}else{

	 			}// end for project types
	 		} //end for
		   
		   //	renderDeliveryHtml(opp);
		    renderHtmlFields(
		    				opp,
		    				listProjectElements, 
		    				listInstallation, 
		    				listTraining, 
		    				listOverview,
		    				listSkyRailOverview,
		    				listSkyTykesOverview,		    			
		    				listEntranceBarriers,
		    				listOptions
		    				);

		}//end for Opportunity

		private void renderHtmlFields(
										Opportunity opp, 
										List<String> projectElements, 
										List<String> projectTraining, 
										List<String> projectInstallation,  										
										List<String> projectOverviews,
										List<String> projectSkyRailOverview,
										List<String> projectSkyTykesOverview,								
										List<String> projectEntranceBarriers,
										List<String> projectOptions							
										){

			opp.htmlElements__c = '<ul>';			
			opp.htmlProjectTypes__c = '<ul>';
			opp.htmlInstallation__c = '';
			opp.htmlTraining__c='';		
			opp.htmlProjectOverviews__c = '<ul>';
			opp.htmlProjectSkyRailOverview__c = '<ul>';
			opp.htmlSkyTykesOverview__c = '<ul>';		
			opp.htmlEntranceBarriers__c = '<ul>';
			opp.htmlOptions__c = '<ul>';


			for (String i :projectElements) {opp.htmlElements__c = opp.htmlElements__c + i + '</br></br>';}

			for (String i :projectInstallation) {opp.htmlInstallation__c = opp.htmlInstallation__c + i ;}

			for (String i :projectTraining) {opp.htmlTraining__c = opp.htmlTraining__c + i ;}

			for (String i :projectOverviews) {opp.htmlProjectOverviews__c = opp.htmlProjectOverviews__c + '<li>' + i + '</li></br>';}

			for (String i :projectSkyRailOverview) {opp.htmlProjectSkyRailOverview__c = opp.htmlProjectSkyRailOverview__c + '<li>' + i + '</li></br>';}

			for (String i :projectSkyTykesOverview) {opp.htmlSkyTykesOverview__c = opp.htmlSkyTykesOverview__c + '<li>' + i + '</li></br>';	}			
			
			for (String i :projectEntranceBarriers) {opp.htmlEntranceBarriers__c = opp.htmlEntranceBarriers__c + '<li>' + i + '</li></br>';	}

			for (String i :projectOptions) {opp.htmlOptions__c = opp.htmlOptions__c +  i + '</br>';	}

			

			opp.htmlProjectOverviews__c = opp.htmlProjectOverviews__c +'</ul>';
			opp.htmlProjectSkyRailOverview__c = opp.htmlProjectSkyRailOverview__c + '</ul>';
			opp.htmlSkyTykesOverview__c = opp.htmlSkyTykesOverview__c + '</ul>';				
			opp.htmlEntranceBarriers__c =  opp.htmlEntranceBarriers__c +'</ul>';
			opp.htmlOptions__c =  opp.htmlOptions__c +'</ul>';
			
		}

	

}