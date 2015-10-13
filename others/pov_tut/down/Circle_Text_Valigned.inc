// POV-Ray 3.6 include file "Circle_Text_Valigned.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// created by Friedrich A, Lohmueller, Dec-2005
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Circle_Text_Valigned_Inc_Temp)
#declare Circle_Text_Valigned_Inc_Temp = version;
#version 3.5;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end

//------------------------------------------------------------------------------ /////////  
//--------------------------------------------------------------------------------------- 

// Circle_Text author: Ron Parker  ; Circle_Text_Valigned: with Valign added 11-13-04 by Mike Thorn 
//  Renamed from "Circle_Text" to "Circle_Text_Valigned(...)" and 
//  placed in a single include file "Circle_Text_Valigned.inc" 
//  to preserve compatibility with old version of standard macro "Circle_Text(...)" 
//  by Friedrich A. Lohmueller, Dec.-2005

/* Circle_Text( Font, Text, Size, Spacing, Thickness, Radius, Inverted,
                Justification, Angle, Valign )
Creates a text object with the bottom (or top) of the character cells aligned
with all or part of a circle.  This macro should be used inside an object{...}
block.

         Font: The font to use (see the documentation for the text object)
         Text: The text string to be created
         Size: The height of the text string, as you would use to scale a
               standard text object
      Spacing: The amount of space to add between the letters.
    Thickness: The thickness of the letters (see the documentation for the
               text object)
       Radius: The radius of the circle along which the letters are aligned
     Inverted: If this parameter is nonzero, the tops of the letters will
               point toward the center of the circle.  Otherwise, the bottoms
               of the letters will do so.
Justification: One of the constants Align_Left, Align_Right, or Align_Center
        Angle: The point on the circle from which rendering will begin.  The
               +x direction is 0 and the +y direction is 90 (i.e. the angle
               increases anti-clockwise. 
       Valign: Rotates the text for vertical objects. -90 turns the text right side up,
               90 results in upside-down, and 0 is horzontal. (added 11-13-04, Mike Thorn) 
*/

                     // VALUE,  // meaning of VAL  
#macro Circle_Text_Valigned( F, // Font, i.e.: "arial.ttf", 
                             T, // Text, i.e.: "POVRay",
                             S, // LetterSize,    i.e.:  0.75, 
                             Sp,// LetterSpacing, i.e.: 0.025,
                             Th,// Deepth,        i.e.: 15.00, 
                             R, // Radius,        i.e.: 1.25
                             I, // Inverted,      0 or 1
                             J, // Justification: Align_Left, Align_Right, or Align_Center  
                             A, // Circle angle
                             Valign// Valign:  Rotates for vertical objects. -90 = right side up, 90 = upside-down, 0 = horzontal.
                           ) //----------------------------------------------------------------------------------------------  
   #local FW = Text_Width(F, T, S, Sp);
   #local TO = text {ttf F T 1 0 scale<S, S, 1>}
   #local TH = max_extent(TO).y;
   #local C = array[strlen(T)]
   #if(FW > 2*pi*R)
      #error concat("\n\n**** Text string \"", T, "\" is too long for a circle of the specified radius.\n\n\n")
   #end
   #local AW = -FW*180/pi/R;
   #local SA = A;
   #local EA = A + AW;
   #if(((J = Align_Right) & !I)|((J = Align_Left) & I))
      #local SA = A - AW;
      #local EA = A;
   #else
      #if(J = Align_Center)
         #local SA = A - AW/2;
         #local EA = A + AW/2;
      #end
   #end

   #local CI = 1;
   #while(CI <= strlen(T))
      #local OE = Text_Width(F, substr(T,CI,1), S, Sp);
      #local LW = Text_Width(F, substr(T,1,CI), S, Sp) - OE;
      #local LA = SA + AW*LW/FW + OE/2/FW*AW;
      #if(I)
         #local LA = EA - (LA - SA);
      #end
      #local TO = text {ttf F substr(T, CI, 1) Th 0 scale<S,S,1> rotate x*Valign}
      #if(I)
         #local C[CI-1] =
         object {TO
            rotate 180*z
            translate <OE/2, TH, 0>
            rotate -90*z
            translate R*x
            rotate LA*z
         }
      #else
         #local C[CI-1] =
         object {TO
            translate -OE/2*x
            rotate -90*z
            translate R*x
            rotate LA*z
         }
      #end
      #local CI = CI + 1;
   #end

   // Create the final object, a union of individual text object letters.
   union {
      #local CI=0;
      #while(CI < strlen(T))
         object {C[CI]}
         #local CI = CI + 1;
      #end
   }
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-----------------------------------------------------------------------------------------------------------
#include "Circle_Text_Valigned.inc" 
//-----------------------------------------------------------------------------------------------------------
object{Circle_Text_Valigned( "arial.ttf", "POV-Ray", // Font, Text, 
                             0.35,  0.0005, 0.10,   // LetterSize, LetterSpacing, Deepth,
                             1.05,     1,          // Radius, Inverted,
                             Align_Left, // Justification: either Align_Left, Align_Right, or Align_Center  
                             50,        // Circle angle
                             -90 )       // Valign:  Rotates for vertical objects. -90 = right side up, 90 = upside-down, 0 = horzontal.
                      
        texture{ pigment{ color rgb<1,0.65,0>}
                 normal { bumps 0.5 scale 0.005}
                 finish { specular 1 reflection 0.05}
               } // end of texture
        rotate<90,-180,0>
        scale<1,2,1>*1.2 
        translate<0.0,1.0,0>
      } // end of "Circle_Text_Valigned" object -------------------------------------------
//-----------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Circle_Text_Valigned_Inc_Temp;
#end
//------------------------------------- end of include file

