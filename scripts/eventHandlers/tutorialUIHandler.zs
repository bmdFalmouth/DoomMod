class TutorialUIHandler : EventHandler
{
    UIEntry currentEntry;


    override void WorldLoaded (WorldEvent e)
    {
        currentEntry=New('UIEntry');
        currentEntry.setDisplayString("This is a tutorial");
        currentEntry.setPosition((120,5));
        super.WorldLoaded(e);
    }

    override void RenderOverlay (RenderEvent e)
    {
        TutorialLogicThinker tutorialLogic=TutorialLogicThinker.GetInstanceReadOnly();

        if (tutorialLogic!=null){
            StatusBar.BeginHud();
            HudFont tutorialFont=HudFont.Create(bigFont);
            StatusBar.DrawString(tutorialFont, currentEntry.getDisplayString(), currentEntry.getPosition(), StatusBar.DI_SCREEN_LEFT_TOP|StatusBar.DI_TEXT_ALIGN_CENTER, Font.CR_Gold);
        }

    }
}