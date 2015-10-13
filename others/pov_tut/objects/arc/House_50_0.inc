// POV-Ray 3.6/3.7 include file "House_50_0.inc" 
// author: Friedrich A, Lohmueller, Feb-2007, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//---------------------------------------------------------------------------------------
#ifndef( House_50_0_Inc_Temp)
#declare House_50_0_Inc_Temp = version;
#version 3.6;
//---------------------------------------------------------------------------------------
#ifndef(  Window_2_Inc_Temp)
#include "Window_2.inc"                                             
#end
#ifndef(  Door_1_Inc_Temp)
#include "Door_1.inc"                                             
#end
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- /////////  
#macro House_50_0(  Half_House_Width_X  , // >= 2.00
                    Total_House_Width_Z , // >= 2.00
                    House_Height_Y      , // >= 2.00
                    Roof___Angle        , // ca. 10 ~ 60 degrees

                    Window_Open___Frontside_1, //left  0=closed  ~ 1=open 
                    Window_Open___Frontside_2,//middle 0=closed  ~ 1=open 
                    Window_Open___Frontside_3, //right 0=closed  ~ 1=open 
                    Window_Open___Backside_1 , //left  0=closed  ~ 1=open 
                    Window_Open___Backside_2 ,//middle 0=closed  ~ 1=open 
                    Window_Open___Backside_3 , //right 0=closed  ~ 1=open 
                    Window_Open___RightSide_1, //back  0=closed  ~ 1=open 
                    Door_Open___Rightside_2  ,//middle 0=closed  ~ 1=open 
                    Window_Open___RightSide_3, //front 0=closed  ~ 1=open 
                    Window_Open___LeftSide_1 , //back  0=closed  ~ 1=open 
                    Window_Open___LeftSide_2 ,//middle 0=closed  ~ 1=open 
                    Window_Open___LeftSide_3 , //front 0=closed  ~ 1=open 

                    Wall___Texture_Outside ,
                    Wall___Texture_Inside  ,
                    Window___Texture       ,
                    Roof___Texture         , 
                    Base___Texture         ,
                    Veranda___Texture      ,
                    Veranda_Beam___Texture1  ,
                    Veranda_Beam___Texture2 

                 ) //-------------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------

#local Socket___Height = 0.45; 
#local Hx = Half_House_Width_X;
#local Hy = House_Height_Y-Socket___Height;
#local Hz = Total_House_Width_Z;

#local Veranda_X = Hx/2; 

#local Ry = Hx * tan(radians(Roof___Angle)); 
#local Beam_R = 0.06; 
#local Beam_H = 0.07; 
#local Reeling_H = 0.70; 
#local Beam_X_len = Veranda_X-3*Beam_R; 
#local VR_z = ((Hz-Beam_R)/5 - Beam_R ) ;   

#local Wall_D = 0.20 ;// the thickness of the Wall 
#local Roof_D = 0.05; // the thickness of the roof
#local Roof_O = 0.20; // overhang 


#local Roof_Y = (Hx + Roof_O) * tan( radians(Roof___Angle)); // !!! 
#local Roof_L = sqrt( pow(Roof_Y,2) +pow(Hx + Roof_O,2)); // !!! 
//---------------------------------------------------------------------- Veranda vertical Beams 
#local Beam___Vertical = union{  
box { <-Beam_R+D,0,-Beam_R  >,< Beam_R-D,Hy-Ry, Beam_R  > texture {Veranda_Beam___Texture1}} // + - x 
box { <-Beam_R  ,0,-Beam_R-D>,< Beam_R  ,Hy-Ry, Beam_R+D> texture {Veranda_Beam___Texture2}} // + - z   
}
#local Beam___Horizontal = union{  
 box { <-Beam_R*0.8  , -Beam_H,0  >,< Beam_R*0.8  ,0  , VR_z> texture {Veranda_Beam___Texture1}} // + - x 
 box { <-Beam_R*0.8+D, -Beam_H-D,0>,< Beam_R*0.8-D,0+D, VR_z> texture {Veranda_Beam___Texture2}} // + - y
}
//------------------------------------------------------------------- Veranda_Reeling                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
#local Veranda___Reeling = 
union{ 
object{ Beam___Horizontal translate<0,Hy-Ry-0.25,0>}
object{ Beam___Horizontal translate<0,Reeling_H,0>}
object{ Beam___Horizontal translate<0,2*Beam_H,0>}
union{
 #local Nr = 1;     // start
 #local EndNr = 10; // end
 #while (Nr< EndNr) 
 union{
  box{<-Beam_R*0.25  ,2*Beam_H,-Beam_R*0.65  >,<Beam_R*0.25  ,Reeling_H-Beam_H,Beam_R*0.65  > texture {Veranda_Beam___Texture1}} // + - x
  box{<-Beam_R*0.25+D,2*Beam_H,-Beam_R*0.65-D>,<Beam_R*0.25-D,Reeling_H-Beam_H,Beam_R*0.65+D> texture {Veranda_Beam___Texture2}} // + - z 
      translate<0,0,Nr*(VR_z-Beam_R)/EndNr>} 
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
 } // end of union
 translate<0,0,Beam_R>
}  
//--------------------------------------------------------------------------------

// ---------------------------------------------------- Window_Positions
// front positions 
#local Window_Positon_1f = <-3*Hx/4,0,Wall_D/3>;
#local Window_Positon_2f = <-1*Hx/4,0,Wall_D/3>;
#local Window_Positon_3f = < 1*Hx/4,0,Wall_D/3>;
// backside positions
#local Window_Positon_1b = <-3*Hx/4,0,Hz-Wall_D/3>;
#local Window_Positon_2b = <-1*Hx/4,0,Hz-Wall_D/3>;
#local Window_Positon_3b = < 1*Hx/4,0,Hz-Wall_D/3>;
// right side positions
#local Window_Positon_1r = < Veranda_X-Wall_D/3,0,5*Hz/6>;
#local Window_Positon_2r = < Veranda_X-Wall_D/3,0.01,3*Hz/6>; //door
#local Window_Positon_3r = < Veranda_X-Wall_D/3,0,1*Hz/6>;
// left side positions
#local Window_Positon_1l = <-Hx+Wall_D/3,0,5*Hz/6>;
#local Window_Positon_2l = <-Hx+Wall_D/3,0,3*Hz/6>;
#local Window_Positon_3l = <-Hx+Wall_D/3,0,1*Hz/6>;
// ------------------------------------------------- end of Window_Positions
// --------------------------------------------------------------------------------------
// #include "Window_1.inc"                                             
// #include "Door_1.inc"                                             
// --------------------------------------------------------------------------------------
#macro Window_(Window_Open_) object{ Window_2(Window_Open_) texture{ Window___Texture }} #end
#local Window_Hole         = object{ Window_2_Hole texture{ Wall___Texture_Outside }}  
#local Door_        = object{ Door_1        texture{Window___Texture }}
#local Door_Hole    = object{ Door_1_Hole   texture{Window___Texture }}
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

 // right side veranda caved out
box { <Veranda_X, 0.01,-Wall_D>,
      <Hx+Wall_D,Hy-Ry-0.25-0.001 ,Hz+Wall_D>  
      texture {Wall___Texture_Outside}  
     }
box { <Veranda_X+0.001, 0.009,-Wall_D>, // floor veranda
      <Hx+Wall_D,Hy-Ry-0.25 ,Hz+Wall_D>  
      texture {Veranda___Texture}  
     }


 // inside caved out
box { <-Hx+Wall_D,0.10,Wall_D>,
      <Veranda_X-Wall_D,Hy,Hz-Wall_D>  
      texture {Wall___Texture_Inside}  
     }
// subtract window holes
object{ Window_Hole translate Window_Positon_1f}
object{ Window_Hole translate Window_Positon_2f}
object{ Window_Hole translate Window_Positon_3f}

object{ Window_Hole translate Window_Positon_1r}
object{ Door_Hole   translate Window_Positon_2r} //door
object{ Window_Hole translate Window_Positon_3r}

object{ Window_Hole translate Window_Positon_1l}
object{ Window_Hole translate Window_Positon_2l}
object{ Window_Hole translate Window_Positon_3l}

object{ Window_Hole translate Window_Positon_1b}
object{ Window_Hole translate Window_Positon_2b}
object{ Window_Hole translate Window_Positon_3b}
 

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
object{ Window_(Window_Open___Frontside_1)                 translate Window_Positon_1f}
object{ Window_(Window_Open___Frontside_2)                 translate Window_Positon_2f}
object{ Window_(Window_Open___Frontside_3)                 translate Window_Positon_3f}
object{ Window_(Window_Open___Backside_1 ) rotate<0,180,0> translate Window_Positon_1b}
object{ Window_(Window_Open___Backside_2 ) rotate<0,180,0> translate Window_Positon_2b}
object{ Window_(Window_Open___Backside_3 ) rotate<0,180,0> translate Window_Positon_3b}
object{ Window_(Window_Open___RightSide_1) rotate<0,-90,0> translate Window_Positon_1r}
object{ Door_ translate< 0.50,0,0> 
              rotate<0, -Door_Open___Rightside_2*90,0> 
              translate<-0.50,0,00>         rotate<0,-90,0> translate Window_Positon_2r}  //Door
object{ Window_(Window_Open___RightSide_3) rotate<0,-90,0> translate Window_Positon_3r}
object{ Window_(Window_Open___LeftSide_1 ) rotate<0, 90,0> translate Window_Positon_1l}
object{ Window_(Window_Open___LeftSide_2 ) rotate<0, 90,0> translate Window_Positon_2l}
object{ Window_(Window_Open___LeftSide_3 ) rotate<0, 90,0> translate Window_Positon_3l}

//---------------------------------------------- Veranda pilars

union{ 
object{Beam___Vertical translate<0,0,Beam_R+0.01> } 
object{Beam___Vertical translate<0,0,1*Hz/5-Beam_R*2/3> } 
object{Beam___Vertical translate<0,0,2*Hz/5-Beam_R*1/3> } 
object{Beam___Vertical translate<0,0,3*Hz/5+Beam_R*1/3> } 
object{Beam___Vertical translate<0,0,4*Hz/5+Beam_R*2/3> } 
object{Beam___Vertical translate<0,0,Hz-Beam_R-0.01> } 

 
object{Veranda___Reeling translate<0,0,      +0.01> }
object{Veranda___Reeling translate<0,0,1*Hz/5-Beam_R*2/3> } 
//object{Veranda___Reeling translate<0,0,2*Hz/5-Beam_R*1/3> } 
object{ Beam___Horizontal translate<0,Hy-Ry-0.25,2*Hz/5>}

object{Veranda___Reeling translate<0,0,3*Hz/5+Beam_R*1/3> } 
object{Veranda___Reeling translate<0,0,4*Hz/5+Beam_R*2/3> } 

object{Veranda___Reeling 
       scale<1,1,Beam_X_len/VR_z> rotate<0,-90,0> translate<0,0,Beam_R+0.01> }
object{Veranda___Reeling 
       scale<1,1,Beam_X_len/VR_z> rotate<0,-90,0> translate<0,0,Hz-Beam_R-0.01> }


 

translate<Hx-Beam_R-0.01,0,0> }

// directly at the wall
object{Beam___Vertical translate<Veranda_X+Beam_R-0.00,0,Beam_R+0.01> } 
object{Beam___Vertical translate<Veranda_X+Beam_R-0.00,0,Hz-Beam_R-0.01> } 


//
translate<0,Socket___Height,0>
} // end of union "House without socket"
// Socket
box{ <-Hx+0.02,0,0+0.02>,<Hx-0.02,Socket___Height,Hz-0.02> 
     texture{Base___Texture}  
   } // end of box "socket"
union{ 
box{ <-0.02,0,-0.75 >,<0.25     ,Socket___Height*2/3-0.01,0.75> 
     texture{Base___Texture}}  
box{ <-0.02,0,-0.745>,<0.25-0.01,Socket___Height*2/3,0.745> 
     texture{Veranda___Texture}}  
box{ < 0.25,0,-0.75 >,<0.50     ,Socket___Height*1/3-0.01,0.75> 
     texture{Base___Texture}}  
box{ < 0.25,0,-0.745>,<0.50-0.01,Socket___Height*1/3,0.745> 
     texture{Veranda___Texture}}  

     translate <Hx,0,Hz/2>
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
#include "House_50_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ House_50_0( 3.00, // Half_House_Width_X, // >= 3.00
                    5.00, // Total_House_Width_Z,// >= 4.00
                    3.50, // House_Height_Y,     // >= 3.00
                    18,   // Roof___Angle, // ca. 10 ~ 60 degrees
                    // door and windows open/closed  

                    0.7, //Window_Open_Frontside_1,  left: 0=closed  ~ 1=open 
                    0.7, //Window_Open_Frontside_2,middle: 0=closed  ~ 1=open 
                    0.3, //Window_Open_Frontside_3, right: 0=closed  ~ 1=open 
                    0.2, //Window_Open_Backside_1,  left: 0=closed  ~ 1=open 
                    0.0, //Window_Open_Backside_2,middle: 0=closed  ~ 1=open 
                    0.0, //Window_Open_Backside_3, right: 0=closed  ~ 1=open 
                    0.7, //Window_Open_RightSide_1, back: 0=closed  ~ 1=open 
                    0.5, //Door_Open___Rightside_2,middle: 0=closed  ~ 1=open 
                    0.0, //Window_Open_RightSide_3,front: 0=closed  ~ 1=open 
                    0.3, //Window_Open_LeftSide_1,  back: 0=closed  ~ 1=open 
                    1.0, //Window_Open_LeftSide_2,middle: 0=closed  ~ 1=open 
                    1.0, //Window_Open_LeftSide_3, front: 0=closed  ~ 1=open 
                      
                    Wall_Texture_Outside,
                    Wall_Texture_Inside ,
                    Window_Texture      ,
                    Roof_Texture        ,
                    Base_Texture        ,
                    Veranda_Texture     ,
                    Veranda_Beam_Texture1  ,
                    Veranda_Beam_Texture2 
                  ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version House_50_0_Inc_Temp;
#end
//------------------------------------- end of include file

