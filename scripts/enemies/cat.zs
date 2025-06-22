class Cat : Actor
{
	Default
	{
		//$Title "Cat"
        //$Category "Monsters"
		//$Sprite "TBIDA0"
		Health 20;
		Radius 20;
		Height 56;
		Speed 2;
		PainChance 200;
		Monster;
		+FLOORCLIP
		Tag "$CAT";
		Scale 0.2;		
		Cat.Hunger 100;
	}

	int purrs;
	int sleepCounter;
	int sleepSeconds;
	int hunger;
	int hungerCounter;
	int hungerSeconds;
	int soundChannel;

	int seeCounter;
	CatFood catFood;

	property Hunger: hunger;

	States
	{
	Spawn:
		TBID A 1
		{
			console.printf("Cat spawned");
			purrs=0;
			sleepCounter=0;
			sleepSeconds=0;
			hungerCounter=0;
			hungerSeconds=0;
			soundChannel=10;
			seeCounter=0;

		}
		TBID A 1 A_Look;
		loop;
	See:
		TBID A 2 
		{
			console.printf("Cat sees player");
			A_Chase();
		}
		Loop;
	Melee:
	Missile:
		TBID A 8 
		{
			console.printf("Cat facing missile");
			A_FaceTarget();
		}
		TBID A 6
		{
			if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>60))
			{
				A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
			}
		}
		Goto See;
	Pain:
		TBID A 1;
		TBID A 1
		{
			console.printf("Cat in pain");
			A_Pain();
		}
		Goto See;
	Death:
		TBSL A 1
		{
			console.printf("Cat is sleeping");
			sleepCounter++;
			if ((sleepCounter%35)==0)
			{
				sleepSeconds++;
			}
			if (sleepSeconds>5)
			{
				sleepCounter=0;
				sleepSeconds=0;
				return ResolveState("Raise");
			}
			return ResolveState(null);
		}
		loop;
	Raise:
		TBSL A 1;
		TBID A 1;
		Goto See;
	Hungry:
		TBID A 1
		{
			console.printf("Hungry");
			//https://zdoom.org/wiki/Classes:ActorIterator
			catFood=CatFood(Level.CreateActorIterator(200,"CatFood").Next());
			if (catFood!=null)
			{
				console.printf("Found cat food");
				SetOrigin(catFood.pos,true);
				hunger=100;
				return ResolveState("Spawn");

			}
			else
			{
				console.printf("Cat food not found");
				return ResolveState(null);
			}
		}
		loop;
    }

	void TakePet()
	{
		purrs++;
		if (purrs >= 5)
		{
			console.printf("Cat is purring happily!");
			purrs = 0; // Reset purr count after reaching threshold
			A_StopSound(soundChannel);
			SetState(FindState("Death"));
		}
		else
		{
			console.printf("Cat received a hug, total purrs: %d", purrs);
			A_StartSound("enemies/cat/purr1",soundChannel,CHANF_OVERLAP);
		}
	}

	override void Tick()
	{
		Super.Tick();
	
		//console.printf(String.Format("Hunger %i",hunger));
		hungerCounter++;
		if ((hungerCounter%35)==0)
		{
			hungerSeconds++;
			if (hungerSeconds>10)
			{
				hunger-=60;
				hungerCounter=0;
				hungerSeconds=0;
			}
		}
		if (hunger<50)
		{
			SetState(FindState("Hungry"));
		}
	}

	action void A_Eat()
	{

	}
}