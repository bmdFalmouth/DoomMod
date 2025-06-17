class MyPlayer : DoomPlayer
{
    default{
        speed 3;
        Player.StartItem "Pet";
    }

    override void Tick()
    {
        Super.Tick();
    }

}