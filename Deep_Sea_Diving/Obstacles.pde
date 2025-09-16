protected abstract class Obstacle
{
  Background background = new Background();

  protected int size, shiftX = 0, shiftY = 0, speed;
  
  protected float obstacleY = (random(background.backgroundCentreY -400, background.backgroundCentreY+400)), obstacleX = 0;
  protected PImage mainImage;

  Player Sub = new Player();

  protected void display()
  {
    imageMode(CENTER);
    image(mainImage, obstacleX, obstacleY);
  }

  protected void move()
  {
  }
  //Sub-routine to move obstacles in accordance to the movement of the background


  
  protected void matchBackground(int backgroundY)
  {
    switch(keyCode)
    {
    case UP:
      if (backgroundY>-400  && backgroundY < 1200 )//if within top and bottom boundry of background
      {
        obstacleY = obstacleY + 8;//change to y co-ordinate of the obstacle to make it move downwards , making the player look like its moving upwards
        shiftY = shiftY + 8;  //ShiftY and ShiftX translate the movement of the guided rocket obstacle based on key presses
      }
      break;
    case DOWN:
      if (backgroundY<1200 && backgroundY > - 400 )//if within top and bottom boundry of background
      {
        obstacleY = obstacleY - 8;//change to y co-ordinate of the obstacle to make it move upwards , making the player look like its moving downwards
        shiftY = shiftY - 8;
      }
      break;
    case RIGHT:
      obstacleX = obstacleX - 8;
    case LEFT:
      obstacleX = obstacleX + 4;
      break;
    }
  }
}
