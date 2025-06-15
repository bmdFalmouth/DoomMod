class Hug : Weapon 
{
	Default
	{
		Weapon.SelectionOrder 3700;
		Tag "$TAG_HUG";
		+WEAPON.MELEEWEAPON
	}
	States
	{
	Ready:
		PUNG A -1 A_WeaponReady;
        loop;
	Deselect:
		PUNG A 1 A_Lower;
		Loop;
	Select:
		PUNG A 1 A_Raise;
		Loop;
	Fire:
		PUNG B 4;
		PUNG C 4 A_Hug;
		PUNG D 5;
		PUNG C 4;
		PUNG B 5 A_ReFire;
		Goto Ready;
	}

	action void A_Hug()
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
				data: t
		);

		if (hit)
		{
			console.printf("Hug hit: %s", t.HitActor.GetClassName());
			Cat cat = Cat(t.HitActor);
			cat.TakeHugs();
		}
	}
}
