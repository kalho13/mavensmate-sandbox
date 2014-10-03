function addLoadEvent(func) { 
       var oldonload = window.onload;
       if (typeof window.onload != 'function') {
          window.onload = func;
       } else {
          window.onload = function() {
             oldonload();
             func();
            }
        }
     }

     addLoadEvent(
     function() {
        if (GBrowserIsCompatible()) {
       	 console.log('1');
           var my_geocoder = new GClientGeocoder();
           var map = new GMap2(document.getElementById("map"));
           var TC = new GMapTypeControl();
           var bottomRight = new GControlPosition(G_ANCHOR_BOTTOM_RIGHT, new GSize(10,10));
           var mCount =0;

           map.addControl(new GSmallMapControl()); // Small arrows     
           map.addControl(TC, bottomRight);  // Map type buttons 
    

           function LTrim( value ) {
              var re = /\s*((\S+\s*)*)/;
              return value.replace(re, "$1");
           }

           function RTrim( value ) {
              var re = /((\s*\S+)*)\s*/;
              return value.replace(re, "$1");
           }

           // Remove leading and ending whitespaces     
           function trim( value ) {
           		console.log('value ' + value);
              return LTrim(RTrim(value));
           }
	 	console.log('2');
           function doAddLocationToMap(SiteName, Street, City, State, Zip, typ) {
              var addr = Street + ", " + City + ", " + State + " " + Zip;
              console.log('3');
              console.log('addr ' + addr);
              my_geocoder.getLatLng (addr, 
              function(point) {
              console.log('point is ' + point);
                 if (point) {
                    var mTag = '';
                    var myIcon = new GIcon(G_DEFAULT_ICON);
                    console.log('4');

                    if(typ == 'self') {
                       mTag = "<b>" + SiteName + "</b>" + "<br>" + City ;
                       myIcon.image = "http://maps.google.com/mapfiles/arrow.png";
                       myIcon.iconSize=new GSize(32,32);
                    } else { 
                       if(typ == 'acct') {
                          mCount ++;
                          var priAr = SiteName.split(":"); 
                          var compName = priAr[0];  // company name 
                          console.log(priAr[0]);
    
                          var pri = trim(priAr[1]); // priority 
                           console.log(trim(priAr[1]));
    
                          var acctId = priAr[2]; //account id 
                           console.log(priAr[2]);
    
                          var index = "";
                          var imgName = "marker"; // default marker image 
    
                          var color = ""; 

                          mTag = "<b>" + compName + "</b>" + "<br>"
                                 + "Priority: " 
                                 +  pri  + "<br>" + City ;
                          // Set up marker colors based on priority 
    						console.log(mTag);
                          if (pri == 'Medium') color="Yellow"; 
                          else if (pri == 'High') color="Red"; 
                          else if (pri == 'Low') color="Green";

                          if(mCount>10){ // use default marker 
    
                             myIcon.image = 
                                "http://maps.google.com/mapfiles/marker.png";
                          } else { // use custom marker 1-10 
    
                             index = String(mCount);
                             imgName = imgName + color + index + ".png";
                            // myIcon.image = "{!URLFOR($Resource.markers, 'markers/" + imgName + "')}";  
                          }

                          document.getElementById(acctId).src = myIcon.image;
                          myIcon.iconSize=new GSize(20,34);
                       }
                    }
                    myIcon.shadowSize=new GSize(56,32);
                    myIcon.iconAnchor=new GPoint(16,32);
                    myIcon.infoWindowAnchor=new GPoint(16,0);
                    markerOptions2 = { icon:myIcon };
                    var marker = new GMarker(point, markerOptions2);
                    map.setCenter(point, 8);
                    map.addOverlay(marker);

                    // Set up listener action to show info on click event 
    
                    GEvent.addListener(marker, "click", 
                       function() { 
                          marker.openInfoWindowHtml(mTag); 
                       }) ;
                 }else {console.log('NO point');}
              }
              );
           }

           //Get accts and draw address 
    
           var arAllStr = '';
           arAllStr ='{!AddrArStr}'; // Get all address recs  
           console.log(arAllStr.length);
           console.log('{!help}');
    
           var arLi = arAllStr.split("~::~"); // Split on line break delim 
    
           for (var i = 0; i < arLi.length-1; i++) {  
              var arLiStr =arLi[i];
              var arCols =arLiStr.split("~:~"); //Split  to get columns 
    

              if(arCols[1].length >0)
                 doAddLocationToMap(arCols[0],arCols[1],arCols[2],
                                    arCols[3],arCols[4],'acct');     
           }
          console.log(arLi[0]);
          console.log(arLi[1]);
          

           //Get user address and draw 
    
           doAddLocationToMap('{!$User.FirstName} {!$User.LastName}'
                 +' (Me)','{!$User.Street}','{!$User.City}','{!$User.State}','{!$User.PostalCode}','self');
        } 
    }
    );