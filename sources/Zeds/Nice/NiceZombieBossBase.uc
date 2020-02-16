class NiceZombieBossBase extends NiceMonster
    abstract;
#exec OBJ LOAD FILE=KFPatch2.utx
#exec OBJ LOAD FILE=KF_Specimens_Trip_T.utx
var bool bChargingPlayer,bClientCharg,bFireAtWill,bMinigunning,bIsBossView;
var float RageStartTime,LastChainGunTime,LastMissileTime,LastSneakedTime;
var bool bClientMiniGunning;
var name ChargingAnim;        // How he runs when charging the player.
var byte SyringeCount,ClientSyrCount;
var int MGFireCounter;
var vector TraceHitPos;
var Emitter mTracer,mMuzzleFlash;
var bool bClientCloaked;
var float LastCheckTimes;
var int HealingLevels[3],HealingAmount;
var(Sounds)     sound   RocketFireSound;    // The sound of the rocket being fired
var(Sounds)     sound   MiniGunFireSound;   // The sound of the minigun being fired
var(Sounds)     sound   MiniGunSpinSound;   // The sound of the minigun spinning
var(Sounds)     sound   MeleeImpaleHitSound;// The sound of melee impale attack hitting the player
var             float   MGFireDuration;     // How long to fire for this burst
var             float   MGLostSightTimeout; // When to stop firing because we lost sight of the target
var()           float   MGDamage;           // How much damage the MG will do
var()           float   ClawMeleeDamageRange;// How long his arms melee strike is
var()           float   ImpaleMeleeDamageRange;// How long his spike melee strike is
var             float   LastChargeTime;     // Last time the patriarch charged
var             float   LastForceChargeTime;// Last time patriarch was forced to charge
var             int     NumChargeAttacks;   // Number of attacks this charge
var             float   ChargeDamage;       // How much damage he's taken since the last charge
var             float   LastDamageTime;     // Last Time we took damage
// Sneaking
var             float   SneakStartTime;     // When did we start sneaking
var             int     SneakCount;         // Keep track of the loop that sends the boss to initial hunting state
// PipeBomb damage
var()           float   PipeBombDamageScale;// Scale the pipe bomb damage over time
replication
{
    reliable if( Role==ROLE_Authority )       bChargingPlayer,SyringeCount,TraceHitPos,bMinigunning,bIsBossView;
}
//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------
defaultproperties
{    ChargingAnim="RunF"    HealingLevels(0)=5600    HealingLevels(1)=3500    HealingLevels(2)=2187    HealingAmount=1750    MGDamage=6.000000    ClawMeleeDamageRange=85.000000    ImpaleMeleeDamageRange=45.000000    fuelRatio=0.400000    bFrugalFuelUsage=False    clientHeadshotScale=1.200000    ZapThreshold=5.000000    ZappedDamageMod=1.250000    ZapResistanceScale=1.000000    bHarpoonToHeadStuns=False    bHarpoonToBodyStuns=False    ZombieFlag=3    MeleeDamage=75    damageForce=170000    bFatAss=True    KFRagdollName="Patriarch_Trip"    bMeleeStunImmune=True    CrispUpThreshhold=1    bCanDistanceAttackDoors=True    bUseExtendedCollision=True    ColOffset=(Z=65.000000)    ColRadius=27.000000    ColHeight=25.000000    SeveredArmAttachScale=1.100000    SeveredLegAttachScale=1.200000    SeveredHeadAttachScale=1.500000    PlayerCountHealthScale=0.750000    BurningWalkFAnims(0)="WalkF"    BurningWalkFAnims(1)="WalkF"    BurningWalkFAnims(2)="WalkF"    BurningWalkAnims(0)="WalkF"    BurningWalkAnims(1)="WalkF"    BurningWalkAnims(2)="WalkF"    OnlineHeadshotOffset=(X=28.000000,Z=75.000000)    OnlineHeadshotScale=1.200000    HeadHealth=100000.000000    MotionDetectorThreat=10.000000    bOnlyDamagedByCrossbow=True    bBoss=True    ScoringValue=500    IdleHeavyAnim="BossIdle"    IdleRifleAnim="BossIdle"    RagDeathVel=80.000000    RagDeathUpKick=100.000000    MeleeRange=10.000000    GroundSpeed=120.000000    WaterSpeed=120.000000    HealthMax=8000.000000    Health=8000    HeadScale=1.300000    MenuName="Nice Patriarch"    MovementAnims(0)="WalkF"    MovementAnims(1)="WalkF"    MovementAnims(2)="WalkF"    MovementAnims(3)="WalkF"    AirAnims(0)="JumpInAir"    AirAnims(1)="JumpInAir"    AirAnims(2)="JumpInAir"    AirAnims(3)="JumpInAir"    TakeoffAnims(0)="JumpTakeOff"    TakeoffAnims(1)="JumpTakeOff"    TakeoffAnims(2)="JumpTakeOff"    TakeoffAnims(3)="JumpTakeOff"    LandAnims(0)="JumpLanded"    LandAnims(1)="JumpLanded"    LandAnims(2)="JumpLanded"    LandAnims(3)="JumpLanded"    AirStillAnim="JumpInAir"    TakeoffStillAnim="JumpTakeOff"    IdleCrouchAnim="BossIdle"    IdleWeaponAnim="BossIdle"    IdleRestAnim="BossIdle"    DrawScale=1.050000    PrePivot=(Z=3.000000)    SoundVolume=75    bNetNotify=False    Mass=1000.000000    RotationRate=(Yaw=36000,Roll=0)
}
