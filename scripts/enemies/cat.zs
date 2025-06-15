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

	int purrs;

	States
	{
	Spawn:
		TBID A -1 
		{
			purrs=0;
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
			console.printf("Cat fires missile");
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
			console.printf("Cat is dead");
		}
		TBID A 1 A_Scream;
		TBID A 1;
		TBID A 1 A_NoBlocking;
		TBID A -1;
		Stop;
		
    }

	void TakeHugs()
	{
		purrs++;
		if (purrs >= 5)
		{
			console.printf("Cat is purring happily!");
			purrs = 0; // Reset purr count after reaching threshold
		}
		else
		{
			console.printf("Cat received a hug, total purrs: %d", purrs);
		}
	}
}