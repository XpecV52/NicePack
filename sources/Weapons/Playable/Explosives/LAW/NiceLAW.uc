class NiceLAW extends NiceWeapon;
simulated function ZoomIn(bool bAnimateTransition){
    if(Level.TimeSeconds < FireMode[0].NextFireTime)       return;
    super.ZoomIn(bAnimateTransition);
    if(bAnimateTransition){       if(bZoomOutInterrupted)           PlayAnim('Raise',1.0,0.1);       else           PlayAnim('Raise',1.0,0.1);
    }
}
simulated function ZoomOut(bool bAnimateTransition){
    super.ZoomOut(false);
    if(bAnimateTransition)       TweenAnim(IdleAnim,FastZoomOutTime);
}
simulated function PostBeginPlay(){
    local AutoReloadAnimDesc reloadDesc;
    autoReloadsDescriptions.Length = 0;
    reloadDesc.canInterruptFrame    = 0.07;
    reloadDesc.trashStartFrame      = 0.601;
    reloadDesc.resumeFrame          = 0.07;
    reloadDesc.speedFrame           = 0.07;
    reloadDesc.animName = 'AimFire';
    autoReloadsDescriptions[0] = reloadDesc;
    super.PostBeginPlay();
}
defaultproperties
{    bChangeClipIcon=True    bChangeBulletsIcon=True    hudClipTexture=Texture'KillingFloorHUD.HUD.Hud_Law_Rocket'    hudBulletsTexture=Texture'KillingFloorHUD.HUD.Hud_Law_Rocket'    reloadType=RTYPE_AUTO    ForceZoomOutOnFireTime=0.100000    MagCapacity=1    ReloadRate=3.000000    bHoldToReload=True    WeaponReloadAnim="Reload_LAW"    MinimumFireRange=300    Weight=9.000000    bHasAimingMode=True    IdleAimAnim="AimIdle"    StandardDisplayFOV=75.000000    SleeveNum=3    TraderInfoTexture=Texture'KillingFloorHUD.Trader_Weapon_Images.Trader_Law'    bIsTier3Weapon=True    MeshRef="KF_Weapons_Trip.LAW_Trip"    SkinRefs(0)="KF_Weapons_Trip_T.Supers.law_cmb"    SkinRefs(1)="KF_Weapons_Trip_T.Supers.law_reddot_shdr"    SkinRefs(2)="KF_Weapons_Trip_T.Supers.rocket_cmb"    SelectSoundRef="KF_LAWSnd.LAW_Select"    HudImageRef="KillingFloorHUD.WeaponSelect.LAW_unselected"    SelectedHudImageRef="KillingFloorHUD.WeaponSelect.LAW"    PlayerIronSightFOV=90.000000    ZoomTime=0.260000    ZoomedDisplayFOV=65.000000    FireModeClass(0)=Class'NicePack.NiceLAWFire'    FireModeClass(1)=Class'KFMod.NoFire'    PutDownAnim="PutDown"    SelectForce="SwitchToRocketLauncher"    bSniping=False    Description="The Light Anti Tank Weapon is, as its name suggests, a military grade heavy weapons platform designed to disable or outright destroy armored vehicles."    EffectOffset=(X=50.000000,Y=1.000000,Z=10.000000)    DisplayFOV=75.000000    Priority=195    HudColor=(G=0)    InventoryGroup=4    GroupOffset=9    PickupClass=Class'NicePack.NiceLAWPickup'    PlayerViewOffset=(X=30.000000,Y=30.000000)    BobDamping=7.000000    AttachmentClass=Class'NicePack.NiceLAWAttachment'    IconCoords=(X1=429,Y1=212,X2=508,Y2=251)    ItemName="L.A.W"    AmbientGlow=2
}
