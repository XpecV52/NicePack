class NiceHuskGunFire extends ScrnHuskGunFire;
/*
var int         AmmoInCharge;     //current charged amount  var() int       MaxChargeAmmo;    //maximum charge

function Timer()
{
    //local PlayerController Player;
    //consume ammo while charging
    if ( HoldTime > 0.0  && !bNowWaiting && AmmoInCharge < MaxChargeAmmo && Weapon.AmmoAmount(ThisModeNum) > 0 ) {          Charge();       // if (AmmoInCharge == MaxChargeAmmo) {           // Player = Level.GetLocalPlayerController();           // if (Player != none)               // Player.ReceiveLocalizedMessage(class'ScrnBalanceSrv.ScrnPlayerMessage',0);       // }
    }
    super.Timer();
}
function Charge()
{
    local int AmmoShouldConsumed;
    if( HoldTime < MaxChargeTime)       AmmoShouldConsumed = clamp(round(MaxChargeAmmo*HoldTime/MaxChargeTime), 1, MaxChargeAmmo);
    else       AmmoShouldConsumed = MaxChargeAmmo;// full charge
    if (AmmoShouldConsumed != AmmoInCharge) {       if (AmmoShouldConsumed - AmmoInCharge > Weapon.AmmoAmount(ThisModeNum))            AmmoShouldConsumed = Weapon.AmmoAmount(ThisModeNum) + AmmoInCharge;       Weapon.ConsumeAmmo(ThisModeNum, AmmoShouldConsumed - AmmoInCharge);       AmmoInCharge = AmmoShouldConsumed;       ScrnHuskGun(Weapon).ChargeAmount = GetChargeAmount(); 
    }
}
function float GetChargeAmount()
{
  return float(AmmoInCharge) / float(MaxChargeAmmo);
}
simulated function bool AllowFire()
{
    return (Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}
*/
//overrided to restore old damage radius
//(c) PooSH
function PostSpawnProjectile(Projectile P)
{
    local HuskGunProjectile HGP;
    super(KFShotgunFire).PostSpawnProjectile(P);
    HGP = HuskGunProjectile(p);
    if ( HGP != none ) {       if( AmmoInCharge < MaxChargeAmmo )       {           HGP.ImpactDamage *= AmmoInCharge;           HGP.Damage *= 1.0 + GetChargeAmount(); // up to 2x damage           HGP.DamageRadius *= 1.0 + 2 * GetChargeAmount();// up 2x the damage radius       }       else       {           HGP.ImpactDamage *= MaxChargeAmmo; //50*10 = 500           HGP.Damage *= 2.0; // up from 2x           HGP.DamageRadius *= 3.0; // down from x3       }       AmmoInCharge = 0; //reset charge after spawning a projectile       ScrnHuskGun(Weapon).ChargeAmount = 0; 
    }
}
/*
//copy pasted and cutted out ammo consuming, because we did it in time
function ModeDoFire()
{
    local float Rec;
    if (!AllowFire() && HoldTime ~= 0)       return;
    Spread = Default.Spread;
    Rec = 1;
  
    if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
    {       Spread *= KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.ModifyRecoilSpread(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self, Rec);
    }
    if( !bFiringDoesntAffectMovement )
    {       if (FireRate > 0.25)       {           Instigator.Velocity.x *= 0.1;           Instigator.Velocity.y *= 0.1;       }       else       {           Instigator.Velocity.x *= 0.5;           Instigator.Velocity.y *= 0.5;       }
    }
    if (!AllowFire() && HoldTime ~= 0)       return;
    if (MaxHoldTime > 0.0)       HoldTime = FMin(HoldTime, MaxHoldTime);
    // server
    if (Weapon.Role == ROLE_Authority)
    {       Charge();
       DoFireEffect();       HoldTime = 0;    // if bot decides to stop firing, HoldTime must be reset first       if ( (Instigator == none) || (Instigator.Controller == none) )           return;
       if ( AIController(Instigator.Controller) != none )           AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
       Instigator.DeactivateSpawnProtection();
    }
    // client
    if (Instigator.IsLocallyControlled())
    {       ShakeView();       PlayFiring();       FlashMuzzleFlash();       StartMuzzleSmoke();
    }
    else // server
    {       ServerPlayFiring();
    }
    Weapon.IncrementFlashCount(ThisModeNum);
    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {       if (bIsFiring)           NextFireTime += MaxHoldTime + FireRate;       else           NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {       NextFireTime += FireRate;       NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }
    Load = AmmoPerFire;
    HoldTime = 0;
    AmmoInCharge = 0;
    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != none)
    {       bIsFiring = false;       Weapon.PutDown();
    }
    // client
    if (Instigator.IsLocallyControlled())
    {       HandleRecoil(Rec);
    }
}
*/
defaultproperties
{    WeakProjectileClass=Class'NicePack.NiceHuskGunProjectile_Weak'    StrongProjectileClass=Class'NicePack.NiceHuskGunProjectile_Strong'    AmmoClass=Class'NicePack.NiceHuskGunAmmo'    ProjectileClass=Class'NicePack.NiceHuskGunProjectile'
}
