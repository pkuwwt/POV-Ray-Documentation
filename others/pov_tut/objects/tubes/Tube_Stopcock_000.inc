// POV-Ray 3.6/3.7 include file "Tube_Stopcock_000.inc" 
// author: Friedrich A, Lohmueller, June-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tube_Stopcock_000_Inc_Temp)
#declare Tube_Stopcock_000_Inc_Temp = version;
#version 3.6;
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef ( Tube_Fork_000_Inc_Temp) 
#include "Tube_Fork_000.inc"
#end 
//--------------------------------------------------------------------------
#macro Tube_Stopcock_000(  R1, // ~0.50
                           R2, // ~0.35 ~0.65
                           Tube_D, // ~0.05; // tube material thickness 
                           Blobfactor, // 0.1~0.002  
                           R_Correction, //   ~  Blobfactor/5
                           Test_End_Cylinders_ON, // on = 1; off = 0

                           F_Add, // flange radius add
                           F_D,   // flange thickness
                           FB_R,   // Flange_Border_Radius
                           Nuts_ON, // 0 = no nuts but holes; 1 = nuts - no holes
                           Nut_Scale,// ~0.035
                           Number_of_Nuts, // ~ 16,   

                           Side_End_Cover_ON,
                           Stopcock_Wheel_ON, // 0 or 1  
                           Stopcock_Wheel_Rotation_Angle, 

                           Wheel_Rmin, 
                           Wheel_Rmaj, 
                           Wheel_Axis_Len,   
                        ) // ------------------------------------------------
//-------------------------------------------------------- dimensions
#local D = 0.0001; // just a little bit !!!
#local Box_L = 4*R1; 
#if (F_Add <=0 ) #local F_Add  = Tube_D+D; #end
//-------------------------------------------------------- default textures
#ifndef (Tube_Body_Texture)
#declare Tube_Body_Texture = 
  texture{ pigment{ color rgb<1,1,1>*0.95}
           normal { bumps 0.05 scale 0.3005} 
           finish { phong 0.7 reflection 0.05}}
#end
#ifndef (Tube_Inside_Texture)
#declare Tube_Inside_Texture = 
  texture{ pigment{ color rgb<1,1,1>*0.7}
           finish { phong 0}}

#end
#ifndef (Test_Tube_Texture)
#declare Test_Tube_Texture = 
           texture { pigment { color rgb<0.7,0.3,1>}
                   //normal  { bumps 0.5 scale <0.25, 0.005,0.005>}  
                     finish  {  phong 0.5 reflection 0.00 }
                   } // end of texture
#end
//--------------------------------------------------------- 
#ifndef( Flange_Texture_1 )
#declare Flange_Texture_1 = 
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }  
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
#ifndef( Flange_Texture_2 )
#declare Flange_Texture_2 = 
          texture { pigment{ color rgb< 1, 1, 1>*0.65 }  
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
#ifndef( Flange_Hole_Texture )
#declare Flange_Hole_Texture = 
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }  
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
#ifndef( Nut_Texture_1 )
#declare Nut_Texture_1 = 
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }  
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
#ifndef( Nut_Texture_2 )
#declare Nut_Texture_2 = 
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }  
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
#ifndef( Wheel_Texture_1 )
#declare Wheel_Texture_1 = 
          texture { pigment{ color rgb< 1, 1, 1>*0.85 }  
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture 
#end 
//---------------------------------------------------------
//---------------------------------------------------------
#local Nut = 
union{ 
object{ Hexagon  
        texture { Nut_Texture_2 }
        scale <0.4,1,1>*Nut_Scale/2 translate<Nut_Scale/2*0.4,0,0>
       } // end of object Hexagon
cylinder{ <0,0,0>, <Nut_Scale*1.15/2,0,0>, Nut_Scale/2*0.5
         texture { Nut_Texture_1 }
       } // end of cylinder
}// end uni                  
//---------------------------------------------------------                  
//---------------------------------------------------------                  
#macro Flange ( Tube_Rad, Flange_Add ) // ---------------------- submacro 
#local Flange_Base = 
difference{  // (point A, point B, Radius, EdgeRadius, UseMerge)
   object{ Round_Cylinder(<0,0,0>, <F_D  ,0,0>,Tube_Rad+Flange_Add, FB_R, 0)  
           texture{Flange_Texture_1}} 
   cylinder{ <-D,0,0>,<F_D+D,0,0>,Tube_Rad-Tube_D/2 texture{Tube_Inside_Texture} }   
 #local Nr = 0;     // start
 #local EndNr = Number_of_Nuts; // end
 #while (Nr< EndNr) 
 cylinder{<-D,0,0>,<F_D+D,0,0>,Nut_Scale/2*0.5 
           texture{ Flange_Hole_Texture }   
           translate<0,0,-Tube_Rad-(Flange_Add)/2> 
           rotate<Nr * 360/EndNr,0,0>} 
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop 
} // end of diff
// ------------------------------------ 
union{
 object{ Flange_Base}
#if (Nuts_ON = 1) 
 union{
  #local Nr = 0;     // start
  #local EndNr = Number_of_Nuts; // end
  #while (Nr< EndNr) 
   object{ Nut 
           translate<F_D,0,-Tube_Rad-(Flange_Add)/2> 
           rotate<Nr * 360/EndNr,0,0>} 
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop 
  } 
#end //'#if (Nuts_ON = 1) '

} // end of union
#end //-------------------------------- end submacro ------------ 
//---------------------------------------------------------------                 
//--------------------------------------------------------------- 
#declare Side_Cover = 
union{ // flange + cover plate  
 object{ Flange( R2, F_Add ) } 
 object{ Round_Cylinder(<0,0,0>, <F_D/2,0,0>,R2+F_Add, FB_R,0)  
          texture{Flange_Texture_1}} 
} // ------------------------------------------------------------
//---------------------------------------------------------------                  
#declare Wheel = 
union{ 
 // axis holder
 object{ Round_Cylinder(<-FB_R,0,0>, <Wheel_Axis_Len/2,0,0>,2*Wheel_Rmin, FB_R, 0)  
         texture{Flange_Texture_1}} 
 object{ Round_Cylinder(<-FB_R,0,0>, <Wheel_Axis_Len/5,0,0>,2.5*Wheel_Rmin, FB_R, 0)  
         texture{Flange_Texture_1}} 
 // wheel + axis 
 union{ //2 
  cylinder{ <0,0,0>,<Wheel_Axis_Len,0,0>,Wheel_Rmin}     
   union{ //3          
    torus{ Wheel_Rmaj, Wheel_Rmin  rotate<0,0,90> } 
    cylinder{ <0,0,-Wheel_Rmaj>,<0,0,Wheel_Rmaj>,Wheel_Rmin*2/3 }     
    cylinder{ <0,0,-Wheel_Rmaj>,<0,0,Wheel_Rmaj>,Wheel_Rmin*2/3 rotate<90,0,0>}     
    sphere{ <0,0,0>,Wheel_Rmin*1.75 scale<0.67,1,1> }
    scale<0.8,1,1>
    translate<Wheel_Axis_Len,0,0>
   } // uni3 
  texture{Wheel_Texture_1} 
 } // uni2 
} // end of union Wheel
//-------------------------------------------------------------- 
//-------------------------------------------------------------- all together now! 

union{ 
// add the flanges
 object{ Flange( R1, F_Add )
         scale <-1,1,1> 
         rotate<0,90,0>
         translate<0,0,-Box_L>  
       }
 object{ Flange( R1, F_Add )
         scale < 1,1,1> 
         rotate<0,90,0>
         translate<0,0, Box_L> 
       }
 object{ Flange( R2, F_Add )
         scale <-1,1,1> 
         rotate<0,0,0>
         translate<Box_L,0, 0> 
       }
//------------------------------
#if ( Side_End_Cover_ON = 1 | Stopcock_Wheel_ON = 1 )
 // Cover with wheel - Deckel mit Rad 
 object{  Side_Cover  
          translate<Box_L,0, 0> }
#end
//------------------------------
#if ( Stopcock_Wheel_ON = 1 )
 object{  Wheel  rotate<Stopcock_Wheel_Rotation_Angle,0,0>
          translate<Box_L,0, 0> }
#end 
//---------------------------------------------------------------------------
// needs: #include "Tube_Fork_000.inc"
object{ Tube_Fork_000 ( // total container box length =   4*R1 
                          R1, // R1, // main tube radius:  1 ~ 0.25
                          R2, // R2, // side tube radius:  1.5 ~ 0.20
                          Tube_D, // Tube_D, // tube material thickness 
                          Blobfactor, // Blobfactor; // 0.1~0.002 ; maximum ~ 0.20 !! 
                          R_Correction, // radius correction, ~ 0.06
                          Test_End_Cylinders_ON, // Test_cylinders_ON;  on = 1; off = 0
                        ) // -------------------------------------------------
      } // end of object -----------------------------------------------------
//------------------------------
} // end union with flanches
#end // --------------------------------------------------- end of macro
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// ------------------------ optional textures
 
#declare Tube_Body_Texture = 
  texture{ pigment{ color rgb<0.3,0.7,0>*1.3}
           finish { phong 1 reflection 0.10}}
#declare Tube_Inside_Texture = 
  texture{ pigment{ color rgb<0.3,0.7,0>*1.1}
           finish { phong 1}}
#declare Test_Tube_Texture = 
           texture { pigment { color rgb<1,0.7,0>}
                   //normal  { bumps 0.5 scale <0.25, 0.005,0.005>}  
                     finish  {  phong 0.5 reflection 0.00 }
                   } // end of texture
//--------------------------------------------------------------------------
 
//--------------------------------------------------------------------------
object{ Tube_Stopcock_000( // total length in z: 4*R1 / in x+: 2*R1 
                           0.50, // R1, // main tube radius:  1 ~ 0.25
                           0.35, // R2, // side tube radius:  1.5 ~ 0.20
                           0.05, // Tube_D, // tube material thickness 
                           0.15, // Blobfactor; // 0.1~0.002 ; maximum = 0.20 !! 
                           0.05, //R_Correction, //   ~  Blobfactor/5
                           0, // Test_End_Cylinders_ON=1; off=0

                           0.14, // F_Add,// flange radius add
                           0.05, // F_D,  // flange  thickness
                           0.01, // FB_R, // Flange_Border_Radius
                           1, // Nuts_ON, // 0 = no nuts but holes; 1 = nuts - no holes
                           0.085, // Nut_Scale, // ~0.035
                           12, // Number_of_Nuts, // ~ 16,   
                          
                           1,// Side_End_Cover_ON,

                           1,// Stopcock_wheel_ON 
                           20,// Stopcock_wheel_Rotation_Angle 
                           // wheel sitzes
                           0.05, //  Wheel_Rmin, 
                           0.45, //  Wheel_Rmaj, 
                           0.35, //  Wheel_Axis_Len,   

                        ) // -----------------------------------------------
         rotate <0,0,90>
      } // -----------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
*/


#version Tube_Stopcock_000_Inc_Temp;
#end
//------------------------------------- end of include file

