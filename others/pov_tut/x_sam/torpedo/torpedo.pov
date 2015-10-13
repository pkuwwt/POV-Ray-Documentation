// POV-Ray 3.6 / 3.7 Example Scene File "torpedo.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Aug-2009/Jan-2011  
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de

//------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
//------------------------------------------------------------------------
#declare Camera_1 = camera { 
                             angle 12
                         
                             location  <18.0 , 17.0 ,-20.0>
                             right     x*image_width/image_height
                             look_at   <-2.6 , 0  , 0.0>
                           }
camera{Camera_1}

// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{pigment{ bozo turbulence 0.85 scale 1.0 translate<5,0,0>
                        color_map { [0.5 rgb <0.20, 0.30, 0.8>]
                                    [0.6 rgb <1,1,1>]
                                    [1.0 rgb <0.5,0.5,0.4>]}
                       }
               finish {ambient 1 diffuse 0} }      
       scale 10000}
//------------------------------
fog{distance 300000 color White}
// sea ---------------------------------------------------------------------
plane{<0,1,0>, 0 
       texture{Polished_Chrome
               normal { bumps 0.15 scale <0.35,0.25,0.25> turbulence 0.5 } 
               finish { diffuse 0.7 reflection 0.60}}}

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




#local Wing = 
       cone { <0,0,0>,0.75,<0,1.00,0>,0.35  
              scale <1,1,0.1> 
              matrix<  1  , 0, 0,  // shearing in x
                     -0.25, 1, 0,
                       0  , 0, 1,
                       0  , 0, 0>            
            } // end of cone -------------------------------------


union{


 sphere { <0,0,0>, 0.5           scale<1.5,1,1>  translate< 0,0,0>  
        }  // end of sphere -------------------------------------- 

 cylinder{ <-4,0,0>,<0,0,0>,0.5  scale<  1,1,1>  translate< 0,0,0>
        } // end of cylinder -------------------------------------

 sphere { <0,0,0>, 0.5           scale<  5,1,1>  translate<-4,0,0>  
        }  // end of sphere -------------------------------------- 
 
       
 union{ 
         object{ Wing rotate <0*90,0,0>}
         object{ Wing rotate <1*90,0,0>}
         object{ Wing rotate <2*90,0,0>}
         object{ Wing rotate <3*90,0,0>}
           
          translate<-5.55,0,0>
      }

 texture { Chrome_Metal //pigment { color White *0.45}
           finish  { phong 1 reflection 0.05}
         } // end of texture

}// end of union

//------------------------------------------------------------- end
