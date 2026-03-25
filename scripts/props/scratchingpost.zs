class ScratchingPost : Actor
{
	Default
	{
		//$Title "ScratchingPost"
        //$Category "Props"
		//$Sprite "SPOSA0"
		Health 20;
		Radius 10;
		Height 128;
		Speed 0;
		PainChance 0;
        +SOLID
		+FLOORCLIP
		+FORCEXYBILLBOARD
		Tag "$SCRATCHING_POST";
		Scale 0.2;	
		Monster;
	}

    States
	{
	Spawn:
		SPOS A -1;
		Loop;
    }

	override void PostBeginPlay() 
    {
        super.PostBeginPlay();
    }

}