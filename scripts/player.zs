class MyPlayer : DoomPlayer
{
    default{
        speed 3;
        Player.StartItem "Hug";
    }

    override void Tick()
    {
        Super.Tick();
    }

}