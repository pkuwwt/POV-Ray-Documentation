// POV-Ray 3.6/3.7 include file "BusinessBuilding_000.inc"
// author: Friedrich A, Lohmueller, Aug-2013, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( BusinessBuilding_000_Inc_Temp)
#declare BusinessBuilding_000_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


//------------------------------------------------------------------------------ /////////
#macro BusinessBuilding_000( 
                    Nx_Elements,  // number of elements in x,  integer >= 1 
                    Ny_Floors,    // number of floors in y,    integer >= 1
                    Nz_Elements,  // number of elements in z,  integer >= 1
                    N_of_Windows_per_Element, // 

                    Win_H,        // window height  
                    Win_Tween_H, // windows tween height - 
                    Win_W,       // window width   
                    Win_Frame_D, // window frame thickness 
                    Wall_D,  // wall thickness  
                    Floor_D, // floor thickness  
                 ) //------------------------------------------------------------- 
//----------------------------------------------- default textures --------------- 
#ifndef( Window_Frame_Texture_1)
#declare Window_Frame_Texture_1 = 
          texture{ pigment{ color rgb< 1, 1, 1>*1.1 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#end
#ifndef( Window_Frame_Texture_2)
#declare Window_Frame_Texture_2 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.98 } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#end
#ifndef( Window_Glass)
#declare Window_Glass = 
          texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                   finish { diffuse 0.1 reflection 0.2  
                            specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                 } // end of texture  
#end
#ifndef( Wall_Texture_1 )
#declare Wall_Texture_1 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.7 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#end
#ifndef( Wall_Texture_2 )
#declare Wall_Texture_2 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.5 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#end
#ifndef( Floor_Texture_1 )
#declare Floor_Texture_1 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.7 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

#end
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------c            
#local D = 0.0001;
//--------------------------------------------------------------------------------c            
#local Raster_Y = Win_H + Floor_D ;
#local Raster_W = N_of_Windows_per_Element*Win_W +Wall_D ; 
#local Width = Nx_Elements*Raster_W+ Wall_D; 
#local Depth = Nz_Elements*Raster_W+ Wall_D; 
//--------------------------------------------------------------------------------c             

#local Window = 
union{ 
  box{<D,+D,-0.005><Win_W-D,Win_H-D,0.005> translate<0,0,Win_Frame_D/2> texture{ Window_Glass }}
  difference{ 
     box{<0,0,0><Win_W,Win_H,Win_Frame_D> texture{ Window_Frame_Texture_1 }}  
     box{<Win_Frame_D,Win_Frame_D,-D><Win_W-Win_Frame_D,Win_H-Win_Frame_D,Win_Frame_D+D> texture{ Window_Frame_Texture_2 }}  
     } // end difference
  translate<-Win_W/2,0,0>
 } // end union 
//--------------------------------------------------------------------------------c            
#local Window_Tween = 
union{ 
   box{<-0.015+D,0,-0.02><0.015-D,Win_H,Win_Frame_D+0.02> texture{ Window_Frame_Texture_1 }}  
   box{<-0.015,0,-0.02+D><0.015,Win_H,Win_Frame_D+0.02-D> texture{ Window_Frame_Texture_2 }}  
 } // end union 
//--------------------------------------------------------------------------------c            
//--------------------------------------------------------------------------------c            
#local Window_Start_x =  N_of_Windows_per_Element*Win_W /2 ; 
#local Window_Segment =  
union{ 
 #local Nr = 0; 
 #while ( Nr < N_of_Windows_per_Element )
 object{ Window translate<-Window_Start_x+(0.5+Nr)*Win_W,0,0> } 
 #local Nr = Nr + 1;
 #end 

 #local Nr = 0; 
 #while ( Nr <= N_of_Windows_per_Element )
 object{ Window_Tween translate<-Window_Start_x+Nr*Win_W,0,0> } 
 #local Nr = Nr + 1;
 #end 

 // top transversal
  box{< -Window_Start_x,Win_H-Win_Frame_D*0.25,-0.15>, <Window_Start_x,Win_H+0.10,0>  texture{ Wall_Texture_2 } }
 // railing line
  box{< -Window_Start_x,-0.05,-0.03>, <Window_Start_x,+0.05,0> translate<0,Win_Tween_H,0> texture{ Window_Frame_Texture_2 } }

} // end uni  


// building walls: 
//--------------------------------------------------------------------------------c            
#local Wall_Edge = box{ <-Wall_D/2,0,-Wall_D/2>,<Wall_D/2,Raster_Y+Floor_D-D,Wall_D/2> } 
#local Floor = 
  box{ <-Width+3*Wall_D/4,0,-Wall_D/4>,<Wall_D/4,Floor_D,Depth-3*Wall_D/4>  }

//--------------------------------------------------------------------------------c            
#local Floor_Segment = // one single level walls + windows  
union{ //
 // floor
 object{ Floor texture {Floor_Texture_1} } 
                 
 union{ // walls
   #local Nr = 1;   // walls in z
   #while ( Nr < Nx_Elements  )
   box{ <-Wall_D/2,0,-Wall_D/2>,<Wall_D/2,Raster_Y+Floor_D-D,Depth> translate<-(Nx_Elements )*Raster_W+Nr*Raster_W,0,0> texture {Wall_Texture_1}} 
   #local Nr = Nr + 1;
   #end 

   #local Nr = 1;  // walls in x
   #while ( Nr < Nz_Elements  )
   box{ <-Width,0,-Wall_D/2>,<Wall_D/2,Raster_Y+Floor_D-D,Wall_D/2> translate<0,0, 0*Raster_W+Nr*Raster_W> texture {Wall_Texture_1}} 
   #local Nr = Nr + 1;
   #end 

   object{ Wall_Edge  translate<                        0,0,                      0> texture {Wall_Texture_1}}
   object{ Wall_Edge  translate<-(Nx_Elements  )*Raster_W,0,                      0> texture {Wall_Texture_1}}
   object{ Wall_Edge  translate<                        0,0, (Nz_Elements)*Raster_W> texture {Wall_Texture_1}}
   object{ Wall_Edge  translate<-(Nx_Elements-1)*Raster_W,0, (Nz_Elements)*Raster_W> texture {Wall_Texture_1}}
   translate<0,-D,0>
  } // end uni walls      

 union{ // windows
   // front + back
   #local Nr = 0; 
   #while ( Nr < Nx_Elements  )
   object{ Window_Segment translate<-0.5*Raster_W-Nr*Raster_W,0,0>} 
   object{ Window_Segment scale<1,1,-1> translate<-0.5*Raster_W-Nr*Raster_W,0,Nz_Elements*Raster_W>} 
   #local Nr = Nr + 1;
   #end 
   // right side + left side 
   #local Nr = 0; 
   #while ( Nr < Nz_Elements  )
   object{ Window_Segment rotate<0,-90,0> translate<0,0,0.5*Raster_W+Nr*Raster_W>} 
   object{ Window_Segment rotate<0, 90,0> translate<-Nx_Elements*Raster_W,0,0.5*Raster_W+Nr*Raster_W>} 
   #local Nr = Nr + 1;
   #end 


   translate<0,Floor_D,0>
  } // end uni windows     
} // end union 

//////////////////////////////////////////////////////////////

union{ // all together: 

  #local Nr = 0; 
  #while ( Nr < Ny_Floors  )
   object{ Floor_Segment translate<0,Nr*Raster_Y,0> }  
  #local Nr = Nr + 1;
  #end 
  // Last floor
  object{ Floor         translate<0,(Ny_Floors)*Raster_Y,0> texture {Floor_Texture_1} }  
  // Top boder
  difference{ 
   box{ <-Width+Wall_D*0.6, 0,-Wall_D*0.6>,<Wall_D*0.6,Floor_D  ,Depth+Wall_D*0.6> } 
   box{ <-Width+Wall_D    ,-D,          0>,<         0,Floor_D+D,Depth-Wall_D    > }

   translate<0,Ny_Floors*Raster_Y+Floor_D,0> texture {Wall_Texture_1}
  } // 




 translate <0,0,0> 
} // end union 
// --------------------------------------------------------------------------------------

#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*

//-------------------------------------------------------------------------------------//
//--------------------------------------------------------------------optional textures
#declare Window_Frame_Texture_1 = 
          texture{ pigment{ color rgb< 1, 1, 1>*1.1 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#declare Window_Frame_Texture_2 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.98 } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#declare Window_Glass = 
          texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                   finish { diffuse 0.1 reflection 0.2  
                            specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                 } // end of texture -------------------------------------------
#declare Wall_Texture_1 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.7 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#declare Wall_Texture_2 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.6 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#declare Floor_Texture_1 = 
          texture{ pigment{ color rgb< 1, 1, 1>*0.5 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
//-------------------------------------------------------------------------------------//
#include "BusinessBuilding_000.inc" 
//-------------------------------------------------------------------------------------//
object{ BusinessBuilding_000( 
                    4, // Nx_Elements,  // number of elements in -x,  integer >= 1
                    6, // Ny_Floors,    // number of floors in    y,  integer >= 1
                    3, // Nz_Elements,  // number of elements in +z,  integer >= 1
                    4, // N_of_Windows_per_Element, // 

                   2.30, // Win_H,       // window height  
                   0.80, // Win_Tween_H, // windows tween height 
                   1.00, // Win_W,       // window width   
                   0.10, // Win_Frame_D, // window frame thickness 
                   0.35, // Wall_D,  // wall thickness 
                   0.50, // Floor_D, // floor thickness 
                 ) //------------------------------------------------------------------//
        // width in -x = Nx_Elements*( N_of_Windows_per_Element*Win_W+Wall_D)+Wall_D;   
        // width in +z = Nz_Elements*( N_of_Windows_per_Element*Win_W+Wall_D)+Wall_D;   
        // top level =  Ny_Floors*(Win_H + Floor_D) + Floor_D; 
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<0.00,0.00, 0.00> 
      } //---------- 
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
*/


#version BusinessBuilding_000_Inc_Temp;
#end
//------------------------------------- end of include file

