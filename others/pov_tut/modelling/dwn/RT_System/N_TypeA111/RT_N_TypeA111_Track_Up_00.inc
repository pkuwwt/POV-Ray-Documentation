// POV-Ray 3.7 include file "RT_N_TypeA111_Track_Up_00.inc"
// author: Friedrich A, Lohmueller, Nov-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_N_TypeA111_Track_Up_00_Inc_Temp)
#declare RT_N_TypeA111_Track_Up_00_Inc_Temp = version;
#version 3.7;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// Sheers tracks by Up_ (N scale model size in meter) up / down 
// Gradient_Type = 0:  continous sheering up or down 
// Gradient_Type = 1:  concav sheering (tracks splitted in 2 parts) for start of ascent or end of slope.
// Gradient_Type = 2:  concav sheering (tracks splitted in 2 parts) for end of ascent or start of slope.

// needs: call after inclusion of "RT_N_TypeA_Set_00.inc"
//------------------------------------------------------------------------------ /////////  
#macro Track_Up_00(  Track_Name_,    // Track_Name "R1","R2","R3","R4", ... ,"R9","L1",..."L9","G239" 
                     Up_, // value for N scale (in meter) // i.e. 0.0160,                                
                     Gradient_Type  // 0 = continous, 1 = start(concav), 2 = end(c)
                  )  //--------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
#local N = 160; 
//---------------------------------------------------------------------------------------
// right curves
#if (Track_Name_ = "T_R1_45") #local Name_ = 1; #end
#if (Track_Name_ = "T_R2_45") #local Name_ = 2; #end
#if (Track_Name_ = "T_R3_45") #local Name_ = 3; #end
#if (Track_Name_ = "T_R4_45") #local Name_ = 4; #end
#if (Track_Name_ = "T_R5_45") #local Name_ = 5; #end
#if (Track_Name_ = "T_R6_45") #local Name_ = 6; #end
#if (Track_Name_ = "T_R7_45") #local Name_ = 7; #end
#if (Track_Name_ = "T_R8_45") #local Name_ = 8; #end
#if (Track_Name_ = "T_R9_45") #local Name_ = 9; #end
#if (Track_Name_ ="T_R10_45") #local Name_ =10; #end

#if (Track_Name_ = "T_R1_30") #local Name_ = 11; #end
#if (Track_Name_ = "T_R2_30") #local Name_ = 12; #end
#if (Track_Name_ = "T_R3_30") #local Name_ = 13; #end
#if (Track_Name_ = "T_R4_30") #local Name_ = 14; #end
#if (Track_Name_ = "T_R5_30") #local Name_ = 15; #end
#if (Track_Name_ = "T_R6_30") #local Name_ = 16; #end
#if (Track_Name_ = "T_R7_30") #local Name_ = 17; #end
#if (Track_Name_ = "T_R8_30") #local Name_ = 18; #end
#if (Track_Name_ = "T_R9_30") #local Name_ = 19; #end
#if (Track_Name_ ="T_R10_30") #local Name_ = 20; #end

#if (Track_Name_ = "T_R1_15") #local Name_ = 31; #end
#if (Track_Name_ = "T_R2_15") #local Name_ = 32; #end
#if (Track_Name_ = "T_R3_15") #local Name_ = 33; #end
#if (Track_Name_ = "T_R4_15") #local Name_ = 34; #end
#if (Track_Name_ = "T_R5_15") #local Name_ = 35; #end
#if (Track_Name_ = "T_R6_15") #local Name_ = 36; #end
#if (Track_Name_ = "T_R7_15") #local Name_ = 37; #end
#if (Track_Name_ = "T_R8_15") #local Name_ = 38; #end
#if (Track_Name_ = "T_R9_15") #local Name_ = 39; #end
#if (Track_Name_ ="T_R10_15") #local Name_ = 40; #end

#if (Track_Name_ = "T_R1_075") #local Name_ = 41; #end
#if (Track_Name_ = "T_R2_075") #local Name_ = 42; #end
#if (Track_Name_ = "T_R3_075") #local Name_ = 43; #end
#if (Track_Name_ = "T_R4_075") #local Name_ = 44; #end
#if (Track_Name_ = "T_R5_075") #local Name_ = 45; #end
#if (Track_Name_ = "T_R6_075") #local Name_ = 46; #end
#if (Track_Name_ = "T_R7_075") #local Name_ = 47; #end
#if (Track_Name_ = "T_R8_075") #local Name_ = 48; #end
#if (Track_Name_ = "T_R9_075") #local Name_ = 49; #end
#if (Track_Name_ ="T_R10_075") #local Name_ = 50; #end

// left curves
#if (Track_Name_ = "T_L1_45") #local Name_ = 51; #end
#if (Track_Name_ = "T_L2_45") #local Name_ = 52; #end
#if (Track_Name_ = "T_L3_45") #local Name_ = 53; #end
#if (Track_Name_ = "T_L4_45") #local Name_ = 54; #end
#if (Track_Name_ = "T_L5_45") #local Name_ = 55; #end
#if (Track_Name_ = "T_L6_45") #local Name_ = 56; #end
#if (Track_Name_ = "T_L7_45") #local Name_ = 57; #end
#if (Track_Name_ = "T_L8_45") #local Name_ = 58; #end
#if (Track_Name_ = "T_L9_45") #local Name_ = 59; #end
#if (Track_Name_ ="T_L10_45") #local Name_ = 60; #end

#if (Track_Name_ = "T_L1_30") #local Name_ = 61; #end
#if (Track_Name_ = "T_L2_30") #local Name_ = 62; #end
#if (Track_Name_ = "T_L3_30") #local Name_ = 63; #end
#if (Track_Name_ = "T_L4_30") #local Name_ = 64; #end
#if (Track_Name_ = "T_L5_30") #local Name_ = 65; #end
#if (Track_Name_ = "T_L6_30") #local Name_ = 66; #end
#if (Track_Name_ = "T_L7_30") #local Name_ = 67; #end
#if (Track_Name_ = "T_L8_30") #local Name_ = 68; #end
#if (Track_Name_ = "T_L9_30") #local Name_ = 69; #end
#if (Track_Name_ ="T_L10_30") #local Name_ = 70; #end

#if (Track_Name_ = "T_L1_15") #local Name_ = 71; #end
#if (Track_Name_ = "T_L2_15") #local Name_ = 72; #end
#if (Track_Name_ = "T_L3_15") #local Name_ = 73; #end
#if (Track_Name_ = "T_L4_15") #local Name_ = 74; #end
#if (Track_Name_ = "T_L5_15") #local Name_ = 75; #end
#if (Track_Name_ = "T_L6_15") #local Name_ = 76; #end
#if (Track_Name_ = "T_L7_15") #local Name_ = 77; #end
#if (Track_Name_ = "T_L8_15") #local Name_ = 78; #end
#if (Track_Name_ = "T_L9_15") #local Name_ = 79; #end
#if (Track_Name_ ="T_L10_15") #local Name_ = 80; #end

#if (Track_Name_ = "T_L1_075") #local Name_ = 81; #end
#if (Track_Name_ = "T_L2_075") #local Name_ = 82; #end
#if (Track_Name_ = "T_L3_075") #local Name_ = 83; #end
#if (Track_Name_ = "T_L4_075") #local Name_ = 84; #end
#if (Track_Name_ = "T_L5_075") #local Name_ = 85; #end
#if (Track_Name_ = "T_L6_075") #local Name_ = 86; #end
#if (Track_Name_ = "T_L7_075") #local Name_ = 87; #end
#if (Track_Name_ = "T_L8_075") #local Name_ = 88; #end
#if (Track_Name_ = "T_L9_075") #local Name_ = 89; #end
#if (Track_Name_ ="T_L10_075") #local Name_ = 90; #end

#if (Track_Name_ = "T_777")  #local Name_ = 91; #end
#if (Track_Name_ = "T_222")  #local Name_ = 92; #end
#if (Track_Name_ = "T_115")  #local Name_ = 93; #end
#if (Track_Name_ = "T_111")  #local Name_ = 94; #end
#if (Track_Name_ = "T_107")  #local Name_ = 95; #end
#if (Track_Name_ = "T_057")  #local Name_ = 96; #end
#if (Track_Name_ = "T_055")  #local Name_ = 97; #end
#if (Track_Name_ = "T_028")  #local Name_ = 98; #end


//---------------------------------------------------------------------------------------
#if ( Gradient_Type = 0 ) // contious in one step
//--------------------- /////////////////////////////////////////////////////////////
#switch ( Name_ )
#case (1)  #local Type= "R"; #local Track = object{ T_R1_45 }; #local Len = R1; #local Angle = 45; #break 
#case (2)  #local Type= "R"; #local Track = object{ T_R2_45 }; #local Len = R2; #local Angle = 45; #break 
#case (3)  #local Type= "R"; #local Track = object{ T_R3_45 }; #local Len = R3; #local Angle = 45; #break 
#case (4)  #local Type= "R"; #local Track = object{ T_R4_45 }; #local Len = R4; #local Angle = 45; #break 
#case (5)  #local Type= "R"; #local Track = object{ T_R5_45 }; #local Len = R5; #local Angle = 45; #break 
#case (6)  #local Type= "R"; #local Track = object{ T_R6_45 }; #local Len = R6; #local Angle = 45; #break 
#case (7)  #local Type= "R"; #local Track = object{ T_R7_45 }; #local Len = R7; #local Angle = 45; #break 
#case (8)  #local Type= "R"; #local Track = object{ T_R8_45 }; #local Len = R8; #local Angle = 45; #break 
#case (9)  #local Type= "R"; #local Track = object{ T_R9_45 }; #local Len = R9; #local Angle = 45; #break 
#case (10) #local Type= "R"; #local Track = object{ T_R10_45}; #local Len =R10; #local Angle = 45; #break 

#case (11) #local Type= "R"; #local Track = object{ T_R1_30 }; #local Len = R1; #local Angle = 30; #break 
#case (12) #local Type= "R"; #local Track = object{ T_R2_30 }; #local Len = R2; #local Angle = 30; #break 
#case (13) #local Type= "R"; #local Track = object{ T_R3_30 }; #local Len = R3; #local Angle = 30; #break 
#case (14) #local Type= "R"; #local Track = object{ T_R4_30 }; #local Len = R4; #local Angle = 30; #break 
#case (15) #local Type= "R"; #local Track = object{ T_R5_30 }; #local Len = R5; #local Angle = 30; #break 
#case (16) #local Type= "R"; #local Track = object{ T_R6_30 }; #local Len = R6; #local Angle = 30; #break 
#case (17) #local Type= "R"; #local Track = object{ T_R7_30 }; #local Len = R7; #local Angle = 30; #break 
#case (18) #local Type= "R"; #local Track = object{ T_R8_30 }; #local Len = R8; #local Angle = 30; #break 
#case (19) #local Type= "R"; #local Track = object{ T_R9_30 }; #local Len = R9; #local Angle = 30; #break 
#case (20) #local Type= "R"; #local Track = object{ T_R10_30}; #local Len =R10; #local Angle = 30; #break 

#case (31) #local Type= "R"; #local Track = object{ T_R1_15 }; #local Len = R1; #local Angle = 15; #break 
#case (32) #local Type= "R"; #local Track = object{ T_R2_15 }; #local Len = R2; #local Angle = 15; #break 
#case (33) #local Type= "R"; #local Track = object{ T_R3_15 }; #local Len = R3; #local Angle = 15; #break 
#case (34) #local Type= "R"; #local Track = object{ T_R4_15 }; #local Len = R4; #local Angle = 15; #break 
#case (35) #local Type= "R"; #local Track = object{ T_R5_15 }; #local Len = R5; #local Angle = 15; #break 
#case (36) #local Type= "R"; #local Track = object{ T_R6_15 }; #local Len = R6; #local Angle = 15; #break 
#case (37) #local Type= "R"; #local Track = object{ T_R7_15 }; #local Len = R7; #local Angle = 15; #break 
#case (38) #local Type= "R"; #local Track = object{ T_R8_15 }; #local Len = R8; #local Angle = 15; #break 
#case (39) #local Type= "R"; #local Track = object{ T_R9_15 }; #local Len = R9; #local Angle = 15; #break 
#case (40) #local Type= "R"; #local Track = object{ T_R10_15}; #local Len =R10; #local Angle = 15; #break 

#case (41) #local Type= "R"; #local Track = object{ T_R1_075}; #local Len = R1; #local Angle =7.5; #break 
#case (42) #local Type= "R"; #local Track = object{ T_R2_075}; #local Len = R2; #local Angle =7.5; #break 
#case (43) #local Type= "R"; #local Track = object{ T_R3_075}; #local Len = R3; #local Angle =7.5; #break 
#case (44) #local Type= "R"; #local Track = object{ T_R4_075}; #local Len = R4; #local Angle =7.5; #break 
#case (45) #local Type= "R"; #local Track = object{ T_R5_075}; #local Len = R5; #local Angle =7.5; #break 
#case (46) #local Type= "R"; #local Track = object{ T_R6_075}; #local Len = R6; #local Angle =7.5; #break 
#case (47) #local Type= "R"; #local Track = object{ T_R7_075}; #local Len = R7; #local Angle =7.5; #break 
#case (48) #local Type= "R"; #local Track = object{ T_R8_075}; #local Len = R8; #local Angle =7.5; #break 
#case (49) #local Type= "R"; #local Track = object{ T_R9_075}; #local Len = R9; #local Angle =7.5; #break 
#case (50) #local Type= "R"; #local Track = object{T_R10_075}; #local Len =R10; #local Angle =7.5; #break 


#case (51) #local Type= "L"; #local Track = object{ T_L1_45 }; #local Len = R1; #local Angle = 45; #break 
#case (52) #local Type= "L"; #local Track = object{ T_L2_45 }; #local Len = R2; #local Angle = 45; #break 
#case (53) #local Type= "L"; #local Track = object{ T_L3_45 }; #local Len = R3; #local Angle = 45; #break 
#case (54) #local Type= "L"; #local Track = object{ T_L4_45 }; #local Len = R4; #local Angle = 45; #break 
#case (55) #local Type= "L"; #local Track = object{ T_L5_45 }; #local Len = R5; #local Angle = 45; #break 
#case (56) #local Type= "L"; #local Track = object{ T_L6_45 }; #local Len = R6; #local Angle = 45; #break 
#case (57) #local Type= "L"; #local Track = object{ T_L7_45 }; #local Len = R7; #local Angle = 45; #break 
#case (58) #local Type= "L"; #local Track = object{ T_L8_45 }; #local Len = R8; #local Angle = 45; #break 
#case (59) #local Type= "L"; #local Track = object{ T_L9_45 }; #local Len = R9; #local Angle = 45; #break 
#case (60) #local Type= "L"; #local Track = object{ T_L10_45}; #local Len =R10; #local Angle = 45; #break 

#case (61) #local Type= "L"; #local Track = object{ T_L1_30 }; #local Len = R1; #local Angle = 30; #break 
#case (62) #local Type= "L"; #local Track = object{ T_L2_30 }; #local Len = R2; #local Angle = 30; #break 
#case (63) #local Type= "L"; #local Track = object{ T_L3_30 }; #local Len = R3; #local Angle = 30; #break 
#case (64) #local Type= "L"; #local Track = object{ T_L4_30 }; #local Len = R4; #local Angle = 30; #break 
#case (65) #local Type= "L"; #local Track = object{ T_L5_30 }; #local Len = R5; #local Angle = 30; #break 
#case (66) #local Type= "L"; #local Track = object{ T_L6_30 }; #local Len = R6; #local Angle = 30; #break 
#case (67) #local Type= "L"; #local Track = object{ T_L7_30 }; #local Len = R7; #local Angle = 30; #break 
#case (68) #local Type= "L"; #local Track = object{ T_L8_30 }; #local Len = R8; #local Angle = 30; #break 
#case (69) #local Type= "L"; #local Track = object{ T_L9_30 }; #local Len = R9; #local Angle = 30; #break 
#case (70) #local Type= "L"; #local Track = object{T_L10_30 }; #local Len =R10; #local Angle = 30; #break 

#case (71) #local Type= "L"; #local Track = object{ T_L1_15 }; #local Len = R1; #local Angle = 15; #break 
#case (72) #local Type= "L"; #local Track = object{ T_L2_15 }; #local Len = R2; #local Angle = 15; #break 
#case (73) #local Type= "L"; #local Track = object{ T_L3_15 }; #local Len = R3; #local Angle = 15; #break 
#case (74) #local Type= "L"; #local Track = object{ T_L4_15 }; #local Len = R4; #local Angle = 15; #break 
#case (75) #local Type= "L"; #local Track = object{ T_L5_15 }; #local Len = R5; #local Angle = 15; #break 
#case (76) #local Type= "L"; #local Track = object{ T_L6_15 }; #local Len = R6; #local Angle = 15; #break 
#case (77) #local Type= "L"; #local Track = object{ T_L7_15 }; #local Len = R7; #local Angle = 15; #break 
#case (78) #local Type= "L"; #local Track = object{ T_L8_15 }; #local Len = R8; #local Angle = 15; #break 
#case (79) #local Type= "L"; #local Track = object{ T_L9_15 }; #local Len = R9; #local Angle = 15; #break 
#case (80) #local Type= "L"; #local Track = object{T_L10_15 }; #local Len =R10; #local Angle = 15; #break 

#case (81) #local Type= "L"; #local Track = object{ T_L1_075}; #local Len = R1; #local Angle =7.5; #break 
#case (82) #local Type= "L"; #local Track = object{ T_L2_075}; #local Len = R2; #local Angle =7.5; #break 
#case (83) #local Type= "L"; #local Track = object{ T_L3_075}; #local Len = R3; #local Angle =7.5; #break 
#case (84) #local Type= "L"; #local Track = object{ T_L4_075}; #local Len = R4; #local Angle =7.5; #break 
#case (85) #local Type= "L"; #local Track = object{ T_L5_075}; #local Len = R5; #local Angle =7.5; #break 
#case (86) #local Type= "L"; #local Track = object{ T_L6_075}; #local Len = R6; #local Angle =7.5; #break 
#case (87) #local Type= "L"; #local Track = object{ T_L7_075}; #local Len = R7; #local Angle =7.5; #break 
#case (88) #local Type= "L"; #local Track = object{ T_L8_075}; #local Len = R8; #local Angle =7.5; #break 
#case (89) #local Type= "L"; #local Track = object{ T_L9_075}; #local Len = R9; #local Angle =7.5; #break 
#case (90) #local Type= "L"; #local Track = object{T_L10_075}; #local Len =R10; #local Angle =7.5; #break 


#case (91) #local Type= "G"; #local Track = object{ T_777  }; #local Len = L777;  #break 
#case (92) #local Type= "G"; #local Track = object{ T_222  }; #local Len = L222;  #break 
#case (93) #local Type= "G"; #local Track = object{ T_115  }; #local Len = L115;  #break 
#case (94) #local Type= "G"; #local Track = object{ T_111  }; #local Len = L111;  #break 
#case (95) #local Type= "G"; #local Track = object{ T_107  }; #local Len = L107;  #break 
#case (96) #local Type= "G"; #local Track = object{ T_057  }; #local Len = L057; #break 
#case (97) #local Type= "G"; #local Track = object{ T_055  }; #local Len = L055; #break 
#case (98) #local Type= "G"; #local Track = object{ T_028  }; #local Len = L028;  #break 
#end // of switch -----------------------------------------------------


//---------------------------------------------- 
#if (Type = "R")
#local Shear_Len =  Len*( sin( 2*pi/ (360/Angle ) ) )*0.95; // track length 30 degrees   
object{ Track
        rotate<0,-Angle/2,0>  
        matrix<1,Up_*N / Shear_Len,0, 0,1,0, 0,0,1, 0,0,0> // matrix-shear_x_to_y    
        rotate< 0,Angle/2,0>
      } // end object
#end // #if (Type = "R")

#if (Type = "L")
#local Shear_Len =  Len*( sin( 2*pi/ (360/Angle ) ) )*0.95; // track length 30 degrees   
object{ Track
        rotate<0,-Angle/2,0>   
        matrix<1,Up_*N / Shear_Len,0, 0,1,0, 0,0,1, 0,0,0> // matrix-shear_x_to_y    
        rotate< 0,Angle/2,0>
      } // end object
#end // #if (Type = "L")

#if (Type = "G")
#local Shear_Len =  Len*1.01; // track length 30 degrees   
object{ Track
        matrix<1,Up_*N / Shear_Len,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y   
      } // end object
#end // #if (Type = "G")
 //-------------------------------
#end // of"#if (Gradient_Type = 0)

// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#if ( Gradient_Type = 1 ) // start (concave) in two step
#switch ( Name_ )                                  // here: Len = radius !! 

// 45° -> splitted in 2*22.5° 
#case (1)  #local Type= "R"; #local Track = object{ T_R1_225}; #local RLen = R1; #local RAngle = 45; #break 
#case (2)  #local Type= "R"; #local Track = object{ T_R2_225}; #local RLen = R2; #local RAngle = 45; #break 
#case (3)  #local Type= "R"; #local Track = object{ T_R3_225}; #local RLen = R3; #local RAngle = 45; #break 
#case (4)  #local Type= "R"; #local Track = object{ T_R4_225}; #local RLen = R4; #local RAngle = 45; #break 
#case (5)  #local Type= "R"; #local Track = object{ T_R5_225}; #local RLen = R5; #local RAngle = 45; #break 
#case (6)  #local Type= "R"; #local Track = object{ T_R6_225}; #local RLen = R6; #local RAngle = 45; #break 
#case (7)  #local Type= "R"; #local Track = object{ T_R7_225}; #local RLen = R7; #local RAngle = 45; #break 
#case (8)  #local Type= "R"; #local Track = object{ T_R8_225}; #local RLen = R8; #local RAngle = 45; #break 
#case (9)  #local Type= "R"; #local Track = object{ T_R9_225}; #local RLen = R9; #local RAngle = 45; #break 
#case (10) #local Type= "R"; #local Track = object{T_R10_225}; #local RLen =R10; #local RAngle = 45; #break 

// 30° -> splitted in 2*15° 
#case (11)  #local Type= "R"; #local Track = object{ T_R1_15}; #local RLen = R1; #local RAngle = 30; #break 
#case (12)  #local Type= "R"; #local Track = object{ T_R2_15}; #local RLen = R2; #local RAngle = 30; #break 
#case (13)  #local Type= "R"; #local Track = object{ T_R3_15}; #local RLen = R3; #local RAngle = 30; #break 
#case (14)  #local Type= "R"; #local Track = object{ T_R4_15}; #local RLen = R4; #local RAngle = 30; #break 
#case (15)  #local Type= "R"; #local Track = object{ T_R5_15}; #local RLen = R5; #local RAngle = 30; #break 
#case (16)  #local Type= "R"; #local Track = object{ T_R6_15}; #local RLen = R6; #local RAngle = 30; #break 
#case (17)  #local Type= "R"; #local Track = object{ T_R7_15}; #local RLen = R7; #local RAngle = 30; #break 
#case (18)  #local Type= "R"; #local Track = object{ T_R8_15}; #local RLen = R8; #local RAngle = 30; #break 
#case (19)  #local Type= "R"; #local Track = object{ T_R9_15}; #local RLen = R9; #local RAngle = 30; #break 
#case (20)  #local Type= "R"; #local Track = object{T_R10_15}; #local RLen =R10; #local RAngle = 30; #break 

// 15° -> splitted in 2*7,5° 
#case (31)  #local Type= "R"; #local Track = object{ T_R1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case (32)  #local Type= "R"; #local Track = object{ T_R2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case (33)  #local Type= "R"; #local Track = object{ T_R3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case (34)  #local Type= "R"; #local Track = object{ T_R4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case (35)  #local Type= "R"; #local Track = object{ T_R5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case (36)  #local Type= "R"; #local Track = object{ T_R6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case (37)  #local Type= "R"; #local Track = object{ T_R7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case (38)  #local Type= "R"; #local Track = object{ T_R8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case (39)  #local Type= "R"; #local Track = object{ T_R9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case (40)  #local Type= "R"; #local Track = object{T_R10_075}; #local RLen =R10; #local RAngle = 15; #break 

// left curves
// 45° -> splitted in 2*22.5° 
#case (51) #local Type= "L"; #local Track = object{ T_L1_225}; #local RLen = R1; #local RAngle = 45; #break 
#case (52) #local Type= "L"; #local Track = object{ T_L2_225}; #local RLen = R2; #local RAngle = 45; #break 
#case (53) #local Type= "L"; #local Track = object{ T_L3_225}; #local RLen = R3; #local RAngle = 45; #break 
#case (54) #local Type= "L"; #local Track = object{ T_L4_225}; #local RLen = R4; #local RAngle = 45; #break 
#case (55) #local Type= "L"; #local Track = object{ T_L5_225}; #local RLen = R5; #local RAngle = 45; #break 
#case (56) #local Type= "L"; #local Track = object{ T_L6_225}; #local RLen = R6; #local RAngle = 45; #break 
#case (57) #local Type= "L"; #local Track = object{ T_L7_225}; #local RLen = R7; #local RAngle = 45; #break 
#case (58) #local Type= "L"; #local Track = object{ T_L8_225}; #local RLen = R8; #local RAngle = 45; #break 
#case (59) #local Type= "L"; #local Track = object{ T_L9_225}; #local RLen = R9; #local RAngle = 45; #break 
#case (60) #local Type= "L"; #local Track = object{T_L10_225}; #local RLen =R10; #local RAngle = 45; #break 

// 30° -> splitted in 2*15° 
#case (61) #local Type= "L"; #local Track = object{ T_L1_15}; #local RLen = R1; #local RAngle = 30; #break 
#case (62) #local Type= "L"; #local Track = object{ T_L2_15}; #local RLen = R2; #local RAngle = 30; #break 
#case (63) #local Type= "L"; #local Track = object{ T_L3_15}; #local RLen = R3; #local RAngle = 30; #break 
#case (64) #local Type= "L"; #local Track = object{ T_L4_15}; #local RLen = R4; #local RAngle = 30; #break 
#case (65) #local Type= "L"; #local Track = object{ T_L5_15}; #local RLen = R5; #local RAngle = 30; #break 
#case (66) #local Type= "L"; #local Track = object{ T_L6_15}; #local RLen = R6; #local RAngle = 30; #break 
#case (67) #local Type= "L"; #local Track = object{ T_L7_15}; #local RLen = R7; #local RAngle = 30; #break 
#case (68) #local Type= "L"; #local Track = object{ T_L8_15}; #local RLen = R8; #local RAngle = 30; #break 
#case (69) #local Type= "L"; #local Track = object{ T_L9_15}; #local RLen = R9; #local RAngle = 30; #break 
#case (70) #local Type= "L"; #local Track = object{T_L10_15}; #local RLen =R10; #local RAngle = 30; #break 

// 15° -> splitted in 2*7.5° 
#case (71) #local Type= "L"; #local Track = object{ T_L1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case (72) #local Type= "L"; #local Track = object{ T_L2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case (73) #local Type= "L"; #local Track = object{ T_L3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case (74) #local Type= "L"; #local Track = object{ T_L4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case (75) #local Type= "L"; #local Track = object{ T_L5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case (76) #local Type= "L"; #local Track = object{ T_L6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case (77) #local Type= "L"; #local Track = object{ T_L7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case (78) #local Type= "L"; #local Track = object{ T_L8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case (79) #local Type= "L"; #local Track = object{ T_L9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case (80) #local Type= "L"; #local Track = object{T_L10_075}; #local RLen =R10; #local RAngle = 15; #break 

// straight tracks 
#case (92) #local Type= "G"; #local Track = object{ T_111  }; #local Len = L222/2;  #break 
#case (93) #local Type= "G"; #local Track = object{ T_057  }; #local Len = L115/2;  #break 
#case (94) #local Type= "G"; #local Track = object{ T_055  }; #local Len = L111/2;  #break 
#end // of switch -----------------------------------------------------
//---------------------------------------------- 
 
#if (Type = "R")
#local Shear_Len =  RLen*( sin( 1*pi/( 360/RAngle)))*0.95; //  track length  15 degrees
union{
object{ Track
        rotate<0,-RAngle/4,0>  // 
        matrix<1,Up_*N  / Shear_Len*0.333 ,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,RAngle/4,0>
      } // end object 
object{ Track
        rotate<0,-RAngle/4,0>  // 
        matrix<1,Up_*N / Shear_Len* 0.667 ,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,RAngle/4,0>
        Rotate_Around_Trans(<0,  1*RAngle/2,0><0,0,-RLen>)
        translate<0,Up_*N*0.333,0>   
      } // end object 
}// end union
#end // #if (Type = "R")

#if (Type = "L")
#local Shear_Len =  RLen*( sin( 1*pi/ (360/RAngle)))*0.95; //  track length  15 degrees
union{
object{ Track
        rotate<0,RAngle/4,0>  // 
        matrix<1,Up_*N / Shear_Len*0.333,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,-RAngle/4,0>
      } // end object 
object{ Track
        rotate<0, RAngle/4,0>  // 
        matrix<1,Up_*N / Shear_Len*0.667,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        rotate< 0,-RAngle/4,0>
        Rotate_Around_Trans(<0, -1*RAngle/2,0><0,0, RLen>)
        translate<0,Up_*N*0.333,0>   
      } // end object 
}// end union
#end // #if (Type = "L")

#if (Type = "G")
#local Shear_Len =  Len*1.01; // track length 30 degrees   
union{
object{ Track
        matrix<1,Up_*N / Shear_Len*0.333,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
      } // end object 
object{ Track
        matrix<1,Up_*N / Shear_Len*0.667,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        translate<Len,Up_*N*0.333,0>   
      } // end object 
}// end union
 
#end // #if (Type = "G")
 
 //-------------------------------
#end // of"#if (Gradient_Type = 1)
// --------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------
#if ( Gradient_Type = 2 ) // end (convex) in two step
#switch ( Name_ )

// 45° -> splitted in 2*22.5° 
#case (1)  #local Type= "R"; #local Track = object{ T_R1_225}; #local RLen = R1; #local RAngle = 45; #break 
#case (2)  #local Type= "R"; #local Track = object{ T_R2_225}; #local RLen = R2; #local RAngle = 45; #break 
#case (3)  #local Type= "R"; #local Track = object{ T_R3_225}; #local RLen = R3; #local RAngle = 45; #break 
#case (4)  #local Type= "R"; #local Track = object{ T_R4_225}; #local RLen = R4; #local RAngle = 45; #break 
#case (5)  #local Type= "R"; #local Track = object{ T_R5_225}; #local RLen = R5; #local RAngle = 45; #break 
#case (6)  #local Type= "R"; #local Track = object{ T_R6_225}; #local RLen = R6; #local RAngle = 45; #break 
#case (7)  #local Type= "R"; #local Track = object{ T_R7_225}; #local RLen = R7; #local RAngle = 45; #break 
#case (8)  #local Type= "R"; #local Track = object{ T_R8_225}; #local RLen = R8; #local RAngle = 45; #break 
#case (9)  #local Type= "R"; #local Track = object{ T_R9_225}; #local RLen = R9; #local RAngle = 45; #break 
#case (10) #local Type= "R"; #local Track = object{T_R10_225}; #local RLen =R10; #local RAngle = 45; #break 

// 30° -> splitted in 2*15° 
#case (11)  #local Type= "R"; #local Track = object{ T_R1_15}; #local RLen = R1; #local RAngle = 30; #break 
#case (12)  #local Type= "R"; #local Track = object{ T_R2_15}; #local RLen = R2; #local RAngle = 30; #break 
#case (13)  #local Type= "R"; #local Track = object{ T_R3_15}; #local RLen = R3; #local RAngle = 30; #break 
#case (14)  #local Type= "R"; #local Track = object{ T_R4_15}; #local RLen = R4; #local RAngle = 30; #break 
#case (15)  #local Type= "R"; #local Track = object{ T_R5_15}; #local RLen = R5; #local RAngle = 30; #break 
#case (16)  #local Type= "R"; #local Track = object{ T_R6_15}; #local RLen = R6; #local RAngle = 30; #break 
#case (17)  #local Type= "R"; #local Track = object{ T_R7_15}; #local RLen = R7; #local RAngle = 30; #break 
#case (18)  #local Type= "R"; #local Track = object{ T_R8_15}; #local RLen = R8; #local RAngle = 30; #break 
#case (19)  #local Type= "R"; #local Track = object{ T_R9_15}; #local RLen = R9; #local RAngle = 30; #break 
#case (20)  #local Type= "R"; #local Track = object{T_R10_15}; #local RLen =R10; #local RAngle = 30; #break 

// 15° -> splitted in 2*7,5° 
#case (31)  #local Type= "R"; #local Track = object{ T_R1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case (32)  #local Type= "R"; #local Track = object{ T_R2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case (33)  #local Type= "R"; #local Track = object{ T_R3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case (34)  #local Type= "R"; #local Track = object{ T_R4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case (35)  #local Type= "R"; #local Track = object{ T_R5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case (36)  #local Type= "R"; #local Track = object{ T_R6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case (37)  #local Type= "R"; #local Track = object{ T_R7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case (38)  #local Type= "R"; #local Track = object{ T_R8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case (39)  #local Type= "R"; #local Track = object{ T_R9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case (40)  #local Type= "R"; #local Track = object{T_R10_075}; #local RLen =R10; #local RAngle = 15; #break 

// left curves
// 45° -> splitted in 2*22.5° 
#case (51) #local Type= "L"; #local Track = object{ T_L1_225}; #local RLen = R1; #local RAngle = 45; #break 
#case (52) #local Type= "L"; #local Track = object{ T_L2_225}; #local RLen = R2; #local RAngle = 45; #break 
#case (53) #local Type= "L"; #local Track = object{ T_L3_225}; #local RLen = R3; #local RAngle = 45; #break 
#case (54) #local Type= "L"; #local Track = object{ T_L4_225}; #local RLen = R4; #local RAngle = 45; #break 
#case (55) #local Type= "L"; #local Track = object{ T_L5_225}; #local RLen = R5; #local RAngle = 45; #break 
#case (56) #local Type= "L"; #local Track = object{ T_L6_225}; #local RLen = R6; #local RAngle = 45; #break 
#case (57) #local Type= "L"; #local Track = object{ T_L7_225}; #local RLen = R7; #local RAngle = 45; #break 
#case (58) #local Type= "L"; #local Track = object{ T_L8_225}; #local RLen = R8; #local RAngle = 45; #break 
#case (59) #local Type= "L"; #local Track = object{ T_L9_225}; #local RLen = R9; #local RAngle = 45; #break 
#case (60) #local Type= "L"; #local Track = object{T_L10_225}; #local RLen =R10; #local RAngle = 45; #break 

// 30° -> splitted in 2*15° 
#case (61) #local Type= "L"; #local Track = object{ T_L1_15}; #local RLen = R1; #local RAngle = 30; #break 
#case (62) #local Type= "L"; #local Track = object{ T_L2_15}; #local RLen = R2; #local RAngle = 30; #break 
#case (63) #local Type= "L"; #local Track = object{ T_L3_15}; #local RLen = R3; #local RAngle = 30; #break 
#case (64) #local Type= "L"; #local Track = object{ T_L4_15}; #local RLen = R4; #local RAngle = 30; #break 
#case (65) #local Type= "L"; #local Track = object{ T_L5_15}; #local RLen = R5; #local RAngle = 30; #break 
#case (66) #local Type= "L"; #local Track = object{ T_L6_15}; #local RLen = R6; #local RAngle = 30; #break 
#case (67) #local Type= "L"; #local Track = object{ T_L7_15}; #local RLen = R7; #local RAngle = 30; #break 
#case (68) #local Type= "L"; #local Track = object{ T_L8_15}; #local RLen = R8; #local RAngle = 30; #break 
#case (69) #local Type= "L"; #local Track = object{ T_L9_15}; #local RLen = R9; #local RAngle = 30; #break 
#case (70) #local Type= "L"; #local Track = object{T_L10_15}; #local RLen =R10; #local RAngle = 30; #break 

// 15° -> splitted in 2*7.5° 
#case (71) #local Type= "L"; #local Track = object{ T_L1_075}; #local RLen = R1; #local RAngle = 15; #break 
#case (72) #local Type= "L"; #local Track = object{ T_L2_075}; #local RLen = R2; #local RAngle = 15; #break 
#case (73) #local Type= "L"; #local Track = object{ T_L3_075}; #local RLen = R3; #local RAngle = 15; #break 
#case (74) #local Type= "L"; #local Track = object{ T_L4_075}; #local RLen = R4; #local RAngle = 15; #break 
#case (75) #local Type= "L"; #local Track = object{ T_L5_075}; #local RLen = R5; #local RAngle = 15; #break 
#case (76) #local Type= "L"; #local Track = object{ T_L6_075}; #local RLen = R6; #local RAngle = 15; #break 
#case (77) #local Type= "L"; #local Track = object{ T_L7_075}; #local RLen = R7; #local RAngle = 15; #break 
#case (78) #local Type= "L"; #local Track = object{ T_L8_075}; #local RLen = R8; #local RAngle = 15; #break 
#case (79) #local Type= "L"; #local Track = object{ T_L9_075}; #local RLen = R9; #local RAngle = 15; #break 
#case (80) #local Type= "L"; #local Track = object{T_L10_075}; #local RLen =R10; #local RAngle = 15; #break 

// straight tracks 
#case (92) #local Type= "G"; #local Track = object{ T_111  }; #local Len = L222/2;  #break 
#case (93) #local Type= "G"; #local Track = object{ T_057  }; #local Len = L115/2;  #break 
#case (94) #local Type= "G"; #local Track = object{ T_055  }; #local Len = L111/2;  #break 

#end // of switch -----------------------------------------------------
//---------------------------------------------- 
#if (Type = "R")
#local Shear_Len =  RLen*( sin( 2*pi/(360/(RAngle)) ) )*0.95; //  track length  15 degrees
union{
 object{ Track
        rotate<0,-RAngle/4,0>  //     
        matrix<1,Up_*N / Shear_Len *1.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0, RAngle/4,0>
      } // end object 
 object{ Track
        rotate<0,-RAngle/4,0>  //     
        matrix<1, Up_*N / Shear_Len *0.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0, RAngle/4,0>
        Rotate_Around_Trans(<0,1*RAngle/2,0><0,0,-RLen>)
        translate<0,Up_*N*0.75,0>   
      } // end object 
}// end union
#end // #if (Type = "R")

#if (Type = "L")
#local Shear_Len =  RLen*(  sin( 2*pi/(360/(RAngle)) ) )*0.95; //  track length  15 degrees
union{
 object{ Track
        rotate<0, RAngle/4,0>  // 
        matrix<1, Up_*N / Shear_Len *1.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0,-RAngle/4,0>
      } // end object 
 object{ Track
        rotate<0, RAngle/4,0>  // 
        matrix<1, Up_*N / Shear_Len *0.5,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y 
        rotate<0,-RAngle/4,0>
        Rotate_Around_Trans(<0,-1*RAngle/2,0><0,0, RLen>)
        translate<0,Up_*N*0.75,0>   
      } // end object 

}// end union

#end // #if (Type = "L")

#if (Type = "G")
#local Shear_Len =  Len*1.01; // track length 30 degrees   
union{
object{ Track
        matrix<1,Up_*N / Shear_Len*0.667,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
      } // end object 
object{ Track
        matrix<1,Up_*N / Shear_Len*0.333,0, 0,1,0, 0,0,1, 0,0,0>  // matrix-shear_x_to_y  
        translate<Len,Up_*N*0.667,0>   
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
#include "RR_System/N_FS/RT_N_TypeA111_Track_Up_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ T_RT_N_TypeA111_Track_Up_00( "R1", //  Name_,    // Track_Name "R1","R2","R3","R4", ... ,"R9","L1",..."L9","G239" 
                        0.175, // Up_, // value for N scale (in meter) // i.e. 0.0160,                                
                        0, // Gradient_Type, // 0 = continous, 1 = start(concav), 2 = end(convex)
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_N_TypeA111_Track_Up_00_Inc_Temp;
#end
//------------------------------------- end of include file

