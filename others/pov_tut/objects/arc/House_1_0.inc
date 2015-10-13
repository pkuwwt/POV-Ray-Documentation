// POV-Ray 3.6/3.7 include file "House_1_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, update Feb-2007, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( House_1_0_Inc_Temp)
#declare House_1_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Window_1_Inc_Temp)
#include "Window_1.inc"                                             
#end
#ifndef(  Door_1_Inc_Temp)
#include "Door_1.inc"                                             
#end
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- /////////  
#macro House_1_0 (  Half_House_Width_X, // >= 2.00
                    Total_House_Width_Z,// >= 2.00
                    House_Height_Y,     // >= 2.00
                    Roof___Angle, // ca. 10 ~ 60 degrees
                      
                    Wall___Texture_Outside
                    Wall___Texture_Inside 
                    Window___Texture
                    Roof___Texture
                 ) //-------------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------

#local Socket___Height = 0.20; 
#local Hx = Half_House_Width_X;
#local Hy = House_Height_Y-Socket___Height;
#local Hz = Total_House_Width_Z;

#local Wall_D = 0.20 ;// the thickness of the Wall 
#local Roof_D = 0.10; // the thickness of the roof
#local Roof_O = 0.20; // overhang 


#local Roof_Y = (Hx + Roof_O) * tan( radians(Roof___Angle)); // !!! 
#local Roof_L = sqrt( pow(Roof_Y,2) +pow(Hx + Roof_O,2)); // !!! 

// ---------------------------------------------------- Window_Positions
// front positions 
#local Window_Positon_1f = <-Hx/2,0,Wall_D/3>;
#local Window_Positon_2f = < Hx/2,0,Wall_D/3>;
// backside positions
#local Window_Positon_1b = <-Hx/2,0,Hz-Wall_D/3>;
#local Window_Positon_2b = < Hx/2,0,Hz-Wall_D/3>;
// right side positions
#local Window_Positon_1r = < Hx-Wall_D/3,0,3*Hz/4>;
#local Window_Positon_2r = < Hx-Wall_D/3,0,  Hz/4>;
// left side positions
#local Window_Positon_1l = <-Hx+Wall_D/3,0,3*Hz/4>;
#local Window_Positon_2l = <-Hx+Wall_D/3,0,  Hz/4>;
// ------------------------------------------------- end of Window_Positions
// --------------------------------------------------------------------------------------
// #include "Window_1.inc"                                             
// #include "Door_1.inc"                                             
// --------------------------------------------------------------------------------------
#local Window_o     = object{ Window_1      texture{ Window___Texture }}
#local Window_Hole  = object{ Window_1_Hole texture{ Wall___Texture_Outside }}
#local Door_        = object{ Door_1        texture {Window___Texture }}
#local Door_Hole    = object{ Door_1_Hole   texture{ Wall___Texture_Outside }}
// --------------------------------------------------------------------------------------
union{  // global union of the house with socket
 union{  //  union of the house


// the walls caved out ----------------------- the Walls
difference{
box { <-Hx,0,0>,< Hx,Hy,Hz> texture {Wall___Texture_Outside} } 

plane{ <0,-1,0>,0           texture { Wall___Texture_Outside}  
       rotate<0,0,Roof___Angle> 
       translate<0,Hy,0>
     }

plane{ <0,-1,0>,0           texture {Wall___Texture_Outside}  
       rotate<0,0,-Roof___Angle>
       translate<0,Hy,0>
     }

 // inside caved out
box { <-Hx+Wall_D,0.10,Wall_D>,
      <Hx-Wall_D,Hy,Hz-Wall_D>  
      texture {Wall___Texture_Inside}  
     }
// subtract window holes
object{ Door_Hole   translate Window_Positon_1f}
object{ Window_Hole translate Window_Positon_2f}

object{ Window_Hole translate Window_Positon_1r}
object{ Window_Hole translate Window_Positon_2r}

object{ Window_Hole translate Window_Positon_1l}
object{ Window_Hole translate Window_Positon_2l}

object{ Window_Hole translate Window_Positon_1b}
object{ Window_Hole translate Window_Positon_2b}
 

}// end of intersection  ------------------------- end of Walls


// the Roof 
box { < -Roof_L, 0.00, -Roof_O>,< Roof_D/2, Roof_D, Hz+Roof_O>  
      texture {Roof___Texture translate<-0.05,0,0>}  
      rotate<0,0, Roof___Angle>
      translate<0,Hy,0>
     }
box { < -Roof_L, 0.00, -Roof_O>,< Roof_D/2, Roof_D, Hz+Roof_O>  
      texture {Roof___Texture translate<-0.05,0,0>}  
      rotate<0,0, Roof___Angle>
      translate<0,Hy,0> scale<-1,1,1>
     }
//------------------------------------------------- end of Roof

//----------------------------------------------- Windows
object{ Door_   translate Window_Positon_1f}
object{ Window_o translate Window_Positon_2f}
object{ Window_o rotate<0,180,0> translate Window_Positon_1b}
object{ Window_o rotate<0,180,0> translate Window_Positon_2b}
object{ Window_o rotate<0,-90,0> translate Window_Positon_1r}
object{ Window_o rotate<0,-90,0> translate Window_Positon_2r}
object{ Window_o rotate<0, 90,0> translate Window_Positon_1l}
object{ Window_o rotate<0, 90,0> translate Window_Positon_2l}
//
translate<0,Socket___Height,0>
} // end of union "House without socket"
// Socket
box{ <-Hx+0.02,0,0+0.02>,<Hx-0.02,Socket___Height,Hz-0.02> 
     texture{ pigment{ color  rgb<1,1,1>*0.7 }
              normal { bumps 0.5 scale 0.005 }
            }  
   } // end of box "socket"
box{ <-0.55,0,-0.35>,<0.55,Socket___Height-0.02,0.02> 
     texture{ pigment{ color  rgb<1,1,1>*0.9 }
              normal { bumps 0.5 scale 0.005 }
            }  
     translate Window_Positon_1f
   } // end of box "socket"

} // end of global union 


// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Wall_Texture_Outside = 
      texture { pigment{ color White*1.1}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              } // end of texture
//--------------------------------------------------------
#declare Wall_Texture_Inside = 
      texture { pigment{ color White*1.1}
                finish { phong 1}
              } // end of texture
//--------------------------------------------------------
#declare Roof_Texture = 
// layered texture!!!
      texture { pigment{ color Scarlet*1.3}
                normal { gradient z scallop_wave scale<1,1,0.15>} 
                finish { phong 1}
              } // end of texture
 
      texture { pigment{ gradient x 
                         color_map{[0.00 color Clear]
                                   [0.90 color Clear]
                                   [0.95 color White*0.1]
                                   [1.00 color White*0.1]}
                          scale 0.25}
                 finish { phong 1}
              } // end of texture

//--------------------------------------------------------
#declare Window_Texture = 
         texture{ pigment{ color White*1.2}
                  finish { phong 0.1}}
//----------------------------------------------------------------------------------------
#//---------------------------------------------------------------------------------------
#include "House_1_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ House_1_0(  2.00, // Half_House_Width_X, // >= 2.00
                    4.00, // Total_House_Width_Z,// >= 2.00
                    3.50, // House_Height_Y,     // >= 2.00
                    38,   // Roof___Angle, // ca. 10 ~ 60 degrees
                      
                    Wall_Texture_Outside
                    Wall_Texture_Inside 
                    Window_Texture
                    Roof_Texture
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version House_1_0_Inc_Temp;
#end
//------------------------------------- end of include file

