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
        +NOGRAVITY
		Tag "$THOUGHT";
		Scale 0.2;		
	}

    static const name THOUGHT_SPRITES[] = 
    {
        'TBBL',
		'TBHU',
		'TBSL',
		'TBPE'

    };

    States
	{
	Spawn:
		#### A 1;
		loop;
	Blank:
		TBBL A 1;
		loop;
	Hungry:
		TBHU A 1;
		loop;
	Sleep:
		TBSL A 1;
		loop;
	Pets:
		TBPE A 1;
		loop;
    }

	override void PostBeginPlay() 
    {
        super.PostBeginPlay();
        sprite = GetSpriteIndex(THOUGHT_SPRITES[0]);
    }

	void ChangeThought(int thoughtIndex)
	{
		sprite = GetSpriteIndex(THOUGHT_SPRITES[thoughtIndex]);
	}
}