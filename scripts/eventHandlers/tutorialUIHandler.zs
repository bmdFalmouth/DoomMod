class TutorialUIHandler : EventHandler
{
    override void RenderOverlay (RenderEvent e)
    {
        TutorialLogicThinker tutorialLogic=TutorialLogicThinker.GetInstanceReadOnly();

        if (tutorialLogic!=null){
            StatusBar.BeginHud();
            HudFont tutorialFont=HudFont.Create(smallFont);
            StatusBar.DrawString(tutorialFont, "This is a tutorial", (120, 5), StatusBar.DI_SCREEN_LEFT_TOP|StatusBar.DI_TEXT_ALIGN_RIGHT, Font.CR_Gold);
        }

    }
}