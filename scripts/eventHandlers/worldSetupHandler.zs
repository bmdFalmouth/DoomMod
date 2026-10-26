class WorldSetupHandler:EventHandler
{
    override void WorldLoaded(WorldEvent e)
    {
        if (Level.LevelNum == 0) // tutorial
        {
            TutorialLogicThinker.GetInstance().Init();
        }
        else{
            GameLogicThinker gameLogic=GameLogicThinker.GetInstance();
            gameLogic.Init();
        }
    }
}