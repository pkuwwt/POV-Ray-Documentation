// POV-Ray 3.6 / 3.7 include file "RT_Track_Curve_00.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, Nov-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_Track_Curve_00_Inc_Temp)
#declare RT_Track_Curve_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"
#end

//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Curve_00 ( Rail___Radius_,  // in x+ in meter
                           Bow___Angle_,    // in degrees
                           Ties_Per_Meter_  // ~1.5, // number per meter
                         ) //--------------------------------------------------- 
//------------------------------------------------------------- default textures 

#ifndef( RailToptex ) 
#declare RailToptex = texture{ Polished_Chrome pigment{quick_color White} }
#end
#ifndef( Railtex1 ) 
#declare Railtex1   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                              pigment{color Tan*0.5}}
#end
#ifndef( Railtex2 ) 
#declare Railtex2   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                               pigment{color Tan*0.4}}
#end
#ifndef( Tietex1 ) 
#declare Tietex1    = texture{ pigment{ color DarkWood*0.95 quick_color Tan}
                               normal { bumps 0.5 scale 0.005 scale<1,10,30>}
                               finish { diffuse 0.85}}
#end
#ifndef( Tietex2 ) 
#declare Tietex2    = texture{ pigment{ color DarkWood quick_color Tan}
                               normal { bumps 0.55 scale 0.005 scale<1,1,10>}
                               finish { diffuse 0.88}}
#end
#ifndef( Tietex3 ) 
#declare Tietex3    = texture{ pigment{ color DarkWood*0.9 quick_color DarkTan}
                               normal { bumps 0.75 scale 0.005 scale<1,1,10>}}
#end
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------- Gauche & Heigth
#ifndef (           RT_System_Sizes_00_Inc_Temp )
#include "RT_System/RT_System_Sizes_00.inc"
#end 
//------------------------------------------------------------------------ 
#local D = 0.00001;
//---------------------------------------------------------------------------------------- 
#local RailRadius = Rail___Radius_; 
#if (RailRadius < 0 ) #local RailRadius = -RailRadius; #end

#local BowAngle   = Bow___Angle_; 
//---------------------------------------------------------------------------------------- 
 
#ifndef ( Rail_Spikes_On )
#declare Rail_Spikes_On = 0; 
#end //----------------------------------------------------------------------------------
#if( Rail_Spikes_On = 1 ) 

#local Spike_Big  = 
union{ 
  object{ Hexagon scale <0.5,1,1> translate<0.5,0,0> rotate<0,0,90> scale<1,1,1>*0.05 texture{Railtex1} translate<0,0.020,0>} 
  cone{<0,0.020,>,0.06,<0,0.01,0>,0.085  texture{Railtex1} }
  cylinder{<0,0.01,0>,<0,0,0.00>,0.085   texture{Railtex2} }
  cylinder{<0,0.085,0>,<0,-0.035,0>,0.02 texture{Railtex2} } 
  // pigment{Cyan}
 scale <1,1,1>*0.60  
} // end uni -----------------------------------------------
#local Spike_Small  = 
union{    // in y+ !!!
  box{<-1,0,-1>,<1,1.5,1>            scale<1,1,1>*0.030  texture{Railtex1} translate<0,0.020,0> }  
  box{<-1+D,0,-1+D>,<1-D,1.5+D,1-D>  scale<1,1,1>*0.030  texture{Railtex2} translate<0,0.020,0> }  
  cone{<0,0.020,>,0.06,<0,0.01,0>,0.085  texture{Railtex1} }
  cylinder{<0,0.01,0>,<0,0,0.00>,0.085   texture{Railtex2} }
 scale <1,1,1>*0.40 
} // end uni ----------------------------------------------- 
#local Rail_Spike = 
union{ 
       box{<-0.10,         0,-RBaT-0.02 >,<0.10,RBaH+0.002,-RBaT-0.15> texture{Railtex2} } 
       box{<-0.06,RBaH+0.002,-RBaT+0.05 >,<0.06,RBaH+0.022,-RBaT-0.08> texture{Railtex2} }  
       object{  Spike_Big   translate<0,RBaH+0.023,-RBaT-0.035> } 
       object{  Spike_Small rotate<0, 14,0> translate< 0.05,RBaH+0.0025,-RBaT-0.12> } 
       object{  Spike_Small rotate<0,-40,0> translate<-0.05,RBaH+0.0025,-RBaT-0.12> } 
     } // end uni 

#end // of #if( Rail_Spikes_On = 1 ) 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// Number and distance of the ties/sleepers - Anzahlen und Abstand der Schwellen:
#local Ties_Number_ = int(RailRadius*pi*abs(BowAngle)/180*Ties_Per_Meter_) ; // Ties between angel (center to center)
#local Ties_Angle =  BowAngle/Ties_Number_; // 
// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------- Ties - Schwellen 
#local Tie = union{
 box {<-SD/2+D,0  ,-SB+D>,< SD/2-D,SH  ,SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-SB+D>,< SD/2  ,SH-D,SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-SB  >,< SD/2-D,SH-D,SB  > texture{Tietex3}}
 #if ( Rail_Spikes_On = 1 )
 object{ Rail_Spike translate<0,SH,-RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH,-RB>}
 object{ Rail_Spike  translate<0,SH, RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH, RB>}
 #end 
}
//--------------------------------------------------------------- Round Rails submacros
//---------------------------- macro symmetrisches Cylinder-Segment_Y: "C_Seg(Ra,Ri,H,W)"----<< 
#macro C_Segment (Radius_aussen, Radius_innen, Hoehe, Segment_Winkel)  
#local D = 0.001;
// needs: #include "shapes_lo.inc"
//#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
object{ Segment_of_CylinderRing ( Radius_aussen, Radius_innen, Hoehe, Segment_Winkel)
        rotate<0,-90,0> rotate<0,0,0>  
        translate<0,0,0>
} #end //----------------------------<<<<<<<<
//-------------------------------------- macro symmetrisches Torus-Segment_Y: "T_Seg(Ra,Ri,YScale,W)"----<< 
#macro T_Segment (Radius_major, Radius_minor, YScale, Segment_Winkel)  
#local D = 0.001;
// needs: #include "shapes_lo.inc"
// #macro Segment_of_Torus( R_major, R_minor, Segment_Angle)
object{ Segment_of_Torus( Radius_major, Radius_minor, Segment_Winkel) scale <1,YScale,1>
        rotate<0,-90,0> rotate<0,0,0>  
}#end //----------------------------<<<<<<<<
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
union{ // 1                                        
 union{  // 2
    union{ // 3
             object{ T_Segment (RailRadius-RB, RToR, RToS, BowAngle) texture {RailToptex pigment{quick_color Red}}}  
             object{ T_Segment (RailRadius+RB, RToR, RToS, BowAngle) texture {RailToptex pigment{quick_color Red}}}  
            // verical part of head - senkrechter Teil des Kopfes
             object{C_Segment (RailRadius-RB+RToR, RailRadius-RB-RToR, 0.02, BowAngle) translate<0,-0.02,0> texture {Railtex2}}
             object{C_Segment (RailRadius+RB+RToR, RailRadius+RB-RToR, 0.02, BowAngle) translate<0,-0.02,0> texture {Railtex2}}
            // lower round part of head - unterer runder Kopfteil
             object{ T_Segment (RailRadius-RB, RToR, RToS, BowAngle) translate<0,-0.02,0> texture {Railtex2}}  
             object{ T_Segment (RailRadius+RB, RToR, RToS, BowAngle) translate<0,-0.02,0> texture {Railtex2}}  

             translate<0,RBoH,0>
         } // 3
      
        // vertical parts 
        object{C_Segment (RailRadius-RB+RBoT, RailRadius-RB-RBoT, RBoH, BowAngle) texture {Railtex1}}
        object{C_Segment (RailRadius+RB+RBoT, RailRadius+RB-RBoT, RBoH, BowAngle) texture {Railtex1}}

        object{C_Segment (RailRadius-RB+RBaT, RailRadius-RB-RBaT, RBaH, BowAngle) texture {Railtex2}}
        object{C_Segment (RailRadius+RB+RBaT, RailRadius+RB-RBaT, RBaH, BowAngle) texture {Railtex2}}

        translate <0,SH,0>
      } // 2 union without ties
 #local Nr = 0;     // start
 #while (Nr< Ties_Number_) 
 object{ Tie translate<0,0,RailRadius>  rotate<0,(Nr+0.5) * Ties_Angle,0>} 
 #local Nr = Nr + 1;  #end // ---------------  end of loop 



translate<0,0,-RailRadius>
} // 3 end of union  with ties/sleepers
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro
//---------------------------------------------------------------------------------------





//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------//
#include "RT_System/RT_Track_Curve_00.inc"  // right curve in x     
//-------------------------------------------------------------------------------------// 
//#declare Rail_Spikes_On = 1;
object{ RT_Track_Curve_00( 20.00, // Rail_Radius_,  // in x+ in meter
                           30,    // Bow_Angle_,    // in degrees
                           1.5,   // Ties_Per_Meter_  // ~1.5, // number per meter
                         ) //----------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>
      } //-----------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RT_Track_Curve_00_Inc_Temp;
#end
//------------------------------------- end of include file

