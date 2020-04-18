// Zombie Monster for KF Invasion gametype
class NiceZombieClotBase extends NiceMonster
    abstract;
#exec OBJ LOAD FILE=KF_Freaks_Trip.ukx
#exec OBJ LOAD FILE=KF_Specimens_Trip_T.utx
var     KFPawn  DisabledPawn;           // The pawn that has been disabled by this zombie's grapple
var     bool    bGrappling;             // This zombie is grappling someone
var     float   GrappleEndTime;         // When the current grapple should be over
var()   float   GrappleDuration;        // How long a grapple by this zombie should last
var    float    ClotGrabMessageDelay;    // Amount of time between a player saying "I've been grabbed" message
replication
{
    reliable if(bNetDirty && Role == ROLE_Authority)
       bGrappling;
}
function BreakGrapple()
{
    if( DisabledPawn != none )
    {
        DisabledPawn.bMovementDisabled = false;
        DisabledPawn = none;
    }
}
//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------
defaultproperties
{
    GrappleDuration=1.500000
    ClotGrabMessageDelay=12.000000
    fuelRatio=0.900000
    clientHeadshotScale=1.500000
    MeleeAnims(0)="ClotGrapple"
    MeleeAnims(1)="ClotGrappleTwo"
    MeleeAnims(2)="ClotGrappleThree"
    bCannibal=True
    MeleeDamage=6
    damageForce=5000
    KFRagdollName="Clot_Trip"
    CrispUpThreshhold=9
    PuntAnim="ClotPunt"
    AdditionalWalkAnims(0)="ClotWalk2"
    Intelligence=BRAINS_Mammal
    bUseExtendedCollision=True
    ColOffset=(Z=48.000000)
    ColRadius=25.000000
    ColHeight=5.000000
    ExtCollAttachBoneName="Collision_Attach"
    SeveredArmAttachScale=0.800000
    SeveredLegAttachScale=0.800000
    SeveredHeadAttachScale=0.800000
    OnlineHeadshotOffset=(X=20.000000,Z=37.000000)
    OnlineHeadshotScale=1.300000
    MotionDetectorThreat=0.340000
    ScoringValue=7
    MeleeRange=20.000000
    GroundSpeed=105.000000
    WaterSpeed=105.000000
    JumpZ=340.000000
    HealthMax=130.000000
    Health=130
    MenuName="Nice Clot"
    MovementAnims(0)="ClotWalk"
    WalkAnims(0)="ClotWalk"
    WalkAnims(1)="ClotWalk"
    WalkAnims(2)="ClotWalk"
    WalkAnims(3)="ClotWalk"
    DrawScale=1.100000
    PrePivot=(Z=5.000000)
    RotationRate=(Yaw=45000,Roll=0)
}
