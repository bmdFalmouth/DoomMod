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

	States
	{
	Spawn:
		TBID A -1 
		{
			console.printf("Cat spawned");
			A_Look();
		}
		Loop;
	See:
		TBID ABBCCDD 4 
		{
			console.printf("Cat sees player");
			A_Chase();
		}
		Loop;

	Melee:
	Missile:
		TBID ABBCCDD 8 
		{
			console.printf("Cat fires missile");
			A_FaceTarget();
		}
		Goto See;
	Pain:
		TBID A 2;
		TBID A 2
		{
			console.printf("Cat in pain");
			A_Pain();
		}
		Goto See;
	Death:
		TBID A 8
		{
			console.printf("Cat is dead");
		}
		TBID A 8 A_Scream;
		TBID A 6;
		TBID A 6 A_NoBlocking;
		TBID A -1;
		Stop;
		
    }
}