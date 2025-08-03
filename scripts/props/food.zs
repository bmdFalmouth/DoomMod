class CatFood : Actor
{
	Default
	{
		//$Title "CatFood"
        //$Category "Props"
		//$Sprite "BOWLA"
		Health 20;
		Radius 10;
		Height 56;
		Speed 0;
		PainChance 0;
        +SOLID
		+FLOORCLIP
		+FORCEXYBILLBOARD
		Tag "$CAT_FOOD";
		Scale 0.2;	
		Monster;
	}

	static const name BOWL_SPRITES[] = 
    {
        'BOWE',
		'BONE',
		'BOHF',
		'BOWL'

    };

	//constants
	const EAT_AMOUNT=25;

	int amount;
	int currentSpriteState;

    States
	{
	Spawn:
		BOWL A 1;
		Loop;
	Full:
		BOWL A 1;
		Stop;
	Eaten:
		BOHF A 1;
		Stop;
	NearlyEmpty:
		BONE A 1;
		Stop;
	Empty:
		BOWE A 1;
		Stop;
    }

	override void PostBeginPlay() 
    {
        super.PostBeginPlay();
		amount=100;
        sprite = GetSpriteIndex(BOWL_SPRITES[CalculateSpriteIndex()]);
    }

	bool IsEmpty()
	{
		if (amount<25)
			return true;
		
		return false;
	}

	void Eat()
	{
		amount-=2;
		sprite = GetSpriteIndex(BOWL_SPRITES[CalculateSpriteIndex()]);
	}

	int CalculateSpriteIndex()
	{
		return Clamp((amount/EAT_AMOUNT)-1,0,3);
	}

	void Fill()
	{
		amount=100;
		sprite = GetSpriteIndex(BOWL_SPRITES[3]);
	}

}