private class StartMenu
{

  //create button objects for each type of button
  private  Button startButton;
  private Button controlsButton;
  private Button highScoresButton;
  private Button hideControlsButton;
  private Button hideHighScoreButton;

  private   boolean startGame = false, showControls = false, showHighScores = false;//showControls and showHighScores for displaying pop up display

  StartMenu()
  {
    rectMode(CENTER);
    textAlign(CENTER);

    //define properties of each button object (buttonHeight,buttonWidth,buttonX,buttonY,sizeOfText, buttonText)

    startButton = new Button(100, 200, width/2, height/2 + 50, 50, "START");

    controlsButton = new Button(50, 100, width - 150, 50, 20, "CONTROLS");

    highScoresButton = new Button(50, 125, 150, 50, 20, "HIGH SCORE");

    hideControlsButton = new Button(50, 150, width - 150, height - 320, 20, "HIDE CONTROLS");

    hideHighScoreButton = new Button(50, 160, 150, height - 320, 20, "HIDE HIGH SCORE");
  }


  private void drawMenu()
  {
    //draw the black background with game title
    drawBackground();

    //draw each of the buttons
    startButton.drawButton();
    controlsButton.drawButton();
    highScoresButton.drawButton();
  }

  private void drawBackground()
  {
    stroke(255);
    fill(0);//fill colour - black
    rect(width/2, height/2, width, height);

    fill(0, 200, 255);
    textSize(65);
    text("AVOID THE OBSTACLES!", width/2, height/2 - 100);//TITLE
  }


  private void displayDropDownMenu()
  {
    fill(0, 0, 20);
    rect(width/2, 655, 500, 250);
  }

  private void displayControls()
  {
    hideControlsButton.drawButton();

    text("UPWARDS ARROW KEY - MOVE UP\n\nRIGHT ARROW KEY - SPEED UP\n\nLEFT ARROW KEY - SLOW DOWN\n\nDOWNWARDS ARROW KEY - MOVE DOWN\n\nCTRL- GO STRAIGHT AT STANDARD SPEED", width/2, 570);
  }

  private void displayHighScores(String PreviousHighestScore)
  {
    hideHighScoreButton.drawButton();

    textSize(30);
    text("CURRENT HIGH SCORE: " + PreviousHighestScore, width/2, 655);
  }
}
