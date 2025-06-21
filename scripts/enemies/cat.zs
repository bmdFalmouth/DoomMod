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
	int hunger;
	int hungerCounter;
	int hungerSeconds;
	int purrChannel;
	int meowChannel;

	int seeCounter;

	States
	{
	Spawn:
		TBID A -1 
		{
			purrs=0;
			sleepCounter=0;
			sleepSeconds=0;
			hunger=100;
			hungerCounter=0;
			hungerSeconds=0;
			purrChannel=10;
			meowChannel=11;
			seeCounter=0;
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
		TBID A 8 
		{
			console.printf("Cat facing missile");
			A_FaceTarget();
		}
		TBID A 6
		{
			if (!IsActorPlayingSound(meowChannel,"enemies/cat/meow1")){
				A_StartSound("enemies/cat/meow1",meowChannel);
			}
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

	void TakePet()
	{
		purrs++;
		if (purrs >= 5)
		{
			console.printf("Cat is purring happily!");
			purrs = 0; // Reset purr count after reaching threshold
			A_StopSound(purrChannel);
			A_StopSound(meowChannel);
			SetState(FindState("Death"));
		}
		else
		{
			console.printf("Cat received a hug, total purrs: %d", purrs);
			A_StartSound("enemies/cat/purr1",purrChannel);
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
		else
		{
			hungerCounter++;
			if ((hungerCounter%35)==0)
			{
				hungerSeconds++;
				if ((hungerSeconds%10)==0)
				{
					hunger--;
					//if hunger is <50 and food bowl is <50
					//enter hug state!
				}
			}
		}
	}
}