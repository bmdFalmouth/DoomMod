class TutorialLogicThinker : Thinker
{
    const CAT_FOOD_ID=200;
    const CAT_ID=100;

    MyPlayer player;
    CatFood catFood;
    Cat cat;

    override void PostBeginPlay()
    {
        Super.PostBeginPlay();
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
            console.printf("Tutorial - Found Player");
        }

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