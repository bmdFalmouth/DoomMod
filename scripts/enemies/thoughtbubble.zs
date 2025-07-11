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

	const thoughtSecondsVisible=10;

	bool visible;
	int thoughtCounter;
	int thoughtSeconds;
	
	

    static const name THOUGHT_SPRITES[] = 
    {
        'TBBL',
		'TBHU',
		'TBSL',
		'TBPT'

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
		TBPT A 1;
		loop;
    }

	override void PostBeginPlay() 
    {
        super.PostBeginPlay();
        sprite = GetSpriteIndex(THOUGHT_SPRITES[0]);
		visible=false;
		thoughtCounter=0;
		thoughtSeconds=0;
		//A_SetRenderStyle(1.0,STYLE_None);
		
    }

	void ChangeThought(int thoughtIndex)
	{
		sprite = GetSpriteIndex(THOUGHT_SPRITES[thoughtIndex]);
		//ToggleVisibility();
	}

	override void Tick()
	{
		Super.Tick();
		thoughtCounter++;
		if ((thoughtCounter%35)==0)
		{
			thoughtSeconds++;
			thoughtCounter=0;
		}
		if (visible)
		{
			if (thoughtSeconds>thoughtSecondsVisible)
			{
				//ToggleVisibility();
			}
		}
	}

	void ToggleVisibility()
	{
		visible=!visible;
		int style=STYLE_None;
		if (visible)
			style=STYLE_Normal;
		
		A_SetRenderStyle(1.0,style);
	}
}