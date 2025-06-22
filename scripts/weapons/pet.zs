//https://github.com/ZDoom/gzdoom/blob/master/wadsrc/static/zscript/actors/doom/weaponfist.zs
class Pet : Weapon 
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
		ARMI A 1 A_WeaponReady;
        loop;
	Deselect:
		ARMI A 1 A_Lower;
		Loop;
	Select:
		ARMI A 1 A_Raise;
		Loop;
	Fire:
		ARMP A 3;
		ARMP B 4;
		ARMP C 3;
		ARMP D 5 A_Pet;
		ARMP C 2;
		ARMP D 5 A_ReFire;
		ARMP CBA 2;
		Goto Ready;
	}

	action void A_Pet()
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
			if (cat!=null)
				cat.TakePet();
		}
	}
}
