class NiceTrenchgun extends NiceWeapon;
simulated function fillSubReloadStages(){
    // Loading 6 shells during 143 frames tops, with first shell loaded at frame 14, with 18 frames between load moments
    generateReloadStages(6, 143, 14, 18);
}
defaultproperties
{
    reloadType=RTYPE_SINGLE
    ForceZoomOutOnFireTime=0.010000
    MagCapacity=6
    ReloadRate=0.700000
    ReloadAnim="Reload"
    ReloadAnimRate=1.000000
    bHoldToReload=True
    WeaponReloadAnim="Reload_Shotgun"
    Weight=8.000000
    bHasAimingMode=True
    IdleAimAnim="Idle_Iron"
    StandardDisplayFOV=65.000000
    TraderInfoTexture=Texture'KillingFloor2HUD.Trader_Weapon_Icons.Trader_TrenchGun'
    bIsTier2Weapon=True
    MeshRef="KF_Wep_TrenchGun.TrenchGun"
    SkinRefs(0)="KF_Weapons8_Trip_T.Weapons.Trenchgun_cmb"
    SelectSoundRef="KF_PumpSGSnd.SG_Select"
    HudImageRef="KillingFloor2HUD.WeaponSelect.TrenchGun_unselected"
    SelectedHudImageRef="KillingFloor2HUD.WeaponSelect.TrenchGun"
    PlayerIronSightFOV=70.000000
    ZoomedDisplayFOV=50.000000
    FireModeClass(0)=Class'NicePack.NiceTrenchgunFire'
    FireModeClass(1)=Class'KFMod.NoFire'
    PutDownAnim="PutDown"
    AIRating=0.600000
    CurrentRating=0.600000
    bShowChargingBar=True
    Description="A WWII-era trench shotgun in 12 gauge, loaded with Dragon's Breath flame rounds. Toasty."
    DisplayFOV=65.000000
    Priority=142
    InventoryGroup=3
    GroupOffset=14
    PickupClass=Class'NicePack.NiceTrenchgunPickup'
    PlayerViewOffset=(X=20.000000,Y=18.750000,Z=-8.000000)
    BobDamping=7.000000
    AttachmentClass=Class'KFMod.TrenchgunAttachment'
    IconCoords=(X1=169,Y1=172,X2=245,Y2=208)
    ItemName="Dragon's Breath Trenchgun"
    TransientSoundVolume=1.000000
}
