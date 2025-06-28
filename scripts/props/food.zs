class CatFood : Actor
{
	Default
	{
		//$Title "CatFood"
        //$Category "Props"
		//$Sprite "BOWLA"
		Health 20;
		Radius 5;
		Height 56;
		Speed 0;
		PainChance 0;
        +SOLID
		+FLOORCLIP
		Tag "$CAT_FOOD";
		Scale 0.2;	
		Monster;	
	}

	//constants
	const EAT_AMOUNT=25;

	int amount;

    States
	{
	Spawn:
		BOWL A -1 A_Look;
		Stop;
    }

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		amount=100;
	}

	bool IsEmpty()
	{
		if (amount<50)
			return true;
		
		return false;
	}

	void Eat()
	{
		amount-=EAT_AMOUNT;
		console.printf("Eat %d", amount);
	}

}