class MyPlayer : DoomPlayer
{
    default{
        speed 2;
        Player.StartItem "Pet";
        Player.StartItem "FoodPuch";
        Player.WeaponSlot 1,"Pet";
        Player.WeaponSlot 2,"FoodPuch";
    }

    override void Tick()
    {
        Super.Tick();
    }

}