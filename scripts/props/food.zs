class CatFood : Actor
{
	Default
	{
		//$Title "CatFood"
        //$Category "Props"
		//$Sprite "BOWLA0"
		Health 20;
		Radius 20;
		Height 56;
		Speed 0;
		PainChance 0;
        +SOLID
		+FLOORCLIP
		Tag "$CAT_FOOD";
		Scale 0.2;	
		Monster;	
	}

    States
	{
	Spawn:
		BOWL A -1 A_Look;
		Stop;
    }

}