private class Background
{
  private PImage backImage, backImageBottom, backImageTop;

  private int backgroundCentreX = width/2, backgroundCentreY = height/2;

  private int screenWidth, screenHeight, speed;

  //Properties of background width of canvas and height of canvas
  Background(int screenWidth, int screenHeight)
  {
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;

    //load image for background
    backImage = loadImage("backDrop.png");
    backImage.resize(screenWidth, screenHeight);

    backImageBottom = loadImage("backDropSand.png");
    backImageBottom.resize(screenWidth, screenHeight);

    backImageTop =loadImage("backDropRocks.png");
    backImageTop.resize(screenWidth, screenHeight);
  }
  Background()
  {
  }
  //set the speed on the background, based on the paramenter passed through
  private void setSpeed(int speed)
  {
    this.speed = speed;
  }

  // display 6 images of the background, so that when the up and down arrow keys are pressed the background appears to be endless
  private void display()
  {
    imageMode(CENTER);

    //draw background image in the centere of the canvas, and one on top and below this centre image
    image(backImage, backgroundCentreX, backgroundCentreY);
    image(backImageBottom, backgroundCentreX, backgroundCentreY + screenHeight);//this image has sand at the bottom to indicate that the player is at the bottom boundry of the screen
    image(backImageTop, backgroundCentreX, backgroundCentreY - screenHeight);

    //draw another set of three images(top, middle and bottom) but now to the right of the initial images
    //these images will move left when the game is in play and the initial images will be redrawn to the right
    image(backImage, backgroundCentreX + screenWidth, backgroundCentreY);
    image(backImageBottom, backgroundCentreX + screenWidth, backgroundCentreY+screenHeight);////this image has sand at the bottom to indicate that the player is at the bottom boundry of the screen
    image(backImageTop, backgroundCentreX + screenWidth, backgroundCentreY-screenHeight);
  }

  private void move()
  {
    //move the background images towards the left up to the point where they are no longer on the canvas
    if (backgroundCentreX>-screenWidth/2)
    {
      backgroundCentreX = backgroundCentreX - speed;
    }
    //reset the location of the background images to the centre of the canvas
    else
    {
      backgroundCentreX = width/2;
    }
  }

  //ALTER BACKGROUND BASED ON KEY PRESSES
  //The background is moved through altering the the x co-ordinate and y co-ordinate variables that are paramaters for the image function

  //for speed up and slow down the background still is constanlty scrolling, the rate of scroll is what is changed after key presses
  private void speedUp()
  {
    //increase the speed of the scrolling background, to make it seem like the player is moving faster
    backgroundCentreX = backgroundCentreX - speed/4;
  }

  private void slowDown()
  {
    //decrease the speed of the scrolling background, to make it seem like the player is moving slower
    backgroundCentreX = backgroundCentreX + speed/2;
  }

  private void moveUp()
  {
    //here the background moves upwards, making it look like the player is moving downwards
    if (backgroundCentreY>-400)//only move upwards up to a certain point, the top boundry of the game background
    {
      backgroundCentreY = backgroundCentreY - speed /2;
    }
  }

  private void moveDown()
  {
    //here the background moves downwards, making it look like the player is moving upwards
    if (backgroundCentreY<1200)
    {
      backgroundCentreY = backgroundCentreY + speed/2;
    }
  }
  private void cruiseControl()
  {
    //resets the current velocity
  }
  private void changeVelocity()
  {
    switch(keyCode)
    {
    case RIGHT:
      speedUp();
      break;
    case LEFT:
      slowDown();
      break;
    case UP:
      moveDown();//background is moving and not the player - so opposite movement to keys pressed
      break;
    case DOWN:
      moveUp();//background is moving and not the player - so opposite movement to keys pressed
      break;
    case CONTROL:
      cruiseControl();//return to normal speed, going straight forwards
      break;
    }
  }
}
