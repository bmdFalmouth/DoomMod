class MyPlayer : DoomPlayer
{
    default{
        speed 1;
        Height 64;
        Player.ViewHeight 80;
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