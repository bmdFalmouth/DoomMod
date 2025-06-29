//https://github.com/ZDoom/gzdoom/blob/master/wadsrc/static/zscript/actors/doom/weaponfist.zs
class FoodPuch : Weapon 
{
	Default
	{
		Weapon.SelectionOrder 3701;
		Tag "FoodPouch";
		+WEAPON.MELEEWEAPON
	}
	States
	{
	Ready:
		FOOP A 1 A_WeaponReady;
        loop;
	Deselect:
		FOOP A 1 A_Lower;
		Loop;
	Select:
		ARMI A 1 A_Raise;
		Loop;
	Fire:
		FOOP A 3;
		FOOP B 4;
		FOOP C 3;
		FOOP D 5 A_Fill;
		FOOP C 2;
		FOOP D 5 A_ReFire;
		FOOP CBA 2;
		Goto Ready;
	}

	action void A_Fill()
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
			console.printf("Food hit: %s", t.HitActor.GetClassName());
			CatFood bowl = CatFood(t.HitActor);
			if (bowl!=null)
				bowl.Fill();
		}
	}
}
