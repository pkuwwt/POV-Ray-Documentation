// POV-Ray 3.6/3.7 include file "Palm_1.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Palm_1_Inc_Temp)
#declare Palm_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

//------------------------------------------------------------------------------ /////////  
#macro Palm_1( Palm___Height, 
               Number_of___Arms 
             )  //-------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
//---------------------------------------------------------------------------------------
#local Palm_Texture =
 texture{ pigment{ color rgb<0.7,1.0,0.1>}
          normal { bumps 0.25 scale <1,0.002,0.5>}
          finish { reflection 0.1 phong 0.7 }    
        } //-----------------------------------------

#local Trunk_Texture =
 texture{ pigment{ color LightWood}
          normal { bumps 1.0 scale<0.005,0.2,0.005>}
          finish { phong 0.1}
        } //-----------------------------------------

//---------------------------------------------------------------------------------------
// tried a simpler kind of leaf finger
#declare Oleaf =  sphere { <1, 0, 1.732> 2.01 
                          clipped_by{sphere {<1,0,-1.732>,2 scale<1,0.03,0.5> }}
                          } //-------------------
//---------------------------------------------------------------------------------------

#local Random1 = seed (1021);  //added some random in the leaf finger positions
#local Random2 = seed (1022);
#local Random3 = seed (1023);

#macro Palm_Head( Number_of_Arms )  // basical algorithm by Tsutomu Higo
              
 union{
#local Sc=5;

#local Cno = Number_of_Arms; 
#local Cn =0; 
 #while (Cn <Cno)
  #local Xr =Cn/Cno*50;
  #local Yr =Cn*210;
  #local Xp =0;
  #local Yp =-Cn/25;
  #local Zp =0;
  
  #local Cto =30; // Number of single leaf fingers
  #local Ct =0; 

  #while (Ct < Cto)
   #local Xr =Xr+3+Ct/Cto*2;
   #local Yr =Yr;
   union{
     cylinder {<0,-0.05,0>,<0,1.05,0>, 0.3*(1-Ct/Cto)+0.05 scale<0.7,0.9,0.4>}
     object { Oleaf                scale Sc*<sin((15+155*Ct/Cto)*pi/180), 1, sin((15+155*Ct/Cto)*pi/180)> 
                                   rotate  z*Ct/Cto*60-3*(0.5-rand(Random3))}
     object { Oleaf translate x*-2 scale Sc*<sin((15+155*Ct/Cto)*pi/180), 1, sin((15+155*Ct/Cto)*pi/180)> 
                                   rotate z*-Ct/Cto*50-3*(0.5-rand(Random3))}
     scale<0.75,1,1>
     rotate <Xr,Yr,0> translate <Xp,Yp,Zp>
     }// end of union
    #local Xp =Xp+sin(Xr*pi/180)*sin(Yr*pi/180);
    #local Yp =Yp+cos(Xr*pi/180);
    #local Zp =Zp+sin(Xr*pi/180)*cos(Yr*pi/180);

  #local Ct = Ct+1; #end
 #local Cn = Cn+1; #end
scale 0.05
texture{ Palm_Texture }
} // end of union 
#end // end of macro "Palm_Head(...)"

//------------------------------------------------------------------------------ 

#local SegH = 0.10;  
#local SegScale =  1+Palm___Height/10;  // scale of the segments depending from Palm___Height!
#local EndNr = int(Palm___Height/SegH); // end value
#local Palm_Height = EndNr*SegH;
#local Segment = 
difference{
cone{<0,-0.05,0>,0.05,<0,SegH      ,0>,0.11 }
cone{<0,2*SegH/3,0>,0.05,<0,SegH+0.001,0>,0.11 }
     scale <1,1,1> rotate<0,0,0> translate<0,0,0>
     texture{Trunk_Texture}
    }
// -------------------------------------------
#local High = 0;
#local Nr = 0;     // start value
union{
 // ----------------------------------- start of loop
 #while (Nr< EndNr)  
   #local ScaleY = (1-0.15*rand(Random1));
   #local ScaleT = (0.5+0.15*cos(pi*High/(Palm_Height)));
   object{Segment
          scale <ScaleT,ScaleY,ScaleT>*SegScale 
          rotate<20*(0.5-rand(Random2)),80*(0.5-rand(Random3)),0> 
          translate<7/EndNr*(-0.15+0.15*cos(pi*High/(1.2*Palm_Height)))
                    ,High,0>} 
 #local High= High+0.1*ScaleY*SegScale;
 #local Nr = Nr + 1;  // next Nr
 #end // ------------------------------- end of loop 

 object{ Palm_Head( Number_of___Arms ) scale 1+Palm___Height/7 rotate<5*(0.5-rand(Random2)),80*(0.5-rand(Random3)),0>
         translate<7/EndNr*(-0.15+0.15*cos(pi*High/(1.2*Palm_Height))) ,High,0>} 
 
 // --------------------------------------------------------------------------------------
 }// end of union
// --------------------------------------------------------------------------------------
#end// of macro ----------------------------------------------------------// end of macro
// --------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------//
#include "Palm_1.inc" 
//-------------------------------------------------------------------------------// 
object{ Palm_1( 2.50, // palm height im meters 
                12    // number of arms - integer
             ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//-------------------------------------------------------------------------------// 
//-------------------------------------------------------------------------------// 
*/


#version Palm_1_Inc_Temp;
#end
//------------------------------------------------------------------- end of include file

