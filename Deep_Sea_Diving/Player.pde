private class Player
{
  private float x = 0, y = 0 ;
  private float size;

  //Boolean values to indicate when to rotate the player upwards or downwards
  private boolean moveUp, moveDown;
  private int AnimationCounter = 0;

  private int lives;

  //get the centre co-ordinates of each circle - the submarine is drawn using two circles and a rectangle in the middle

  //Pass through properties of the playe, size and lives
  Player(float size, int lives)
  {
    this.size = size;

    this.lives = lives;
  }

  Player()
  {
  }

  private void Display()
  {
    drawSub();
  }

  private void drawSub()
  {
    //push matrix allows the rotation to work and not impact any other display of the game for example the HUD (level and score)
    //save current co-ordinate system to the matrix stack
    pushMatrix();

    rectMode(CENTER);
    translate(width/2, height/2);
    if (moveUp)
    {
      rotate(-PI/6);
      moveUp = false;
    } else if (moveDown)
    {
      rotate(PI/6);
      moveDown = false;
    }

    //DRAW MAIN BODY

    //set black outline
    stroke(0);

    //draw round edges of each side of the submarine, as two ellipses
    fill(255, 200, 55);//fill colour - yellow
    ellipse( x + size/2, y, size, size);
    ellipse( x - size/2, y, size, size);

    //draw the centre rectangle and the smaller sail rectangle on top
    rect(x + size/4, y - size/8 * 5, size / 4, size/8 * 5);//  80/4 = 20     80/8 * 5 = 50
    //DRAW MAIN BODY RECTANGLE
    rect(x, y, size, size);

    //DRAW WINDOWS
    fill(0, 200, 255);//fill colour - light blue
    ellipse(x, y, size/16 * 3, size/16 * 3);
    ellipse(x + size/3.2, y, size/16 * 3, size/16 * 3);//    80/15 * 3 = 15
    ellipse(x - size/3.2, y, size/16 * 3, size/16 * 3);

    setEmissions();

    popMatrix();//restores previous co-ordinate system from matrix stack
  }

  //the y co-ordinate of the background is passed through, this is to make sure the sub is not rotated when at the top or bottom of game boundries
  private void rotateSub(int backgroundY)
  {
    switch(keyCode)
    {
    case UP:

      if (backgroundY < 1200)
      {
        moveUp = true;
      }
      break;

    case DOWN:
      if (backgroundY > -400)
      {
        moveDown = true;
      }
      break;
    }
  }


  private void setEmissions()
  {
    //Load images for the exhaust animations (bubbles)
    PImage emission1 = loadImage("exhaust_1.png"), emission2= loadImage("exhaust_2.png"), emission3= loadImage("exhaust_3.png");

    emission1.resize(60, 20);
    emission2.resize(60, 20);
    emission3.resize(60, 20);

    animateImages(emission1, emission2, emission3, -85, 10);
  }

  private void animateImages(PImage emission1, PImage emission2, PImage emission3, int animationX, int animationY)
  {
    boolean countDown = false;

    if (!countDown)
    {
      AnimationCounter++;//this is a counter to have each of the three images displayed for a certain range of the counter one at a time, making it animated
    } else
    {
      AnimationCounter--;
    }

    //GO THROUGH THE SEQUANCE OF IMAGES ONE AT A TIME, TO CREATE ANIMATION
    if (AnimationCounter < 20)
    {
      image(emission1, animationX, animationY );
    } else if (AnimationCounter < 40)
    {
      image(emission2, animationX, animationY );
    } else if (AnimationCounter <60)
    {
      image(emission3, animationX, animationY );
    } else if (AnimationCounter > 60)
    {
      AnimationCounter = 0;
    }
  }

  private boolean Collision(Obstacle obstacle)
  {
    //if the obtacle hits the main body of the submarine
    if (dist(obstacle.obstacleX, obstacle.obstacleY, width/2, height/2) < size/4 )
    {
      lives--;
      return true;
      //if the obtacle hits the left circular end of the submarine
    } else if (dist(obstacle.obstacleX, obstacle.obstacleY, width/2 - size/2, height/2) < size)
    {
      lives--;
      return true;
      //if the obtacle hits the left circular end of the submarine
    } else if (dist(obstacle.obstacleX, obstacle.obstacleY, width/2 + size/2, height/2) < size)
    {
      lives--;
      return true;
    }

    return false;
  }

  private int getLives()
  {
    return lives;
  }
}
