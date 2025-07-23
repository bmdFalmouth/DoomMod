

class Cat : Actor
{
	Default
	{
		//$Title "Cat"
        //$Category "Monsters"
		//$Sprite "TBIDA"
		Health 20;
		Radius 20;
		Height 32;
		Speed 6;
		PainChance 200;
		MaxStepHeight 64;
		MaxDropOffHeight 64;
		Monster;
		Tag "$CAT";
		Scale 0.3;		
	}

	enum EThoughtImageIndex : uint
	{
    	BLANK,
		HUNGRY,
		SLEEP,
		PETS
	}

	//constants
	const MAX_NO_PURRS=5;
	const MEOW_CHANCE=60;
	const MAX_SECS_SLEEP=5;
	const EAT_AMOUNT=1;
	const HUNGRY_THRESHOLD=50;
	const MAX_SECS_HUNGRY=10;
	const HUNGRY_DECREMENT=20;
	const MAX_SECS_EAT=10;

	const CAT_FOOD_ID=200;


	int purrs;
	int sleepCounter;
	int sleepSeconds;
	int hunger;
	int hungerCounter;
	int hungerSeconds;
	int soundChannel;
	int seeCounter;
	int eatCounter;
	int eatSeconds;
	bool firstSee;

	CatFood catFood;
	ThoughtBubble thoughtBubble;

	Vector3 thoughtPos;
	Vector3 thoughtOffsets;

	Vector3 eatingOffsets;
	Vector3 eatingPos;


	States
	{
	Spawn:
		TBSE A 1 A_Look;
		Goto Death;
	See:
		TBWL ABCDEF 6 
		{
			//if target is food
			if (target!=null){
				if (target.GetClassName()=="CatFood")
					thoughtBubble.ChangeThought(HUNGRY);
				else{
					if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (firstSee))
					{
						A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
						firstSee=false;
					}
					thoughtBubble.ChangeThought(PETS);
				}
			}
			A_Chase();
		}
		Loop;
	Melee:
		TBID A 8 
		{
			A_FaceTarget();
			if (target.GetClassName()=="CatFood")
			{
				Speed=6;
				return ResolveState("Eating");
			}
			return ResolveState(null);
		}
		TBID A 6
		{
			if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>MEOW_CHANCE))
			{
				Speed=6;
				A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
				return ResolveState("See");
			}
			return ResolveState(null);
		}
	Pain:
		TBID A 1;
		TBID A 1
		{
			A_Pain();
		}
		Goto See;
	Death:
		TBSE A 1
		{
			thoughtBubble.ChangeThought(SLEEP);
			sleepCounter++;
			if ((sleepCounter%35)==0)
			{
				sleepSeconds++;
			}
			if (sleepSeconds>MAX_SECS_SLEEP)
			{
				sleepCounter=0;
				sleepSeconds=0;
				firstSee=true;
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
		TBWL ABCDEF 6
		{
			A_Hungry();
			thoughtBubble.ChangeThought(HUNGRY);
		}
		loop;
	Eating:
		//we need to make sure we are just a bit offset from food
		TBEA A 5{
			SetOrigin(eatingPos,false);
			//need to rewrite this!
			thoughtBubble.ChangeThought(HUNGRY);
			if (!catFood.IsEmpty())
			{
				console.printf("Eating");
				catFood.Eat();
				hunger+=EAT_AMOUNT;
				if (hunger>HUNGRY_THRESHOLD)
				{
					target=players[0].mo;
					return ResolveState("See");
				}
			}
			return ResolveState(null);
		}
		loop;

	Pets:
		TBPE ABC 5;
		goto See;
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
		catFood=CatFood(Level.CreateActorIterator(CAT_FOOD_ID,"CatFood").Next());

		eatingOffsets.x=0;
		eatingOffsets.y=0;
		eatingOffsets.z=0;
		eatingPos=catFood.Vec3Offset(eatingOffsets.x,eatingOffsets.y,eatingOffsets.z);


		firstSee=true;
	}


	void TakePet()
	{
		purrs++;
		if (purrs >= MAX_NO_PURRS)
		{
			purrs = 0; // Reset purr count after reaching threshold
			A_StopSound(soundChannel);
			SetState(FindState("Death"));
		}
		else
		{
			A_StartSound("enemies/cat/purr1",soundChannel,CHANF_OVERLAP);
			if (!(InStateSequence(CurState, ResolveState("Pets"))))
			{
				SetState(FindState("Pets"));
			}
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
			if (!(InStateSequence(CurState, ResolveState("Hungry"))))
			{
				SetState(FindState("Hungry"));
			}
		}

		//move thought bubble
		//thoughtBubble
		thoughtPos=Vec3Offset(thoughtOffsets.x, thoughtOffsets.y, thoughtOffsets.z);
		thoughtBubble.SetOrigin(thoughtPos,true);
	}

	void A_Hungry()
	{
		//https://zdoom.org/wiki/Classes:ActorIterator
		if ((!IsActorPlayingSound(soundChannel,"enemies/cat/meow1")) && (Random(0,100)>MEOW_CHANCE))
		{
			A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
		}
		if (catFood!=null)
		{
			A_ClearTarget();
			target=catFood;
			A_Chase();
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

	void HearDreamies()
	{
		A_StartSound("enemies/cat/meow1",soundChannel,CHANF_DEFAULT);
		Speed=30;
		A_Chase("Melee",null,CHF_NORANDOMTURN);
	}

	void TakeDreamies()
	{
		Speed=6;
		hunger+=10;
		SetState(FindState("Pets"));
	}
}