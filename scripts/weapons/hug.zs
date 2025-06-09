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
		HUGI A -1 A_WeaponReady;
        loop;
	Deselect:
		PUNG A 1 A_Lower;
		Loop;
	Select:
		PUNG A 1 A_Raise;
		Loop;
	Fire:
		PUNG B 4;
		PUNG C 4 A_Punch;
		PUNG D 5;
		PUNG C 4;
		PUNG B 5 A_ReFire;
		Goto Ready;
	}
}