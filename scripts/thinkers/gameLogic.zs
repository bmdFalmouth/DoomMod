class GameLogicThinker : Thinker
{
    //This is around 5 minutes
    //const MaxGameTime=10500;
    const MaxGameTime=1050;
    int currentGameTime;

    int numberOfFeeds;
    int numberOfTreats;
    int numberOfPets;
    int numberOfSleeps;

    override void PostBeginPlay()
    {
        Super.PostBeginPlay();
        Init();
    }

    void Init()
    {
        currentGameTime=MaxGameTime;
        numberOfFeeds=0;
        numberOfTreats=0;
        numberOfPets=0;
        numberOfSleeps=0;
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

    void IncreaseFeedStat()
    {
        numberOfFeeds++;
    }

    void IncreaseTreatStat()
    {
        numberOfTreats++;
    }

    void IncreasePetsStat()
    {
        numberOfPets++;
    }

    void IncreaseSleepsStat()
    {
        numberOfSleeps++;
    }

    clearscope String GetStats()
    {
        return String.Format("Sleeps : %d\nTreats : %d\nPets : %d\nFeeds :%d",numberOfSleeps,numberOfTreats,numberOfPets,numberOfFeeds);
    }

    clearscope int GetCurrentTime()
    {
        return currentGameTime;
    }

    clearscope int GetSleepsStat()
    {
        return numberOfSleeps;
    }

    clearscope int GetTreatStat()
    {
        return numberOfTreats;
    }

    clearscope int GetPetsStat()
    {
        return numberOfPets;
    }

    clearscope int GetFeedsStat()
    {
        return numberOfFeeds;
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