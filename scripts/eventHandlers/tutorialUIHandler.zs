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
            UIEntry currentEntry=tutorialLogic.GetCurrentTutorialEntry();
            //String teststring = "Officia nostrum suscipit laborum voluptates explicabo suscipit. Amet illum odit asperiores aut mollitia eaque. Est et officiis rerum. At recusandae est eos.";
            HudFont tutorialFont=HudFont.Create(bigFont);

            // Create an instance of BrokenLines and break the lines
            // using the font initialized above:
            BrokenLines brlines = tutorialFont.mFont.BreakLines(currentEntry.getDisplayString(), 250);
            double lineHeight = tutorialFont.mFont.GetHeight(); //this will be used for vertical spacing
            // Start printing at the top left corner:
            Vector2 strPos = currentEntry.getPosition();

            StatusBar.BeginHud();
            // Iterate over each separate string and draw it:
            for (int i = 0; i < brlines.Count(); i++)
            {
                StatusBar.DrawString(tutorialFont, brlines.StringAt(i), strPos, StatusBar.DI_SCREEN_LEFT_TOP|StatusBar.DI_TEXT_ALIGN_CENTER, 
                Font.CR_Gold);
                strPos.y += lineHeight; //move the position down according to the height of the font
            }
        }
    }
}