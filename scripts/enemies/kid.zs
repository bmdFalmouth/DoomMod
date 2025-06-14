class Kid : Actor
{
	Default
	{
		Health 20;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 200;
		Monster;
		+FLOORCLIP
		Tag "$FN_CHILD";
		Scale 0.2;
	}
	States
	{
	Spawn:
		TBID A -1 A_Look;
		Loop;
	See:
		TBID ABBCCDD 4 A_Chase;
		Loop;
	Missile:
		TBID A 0 A_FaceTarget;
		TBID A 0;
		Goto See;
	Pain:
		TBID A 0;
		TBID A 0 A_Pain;
		Goto See;
	Death:
		POSS H 5;
		POSS I 5 A_Scream;
		POSS J 5 A_NoBlocking;
		POSS K 5;
		POSS L -1;
		Stop;
    }
}