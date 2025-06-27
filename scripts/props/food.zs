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
		CatFood.Amount 100;
	}

	int amount;
	property Amount: amount;

    States
	{
	Spawn:
		BOWL A -1 A_Look;
		Stop;
    }

	bool IsEmpty()
	{
		if (amount<50)
			return true;
		
		return false;
	}

	void Eat()
	{
		amount-=25;
		console.printf("Eat %d", amount);
	}

}