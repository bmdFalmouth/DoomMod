class TutorialLogicThinker : Thinker
{
    const CAT_FOOD_ID=200;
    const CAT_ID=100;

    MyPlayer player;
    CatFood catFood;
    Cat cat;

    array <UIEntry> tutorialEntries; 

    override void PostBeginPlay()
    {
        Super.PostBeginPlay();
        tutorialEntries.Clear();

        UIEntry petEntry=New('UIEntry');
        petEntry.setDisplayString("Get close to the cat, and click left mouse to pet");
        petEntry.setPosition((120,5));

        UIEntry completeEntry=New('UIEntry');
        completeEntry.setDisplayString("Completed Tutorial");
        completeEntry.setPosition((120,5));

        tutorialEntries.push(completeEntry);
        tutorialEntries.push(petEntry);

    }

    clearscope UIEntry GetCurrentTutorialEntry()
    {
        return tutorialEntries[tutorialEntries.size()-1];
    }

    void Init()
    {
        //grab all the variables to enable the thinker to do its work
        catFood=CatFood(Level.CreateActorIterator(CAT_FOOD_ID,"CatFood").Next());
        if (catFood!=null)
        {
            console.printf("Tutorial - Found Cat Food");
        }
        cat=Cat(level.CreateActorIterator(CAT_ID,"Cat").Next());
        if (cat!=null)
        {
            console.printf("Tutorial - Found Cat");
        }
        player=MyPlayer(players[consoleplayer].mo);
        if (player!=null)
        {
            player.ClearInventory();
            player.GiveInventory("Dreamies",1);
            player.GiveInventory("FoodPuch",1);
            player.GiveInventory("Pet",1);
            
            console.printf("Tutorial - Found Player");
        }

    }

    void completePetTheCat()
    {
        tutorialEntries.pop();
    }

    static TutorialLogicThinker GetInstance()
    {
        ThinkerIterator thinkerIter = ThinkerIterator.Create("TutorialLogicThinker");
        Thinker t=thinkerIter.Next();
        if (t)
            return TutorialLogicThinker(t);
        
        TutorialLogicThinker tutorialLogic=new("TutorialLogicThinker");
        return tutorialLogic;
    }

    static clearscope TutorialLogicThinker GetInstanceReadOnly()
    {
        ThinkerIterator thinkerIter = ThinkerIterator.Create("TutorialLogicThinker");
        Thinker t=thinkerIter.Next();
        if (t)
            return TutorialLogicThinker(t);
        
        return null;
    }
}