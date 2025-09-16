private class Guided_Rocket extends Obstacle
{
  //this is an obstacle that will go towards the submarine in the centre and then loop back towards the centre
  private float m, startY = obstacleY;

  //reverse is true when the guided rocket hits the right hand side of the screen
  private boolean reverse = false ;

  Guided_Rocket()
  {
    //starting Y co-ordinate of the obstacle
    startY = int(random(0, 800));

    obstacleX =0;

    mainImage = loadImage("Rocket_r.png");
    mainImage.resize(80, 40);
  }

  //move rocket through centre of screen - where the submarine is
  @Override
    void move()//Set specific movement for this guided rocket obstacle
  {
    //calculate gradient frome stating co-ordinate of rocket to the player
    m = (height /2  -  startY) / (width/2);

    if (obstacleX<width && !reverse)
    {
      //this line controls speed
      obstacleX = obstacleX + 6;
    }
    else//move rocket back towards the player after hitting the right edge of the screen
    {
      reverse = true;

      obstacleX = obstacleX - 6;
    }


    //startY is the same as what would be y intecept
    obstacleY = (m*(obstacleX + shiftX) + startY + shiftY);//y = mx + c equation, so that the rocket always goes through the centre of the screen(towards the player)
  }
}
