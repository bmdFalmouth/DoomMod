class Cat : Actor
{
	Default
	{
		//$Title "Cat"
        //$Category "Monsters"
		//$Sprite "TBIDA"
		Health 20;
		Radius 10;
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
	ThoughtBubble thoughtBubble;

	Vector3 thoughtPos;

	property Hunger: hunger;

	States
	{
	Spawn:
		TBID A 1
		{
			console.printf("Cat spawned");
		}
		TBID A 1 A_Look;
		loop;
	See:
		TBID A 2 
		{
			console.printf("Cat sees player %s",target.GetClassName());
			A_Chase();
		}
		Loop;
	Melee:
		TBID A 8 
		{
			console.printf("Cat facing missile");
			A_FaceTarget();
			if (target.GetClassName()=="CatFood")
			{
				return ResolveState("Eating");
			}
			return ResolveState(null);
		}
		TBID A 6
		{
			if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>60))
			{
				A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
				return ResolveState("See");
			}
			return ResolveState(null);
		}
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
		TBID A 5
		{
			console.printf("Hungry");
			A_Hungry();
		}
		loop;
	Eating:
		TBID A 5{
			console.printf("Eating");
			if (!catFood.IsEmpty())
			{
				catFood.Eat();
				hunger+=20;
				if (hunger>50)
				{
					target=players[0].mo;
					return ResolveState("See");
				}
			}
			else{
				return ResolveState("Hungry");
			}

			return ResolveState(null);
		}
		loop;
    }

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		purrs=0;
		sleepCounter=0;
		sleepSeconds=0;
		hungerCounter=0;
		hungerSeconds=0;
		soundChannel=10;
		seeCounter=0;
		thoughtPos=Vec3Offset(10, 10, 60);

		//spawn thought bubble
		thoughtBubble=ThoughtBubble(Spawn('ThoughtBubble', thoughtPos));
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

		//move thought bubble
		//thoughtBubble
		thoughtPos=Vec3Offset(10, 10, 60);
		thoughtBubble.SetOrigin(thoughtPos,false);
	}

	void A_Hungry()
	{
		//https://zdoom.org/wiki/Classes:ActorIterator
		if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>50))
		{
			A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
		}
		catFood=CatFood(Level.CreateActorIterator(200,"CatFood").Next());
		if (catFood!=null)
		{
			console.printf("Found cat food");
			A_ClearTarget();
			target=catFood;
			A_Chase();
			console.printf("Target now %s",target.GetClassName());
			//SetOrigin(catFood.pos,true);
			//SetState(FindState("Eat"));
		}
		else
		{
			console.printf("Cat food not found");
			return;
		}		
	}

	override void CollidedWith(Actor other, bool passive)
	{
		Super.CollidedWith(other,passive);
	}
}