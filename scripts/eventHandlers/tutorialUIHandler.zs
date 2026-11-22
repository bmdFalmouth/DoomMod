class TutorialUIHandler : EventHandler
{
    override void WorldLoaded (WorldEvent e)
    {      
        super.WorldLoaded(e);
    }

    override void RenderOverlay (RenderEvent e)
    {
        TutorialLogicThinker tutorialLogic=TutorialLogicThinker.GetInstanceReadOnly();

        if (tutorialLogic!=null){
            StatusBar.BeginHud();
            HudFont tutorialFont=HudFont.Create(bigFont);
            UIEntry currentEntry=tutorialLogic.GetCurrentTutorialEntry();
            StatusBar.DrawString(tutorialFont, currentEntry.getDisplayString(), currentEntry.getPosition(), StatusBar.DI_SCREEN_LEFT_TOP|StatusBar.DI_TEXT_ALIGN_CENTER, Font.CR_Gold);
        }

    }
}