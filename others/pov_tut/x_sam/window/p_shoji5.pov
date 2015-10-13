// POV-Ray 3.6 / 3.7 Scene File "p_shoji5.pov"
// author: Friedrich A. Lohmueller, 2003/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

global_settings { noise_generator 1 }
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"

// camera -----------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 60
                            location  <0.0 , 1.0 ,-4.0>
                            right x*image_width/image_height
                            look_at <0.0 , 1.2 , 0.0>}
camera{Camera_0} 

// ---------------------------------------------------------------------------------
#declare  Shoji_On = 1;


// sun -----------------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ----------------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76 translate <-2,0,0>
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog ----------------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.5
    turbulence 0.8}
// ground -------------------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>}
	         normal { bumps 0.5 scale 0.01}
                 finish { phong 0.1}
               } // end of texture
      } // end of plane
//---------------------------------------------------------------------------------
//---------------------------- objects in scene -----------------------------------
//---------------------------------------------------------------------------------

#declare Shoji_WoodTX  = texture{ pigment{ color LightWood*1.5 quick_color White}
                                  finish { phong 1}}
#declare Shoji_WoodTY  = texture{ pigment{ color LightWood*1.5 quick_color White}
                                  finish { phong 1}}
#declare Shoji_M = material{texture {pigment{ color White filter 0.27 quick_color White}
                                     normal { bumps 0.1 scale 0.002}
                                     finish { phong 0.5}
                                     }
                             interior{caustics 0.002
                                     }           
                            }// end of material

#declare WindowFrameTex = texture{ pigment{ color rgb <0.85,0.6,0.4>*1.1 quick_color LightWood}
                                   finish {  phong 0.5}}



#declare Lo_Window_Glass =
 material{ texture {pigment {color White filter 0.85}
                    finish  {Shiny ambient 0 diffuse 0 reflection 0.15} }
           interior{caustics 0.02 }           
                            }// end of material

#macro HortS(Dx,Dy,Dz)
#local D = 0.0001;
union{
 box {<D,D,D>,< Dx-D,Dy-D,Dz  > texture{Shoji_WoodTX}}
 box {<D,D,D>,< Dx-D,Dy  ,Dz-D> texture{Shoji_WoodTY}}
} #end // -----------------------------------------------

#macro HortSD(Dx,Dy,Dz)
#local D = 0.0001;
union{
 box {<D,D,-Dz  >,< Dx-D,Dy-D,Dz  > texture{Shoji_WoodTX}}
 box {<D,D,-Dz+D>,< Dx-D,Dy  ,Dz-D> texture{Shoji_WoodTY}}
} #end // -----------------------------------------------

 

#macro Shoji(WideX,WideY,XNr,YNr) 
#local D = 0.0001;
union{
box {<D+0.01,D+0.01,0.010>,<WideX-D-0.01,WideY-D-0.01,0.011> material{Shoji_M}}
#local Nr = 0;     // start
#local EndNr = YNr; // end
#while (Nr< EndNr+1) 
   object{HortS(WideX-2*D,0.01,0.01) translate<D,Nr*(WideY-1*0.01)/EndNr,0>} 
 #local Nr = Nr + 1;    
#end // --------------- loop-end 
#local Nr = 0;     // start
#local EndNr = XNr; // end
#while (Nr< EndNr+1) 
   object{HortS(0.01,WideY-2*D,0.01) translate<Nr*(WideX-1*0.01)/EndNr,D,0>} 
 #local Nr = Nr + 1;    
#end // --------------- loop-end 
}// end of union
#end  //of Shoji - singlesided sliding-door - macro ------------------------------


#macro Window1(WideX, WideY,FrameXY,FrameZ)
#local D= 0.0001;
union{
//box {<D,D,-0.002>,<WideX-D,WideY-D,0.002> material{Lo_Window_Glass}}
box {<D,            0,-FrameZ>,<WideX-D,FrameXY,FrameZ>texture{WindowFrameTex}}
box {<D,WideY-FrameXY,-FrameZ>,<WideX-D,  WideY,FrameZ>texture{WindowFrameTex}}
box {<            0,D,-FrameZ>,<FrameXY,WideY,FrameZ>texture{WindowFrameTex}}
box {<WideX-FrameXY,D,-FrameZ>,<  WideX,WideY,FrameZ>texture{WindowFrameTex}}
} // end of union
#end //  of Window1 macro



#macro Frame(Wide_X,Wide_Y,Frame_XY,Frame_Z,X_Nr,Y_Nr)
union{ 
 object{  Shoji(Wide_X-2*Frame_XY,Wide_Y-2*Frame_XY,X_Nr,Y_Nr) translate<Frame_XY,Frame_XY,Frame_Z*3/4>}
 object{Window1(Wide_X,Wide_Y,Frame_XY,Frame_Z)  }
}
#end //---------------------------------------------------------------------------------------------------

#declare Win_D   = 0.01;

#macro Paravent_3( Wide_x, Wide_y, Frame_xy, Frame_z, X_n, Y_n, Angle1, Angle2) 
#local Win_D = Frame_z/2;
union{
 object{ Frame (Wide_x, Wide_y, Frame_xy, Frame_z, X_n, Y_n)}
  union{ object{ Frame (Wide_x, Wide_y, Frame_xy, Frame_z, X_n, Y_n)}
         object{ Frame (Wide_x, Wide_y, Frame_xy, Frame_z, X_n, Y_n)
                 translate<Win_D,0,0> rotate<0,Angle1,0> translate<Wide_x+Win_D,0,0>}
         translate<Win_D,0,0> rotate<0,Angle2,0> translate<Wide_x+Win_D,0,0>}   
} #end //------------------------------------------------------------------------------------------------

object{ Paravent_3 (0.80,2.00,0.05,0.02, 6, 8, 50, -50)         
        scale<1,1, 1> rotate<0,  20,0> translate<-1.25,0.2,-1>}

//----------------------------------------------------------------------------------------------------end


