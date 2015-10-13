// POV-Ray 3.6/3.7 include file "Street_10.inc"
// created by Friedrich A, Lohmueller, Dec-2005
// update July-2013
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Street_10_Inc_Temp)
#declare Street_10_Inc_Temp = version;
#version 3.6;
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(Colors_Inc_Temp)
#include "colors.inc"
#end
#ifndef(Textures_Inc_Temp)
#include "textures.inc"
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Street_Texture )
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.3}
               normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
#end

//------------------------------------------------------------------------------ /////////
#macro Street_10( Street_Width,  // total width
                  Street_Length, //
                  Stripes_Width, // 
                  Stripes_Length // = 0 => continuous line!!!
                ) //---------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#local D = 0.001;
//---------------------------------------------------------------------------------------
union{
box { <-Street_Width/2, 0.00, 0>,< Street_Width/2, D, Street_Length>   
      
      texture{Street_Texture} 
    } // end of box --------------------------------------

   // right line
   box { <-Stripes_Width/2, 0.00, 0>,< Stripes_Width/2, 2*D, Street_Length>   
         texture{Stripes_Texture} 
         translate< Street_Width/2-Stripes_Width*1, 0.00, 0> 
       } // end of box --------------------------------------
   // left line
   box { <-Stripes_Width/2, 0.00, 0>,< Stripes_Width/2, 2*D, Street_Length>   
         texture{Stripes_Texture} 
         translate<-Street_Width/2+Stripes_Width*1, 0.00, 0> 
       } // end of box --------------------------------------
#if( Stripes_Length > 0 )
 #local Number_of_Stripes = int(Street_Length /(2*Stripes_Length));
 #declare Nr = 0;   // start
 #declare EndNr = Number_of_Stripes; // end
 #while (Nr< EndNr) 

   box { <-Stripes_Width/2, 0.00, 0>,< Stripes_Width/2, 2*D, Stripes_Length>   
         texture{ Stripes_Texture} 
         translate<0,0,Nr*2*Stripes_Length>
       } // end of box

 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
#else
   // middle line
  box { <-Stripes_Width/2, 0.00, 0>,< Stripes_Width/2, 2*D, Street_Length>   
          texture{ Stripes_Texture} 
        } // end of box
#end//  of "#if( Stripes_Length > 0 )"

} // end of union
// -----------------------------------------------------------------------//////////////
// --------------------------------------------------------------------------------------
#end// of macro ----------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/* 
// alternative declaration of textures
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.4}
               normal { bumps 0.25 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
*/
//-------------------------------------------------------------------------------------// 
#include "Street_10.inc" 
//-------------------------------------------------------------------------------------// 
object{ Street_10( 4,     // Street_Widthm, // 
                   1000 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length // = 0 => continuous line!!!                                 
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, -5.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------


*/


#version Street_10_Inc_Temp;
#end
//------------------------------------- end of include file

