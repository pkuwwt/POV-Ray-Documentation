// POV-Ray 3.6 / 3.7 include file "Seven_Segment_LCD_Display.inc"
// author: Friedrich A, Lohmueller, Aug-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//---------------------------------------------------------------------------------------
// -------------------------  Seven_Segment_LCD_Display --------------------------------- 
// -------------------------  Size: 1 unit = 1mm ---------------------------------------- 
//---------------------------------------------------------------------------------------
#ifndef( Seven_Segment_LCD_Display_Inc_Temp)
#declare Seven_Segment_LCD_Display_Inc_Temp = version;
#version 3.6;
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
// -------------------------------------------------------------------------------------------------- /////////  
// ------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------------
#macro Single_Digit_Seven_Segment_Display ( 
      // choose display type:
         SSB_Type, //  1 ~ 7
// Types of single digit Seven-Segment LED Displays:
// SSB_Type 0 :  7.5 x  14.0  x  8.4, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-360"    , Unity Opto Technology Display: (0.36 inch)   9.14 mm
// SSB_Type 1 :  9.7 x  12.8  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-4301"   , Unity Opto Technology Display: (0.40 inch)   10.0 mm
// SSB_Type 2 :  9.6 x  13.0  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LA-401DN"   , ROHM                  Display: (0.40 inch)   10   mm
// SSB_Type 3 :  9.7 x  12.9  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LTS-4301"   , LITE-ON               Display: (0.40 inch)   10   mm

// SSB_Type 4 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "UVS-546"    , UNi                   Display: (0.52 inch)   13.2 mm
// SSB_Type 5 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "LTS-547 AP" , LITE-ON               Display: (0.52 inch)   13.2 mm
// SSB_Type 6 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "SA52-11EWA" , KINGBRIGHT            Display: (0.52 inch)   13.2 mm
// SSB_Type 7 : 12.7 x  19.0  x  8.3, Pin_Dir= 1;Pin_Row_Dist= 6; "SA56-11EWA" , KINGBRIGHT            Display: (0.56 inch)   14.2 mm 

// SSB_Type 8 : 18.6 x  25.0  x 10.6, Pin_Dir= 0;Pin_Row_Dist= 6;  "SA08-21EWA", KINGBRIGHT            Display: (0.80 inch)  20.3 mm 
// SSB_Type 9 : 22.5 x  27.7  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1001"  , Lucky Light           Display: (1.00 inch)  25.4 mm 
// SSB_Type 10: 24.0 x  33.0  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1002"  , Lucky Light           Display: (1.00 inch)  25.4 mm 

// SSB_Type 11: 28.8 x  40.8  x  9.0, Pin_Dir= 1;Pin_Row_Dist= 14; "KW1-1201"  , Lucky Light           Display: (1.20 inch)  30.4 mm 
// SSB_Type 12: 30.6 x  44.1  x  8.0, Pin_Dir= 1;Pin_Row_Dist= 16; "KW1-1501"  , Lucky Light           Display: (1.50 inch)  38.1 mm 
// SSB_Type 13: 90.0 x 122.0  x 15.0, Pin_Dir= 1;Pin_Row_Dist= 42;Raster=2*2.54;"SA40-19SRWA",KINGBRIGHT Display: (4.00 inch) 100   mm 
             

         SS_Text_On,   // [ 0 = off, 1 = on ]
         Socket_Font,  // = "courbd.ttf"
         DisplayIntegerNumber_, // [ 0, 1, 2,  ..., 9, + hexnumbers: 10=A,11=b, 12=C, 13=d, 14=E, 15=F, degrees: 16="°", minus="-" ] 
         Point_On_,                  // [ 0 = off, 1 = on ] 
         ActiveLED_Texture_Number_,  // [ 0 = white, 1 = red, 2 = orange, 3 = amber ,4 = yellow, 5 =green, 6 = blue, 7= violet] 
         InactiveLED_Texture_Number_,// [ 0 = dark gray, 1 = light gray, 2 = transparent1, 3 = transparent2, 4 = amber]
         DisplaySkin_Texture_Number_,// [ 0 = near black, 1 = dark gray, 2 = medium gray, 3 = light gray ] 

         Segment_Type_,  // 0 = angular, 1 = more curved // 

         PackageView_0n_, //  = 0 or 1 )
	 FootPrint_On_, //  = 0 or 1 )
       ) // ---------------------------------------------------------------------------------------------------
 
// ------------------------------------------------------------------------------------------------------------
#declare Pin_Raster_Base = 2.54 ; // raster 2.54 

// ----------------------------------------------------
// basic Pin_Raster = 2.54; // 0.1 inch
#switch ( SSB_Type )                                             

#case (0) #declare SS_Name = "UVS-360";   #declare SS_Manufacturer = "UNi"  #declare Display_in = 0.36; #declare Display_mm = 9.14;  //Unity Opto Technology Co., Ltd      
 #declare SSB_x =  7.5; #declare SSB_z = 14.0; #declare SSB_y = 8.44; #declare SSB_yi= 7.8;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 1; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 0; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 2; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (1) #declare SS_Name = "UVS-4301";   #declare SS_Manufacturer = "UNi"  #declare Display_in = 0.40; #declare Display_mm = 10.0;  //Unity Opto Technology Co., Ltd      
 #declare SSB_x =  9.7; #declare SSB_z = 12.8; #declare SSB_y = 7.00; #declare SSB_yi= 6.4;  
 #declare SS_Pin_R = 0.15;                     #declare SSB_Base_Cut  = 0; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 0; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 2; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (2) #declare SS_Name = "LA-401DN";   #declare SS_Manufacturer = "ROHM"    #declare Display_in = 0.40; #declare Display_mm = 10;        
 #declare SSB_x =  9.6; #declare SSB_z = 13.0; #declare SSB_y = 7.0;#declare SSB_yi= 6.4;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 0;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 0; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 3; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (3) #declare SS_Name = "LTS-4301";   #declare SS_Manufacturer = "LITE-ON" #declare Display_in = 0.40; #declare Display_mm = 10;        
 #declare SSB_x =  9.7; #declare SSB_z = 12.9; #declare SSB_y = 7.0;#declare SSB_yi= 6.4;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 1;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 0; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 3; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 

#case (4) #declare SS_Name = "UVS-546";   #declare SS_Manufacturer = "UNi"  #declare Display_in = 0.52; #declare Display_mm = 13.2;  //Unity Opto Technology Co., Ltd      
 #declare SSB_x = 12.4; #declare SSB_z = 17.55; #declare SSB_y = 7.00; #declare SSB_yi= 6.4;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 1 ; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 6; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (5) #declare SS_Name = "LTS-547 AP";  #declare SS_Manufacturer = "LITE-ON" #declare Display_in = 0.52; #declare Display_mm = 13.2;        
 #declare SSB_x = 12.4; #declare SSB_z = 17.55;#declare SSB_y = 7.0;#declare SSB_yi= 6.4; 
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 1;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 6; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (6) #declare SS_Name = "SA52-11EWA";  #declare SS_Manufacturer = "KINGBRIGHT" #declare Display_in = 0.52; #declare Display_mm = 13.2;        
 #declare SSB_x = 12.4; #declare SSB_z = 17.55;#declare SSB_y = 7.0;#declare SSB_yi= 6.4; 
 #declare SS_Pin_R = 0.25;                                         #declare SSB_Base_Cut  = 0;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 6; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (7) #declare SS_Name = "SA56-11EWA";  #declare SS_Manufacturer = "KINGBRIGHT" #declare Display_in = 0.56; #declare Display_mm = 14.2;        
 #declare SSB_x = 12.7; #declare SSB_z = 19.00;#declare SSB_y = 8.3;#declare SSB_yi= 6.4;  
 #declare SS_Pin_R = 0.25;                                         #declare SSB_Base_Cut  = 0;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 6; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 

#case (8) #declare SS_Name = "SA08-21EWA";  #declare SS_Manufacturer = "KINGBRIGHT" #declare Display_in = 0.80; #declare Display_mm = 20.3;        
 #declare SSB_x = 18.6; #declare SSB_z = 25.0; #declare SSB_y = 10.6;#declare SSB_yi= 9.0;  
 #declare SS_Pin_R = 0.25;                                         #declare SSB_Base_Cut  = 0;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 0; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 6; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (9) #declare SS_Name = "KW1-1001";   #declare SS_Manufacturer = "Lucky Light"  #declare Display_in = 1.00; #declare Display_mm = 25.4;       
 #declare SSB_x = 22.50; #declare SSB_z = 33.00; #declare SSB_y = 10.50; #declare SSB_yi= 8.2;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 0; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 12; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (10) #declare SS_Name = "KW1-1002";   #declare SS_Manufacturer = "Lucky Light"  #declare Display_in = 1.00; #declare Display_mm = 25.4;       
 #declare SSB_x = 24.00; #declare SSB_z = 34.00; #declare SSB_y = 10.50; #declare SSB_yi= 8.2;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 0; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 12; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (11) #declare SS_Name = "KW1-1201";   #declare SS_Manufacturer = "Lucky Light"  #declare Display_in = 1.20; #declare Display_mm = 30.4;       
 #declare SSB_x = 28.80; #declare SSB_z = 40.80; #declare SSB_y = 9.00; #declare SSB_yi= 7.0;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 0; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 14; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (12) #declare SS_Name = "KW1-1501";   #declare SS_Manufacturer = "Lucky Light"  #declare Display_in = 1.50; #declare Display_mm = 38.1;       
 #declare SSB_x = 30.60; #declare SSB_z = 44.10; #declare SSB_y = 8.00; #declare SSB_yi= 6.4;  
 #declare SS_Pin_R = 0.25;                    #declare SSB_Base_Cut  = 0; // Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir    = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 1; #declare SS_Pin_Row_D = 16; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 
#case (13) #declare SS_Name = "SA40-19SRWA";  #declare SS_Manufacturer = "KINGBRIGHT" #declare Display_in = 4.00; #declare Display_mm =100;        
 #declare SSB_x = 90.0; #declare SSB_z =122.0; #declare SSB_y =15.0;#declare SSB_yi=12.0;  
 #declare SS_Pin_R = 0.40;                                         #declare SSB_Base_Cut  = 1;// Base_Cut: 0 = slope; 1 = vertical  
 #declare SS_Pin_Dir   = 1; // Pin_Direction 0 vertical , 1 horizontal 
 #declare SS_Pin_Raster = 2; #declare SS_Pin_Row_D =42; //!!!Pin_Row_Distance * SSB_Pin_Raster = 0.1 inch = 2.54 cm
#break 

#end // of switch  ( SSB_Type )  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------


// Single_Seven_Segment_Display
// ----------------------------------------------------------------------------------------------------------- macro
#macro Single_Seven_Segment_Display (  

        DisplayIntegerNumber, // digit [0, ..., 9, + hexnumbers 10=A,11=b, 12=C, 13=d, 14=E, 15=F, 16="°", -1="-"] , 
        Point_On, // decimal point [ 1 = On 0 = Off ] 

	ActiveLED_Texture_Number, //  [  0 = red, 1 = green, 2 = white, 3 = Orange, 4 = transparent1, 5 = transparent2, 6 = amber]
        InactiveLED_Texture_Number, //  [  0 = dark gray, 2 = light gray, 3 = transparent1, 4 = transparent2, 5 = amber]
        DisplaySkin_Texture_Number, // [ 0 = near black, ]
        
        Segment_Type,  // / 0 = angular, 1 = more curved // 
        
        Length_SD7S, // 19
        Width_SD7S,  // 12.7
        Height_SD7S, //  8
        
        PackageView_0n, //  = 1 or 0
        FootPrint_On, // 
      ) // ---------------------------------------------------------------------------------------------------
		                   
        // ---------------------------------------------------------------------------------------------------
        // i.e. Real Dimensions of Single Display 7Segments
	//	#local Length_SD7S = 19.0;     
	//	#local Width_SD7S  = 12.7;      
	//	#local Height_SD7S =  8.0;      
        #ifndef( Active_LEDs_Texture )
        #declare Active_LEDs_Texture =
                texture{
			#switch ( ActiveLED_Texture_Number )
			#case(0)  pigment{ color rgb< 1, 0.98, 0.90 > * 1.1 }     // color White  
			#break
			#case(1)  pigment{ color rgb< 1.0, 0.0, 0 > * 1.2 }    // color Red  
			#break
			#case(2)  pigment{ color rgb< 1.0, 0.5, 0.0 > * 1.1  } // color Orange  
			#break
			#case(3)  pigment{ color rgb< 1.0, 0.7, 0.35>*0.75 } //  color Amper
			#break
			#case(4)  pigment{ color rgb< 1.0, 0.75, 0.0 > * 1.1  } // color Yellow  
			#break
			#case(5)  pigment{ color rgb< 0.25, 0.5, 0 > * 1.5 } // color Green  
			#break
			#case(6)  pigment{ color rgb< 0.10,0.5, 1>  } // color Blue  
			#break 
                        #case(7)  pigment{ color rgb< 0.4, 0.3, 1>*1.2 } // color VioletBlue  
			#break
			#else // != [ 0, ..., 6 ]
				  pigment{ color rgb< 1, 0.98, 0.90 > * 1.1 }    // color Red  
			#break
			#end // endSwitch
				finish { phong 1 }
			} // end of texture
        #end // Active_LEDs_Texture  
        
        #ifndef( Inactive_LEDs_Texture )
	#declare Inactive_LEDs_Texture =
		texture{
			#switch ( InactiveLED_Texture_Number )
			#case(0) pigment{ color rgb< 1, 1, 1 > * 0.3 }          //  color gray dark
			#break                                                                       
			#case(1) pigment{ color rgb< 1, 1, 1 > * 0.6 }          //  color gray light
			#break                                                                       
			#case(2)  pigment{ color rgbt<0.9,0.9,0.9,0.95>  } // Color Transparent1  
			#break 
                        #case(3)  pigment{ color rgbf <0.8,0.8,0.8,0.8> } // Color Transparent2  
                        #break
			#case(4)  pigment{ color rgbf< 0.9, 0.9, 0.5, 0.999> } // Color Amber  
			#break
			#end // of switch
			         finish { phong 1 reflection 0.05 }
		} // end of texture
 	#end // Inactive_LEDs_Texture
	
	#ifndef( DisplaySkin_Texture )
	#declare DisplaySkin_Texture =
		texture{
			#switch ( DisplaySkin_Texture_Number )
 	                #case(0) pigment{ color rgb< 1, 1, 1 > * 0.05 }         // color nearly black 
				 finish { phong 1 reflection 0.15 }
			#break
 	                #case(1) pigment{ color rgb< 1, 1, 1 > * 0.15 }         // color dark gray
				 finish { phong 1 reflection 0.15 }
			#break
 	                #case(2) pigment{ color rgb< 1, 1, 1 > * 0.50 }         // color medium gray
				 finish { phong 1 reflection 0.15 }
			#break
 	                #case(3) pigment{ color rgb< 1, 1, 1 > * 0.85 }         // color light gray
				 finish { phong 1 reflection 0.15 }
			#break
			#end // endSwitch
			} // end of texture      // 0 = nearly black, 1 = dark gray, 2 = medium gray, 3 = light gray, 
        #end // DisplaySkin_Texture
        // ---------------------------------------------------------------------------------------------------	
	// -------------------------------------------------------------------------¬
	#macro S7_DiodeSegment( SS_Color__ )
		#local SS_Width = 1.5;
		#local SS_Length = 6.60;
		#local SS_Diag = sqrt( SS_Width * SS_Width ) / 2;

		// polygon { number of points, list of < x, y > points -  closed series! }
		polygon {  7,
				< -SS_Length/2, 0 >,
				< -SS_Length/2+SS_Diag, -SS_Width/2 >,
				<  SS_Length/2-SS_Diag, -SS_Width/2 >,
				<  SS_Length/2, 0 >,
				<  SS_Length/2-SS_Diag,  SS_Width/2 >,
				< -SS_Length/2+SS_Diag,  SS_Width/2 >,
				< -SS_Length/2, 0 >
			texture { SS_Color__ }
			rotate< 90, 0, 0 >
        		scale <0.93,1,1>
        		} // end of polygon
	#end //__________________________________________end of macro S7_DiodeSegment
	
	// ------------- 2nd version -----------------------------------------------
	#macro Segment_a ( SS_Color__ ) 
	        prism{  0, 0.01, 7,            
                <8.890,30.480>,<9.754,31.166>,<8.992,31.750>,
                <3.886,31.750>,<3.480,31.394>,<4.242,30.480>,<8.890,30.480>  //  
                texture { SS_Color__ } } // end prism
        #end // end of macro
        #macro Segment_b ( SS_Color__ ) 
	        prism{  0, 0.01, 6,             
                <9.246,30.150>,<10.135,30.8610>,<10.592,30.531>,
                <9.703,25.806>,< 8.560,26.4414>,< 9.246,30.150>
                texture { SS_Color__ } } // end prism
        #end // end of macro
        #macro Segment_c ( SS_Color__ ) 
	        prism{ 0, 0.01, 6,            
                <8.179,24.206>,<9.525,24.892>,<8.636,19.990>,
                <8.306,19.710>,<7.518,20.650>,<8.179,24.206>       
                texture { SS_Color__ } } // end prism
        #end // end of macro
        #macro Segment_d ( SS_Color__ ) 
                prism{ 0, 0.01, 7,            
                <7.188,20.320>,<7.950,19.406>,<7.544,19.050>,
                <2.438,19.050>,<1.676,19.634>,<2.540,20.320>,<7.188,20.320>     
                texture { SS_Color__ } } // end prism
        #end // end of macro
        #macro Segment_e ( SS_Color__ ) 
                prism{ 0, 0.01, 6,            
                  <2.184,20.650>,<1.295,19.939>,<0.838,20.269>,
                  <1.727,24.994>,<2.870,24.359>,<2.184,20.650>
                texture { SS_Color__ } } // end prism
        #end // end of macro
        #macro Segment_f ( SS_Color__ ) 
                prism{ 0, 0.01, 6,           
                  <3.251,26.594>,<1.905,25.908>,<2.794,30.810>,
                  <3.124,31.090>,<3.912,30.150>,<3.251,26.594>
                texture { SS_Color__ } } // end prism
        #end // end of macro
        #macro Segment_g ( SS_Color__ ) 
                prism{ 0, 0.01, 7,            
                 <8.255,26.035>,<9.398,25.400>,<8.128,24.765>,
                 <3.175,24.765>,<2.032,25.400>,<3.302,26.035>,<8.255,26.035>     
                texture { SS_Color__ } } // end prism
        #end // end of macro
	// ------------------------------------------------------------------------------------------
 
        #macro S7_Diode_Point( Point_On )
		#local SS_Width = 1.55;
		#local D = 0.0001;       // just a little bit !!

		// point
		cylinder{
				< 0, 0, 0 >, < 0, D, 0 >, SS_Width/2
				translate< SS_Width, 0, 0 >
				// "on" or "off"
				#if ( Point_On = 1 )
						texture { SS_Light_Color }
				#else
						texture { SS_Shade_Color }
				#end
		} // end of point
	#end //_____________________________________end of macro S7_Diode_Point

	//-------------------------------------------------------------------------
	#macro Light_Color( Num )
		#if( Lights_On[Num] = 1 )
			SS_Light_Color
		#else
			SS_Shade_Color
		#end
	#end //______end of Light_Color ------------------------------------------
        // -----------------------------------------------------------------------------------------
	#macro Single_Seven_Segment(
				        SS_Number,
				        SS_Angle,
					SS_Element_Scale,
					SS_Light_Color,
					SS_Shade_Color,
					SS_Background_Color,
				) // --------------------------------------------
		//-----------------------------------------------
		#local SS_Len = 6.75;
		#local D = 0.0001;       // just a little bit !!
		#local Shear_Factor =  tan( radians( SS_Angle ) );
		//-----------------------------------------------
		// The sequence of the elements (Diodes):
 
 		//   |¯¯¯¯¯¯¯¯¯¯¯¯|\
		//   |       --   | \       1(a)
		//   |     /   /  | |  6(f)      2(b)
		//   |      -     | |       7(g)
		//   |   /   /    | |  5(e)      3(c)
		//   |    --   O  | |        4(d)     8(point)
		//   |____________| |
		//    \           \ |
		//     \___________\|
       
                // ----------------------------------------------

		#if( SS_Number <-2 | SS_Number > 16 ) // [0, ..., 9, + hexnumbers: 10=A,11=b, 12=C, 13=d, 14=E, 15=F, degrees: 16="°", minus="-"] 
  			#local SS_Number = 99;
		#end

		#switch ( SS_Number )             // point, g, f, e, d, c, b, a
		#case(0)        #local Lights_On = array [ 7 ] { 1, 1, 1, 1, 1, 1, 0 }
		#break
		#case(1)        #local Lights_On = array [ 7 ] { 0, 1, 1, 0, 0, 0, 0 }
		#break
		#case(2)        #local Lights_On = array [ 7 ] { 1, 1, 0, 1, 1, 0, 1 }
		#break
		#case(3)        #local Lights_On = array [ 7 ] { 1, 1, 1, 1, 0, 0, 1 }
        	#break
		#case(4)        #local Lights_On = array [ 7 ] { 0, 1, 1, 0, 0, 1, 1 }
		#break
		#case(5)        #local Lights_On = array [ 7 ] { 1, 0, 1, 1, 0, 1, 1 }
		#break
		#case(6)        #local Lights_On = array [ 7 ] { 1, 0, 1, 1, 1, 1, 1 }
		#break
		#case(7)        #local Lights_On = array [ 7 ] { 1, 1, 1, 0, 0, 0, 0 }
        	#break
		#case(8)        #local Lights_On = array [ 7 ] { 1, 1, 1, 1, 1, 1, 1 }
		#break
		#case(9)        #local Lights_On = array [ 7 ] { 1, 1, 1, 1, 0, 1, 1 }
		#break
		// + hexnumbers 10=A,11=b, 12=C, 13=d, 14=E, 15=F ], 
		#case(10)       #local Lights_On = array [ 7 ] { 1, 1, 1, 0, 1, 1, 1 } // "A"
		#break
		#case(11)       #local Lights_On = array [ 7 ] { 0, 0, 1, 1, 1, 1, 1 } // "b"
		#break
		#case(12)      	#local Lights_On = array [ 7 ] { 1, 0, 0, 1, 1, 1, 0 } // "C"
		#break
		#case(13) 	#local Lights_On = array [ 7 ] { 0, 0, 1, 1, 1, 1, 1 } // "d"
		#break
		#case(14)       #local Lights_On = array [ 7 ] { 1, 0, 0, 1, 1, 1, 1 } // "E"
		#break
		#case(15)       #local Lights_On = array [ 7 ] { 1, 0, 0, 0, 1, 1, 1 } // "F"
		#break
		// specials ------------------------------------------------
  		#case(16)	#local Lights_On = array [ 7 ] { 1, 1, 0, 0, 0, 1, 1 } // "°" degrees
		#break
		#case(-1)	#local Lights_On = array [ 7 ] { 0, 0, 0, 0, 0, 0, 1 } // "-" minus
		#break
        	//---------------------------------------------------------
		#else 		#local Lights_On = array [ 7 ] { 0, 0, 0, 0, 0, 0, 0 } // nothing - all off!!! 
		#break
		#end    // end #switch ( SS_Number )  arrays
                //-------------------------------------------------------------------------
		



 	//-------------------------------------------------------------------------------------------------------------------
	union{  // Single_Seven_Segment
		union{ // union LEDs
                // Segment_Type,  // / 0 = angular, 1 = curved // 
		#if (Segment_Type_ = 0 ) 
			object{ S7_DiodeSegment( Light_Color(1-1) ) translate< 0, 0, SS_Len > }
			object{ S7_DiodeSegment( Light_Color(7-1) ) translate< 0, 0, 0 > }
			object{ S7_DiodeSegment( Light_Color(4-1) ) translate< 0, 0, -SS_Len > }
			object{ S7_DiodeSegment( Light_Color(2-1) ) rotate< 0, 90, 0 > translate<  SS_Len/2, 0,  SS_Len/2 > }
			object{ S7_DiodeSegment( Light_Color(3-1) ) rotate< 0, 90, 0 > translate<  SS_Len/2, 0, -SS_Len/2 > }
			object{ S7_DiodeSegment( Light_Color(6-1) ) rotate< 0, 90, 0 > translate< -SS_Len/2, 0,  SS_Len/2 > }
			object{ S7_DiodeSegment( Light_Color(5-1) ) rotate< 0, 90, 0 > translate< -SS_Len/2, 0, -SS_Len/2 > }
			matrix<  1, 0, 0, // matrix-shear_z_to_x
	        		 0, 1, 0,
		      Shear_Factor, 0, 1,
				 0, 0, 0>
        		scale <1.03,1,0.98>
			translate< 0, SS_Element_Scale.y+D, 0.0 >
					
			scale < Width_SD7S/12.7, 1, Length_SD7S/19  >
	
		#else // (Segment_Type = 1 )  
     			object{ Segment_a( Light_Color(0) )  }
			object{ Segment_b( Light_Color(1) )  }
			object{ Segment_c( Light_Color(2) )  }
			object{ Segment_d( Light_Color(3) )  }
			object{ Segment_e( Light_Color(4) )  }
			object{ Segment_f( Light_Color(5) )  }
			object{ Segment_g( Light_Color(6) )  }
                       
                        translate<-5.6, SS_Element_Scale.y+D , -25.5 >
                        scale <1.05,1,1.05>
                        scale < Width_SD7S/12.4, 1, Length_SD7S/17.55  >
                
                #end // of "#if (Segment_Type = 0 )"       
		} // end union LEDs


		// Skin 8
		box{ < -0.50+D, 1, -0.50+D >,< 0.50-D, 1-0.01, 0.50-D >
			texture { SS_Background_Color }
			scale SS_Element_Scale
		} // end of box
	#if( Point_On = 0 | Point_On = 1 )
	        object{ S7_Diode_Point(  Point_On )  // point
		        translate<  SS_Len*0.42, SS_Element_Scale.y+D, -SS_Len*1 >
			scale < Width_SD7S/12.7, 1, Length_SD7S/19  >
		} // end Point
	#end // of "#if( Point_On = 0 | Point_On = 1 )"
        } // end of union "Single_Seven_Segment"

       #end // ___________________________________________________________end of macro Single_Seven_Segment(...)




// -------------------------------------------------------------------------------------------------------------
#if (FootPrint_On = 1)
union { 
#end // only "#if  (FootPrint_On = 1)"

      
   #if( PackageView_0n = 1 )
   // -------------------------------------------------------------------
   object{ Single_Seven_Segment(
	
                DisplayIntegerNumber, // [0, ..., 9, + hexnumbers 10=A,11=b, 12=C, 13=d, 14=E, 15=F  16= "°" degrees] ! SS_Number  
		10,                    // 0...10, SS_Angle for shearing  
		< Width_SD7S, Height_SD7S, Length_SD7S  >, // for SS_Angle=10  
		Active_LEDs_Texture,            // SS_Light_Color  
		Inactive_LEDs_Texture,          // SS_Shade_Color 
		DisplaySkin_Texture,    // SS_Background_Color 
	      ) // -------------------------------------------
   } // end of object
   #end // of "#if( PackageView_0n = 1 )" 
   // -------------------------------------------------------------------

   #if (FootPrint_On = 1)	// FootPrint of SingleDisplay7Segments
   union{ 
     object{ Single_Seven_Segment(

		8,
		10,                                     // 0...10, SS_Angle for shearing  
		< Width_SD7S, 0.005, Length_SD7S  >,     // for SS_Angle=10  
		pigment{ color rgb< 1, 1, 1 > * 1.1  }, // color White // SS_Light_Color   
		pigment{ color rgb< 1, 1, 1 > * 1.1  }, // color White // SS_Shade_Color    
		pigment{ color rgbf <0.9,0.9,0.9,0.999> }, // Transparent // SS_Background_Color  
	      ) // -------------------------------------------
     } // end of object
     difference{ 
       box{ <-Width_SD7S/2    , 0,-Length_SD7S/2>    ,< Width_SD7S/2    ,0.02,Length_SD7S/2>} 
       box{ <-Width_SD7S/2+0.2,-1,-Length_SD7S/2>+0.2,< Width_SD7S/2-0.2,2.00,Length_SD7S/2-0.2>} 
       texture{ pigment{ color rgb< 1, 1, 1 > * 1.1 } }
          
     }// end difference 
   } // end union                     
}// ------ end of union "#if  (FootPrint_On = 1)"  
   #end // end of  "#if (FootPrint_On = 1)"
   // -------------------------------------------------------------------
#end // of macro Single_Seven_Segment_Display  ----------------------- end of macro Single_Seven_Segment_Display
// -------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------
 
//------------------------------------------------------------------------------ /////////  macro  Seven_Segment_Socket
//------------------------------------------------------------------------------ /////////  
#macro Seven_Segment_Socket   (  SSS_z, // length in z 
                                 SSS_x, // width in x
                                 SSS_y, // height in y 
                                 SSS_yi, // inner height in y 
                                 SSS_Base_Cut_Type_, 
                                 SSS_Pin_Dir_,
                                 SSS_Pin_Raster_, 
                                 
                                 SSS_Text_On_, 
                                 SS_Name_, // elements name
                                 SS_Manufacturer_, // elements manufacturer name
                              ) // ---------------------------------------------
//------------------------------------------------------------------------------ /////////  
#ifndef (Socket_Font)
 #declare Socket_Font = "courbd.ttf"
#end 
#ifndef ( Pin_Raster_Base ) 
 #declare Pin_Raster_Base = 2.54 ; // raster 2.54 mm = 0.1 inch  
#end 
//------------------------------------------------------------------------------
#local D = 0.00001; 

//------------------------------------------------------------------------------ <<<<< 
#macro Seven_Segment_Base_Body (  SSB_Long , // in z 
                                  SSB_Wide , // in x  
                                  SSB_Total_Height, // in y 
                                  SSB_Reduced_Height, //  
                                  SSB_Base_Cut, 
                                  SS_Text_On, 
                               ) //----------------------
// -----------------------------------------------------
#ifndef( SSBase_Texture_1 ) // outer sides
#declare SSBase_Texture_1 =  texture{ pigment{ color rgb<1,1,1>}}
#end 
#ifndef( SSBase_Texture_2 ) // inner base sides
#declare SSBase_Texture_2 =  texture{ pigment{ color rgb<1,1,1>*0.8}}
#end 
#ifndef( SSBase_Texture_3 ) // inner base top 
#declare SSBase_Texture_3 =  texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 }}
#end 
#ifndef( SSB_Text_Texture ) // inner base top 
#declare SSB_Text_Texture =  texture{ pigment{ color rgb<1,1,1>*0.05 }}
#end 
// -----------------------------------------------------
#local D = 0.00001; 
#local Base_Gap_H = SSB_Total_Height - SSB_Reduced_Height;  
#local GWFo = 0.80;  // upper Gap_width_Faktor = 0.80;  
#local GWFu = 0.85;  
#local GWF  = 0.90; // vertical gaping 
// -----------------------------------------------------

difference{
box{ <-SSB_Wide/2,0,-SSB_Long/2>,<SSB_Wide/2,SSB_Total_Height,SSB_Long/2> texture{SSBase_Texture_1} } 

#if (SSB_Base_Cut = 0 ) // sloop cut  

prism { -SSB_Long/2-D, SSB_Long/2+D, 5  // in z
        <-SSB_Wide/2*GWFu, -D>,          // first point
        < SSB_Wide/2*GWFu, -D>, 
        < SSB_Wide/2*GWFo, Base_Gap_H>,   
        <-SSB_Wide/2*GWFo, Base_Gap_H>, 
        <-SSB_Wide/2*GWFu, -D>   
        rotate<-90,0,0>   
        texture { SSBase_Texture_2 }  
      } // end of prism --------------------------------------------------------
  
prism {  -SSB_Wide/2-D, SSB_Wide/2+D, 5 // in x 
        <         -D,-SSB_Long/2*GWFu>,  // first point
        <         -D, SSB_Long/2*GWFu>, 
        < Base_Gap_H, SSB_Long/2*GWFo>,   
        < Base_Gap_H,-SSB_Long/2*GWFo>, 
        <         -D,-SSB_Long/2*GWFu>  
        rotate< 0,0,90>  
        texture { SSBase_Texture_2 }  
     } // end of prism --------------------------------------------------------
#end
#if (SSB_Base_Cut = 1) // vertical cut
box{ <-SSB_Wide/2*GWF ,-D,-SSB_Long/2-D  >,< SSB_Wide/2*GWF ,Base_Gap_H ,SSB_Long/2+D  > texture{SSBase_Texture_2} } 
box{ <-SSB_Long/2*GWF ,-D,-SSB_Wide/2-D  >,< SSB_Long/2*GWF ,Base_Gap_H ,SSB_Wide/2+D  > texture{SSBase_Texture_2} } 
#end

// inner cut: 
box{ <-SSB_Wide/2+0.3  ,-D,-SSB_Long/2+0.3  >,<SSB_Wide/2-0.3  ,Base_Gap_H+0.5  ,SSB_Long/2-0.3  > texture{SSBase_Texture_2} } 
box{ <-SSB_Wide/2+0.3+D,-D,-SSB_Long/2+0.3+D>,<SSB_Wide/2-0.3-D,Base_Gap_H+0.5+D,SSB_Long/2-0.3-D> texture{SSBase_Texture_3} } 

#if (SSS_Text_On_ = 1)//-------------------------------------------------------------
        text{ttf Socket_Font SS_Name_         0.3,0 texture{SSB_Text_Texture} scale<1.25,1.0,-5> translate<-SSB_Wide/2+1,Base_Gap_H +0.5,-SSB_Long/2+0.0025>}
        text{ttf Socket_Font SS_Manufacturer_ 0.3,0 texture{SSB_Text_Texture} scale<1.50,2.5,-5> translate<-SSB_Wide/2+1,Base_Gap_H +2.0,-SSB_Long/2+0.0025>}
#end // of "#if (SS_Text_On_ = 1)" 
} // end intersection 
#end // --------------------------------------------------------- end of macro                             
//------------------------------------------------------------------------------ <<<<< 
//------------------------------------------------------------------------------



//----------------------------------------------------------------------------
//------------------------------------------------------------------------------ <<<<< 
#declare SSB_Pin_Half_Len = 3.81; // down! 
//----------------------------------------------------------------------------
#ifndef( SS_Pin_Texture_1 ) 
#declare SS_Pin_Texture_1 =  texture{ Polished_Chrome }
#end 
//----------------------------------------------------------------------------
#macro SS_Pin(Pin_R_)
union{ 
  cylinder{<0,-SSB_Pin_Half_Len,0>,<0,SSB_Pin_Half_Len,0>,Pin_R_ }  
  sphere{ <0,0,0>,  Pin_R_ scale <1,0.6,1> translate<0,-SSB_Pin_Half_Len,0>} 
  // upper part
  cylinder{<0,0.2,0>,<0,SSB_Pin_Half_Len,0>, Pin_R_*1.5 }  
  sphere{ <0,0,0>,  Pin_R_*1.5 scale <1,1,1> translate<0, 0.2,0>} 
  texture{ SS_Pin_Texture_1 } 
} // end of union  
#end // ------------------------------ end macro
//----------------------------------------------------------------------------
#macro SS_Pins_X_5 (SS_Pin_R_, Pin_Raster__)    
#local PRaster__= Pin_Raster_Base* Pin_Raster__;
union{        
 object{ SS_Pin(SS_Pin_R_) translate<-2*PRaster__, 0, 0> }   
 object{ SS_Pin(SS_Pin_R_) translate<-1*PRaster__, 0, 0> }   
 object{ SS_Pin(SS_Pin_R_) translate< 0*PRaster__, 0, 0> }   
 object{ SS_Pin(SS_Pin_R_) translate< 1*PRaster__, 0, 0> }   
 object{ SS_Pin(SS_Pin_R_) translate< 2*PRaster__, 0, 0> }   
} // end of union  
#end // ------------------------------ end macro
//------------------------------------------------------------------------------ <<<<< 
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
union{ 
// ---------------------------------------------------------- //  
object{ Seven_Segment_Base_Body( SSS_z , // SSB_Long , // in z 
                                 SSS_x , // SSB_Wide , // in x  
                                 SSS_y , // SSB_Totol_Height, // in y 
                                 SSS_yi, // SSB_Reduced_Height,
                                 SSS_Base_Cut_Type_, 
                                 SSS_Text_On_, 
                              ) //----------------------  
      } // ----------------------------------------------------------
#if ( SSS_Pin_Dir_ = 1) // horizontal 
union{        
object{ SS_Pins_X_5(SS_Pin_R, SSS_Pin_Raster_)  translate<0,0,SS_Pin_Row_D/2*Pin_Raster_Base>              } // +z 
object{ SS_Pins_X_5(SS_Pin_R, SSS_Pin_Raster_)  translate<0,0,SS_Pin_Row_D/2*Pin_Raster_Base> scale<1,1,-1>} // -z 
} // -------------------------------------------------------------------------------------
#else  // vertical
union{        
object{ SS_Pins_X_5(SS_Pin_R, SSS_Pin_Raster_)  rotate<0,90,0> translate<SS_Pin_Row_D/2*Pin_Raster_Base,0,0>              } // +x 
object{ SS_Pins_X_5(SS_Pin_R, SSS_Pin_Raster_)  rotate<0,90,0> translate<SS_Pin_Row_D/2*Pin_Raster_Base,0,0> scale<-1,1,1>} // -x 
} // -------------------------------------------------------------------------------------
#end // of "( SS_Pin_Dir = 1)"

} // end of union 
// ---------------------------------------------------------------------------------------------------
#end// of macro ---------------------------------------------------------------- end of macro Seven_Segment_Socket
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  

//-----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------
union{ 
#local D = 0.00001; 
#if (PackageView_0n_ = 1)

// ----------------------------------------------------------  
object{ Seven_Segment_Socket ( SSB_z , // SSB_Long , // in z 
                               SSB_x , // SSB_Wide , // in x  
                               SSB_y , // SSB_Total_Height, // in y 
                               SSB_yi, // SSB_Reduced_Height,
                               SSB_Base_Cut, // cut type 
                               SS_Pin_Dir,
                               SS_Pin_Raster,
                               
                               SS_Text_On, 
                               SS_Name, // elements name
                               SS_Manufacturer, // elements manufacturer name
                             ) //----------------------  
      } // ----------------------------------------------------------
#end // of "#if (PackageView_0n = 1)
// -------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------
object{ Single_Seven_Segment_Display(  
        
        DisplayIntegerNumber_, //  0, 1, 2,  ..., 9, + hexnumbers: 10=A,11=b, 12=C, 13=d, 14=E, 15=F, degrees: 16="°", minus="-"  
	Point_On_, // 0 = off, 1 = on  

	ActiveLED_Texture_Number_,   // [ 0 = white, 1 = red, 2 = orange, 3 = amber ,4 = yellow, 5 =green, 6 = blue, 7= violet ]
        InactiveLED_Texture_Number_, // [ 0 = dark gray, 1 = light gray, 2 = transparent1, 3 = transparent2, 4 = amber ]
	DisplaySkin_Texture_Number_, // [ 0 = near black, 1 = dark gray, 2 = medium gray, 3 = light gray ] 
	
	Segment_Type_,  // 0 = angular, 1 = more curved //  
		                       
	SSB_z, // length_, // i.e. 19
	SSB_x, // width_,  // i.e. 12.7
	SSB_y, // height,  // i.e.  8

        PackageView_0n_, //  = 0 or 1  
	FootPrint_On_,   //  = 0 or 1  
      ) //------------------------------------------------------- 
        rotate<  0,0,0> 
        translate<0.00,D, 0.00>
   } // end  Single_Seven_Segment_Display
// -------------------------------------------------------------------------------------
} // global union                                        
#end // ------------------------------------------------------------------------------------- end of macro
// -------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//-------------------------------------------------------------------------------------------------
#declare SSBase_Texture_1 =  texture{ pigment{ color rgb<1,1,1>}} // outer sides
#declare SSBase_Texture_2 =  texture{ pigment{ color rgb<1,1,1>*0.8}} // inner base sides
#declare SSBase_Texture_3 =  texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 }} // inner base top
#declare SSB_Text_Texture =  texture{ pigment{ color rgb<1,1,1>*0.05 }} // name + manufacturers text 
// Active_LEDs_Texture,            //  
// Inactive_LEDs_Texture,          //  
// DisplaySkin_Texture_Texture,    //  
// ------------------------------------------------------------------------------------------------
#declare Socket_Font_  = "courbd.ttf"
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
#include "Seven_Segment_LCD_Display.inc" 
// ------------------------------------------------------------------------------------------------
object{  Single_Digit_Seven_Segment_Display ( 
      // choose display type:
         3, //  SSB_Type, //  1 ~ 7
// Types of single digit Seven-Segment LED Displays:
// SSB_Type 0 :  7.5 x  14.0  x  8.4, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-360"    , Unity Opto Technology Display: (0.36 inch)   9.14 mm
// SSB_Type 1 :  9.7 x  12.8  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-4301"   , Unity Opto Technology Display: (0.40 inch)   10.0 mm
// SSB_Type 2 :  9.6 x  13.0  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LA-401DN"   , ROHM                  Display: (0.40 inch)   10   mm
// SSB_Type 3 :  9.7 x  12.9  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LTS-4301"   , LITE-ON               Display: (0.40 inch)   10   mm

// SSB_Type 4 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "UVS-546"    , UNi                   Display: (0.52 inch)   13.2 mm
// SSB_Type 5 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "LTS-547 AP" , LITE-ON               Display: (0.52 inch)   13.2 mm
// SSB_Type 6 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "SA52-11EWA" , KINGBRIGHT            Display: (0.52 inch)   13.2 mm
// SSB_Type 7 : 12.7 x  19.0  x  8.3, Pin_Dir= 1;Pin_Row_Dist= 6; "SA56-11EWA" , KINGBRIGHT            Display: (0.56 inch)   14.2 mm 

// SSB_Type 8 : 20.0 x  27.7  x  8.4, Pin_Dir= 1;Pin_Row_Dist= 12; "SC08-11SRWA", KINGBRIGHT            Display: (0.80 inch)  20.3 mm 
// SSB_Type 9 : 22.5 x  27.7  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1001", Lucky Light              Display: (1.00 inch)  25.4 mm 
// SSB_Type 10: 24.0 x  33.0  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1002", Lucky Light              Display: (1.00 inch)  25.4 mm 

// SSB_Type 11: 28.8 x  40.8  x  9.0, Pin_Dir= 1;Pin_Row_Dist= 14; "KW1-1201", Lucky Light              Display: (1.20 inch)  30.4 mm 
// SSB_Type 12: 30.6 x  44.1  x  8.0, Pin_Dir= 1;Pin_Row_Dist= 16; "KW1-1501", Lucky Light              Display: (1.50 inch)  38.1 mm 
// SSB_Type 13: 90.0 x 122.0  x 15.0, Pin_Dir= 1;Pin_Row_Dist= 42;Raster=2*2.54;"SA56-11EWA",KINGBRIGHT Display: (4.00 inch) 100   mm 

         1, // SS_Text_On, // [ 0 = off, 1 = on ] 
         Socket_Font_ , //  = "courbd.ttf"
         
         4, // DisplayIntegerNumber_, // [ 0, 1, 2,  ..., 9, + hexnumbers: 10=A,11=b, 12=C, 13=d, 14=E, 15=F, degrees: 16="°", minus="-" ] 
         0, // Point_On_,                  // [ 0 = off, 1 = on ] 
         3, // ActiveLED_Texture_Number,   // [ 0 = white, 1 = red, 2 = orange, 3 = amber ,4 = yellow, 5 =green, 6 = blue, 7= violet] 
         4, // InactiveLED_Texture_Number, // [ 0 = dark gray, 1 = light gray, 2 = transparent1, 3 = transparent2, 4 = amber]
         0, // DisplaySkin_Texture_Number_,// [ 0 = near black, 1 = dark gray, 2 = medium gray, 3 = light gray ] 

         0, // Segment_Type_,  // 0 = angular, 1 = curved // 

		
         1, //  PackageView_0n, //  = 0 or 1 )
	 0, //  FootPrint_On, //  = 0 or 1 )
       ) // ---------------------------------------------------------------------------------------------------
  rotate< 0,0,0> 
  translate<0, 0, 0>
} //-------------------------------------------------------  
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Seven_Segment_LCD_Display_Inc_Temp;
#end
//------------------------------------- end of include file

