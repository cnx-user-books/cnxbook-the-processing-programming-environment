/*3456789012345678901234567890123456789012345678901234567//
Pr0120a.pde
Copyright 2013, R.G.Baldwin
Program illustrates how to write an image explorer sketch
that will display the coordinates of the mouse pointer
along with the RGB color values of the pixel at the mouse
pointer. 

Also displays the width and height of the image.

Displays an error message in place of the image if the 
image is wider or taller than the output display window.
**********************************************************/
//@pjs preload required for JavaScrpt version in browser.
/* @pjs preload="Pr0120a.jpg"; */

PImage img;
PFont font;

Pr0120aRunner obj;
void setup(){
  //Make the height of the frame at least 70 pixels
  // greater than the height of the image to allow room
  // to display width, height, and pixel information.
  // Otherwise, the black text may not be visible,
  // depending on the image colors. If the height of the
  // frame is less than the height of the image, an error
  // message is displayed in place of the image.
  //Make width of the frame at least as wide as the
  // width of the image. Otherwise an error message will
  // be displayed in place of the image.
  size(400,344);
  frameRate(30);
  img = loadImage("Pr0120a.jpg");
  obj = new Pr0120aRunner();
  font = createFont("Arial",16,true);
}//end setup
//-------------------------------------------------------//
void draw(){
  obj.run();
}//end draw
class Pr0120aRunner{
 
  void run(){
    background(255);//white
    
    textFont(font,16);//Set the font size, and color
    fill(0);//black text
    
    loadPixels();//required
    img.loadPixels();//required
    
    float reD,greeN,bluE;//store color values here
    int ctr = 0;//output pixel array counter

    //Display error message in place of image if the 
    // image won't fit in the display window.    
    if(img.width > width){
      text("--Image too wide--",10,20);
      text("Image width: " + img.width,10,40);
      text("Display width: " + width,10,60);
    }else if(img.height > height){
      text("--Image too tall--",10,20);
      text("Image height: " + img.height,10,40);
      text("Display height: " + height,10,60);
    }else{
      //Copy pixel colors from the input image to the
      // display image. 
      for(int cnt = 0;cnt < img.pixels.length;cnt++){
        //Get and save RGB color values for current pixel.
        reD = red(img.pixels[cnt]);
        greeN = green(img.pixels[cnt]);
        bluE = blue(img.pixels[cnt]);
  
        //Normally some sort of image processing algorithm
        // would be implemented here.
        
        //Construct output pixel color
        color c = color(reD, greeN, bluE);
        
        if(width >= img.width){
          if((cnt % img.width == 0) && (cnt != 0)){
            //Compensate for excess display width by
            // increasing the output counter.
            ctr += (width - img.width);
          }//end if
          //Store the pixel in the output pixel arran
          // and increment the output counter.
          pixels[ctr] = c;
          ctr++;
        }//end if
      }//end for loop
      updatePixels();//required
    }//end else
    
    //Display pixel information only if a mouse button
    // is pressed.
    if(mousePressed){
      displayPixelInfo(img);
    }//end if
  }//end run
  
  //-----------------------------------------------------//
  //Method to display coordinate and pixel color info at
  // the current mouse pointer location. Also displays 
  // width and height information about the image.
  void displayPixelInfo(PImage image){
    //Protect against mouse being outside the frame
    if((mouseX < width) && (mouseY < height) && 
       (mouseX >= 0) && (mouseY >= 0)){
      
      //Get and display the width and height of the
      // image.
      text("Width: " + image.width + "  Height: " + 
                       image.height,10,height - 50);
      
      //Get and display coordinates of mouse pointer.
      text("X: " + mouseX + ",  Y: " + mouseY,10,
                                       height - 30);
 
      //Get and display color data for the pixel at the
      // mouse pointer.
      text("R: " + red(pixels[mouseY*width+mouseX]) +
           "  G: " + green(pixels[mouseY*width+mouseX]) +
           "  B: " + blue(pixels[mouseY*width+mouseX]),
                                    10,height - 10);
    }//end if
  }//end displayPixelInfo
}//end class Pr0120aRunner

