// PoVRay 3.6 / 3.7 Include File "Fence_1.inc"
// author: by Friedrich A. Lohmueller, Jan-2006 / May-2014.
// homepage: http://www.f-lohmueller.de  
// email: Friedrich.Lohmueller_AT_t-online.de

#ifndef(Fence_1_Inc_Temp)
#declare Fence_1_Inc_Temp = version;
#version 3.6;


#macro Fence_1 (Fence_Height, Length_x, Number_of_Elements_x, Element_Length_x, Element_Depth_z, Fence__Texture)
#local D= 0.000001; 
#local PL = Element_Length_x/2; 
#local Picket_Distance = (Length_x-2*PL)/(Number_of_Elements_x-1); 
#declare Picket = // Zaunlatte

// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -Element_Depth_z ,0.00 , 6
       <-PL, 0.00>,  // first point
       < PL, 0.00>, 
       < PL, Fence_Height-0.05>, 
       < 0.00, Fence_Height>, 
       <-PL, Fence_Height-0.05>, 
       <-PL, 0.00> // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 

       texture { Fence__Texture  rotate<90,0,0>}  

     } // end of prism --------------------------------------------------------
union{
 #declare Nr = 0;     // start
 #declare EndNr = 20; // end
 #while (Nr< Number_of_Elements_x) 

   object{Picket translate<0.05+ Nr*Picket_Distance,0,0>} 

 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
box {<0.00, 0.03, 0.00>,< Length_x, -0.03, 0.03> texture{ Fence__Texture rotate<0,90,0>}  translate<0,Fence_Height*3/4,0>} 
box {<0.00, 0.03, 0.00>,< Length_x, -0.03, 0.03> texture{ Fence__Texture rotate<0,90,0>}  translate<0,Fence_Height*1/4,0>} 

rotate<0,0,0> 
translate<0,0,0>} // end of union

#end // ------------------------------------------------- end of #macro Fence_1 (...)




// sample:
/*
//------------------------------------------------------------------- textures //

#declare Fence_Texture = // (wood structures by default in direction z) 
         texture { pigment{ color rgb< 0.75, 0.5, 0.30>*0.80 } 
                   normal { bumps 0.25 scale 0.005 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

//-----------------------------------------------------------------------------//
#include "Fence_1.inc"
//-----------------------------------------------------------------------------//
object{ Fence_1 ( 0.80, // Fence_Height, 
                    2.00, // Fence_Length_x,
                    15,   // Number_of_Elements_x,
                    0.10, // Element_Length_x, 
                    0.03, // Element_Depth_z, 
                    Fence_Texture) // -------------------------------
        rotate<0,40,0> 
        translate< 0.00,0.05,0.00>} // end of object{ Fence_1(...) ...}
//-----------------------------------------------------------------------------//
*/
 
#version Fence_1_Inc_Temp;
#end
//------------------------------------- end of include file

