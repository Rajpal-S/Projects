private class Explosion
{
  private PImage explosionImg1, explosionImg2, explosionImg3;

  Player Sub;

  Explosion()
  {
    Sub = new Player();

    explosionImg1  = loadImage("ExplosionBig.png");
    explosionImg2  = loadImage("ExplosionMid.png");
    explosionImg3  = loadImage("ExplosionSmall.png");

    //resize two of the exploion images - three different sized images for the explosion
    explosionImg2.resize(200, 200);
    explosionImg3.resize(100, 100);
  }

  private void display()
  {
     Sub.animateImages(explosionImg1, explosionImg2, explosionImg3, width/2, height/2);
  }
}
