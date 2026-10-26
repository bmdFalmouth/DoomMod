class TutorialLogicThinker : Thinker
{

    override void PostBeginPlay()
    {
        Super.PostBeginPlay();
        //Init();
    }

    void Init()
    {

    }

    static TutorialLogicThinker GetInstance()
    {
        ThinkerIterator thinkerIter = ThinkerIterator.Create("TutorialLogicThinker");
        Thinker t=thinkerIter.Next();
        if (t)
            return TutorialLogicThinker(t);
        
        TutorialLogicThinker tutorialLogic=new("TutorialLogicThinker");
        //gameLogic.Init();
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