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
		Speed 2;
		PainChance 200;
		Monster;
		+FLOORCLIP
		Tag "$CAT";
		Scale 0.2;		
	}

	int purrs;
	int sleepCounter;
	int sleepSeconds;

	States
	{
	Spawn:
		TBID A -1 
		{
			purrs=0;
			sleepCounter=0;
			sleepSeconds=0;
			console.printf("Cat spawned");
			A_Look();
		}
		Loop;
	See:
		TBID A 1 
		{
			console.printf("Cat sees player");
			A_Chase();
		}
		Loop;

	Melee:
	Missile:
		TBID A 1 
		{
			console.printf("Cat facing missile");
			A_FaceTarget();
		}
		Goto See;
	Pain:
		TBID A 1;
		TBID A 1
		{
			console.printf("Cat in pain");
			A_Pain();
		}
		Goto See;
	Death:
		TBID A 1
		{
			console.printf("Cat is sleeping");
		}
		TBID A 1 A_Scream;
		TBID A 1;
		TBID A 1 A_NoBlocking;
		TBSL A -1;
		Stop;
	Raise:
		TBSL A 1;
		TBID A 1;
		Goto See;
    }

	void TakeHugs()
	{
		purrs++;
		if (purrs >= 5)
		{
			console.printf("Cat is purring happily!");
			purrs = 0; // Reset purr count after reaching threshold
			//A_StopSound(CHAN_VOICE);
			SetState(FindState("Death"));
		}
		else
		{
			console.printf("Cat received a hug, total purrs: %d", purrs);
			A_StartSound("enemies/cat/purr1");
		}
	}

	override void Tick()
	{
		Super.Tick();
		
		if (InStateSequence(FindState("Death"),ResolveState("Death")))
		{
			sleepCounter++;
			if ((sleepCounter%35)==0)
			{
				sleepSeconds++;
			}
			if (sleepSeconds>5)
			{
				sleepCounter=0;
				sleepSeconds=0;
				SetState(FindState("Raise"));
			}
		}
	}
}