class GameLogicThinker : Thinker
{
    //This is around 5 minutes
    //const MaxGameTime=10500;
    int MaxGameTime;
    int currentGameTime;

    const TicksPerSecond=35;

    int numberOfFeeds;
    int numberOfTreats;
    int numberOfPets;
    int numberOfSleeps;

    const MaxGameTimeID="MaxGameTime";

    override void PostBeginPlay()
    {
        Super.PostBeginPlay();
        //Init();
    }

    void Init()
    {
        MaxGameTime=10500;
        //Read this from the GAMECONSTS
        array<String> gameConstsDataLines;
        // Find a lump named TEXTURES:
        int lumpID = Wads.FindLump("GAMEDATA", 0);
        String gameConstsData= Wads.ReadLump(lumpID);
        //Console.Printf(gameConstsData);
    
        gameConstsData.Split(gameConstsDataLines,"\n");
        foreach(line : gameConstsDataLines)
        {
            line.StripLeftRight();
            //Console.Printf("Data Line %s",line);
            if (line==""){
                continue;
            }

            array<String> dataElements;
            line.Split(dataElements,"=");

            Console.Printf("Data Line %s %s",dataElements[0],dataElements[1]);
            if (dataElements[0]==MaxGameTimeID)
            {
                //Lets split the other side
                array<String> timeElement;
                dataElements[1].Split(timeElement,":");
                int minutes=timeElement[0].ToInt();
                int seconds=timeElement[1].ToInt();
                Console.Printf("Game Time %im : %is",minutes,seconds);

                //we need to validate the above to see if it can be parsed

                MaxGameTime=((minutes*60)+seconds)*TicksPerSecond;
            }
            
        }

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
        //gameLogic.Init();
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