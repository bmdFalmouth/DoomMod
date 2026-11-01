class UIEntry
{
    private String displayString;
    private Vector2 screenPosition;


    void setDisplayString(String display)
    {
        displayString=display;
    }

    String getDisplayString()
    {
        return displayString;
    }

    void setPosition(Vector2 pos)
    {
        screenPosition=pos;
    }

    Vector2 getPosition()
    {
        return screenPosition;
    }
}