// POV-Ray 3.7 Scene File "Seven_Segment_LCD_run02.pov"
// author: Friedrich A. Lohmueller, May-2009/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
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
//-------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.50,-5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.50, 0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 1.80,-0.30,-1.50> ;  // diagonal up view
  #declare Camera_Look_At  = < 0.55, 0.43, 0.00> ;
  #declare Camera_Angle    =  38 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" ------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ // ultra_wide_angle
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
// sun --------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky --------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


#declare Active_Texture = 
//    texture { pigment{ color rgb< 1, 0.0, 0>*1.2 } //  color Red
//    texture { pigment{ color rgb< 0.25, 0.5, 0>*1.7  } //  color Green
  texture { pigment{ color rgb< 1, 1, 1>*1.1  } //  color White
                   finish { ambient 0.9 diffuse 0.1 phong 1}
              } // end of texture 
#declare Inactive_Texture = 
    texture { pigment{ color rgb< 1, 1, 1>*0.35 } //  color gray
                   finish { phong 1 reflection 0.00}
              } // end of texture 
#declare Background_Texture =
    texture { pigment{ color rgb< 1, 1, 1>*0.05 } //  color nearly black
                   finish { phong 1 reflection 0.1}
              } // end of texture 

//----------------------------------------------------------------------------
#declare Number = frame_number*3; //0~99

#declare Num_10 = int ( Number/10);
#declare Num_1  = int ((Num_10*10)/1);

#if(Num_10=0) #declare Num_10=99; #end

//----------------------------------
#include "Seven_Segment_LCD.inc"
//----------------------------------
union{
 object{ Seven_Segment_LCD( 
         
         Num_10, // 0~9, integer!
         10, // shearing angle
         < 1.75, 10, 1.40>, //
         Active_Texture,  
         Inactive_Texture,  
         Background_Texture,  
         1, // SS_Point_On, 
         0, // SS_Point_Active, 
         ) //-----------------------
         scale 0.09
         translate< 0.51,0.05,0>
       } // ------------------------
 object{ Seven_Segment_LCD( 
         
         Num_1,// 0~9, integer! 
         10, // shearing angle
         < 1.75, 10, 1.40>, //
         Active_Texture,  
         Inactive_Texture,  
         Background_Texture,  
         1, // SS_Point_On, 
         0, // SS_Point_Active, 
         ) //------------------------
         scale 0.09
         translate< 3*0.51,0.05,0>
       } // ------------------------- 
 scale 0.5
 rotate<-90,0,0>
 translate< 0, 0.4,0>
} // end union ----------------------
//-----------------------------------end

 