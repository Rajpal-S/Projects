//HEADS UP DISPLAY
private class HeadsUpDisplay
{
  //initial values for score and level
  private int score = 0, level = 1;


  HeadsUpDisplay()
  {
  }

  private void display()
  {
    fill(255);
    textSize(40);
    
    displayScore();
    displayLevel();
  }

  private void displayScore()
  {
    //Display score on screen during game
    score++;

    text("SCORE: " + score, 600, 50);
  }

  private void displayLevel()
  {
    //Display level on screen during game
    //Increment level every time score increases by 2000
    if (score % 2000 == 0)
    {
      level++;
    }
    text("LEVEL: " + level, 600, 100);
  }

  private int getScore()
  {
    return score;
  }
  private int getLevel()
  {
    return level;
  }

  private void displayLives(int livesRemaining)
  {
    PImage lifeSymbol = loadImage("heart.png");
    
    int imageLocationX = 30, imageLocationY = 20;

    lifeSymbol.resize(30, 30);

    //for each life remaining, display a heart image on the screen
    for (int lifeNumber = 0; lifeNumber < livesRemaining; lifeNumber++)
    {
      image(lifeSymbol, imageLocationX, imageLocationY);

      imageLocationX = imageLocationX + 30;
    }
  }
}
