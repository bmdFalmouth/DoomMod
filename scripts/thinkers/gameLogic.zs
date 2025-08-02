class GameLogicThinker : Thinker
{
    //This is around 5 minutes
    //const MaxGameTime=10500;
    const MaxGameTime=1050;
    int currentGameTime;

    override void PostBeginPlay()
    {
        Super.PostBeginPlay();
        Init();
    }

    void Init()
    {
        currentGameTime=MaxGameTime;
    }

    override void Tick()
    {
        Super.Tick();
        currentGameTime--;
        if (currentGameTime==0)
        {
            Exit_Normal(0);
        }
    }

    clearscope int GetCurrentTime()
    {
        return currentGameTime;
    }

    static GameLogicThinker GetInstance()
    {
        ThinkerIterator thinkerIter = ThinkerIterator.Create("GameLogicThinker");
        Thinker t=thinkerIter.Next();
        if (t)
            return GameLogicThinker(t);
        
        GameLogicThinker gameLogic=new("GameLogicThinker");
        gameLogic.Init();
        return gameLogic;
    }

    static clearscope GameLogicThinker GetInstanceReadOnly()
    {
        ThinkerIterator thinkerIter = ThinkerIterator.Create("GameLogicThinker");
        Thinker t=thinkerIter.Next();
        if (t)
            return GameLogicThinker(t);
        
        return null;
    }
}