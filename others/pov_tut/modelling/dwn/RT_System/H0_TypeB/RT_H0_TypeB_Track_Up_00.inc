// POV-Ray 3.7 include file "RT_H0_TypeB_Track_Up_00.inc"
// author: Friedrich A, Lohmueller, Dec-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_H0_TypeB_Track_Up_00_Inc_Temp)
#declare RT_H0_TypeB_Track_Up_00_Inc_Temp = version;
#version 3.7;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// Um Up_m (in Meter) nach oben gescherte Kurvengleise 

// needs: call after inclusion of "RT_H0_TypeA_Set_00.inc"
//------------------------------------------------------------------------------ /////////  
#macro Track_Up_00(  Track_Name_,    // Track_Name "R1","R2","R3","R4", ... ,"R9","L1",..."L9","G239" 
                     Up_, // value for H0 scale (in meter) // i.e. 0.0160,                                
                     Gradient_Type  // 0 = continous, 1 = start(concav), 2 = end(convex)
                  )  //--------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
#local H0 = 87; 
//---------------------------------------------------------------------------------------
#if (Track_Name_ = "T_R0_30") #local Name_ = 0; #end
#if (Track_Name_ = "T_R1_30") #local Name_ = 1; #end
#if (Track_Name_ = "T_R2_30") #local Name_ = 2; #end
#if (Track_Name_ = "T_R3_30") #local Name_ = 3; #end
#if (Track_Name_ = "T_R4_30") #local Name_ = 4; #end
#if (Track_Name_ = "T_R5_30") #local Name_ = 5; #end
#if (Track_Name_ = "T_R6_30") #local Name_ = 6; #end
#if (Track_Name_ = "T_R7_30") #local Name_ = 7; #end
#if (Track_Name_ = "T_R8_30") #local Name_ = 8; #end
#if (Track_Name_ = "T_R9_30") #local Name_ = 9; #end
#if (Track_Name_ ="T_R10_30") #local Name_ =10; #end

#if (Track_Name_ = "T_R0_15") #local Name_ = 20; #end
#if (Track_Name_ = "T_R1_15") #local Name_ = 21; #end
#if (Track_Name_ = "T_R2_15") #local Name_ = 22; #end
#if (Track_Name_ = "T_R3_15") #local Name_ = 23; #end
#if (Track_Name_ = "T_R4_15") #local Name_ = 24; #end
#if (Track_Name_ = "T_R5_15") #local Name_ = 25; #end
#if (Track_Name_ = "T_R6_15") #local Name_ = 26; #end
#if (Track_Name_ = "T_R7_15") #local Name_ = 27; #end
#if (Track_Name_ = "T_R8_15") #local Name_ = 28; #end
#if (Track_Name_ = "T_R9_15") #local Name_ = 29; #end
#if (Track_Name_ ="T_R10_15") #local Name_ = 30; #end

#if (Track_Name_ = "T_R0_075") #local Name_= 40; #end
#if (Track_Name_ = "T_R1_075") #local Name_= 41; #end
#if (Track_Name_ = "T_R2_075") #local Name_= 42; #end
#if (Track_Name_ = "T_R3_075") #local Name_= 43; #end
#if (Track_Name_ = "T_R4_075") #local Name_= 44; #end
#if (Track_Name_ = "T_R5_075") #local Name_= 45; #end
#if (Track_Name_ = "T_R6_075") #local Name_= 46; #end
#if (Track_Name_ = "T_R7_075") #local Name_= 47; #end
#if (Track_Name_ = "T_R8_075") #local Name_= 48; #end
#if (Track_Name_ = "T_R9_075") #local Name_= 49; #end
#if (Track_Name_ = "T_R10_075") #local Name_= 50; #end



#if (Track_Name_ = "T_L0_30") #local Name_ = 60; #end
#if (Track_Name_ = "T_L1_30") #local Name_ = 61; #end
#if (Track_Name_ = "T_L2_30") #local Name_ = 62; #end
#if (Track_Name_ = "T_L3_30") #local Name_ = 63; #end
#if (Track_Name_ = "T_L4_30") #local Name_ = 64; #end
#if (Track_Name_ = "T_L5_30") #local Name_ = 65; #end
#if (Track_Name_ = "T_L6_30") #local Name_ = 66; #end
#if (Track_Name_ = "T_L7_30") #local Name_ = 67; #end
#if (Track_Name_ = "T_L8_30") #local Name_ = 68; #end
#if (Track_Name_ = "T_L9_15") #local Name_ = 69; #end
#if (Track_Name_ ="T_L10_15") #local Name_ = 70; #end

#if (Track_Name_ = "T_L0_15") #local Name_ = 80; #end
#if (Track_Name_ = "T_L1_15") #local Name_ = 81; #end
#if (Track_Name_ = "T_L2_15") #local Name_ = 82; #end
#if (Track_Name_ = "T_L3_15") #local Name_ = 83; #end
#if (Track_Name_ = "T_L4_15") #local Name_ = 84; #end
#if (Track_Name_ = "T_L5_15") #local Name_ = 85; #end
#if (Track_Name_ = "T_L6_15") #local Name_ = 86; #end
#if (Track_Name_ = "T_L7_15") #local Name_ = 87; #end
#if (Track_Name_ = "T_L8_15") #local Name_ = 88; #end
#if (Track_Name_ = "T_L9_15") #local Name_ = 89; #end
#if (Track_Name_ ="T_L10_15") #local Name_ = 90; #end

#if (Track_Name_ = "T_L0_075") #local Name_=100; #end
#if (Track_Name_ = "T_L1_075") #local Name_=101; #end
#if (Track_Name_ = "T_L2_075") #local Name_=102; #end
#if (Track_Name_ = "T_L3_075") #local Name_=103; #end
#if (Track_Name_ = "T_L4_075") #local Name_=104; #end
#if (Track_Name_ = "T_L5_075") #local Name_=105; #end
#if (Track_Name_ = "T_L6_075") #local Name_=106; #end
#if (Track_Name_ = "T_L7_075") #local Name_=107; #end
#if (Track_Name_ = "T_L8_075") #local Name_=108; #end
#if (Track_Name_ = "T_L9_075") #local Name_=109; #end
#if (Track_Name_ ="T_L10_075") #local Name_=110; #end
 
#if (Track_Name_ = "T_239") #local Name_ =121; #end
#if (Track_Name_ = "T_231") #local Name_ =122; #end
#if (Track_Name_ = "T_119") #local Name_ =123; #end
#if (Track_Name_ = "T_115") #local Name_ =124; #end
#if (Track_Name_ = "T_107") #local Name_ =125; #end
#if (Track_Name_ = "T_062" ) #local Name_ =126; #end
#if (Track_Name_ = "T_940" ) #local Name_ =127; #end

//---------------------------------------------------------------------------------------
#if ( Gradient_Type = 0 ) // contious in one step
//--------------------- /////////////////////////////////////////////////////////////
#switch ( Name_ )
#case (0)  #local Type= "R"; #local Track = object{ R0_30 }; #local Len = R0; #local Angle = 30; #break 
#case (1)  #local Type= "R"; #local Track = object{ R1_30 }; #local Len = R1; #local Angle = 30; #break 
#case (2)  #local Type= "R"; #local Track = object{ R2_30 }; #local Len = R2; #local Angle = 30; #break 
#case (3)  #local Type= "R"; #local Track = object{ R3_30 }; #local Len = R3; #local Angle = 30; #break 
#case (4)  #local Type= "R"; #local Track = object{ R4_30 }; #local Len = R4; #local Angle = 30; #break 
#case (5)  #local Type= "R"; #local Track = object{ R5_30 }; #local Len = R5; #local Angle = 30; #break 
#case (6)  #local Type= "R"; #local Track = object{ R6_30 }; #local Len = R6; #local Angle = 30; #break 
#case (7)  #local Type= "R"; #local Track = object{ R7_30 }; #local Len = R7; #local Angle = 30; #break 
#case (8)  #local Type= "R"; #local Track = object{ R8_30 }; #local Len = R8; #local Angle = 30; #break 
#case (9)  #local Type= "R"; #local Track = object{ R9_30 }; #local Len = R9; #local Angle = 30; #break 
#case (10) #local Type= "R"; #local Track = object{ R10_30}; #local Len =R10; #local Angle = 30; #break 

#case (20) #local Type= "R"; #local Track = object{ R0_15 }; #local Len = R0; #local Angle = 15; #break 
#case (21) #local Type= "R"; #local Track = object{ R1_15 }; #local Len = R1; #local Angle = 15; #break 
#case (22) #local Type= "R"; #local Track = object{ R2_15 }; #local Len = R2; #local Angle = 15; #break 
#case (23) #local Type= "R"; #local Track = object{ R3_15 }; #local Len = R3; #local Angle = 15; #break 
#case (24) #local Type= "R"; #local Track = object{ R4_15 }; #local Len = R4; #local Angle = 15; #break 
#case (25) #local Type= "R"; #local Track = object{ R5_15 }; #local Len = R5; #local Angle = 15; #break 
#case (26) #local Type= "R"; #local Track = object{ R6_15 }; #local Len = R6; #local Angle = 15; #break 
#case (27) #local Type= "R"; #local Track = object{ R7_15 }; #local Len = R7; #local Angle = 15; #break 
#case (28) #local Type= "R"; #local Track = object{ R8_15 }; #local Len = R8; #local Angle = 15; #break 
#case (29) #local Type= "R"; #local Track = object{ R9_15 }; #local Len = R9; #local Angle = 15; #break 
#case (30) #local Type= "R"; #local Track = object{ R10_15}; #local Len =R10; #local Angle = 15; #break 

#case (40) #local Type= "R"; #local Track = object{ R0_075}; #local Len = R0; #local Angle =7.5; #break 
#case (41) #local Type= "R"; #local Track = object{ R1_075}; #local Len = R1; #local Angle =7.5; #break 
#case (42) #local Type= "R"; #local Track = object{ R2_075}; #local Len = R2; #local Angle =7.5; #break 
#case (43) #local Type= "R"; #local Track = object{ R3_075}; #local Len = R3; #local Angle =7.5; #break 
#case (44) #local Type= "R"; #local Track = object{ R4_075}; #local Len = R4; #local Angle =7.5; #break 
#case (45) #local Type= "R"; #local Track = object{ R5_075}; #local Len = R5; #local Angle =7.5; #break 
#case (46) #local Type= "R"; #local Track = object{ R6_075}; #local Len = R6; #local Angle =7.5; #break 
#case (47) #local Type= "R"; #local Track = object{ R7_075}; #local Len = R7; #local Angle =7.5; #break 
#case (48) #local Type= "R"; #local Track = object{ R8_075}; #local Len = R8; #local Angle =7.5; #break 
#case (49) #local Type= "R"; #local Track = object{ R9_075}; #local Len = R9; #local Angle =7.5; #break 
#case (50) #local Type= "R"; #local Track = object{R10_075}; #local Len =R10; #local Angle =7.5; #break 



#case (60) #local Type= "L"; #local Track = object{ L0_30 }; #local Len = R0; #local Angle = 30; #break 
#case (61) #local Type= "L"; #local Track = object{ L1_30 }; #local Len = R1; #local Angle = 30; #break 
#case (62) #local Type= "L"; #local Track = object{ L2_30 }; #local Len = R2; #local Angle = 30; #break 
#case (63) #local Type= "L"; #local Track = object{ L3_30 }; #local Len = R3; #local Angle = 30; #break 
#case (64) #local Type= "L"; #local Track = object{ L4_30 }; #local Len = R4; #local Angle = 30; #break 
#case (65) #local Type= "L"; #local Track = object{ L5_30 }; #local Len = R5; #local Angle = 30; #break 
#case (66) #local Type= "L"; #local Track = object{ L6_30 }; #local Len = R6; #local Angle = 30; #break 
#case (67) #local Type= "L"; #local Track = object{ L7_30 }; #local Len = R7; #local Angle = 30; #break 
#case (68) #local Type= "L"; #local Track = object{ L8_30 }; #local Len = R8; #local Angle = 30; #break 
#case (69) #local Type= "L"; #local Track = object{ L9_30 }; #local Len = R9; #local Angle = 30; #break 
#case (70) #local Type= "L"; #local Track = object{L10_30 }; #local Len =R10; #local Angle = 30; #break 


#case (80) #local Type= "L"; #local Track = object{ L0_15 }; #local Len = R0; #local Angle = 15; #break 
#case (81) #local Type= "L"; #local Track = object{ L1_15 }; #local Len = R1; #local Angle = 15; #break 
#case (82) #local Type= "L"; #local Track = object{ L2_15 }; #local Len = R2; #local Angle = 15; #break 
#case (83) #local Type= "L"; #local Track = object{ L3_15 }; #local Len = R3; #local Angle = 15; #break 
#case (84) #local Type= "L"; #local Track = object{ L4_15 }; #local Len = R4; #local Angle = 15; #break 
#case (85) #local Type= "L"; #local Track = object{ L5_15 }; #local Len = R5; #local Angle = 15; #break 
#case (86) #local Type= "L"; #local Track = object{ L6_15 }; #local Len = R6; #local Angle = 15; #break 
#case (87) #local Type= "L"; #local Track = object{ L7_15 }; #local Len = R7; #local Angle = 15; #break 
#case (88) #local Type= "L"; #local Track = object{ L8_15 }; #local Len = R8; #local Angle = 15; #break 
#case (89) #local Type= "L"; #local Track = object{ L9_15 }; #local Len = R9; #local Angle = 15; #break 
#case (90) #local Type= "L"; #local Track = object{L10_15 }; #local Len =R10; #local Angle = 15; #break 

#case (100) #local Type= "L"; #local Track = object{ L0_075}; #local Len = R0; #local Angle =7.5; #break 
#case (101) #local Type= "L"; #local Track = object{ L1_075}; #local Len = R1; #local Angle =7.5; #break 
#case (102) #local Type= "L"; #local Track = object{ L2_075}; #local Len = R2; #local Angle =7.5; #break 
#case (103) #local Type= "L"; #local Track = object{ L3_075}; #local Len = R3; #local Angle =7.5; #break 
#case (104) #local Type= "L"; #local Track = object{ L4_075}; #local Len = R4; #local Angle =7.5; #break 
#case (105) #local Type= "L"; #local Track = object{ L5_075}; #local Len = R5; #local Angle =7.5; #break 
#case (106) #local Type= "L"; #local Track = object{ L6_075}; #local Len = R6; #local Angle =7.5; #break 
#case (107) #local Type= "L"; #local Track = object{ L7_075}; #local Len = R7; #local Angle =7.5; #break 
#case (108) #local Type= "L"; #local Track = object{ L8_075}; #local Len = R8; #local Angle =7.5; #break 
#case (109) #local Type= "L"; #local Track = object{ L9_075}; #local Len = R9; #local Angle =7.5; #break 
#case (110) #local Type= "L"; #local Track = object{L10_075}; #local Len =R10; #local Angle =7.5; #break 


#case (121) #local Type= "G"; #local Track = object{ T_239 }; #local Len = L_239; #break 
#case (122) #local Type= "G"; #local Track = object{ T_231 }; #local Len = L_231; #break 
#case (123) #local Type= "G"; #local Track = object{ T_119 }; #local Len = L_119; #break 
#case (124) #local Type= "G"; #local Track = object{ T_115 }; #local Len = L_115; #break 
#case (125) #local Type= "G"; #local Track = object{ T_107 }; #local Len = L_107; #break 
#case (126) #local Type= "G"; #local Track = object{ T_062 }; #local Len = L_062 ; #break 
#case (127) #local Type= "G"; #local Track = object{ T_940 }; #local Len = L_940 ; #break 
#end // of switch -----------------------------------------------------
//---------------------------------------------- 
#if (Type = "R")
#local Sheer_Len =  Len*( sin( 2*pi/ (360/Angle ) ) )*1.04; // track length 30 degrees   
object{ Track
        rotate<0,-Angle/2,0>  
        matrix<1,Up_*H0 / Sheer_Len,0, 0,1,0, 0,0,1, 0,0,0> // matrix-shear_x_to_y    
        rotate< 0,Angle/2,0>
      } // end object
#end // #if (Type = "R")

#if (Type = "L")
#local Sheer_Len =  Len*( sin( 2*pi/ (360/Angle ) ) )*1.04; // track length 30 degrees   
object{ Track
        rotate<0,-Angle/2,0>   
        matrix<1,Up_*H0 / Sheer_Len,0, 0,1,0, 0,0,1, 0,0,0> // matrix-shear_x_to_y    
        rotate< 0,Angle/2,0>
      } // end object
#end // #if (Type = "L")

#if (Type = "G")
#local Sheer_Len =  Len*1.01; // track length 30 degrees   
object{ Track
        matrix<1,Up_*H0 / Sheer_Len,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y   
      } // end object
#end // #if (Type = "G")
 //-------------------------------
#end // of"#if (Gradient_Type = 0)

// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#if ( Gradient_Type = 1 ) // start (concave) in two step
#switch ( Name_ )                                  // here: Len = radius !! 
#case (0) #local Type= "R"; #local Track = object{ R0_15 }; #local RLen = R0; #local RAngle = 30; #break 
#case (1) #local Type= "R"; #local Track = object{ R1_15 }; #local RLen = R1; #local RAngle = 30; #break 
#case (2) #local Type= "R"; #local Track = object{ R2_15 }; #local RLen = R2; #local RAngle = 30; #break 
#case (3) #local Type= "R"; #local Track = object{ R3_15 }; #local RLen = R3; #local RAngle = 30; #break 
#case (4) #local Type= "R"; #local Track = object{ R4_15 }; #local RLen = R4; #local RAngle = 30; #break 
#case (5) #local Type= "R"; #local Track = object{ R5_15 }; #local RLen = R5; #local RAngle = 30; #break 
#case (6) #local Type= "R"; #local Track = object{ R6_15 }; #local RLen = R6; #local RAngle = 30; #break 
#case (7) #local Type= "R"; #local Track = object{ R7_15 }; #local RLen = R7; #local RAngle = 30; #break 
#case (8) #local Type= "R"; #local Track = object{ R8_15 }; #local RLen = R8; #local RAngle = 30; #break 
#case (9) #local Type= "R"; #local Track = object{ R9_15 }; #local RLen = R9; #local RAngle = 30; #break 
#case(10) #local Type= "R"; #local Track = object{R10_15 }; #local RLen =R10; #local RAngle = 30; #break 

#case(20) #local Type= "R"; #local Track = object{ R0_075}; #local RLen = R0; #local RAngle = 15; #break 
#case(21) #local Type= "R"; #local Track = object{ R1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case(22) #local Type= "R"; #local Track = object{ R2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case(23) #local Type= "R"; #local Track = object{ R3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case(24) #local Type= "R"; #local Track = object{ R4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case(25) #local Type= "R"; #local Track = object{ R5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case(26) #local Type= "R"; #local Track = object{ R6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case(27) #local Type= "R"; #local Track = object{ R7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case(28) #local Type= "R"; #local Track = object{ R8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case(29) #local Type= "R"; #local Track = object{ R9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case(30) #local Type= "R"; #local Track = object{R10_075}; #local RLen =R10; #local RAngle = 15; #break 

#case (60) #local Type= "L"; #local Track = object{ L0_15 }; #local RLen = R0; #local RAngle = 30; #break 
#case (61) #local Type= "L"; #local Track = object{ L1_15 }; #local RLen = R1; #local RAngle = 30; #break 
#case (62) #local Type= "L"; #local Track = object{ L2_15 }; #local RLen = R2; #local RAngle = 30; #break 
#case (63) #local Type= "L"; #local Track = object{ L3_15 }; #local RLen = R3; #local RAngle = 30; #break 
#case (64) #local Type= "L"; #local Track = object{ L4_15 }; #local RLen = R4; #local RAngle = 30; #break 
#case (65) #local Type= "L"; #local Track = object{ L5_15 }; #local RLen = R5; #local RAngle = 30; #break 
#case (66) #local Type= "L"; #local Track = object{ L6_15 }; #local RLen = R6; #local RAngle = 30; #break 
#case (67) #local Type= "L"; #local Track = object{ L7_15 }; #local RLen = R7; #local RAngle = 30; #break 
#case (68) #local Type= "L"; #local Track = object{ L8_15 }; #local RLen = R8; #local RAngle = 30; #break 
#case (69) #local Type= "L"; #local Track = object{ L9_15 }; #local RLen = R9; #local RAngle = 30; #break 
#case (70) #local Type= "L"; #local Track = object{L10_15 }; #local RLen =R10; #local RAngle = 30; #break 

#case (80) #local Type= "L"; #local Track = object{ L0_075}; #local RLen = R0; #local RAngle = 15; #break 
#case (81) #local Type= "L"; #local Track = object{ L1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case (82) #local Type= "L"; #local Track = object{ L2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case (83) #local Type= "L"; #local Track = object{ L3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case (84) #local Type= "L"; #local Track = object{ L4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case (85) #local Type= "L"; #local Track = object{ L5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case (86) #local Type= "L"; #local Track = object{ L6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case (87) #local Type= "L"; #local Track = object{ L7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case (88) #local Type= "L"; #local Track = object{ L8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case (89) #local Type= "L"; #local Track = object{ L9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case (90) #local Type= "L"; #local Track = object{L10_075}; #local RLen =R10; #local RAngle = 15; #break 

#case (121) #local Type= "G"; #local Track = object{ T_119 }; #local Len = L_119; #break 
#case (122) #local Type= "G"; #local Track = object{ T_115 }; #local Len = L_115; #break 
#case (123) #local Type= "G"; #local Track = object{T_Linear(L_119/2)}; #local Len = L_119/2; #break 
#case (124) #local Type= "G"; #local Track = object{T_Linear(L_115/2)}; #local Len = L_115/2; #break 
#case (125) #local Type= "G"; #local Track = object{T_Linear(L_107/2)}; #local Len = L_107/2; #break 
#case (126) #local Type= "G"; #local Track = object{T_Linear(L_062/2) }; #local Len = L_062/2 ; #break 
#case (127) #local Type= "G"; #local Track = object{T_Linear(L_940/2) }; #local Len = L_940/2 ; #break 
#end // of switch -----------------------------------------------------
//---------------------------------------------- 
 
#if (Type = "R")
#local Sheer_Len =  RLen*( sin( 1*pi/( 360/RAngle)))*1.04; //  track length  15 degrees
union{
object{ Track
        rotate<0,-RAngle/4,0>  // 
        matrix<1,Up_*H0  / Sheer_Len*0.333 ,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,RAngle/4,0>
      } // end object 
object{ Track
        rotate<0,-RAngle/4,0>  // 
        matrix<1,Up_*H0 / Sheer_Len* 0.667 ,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,RAngle/4,0>
        Rotate_Around_Trans(<0,  1*RAngle/2,0><0,0,-RLen>)
        translate<0,Up_*H0*0.333,0>   
      } // end object 
}// end union
#end // #if (Type = "R")

#if (Type = "L")
#local Sheer_Len =  RLen*( sin( 1*pi/ (360/RAngle)))*1.04; //  track length  15 degrees
union{
object{ Track
        rotate<0,RAngle/4,0>  // 
        matrix<1,Up_*H0 / Sheer_Len*0.333,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,-RAngle/4,0>
      } // end object 
object{ Track
        rotate<0, RAngle/4,0>  // 
        matrix<1,Up_*H0 / Sheer_Len*0.667,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,-RAngle/4,0>
        Rotate_Around_Trans(<0, -1*RAngle/2,0><0,0, RLen>)
        translate<0,Up_*H0*0.333,0>   
      } // end object 
}// end union
#end // #if (Type = "L")

#if (Type = "G")
#local Sheer_Len =  Len*1.01; // track length 30 degrees   
union{
object{ Track
        matrix<1,Up_*H0 / Sheer_Len*0.333,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
      } // end object 
object{ Track
        matrix<1,Up_*H0 / Sheer_Len*0.667,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        translate<Len,Up_*H0*0.333,0>   
      } // end object 
}// end union
 
#end // #if (Type = "G")
 
 //-------------------------------
#end // of"#if (Gradient_Type = 1)
// --------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------
#if ( Gradient_Type = 2 ) // end (convex) in two step
#switch ( Name_ )
#case (0) #local Type= "R"; #local Track = object{ R0_15 }; #local RLen = R0; #local RAngle = 30; #break 
#case (1) #local Type= "R"; #local Track = object{ R1_15 }; #local RLen = R1; #local RAngle = 30; #break 
#case (2) #local Type= "R"; #local Track = object{ R2_15 }; #local RLen = R2; #local RAngle = 30; #break 
#case (3) #local Type= "R"; #local Track = object{ R3_15 }; #local RLen = R3; #local RAngle = 30; #break 
#case (4) #local Type= "R"; #local Track = object{ R4_15 }; #local RLen = R4; #local RAngle = 30; #break 
#case (5) #local Type= "R"; #local Track = object{ R5_15 }; #local RLen = R5; #local RAngle = 30; #break 
#case (6) #local Type= "R"; #local Track = object{ R6_15 }; #local RLen = R6; #local RAngle = 30; #break 
#case (7) #local Type= "R"; #local Track = object{ R7_15 }; #local RLen = R7; #local RAngle = 30; #break 
#case (8) #local Type= "R"; #local Track = object{ R8_15 }; #local RLen = R8; #local RAngle = 30; #break 
#case (9) #local Type= "R"; #local Track = object{ R9_15 }; #local RLen = R9; #local RAngle = 30; #break 
#case(10) #local Type= "R"; #local Track = object{R10_15 }; #local RLen =R10; #local RAngle = 30; #break 

#case(20) #local Type= "R"; #local Track = object{ R0_075}; #local RLen = R0; #local RAngle = 15; #break 
#case(21) #local Type= "R"; #local Track = object{ R1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case(22) #local Type= "R"; #local Track = object{ R2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case(23) #local Type= "R"; #local Track = object{ R3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case(24) #local Type= "R"; #local Track = object{ R4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case(25) #local Type= "R"; #local Track = object{ R5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case(26) #local Type= "R"; #local Track = object{ R6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case(27) #local Type= "R"; #local Track = object{ R7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case(28) #local Type= "R"; #local Track = object{ R8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case(29) #local Type= "R"; #local Track = object{ R9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case(30) #local Type= "R"; #local Track = object{R10_075}; #local RLen =R10; #local RAngle = 15; #break 

#case (60) #local Type= "L"; #local Track = object{ L0_15 }; #local RLen = R0; #local RAngle = 30; #break 
#case (61) #local Type= "L"; #local Track = object{ L1_15 }; #local RLen = R1; #local RAngle = 30; #break 
#case (62) #local Type= "L"; #local Track = object{ L2_15 }; #local RLen = R2; #local RAngle = 30; #break 
#case (63) #local Type= "L"; #local Track = object{ L3_15 }; #local RLen = R3; #local RAngle = 30; #break 
#case (64) #local Type= "L"; #local Track = object{ L4_15 }; #local RLen = R4; #local RAngle = 30; #break 
#case (65) #local Type= "L"; #local Track = object{ L5_15 }; #local RLen = R5; #local RAngle = 30; #break 
#case (66) #local Type= "L"; #local Track = object{ L6_15 }; #local RLen = R6; #local RAngle = 30; #break 
#case (67) #local Type= "L"; #local Track = object{ L7_15 }; #local RLen = R7; #local RAngle = 30; #break 
#case (68) #local Type= "L"; #local Track = object{ L8_15 }; #local RLen = R8; #local RAngle = 30; #break 
#case (69) #local Type= "L"; #local Track = object{ L9_15 }; #local RLen = R9; #local RAngle = 30; #break 
#case (70) #local Type= "L"; #local Track = object{L10_15 }; #local RLen =R10; #local RAngle = 30; #break 

#case (80) #local Type= "L"; #local Track = object{ L0_075}; #local RLen = R0; #local RAngle = 15; #break 
#case (81) #local Type= "L"; #local Track = object{ L1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case (82) #local Type= "L"; #local Track = object{ L2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case (83) #local Type= "L"; #local Track = object{ L3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case (84) #local Type= "L"; #local Track = object{ L4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case (85) #local Type= "L"; #local Track = object{ L5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case (86) #local Type= "L"; #local Track = object{ L6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case (87) #local Type= "L"; #local Track = object{ L7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case (88) #local Type= "L"; #local Track = object{ L8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case (89) #local Type= "L"; #local Track = object{ L9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case (90) #local Type= "L"; #local Track = object{L10_075}; #local RLen =R10; #local RAngle = 15; #break 

#case (121) #local Type= "G"; #local Track = object{ T_119 }; #local Len = L_119; #break 
#case (122) #local Type= "G"; #local Track = object{ T_115 }; #local Len = L_115; #break 
#case (123) #local Type= "G"; #local Track = object{T_Linear(L_119/2)}; #local Len = L_119/2; #break 
#case (124) #local Type= "G"; #local Track = object{T_Linear(L_115/2)}; #local Len = L_115/2; #break 
#case (125) #local Type= "G"; #local Track = object{T_Linear(L_107/2)}; #local Len = L_107/2; #break 
#case (126) #local Type= "G"; #local Track = object{T_Linear(L_062/2) }; #local Len = L_062/2 ; #break 
#case (127) #local Type= "G"; #local Track = object{T_Linear(L_940/2) }; #local Len = L_940/2 ; #break 
#end // of switch -----------------------------------------------------
//---------------------------------------------- 
#if (Type = "R")
#local Sheer_Len =  RLen*( sin( 2*pi/(360/(RAngle)) ) )*1.04; //  track length  15 degrees
union{
 object{ Track
        rotate<0,-RAngle/4,0>  //     
        matrix<1,Up_*H0 / Sheer_Len *1.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0, RAngle/4,0>
      } // end object 
 object{ Track
        rotate<0,-RAngle/4,0>  //     
        matrix<1, Up_*H0 / Sheer_Len *0.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0, RAngle/4,0>
        Rotate_Around_Trans(<0,1*RAngle/2,0><0,0,-RLen>)
        translate<0,Up_*H0*0.75,0>   
      } // end object 
}// end union
#end // #if (Type = "R")

#if (Type = "L")
#local Sheer_Len =  RLen*( sin(  2*pi/(360/RAngle) ) )*1.04; //  track length  15 degrees
union{
 object{ Track
        rotate<0, RAngle/4,0>  // 
        matrix<1, Up_*H0 / Sheer_Len *1.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0,-RAngle/4,0>
      } // end object 
 object{ Track
        rotate<0, RAngle/4,0>  // 
        matrix<1, Up_*H0 / Sheer_Len *0.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0,-RAngle/4,0>
        Rotate_Around_Trans(<0,-1*RAngle/2,0><0,0, RLen>)
        translate<0,Up_*H0*0.75,0>   
      } // end object 
}// end union

#end // #if (Type = "L")

#if (Type = "G")
#local Sheer_Len =  Len*1.01; // track length 30 degrees   
union{
object{ Track
        matrix<1,Up_*H0 / Sheer_Len*0.667,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
      } // end object 
object{ Track
        matrix<1,Up_*H0 / Sheer_Len*0.333,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        translate<Len,Up_*H0*0.667,0>   
      } // end object 
}// end union


#end // #if (Type = "G")
 //-------------------------------
#end // of"#if (Gradient_Type = 2)
// --------------------------------------------------------------------------------------


// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
//---------------------------------------------------------------------------------------
#include "RR_System/RT_H0_TypeB_Track_Up_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ Track_Up_00( "R1", //  Name_,    // Track_Name "R1","R2","R3","R4", ... ,"R9","L1",..."L9","G239" 
                      0.175, // Up_, // step value for H0 scale (in meter) // i.e. 0.0160,                                
                      0, // Gradient_Type, // 0 = continous, 1 = start(concav), 2 = end(convex)
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_H0_TypeB_Track_Up_00_Inc_Temp;
#end
//------------------------------------- end of include file

