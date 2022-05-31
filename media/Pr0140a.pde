/*3456789012345678901234567890123456789012345678901234567*/
/*Pr0140a.pde
Copyright 2013, R.G.Baldwin

This sketch can be used as a template for writing other 
pixel modification algorithms.

The sketch illustrates a linear spacewise pixel 
modification algorithm in which the green and blue pixel 
color values are scaled linearly as a function of the 
distance of the pixel from the left side of the image.

The output is displayed in an image explorer. 

The image explorer displays the coordinates of the mouse 
pointer along with the RGB color values of the pixel at 
the mouse pointer. It also displays the width and height 
of the image.

The image explorer displays an error message in place of 
the image if the image is wider or taller than the output 
display window.
**********************************************************/
//@pjs preload required for JavaScrpt version in browser.
/* @pjs preload="Pr0140a.jpg"; */

PImage img;
PFont font;

Pr0140aRunner obj;
void setup(){
  //This size matches the width of the image and allows
  // space below the image to display the text information.
  size(365,344);
  frameRate(30);
  img = loadImage("Pr0140a.jpg");
  obj = new Pr0140aRunner();
  font = createFont("Arial",16,true);
}//end setup
//-------------------------------------------------------//
void draw(){
  obj.run();
}//end draw
/*3456789012345678901234567890123456789012345678901234567*/
class Pr0140aRunner{
  //The following instance variable is used to set the
  // color of the appropriate pixel in the output display
  // window.
  int ctr = 0;//output pixel array counter
  
  void run(){
    background(255);//white
    textFont(font,16);//Set the font size
    fill(255,0,0);//Set the text color to red
    
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
      //The image will fit in the output window.
      
      //Call a method that will apply a specific 
      // pixel-modification algorithm and write the
      // modified pixel colors into the output window. 
      processPixels();
    }//end else
    
    //Display the author's name on the output in the font
    // size and text color defined above.
    text("Dick Baldwin",10,20);
    
    //Display information about the pixel being pointed
    // to with the mouse. Display near the bottom of the 
    // output window.
    displayPixelInfo(img);
  }//end run
  //-----------------------------------------------------//
  
  //Apply a pixel modification algorithm that causes the 
  // green and blue color values to be scaled on a linear
  // basis moving from left to right across the image. 
  void processPixels(){
    loadPixels();//required
    img.loadPixels();//required
    float reD,greeN,bluE;//store color values here
    ctr = 0;//initialize output pixel array counter
    
    //Process each pixel in the input image.
    for(int cnt = 0;cnt < img.pixels.length;cnt++){
      //Get and save RGB color values for current pixel.
      reD = red(img.pixels[cnt]);
      greeN = green(img.pixels[cnt]);
      bluE = blue(img.pixels[cnt]);

      //Compute the column number and use it to compute
      // the linear scale factors that will be applied to
      // the green and blue color values.
      int col = cnt%img.width;
      float greenScale = (float)(width - col)/width;
      float blueScale = (float)(col)/width;
      
      //Compute a new color based on scaled versions of
      // the input color values. Don't modify the red
      // color value.
      color colr = 
              color(reD, greenScale*greeN, blueScale*bluE);
      //Enable the following statement to override the
      // color modification and display the raw image in 
      // the output window. Disable it to display the 
      // modified image.
      //colr = color(reD, greeN, bluE);
      
      //Store the modified pixel color in the output pixel
      // array.
      setOutputPixelColor(cnt,colr);
    }//end for loop
    updatePixels();//required
  }//end processPixels
  //-----------------------------------------------------//
  
  //Method to set the color of a pixel in the output image
  // based on the input pixel counter, the output pixel
  // counter, the widths of the input and output images, 
  // and the desired color. Deals with the possibility that
  // the output dsplay window is wider than the image being
  // processed.
  void setOutputPixelColor(int cnt,color colr){
    if(width >= img.width){
      if((cnt % img.width == 0) && (cnt != 0)){
        //Compensate for excess display width by
        // increasing the output counter.
        ctr += (width - img.width);
      }//end if
      //Store the pixel in the output pixel array
      // and increment the output pixel counter.
      pixels[ctr] = colr;
      ctr++;
    }//end if
  }//end setOutputPixelColor

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
}//end class Pr0140aRunner

