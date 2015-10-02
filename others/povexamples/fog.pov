fog {
   distance 6
   color rgbft <1,0.6,0,0,0>
   fog_type 2
   up <0,0,1>
   fog_offset 0.5
   fog_alt 0.5
   turbulence 1
   turb_depth 0.9
}

global_settings {
   ambient_light rgb <1,1,1>
}

camera {
   perspective
   location <-4,0,1>
   up y
   right 4*x/3
   angle 60
   sky <0,0,1>
   look_at <1,0,1>
}

light_source {
   <2,1,4>
   color rgb <2,2,2>
}

plane {
   <0,0,1>, 0
   texture {
      pigment {    
         color rgb <0.8,0.8,0.8> 
      }
      normal {
         crackle 1
         turbulence 0.4 
         scale 0.2
      }
   }
}

/* Star field */
sphere {
   <0,0,0>, 1
   hollow
   pigment {
      image_map {
         png "starmap.png" /* Not supplied */
         map_type 1 /* Spherical */
         once
      }
   }
   finish {
      ambient 2 
      diffuse 0
   }
   scale 100
}

/* Marker posts */
#declare xpos = 1;
#while (xpos < 20)
   #declare ypos = -3;
   #while (ypos < 3.1)
      cylinder { 
         <xpos,ypos,0>, <xpos,ypos,1.25>, 0.04 
         pigment { color <0.5,0.5,1> } 
      }
      #declare ypos = ypos + 1;
   #end
   #declare xpos = xpos + 4;
#end

