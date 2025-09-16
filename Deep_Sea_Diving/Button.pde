private class Button
{
  private int buttonHeight, buttonWidth, buttonX, buttonY, sizeOfText, buttonTextOffset;//buttonTextOffset is the co-ordinates of the text within every button in accordance to the size of the button
  private String buttonText;

  Button(int buttonHeight, int buttonWidth, int buttonX, int buttonY, int sizeOfText, String buttonText)
  {
    this.buttonHeight = buttonHeight;
    this.buttonWidth = buttonWidth;
    this.buttonX = buttonX;
    this.buttonY = buttonY;
    this.sizeOfText = sizeOfText;
    this.buttonText = buttonText;

    buttonTextOffset = sizeOfText * 3/10;//ofrmula to get the co-ordinates of text based on the size of the text
  }

  private void drawButton()
  {
    if (hoveringOnButton())
    {
      fill(0, 255, 50);//make the button green if mouse is hovering on button
    } else
    {
      fill(0);
    }
    //Draw rectangle for button
    stroke(255);
    rect(buttonX, buttonY, buttonWidth, buttonHeight);

    //output white text inside button rectangle
    fill(255);
    textSize(sizeOfText);
    text(buttonText, buttonX, buttonY + buttonTextOffset);
  }

  private boolean hoveringOnButton()
  {
    //If the mouse pointer co-ordinates are the same as the button co-ordinates then the mouse is heving on the button
    if ((mouseX >= buttonX - buttonWidth/2 && mouseX <= buttonX + buttonWidth/2) &&(mouseY >= buttonY - buttonHeight/2 && mouseY <= buttonY + buttonHeight/2))
    {
      return true;
    }
    return false;
  }
}
