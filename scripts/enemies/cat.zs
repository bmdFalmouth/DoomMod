class Cat : Actor
{
	Default
	{
		//$Title "Cat"
        //$Category "Monsters"
		//$Sprite "TBIDA0"
		Health 20;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 200;
		Monster;
		+FLOORCLIP
		Tag "$CAT";
		Scale 0.2;


	}
	States
	{
	Spawn:
		TBID A -1 A_Look;
		Loop;
	See:
		TBID ABBCCDD 4 A_Chase;
		Loop;
    }
}