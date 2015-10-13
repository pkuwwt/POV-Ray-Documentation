// POV-Ray 3.7 include file "RT_H0_TypeB_Set_00.inc"
// author: Friedrich A, Lohmueller, Dec-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_H0_TypeB_Set_00_Inc_Temp)
#declare RT_H0_TypeB_Set_00_Inc_Temp = version;
#version 3.7;
// 
// A collection of rail track elements 
// All elements scaled up by 87 ("*H0") to real world scale (1 = 1m)
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

//---------------------------------------------------
#declare H0 = 87; 
#local D = 0.00001;
//--------------------------------------------------- /// Piko rail tracks dimensions
#declare Track_Dist = 0.061875869*H0; // 0.061875869*H0; //~0.0619 in meter distance of parallel tracks
#declare Track_Distance = Track_Dist; 
                    
#declare Track_Dist2= 0.09276*H0; // distance of parallel tracks with level junction 30 degrees between
#declare Track_Distance2 = Track_Dist2; 

#declare Ri =(0.36000-0.0300)*H0; // m  for (improvisated) curve switches only 

#declare R9 = 0.907958466*H0; // m      in H0:  0.908 m    ~'R9'

#declare R0 = R9 - Track_Dist*9 ; // m  in H0:  0.3510 m   ~'R1'
#declare R1 = R9 - Track_Dist*8 ; // m  in H0:  0.4130 m   ~'R2'
#declare R2 = R9 - Track_Dist*7 ; // m  in H0:  0.475 m    ~'R3'
#declare R3 = R9 - Track_Dist*6 ; // m  in H0:  0.537 m    ~'R4'
#declare R4 = R9 - Track_Dist*5 ; // m  in H0:  0.599 m
#declare R5 = R9 - Track_Dist*4 ; // m  in H0:  0.660 m
#declare R6 = R9 - Track_Dist*3 ; // m  in H0:  0.722 m
#declare R7 = R9 - Track_Dist*2 ; // m  in H0:  0.784 m
#declare R8 = R9 - Track_Dist*1 ; // m  in H0:  0.846 m
#declare R10= R9 + Track_Dist*1; // m      in H0:  0.969 m   

#declare Modul_Len = 0.470*H0; //m 

#declare L239 = 0.23907*H0; // m L1
#declare L231 = 0.23093*H0; // m L2
#declare L119 = L239/2; // m 
#declare L115 = L231/2; // m 

#declare L107 = 0.10735*H0; // m || zu 30° Crossing
#declare L062 = 0.06188*H0; // m für Bogenweiche R2,R3,R4

#declare L940 = 0.94000*H0; // m  FlexGleis

#declare Switch_Length = L239;    // 
#declare Switch_Angle = 15; //
#declare Switch_Radius =  R9; //
//------------------------------------------------------------------------ 
#declare H0_Frame = box{<-0.048/2,0,0>,<0.048/2, 0.065,0.001> scale H0 
                        pigment{ rgb<1,0.5,0>*1 } }    
#declare H0_Frame_X = box{<-0.048/2,0,0>,<0.048/2, 0.080,0.001> scale H0 
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
//------------------------------------------------------------------------ ////////////////////////
#ifndef( Simulate_On )
#declare Simulate_On = 0; // 0=realistic, 1=two lines, 2=boxes
#end
// ------------------------------ optional base beneath the rail tracks
//------------------------------------------------------------------------------------------  
// tracks from "Rails_System_000.inc" :
//------------------------------------------------------------------------------------------  
// Variable linear track
#macro T_Straight (Track_Length_ )  
object{ RT_Track_Straight_0 ( Simulate_On, 
                              Track_Length_, 
                              Ties_Per_Meter,
                            ) } //------------------------------------------------------------ 
#end // end of macro -----------------------------------------------------------------------
// Variable round track
#macro T_Curve ( Rail_Radius_, Curve_Angle_ ) 
object{  RT_Track_Curve_0 (  Simulate_On, 
                            Rail_Radius_, // in meter  
                            Curve_Angle_ , // in degrees lefthanded  
                            Ties_Per_Meter, // Ties_Per_Meter_  // ~1.5
                          ) }   //------------------------------
#end // end of macro -----------------------------------------------------------------------
// ----------------------------------------------------------------------- Standard Switches  
#macro Switch_0 (Switch_Direction_ ) // 
object{ RT_Track_Switch_B_0( Simulate_On, 
                             Switch_Direction_, // straight ~ 1 round (Save 0< x <1)
                             L239,  // meter
                             Switch_Angle, // Switch_Angle,   // degrees 
                             Ties_Per_Meter*1.20// Ties_Per_Meter_  // ~1.5
                           ) } //---------------
#end // end of macro ---------------------------------------------------------------------  
// ----------------------------------------------------------------------------- /////////
// ----------------------------------------------------------------------------- /////////
/*
// Track Set H0 Type B (~ 'Piko Gleis A' ) 
//constants:
H0 = 87 -> 3cm on H0 layout -> 0.03*H0; 
//-------------------------------------  
Track_Dist or Track_Distance   (=0.06188*H0)
Track_Dist2 or Track_Distance2 (=0.09276*H0
lengths of curve radii: R1, R2, R3, ..., R9 
lengths of straigth tracks:   L239,  L231,  L119,  L115,  L107,  L062,  L940
Modul_Len = 0.470*H0;
Switch_Length = L239;   
Switch_Angle = 15; 
Switch_Radius =  R9;

// track objects: 
object{ T_Straight ( Lenght ) rotate<0,0,0> translate<0*Lenght ,0,0> } 
object{ T_Curve    ( Curve_Radius, Curve_Angle ) Rotate_Around_Trans(<0,0*Curve_Angle_,0>,<0,0,-Curve_Radius>) rotate<0,0,0> translate<0,0,0> } 
//--------------------------------------------------
object{ T_239 rotate<0,0,0> translate<0*L239,0,0> } 
object{ T_231 rotate<0,0,0> translate<0*L231,0,0> } 
object{ T_119 rotate<0,0,0> translate<0*L119,0,0> } 
object{ T_115 rotate<0,0,0> translate<0*L115,0,0> } 
object{ T_107 rotate<0,0,0> translate<0*L107,0,0> } 
object{ T_062 rotate<0,0,0> translate<0*L062,0,0> } 
object{ T_940 rotate<0,0,0> translate<0*L940,0,0> } 

object{ T_R0_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R0_30>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R1_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R1_30>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R2_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R2_30>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R3_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R3_30>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R4_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R4_30>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R5_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R5_30>) rotate<0,0,0> translate<0,0,0> }   
object{ T_R6_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R6_30>) rotate<0,0,0> translate<0,0,0> }   
object{ T_R7_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R7_30>) rotate<0,0,0> translate<0,0,0> }   
object{ T_R8_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R8_30>) rotate<0,0,0> translate<0,0,0> }    
object{ T_R9_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R9_30>) rotate<0,0,0> translate<0,0,0> }    
object{ T_R10_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R10_30>) rotate<0,0,0> translate<0,0,0> }    

object{ T_R0_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R0_15>) rotate<0,0,0> translate<0,0,0> }  
....
object{ T_R9_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R9_15>) rotate<0,0,0> translate<0,0,0> }  
object{ T_R10_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R10_15>) rotate<0,0,0> translate<0,0,0> }  

object{ T_R0_075= Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R0_075>) rotate<0,0,0> translate<0,0,0> }
object{ T_R1_075= Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R1_075>) rotate<0,0,0> translate<0,0,0> }
object{ T_R2_075= Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R2_075>) rotate<0,0,0> translate<0,0,0> }
...
object{ T_R10_075= Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R10_075>) rotate<0,0,0> translate<0,0,0> }

object{ SWR(Switch_Direction) rotate<0,0,0> translate<0*L239,0,0>} 
object{ SWL(Switch_Direction) rotate<0,0,0> translate<0*L239,0,0>} 
 
object{ SW3(Switch_Direction) rotate<0,0,0> translate<0*L239,0,0>}  
object{ SWY(Switch_Direction) rotate<0,0,0> translate<0*L239,0,0>} 
object{ X15     rotate<0,0,0> translate<0*L239,0,0>}  
object{ X30     rotate<0,0,0> translate<0*L239,0,0>}  
object{ XX15    rotate<0,0,0> translate<0*L239,0,0>} 
object{ CSW_23R  rotate<0,0,0> translate<0*L239,0,0>} 
object{ CSW_23L  rotate<0,0,0> translate<0*L239,0,0>} 
object{ CSWR     rotate<0,0,0> translate<0*L239,0,0>} 
*/ 

// ----------------------------------------------------------------------------- /////////  
#declare T_Trans = transform{ scale<1,1.25,1>*1.25 
                              rotate<90,0,0> 
                              translate<0, Rails_Height+0.001 ,-0.55>}  
// ----------------------------------------------------------------------------- /////////  

// linear tracks
#declare G_Flex  = object{ T_Straight (L940) } 
#if (Simulate_On <=0 ) 
#declare T_231 = object{ T_Straight (L231) } 
#declare T_239 = object{ T_Straight (L239) } 
#declare T_119 = object{ T_Straight (L119) } 
#declare T_115 = object{ T_Straight (L115) } 
#declare T_107 = object{ T_Straight (L107) } 
#declare T_062 = object{ T_Straight (L062) } 
#declare T_940 = object{ T_Straight (L940) } 

#end // #if (Simulate_On <=0 ) 
//--------------
#if ( Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
#declare T_940 = 
union{ object{ T_Straight (L940) } 
       text{ ttf TTF, "T_940", 0.02, 0.0 texture{TTex} transform T_Trans translate<L940/2,0,0>}} 
#declare T_231 = 
union{ object{ T_Straight (L231) } 
       text{ ttf TTF, "T_0231", 0.02, 0.0 texture{TTex} transform T_Trans translate<L231/2,0,0>}} 
#declare T_239 = 
union{ object{ T_Straight (L239) } 
       text{ ttf TTF, "T_239", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/2,0,0>}} 
#declare T_119 = 
union{ object{ T_Straight (L119) } 
       text{ ttf TTF, "T_119", 0.02, 0.0 texture{TTex} transform T_Trans translate<L119/2,0,0>}} 
#declare T_115 = 
union{ object{ T_Straight (L115) } 
       text{ ttf TTF, "T_115", 0.02, 0.0 texture{TTex} transform T_Trans translate<L115/2,0,0>}} 
#declare T_107 = 
union{ object{ T_Straight (L107) } 
       text{ ttf TTF, "T_107", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/2,0,0>}} 
#declare T_062  = 
union{ object{ T_Straight (L062 ) } 
       text{ ttf TTF, "T_062", 0.02, 0.0 texture{TTex} transform T_Trans translate<L062/2,0,0>}} 

#end // of "#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) "
// -------------------------------------------------------------------------------------- 
// -------------------------------------------------------------------------------------- 
// round tracks
#declare T_Ri_30 =  object{ T_Curve ( Ri, 30 )   }  
#declare T_Rix = object{ T_Curve ( Ri, 41.95 )  }  


#if (Simulate_On <= 0 ) //----------------------------------------------------------------------------------------- Simulate_0n = 0; 
#declare T_R0_30 = object{ T_Curve ( R0, 30 )  }  
#declare T_R1_30 = object{ T_Curve ( R1, 30 )  }  
#declare T_R2_30 = object{ T_Curve ( R2, 30 ) }  
#declare T_R3_30 = object{ T_Curve ( R3, 30 ) }  
#declare T_R4_30 = object{ T_Curve ( R4, 30 ) }  
#declare T_R5_30 = object{ T_Curve ( R5, 30 ) }  
#declare T_R6_30 = object{ T_Curve ( R6, 30 ) }  
#declare T_R7_30 = object{ T_Curve ( R7, 30 ) }   
#declare T_R8_30 = object{ T_Curve ( R8, 30 ) }   
#declare T_R9_30 = object{ T_Curve ( R9, 30 ) }   
#declare T_R10_30= object{ T_Curve (R10, 30 ) }   

#declare T_R0_15 = object{ T_Curve ( R0, 15 ) }  
#declare T_R1_15 = object{ T_Curve ( R1, 15 ) }  
#declare T_R2_15 = object{ T_Curve ( R2, 15 ) }  
#declare T_R3_15 = object{ T_Curve ( R3, 15 ) }  
#declare T_R4_15 = object{ T_Curve ( R4, 15 ) }  
#declare T_R5_15 = object{ T_Curve ( R5, 15 ) }  
#declare T_R6_15 = object{ T_Curve ( R6, 15 ) }  
#declare T_R7_15 = object{ T_Curve ( R7, 15 ) }  
#declare T_R8_15 = object{ T_Curve ( R8, 15 ) }  
#declare T_R9_15 = object{ T_Curve ( R9, 15 ) }  
#declare T_R10_15= object{ T_Curve (R10, 15 ) }  

#declare T_R0_075= object{ T_Curve ( R0, 7.5) }
#declare T_R1_075= object{ T_Curve ( R1, 7.5) }
#declare T_R2_075= object{ T_Curve ( R2, 7.5) }
#declare T_R3_075= object{ T_Curve ( R3, 7.5) }
#declare T_R4_075= object{ T_Curve ( R4, 7.5) }
#declare T_R5_075= object{ T_Curve ( R5, 7.5) }
#declare T_R6_075= object{ T_Curve ( R6, 7.5) }
#declare T_R7_075= object{ T_Curve ( R7, 7.5) }
#declare T_R8_075= object{ T_Curve ( R8, 7.5) }
#declare T_R9_075= object{ T_Curve ( R9, 7.5) }
#declare T_R10_075=object{ T_Curve (R10, 7.5) }

#declare T_L0_30 = object{ T_Curve ( R0, 30 ) scale<1,1,-1> }  
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

#declare T_L0_15 = object{ T_Curve ( R0, 15 ) scale<1,1,-1> }  
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

#declare T_L0_075= object{ T_Curve ( R0, 7.5) scale<1,1,-1> }
#declare T_L1_075= object{ T_Curve ( R1, 7.5) scale<1,1,-1> }
#declare T_L2_075= object{ T_Curve ( R2, 7.5) scale<1,1,-1> }
#declare T_L3_075= object{ T_Curve ( R3, 7.5) scale<1,1,-1> }
#declare T_L4_075= object{ T_Curve ( R4, 7.5) scale<1,1,-1> }
#declare T_L5_075= object{ T_Curve ( R5, 7.5) scale<1,1,-1> }
#declare T_L6_075= object{ T_Curve ( R6, 7.5) scale<1,1,-1> }
#declare T_L7_075= object{ T_Curve ( R7, 7.5) scale<1,1,-1> }
#declare T_L8_075= object{ T_Curve ( R8, 7.5) scale<1,1,-1> }
#declare T_L9_075= object{ T_Curve ( R9, 7.5) scale<1,1,-1> }
#declare T_L10_075=object{ T_Curve (R10, 7.5) scale<1,1,-1> }

#end //-------------------------------------------- end  of "#if (Simulate_On =0 ) "


#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
#declare T_R0_30 = union{ object{ T_Curve ( R0, 30 )  }  
                     text{ ttf TTF, "R0_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R1_30 = union{ object{ T_Curve ( R1, 30 )  }  
                     text{ ttf TTF, "R1_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R2_30 = union{ object{ T_Curve ( R2, 30 )  }  
                     text{ ttf TTF, "R2_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R3_30 = union{ object{ T_Curve ( R3, 30 )  }  
                     text{ ttf TTF, "R3_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R4_30 = union{ object{ T_Curve ( R4, 30 )  }  
                     text{ ttf TTF, "R4_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R5_30 = union{ object{ T_Curve ( R5, 30 )  }   
                     text{ ttf TTF, "R5_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R6_30 = union{ object{ T_Curve ( R6, 30 )  }  
                     text{ ttf TTF, "R6_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R7_30 = union{ object{ T_Curve ( R7, 30 )  }  
                     text{ ttf TTF, "R7_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R8_30 = union{ object{ T_Curve ( R8, 30 )  } 
                     text{ ttf TTF, "R8_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R9_30 = union{ object{ T_Curve ( R9, 30 )  } 
                     text{ ttf TTF, "R9_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 
#declare T_R10_30= union{ object{ T_Curve ( R10, 30 )  } 
                     text{ ttf TTF, "R10_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0,0>}} 

#declare T_R0_15 = union{ object{ T_Curve ( R0, 15 ) }  
                          text{ ttf TTF, "R0_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R1_15 = union{ object{ T_Curve ( R1, 15 ) }  
                          text{ ttf TTF, "R1_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R2_15 = union{ object{ T_Curve ( R2, 15 ) }  
                          text{ ttf TTF, "R2_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R3_15 = union{ object{ T_Curve ( R3, 15 ) }  
                          text{ ttf TTF, "R3_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R4_15 = union{ object{ T_Curve ( R4, 15 ) }  
                          text{ ttf TTF, "R4_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R5_15 = union{ object{ T_Curve ( R5, 15 ) }  
                          text{ ttf TTF, "R4_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R6_15 = union{ object{ T_Curve ( R6, 15 ) }  
                          text{ ttf TTF, "R4_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R7_15 = union{ object{ T_Curve ( R7, 15 ) }  
                          text{ ttf TTF, "R4_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R8_15 = union{ object{ T_Curve ( R8, 15 ) }  
                          text{ ttf TTF, "R4_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R9_15 = union{ object{ T_Curve ( R9, 15 ) }  
                          text{ ttf TTF, "R9_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_R10_15= union{ object{ T_Curve ( R10, 15 ) }  
                          text{ ttf TTF, "R10_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 

#declare T_R0_075 = union{ object{ T_Curve ( R0, 7.5 )  }  
                     text{ ttf TTF, "R0_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R1_075 = union{ object{ T_Curve ( R1, 7.5 )  }  
                     text{ ttf TTF, "R1_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R2_075 = union{ object{ T_Curve ( R2, 7.5 )  }  
                     text{ ttf TTF, "R2_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R3_075 = union{ object{ T_Curve ( R3, 7.5 )  }  
                     text{ ttf TTF, "R3_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R4_075 = union{ object{ T_Curve ( R4, 7.5 )  }  
                     text{ ttf TTF, "R4_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R5_075 = union{ object{ T_Curve ( R5, 7.5 )  }  
                     text{ ttf TTF, "R5_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R6_075 = union{ object{ T_Curve ( R6, 7.5 )  }  
                     text{ ttf TTF, "R6_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R7_075 = union{ object{ T_Curve ( R7, 7.5 )  }  
                     text{ ttf TTF, "R7_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R8_075 = union{ object{ T_Curve ( R8, 7.5 )  }  
                     text{ ttf TTF, "R8_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R9_075 = union{ object{ T_Curve ( R9, 7.5 )  }  
                     text{ ttf TTF, "R9_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 
#declare T_R10_075= union{ object{ T_Curve ( R10, 7.5 )  }  
                     text{ ttf TTF, "R10_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.002*H0,0,-0.0>}} 

#declare T_L0_30 = union{ object{ T_Curve ( R0, 30 ) scale<1,1,-1> }  
                     text{ ttf TTF, "R0_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L1_30 = union{ object{ T_Curve ( R1, 30 ) scale<1,1,-1> }  
                     text{ ttf TTF, "R1_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L2_30 = union{ object{ T_Curve ( R2, 30 ) scale<1,1,-1> }  
                     text{ ttf TTF, "R2_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L3_30 = union{ object{ T_Curve ( R3, 30 ) scale<1,1,-1> }  
                     text{ ttf TTF, "R3_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L4_30 = union{ object{ T_Curve ( R4, 30 ) scale<1,1,-1> }  
                     text{ ttf TTF, "R4_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L5_30 = union{ object{ T_Curve ( R5, 30 ) scale<1,1,-1> }  
                     text{ ttf TTF, "R5_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L6_30 = union{ object{ T_Curve ( R6, 30 ) scale<1,1,-1> }   
                     text{ ttf TTF, "R6_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L7_30 = union{ object{ T_Curve ( R7, 30 ) scale<1,1,-1> }   
                     text{ ttf TTF, "R7_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L8_30 = union{ object{ T_Curve ( R8, 30 ) scale<1,1,-1> }   
                     text{ ttf TTF, "R8_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L9_30 = union{ object{ T_Curve ( R9, 30 ) scale<1,1,-1> }   
                     text{ ttf TTF, "R9_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 
#declare T_L10_30= union{ object{ T_Curve ( R10, 30 ) scale<1,1,-1> }   
                     text{ ttf TTF, "R10_30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L107/4,0, 0.1>}} 

#declare T_L0_15 = union{ object{ T_Curve ( R0, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R0_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*H0,0,0>}} 
#declare T_L1_15 = union{ object{ T_Curve ( R1, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R1_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*H0,0,0>}} 
#declare T_L2_15 = union{ object{ T_Curve ( R2, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R2_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.005*H0,0,0>}} 
#declare T_L3_15 = union{ object{ T_Curve ( R3, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R3_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_L4_15 = union{ object{ T_Curve ( R4, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R4_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_L5_15 = union{ object{ T_Curve ( R5, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R5_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_L6_15 = union{ object{ T_Curve ( R6, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R6_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_L7_15 = union{ object{ T_Curve ( R7, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R7_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_L8_15 = union{ object{ T_Curve ( R8, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R8_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0,0>}} 
#declare T_L9_15 = union{ object{ T_Curve ( R9, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R9_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.1>}} 
#declare T_L10_15= union{ object{ T_Curve ( R10, 15 ) scale<1,1,-1> }  
                          text{ ttf TTF, "R10_15", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.1>}} 


#declare T_L0_075 = union{ object{ T_Curve ( R0, 7.5) scale<1,1,-1> }  
                           text{ ttf TTF, "R0_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L1_075 = union{ object{ T_Curve ( R1, 7.5) scale<1,1,-1> }  
                           text{ ttf TTF, "R1_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L2_075 = union{ object{ T_Curve ( R2, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R2_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L3_075 = union{ object{ T_Curve ( R3, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R3_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L4_075 = union{ object{ T_Curve ( R4, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R4_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L5_075 = union{ object{ T_Curve ( R5, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R5_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L6_075 = union{ object{ T_Curve ( R6, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R6_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L7_075 = union{ object{ T_Curve ( R7, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R7_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L8_075 = union{ object{ T_Curve ( R8, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R8_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 
#declare T_L9_075 = union{ object{ T_Curve ( R9, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R9_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<-0.003*H0,0,0>}} 
#declare T_L10_075 =union{ object{ T_Curve ( R10, 7.5 ) scale<1,1,-1> }  
                           text{ ttf TTF, "R10_075", 0.02, 0.0 texture{TTex} transform T_Trans translate<0.003*H0,0, 0.15>}} 

// to -x //----------------------------------------------------
#end // of "#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3)" 
// --------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------- 
// switches
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
//-------------------------------------------------
#macro SW_R(Switch_Direction__) 
 union{ object{ Switch_0 (Switch_Direction__)}
        text{ ttf TTF, "SW_R", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/2,0,-0.35>}
      } // uni 
#end //  of macro 
//-------------------------------------------------
#macro SW_L(Switch_Direction__) 
 union{ object{ Switch_0 (Switch_Direction__) scale<1,1,-1>  }
        text{ ttf TTF, "SW_L", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/2,0,0.35>}
      } // uni 
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
 text{ ttf TTF, "SW3", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/2,0,0>}  
}// union
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
 text{ ttf TTF, "SWY", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/3,0,0>}
}// union
#end //  of macro 
// to -x //---------------------------------------
//-------------------------------------------------
#end //    #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
//-------------------------------------------------

#if (Simulate_On <= 0 ) 
//-------------------------------------------------
#macro SW_R(Switch_Direction__)   object{ Switch_0 (Switch_Direction__)  } //  
#end 
//-------------------------------------------------
#macro SW_L(Switch_Direction__)   object{ Switch_0 (Switch_Direction__)   scale<1,1,-1> } // uni 
#end 
//-------------------------------------------------
#macro SWY(Switch_Direction__) 
object{ RT_Track_Switch_Y_0 ( Simulate_On, 
                                  Switch_Direction__, // 0=right , 1=left
                                  Switch_Radius,  // Switch_Radius,
                                  Switch_Angle, //
                                  Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                                ) } //--------------------------------------------------
#end // of macro
//-------------------------------------------------
#macro SW3(Switch_Direction__) 
object{ RT_Track_Switch_3Ways_B_0( Simulate_On, 
                                  Switch_Direction__, // 0=straight, 1=right , 2=left
                                  Switch_Length, // Track_Length_,
                                  Switch_Angle, // 
                                  Ties_Per_Meter // Ties_Per_Meter_  // ~1.5
                                ) } //--------------------------------------------------
#end // of macro
//-------------------------------------------------
#end //    #if (Simulate_On  <= 0 ) 
// --------------------------------------------------------------------------------------



// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#declare X15 = //  crossing 15 degrees
#if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) union{ #end
   object{ RT_Track_Level_Junction_0 (Simulate_On,  //Simulate_On, 
                              15, //Cross_Ang, 
                              L239,  // Main_Len,
                              L239 , // Cross_Len, 
                              Ties_Per_Meter
                           ) }//-------------------------
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
       text{ ttf TTF, "X15", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/2,0,0> }
     } // end union 
   #end
//----------------------------------------------------------------------------------------------
#declare X30 = //  crossing 30 degrees
#if (Simulate_On = 1 | Simulate_On = 2| Simulate_On = 3) union{ #end
   object{ RT_Track_Level_Junction_0 (Simulate_On,  //Simulate_On, 
                              30, //Cross_Ang, 
                              L119, // Main_Len, 
                              L119, // Cross_Len, 
                              Ties_Per_Meter-0.026 
                           ) scale< 1,1,1> } //-------------------------
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
       text{ ttf TTF, "X30", 0.02, 0.0 texture{TTex} transform T_Trans translate<L119/3,0,0>}
     } // end union 
   #end
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#declare XX15 = // double switch (passiv - quick and dirty)
union{ object{ T_Straight (L239) } 
       object{ T_Straight (L239) translate<-L231/2,0,0> rotate<0,-15,0> translate<L231/2,0,0>}
       object{ T_Curve ( R9, 15 ) scale< 1,1,-1>  } 
       object{ T_Curve ( R9, 15 ) scale<-1,1, 1>  translate<L239,0,0>}
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3) 
       text{ ttf TTF, "XX15", 0.02, 0.0 texture{TTex} transform T_Trans translate<L239/2-0.02*H0,0,0>}
   #end
     } // end union 
// --------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------- (quick and dirty)
#declare CSW_23R =  // curved switch R2~R3   
union { 
 object{ T_R2_30 scale< 1,1, 1> translate<0,0,R2> rotate<0, 0,0> translate<0,0,-R2> } 
 object{ T_R2_30 scale< 1,1, 1> translate<0,0,R2> rotate<0,30,0> translate<0,0,-R2> } 
 object{ T_R9_15 scale< 1,1, 1> translate<0,0,R2> rotate<0, 0,0> translate<0,0,-R2> } 

 union { 
  object{ T_R3_30 scale< 1,1,1> translate<0,0,R3> rotate<0, 0,0> translate<0,0,-R3> } 
  object{ T_R3_30 scale< 1,1,1> translate<0,0,R3> rotate<0,30,0> translate<0,0,-R3> } 
  object{ T_Rix   scale<-1,1,1> translate<0,0,R3> rotate<0,60,0> translate<0,0,-R3> } 
  translate<0,0, Track_Dist>
 }// uni
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
    text{ ttf TTF, "CSW_23", 0.02, 0.0 texture{TTex} transform T_Trans rotate<0, 15,0> translate<L239*0.85,0,-2.00 >  }
   #end
}// end union 
#declare CSW_23L =  // curved switch R2~R3   
union { 
 union { //2 
  object{ T_R2_30 scale< 1,1, 1> translate<0,0,R2> rotate<0, 0,0> translate<0,0,-R2> } 
  object{ T_R2_30 scale< 1,1, 1> translate<0,0,R2> rotate<0,30,0> translate<0,0,-R2> } 
  object{ T_R9_15 scale< 1,1, 1> translate<0,0,R2> rotate<0, 0,0> translate<0,0,-R2> } 

  union { 
   object{ T_R3_30 scale< 1,1, 1> translate<0,0,R3> rotate<0, 0,0> translate<0,0,-R3> } 
   object{ T_R3_30 scale< 1,1, 1> translate<0,0,R3> rotate<0,30,0> translate<0,0,-R3> } 
   object{ T_Rix   scale<-1,1, 1> translate<0,0,R3> rotate<0,60,0> translate<0,0,-R3> } 
   translate<0,0, Track_Dist>
  }// uni
 scale<1,1,-1>
 }//2 

   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
    text{ ttf TTF, "CSW_23", 0.02, 0.0 texture{TTex} transform T_Trans rotate<0, 15,0> translate<L239*0.85,0,-2.00 >  }
   #end
}// end union 

 
#declare CSW_L = // curved switch left (passiv - quick and dirty)
union { 
  object{ T_R2_30 scale< 1,1, 1> translate<0,0,R2> rotate<0, 0,0> translate<0,0,-R2> } 
  object{ T_R9_15 scale< 1,1, 1> translate<0,0,R2> rotate<0, 0,0> translate<0,0,-R2> } 
   #if (Simulate_On = 1 | Simulate_On = 2 ) 
    text{ ttf TTF, "CSWL", 0.02, 0.0 texture{TTex} transform T_Trans rotate<0, 15,0> translate<L239*0.5,0,-1.00 >  }
   #end
}// end union 
// 
#declare CSW_R  = // curved switch right (passiv - quick and dirty)
union { 
  object{ T_R3_30 scale< 1,1, 1> translate<0,0,R3> rotate<0, 0,0> translate<0,0,-R3> } 
  object{ T_Rix   scale<-1,1,1> translate<0,0,R3> rotate<0,30,0> translate<0,0,-R3> } 
   #if (Simulate_On = 1 | Simulate_On = 2 | Simulate_On = 3 ) 
    text{ ttf TTF, "CSWR", 0.02, 0.0 texture{TTex} transform T_Trans rotate<0, 15,0> translate<L239*0.35,0,-1.00 >  }
   #end
}// end union 

// ----------------------------------------------------------------------- end  PikoGleisA-like railroad tracks

 


//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
#declare Simulate_On = 2; // -1,0,1,2,3
//---------------------------------------------------------------------------------------
#include "RT_System/H0_B/RT_H0_TypeB_Set_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ T_940 scale <1,1,1>*1 rotate<0,0,0> translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_H0_TypeB_Set_00_Inc_Temp;
#end
//------------------------------------- end of include file

