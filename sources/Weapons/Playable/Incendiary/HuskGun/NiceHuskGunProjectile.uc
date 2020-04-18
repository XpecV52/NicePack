class NiceHuskGunProjectile extends ScrnHuskGunProjectile;
simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
    local vector X;
    local Vector TempHitLocation, HitNormal;
    local array<int>    HitPoints;
    local KFPawn HitPawn;
    // Don't let it hit this player, or blow up on another player
    if ( Other == none || Other == Instigator || Other.Base == Instigator )
       return;
    // Don't collide with bullet whip attachments
    if( KFBulletWhipAttachment(Other) != none )
    {
       return;
    }
    // Don't allow hits on poeple on the same team
    if( KFHumanPawn(Other) != none && Instigator != none
       && KFHumanPawn(Other).PlayerReplicationInfo.Team.TeamIndex == Instigator.PlayerReplicationInfo.Team.TeamIndex )
    {
       return;
    }
    if( !bDud )
    {
       Explode(HitLocation,Normal(HitLocation-Other.Location));
    }
    // Use the instigator's location if it exists. This fixes issues with
    // the original location of the projectile being really far away from
    // the real Origloc due to it taking a couple of milliseconds to
    // replicate the location to the client and the first replicated location has
    // already moved quite a bit.
    if( Instigator != none )
    {
       OrigLoc = Instigator.Location;
    }
    X = Vector(Rotation);
    if( Role == ROLE_Authority )
    {
        if( ROBulletWhipAttachment(Other) != none )
       {
           if(!Other.Base.bDeleteMe)
           {
               Other = Instigator.HitPointTrace(TempHitLocation, HitNormal, HitLocation + (200 * X), HitPoints, HitLocation,, 1);

               if( Other == none || HitPoints.Length == 0 )
                   return;

               HitPawn = KFPawn(Other);

               if (Role == ROLE_Authority)
               {
                   if ( HitPawn != none )
                   {
                        // Hit detection debugging
                       /*log("Bullet hit "$HitPawn.PlayerReplicationInfo.PlayerName);
                       HitPawn.HitStart = HitLocation;
                       HitPawn.HitEnd = HitLocation + (65535 * X);*/

                       if( !HitPawn.bDeleteMe )
                           HitPawn.ProcessLocationalDamage(ImpactDamage, Instigator, TempHitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType,HitPoints);

                       // Hit detection debugging
                       //if( Level.NetMode == NM_Standalone)
                       //    HitPawn.DrawBoneLocation();
                   }
               }
           }
       }
       else
       {
           if (Pawn(Other) != none && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))
           {
               Pawn(Other).TakeDamage(ImpactDamage * HeadShotDamageMult, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
           }
           else
           {
               Other.TakeDamage(ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
           }
       }
    }
}
// Overrided to not use alternate burning mechanism
simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
    local actor Victims;
    local float damageScale, dist;
    local vector dirs;
    local int NumKilled;
    local Pawn P;
    local KFMonster KFMonsterVictim;
    local KFPawn KFP;
    local array<Pawn> CheckedPawns;
    local int i;
    local bool bAlreadyChecked;
    //local int OldHealth;
    if ( bHurtEntry )
       return;
    bHurtEntry = true;
    foreach CollidingActors (class 'Actor', Victims, DamageRadius, HitLocation) {
       // null pawn variables here just to be sure they didn't left from previous iteration
       // and waste another day of my life to looking for this fucking bug -- PooSH /totallyPissedOff!!!
       P = none;
       KFMonsterVictim = none;
       KFP = none;
       if(Victims == none)
           continue;
       // don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
       if( (Victims != self) && (Victims != Instigator) &&(Hurtwall != Victims)
               && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo')
               && ExtendedZCollision(Victims)==none && KFBulletWhipAttachment(Victims)==none )
       {
           dirs = Victims.Location - HitLocation;
           dist = FMax(1,VSize(dirs));
           dirs = dirs/dist;
           damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
           if ( Instigator == none || Instigator.Controller == none )
               Victims.SetDelayedDamageInstigatorController( InstigatorController );
           if ( Victims == LastTouched )
               LastTouched = none;

           P = Pawn(Victims);

           if( P != none ) {
               for (i = 0; i < CheckedPawns.Length; i++) {
                   if (CheckedPawns[i] == P) {
                       bAlreadyChecked = true;
                       break;
                   }
               }

               if( bAlreadyChecked )
               {
                   bAlreadyChecked = false;
                   P = none;
                   continue;
               }

               if( KFMonsterVictim != none && KFMonsterVictim.Health <= 0 ) {
                   KFMonsterVictim = none;
               }

               KFMonsterVictim = KFMonster(Victims);
               KFP = KFPawn(Victims);

               if( KFMonsterVictim != none )
                   damageScale *= KFMonsterVictim.GetExposureTo(HitLocation);
               else if( KFP != none )
                   damageScale *= KFP.GetExposureTo(HitLocation);

               CheckedPawns[CheckedPawns.Length] = P;

               if ( damageScale <= 0)
                   continue;
           }

           Victims.TakeDamage
           (
               damageScale * DamageAmount,
               Instigator,
               Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dirs,
               (damageScale * Momentum * dirs),
               DamageType
           );

           if( Role == ROLE_Authority && KFMonsterVictim != none && KFMonsterVictim.Health <= 0 )
           {
               NumKilled++;
           }
       }
    }
    if( Role == ROLE_Authority )
    {
       if( NumKilled >= 4 )
       {
           KFGameType(Level.Game).DramaticEvent(0.05);
       }
       else if( NumKilled >= 2 )
       {
           KFGameType(Level.Game).DramaticEvent(0.03);
       }
    }
    bHurtEntry = false;
}
defaultproperties
{
    HeadShotDamageMult=1.500000
    ImpactDamageType=Class'NicePack.NiceDamTypeHuskGunProjectileImpact'
    ImpactDamage=50
}
