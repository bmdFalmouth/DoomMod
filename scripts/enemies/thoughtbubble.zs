class ThoughtBubble : Actor
{
    Default
	{
		//$Title "ThoughtBubble"
        //$Category "Monsters"
		//$Sprite "TBBLA"
		Health 20;
		Radius 10;
		Height 56;
		Speed 2;
		PainChance 200;
		Monster;
		+FLOORCLIP
		Tag "$CAT";
		Scale 0.2;		
	}

    States
	{
	Spawn:
		TBBL A 1;
		loop;
    }
}