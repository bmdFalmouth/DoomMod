class GameTimeUIHandler : EventHandler
{
    override void RenderOverlay (RenderEvent e)
    {
        GameLogicThinker gameLogic=GameLogicThinker.GetInstanceReadOnly();
        StatusBar.BeginHud();
        HudFont gameTimeFont=HudFont.Create(smallFont);

        int seconds=gameLogic.GetCurrentTime()/35;

        int displaySeconds=seconds%60;
        int displayMinutes=seconds/60;
        String time="0\:00";
        if (displaySeconds>9)
            time=String.Format("%i\:%i",displayMinutes,displaySeconds);
        else
            time=String.Format("%i\:0%i",displayMinutes,displaySeconds);
        StatusBar.DrawString(gameTimeFont, time, (50, 5), StatusBar.DI_SCREEN_LEFT_TOP|StatusBar.DI_TEXT_ALIGN_RIGHT, Font.CR_Gold);

    }
}