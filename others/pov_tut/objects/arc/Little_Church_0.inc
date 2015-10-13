// POV-Ray 3.6/3.7 include file "Little_Church_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Little_Church_0_Inc_Temp)
#local Little_Church_0_Inc_Temp = version;
#version 3.6;

//------------------------------------------------------------------------------ 
//------------------------------------------------------------------------------ 
//------------------------------------------------------------------------------ /////////  
#macro Little_Church_0 ( Wall___Texture , // texture of the walls 
                         Window_Hole___Texture, // texture of window holes and inside
                         Roof___Texture,        // texture of roof in x direction    
                         Door___Texture         // texture of front door
                       ) //--------------------------------------------------------------- 
//---------------------------------------------------------------------------------------- 


#local Window_Hole = 
union{ 
 //------------------------------------------------------------------ Window Hole 
 box     { <-0.30,0,-1.7>,< 0.30,0.90,1.7> 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
         } // end of box
 cylinder{ <0,0,-1.7>,<0,0,1.7>, 0.30 
           scale <1,1,1> rotate<0,0,0> translate<0,0.90,0>
         } // end of cylinder  ------------------------------------
 texture { Window_Hole___Texture } 
}// ---------------------------------------------------------------------------- 

#local Door_Shape = 
union{ 
 //------------------------------------------------------------------ Window Hole 
 box     { <-0.75,0,-1.0>,< 0.75,1.65,1.0> 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
         } // end of box
 cylinder{ <0,0,-1.0>,<0,0,1.0>, 0.75 
           scale <1,1,1> rotate<0,0,0> translate<0,1.65,0>
         } // end of cylinder  ------------------------------------
}// ---------------------------------------------------------------------------- 
//--------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------ Start "Church_Tower"
#local Church_Tower = 
difference{
union{ 
// ------------------------------------------------------------------ tower roof 
intersection{ //----------------------------------------------------------------
// linear prism in x-direction: from ... to ..., number of points (first = last)
prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
     scale <1.00, 0.50, 1.00>*1.65
     texture { Roof___Texture rotate<0,90,0>}  
      } // end of prism --------------------------------------------------------

// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -1.00 ,1.00 , 4
       <-1.00, 0.00>,  // first point
       < 1.00, 0.00>, 
       < 0.00, 1.50>, 
       <-1.00, 0.00>   // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction!  
     scale <1.00, 0.50, 1.00>*1.65
     texture { Roof___Texture rotate<0, 0,0>}  
      } // end of prism --------------------------------------------------------

  rotate<0,0,0> 
  translate<0.00, 7.50, 0.00> 
}// -------------------------------------- end of intersection

//------------------------------------------------- tower base 
box { <-1.50,0,-1.50>,< 1.50,7.5,1.50> 
      texture { Wall___Texture }  
    } // end of box
// ----------------------------------------------------------- 
} // end of union 


object{ Window_Hole translate< 0.50,5.70,0>} 
object{ Window_Hole translate<-0.50,5.70,0>} 

object{ Window_Hole translate< 0.50,5.70,0> rotate<0,1*90,0>} 
object{ Window_Hole translate<-0.50,5.70,0> rotate<0,1*90,0>} 

// subtracting upper tower inside ---------------------------- 
box { <-1.20,3.50,-1.20>,< 1.20,7.49, 1.20> 
      texture { Wall___Texture }  
    } // end of box
// ----------------------------------------------------------- 
} // end of difference -------------------------------------------------- end of "Church_Tower"
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//----------------------------------------------------------------------- start "church_Nave"
#local Church_Nave = 
union{

difference{ 
// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -1.00 ,1.00 , 6
       <-1.00, 0.00>,  // first point
       < 1.00, 0.00>, 
       < 1.00, 1.00>, 
       < 0.00, 1.50>, 
       <-1.00, 1.00>, 
       <-1.00, 0.00>   // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 


       scale <1.00,1.00,1.00>*3       
       texture { Wall___Texture }  
       rotate <0,0,0> 
       translate <0.00,0.00,0.00> 
     } // end of prism --------------------------------------------------------

// subtracting the kernel
box{ <-0.90,0.05,-0.90>,<0.90,2,0.90>
      scale <1.00,1.00,1.00>*3 
      texture { Window_Hole___Texture }  
     }// end of box ----------------------------

//  subtracting  the door hole
object{ Door_Shape translate< 0.0,0.10,-3.0>
       texture { Window_Hole___Texture }  
     } //--------------------------------------- 

//  subtracting the window holes
// left side 
object{ Window_Hole rotate<0,1*90,0> translate<-3.00,1.20, 1.50>} 
object{ Window_Hole rotate<0,1*90,0> translate<-3.00,1.20, 0.00>} 
object{ Window_Hole rotate<0,1*90,0> translate<-3.00,1.20,-1.50>} 
// right side 
object{ Window_Hole rotate<0,1*90,0> translate< 3.00,1.20, 1.50>} 
object{ Window_Hole rotate<0,1*90,0> translate< 3.00,1.20, 0.00>} 
}// end of difference

// the roof: 
// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -1.10 ,1.10 , 7
       <-1.05, 0.95>,  // first point
       < 0.00, 1.50>,  
       < 1.05, 0.95>, 
       < 1.05, 1.00>, 
       < 0.00, 1.55>, 
       <-1.05, 1.00>, 
       <-1.05, 0.95>  // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 

       scale <1.00,1.00,1.00>*3       
       texture {Roof___Texture } // end of texture
     } // end of prism --------------------------------------------------------------------
 
object { Door_Shape scale<1,1,0.020>  
         translate<0.75,0,0> rotate<0,-30,0> translate<-0.75,0,0>  
         translate< 0.0,0.10,-3.00+0.075>
         texture { Door___Texture}
       } //-------------------------------------------------------
  
} //-------------------------------------------------------------------- end of church nave 
//-----------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------

union{ // ---------------------------------------------- Church
 object{ Church_Tower translate< 4.50, 0,-3.00>} 
 object{ Church_Nave  translate< 0.00, 0, 0.00>} 
}//---------------------------------------------- End of Church  
// ----------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------------------------// 
//--------------------------------------------------------------------- Textures  
#local Wall_Texture = 
 texture { pigment{ color White*1.1}
           normal { bumps 0.5 scale 0.0025}
           finish { phong 0.2}
         } // end of texture
#local Window_Hole_Texture = 
 texture { pigment{color White*0.8}
           finish { phong 0.2}
         } // end of texture
#local Roof_Texture = 
  texture { pigment{ color Scarlet} 
            finish { phong 0.2}
          } // end of texture
#local Door_Texture = 
  texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.55 }// dark brown  
           normal { bumps 0.25 scale 0.025 }
           finish { diffuse 0.9 phong 1 reflection 0.00}
         } // end of texture 
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------// 
#include "Little_Church_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ Little_Church_0( Wall_Texture , // texture of the walls 
                         Window_Hole_Texture, // texture of window holes and inside
                         Roof_Texture,        // texture of roof in x direction    
                         Door_Texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------
*/


#version Little_Church_0_Inc_Temp;
#end
//------------------------------------- end of include file

