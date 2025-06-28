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
	}

	//constants
	const MAX_NO_PURRS=5;
	const MEOW_CHANCE=60;
	const MAX_SECS_SLEEP=5;
	const EAT_AMOUNT=30;
	const HUNGRY_THRESHOLD=50;
	const MAX_SECS_HUNGRY=10;
	const HUNGRY_DECREMENT=20;

	const CAT_FOOD_ID=200;


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
	Vector3 thoughtOffsets;


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
			//if target is food
			if (target.GetClassName()=="CatFood")
				thoughtBubble.ChangeThought(1);
			else
				thoughtBubble.ChangeThought(3);
			console.printf("Cat sees target %s",target.GetClassName());
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
			if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>MEOW_CHANCE))
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
		TBSE A 1
		{
			console.printf("Cat is sleeping");
			thoughtBubble.ChangeThought(2);
			sleepCounter++;
			if ((sleepCounter%35)==0)
			{
				sleepSeconds++;
			}
			if (sleepSeconds>MAX_SECS_SLEEP)
			{
				sleepCounter=0;
				sleepSeconds=0;
				return ResolveState("Raise");
			}
			return ResolveState(null);
		}
		loop;
	Raise:
		TBSE A 1;
		TBID A 1;
		Goto See;
	Hungry:
		TBID A 5
		{
			console.printf("Hungry");
			A_Hungry();
			thoughtBubble.ChangeThought(1);
		}
		loop;
	Eating:
		TBID A 5{
			console.printf("Eating");
			thoughtBubble.ChangeThought(1);
			if (!catFood.IsEmpty())
			{
				catFood.Eat();
				hunger+=EAT_AMOUNT;
				if (hunger>HUNGRY_THRESHOLD)
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
		hunger=100;
		
		thoughtOffsets.x=10;
		thoughtOffsets.y=10;
		thoughtOffsets.z=60;
		thoughtPos=Vec3Offset(thoughtOffsets.x, thoughtOffsets.y, thoughtOffsets.z);

		//spawn thought bubble
		thoughtBubble=ThoughtBubble(Spawn('ThoughtBubble', thoughtPos));
	}


	void TakePet()
	{
		purrs++;
		if (purrs >= MAX_NO_PURRS)
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
			if (hungerSeconds>MAX_SECS_HUNGRY)
			{
				hunger-=HUNGRY_DECREMENT;
				hungerCounter=0;
				hungerSeconds=0;
			}
		}
		if (hunger<HUNGRY_THRESHOLD)
		{
			SetState(FindState("Hungry"));
		}

		//move thought bubble
		//thoughtBubble
		thoughtPos=Vec3Offset(thoughtOffsets.x, thoughtOffsets.y, thoughtOffsets.z);
		thoughtBubble.SetOrigin(thoughtPos,false);
	}

	void A_Hungry()
	{
		//https://zdoom.org/wiki/Classes:ActorIterator
		if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>MEOW_CHANCE))
		{
			A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
		}
		catFood=CatFood(Level.CreateActorIterator(CAT_FOOD_ID,"CatFood").Next());
		if (catFood!=null)
		{
			console.printf("Found cat food");
			A_ClearTarget();
			target=catFood;
			A_Chase();
			console.printf("Target now %s",target.GetClassName());
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