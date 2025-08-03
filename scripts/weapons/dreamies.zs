//https://github.com/ZDoom/gzdoom/blob/master/wadsrc/static/zscript/actors/doom/weaponfist.zs
class Dreamies : Weapon 
{
	Default
	{
		Weapon.SelectionOrder 3702;
		Tag "Dreamies";
		+WEAPON.MELEEWEAPON
	}
	States
	{
	Ready:
		DREA A 1 A_WeaponReady;
        loop;
	Deselect:
		DREA A 1 A_Lower;
		Loop;
	Select:
		DREA A 1 A_Raise;
		Loop;
	Fire:
		DREL A 3 A_Feed;
		DREL B 4;
		DREL C 8;
		DREL BA 2;
		Goto Ready;
	AltFire:
		DREA A 3;
		DREA B 4 A_StartSound("weapons/dreamies/shake");
		DREA A 3;
		DREA B 5 A_Shake;
		DREA BA 2;
		Goto Ready;
	}

	const CAT_ID=100;

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
	}

	action void A_Feed()
	{
		FLineTraceData t;

		if (player != null)
		{
			Weapon weap = player.ReadyWeapon;
			if (weap != null && !weap.bDehAmmo && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
			{
				if (!weap.DepleteAmmo (weap.bAltFire))
					return;
			}
		}
		
		double ang = angle + Random2[Punch]() * (5.625 / 256);
		double range = MeleeRange + MELEEDELTA;
		double pitch = AimLineAttack (ang, range, null, 0., ALF_CHECK3D);

		double pz = self.height * 0.5 - self.floorclip + self.player.mo.AttackZOffset*self.player.crouchFactor;
		bool hit = self.LineTrace(
				ang,
				range,
				pitch,
				offsetz: pz,
				data: t);

		if (hit)
		{
			if (t.HitActor){
				Cat cat = Cat(t.HitActor);
				if (cat!=null){
					GameLogicThinker.GetInstance().IncreaseTreatStat();
					cat.TakeDreamies();
				}
			}
		}
	}

	action void A_Shake()
	{
		Cat cat=Cat(Level.CreateActorIterator(CAT_ID,"Cat").Next());
		cat.HearDreamies();
	}
}
