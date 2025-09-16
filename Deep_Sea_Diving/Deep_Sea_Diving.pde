//Create objects for background(that will be moving) , for the submarine (that stays in the centre of the screen)
//and the obstacles(that will be moving in the opposite direction to the background).

private Background background;
private Player Sub;
private HeadsUpDisplay HUD;
private StartMenu Menu;
private Explosion explosion;

private int backgroundSpeed = 0, rocketFrequency = 50;

private ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();//all obtacles will be stored here- polymorphism

private boolean collision;

private int livesRemaining, time = 0, wait = 500;

private String[] currentHighScore;

private String previousHighScore;


void setup()
{
  size(800, 800);

  //store the size of the screen
  final int screenWidth = 800;
  final int screenHeight = screenWidth;

  //set lives to start off with
  final int livesAtStart = 5;

  //lives remaining is what will be changing
  livesRemaining = livesAtStart;

  //submarine size to be 7.5% the size of the backgound height and width
  float submarineSize = screenWidth * 0.075;


  explosion = new Explosion();

  background = new Background(screenWidth, screenHeight);

  Sub = new Player(submarineSize, livesAtStart);//passing through size of submarine and lives that the player will start with

  HUD = new HeadsUpDisplay();//HUD object, to display lives remaining, score and the current level on the screen during the game

  Menu = new StartMenu();//Menue class organises all the button displays and functions before the start of the game

  currentHighScore = loadStrings("HighScoreFile.txt");//load the text file stored with the sketch, this contains the highest achieved score

  previousHighScore = currentHighScore[0];//save the previous high score, current high score may change
}
void draw()
{
  if (!Menu.startGame)//if start button not been clicked
  {
    //the menue is only drawn if the start button has not been clicked, all the operations as a result of the other button clicks will also only be executed if the start button is not clicked
    Menu.drawMenu();

    if (Menu.showControls || Menu.showHighScores)//if show control or show high scores button is clicked
    {
      Menu.displayDropDownMenu();

      if (Menu.showControls)
      {
        Menu.displayControls();

        Menu.showHighScores = false;
      } else if (Menu.showHighScores)
      {
        Menu.displayHighScores(currentHighScore[0]);

        Menu.showControls = false;
      }
    }
  }

   else//when start button is clicked - start the game
  {

    if (livesRemaining > 0)
    {
      //set the speed of the game (background) based off the current level - starts at 10
      backgroundSpeed = (HUD.getLevel() * 2) + 10;
      background.setSpeed(backgroundSpeed);

      //display background images
      background.display();

      //make the background scrolling background towards the left
      background.move();

      //this calls a method that changes velocity based on arrow keys being pressed
      background.changeVelocity();

      //display the player, submarine
      Sub.Display();

      //allow the sub to rotate based on arrow keys pressed
      Sub.rotateSub(background.backgroundCentreY);

      //display the level and score
      HUD.display();

      //Display the lives on the screnn in the form of hearts
      HUD.displayLives(livesRemaining);

      //loop through every obstacle in the obstacle ArrayList one by one
      for (int currentObstacle = 0; currentObstacle < obstacles.size(); currentObstacle++)
      {
        //display and move the current obstacle in the ArrayList, the obstacle index is determined by the loop
        obstacles.get(currentObstacle).display();
        obstacles.get(currentObstacle).move();

        //this moves the rocket making it seem like the submarine is moving when its the background and obtacles moving.
        obstacles.get(currentObstacle).matchBackground(background.backgroundCentreY);

        //boolean true of the obstacle is in contact with the player (submarine)
        collision = Sub.Collision(obstacles.get(currentObstacle));

        displayExplosion();

        //remove obstacles from arrayList if not on screen screen or collided with sub
        removeUnusedObstacles(currentObstacle, collision);
      }

      alterObstacleFrequency();
      
      generateObstacles();

      livesRemaining = Sub.getLives();
      
    }
    
    else//when lives remaining is zero and game is over
    {
       displayGameOverScreen();
    }
  }
}

private void displayExplosion()
{
  //SET TIMER FOR EXPLOSION ANIMATION AFTER COLLISION
  if (collision)
  {
    time = millis();
  }
  if (millis() - time < wait)//If the time is not yet past the wait period display explosion animation
  {
    explosion.display();
  }
}

private void alterObstacleFrequency()
{
  //INCREASE FREQUENCY OF ROCKET GENERATION AS SCORE INCREASES
  if (HUD.getScore() > 5000)
  {
    rocketFrequency = 25;
  } else if (HUD.getScore() > 10000)
  {
    rocketFrequency = 15;
  }
}

private void generateObstacles()
{
  if (HUD.getScore() % rocketFrequency == 0)//a frequency variable that changes with score
  {
    obstacles.add(new Rocket());//add a rocket object to ther ArrayList of Obstacles - Polymorphism
  }
  if (HUD.getLevel() >= 2 && HUD.getScore() % 300 == 0)//make frequency variable that changes with level
  {
    obstacles.add(new Guided_Rocket());//add a guided rocket object to ther ArrayList of Obstacles - Polymorphism
  }
}

private void removeUnusedObstacles(int currentObstacleNumber, boolean collisionWithSub)
{
  //if the Obstacle passed through as a parameter is now past the screen that the user can see, or if the obstacle collides with sub then remove obstacle from ArrayList to save space
  if (obstacles.get(currentObstacleNumber).obstacleX > width + 200 || obstacles.get(currentObstacleNumber).obstacleX < - 200 || collisionWithSub)
  {
    obstacles.remove(currentObstacleNumber);
  }
}

private void displayGameOverScreen()
{
  background(0);
  fill(255, 0, 0);
  textSize(100);
  //Tell the user that the game is over
  text("GAME OVER", width/2, height/2);

  //DISPLAY THE USERS SCORE
  textSize(80);
  text("SCORE: " + HUD.getScore(), width/2, height/2 + 100);

  //DISPLAY THE PREVIOUS HIGH SCORE
  textSize(60);
  text("Previous Highest Score: " + previousHighScore, width/2, height/2 + 300);

  //CHECK IF USER HAS NEW HIGHEST SCORE
  if (parseInt(previousHighScore) < HUD.getScore())
  {
    fill(255);
    textSize(100);
    //INFORM THE USER OF HIGH SCORE
    text("NEW HIGH SCORE!", width/2, 200);

    //REPLACE THE CURRENT HIGH SCORE IN THE TEXT FILE WITH THE NEW ONE
    currentHighScore[0] = String.valueOf(HUD.getScore());
    saveStrings("HighScoreFile.txt", currentHighScore);
  }
}

void mouseClicked()
{
  //Activate the button (if any) that the mouse was hovering over during the mouse click

  if (Menu.startButton.hoveringOnButton())
  {
    Menu.startGame = true;
  } else if (Menu.controlsButton.hoveringOnButton())
  {
    Menu.showControls = true;
  } else if (Menu.highScoresButton.hoveringOnButton())
  {
    Menu.showHighScores = true;
  } else if (Menu.hideControlsButton.hoveringOnButton())
  {
    Menu.showControls = false;
  } else if (Menu.hideHighScoreButton.hoveringOnButton())
  {
    Menu.showHighScores = false;
  }
}
