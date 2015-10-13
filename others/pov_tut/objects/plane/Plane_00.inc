// POV-Ray 3.6/3.7 include file "Plane_00.inc" 
// created by Friedrich A, Lohmueller, Aug, 2005, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Plane_00_Inc_Temp)
#declare Plane_00_Inc_Temp = version;
#version 3.6; 

// Wheels defined with axes at zero!
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------



//----------------------------------------------------- /////////  
#macro Plane_00  (  Number_of___Blades,             
                    Rotation_Angle___Right, //
                    Rotation_Angle___Left,  //
                    Rotor_On___Right, // activates rotation blur 
                    Rotor_On___Left, // activates rotation blur 
  
                    Window___Glass,  // glass texture without interior
                    APlane_Outside___Texture // airplane texture of the outside, 
                    APlane_Inside___Texture, // airplane inside texture
               
                    Blades___Texture, //
                    Engine___Texture, //
                    Undercarriage___Metal, //
                    Pneu___Texture //  
                ) //------------------------------------------------------------ 
//-------------------------------------------------------------------------------------------- 
#local D = 0.00001;
//------------------------------------------------------------------------------
#local Blade___Radius = 2.30; 
// ---------------------------------------------------------------------------------------------------
#local Skin  = 0.05;  // the thickness of the skin
#local G     = 0.005; // the thickness of the windows
#local R_W   = 0.35;  // radius of the passenger's Windows

#local R1  = 2.00;  // radius of the body outside
#local R2  = 1.25;  // radius nose top y     
#local R3  = 4.00;  // length nose
#local R4  = 2.50;  // length forehead   
#local R5  = 9.50;  // length tail

//-------------------------------------------------------------------
//#macro Body(Radius, Radius_Nose_TopY, Length_Nose, Length_Forehead, 
//            Length_Tail, A_Tex)
#macro Body(Radius, Radius_Nose_TopY, Length_Nose, Length_Forehead, 
            Length_Tail)
union{
intersection{                                 //  nose lower part (1)
 sphere { <0,0,0>,1  scale <Length_Nose, Radius, Radius>}
 box    { <0,-1,-1>,<1,0,1> scale <Length_Nose, Radius, Radius>} 
 }// -------------- end of intersection    

intersection{                             // nose - forehead part (2)
 sphere { <0,0,0>,1  scale < Length_Forehead, Radius, Radius>}
 box    { <0,0,-1>,<1,1,1>  scale < Length_Forehead, Radius, Radius>} 

 }// -------------- end of intersection    
intersection{                            // nose front upper part (3)
 sphere { <0,0,0>,1  scale <Length_Nose, Radius_Nose_TopY, Radius>}
 box    { <0,0,-1>,<1,1,1> scale <Length_Nose, Radius, Radius>} 
 }// -------------- end of intersection    

intersection {                        // the tail of the airplane (4)
 sphere { <0,0,0>,1    scale < Length_Tail, Radius, Radius> }
 box    { <-1,-1,-1>,<0,1,1> scale < Length_Tail, Radius, Radius>} 
 }// -------------- end of intersection    
}// end of union
#end // ---------------------------------- end of macro "Body( ... )"
 
 

//----------------------------------------------------------------------
#local Windows_Cut_Cockpit = // prisms for cutting out the windowwunion{
union{
prism { -R1-G, R1-2*G, 5 //side window
       < 0.50, 0.50>, 
       < 1.30, 0.70>,
       < 1.00, 1.33>,
       < 0.40, 1.30>,
       < 0.50, 0.50>
       rotate<-90,0,0>scale<1,1,-1> }//turns prism in z-direction! 

prism { -R1-G, R1-2*G, 6  //side window
       < 1.35, 0.72>, 
       < 1.95, 0.99>,
       < 1.76, 1.17>,
       < 1.52, 1.37>,
       < 1.05, 1.33>,
       < 1.35, 0.72>
       rotate<-90,0,0>scale<1,1,-1> }//turns prism in z-direction! 

prism {  -R1-0.1 ,R1+0.1 , 5   // right side font glass
       <-0.65, 1.02>,
       <-0.04, 1.10>, 
       <-0.04, 1.40>,
       <-0.70, 1.39>,
       <-0.65, 1.02>
       rotate<-90,-90,0>} //turns prism in x-direction! 

prism {  -R1-0.1 ,R1+0.1 , 5  // left side font glass
       <-0.65, 1.02>,
       <-0.04, 1.10>, 
       <-0.04, 1.40>,
       <-0.70, 1.39>,
       <-0.65, 1.02>
       rotate<-90,-90,0> //turns prism in x-direction! 
       scale<1,1,-1>} // mirrored at the xy plane 

 }// end of union
//--------------------------------------------------------------------
//--------------------------------------------------------------------

#local Windows_Cut_Passenger_Windows = // prisms for cutting out the 
 union{                                   // passenger windows
   cylinder{ <0,0,-1.1*R1>,<0,0,1.1*R1>, R_W  
            }
   cylinder{ <0,0,-1.1*R1>,<0,0,1.1*R1>, R_W
             translate<-1.50, 0, 0>}
   cylinder{ <0,0,-1.1*R1>,<0,0,1.1*R1>, R_W
             translate<-3.00, 0, 0>}
  }
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------

//-------------------------------- ------- blur texture
#macro Radial_Rotor_TextureX (Number_of_radial_stripes)
 radial 
 frequency Number_of_radial_stripes // = number of blades
 rotate<90,0,0> 
 texture_map { [0.00  pigment {color rgbt<1,1,1,0.5>} 
                      finish  {ambient 0.15 
                               diffuse 0.85 
                               phong 0.1}]
               [0.60 pigment{color Clear}]
               [1.00 pigment{color Clear}]
             }
#end //------------------------------------ other textures 
 
//--------------------------------------------------------
#macro Engine( Number_Blades, 
               Blade_Radius, 
               Rotation_Angle, 
               Rotor_On,
               Blades_Texture, 
               Engine_Texture
               )// ---------------------------------------   
union{  // engine
   // --------------------------- the casing of the engine
   torus{1.0,0.175 rotate<90,0,0> 
         scale <1,1,5>*0.35 
         texture{Engine_Texture}
         translate<0,0,-0.3>  
        }  // end of torus  
   difference {
         sphere { <0,0,0>,1 
                  scale <0.35,0.35,1.3>
                  translate<0,0,0.5>}
         box    { <-1,-1,-1.2>,<1,1,-0.48>}
         texture{Engine_Texture}
      }      
 union{  // propeller
   cylinder{ <0,0,-0.01>,<0,0,1.00>,0.10}// peopeller axis
   difference{                           // propeller nose  
               sphere{<0,0,0>, 1}  
               box {<-1,-1,-0.1>,<1,1,1>}
               scale <1,1,2.5>*0.3 
               translate<0,0,0.2>
               texture{Blades_Texture}
             }
   union{  // --------------------------------- the blades
     #declare Nr = 0;
     #declare End = Number_Blades; 
     #while ( Nr < End) 
     sphere { <0,0,0>,0.5  
              scale <1,0.15,0.04>
              translate <0.5,0,0> 
              rotate <10,0,0>
              scale Blade_Radius // = Blade_Radius
              texture {Blades_Texture}
              rotate< 0,0, 360/End * Nr > 
            } 
     #declare Nr = Nr + 1; 
     #end
     // ---------------------------------------------------------
     #if (Rotor_On = 1) // --------------------------------- blur
     cylinder { <0,0,0>,<0,0,0.001>, Blade_Radius 
                texture{ Radial_Rotor_TextureX(Number_Blades) } 
                rotate <0, 0,0> 
                translate<0,0, 0.025>
              } 
     #end // of #if (Activate_B = 1) ------------------------------

   } // end of union of the blades
  translate<0,0,-0.7>
  rotate<0,0,Rotation_Angle>
  } // end of union propeller  ------------------------------------
} // end of union engine  -----------------------------------------
#end // end of macro Engine "( ... )" -----------------------------
//-----------------------------------------------------------------


//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
#local Tail_Wing_Y = 
union{
 cone  { <0,0,0>, 1.50,<0, 3.50,0>, 0.80}
 sphere{ <0,0,0>, 0.80 scale<1,0.15,1> translate<0,3.50,0>}
 scale <1,1,0.15>
 matrix<     1, 0, 0, //Shearing in X direction
         -0.30, 1, 0,
             0, 0, 1,
             0, 0, 0>
  }//----------- 
//----------------------------------------------------------------------
#local Tail_Unit = 
union{ object{ Tail_Wing_Y }
       object{ Tail_Wing_Y rotate< 80,0,0> }
       object{ Tail_Wing_Y rotate<-80,0,0> }
       translate<1.50, 0,0>
     } // end of union
//----------------------------------------------------------------------
#local Wing = 
union{
 cone  { <0,0,0>, 2.40,<0,9.50,0>, 1.00}
 sphere{ <0,0,0>, 1.00 scale<1,0.15,1> translate<0,9.50,0>}
 scale <1,1,0.15>
 matrix<     1, 0, 0, //Shearing in X direction
          0.10, 1, 0,
             0, 0, 1,
             0, 0, 0>
  }//----------- 
#local Wings = 
union{ object{ Wing  rotate< 83,0,0>}
       object{ Wing  rotate<-83,0,0>}
     } // end of union
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
#local Weel = union{
torus { 0.25,0.10 
        texture { Pneu___Texture} 
        scale <1,1,1> rotate<90,0,0> translate<0,0,0>
      } // end of torus  -------------------------------              

cylinder { <0,0,-0.05>,<0,0,0.05>,0.2 
           texture { Undercarriage___Metal }  
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder
} // end of union 

#local Weels = union{
cylinder { <0,0,-0.25>,<0,0,0.25>,0.05 
           texture { Undercarriage___Metal }  
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder
cylinder { <0,0,0>,<0,2.2,0>,0.07 
           texture { Undercarriage___Metal }  
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder
cylinder { <0,0,0>,<0,2.80,0>,0.05 
           texture { Undercarriage___Metal }  
           scale <1,1,1> rotate<0,0,45> translate<0,0.1,0>
         } // end of cylinder
cylinder { <0,0,0>,<0,2,0>,0.04 
           texture { Undercarriage___Metal }  
           scale <1,1,1> rotate<35,0,0> translate<0,0.25,0>
         } // end of cylinder

object{ Weel translate<0,0,-0.20>}
object{ Weel translate<0,0, 0.20>}
rotate<0,0,4>
translate<0,0.33,0>
} // end of union 
//----------------------------------------------------------------------
//----------------------------------------------------------------------

#local Weel_Back = 
union{
object{ Weel} 
cylinder { <0,0,-0.25>,<0,0,0.15>,0.05 
           texture { pigment { color Silver}
                     finish  { ambient 0.15 diffuse 0.8 phong 1}
                   } // end of texture
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder
cylinder { <0,0,0>,<0,1.5,0>,0.05 
           texture { pigment { color Silver}
                     finish  { ambient 0.15 diffuse 0.8 phong 1}
                   } // end of texture
           scale <1,1,1> rotate<0,0,0> translate<0,0,-0.20>
         } // end of cylinder

rotate<0,0,-45>
translate<0,0.33,0>
} // end of union 

//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------


union{ //------------------------------------------------------------------------ complete plane
 difference { 
   object { Body(R1, R2, R3, R4, R5) }
   object { Body(R1-Skin, R2-Skin, R3-Skin, R4-Skin,R5-Skin) 
            texture { APlane_Inside___Texture } }
   object { Windows_Cut_Cockpit }
   object { Windows_Cut_Passenger_Windows
            rotate<0,0,3>  translate< -1-0.00, 0.25*R1, 0> }
   
   texture{ APlane_Outside___Texture}
 }// end of difference 


 difference { 
   object { Body(R1-G, R2-G, R3-G, R4-G, R5-G) }
   object { Body(R1-2*G, R2-2*G, R3-2*G, R4-2*G,  R5-2*G)}
   
   texture{ Window___Glass}
 }// end of difference 

 object{ Tail_Unit
         translate< -R5,0,0>

         texture{ APlane_Wings_Texture}
        }

 object{ Wings
         translate<-2.50,-1.30,0>
         texture{ APlane_Wings_Texture}
        }

//#macro{ Engine(Number_of___Blades, Blade_Radius, Rotation_Angle, Rotor_On) // right engine 
 object{ Engine( Number_of___Blades, 
                 Blade___Radius, 
                 Rotation_Angle___Right, 
                 Rotor_On___Right,  
                 Blades___Texture, 
                 Engine___Texture)
         scale 0.85
         rotate<0,-90,0>
         translate <-0.30,-0.70,-5.00>
       }

//#macro{ Engine(Number_of_Blades, Blade_Radius, Rotation_Angle, Rotor_On)  // left engine
 object{ Engine( Number_of___Blades, 
                 Blade___Radius, 
                 Rotation_Angle___Left, 
                 Rotor_On___Left,  
                 Blades___Texture, 
                 Engine___Texture)
         scale 0.85 
         rotate<0,-90,0>  scale<1,1,-1>
         translate <-0.30,-0.70,-5.00>
         scale <1,1,-1>
       }

 object{ Weels scale 1 translate<-1.0,-2.90,-4.50>  }
 object{ Weels scale 1 translate<-1.0,-2.90,-4.50> scale<1,1,-1>}

 object{ Weel_Back scale 1 translate<-8.5,-1.60,0>  }

   
}//-------------------------------------------------------------------end  
// ---------------------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------//
//-------------------------------------------------------------------- textures
#declare APlane_Outside_Texture =       
    texture { pigment{color Silver}
              finish { phong 1} }

#declare APlane_Wings_Texture =          
    texture { pigment{color Silver}
              finish { phong 1} } 
 
#declare  APlane_Inside_Texture=                
    texture { pigment{color White}
              finish { phong } }

#declare Window___Glass =                       
     texture{  NBbeerbottle }    
            
#declare Blades_Texture =                     
    texture { Chrome_Metal
              finish { phong 1}}

#declare Engine_Texture =                      
    texture { APlane_Outside_Texture }

#declare Undercarriage_Metal =                   
    texture { pigment { color Silver}
              finish  { phong 1}}

#declare Pneu_Texture = 
    texture { pigment{ color Gray40}         
              finish { phong 1}}

//-------------------------------------------------------------------------------------------//
#include "Plane_00.inc" 
//-------------------------------------------------------------------------------------------// 
object{ Plane_00 (  
                    5, // Number_of___Blades,             
                    10,// Rotation_Angle___Right, //
                    15,// Rotation_Angle___Left, //
                    2, // Rotor_On___Right, // activates rotation blur 
                    1, // Rotor_On___Left, // activates rotation blur 
                 
                    Window___Glass,  // glass texture without interior
                    APlane_Outside___Texture // airplane texture of the outside, 
                    APlane_Inside___Texture, // airplane inside texture

                   
                    Blades_Texture, //
                    Engine_Texture, //
                    Undercarriage_Metal, //
                    Pneu_Texture, //  
                 ) //------------------------------------------------------------ 
        rotate<0,0,10> 
        scale 1
        translate<0.00,0.00, 0.00>}
//-------------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------------
*/


#version Plane_00_Inc_Temp;
#end
//------------------------------------------------------------------------- end of include file

 
 
 
 