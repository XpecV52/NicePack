class NiceM4Pickup extends NiceWeaponPickup;
defaultproperties
{
    Weight=5.000000
    cost=500
    AmmoCost=20
    BuyClipSize=30
    PowerValue=30
    SpeedValue=90
    RangeValue=60
    Description="A compact assault rifle. Can be fired in semi or full auto with good damage and good accuracy."
    ItemName="M4"
    ItemShortName="M4"
    AmmoItemName="5.56mm Ammo"
    AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
    CorrespondingPerkIndex=3
    EquipmentCategoryID=2
    VariantClasses(0)=Class'KFMod.CamoM4Pickup'
    InventoryType=Class'NicePack.NiceM4AssaultRifle'
    PickupMessage="You got the M4"
    PickupSound=Sound'KF_M4RifleSnd.foley.WEP_M4_Foley_Pickup'
    PickupForce="AssaultRiflePickup"
    StaticMesh=StaticMesh'KF_pickups3_Trip.Rifles.M4_Pickup'
    CollisionRadius=25.000000
    CollisionHeight=5.000000
}
