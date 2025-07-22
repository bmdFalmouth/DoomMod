class MyPlayer : DoomPlayer
{
    default{
        speed 1;
        Height 64;
        Player.ViewHeight 80;
        Player.StartItem "Pet";
        Player.StartItem "FoodPuch";
        Player.StartItem "Dreamies";
        Player.WeaponSlot 1,"Pet";
        Player.WeaponSlot 2,"FoodPuch";
        Player.WeaponSlot 3,"Dreamies";
    }

    override void Tick()
    {
        Super.Tick();
    }

}