// POV-Ray 3.6 include file "Tube_Fork_000.inc"
// author: Friedrich A, Lohmueller, June-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tube_Fork_000_Inc_Temp)
#declare Tube_Fork_000_Inc_Temp = version;
#version 3.6;
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#macro Tube_Fork_000 ( R1, // ~0.50
                       R2, // ~0.35 ~0.65
                       Tube_D, // ~0.05; // tube material thickness 
                       Bloby, // Blobfactor, // 0.1~0.002  
                       Cor, //   radius correction
                       Test_Cylinders_ON, // on = 1; off = 0
                       ) // ------------------------------------------------
//--------------------------------------------------------------------------
#local D = 0.0001; // just a little bit !!!
#local Box_L = 4*R1; 
//--------------------------------------------------------------------------
//---------------------------------------------- default textures ----------
#ifndef (Tube_Body_Texture)
#declare Tube_Body_Texture = 
  texture{ pigment{ color rgb<1,1,1>*0.85}
           normal { bumps 0.05 scale 0.3005} 
           finish { phong 0.7 reflection 0.05}}
#end
#ifndef (Tube_Inside_Texture)
#declare Tube_Inside_Texture = 
  texture{ pigment{ color rgb<1,1,1>*0.7}}

#end
#ifndef (Test_Tube_Texture)
#declare Test_Tube_Texture = 
           texture { pigment { color rgb<0.7,0.3,1>}} 
                    
#end
//--------------------------------------------------------------------------
//------------------------------------------------------- main part --------
union{ // main union  
 
#if(Test_Cylinders_ON=1) 
union{ // 1
#end

difference{ 
 union{  
 isosurface { //-------------------------------------------------------------
  function { (1+Bloby)
              - pow( Bloby, ( sqrt(x*x+y*y)-(R1+Cor) ) )
              - pow( Bloby,( sqrt( y*y+z*z)-(R2+Cor) ) )
  }
  contained_by { box {  <0,-Box_L,-Box_L>, <Box_L,Box_L,Box_L>} }
  accuracy 0.001
  max_gradient 7
 } // end of isosurface ----------------------------------------------------- 
 
 isosurface { //-------------------------------------------------------------
  function { (1+Bloby)
              - pow( Bloby, ( sqrt(x*x+y*y)-(R1+Cor) ) )
              - pow( Bloby,( sqrt(y*y+z*z +x*x)-(R2+Cor) ) )
  }
  contained_by { box { <-Box_L,-Box_L,-Box_L>, <0,Box_L,Box_L> } }
  accuracy 0.001
  max_gradient 7
 } // end of isosurface ----------------------------------------------------- 
 
 texture{Tube_Body_Texture}
 }// end of union
 
 cylinder { <0,0,-Box_L-D>,<      0,0,Box_L+D>, R1-Tube_D texture{ Tube_Inside_Texture }}
 cylinder { <0,0,       0>,<Box_L+D,0,      0>, R2-Tube_D texture{ Tube_Inside_Texture }}
}//end of difference  //

#if(Test_Cylinders_ON=1)
 union{ // 'test'
   cylinder { <    0,0, Box_L       >,<           0,0,Box_L+0.5*R1>, R1} 
   cylinder { <    0,0,-Box_L-0.5*R1>,<           0,0,-Box_L      >, R1} 
   cylinder { <Box_L,0,            0>,<Box_L+0.5*R1,0,           0>, R2} 
   texture { Test_Tube_Texture }} 
 }// end union 'test'
} // end union of '#if(Test_Cylinders_ON = 1)'
#end // Test_Cylinders_ON=1
// ---------

} // end union main  
#end // --------------------------------------------------- end of macro
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
// ---------------------------------------------------------------------------
// ------------------------------------------------ optional textures 
#declare Tube_Body_Texture = 
  texture{ Polished_Chrome pigment{ color rgb<1,1,1>*0.9}
           normal { bumps 0.05 scale 0.3005} 
           finish { phong 0.7 reflection 0.25}}
#declare Tube_Body_Texture = 
  texture{ pigment{ color rgb<0.75,1,0>*1}
           finish { phong 1 reflection 0.10}}
#declare Tube_Inside_Texture = 
  texture{ pigment{ color rgb<0.3,0.7,0>*1.1}
           finish { phong 1}}
#declare Test_Tube_Texture = 
           texture { pigment { color rgb<1,0.7,0>}
                   //normal  { bumps 0.5 scale <0.25, 0.005,0.005>}  
                     finish  {  phong 0.5 reflection 0.00 }
                   } // end of texture

// ---------------------------------------------------------------------------
#include "Tube_Fork_000.inc"
// ---------------------------------------------------------------------------
object{ Tube_Fork_000 ( // total container box length =   4*R1 
                          0.50, // R1, // main tube radius:  1 ~ 0.25
                          0.35, // R2, // side tube radius:  1.5 ~ 0.20
                          0.01, // Tube_D, // tube material thickness 
                          0.15, // Blobfactor; // 0.1~0.002 ; maximum ~ 0.20 !! 
                          0.06, // radius correction, ~ 0.06
                          0, // Test_cylinders_ON;  on = 1; off = 0
                        ) // -------------------------------------------------
        //rotate <0,0,90>
         translate <0,0,0>
      } // -------------------------------------------------------------------
// ---------------------------------------------------------------------------
*/


#version Tube_Fork_000_Inc_Temp;
#end
//------------------------------------- end of include file

