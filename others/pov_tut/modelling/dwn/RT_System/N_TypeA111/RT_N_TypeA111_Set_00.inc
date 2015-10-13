// POV-Ray 3.7 include file "RT_N_TypeA111_Set_00.inc"  // Spur N Gleis
// author: Friedrich A, Lohmueller, Oct-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_N_TypeA111_Set_00_Inc_Temp)
#declare RT_N_TypeA111_Set_00_Inc_Temp = version;
#version 3.7;
// 
// A collection of rail track elements 
// with the raster dimensions
// ( ~ Fleischmann "Gleis mit Schotter") 
// 
// All elements scaled up by 160 ("*N") to real woRLd scale (1 = 1m)
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/*
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
*/
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"
#end
//------------------------------------------------------------------------ ////////////////////////
#ifndef( Simulate_On )
#declare Simulate_On = 0; // 0=realistic, 1=two lines, 2=boxes
#end
//------------------------------------------------------------------------------ /////////
// track simulation:  Simulate_On___ 
//  -1, // real with flat base
//   0, // real with ties/sleepers
//   1, // double rails - no ties
//   2, // blocks
//   3, // blocks with end markers
//------------------------------------------------------------------------------ /////////  

/*
// N scale track set: ( ~ Fleischmann  'piccolo'  but much much better!!!)
// constants:
N = 160 -> 3cm on N layout -> 0.03*N;  
//-------------------------------------  
#declare T_Dist = 0.029226854*N; // in meter distance of parallel tracks
#declare Track_Dist = T_Dist;  
#declare Track_Distance = Track_Dist; 
// Track_Dist or Track_Distance   (Fleischmann Schotter:=0.0336*N)
// curve radii                   // N scale model size:
#declare R1 = RS - 8*Track_Dist; // ~ 0.195 m 
#declare R2 = RS - 7*Track_Dist; // ~ 0.224 m 
#declare R3 = RS - 6*Track_Dist; // ~ 0.254 m 
#declare R4 = RS - 5*Track_Dist; // ~ 0.283 m
#declare R5 = RS - 4*Track_Dist; // ~ 0.312 m
#declare R6 = RS - 3*Track_Dist; // ~ 0.341 m
#declare R7 = RS - 2*Track_Dist; // ~ 0.370 m
#declare R8 = RS - 1*Track_Dist; // ~ 0.400 m
#declare R9 = RS - 0*Track_Dist; // ~ 0.429 m 
#declare Switch_Length = 0.111*N = L111 ; //  N scale model size: 111 mm
#declare Switch_Angle  = 15;     // 
#declare Switch_Radius =  0.4288710660*N = R9 ; //
 
// length of straight tracks 
#declare L777 = 0.777*N ;  // 'flexible' // here only straight!     
#declare L222 = 0.222*N;   // ~ 0.222 m  double length
#declare L111 = 0.111*N;   // ~ 0.111 m  length of switch / turnout  = base length 
#declare L115 = LDiag15;     // ~ 0.115 m  length of a 15° diagonal   
#declare L107 = 0.10735*N; // ~ 0.107 m, || to 30° crossing / level junction
#declare L057 = LDiag15/2 ;  // ~ 0.574 m  half diagonal length
#declare L055 = L111/2 ;   // ~ 0.550 m  1/2 base length 
#declare L028 = L111/4 ;// ~ 0.028 m  1/4 base length  
//------------------------------------------------------------------------
// track objects: 
object{ Track_Straight_0 ( Lenght ) rotate<0,0,0> translate<0*Lenght ,0,0> } 
object{ Track_Curve_0    ( Curve_Radius, Curve_Angle ) Rotate_Around_Trans(<0,0*Curve_Angle_,0>,<0,0,-Curve_Radius>) rotate<0,0,0> translate<0,0,0> } 
//--------------------------------------------------
object{ T_222 rotate<0,0,0> translate<0*L222 ,0,0> } 
object{ T_115 rotate<0,0,0> translate<0*L111 ,0,0> }
object{ T_111 rotate<0,0,0> translate<0*L111 ,0,0> }
object{ T_107 rotate<0,0,0> translate<0*L107 ,0,0> }
object{ T_057 rotate<0,0,0> translate<0*L057 ,0,0> } 
object{ T_055 rotate<0,0,0> translate<0*L055 ,0,0> } 
object{ T_028 rotate<0,0,0> translate<0*L028 ,0,0> } 
object{ T_777 rotate<0,0,0> translate<0*L777 ,0,0> } 

object{ T_R1_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R2_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R2>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R3_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R3>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R4_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R4>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R5_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R5>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R6_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R6>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R7_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R7>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R8_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R8>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R9_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R9>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R10_45 Rotate_Around_Trans(<0,0*45,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> }  

object{ T_R1_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R2_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R2>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R3_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R3>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R4_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R4>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R5_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R5>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R6_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R6>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R7_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R7>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R8_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R8>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R9_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R9>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R10_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> } 

object{ T_R1_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R2_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R2>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R3_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R3>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R4_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R4>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R5_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R5>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R6_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R6>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R7_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R7>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R8_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R8>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R9_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R9>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R10_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> } 

object{ T_R1_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R2_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R2>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R3_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R3>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R4_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R4>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R5_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R5>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R6_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R6>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R7_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R7>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R8_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R8>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R9_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R9>) rotate<0,0,0> translate<0,0,0> } 
object{ T_R10_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> } 

// analog: object{ L1_45 ... for left curve - just for easier placing the curve elements !!!

// turnouts - switches
object{ SW_R(Switch_Direction) rotate<0,0,0> translate<0*L110,0,0>} // angle: 15 degrees
object{ SW_L(Switch_Direction) rotate<0,0,0> translate<0*L110,0,0>} 
object{ SW3(Switch_Direction) rotate<0,0,0> translate<0*L110,0,0>} 
object{ SWY(Switch_Direction) rotate<0,0,0> translate<0*L110,0,0>} 
// level junctions - diamond crossings 
object{ X15_RL    rotate<0,0,0> translate<0*L110,0,0>}  
object{ X15_LR    rotate<0,0,0> translate<0*L110,0,0>}  
object{ XX_RL    rotate<0,0,0> translate<0*L110,0,0>} 
object{ XX_LR    rotate<0,0,0> translate<0*L110,0,0>} 
// curved switches: (still something ToDo!)
object{ CSW12_R  rotate<0,0,0> translate<0,0,0>} // not correctly ! ToDo!
object{ CSW12_L  rotate<0,0,0> translate<0,0,0>} 
*/ 

//---------------------------------------------------
#declare N = 160; 
#local D = 0.00001;
//--------------------------------------------------- /// rail tracks dimensions
#declare T_Dist = 0.029226854*N; // in meter distance of parallel tracks
#declare Track_Dist = T_Dist;  
#declare Track_Distance = Track_Dist; 

                   
#declare Switch_Length = 0.111*N ; //  N scale model size: 111 mm
#declare Switch_Angle  = 15;     // 
#declare Switch_Radius =  0.4288710660*N ; //
#declare L0 = Switch_Length; 
#declare RS = Switch_Radius; 
                                 // N scale model size:
#declare R1 = RS - 8*Track_Dist; // ~ 0.195 m 
#declare R2 = RS - 7*Track_Dist; // ~ 0.224 m 
#declare R3 = RS - 6*Track_Dist; // ~ 0.254 m 
#declare R4 = RS - 5*Track_Dist; // ~ 0.283 m
#declare R5 = RS - 4*Track_Dist; // ~ 0.312 m
#declare R6 = RS - 3*Track_Dist; // ~ 0.341 m
#declare R7 = RS - 2*Track_Dist; // ~ 0.370 m
#declare R8 = RS - 1*Track_Dist; // ~ 0.400 m
#declare R9 = RS - 0*Track_Dist; // ~ 0.429 m ~ switch radius
#declare R10= RS + 1*Track_Dist; // ~ 0.468 m 
// length of the straight tracks:  
// diagonal of 15°; 
#declare LDiag15 = sqrt( pow(L0,2)+pow(T_Dist,2));  
// || to 30° crossing / level junction of 0.111 length:
#declare LParallel30 = sqrt(  pow(L0,2)-pow(T_Dist,2)); 
//...................
#declare L777 = 0.777*N ;  // 'flexible' // here only straight!     
#declare L222 = 0.222*N;   // ~ 0.222 m  double length
#declare L111 = 0.111*N;   // ~ 0.111 m  length of switch / turnout  = base length 
#declare L115 = LDiag15;     // ~ 0.115 m  length of a 15° diagonal   
#declare L107 = 0.10735*N; // ~ 0.107 m, || to 30° crossing / level junction
#declare L057 = LDiag15/2 ;  // ~ 0.574 m  half diagonal length
#declare L055 = L111/2 ;   // ~ 0.550 m  1/2 base length 
#declare L028 = L111/4 ;// ~ 0.028 m  1/4 base length  
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// minimum frame for N scale 
#declare N_Frame = box{<-0.0334/2,0,0>,<0.0334/2, 0.055,0.001> scale N 
                        pigment{ rgb<1,0.5,0>*1 } }    
#declare N_Frame_X = box{<-0.0334/2,0,0>,<0.0334/2, 0.055,0.001> scale N 
                        pigment{ rgb<0.8,0.0,0>*1 } }    
//------------------------------------------------------------------------ 
//------------------------------------------------------------------------ 
#ifndef( Ties_Per_Meter )
#declare Ties_Per_Meter= 1.40-0.00;  // ties/sleepers per meter
#end
#ifndef( TTex ) // text texture  
#declare TTex = 
  texture{ pigment{ color rgb< 1, 1, 1>*0.00 } //  color Black
           finish { phong 1 }
         } // end of texture 
#end 
#ifndef( TTF )
#declare TTF = "arialbd.ttf"
#end 
//------------------------------------------------------------------------ //////////////////////// 
#include "RT_System/RT_System_00.inc" 
//---------------------------------------------------
#ifndef (Rails_Height)
#declare Rails_Height = Height_Rail_Top; 
#end 
// ------------------------------ optional base beneath the rail tracks
//------------------------------------------------------------------------------------------  
// tracks from "Rails_System_000.inc" :
//------------------------------------------------------------------------------------------  
// Variable linear track
#macro Track_Straight_0 (Track_Length_ )  
object{ RT_Track_Straight_0 ( Simulate_On, 
                              Track_Length_, 
                              Ties_Per_Meter,
                            ) } //------------------------------------------------------------ 
#end // end of macro -----------------------------------------------------------------------
// Variable linear track
#macro T_Straight (Track_Length_ )  
object{ RT_Track_Straight_0 ( Simulate_On, 
                              Track_Length_, 
                              Ties_Per_Meter,
                            ) } //------------------------------------------------------------ 
#end // end of macro -----------------------------------------------------------------------
// Variable round track
#macro Track_Curve_0 ( Rail_Radius_, Curve_Angle_ ) 
object{  RT_Track_Curve_0(  Simulate_On, 
                            Rail_Radius_, // in meter  
                            Curve_Angle_ , // in degrees lefthanded  
                            Ties_Per_Meter, // Ties_Per_Meter_  // ~1.5
                          ) }   //------------------------------
#end // end of macro -----------------------------------------------------------------------
#macro T_Curve ( Rail_Radius_, Curve_Angle_ ) 
object{  RT_Track_Curve_0(  Simulate_On, 
                            Rail_Radius_, // in meter  
                            Curve_Angle_ , // in degrees lefthanded  
                            Ties_Per_Meter, // Ties_Per_Meter_  // ~1.5
                          ) }   //------------------------------
#end // end of macro -----------------------------------------------------------------------
// ----------------------------------------------------------------------- curve for XX 
#macro Track_Curve_0S ( Rail_Radius_, Curve_Angle_ , Ties_Per_Meter_) 
object{  RT_Track_Curve_0(  Simulate_On, 
                            Rail_Radius_, // in meter  
                            Curve_Angle_ , // in degrees lefthanded  
                            Ties_Per_Meter_, // Ties_Per_Meter_  // ~1.5
                          ) }   //------------------------------
#end // end of macro -----------------------------------------------------------------------
// ----------------------------------------------------------------------- curve for XX 
#macro T_CurveS ( Rail_Radius_, Curve_Angle_ , Ties_Per_Meter_) 
object{  RT_Track_Curve_0(  Simulate_On, 
                            Rail_Radius_, // in meter  
                            Curve_Angle_ , // in degrees lefthanded  
                            Ties_Per_Meter_, // Ties_Per_Meter_  // ~1.5
                          ) }   //------------------------------
#end // end of macro -----------------------------------------------------------------------
// ----------------------------------------------------------------------- Standard Switches  
// ----------------------------------------------------------------------- Standard Switches  
#macro Switch_0 (Switch_Direction_ ) // 
object{ RT_Track_Switch_A_0( Simulate_On, 
                             Switch_Direction_, // straight ~ 1 round (Save 0< x <1)
                             Switch_Length,  // meter
                             Switch_Angle, // Switch_Angle,   // degrees 
                             Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                           ) } //---------------
#end // end of macro ---------------------------------------------------------------------  
// ----------------------------------------------------------------------------- /////////
// ----------------------------------------------------------------------------- /////////
 

// ----------------------------------------------------------------------------- /////////  
#declare T_Trans = transform{ scale<1,1.25,1>*1.25 
                              rotate<90,0,0> 
                              translate<0, Rails_Height+0.001 ,-0.55>}  
// ----------------------------------------------------------------------------- /////////  

// linear tracks
#declare G_Flex  = object{ T_Straight (L777) } 
#if (Simulate_On <=0 ) 
#declare T_222 = object{ T_Straight (L222) } 
#declare T_115 = object{ T_Straight (L115) } 
#declare T_111 = object{ T_Straight (L111) } 
#declare T_107 = object{ T_Straight (L107) } 
#declare T_057 = object{ T_Straight (L057) } 
#declare T_055 = object{ T_Straight (L055) } 
#declare T_028 = object{ T_Straight (L028) } 
#declare T_777 = object{ T_Straight (L777) } 

#end // #if (Simulate_On =0 ) 
//--------------
//--------------
#if ( Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
#declare T_222 = 
union{ object{ T_Straight (L222) } 
       text{ ttf TTF, "222", 0.02, 0.0 texture{TTex} transform T_Trans translate<L222/2,0,0>}} 
#declare T_115 = 
union{  object{ T_Straight (L115) } 
       text{ ttf TTF, "115", 0.02, 0.0 texture{TTex} transform T_Trans translate<L115/2,0,0>}} 
#declare T_111 = 
union{  object{ T_Straight (L111) } 
       text{ ttf TTF, "111", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2,0,0>}} 
#declare T_107 = 
union{  object{ T_Straight (L107) } 
       text{ ttf TTF, "107", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/2,0,0>}} 
#declare T_057 = 
union{  object{ T_Straight (L057) } 
       text{ ttf TTF, "057", 0.02, 0.0 texture{TTex} transform T_Trans translate<L057/2,0,0>}} 
#declare T_055 = 
union{  object{ T_Straight (L055) } 
        text{ ttf TTF,"055", 0.02, 0.0 texture{TTex} transform T_Trans translate<L055/2,0,0>}} 
#declare T_028 = 
union{  object{ T_Straight (L028) } 
       text{ ttf TTF, "028", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_777 = 
union{  object{ T_Straight (L777) } 
       text{ ttf TTF, "777", 0.02, 0.0 texture{TTex} transform T_Trans translate<L777/2,0,0>}} 

#end // of "#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) "
// -------------------------------------------------------------------------------------- 
// -------------------------------------------------------------------------------------- 
//--------------
// curve tracks
#if (Simulate_On <= 0 ) //--------------------------- 

#declare T_R1_45 = object{ T_Curve ( R1, 45 )  }  
#declare T_R2_45 = object{ T_Curve ( R2, 45 )  }  
#declare T_R3_45 = object{ T_Curve ( R3, 45 )  }  
#declare T_R4_45 = object{ T_Curve ( R4, 45 )  }  
#declare T_R5_45 = object{ T_Curve ( R5, 45 )  }  
#declare T_R6_45 = object{ T_Curve ( R6, 45 )  }  
#declare T_R7_45 = object{ T_Curve ( R7, 45 )  }  
#declare T_R8_45 = object{ T_Curve ( R8, 45 )  }  
#declare T_R9_45 = object{ T_Curve ( R9, 45 )  }  
#declare T_R10_45= object{ T_Curve (R10, 45 )  }  

#declare T_R1_225 = object{ T_Curve ( R1, 45/2 ) } //  for "Track_Up()" macro only 
#declare T_R2_225 = object{ T_Curve ( R2, 45/2 ) }  
#declare T_R3_225 = object{ T_Curve ( R3, 45/2 ) }  
#declare T_R4_225 = object{ T_Curve ( R4, 45/2 ) }  
#declare T_R5_225 = object{ T_Curve ( R5, 45/2 ) }  
#declare T_R6_225 = object{ T_Curve ( R6, 45/2 ) }  
#declare T_R7_225 = object{ T_Curve ( R7, 45/2 ) }  
#declare T_R8_225 = object{ T_Curve ( R8, 45/2 ) }  
#declare T_R9_225 = object{ T_Curve ( R9, 45/2 ) }  
#declare T_R10_225= object{ T_Curve (R10, 45/2 ) }  

#declare T_R1_30 = object{ T_Curve ( R1, 30 )  }  
#declare T_R2_30 = object{ T_Curve ( R2, 30 )  }   
#declare T_R3_30 = object{ T_Curve ( R3, 30 )  }   
#declare T_R4_30 = object{ T_Curve ( R4, 30 )  }  
#declare T_R5_30 = object{ T_Curve ( R5, 30 )  }  
#declare T_R6_30 = object{ T_Curve ( R6, 30 )  }   
#declare T_R7_30 = object{ T_Curve ( R7, 30 )  }   
#declare T_R8_30 = object{ T_Curve ( R8, 30 )  }  
#declare T_R9_30 = object{ T_Curve ( R9, 30 )  }  
#declare T_R10_30= object{ T_Curve (R10, 30 )  }   

#declare T_R1_15 = object{ T_Curve ( R1, 15 )  }  
#declare T_R2_15 = object{ T_Curve ( R2, 15 )  }   
#declare T_R3_15 = object{ T_Curve ( R3, 15 )  }   
#declare T_R4_15 = object{ T_Curve ( R4, 15 )  }  
#declare T_R5_15 = object{ T_Curve ( R5, 15 )  }  
#declare T_R6_15 = object{ T_Curve ( R6, 15 )  }   
#declare T_R7_15 = object{ T_Curve ( R7, 15 )  }   
#declare T_R8_15 = object{ T_Curve ( R8, 15 )  }  
#declare T_R9_15 = object{ T_Curve ( R9, 15 )  }  
#declare T_R10_15= object{ T_Curve (R10, 15 )  }   

#declare T_R1_075 = object{ T_Curve ( R1, 7.5 )  }  
#declare T_R2_075 = object{ T_Curve ( R2, 7.5 )  }
#declare T_R3_075 = object{ T_Curve ( R3, 7.5 )  }
#declare T_R4_075 = object{ T_Curve ( R4, 7.5 )  }
#declare T_R5_075 = object{ T_Curve ( R5, 7.5 )  }  
#declare T_R6_075 = object{ T_Curve ( R6, 7.5 )  }
#declare T_R7_075 = object{ T_Curve ( R7, 7.5 )  }
#declare T_R8_075 = object{ T_Curve ( R8, 7.5 )  }
#declare T_R9_075 = object{ T_Curve ( R9, 7.5 )  }
#declare T_R10_075= object{ T_Curve (R10, 7.5 )  }

//--------------------------------------------------------
#declare T_L1_45 = object{ T_Curve ( R1, 45 ) scale<1,1,-1> }  
#declare T_L2_45 = object{ T_Curve ( R2, 45 ) scale<1,1,-1> }  
#declare T_L3_45 = object{ T_Curve ( R3, 45 ) scale<1,1,-1> }  
#declare T_L4_45 = object{ T_Curve ( R4, 45 ) scale<1,1,-1> }  
#declare T_L5_45 = object{ T_Curve ( R5, 45 ) scale<1,1,-1> }  
#declare T_L6_45 = object{ T_Curve ( R6, 45 ) scale<1,1,-1> }  
#declare T_L7_45 = object{ T_Curve ( R7, 45 ) scale<1,1,-1> }  
#declare T_L8_45 = object{ T_Curve ( R8, 45 ) scale<1,1,-1> }  
#declare T_L9_45 = object{ T_Curve ( R9, 45 ) scale<1,1,-1> }  
#declare T_L10_45= object{ T_Curve (R10, 45 ) scale<1,1,-1> }  

#declare T_L1_225 = object{ T_Curve ( R1, 45/2 ) scale<1,1,-1> } // for "Track_Up()" macro only  
#declare T_L2_225 = object{ T_Curve ( R2, 45/2 ) scale<1,1,-1> }  
#declare T_L3_225 = object{ T_Curve ( R3, 45/2 ) scale<1,1,-1> }  
#declare T_L4_225 = object{ T_Curve ( R4, 45/2 ) scale<1,1,-1> }  
#declare T_L5_225 = object{ T_Curve ( R5, 45/2 ) scale<1,1,-1> }  
#declare T_L6_225 = object{ T_Curve ( R6, 45/2 ) scale<1,1,-1> }  
#declare T_L7_225 = object{ T_Curve ( R7, 45/2 ) scale<1,1,-1> }  
#declare T_L8_225 = object{ T_Curve ( R8, 45/2 ) scale<1,1,-1> }  
#declare T_L9_225 = object{ T_Curve ( R9, 45/2 ) scale<1,1,-1> }  
#declare T_L10_225= object{ T_Curve (R10, 45/2 ) scale<1,1,-1> }  

#declare T_L1_30 = object{ T_Curve ( R1, 30 ) scale<1,1,-1> }  
#declare T_L2_30 = object{ T_Curve ( R2, 30 ) scale<1,1,-1> }   
#declare T_L3_30 = object{ T_Curve ( R3, 30 ) scale<1,1,-1> }   
#declare T_L4_30 = object{ T_Curve ( R4, 30 ) scale<1,1,-1> }  
#declare T_L5_30 = object{ T_Curve ( R5, 30 ) scale<1,1,-1> }  
#declare T_L6_30 = object{ T_Curve ( R6, 30 ) scale<1,1,-1> }   
#declare T_L7_30 = object{ T_Curve ( R7, 30 ) scale<1,1,-1> }   
#declare T_L8_30 = object{ T_Curve ( R8, 30 ) scale<1,1,-1> }  
#declare T_L9_30 = object{ T_Curve ( R9, 30 ) scale<1,1,-1> }   
#declare T_L10_30= object{ T_Curve (R10, 30 ) scale<1,1,-1> }  

#declare T_L1_15 = object{ T_Curve ( R1, 15 ) scale<1,1,-1> }  
#declare T_L2_15 = object{ T_Curve ( R2, 15 ) scale<1,1,-1> }   
#declare T_L3_15 = object{ T_Curve ( R3, 15 ) scale<1,1,-1> }   
#declare T_L4_15 = object{ T_Curve ( R4, 15 ) scale<1,1,-1> }  
#declare T_L5_15 = object{ T_Curve ( R5, 15 ) scale<1,1,-1> }  
#declare T_L6_15 = object{ T_Curve ( R6, 15 ) scale<1,1,-1> }   
#declare T_L7_15 = object{ T_Curve ( R7, 15 ) scale<1,1,-1> }   
#declare T_L8_15 = object{ T_Curve ( R8, 15 ) scale<1,1,-1> }  
#declare T_L9_15 = object{ T_Curve ( R9, 15 ) scale<1,1,-1> }   
#declare T_L10_15= object{ T_Curve (R10, 15 ) scale<1,1,-1> }  

#declare T_L1_075 = object{ T_Curve ( R1, 7.5) scale<1,1,-1> }  
#declare T_L2_075 = object{ T_Curve ( R2, 7.5) scale<1,1,-1> }
#declare T_L3_075 = object{ T_Curve ( R3, 7.5) scale<1,1,-1> }
#declare T_L4_075 = object{ T_Curve ( R4, 7.5) scale<1,1,-1> }
#declare T_L5_075 = object{ T_Curve ( R5, 7.5) scale<1,1,-1> }  
#declare T_L6_075 = object{ T_Curve ( R6, 7.5) scale<1,1,-1> }
#declare T_L7_075 = object{ T_Curve ( R7, 7.5) scale<1,1,-1> }  
#declare T_L8_075 = object{ T_Curve ( R8, 7.5) scale<1,1,-1> }
#declare T_L9_075 = object{ T_Curve ( R9, 7.5) scale<1,1,-1> }
#declare T_L10_075= object{ T_Curve (R10, 7.5) scale<1,1,-1> }

#end //-------------------------------------------- end  of "#if (Simulate_On =0 ) "


#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
#declare T_R1_45  = union{ object{ T_Curve ( R1, 45)  }  
                           text{ ttf TTF, "R1 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R2_45  = union{ object{ T_Curve ( R2, 45)  }  
                           text{ ttf TTF, "R2 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R3_45  = union{ object{ T_Curve ( R3, 45)  }  
                           text{ ttf TTF, "R3 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R4_45  = union{ object{ T_Curve ( R4, 45)  }  
                           text{ ttf TTF, "R4 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R5_45  = union{ object{ T_Curve ( R5, 45)  }  
                           text{ ttf TTF, "R5 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R6_45  = union{ object{ T_Curve ( R6, 45)  }  
                           text{ ttf TTF, "R6 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R7_45  = union{ object{ T_Curve ( R7, 45)  }  
                           text{ ttf TTF, "R7 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R8_45  = union{ object{ T_Curve ( R8, 45)  }  
                           text{ ttf TTF, "R8 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R9_45  = union{ object{ T_Curve ( R9, 45)  }  
                           text{ ttf TTF, "R9 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R10_45 = union{ object{ T_Curve (R10, 45)  }  
                           text{ ttf TTF, "R10 45°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_R1_225 = union{ object{ T_Curve ( R1, 45/2)  }  
                           text{ ttf TTF, "R1 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} //  for "Track_Up()" macro only  
#declare T_R2_225 = union{ object{ T_Curve ( R2, 45/2)  }  
                           text{ ttf TTF, "R2 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R3_225 = union{ object{ T_Curve ( R3, 45/2)  }  
                           text{ ttf TTF, "R3 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R4_225 = union{ object{ T_Curve ( R4, 45/2)  }  
                           text{ ttf TTF, "R4 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R5_225 = union{ object{ T_Curve ( R5, 45/2)  }  
                           text{ ttf TTF, "R5 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}}  
#declare T_R6_225 = union{ object{ T_Curve ( R6, 45/2)  }  
                           text{ ttf TTF, "R6 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R7_225 = union{ object{ T_Curve ( R7, 45/2)  }  
                           text{ ttf TTF, "R7 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R8_225 = union{ object{ T_Curve ( R8, 45/2)  }  
                           text{ ttf TTF, "R8 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R9_225 = union{ object{ T_Curve ( R9, 45/2)  }  
                           text{ ttf TTF, "R9 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}}  
#declare T_R10_225= union{ object{ T_Curve (R10, 45/2)  }  
                           text{ ttf TTF, "R10 225°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_R1_30  = union{ object{ T_Curve ( R1, 30)  }  
                           text{ ttf TTF, "R1 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R2_30  = union{ object{ T_Curve ( R2, 30)  }  
                           text{ ttf TTF, "R2 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R3_30  = union{ object{ T_Curve ( R3, 30)  }  
                           text{ ttf TTF, "R3 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R4_30  = union{ object{ T_Curve ( R4, 30)  }  
                           text{ ttf TTF, "R4 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R5_30  = union{ object{ T_Curve ( R5, 30)  }  
                           text{ ttf TTF, "R5 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R6_30  = union{ object{ T_Curve ( R6, 30)  }  
                           text{ ttf TTF, "R6 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R7_30  = union{ object{ T_Curve ( R7, 30)  }  
                           text{ ttf TTF, "R7 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R8_30  = union{ object{ T_Curve ( R8, 30)  }  
                           text{ ttf TTF, "R8 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R9_30  = union{ object{ T_Curve ( R9, 30)  }  
                           text{ ttf TTF, "R9 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R10_30 = union{ object{ T_Curve (R10, 30)  }  
                           text{ ttf TTF, "R10 30°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 


#declare T_R1_15  = union{ object{ T_Curve ( R1, 15)  }  
                           text{ ttf TTF, "R1 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R2_15  = union{ object{ T_Curve ( R2, 15)  }  
                           text{ ttf TTF, "R2 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R3_15  = union{ object{ T_Curve ( R3, 15)  }  
                           text{ ttf TTF, "R3 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R4_15  = union{ object{ T_Curve ( R4, 15)  }  
                           text{ ttf TTF, "R4 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R5_15  = union{ object{ T_Curve ( R5, 15)  }  
                           text{ ttf TTF, "R5 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R6_15  = union{ object{ T_Curve ( R6, 15)  }  
                           text{ ttf TTF, "R6 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R7_15  = union{ object{ T_Curve ( R7, 15)  }  
                           text{ ttf TTF, "R7 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R8_15  = union{ object{ T_Curve ( R8, 15)  }  
                           text{ ttf TTF, "R8 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R9_15  = union{ object{ T_Curve ( R9, 15)  }  
                           text{ ttf TTF, "R9 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_R10_15 = union{ object{ T_Curve (R10, 15)  }  
                           text{ ttf TTF, "R10 15°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_R1_075 = union{ object{ T_Curve ( R1, 7.5)  }  
                           text{ ttf TTF, "R1 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.001*N,0,0>}} 
#declare T_R2_075 = union{ object{ T_Curve ( R2, 7.5)  }  
                           text{ ttf TTF, "R2 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*N,0,0>}} 
#declare T_R3_075 = union{ object{ T_Curve ( R3, 7.5)  }  
                           text{ ttf TTF, "R3 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*N,0,0>}} 
#declare T_R4_075 = union{ object{ T_Curve ( R4, 7.5)  }  
                           text{ ttf TTF, "R4 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.004*N,0,0>}} 
#declare T_R5_075 = union{ object{ T_Curve ( R5, 7.5)  }  
                           text{ ttf TTF, "R5 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.001*N,0,0>}} 
#declare T_R6_075 = union{ object{ T_Curve ( R6, 7.5)  }  
                           text{ ttf TTF, "R6 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*N,0,0>}} 
#declare T_R7_075 = union{ object{ T_Curve ( R7, 7.5)  }  
                           text{ ttf TTF, "R7 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*N,0,0>}} 
#declare T_R8_075 = union{ object{ T_Curve ( R8, 7.5)  }  
                           text{ ttf TTF, "R8 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.004*N,0,0>}} 
#declare T_R9_075 = union{ object{ T_Curve ( R9, 7.5)  }  
                           text{ ttf TTF, "R9 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.001*N,0,0>}} 
#declare T_R10_075 = union{ object{ T_Curve (R10, 7.5)  }  
                           text{ ttf TTF, "R10 7.5°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*N,0,0>}} 


#declare T_L1_45  = union{ object{ T_Curve ( R1, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R1 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L2_45  = union{ object{ T_Curve ( R2, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R2 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L3_45  = union{ object{ T_Curve ( R3, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R3 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L4_45  = union{ object{ T_Curve ( R4, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R4 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L5_45  = union{ object{ T_Curve ( R5, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R5 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L6_45  = union{ object{ T_Curve ( R6, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R6 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L7_45  = union{ object{ T_Curve ( R7, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R7 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L8_45  = union{ object{ T_Curve ( R8, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R8 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L9_45  = union{ object{ T_Curve ( R9, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R9 45°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L10_45  = union{ object{ T_Curve (R10, 45) scale<1,1,-1>}  
                           text{ ttf TTF, "R10 45°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_L1_225 = union{ object{ T_Curve ( R1, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R1 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} // for "Track_Up()" macro only  
#declare T_L2_225 = union{ object{ T_Curve ( R2, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R2 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L3_225 = union{ object{ T_Curve ( R3, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R3 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L4_225 = union{ object{ T_Curve ( R4, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R4 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L5_225 = union{ object{ T_Curve ( R5, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R5 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L6_225 = union{ object{ T_Curve ( R6, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R6 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L7_225 = union{ object{ T_Curve ( R7, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R7 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L8_225 = union{ object{ T_Curve ( R8, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R8 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L9_225 = union{ object{ T_Curve ( R9, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R9 225°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L10_225= union{ object{ T_Curve (R10, 45/2) scale<1,1,-1>}  
                           text{ ttf TTF, "R10 225°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_L1_30  = union{ object{ T_Curve ( R1, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R1 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L2_30  = union{ object{ T_Curve ( R2, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R2 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L3_30  = union{ object{ T_Curve ( R3, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R3 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L4_30  = union{ object{ T_Curve ( R4, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R4 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L5_30  = union{ object{ T_Curve ( R5, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R5 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L6_30  = union{ object{ T_Curve ( R6, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R6 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L7_30  = union{ object{ T_Curve ( R7, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R7 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L8_30  = union{ object{ T_Curve ( R8, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R8 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L9_30  = union{ object{ T_Curve ( R9, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R9 30°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L10_30  = union{ object{ T_Curve (R10, 30) scale<1,1,-1>}  
                           text{ ttf TTF, "R10 30°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_L1_15  = union{ object{ T_Curve ( R1, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R1 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L2_15  = union{ object{ T_Curve ( R2, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R2 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L3_15  = union{ object{ T_Curve ( R3, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R3 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L4_15  = union{ object{ T_Curve ( R4, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R4 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L5_15  = union{ object{ T_Curve ( R5, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R5 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L6_15  = union{ object{ T_Curve ( R6, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R6 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L7_15  = union{ object{ T_Curve ( R7, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R7 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L8_15  = union{ object{ T_Curve ( R8, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R8 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L9_15  = union{ object{ T_Curve ( R9, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R9 15°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 
#declare T_L10_15  = union{ object{ T_Curve (R10, 15) scale<1,1,-1>}  
                           text{ ttf TTF, "R10 15°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*N,0,0>}} 

#declare T_L1_075 = union{ object{ T_Curve ( R1, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R1 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.001*N,0,0>}} 
#declare T_L2_075 = union{ object{ T_Curve ( R2, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R2 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*N,0,0>}} 
#declare T_L3_075 = union{ object{ T_Curve ( R3, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R3 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*N,0,0>}} 
#declare T_L4_075 = union{ object{ T_Curve ( R4, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R4 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.004*N,0,0>}} 
#declare T_L5_075 = union{ object{ T_Curve ( R5, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R5 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.001*N,0,0>}} 
#declare T_L6_075 = union{ object{ T_Curve ( R6, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R6 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*N,0,0>}} 
#declare T_L7_075 = union{ object{ T_Curve ( R7, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R7 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*N,0,0>}} 
#declare T_L8_075 = union{ object{ T_Curve ( R8, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R8 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.004*N,0,0>}} 
#declare T_L9_075 = union{ object{ T_Curve ( R9, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R9 7.5°", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.001*N,0,0>}} 
#declare T_L10_075= union{ object{ T_Curve (R10, 7.5) scale<1,1,-1>}  
                           text{ ttf TTF, "R10 7.5°",0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*N,0,0>}} 
// to -x //------------------------------------------------------------------------------
#end // of "#if (Simulate_On = 1 | Simulate_On = 2| Simulate_On = 3)" 
// --------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------- 
//--------------------------------------------------------------------------------------------
// switches
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
//-------------------------------------------------
#macro SW_R(Switch_Direction__) 
 union{ object{ Switch_0 (Switch_Direction__)}
        text{ ttf TTF, "SW_R", 0.02, 0.0 texture{TTex} transform T_Trans translate<Switch_Length/2,0,-0.35>}
      } // uni 
#end //  of macro 
//-------------------------------------------------
#macro SW_L(Switch_Direction__) 
 union{ object{ Switch_0 (Switch_Direction__) scale<1,1,-1>  }
        text{ ttf TTF, "SW_L", 0.02, 0.0 texture{TTex} transform T_Trans translate<Switch_Length/2,0,0.35>}
      } // uni 
#end //  of macro 
//-------------------------------------------------
#macro SWY(Switch_Direction__) 
 union{ 
   object{ RT_Track_Switch_Y_0 (    Simulate_On, 
                                  Switch_Direction__, // 0=right , 1=left
                                   Switch_Radius, // Switch_Radius_,
                                  Switch_Angle, //  
                                  Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                                ) } //--------------------------------------------------
   text{ ttf TTF, "SWY", 0.02, 0.0 texture{TTex} transform T_Trans translate<Switch_Length/3,0,0>}
 }// union
#end //  of macro 
//-------------------------------------------------
#macro SW3(Switch_Direction__) 
 union{ 
   object{ RT_Track_Switch_3Ways_B_0( Simulate_On, 
                                    Switch_Direction__, // 0=straight, 1=right , 2=left
                                    Switch_Length, // Track_Length_,
                                    Switch_Angle, // 
                                    Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                                ) } //--------------------------------------------------
   text{ ttf TTF, "SW3", 0.02, 0.0 texture{TTex} transform T_Trans translate<Switch_Length/2,0,0>}  
 }// union
#end //  of macro 
//--------------------------------------------------------------------------------------------
#end //    #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
//--------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------




//--------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------
#if (Simulate_On <= 0 ) 
//-------------------------------------------------
#macro SW_R(Switch_Direction__)   object{ Switch_0 (Switch_Direction__)  } 
#end  // of macro  
//-------------------------------------------------
#macro SW_L(Switch_Direction__)   object{ Switch_0 (Switch_Direction__)   scale<1,1,-1> }  
#end  // of macro
//-------------------------------------------------
#declare Switch_Radius = Switch_Length/(sin(radians( Switch_Angle))); // type A 
#macro SWY(Switch_Direction__) 
object{ RT_Track_Switch_Y_0 ( Simulate_On, 
                                  Switch_Direction__, // 0=right , 1=left
                                  Switch_Radius,// Rail___Length_,
                              Switch_Angle, // 
                                  Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                                ) } //--------------------------------------------------
#end // of macro
//-------------------------------------------------
#macro SW3(Switch_Direction__) 
   object{ RT_Track_Switch_3Ways_A_0( Simulate_On, 
                                  Switch_Direction__, // 0=straight, 1=right , 2=left
                                  Switch_Length, // Track_Length_,
                                  Switch_Angle, // 
                                  Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                                ) } //--------------------------------------------------
#end // of macro
//-------------------------------------------------
#end // of '#if (Simulate_On  <= 0 )' 




// --------------------------------------------------------------------------------------
#declare C_Angle = 15;
#declare Main_Len =  L111;
#declare Cross_Len = L115;
//
#declare X15_RL = //  crossing 15 degrees
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) union{ #end
   object{ RT_Track_Level_Junction_0 (Simulate_On,  //Simulate_On, 
                              C_Angle, //Cross_Ang, 
                              Main_Len,  // Main_Len,
                              Cross_Len, // Cross_Len, 
                              Ties_Per_Meter
                           ) }//-------------------------
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "X15 RL", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2,0,0>}
     } // end union 
   #end
#declare X15_LR = //  crossing 15 degrees
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) union{ #end
   object{ RT_Track_Level_Junction_0 (Simulate_On,  //Simulate_On, 
                             -C_Angle, //Cross_Ang, 
                              Main_Len,  // Main_Len,
                              Cross_Len, // Cross_Len, 
                              Ties_Per_Meter
                           ) }//-------------------------
  #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "X15 LR", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2,0,0>}
     } // end union 
   #end

//---------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------
#declare C_Angle2 = 30;
#declare Main_Len2  = L115;
#declare Cross_Len2 = L115;

#declare X30 = //  crossing 30 degrees
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) union{ #end
   object{ RT_Track_Level_Junction_0 (Simulate_On,  //Simulate_On, 
                              C_Angle2, //Cross_Ang, 
                              Cross_Len2, // Main_Len, 
                              Cross_Len2, // Cross_Len, 
                              Ties_Per_Meter-0.026 
                           )  } //-------------------------
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "X30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2,0,0>}
     } // end union 
   #end
//--------------

//----------------------------------------------------------------------------------------------
#declare C_Angle2 = 30;
#declare ShortLinear= T_Dist* tan(radians(60));  
#declare Len_X30s  = sqrt( pow(T_Dist,2) +pow(ShortLinear,2)); 
#declare Main_Len2  = Len_X30s;
#declare Cross_Len2 = Len_X30s;

#declare X30s = //  crossing 30 degrees
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) union{ #end
   object{ RT_Track_Level_Junction_0 (Simulate_On,  //Simulate_On, 
                              C_Angle2, //Cross_Ang, 
                              Cross_Len2, // Main_Len, 
                              Cross_Len2, // Cross_Len, 
                              Ties_Per_Meter-0.026 
                           )  } //-------------------------
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "X30_s", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2,0,0>}
     } // end union 
   #end
//--------------

// --------------------------------------------------------------------------------------
#declare C_Angle = 15;
#declare Main_Len  = L111;
#declare Cross_Len = L115;
//
#declare XX_RL = // double slip (passiv - quick and dirty)
#if (Simulate_On = 3) #local Save_Sim = 3; #local Simulate_On = 2; #else #local Save_Sim = 100; #end
union{ object{ T_Straight (Main_Len) } 
       object{ T_Straight (Main_Len) translate<-Main_Len/2,0,0> rotate<0,-Switch_Angle,0> translate<Main_Len/2,0,0>}
       object{ T_CurveS( R9, Switch_Angle, Ties_Per_Meter -0.16)  scale< 1,1,-1>  } 
       object{ T_CurveS( R9, Switch_Angle, Ties_Per_Meter -0.16) scale<-1,1, 1>  translate<Main_Len,0,0>}
#if (Save_Sim != 100) #local Simulate_On = Save_Sim; #end
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "XX RL", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2-0.02*N,0,0>}
   #end
     } // end union 

//--------------------------------------- 
#declare XX_LR = // double slip (passiv - quick and dirty)
 #if (Simulate_On = 3) #local Save_Sim = 3; #local Simulate_On = 2; #else #local Save_Sim = 100; #end
union{ 
       object{ T_Straight (Main_Len) scale<-1,1,1> translate< Main_Len,0,0>} 
       object{ T_Straight (Main_Len) translate<-Main_Len/2,0,0> rotate<0,-Switch_Angle,0> translate<Main_Len/2,0,0> scale<-1,1,1> translate< Main_Len,0,0>}
       object{ T_CurveS( R9, Switch_Angle, Ties_Per_Meter -0.16) scale< 1,1,-1>  scale<-1,1,1> translate< Main_Len,0,0>} 
       object{ T_CurveS( R9, Switch_Angle, Ties_Per_Meter -0.16) scale<-1,1, 1>  translate<Main_Len,0,0> scale<-1,1,1> translate< Main_Len,0,0>}
       
#if (Save_Sim != 100) #local Simulate_On = Save_Sim; #end

   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "XX LR", 0.02, 0.0 texture{TTex} transform T_Trans translate<L111/2-0.02*N,0,0 >}
   #end
     
     } // end union 
//---------------------------------------  Curve Switches from R1 to R2

//------------------------------------------ inprovised curved turnouts

#declare CSW21_L =// curved switches
union{
object{ T_L2_45  Rotate_Around_Trans(<0,-0*45,0>, <0,0,R2> ) }
object{ T_L2_45  Rotate_Around_Trans(<0,-1*45,0>, <0,0,R2> ) }
object{ T_L1_45  Rotate_Around_Trans(<0,-0*45,0>, <0,0,R1> ) translate<0.00,0.00,1*Track_Distance>}
object{ T_L1_45  Rotate_Around_Trans(<0,-1*45,0>, <0,0,R1> ) translate<0.00,0.00,1*Track_Distance> }
 
#local Rb = R4-0.0096*N;
#local Ab = 33; 
object{ T_Curve(Rb,Ab) rotate<0,180,0> Rotate_Around_Trans(<0,-1*90,0>, <0,0,R2> ) translate<-(R2-R1),0.00,0*Track_Distance>}
#local Rc = R1-0.0093*N;
#local Ac = 24.0; 
object{ T_Curve(Rc,Ac) scale<1,1,-1>   Rotate_Around_Trans(<0,-0*30,0>, <0,0,R1> ) }
object{ T_L1_30  Rotate_Around_Trans(<0,-1*Ac,0>, <0,0,Rc > ) }
// ----------------------------------- end curved switches
} 
#declare CSW21_R = 
object{  CSW21_L  Rotate_Around_Trans(<0,90,0>, <0,0,R2> ) rotate<0,180,0>}

#declare CSW12_L = 
object{ CSW21_L Rotate_Around_Trans(<0, 1*90,0>, <0,0,R2> )  scale<-1,1,1>} 

#declare CSW12_R = 
object{ CSW12_L Rotate_Around_Trans(<0,90,0>, <0,0,R2> ) rotate<0,180,0>}

// ----------------------------------- end curved switches


//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// samples: 
/*
#declare Simulate_On = 2;
//---------------------------------------------------------------------------------------
#include "RT_System/N_FS/RT_N_TypeA111_Set_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ G111 scale <1,1,1>*1 rotate<0,0,0> translate<0*L111, 0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_N_TypeA111_Set_00_Inc_Temp;
#end
//------------------------------------- end of include file

