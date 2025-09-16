private class Rocket extends Obstacle
{
  Rocket()
  {
    mainImage = loadImage("Rocket_b.png");
    mainImage.resize(80, 40);
  }

  @Override void move()//Set specific movement for this rocket obstacle
  {
    speed = background.speed / 2;

    obstacleX = obstacleX + 8;
  }
}
