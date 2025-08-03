class TigerbunIntermission : DoomStatusScreen
{
    override void drawStats()
    {
        drawLF();

        Font textFont = content.mFont;
		let tcolor = content.mColor;

        GameLogicThinker gameLogic=GameLogicThinker.GetInstanceReadOnly();

		DrawText (textFont, tcolor, 50, 65, "Sleeps", shadow:true);
		DrawText (textFont, tcolor, 50, 90, "Treats", shadow:true);
		DrawText (textFont, tcolor, 50, 115, "Pets", shadow:true);
        DrawText (textFont, tcolor, 50, 140, "Feeds", shadow:true);

        if (sp_state >= 2)
		{
            DrawText (textFont, tcolor, 270, 65, String.format("%d",gameLogic.GetSleepsStat()) ,shadow:true);
		}
		if (sp_state >= 4)
		{
            DrawText (textFont, tcolor, 270, 90,String.format("%d",gameLogic.GetTreatStat()) ,shadow:true);
		}
		if (sp_state >= 6)
		{
            DrawText (textFont, tcolor, 270, 115,String.format("%d",gameLogic.GetPetsStat()) ,shadow:true);
		}
		if (sp_state >= 8)
		{
            DrawText (textFont, tcolor, 270, 140,String.format("%d",gameLogic.GetFeedsStat()) ,shadow:true);
		}
        if (sp_state >= 10)
		{
            DrawText (textFont, tcolor, 25, 200,"Press Space to Continue",shadow:true);
		}
    }
}