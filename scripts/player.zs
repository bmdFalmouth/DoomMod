class MyPlayer : DoomPlayer
{
    default{
        speed 3;
        Player.StartItem "Hug";
    }

    Cat catActor;

    override void Tick()
    {
        
        if (catActor==null)
        {
            A_Log("No Cat found");
            ActorIterator iter=level.CreateActorIterator(10246,"Cat");
            if (iter!=null)
            {
                A_Log("Looking for cat");
                let cActor=Cat(iter.Next());
                catActor=cActor;
                if (cActor)
                {
                    A_Log("We have a cat");
                }
            }
        }
        else
        {
            A_Log("We have a cat");
            A_Log(catActor.currentStateLabel);
        }
        Super.Tick();
    }

}