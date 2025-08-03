class TigerbunIntermission : StatusScreen
{
    override void drawStats()
    {
        drawLF();

        Font textFont = content.mFont;
		let tcolor = content.mColor;

		DrawText (textFont, tcolor, 50, 65, "Hello", shadow:true);

    }
}