// Vehicle Workshop

#include "Requirements.as"
#include "Requirements_Tech.as"
#include "ShopCommon.as"
#include "Descriptions.as"
#include "Costs.as"
#include "CheckSpam.as"
#include "TeamIconToken.as"

void onInit(CBlob@ this)
{
	this.set_TileType("background tile", CMap::tile_wood_back);

	this.getSprite().SetZ(-50); //background
	this.getShape().getConsts().mapCollisions = false;

	this.Tag("has window");

	//INIT COSTS
	InitCosts();

	// SHOP
	this.set_Vec2f("shop offset", Vec2f_zero);
	this.set_Vec2f("shop menu size", Vec2f(7, 7));
	this.set_string("shop description", "Buy");
	this.set_u8("shop icon", 25);

	int team_num = this.getTeamNum();

	{
		string cata_icon = getTeamIcon("catapult", "VehicleIcons.png", team_num, Vec2f(32, 32), 0);
		ShopItem@ s = addShopItem(this, "Catapult", cata_icon, "catapult", cata_icon + "\n\n\n" + Descriptions::catapult, false, true);
		s.crate_icon = 4;
		AddRequirement(s.requirements, "coin", "", "Coins", CTFCosts::catapult);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 150);
	}
	{
		string ballista_icon = getTeamIcon("ballista", "VehicleIcons.png", team_num, Vec2f(32, 32), 1);
		ShopItem@ s = addShopItem(this, "Ballista", ballista_icon, "ballista", ballista_icon + "\n\n\n" + Descriptions::ballista, false, true);
		s.crate_icon = 5;
		AddRequirement(s.requirements, "coin", "", "Coins", CTFCosts::ballista);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 210);
	}
	{
		string bomber_icon = getTeamIcon("bomber", "VehicleIcons.png", team_num, Vec2f(32, 32), 2);
		ShopItem@ s = addShopItem(this, "Bomber", bomber_icon, "bomber", bomber_icon + "\n\n\n" + "Balloon.\nServes as excellent air support for the main troops. Can drop bombs on [SPACE]", false, true);
		AddRequirement(s.requirements, "coin", "", "Coins", 500);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 250);
	}
	{
		string longboat_icon = getTeamIcon("longboat", "VehicleIcons.png", team_num, Vec2f(32, 32), 4);
		ShopItem@ s = addShopItem(this, "Long Boat", longboat_icon, "longboat", longboat_icon + "\n\n\n" + "Long Boat.\nServes as excellent air support for the main troops. Can drop bombs on [SPACE]", false, true);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 250);
	}
	{
		string dinghy_icon = getTeamIcon("dinghy", "VehicleIcons.png", team_num, Vec2f(32, 32), 5);
		ShopItem@ s = addShopItem(this, "Dinghy", dinghy_icon, "dinghy", dinghy_icon + "\n\n\n" + "Dinghy.\nServes as excellent air support for the main troops. Can drop bombs on [SPACE]", false, true);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 150);
	}

}

void GetButtonsFor(CBlob@ this, CBlob@ caller)
{
	this.set_bool("shop available", this.isOverlapping(caller));
}

void onCommand(CBlob@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID("shop made item client") && isClient())
	{
		this.getSprite().PlaySound("/ChaChing.ogg");
	}
}
