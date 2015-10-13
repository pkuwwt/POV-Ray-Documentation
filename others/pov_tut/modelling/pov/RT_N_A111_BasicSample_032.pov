// POV-Ray 3.7 Scene File "RT_N_A111_BasicSample_032.pov"
// N scale Track Layout Design by rescaling N scale elements by '*160' to real world sizes (1 unit = 1 meter)

// author: Friedrich A. Lohmueller, Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7; 
global_settings { assumed_gamma 1.0 }
global_settings { charset utf8 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 2 ;

#declare N = 160;
//---------------------------


//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = <0.60*N, 0.10*N, -1.50*N-0.0001> ;  // front view
  #declare Camera_Look_At  = <0.60*N, 0.10*N,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = <-0.10*N, 0.50*N, -0.10*N-0.0001> ;  // front view
  #declare Camera_Look_At  = < 0.30*N,-0.05*N,  0.20*N> ;
  #declare Camera_Angle    =  70 ;
#break
#case (2) // aspect ratio 4:3 
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 1;// don't use fish eye - for proper text
  #declare Camera_Position = <0.55*N, 1.77*N,  0.407*N+0.00 > ;  // front view
  #declare Camera_Look_At  = <0.55*N,   0.00,  0.407*N+0.01> ;
  #declare Camera_Angle    = 35;
#break
#else
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ #if (Ultra_Wide_Angle_On = 1) ultra_wide_angle #end  // don't use fish eye - for proper text
        #if (Orthographic_On = 1) orthographic #end // don't use fish eye - for proper text
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<

//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,1500, 1500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------

//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture)
 union{
    cylinder { <0,-AxisLen,0>,<0,AxisLen,0>,0.05
               texture{checker texture{Dark_Texture }
                               texture{Light_Texture}
                       translate<0.1,0,0.1>}
             }
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
          texture{Dark_Texture}
         }
     } // end of union
#end // of macro "Axis()"
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
#declare Text_Rotate = <80,0,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.15,0.2, 0.20> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.5 translate <-0.45,AxisLenY+0.20, 0.25> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <-0.55,0.2,AxisLenZ+0.10> no_shadow }
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0 * 160/100; // cm Raster
#declare RasterHalfLine  = 0.055;
#declare RasterHalfLineZ = 0.055;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------
#declare RasterScale2 = 10.0 * 160/100; // 1cm raster
#declare RasterHalfLine2  = 0.010;
#declare RasterHalfLineZ2 = 0.010;
// ------------------------------------------------------------------------
#macro Raster2(RScale2, HLine2)
       pigment{ gradient x scale RScale2
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine2 color rgbt<1,1,1,0>*0.6]
                          [0+HLine2 color rgbt<1,1,1,1>]
                          [1-HLine2 color rgbt<1,1,1,1>]
                          [1-HLine2 color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

/*
// N scale track set: ( ~ Fleischmann  'piccolo', but much much better!!!)
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
#declare R9 = RS - 0*Track_Dist; // ~ 0.429 m  // Switch_Radius 
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
// rail track objects: 
object{ T_Straight ( Lenght ) rotate<0,0,0> translate<0*Lenght ,0,0> } 
object{ T_Curve    ( Curve_Radius, Curve_Angle ) Rotate_Around_Trans(<0,0*Curve_Angle_,0>,<0,0,-Curve_Radius>) rotate<0,0,0> translate<0,0,0> } 
//--------------------------------------------------
object{ T_222 rotate<0,0,0> translate<0*L222 ,0,0> } 
object{ T_115 rotate<0,0,0> translate<0*L111 ,0,0> }
object{ T_111 rotate<0,0,0> translate<0*L111 ,0,0> }
object{ T_107 rotate<0,0,0> translate<0*L107 ,0,0> }
object{ T_057 rotate<0,0,0> translate<0*L057 ,0,0> } 
object{ T_055 rotate<0,0,0> translate<0*L055 ,0,0> } 
object{ T_028 rotate<0,0,0> translate<0*L028 ,0,0> } 
object{ T_777 rotate<0,0,0> translate<0*L777 ,0,0> } 
// curves 45 degress
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
// curves 30 degrees
object{ T_R1_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> }  
....
object{ T_R10_30 Rotate_Around_Trans(<0,0*30,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> } 
// curves 15 degrees
object{ T_R1_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> }  
... 
object{ T_R10_15 Rotate_Around_Trans(<0,0*15,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> } 
// curves 7.5 degrees
object{ T_R1_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R1>) rotate<0,0,0> translate<0,0,0> } 
...
object{ T_R10_075 Rotate_Around_Trans(<0,0*7.5,0>,<0,0,-R10>) rotate<0,0,0> translate<0,0,0> } 
// tracks up and down by macro Track_Up_00 
object{ Track_Up_00 ("T_L1_15", Step_1/2,1) Rotate_Around_Trans(<0, 0*15,0>,<0,0, R1>) translate<0,0.0*Step_1*N,0> } // start upward 
object{ Track_Up_00 ("T_L1_15", Step_1  ,0) Rotate_Around_Trans(<0, 1*15,0>,<0,0, R1>) translate<0,0.5*Step_1*N,0> } // continuous up/down 
object{ Track_Up_00 ("T_L1_15", Step_1/2,2) Rotate_Around_Trans(<0, 1*15,0>,<0,0, R1>) translate<0,0.5*Step_1*N,0> } // end upward 
// analog: object{ L1_45 ... for left curve - just for easier placing the curve elements !!!
// turnouts - switches
object{ SW_R(Switch_Direction) rotate<0,0,0> translate<0*L111,0,0>} // angle: 15 degrees
object{ SW_L(Switch_Direction) rotate<0,0,0> translate<0*L111,0,0>} 
object{ SW3(Switch_Direction) rotate<0,0,0> translate<0*L111,0,0>} 
object{ SWY(Switch_Direction) rotate<0,0,0> translate<0*L111,0,0>} 
// sheared: 
object{ SW_R(Switch_Direction) Shear_Up(L111, 0.003) rotate<0,0,0> translate<0*L111,0,0>} // angle: 15 degrees
// -------------------------------
object{ X15_RL    rotate<0,0,0> translate<0*L111,0,0>} // level junction - diamond crossing 
object{ X15_LR    rotate<0,0,0> translate<0*L111,0,0>}  
object{ XX_RL    rotate<0,0,0> translate<0*L111,0,0>}  // double slip
object{ XX_LR    rotate<0,0,0> translate<0*L111,0,0>} 
// double sets of curved switches: (not correctly ! still something ToDo!)
//object{ CSW12_R  rotate<0,0,0> translate<0,0,0>}    
//object{ CSW21_R  rotate<0,0,0> translate<0,0,0>}    
//object{ CSW12_L  rotate<0,0,0> translate<0,0,0>} 
//object{ CSW21_L   rotate<0,0,0> translate<0,0,0>} 
//--------------------------------------------------------------------------
*/ 

//-------------------------------------------------------------------------------------//
#macro Block ( Low ) // supporting block
  box{<-0.005,Low+(Simulate_On = -1)*-0.0025,-0.012>,<0.005,-0.0015,0.012> scale N 
  texture {  pigment{ color rgb<1.00, 1.00, 1.00>} finish{ phong 1 } }  } 
  translate<0, 0,0>
#end // of macro
//--------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
// Switch_Directions -------------------------------------------------------
#local SD_1 = 1; // 0 = straight, 1 = round  
#local SD_2 = 1; // 0 = straight, 1 = round  
#local SD_3 = 1; // 0 = straight, 1 = round  
//#local SD_4 = 1; // 0 = straight, 1 = round  
//#local SD_5 = 1; // 0 = straight, 1 = round  
//#local SD_6 = 1; // 0 = straight, 1 = round  
//#local SD_7 = 1; // 0 = straight, 1 = round  
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
 #declare Simulate_On = -1  ; // -1=real with base, 0 = real, 1 = double rails, 2 = single blocks, 3 = blocks with names
 #declare Rail_Spikes_On = 0; // 0 = no spikes, 1 = with spikes
 #local Blocks_ON = 1 ;  // 1 = on, 0 = off 

 //------------------------------------------------------------------------------------//
 #declare Rails_Quick_Texture = texture{pigment{color rgb< 1, 1, 1>*0.85 }} 
 #declare Rails_End_Texture   = texture{pigment{color rgb< 0.75, 0, 0.00> }} 
 #declare Track_Base_Texture  = texture{pigment{color rgb<1,1,1>*1.1 }} 
 //------------------------------------------------------------------------------------//
#include "RT_System/N_TypeA111/RT_N_TypeA111_Set_00.inc" 
#include "RT_System/N_TypeA111/RT_N_TypeA111_Track_Up_00.inc" 
#declare N = 160;
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
#local Step_1 = 0.0035; // meter value for N scale tracks
#local Step_2 = Step_1*1.000; 
//-------------------------------------------------------------------------------------//
#macro Shear_Up(Shear_Len,Step_Up)
 matrix<1,Step_Up*N/Shear_Len ,0, 0,1,0, 0,0,1, 0,0,0> 
#end
//-------------------------------------------------------------------------------------//
#macro RTyz( Y_Angle, Z_Distance )
 Rotate_Around_Trans(<0, Y_Angle,0>,<0,0,Z_Distance>)
#end 
//-------------------------------------------------------------------------------------------------------// 
//-------------------------------------------------------------------------------------------------------// 
//-------------------------------------------------------------------------------------------------------// 
#declare Scene = 

union{ // global - track layout on a N scale raster plate
//-------------------------------------------------------------------------------------// 
union{ // rail tracks union
//-------------------------
 sphere { <0,0,0>,0.0025*160  pigment { color rgb<1,0,0>}  translate<0,0,0>} // start marker
 //-------------------------------------------------------------------------------------//
union{ //  western curve
 object{ Track_Up_00 ("T_R1_15", Step_1/2,1) RTyz( 0*15,-R1) translate<0, 0.0*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 1*15,-R1) translate<0, 0.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 2*15,-R1) translate<0, 1.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 3*15,-R1) translate<0, 2.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 4*15,-R1) translate<0, 3.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 5*15,-R1) translate<0, 4.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 6*15,-R1) translate<0, 5.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 7*15,-R1) translate<0, 6.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 8*15,-R1) translate<0, 7.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz( 9*15,-R1) translate<0, 8.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(10*15,-R1) translate<0, 9.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(11*15,-R1) translate<0,10.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(12*15,-R1) translate<0,11.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(13*15,-R1) translate<0,12.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(14*15,-R1) translate<0,13.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(15*15,-R1) translate<0,14.5*Step_1*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_1,  0) RTyz(16*15,-R1) translate<0,15.5*Step_1*N,0> }  
 #if ( Blocks_ON = 1 )
   object{ Block ( - 0.5*Step_1 )  RTyz( 1*15,-R1) translate<0, 0.5*Step_1*N,0> }  
   object{ Block ( - 1.5*Step_1 )  RTyz( 2*15,-R1) translate<0, 1.5*Step_1*N,0> }  
   object{ Block ( - 2.5*Step_1 )  RTyz( 3*15,-R1) translate<0, 2.5*Step_1*N,0> }  
   object{ Block ( - 3.5*Step_1 )  RTyz( 4*15,-R1) translate<0, 3.5*Step_1*N,0> }  
   object{ Block ( - 4.5*Step_1 )  RTyz( 5*15,-R1) translate<0, 4.5*Step_1*N,0> }  
   object{ Block ( - 5.5*Step_1 )  RTyz( 6*15,-R1) translate<0, 5.5*Step_1*N,0> }  
   object{ Block ( - 6.5*Step_1 )  RTyz( 7*15,-R1) translate<0, 6.5*Step_1*N,0> }  
   object{ Block ( - 7.5*Step_1 )  RTyz( 8*15,-R1) translate<0, 7.5*Step_1*N,0> }  
   object{ Block ( - 8.5*Step_1 )  RTyz( 9*15,-R1) translate<0, 8.5*Step_1*N,0> }  
   object{ Block ( - 9.5*Step_1 )  RTyz(10*15,-R1) translate<0, 9.5*Step_1*N,0> }  
   object{ Block ( -10.5*Step_1 )  RTyz(11*15,-R1) translate<0,10.5*Step_1*N,0> }  
   object{ Block ( -11.5*Step_1 )  RTyz(12*15,-R1) translate<0,11.5*Step_1*N,0> }  
   object{ Block ( -12.5*Step_1 )  RTyz(13*15,-R1) translate<0,12.5*Step_1*N,0> }  
   object{ Block ( -13.5*Step_1 )  RTyz(14*15,-R1) translate<0,13.5*Step_1*N,0> }  
   object{ Block ( -14.5*Step_1 )  RTyz(15*15,-R1) translate<0,14.5*Step_1*N,0> }  
   object{ Block ( -15.5*Step_1 )  RTyz(16*15,-R1) translate<0,15.5*Step_1*N,0> }  
   object{ Block ( -16.5*Step_1 )  RTyz(17*15,-R1) translate<0,16.5*Step_1*N,0> }  
 #end //  #if ( Blocks_ON = 1 )
 rotate<0,180,0> 
 RTyz(-2*15, R1 )     
} // end  western curve 
 

union{ // simple  station 
 // starting at western end: 
 object{ SW_L( SD_1)  rotate<0,0,0>                           translate< 0*L111 ,0,0> } 
 object{ T_R9_15  Rotate_Around_Trans(<0,-1*15,0>,<0,0, R9>)  translate< 0*L111 ,0,0>}  
 object{ T_111        rotate<0,0,0>                           translate< 1*L111 ,0,0> } 

 object{ T_055       rotate<0,0,0>   translate< 2*L111 ,0, 1*Track_Distance> } 
 object{ T_055       rotate<0,0,0>   translate< 2*L111 ,0, 0> } 
 
 object{ SW_R( SD_2)  rotate<0,0,0>   translate< 2*L111+1*L055 ,0, 1*Track_Distance> } 
 object{ T_111        rotate<0,0,0>   translate< 2*L111+1*L055 ,0, 0> } 

 object{ T_111        rotate<0,0,0>   translate< 3*L111+1*L055 ,0, 1*Track_Distance> } 
 object{ SW_R( SD_2)  rotate<0,180,0> translate< 4*L111+1*L055 ,0, 0> } 

 RTyz(-2*15, R1 )      
} //   

union{ // eastern curve
 object{ Track_Up_00 ("T_R1_15", Step_2/2,1) RTyz( 0*15,-R1) translate<0, 0.0*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 1*15,-R1) translate<0, 0.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 2*15,-R1) translate<0, 1.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 3*15,-R1) translate<0, 2.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 4*15,-R1) translate<0, 3.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 5*15,-R1) translate<0, 4.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 6*15,-R1) translate<0, 5.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 7*15,-R1) translate<0, 6.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 8*15,-R1) translate<0, 7.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz( 9*15,-R1) translate<0, 8.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(10*15,-R1) translate<0, 9.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(11*15,-R1) translate<0,10.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(12*15,-R1) translate<0,11.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(13*15,-R1) translate<0,12.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(14*15,-R1) translate<0,13.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(15*15,-R1) translate<0,14.5*Step_2*N,0> }  
 object{ Track_Up_00 ("T_R1_15", Step_2,  0) RTyz(16*15,-R1) translate<0,15.5*Step_2*N,0> }  
 #if ( Blocks_ON = 1 )
   object{ Block ( - 0.5*Step_1 )  RTyz( 1*15,-R1) translate<0, 0.5*Step_1*N,0> }  
   object{ Block ( - 1.5*Step_1 )  RTyz( 2*15,-R1) translate<0, 1.5*Step_1*N,0> }  
   object{ Block ( - 2.5*Step_1 )  RTyz( 3*15,-R1) translate<0, 2.5*Step_1*N,0> }  
   object{ Block ( - 3.5*Step_1 )  RTyz( 4*15,-R1) translate<0, 3.5*Step_1*N,0> }  
   object{ Block ( - 4.5*Step_1 )  RTyz( 5*15,-R1) translate<0, 4.5*Step_1*N,0> }  
   object{ Block ( - 5.5*Step_1 )  RTyz( 6*15,-R1) translate<0, 5.5*Step_1*N,0> }  
   object{ Block ( - 6.5*Step_1 )  RTyz( 7*15,-R1) translate<0, 6.5*Step_1*N,0> }  
   object{ Block ( - 7.5*Step_1 )  RTyz( 8*15,-R1) translate<0, 7.5*Step_1*N,0> }  
   object{ Block ( - 8.5*Step_1 )  RTyz( 9*15,-R1) translate<0, 8.5*Step_1*N,0> }  
   object{ Block ( - 9.5*Step_1 )  RTyz(10*15,-R1) translate<0, 9.5*Step_1*N,0> }  
   object{ Block ( -10.5*Step_1 )  RTyz(11*15,-R1) translate<0,10.5*Step_1*N,0> }  
   object{ Block ( -11.5*Step_1 )  RTyz(12*15,-R1) translate<0,11.5*Step_1*N,0> }  
   object{ Block ( -12.5*Step_1 )  RTyz(13*15,-R1) translate<0,12.5*Step_1*N,0> }  
   object{ Block ( -13.5*Step_1 )  RTyz(14*15,-R1) translate<0,13.5*Step_1*N,0> }  
   object{ Block ( -14.5*Step_1 )  RTyz(15*15,-R1) translate<0,14.5*Step_1*N,0> }  
   object{ Block ( -15.5*Step_1 )  RTyz(16*15,-R1) translate<0,15.5*Step_1*N,0> }  
   object{ Block ( -16.5*Step_1 )  RTyz(17*15,-R1) translate<0,16.5*Step_1*N,0> }  
 #end //  #if ( Blocks_ON = 1 )

// rotate<0,180,0> 
 translate<4.5*L111,0,0>
 RTyz(-2*15, R1 )     
} // end  eastern curve 

union{ // cross line southeast to northwest
 object{ Track_Up_00 ("T_111", Step_1  , 0)  translate< 0*L111, 0.0*Step_2*N,0> }  
 object{ Track_Up_00 ("T_111", Step_1/2, 2)  translate< 1*L111, 1.0*Step_2*N,0> }  
 object{ T_Straight( 0.062*N )               translate< 2*L111 ,1.5*Step_2*N,0> } 

 object{ Track_Up_00 ("T_111",-Step_1/2, 1)  translate< 2*L111+0.062*N ,1.5*Step_2*N,0> } 
 object{ Track_Up_00 ("T_111",-Step_1  , 0)  translate< 3*L111+0.062*N, 1.0*Step_2*N,0> }  

 #if ( Blocks_ON = 1 )
   object{ Block ( - 17.25*Step_1 )   translate<0.5*L111, 0.5*Step_1*N,0> }  
   object{ Block ( - 17.50*Step_1 )   translate<  1*L111, 1.0*Step_1*N,0> }  
   object{ Block ( - 17.75*Step_1 )   translate<1.5*L111, 1.33*Step_1*N,0> }  
  //object{ Block ( - 18.0*Step_1 )    translate<  2*L111, 1.5*Step_1*N,0> }  

   object{ Block ( - 18.00*Step_1 )    translate<  2*L111+0.062*N, 1.5*Step_1*N,0> }  
   object{ Block ( - 17.75*Step_1 )    translate<2.5*L111+0.062*N, 1.25*Step_1*N,0> }  
   object{ Block ( - 17.50*Step_1 )    translate<  3*L111+0.062*N, 1.0*Step_1*N,0> }  
   object{ Block ( - 17.25*Step_1 )    translate<3.5*L111+0.062*N, 1.0*Step_1*N,0> }  
 #end //  #if ( Blocks_ON = 1 )



 rotate<0,180+1.0,0> 
 translate<0, 16.5*Step_1*N,0> 
 RTyz( 15*15, R1 )
} // end  cross line southeast to northwest


 Rotate_Around_Trans(<0,-1*7.5,0>,<0,0,R1>)
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------// 
translate< R1 + 0.035*N, (Simulate_On = -1)*0.0025*N , 0.035*N> // Global Start Position
} // end rail tracks union


// The Axes 
object{ AxisXYZ( 10,  5.5, 10.5, Texture_A_Dark, Texture_A_Light) scale 160/100*2 no_shadow}

// Your name
text { ttf "arialbd.ttf",
       concat(chr(169)," Friedrich A. Lohm",chr(252),"ller, 2011")
       , 0.001, 0.0   // thickness, offset
       scale<1, 0.9,-1>
       matrix< 1  , 0, 0, // matrix-shear_y_to_x
               0.2, 1, 0,
               0  , 0, 1,
               0  , 0, 0>
       texture{ pigment{color <1,0.95,0.5>*0.1}  //rgb<1,1,1>*0.0}
                finish {ambient 1 diffuse 0.0 specular 0 }
              } // end of texture
       rotate<90,0,0> 
       scale 3
       translate<0.81*N,0,0.005*N>
      }// end text object

// Base_Plate   
box{ < 0,-0.02,0.00>,<1.10,0,0.45> scale  160 // plane with layered textures

        texture { pigment{color White*1.3}
                 // finish {ambient 0.45 diffuse 0.85}
                }

        // 1 cm raster -----------------
     //   texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
     //   texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
       // 10 cm raster -----------------
        texture { Raster2(RasterScale2,RasterHalfLine2) rotate<0,0,0> }
        texture { Raster2(RasterScale2,RasterHalfLineZ2)  rotate<0,90,0>}

        rotate<0,0,0>
      }
 
} // end global scene union --------------------------------------------------------------- end of scene + raster plate + axes
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//

object{  Scene  } 
 
object{  Scene scale 0.94 rotate<0,-30,0> rotate<67,0,0> translate<0.205*N,-0.20*N,0.47*N>} 


//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//

















