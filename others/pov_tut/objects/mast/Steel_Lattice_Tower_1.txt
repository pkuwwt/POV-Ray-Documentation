// POV-Ray 3.7 include file "Steel_Lattice_Tower_1.inc"
// author: Friedrich A, Lohmueller, Jan-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Steel_Lattice_Tower_1_Inc_Temp)
#declare Steel_Lattice_Tower_1_Inc_Temp = version;
#version 3.6; // 3.7;


//------------------------------------------------------------------------------//////////////
//------------------------------------------------------------------------------//////////////
//------------------------------------------------------------------------------//////////////
#macro Steel_Lattice_Tower_1 ( 
              Tower_Height__, //7.70, // beam height,
              Cross_Beam_H__, // 2.50, // cross height,   
              
              BLx, // 0.85, // half width x, // 
              BLz, // 1.50, // half width z, // 


              BR, // 0.125, // main beams radius, // 
              BT, // 0.080, // radius side diagonals, // 
              Sh_X, // 0.1, // shearfactor in X
              Sh_Z, // 0.3, // shearfactor in Z

            ) // ------------------------  
//----------------------------------------------------------------------------
//---------------------------------------------------------------------------- 
#local Intern_H = Tower_Height__-BR-BT; 

#local End = abs( int( (Intern_H)/( Cross_Beam_H__ ) ) ); 
#if (End > 0 )
#local Cross_H = abs((Tower_Height__ -1.0*BR)/(End) );
#else 
#local Cross_H = 0; 
#end 

//#local Cross_H = Cross_Beam_H__ ; 
#local Low_H = -Tower_Height__+BR+BT ; 


#local BD = BT; 
#local Sx = Sh_X*Cross_H;
#local Sz = Sh_Z*Cross_H;
#local Fx = Sh_X*Low_H+BT; 
#local Fz = Sh_Z*Low_H+BT; 
//----------------------------------------------------------------------------
#local Single_Beam = 
  cylinder{ <0, (Low_H-BT-0.000001),0>,<0,0,0>, BR 
            matrix<1,0,0, -Sh_X,1,Sh_Z, 0,0,1, 0,0,0> //  matrix-shear_y_to_z 
             translate<BLx,0,-BLz> 
          } //      
//----------------------------------------------------------------------------
#if (Cross_H > 0 )
#macro Cross_Beam( Num )//2 
 union{                           // 
     cylinder{ <0,-(Num-1)*Cross_H,-BLz-(Num-1)*(Cross_H)*Sh_Z> ,<0,-Num*Cross_H, BLz+Num*(Cross_H)*Sh_Z>, BT }   
     cylinder{ <0,-(Num-1)*Cross_H, BLz+(Num-1)*(Cross_H)*Sh_Z> ,<0,-Num*Cross_H,-BLz-Num*(Cross_H)*Sh_Z>, BT }   
     cylinder{ <0,-Num*Cross_H,-BLz-Num*(Cross_H)*Sh_Z>,<0,-Num*Cross_H,BLz+Num*(Cross_H)*Sh_Z>,BT } 
   }// end union 
#end // end macro

#end
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------
union{ 
 object{ Single_Beam scale< 1,1, 1> }
 object{ Single_Beam scale<-1,1, 1> }
 object{ Single_Beam scale< 1,1,-1> }
 object{ Single_Beam scale<-1,1,-1> }
 sphere{<0,0,0>, BR translate< BLx,0, BLz>} 
 sphere{<0,0,0>, BR translate<-BLx,0, BLz>} 
 sphere{<0,0,0>, BR translate< BLx,0,-BLz>} 
 sphere{<0,0,0>, BR translate<-BLx,0,-BLz>} 
 // upper horizontals 
 cylinder{<-BLx,0,0>,<BLx,0,0>,  BR translate<0,0,-BLz>}  
 cylinder{<-BLx,0,0>,<BLx,0,0>,  BR translate<0,0, BLz>}  
 cylinder{<0,0,-BLz>,<0,0,BLz>,  BR translate<-BLx,0,0>}  
 cylinder{<0,0,-BLz>,<0,0,BLz>,  BR translate< BLx,0,0>}  



#if (Cross_H > 0 )
 // ------------------
#local Nr = 1;
#while (Nr<=End)   
//#if( Nr <= End ) 
 // crosses in z direction
 object{ Cross_Beam(Nr) translate<-BLx,0,0> matrix<1,0,0, Sh_X,1,0, 0,0,1, 0,0,0> scale< 1,1,1>}
 object{ Cross_Beam(Nr) translate<-BLx,0,0> matrix<1,0,0, Sh_X,1,0, 0,0,1, 0,0,0> scale<-1,1,1> }

 // horizontal travers
 cylinder{<-BLx-(Nr )*Sx,0,0>,<BLx+(Nr )*Sx,0,0>, BT translate<0,-(Nr  )*Cross_H, BLz+(Nr  )*Sz> }  
 cylinder{<-BLx-(Nr )*Sx,0,0>,<BLx+(Nr )*Sx,0,0>, BT translate<0,-(Nr  )*Cross_H,-BLz-(Nr  )*Sz> }  

 // inner diagonal 
 cylinder{<-BLx-(Nr )*Sx,0,-BLz-(Nr)*Sz>,<BLx+(Nr )*Sx,0,BLz+(Nr)*Sz>, BD translate<0,-(Nr)*Cross_H,0>  }  
 cylinder{<-BLx-(Nr )*Sx,0,-BLz-(Nr)*Sz>,<BLx+(Nr )*Sx,0,BLz+(Nr)*Sz>, BD translate<0,-(Nr)*Cross_H,0> scale<-1,1,1> }  
 
 // left cross
 cylinder{< BLx+(Nr-1)*Sx,-(Nr-1)*Cross_H,-BLz-(Nr-1)*Sz>,<-BLx-(Nr  )*Sx,-(Nr  )*Cross_H,-BLz-(Nr  )*Sz>,BD }  
 cylinder{< BLx+(Nr  )*Sx,-(Nr  )*Cross_H,-BLz-(Nr  )*Sz>,<-BLx-(Nr-1)*Sx,-(Nr-1)*Cross_H,-BLz-(Nr-1)*Sz>,BD }  
  
 // right cross
 cylinder{< BLx+(Nr-1)*Sx,-(Nr-1)*Cross_H, BLz+(Nr-1)*Sz>,<-BLx-(Nr  )*Sx,-(Nr  )*Cross_H, BLz+(Nr  )*Sz>,BD }  
 cylinder{< BLx+(Nr  )*Sx,-(Nr  )*Cross_H, BLz+(Nr  )*Sz>,<-BLx-(Nr-1)*Sx,-(Nr-1)*Cross_H, BLz+(Nr-1)*Sz>,BD }  
 

 
#local Nr = Nr+1 ; 
#end 
#end // #if (Cross_H > 0 )

#if (End = 0 ) // no crosses
 // horizontal travers
 cylinder{<-BLx-Fx,0,0>,<BLx+Fx,0,0>, BT translate<0, Low_H-BT, BLz+Fz> }  
 cylinder{<-BLx-Fx,0,0>,<BLx+Fx,0,0>, BT translate<0, Low_H-BT,-BLz-Fz> }  

 cylinder{<0,0,-BLz-Fz>,<0,0,BLz+Fz>, BT translate<-BLx-Fx, Low_H-BT,0> }  
 cylinder{<0,0,-BLz-Fz>,<0,0,BLz+Fz>, BT translate< BLx+Fx, Low_H-BT,0> }  

#end // #if (Cross_H > 0 )
 // ------------------

 

 translate<0,-BR ,0>
  translate<0,Tower_Height__,0>
} // end union 
//----------------------------------------------------------------------------//////////////
//----------------------------------------------------------------------------//////////////
#end// of macro ------------------------------------------------------// end of macro ////// 




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- texture 
//----------------------------------------------------------------------------
#declare Steel_Lattice_Tower_Texture =   
         texture { pigment{ color rgb< 0.85, 0.82, 0.79 >*0.45 }
                   normal { bumps 0.25 scale 0.015 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
//--------------------------------------------------------------------------
#include "Steel_Lattice_Tower_1.inc"
//--------------------------------------------------------------------------
object{Steel_Lattice_Tower_1 ( 
              7.70, // Tower_Height, // 
              2.50, // Cross_Beam_H, //  
              
              0.85, // BLx, // half width x, // 
              1.50, // BLz, // half width z, // 
              0.115, // BR, // main beams radius, // 
              0.070, // BT, // radius side diagonals, // 
              0.1, // Sh_X, // shear factor in x, // 
              0.2, // Sh_Z, // shear factor,in z  // 
            ) // ------------------------ 
   texture{ Steel_Lattice_Tower_Texture } 
   rotate<0,0,0> 
   translate< 0.00, 0.00, 0.00 >} 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Steel_Lattice_Tower_1_Inc_Temp;
#end
//------------------------------------- end of include file

