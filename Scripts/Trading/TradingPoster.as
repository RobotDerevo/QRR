// Workbench

#include "Requirements.as"
#include "ShopCommon.as"
#include "Descriptions.as"
#include "Costs.as"
#include "CheckSpam.as"
string chiname = "Chicken";

void onInit(CBlob@ this)
{
	this.getSprite().SetZ(-50); //background
	this.getShape().getConsts().mapCollisions = false;

	this.Tag("can settle"); //for DieOnCollapse to prevent 2 second life :) Good live xd

	InitWorkshop(this);
}


void InitWorkshop(CBlob@ this)
{
	InitCosts(); //read from cfg

	this.set_Vec2f("shop offset", Vec2f_zero);
	this.set_Vec2f("shop menu size", Vec2f(3, 3));
	{
		ShopItem@ s = addShopItem(this, "Stone", "$mat_stone$", "mat_stone", "Buy Stone", false);
		AddRequirement(s.requirements, "coin", "coin", "Coins", 100);
	}
	{
		ShopItem@ s = addShopItem(this, "Wood", "$mat_wood$", "mat_wood", "Buy Wood", false);
		AddRequirement(s.requirements, "coin", "coin", "Coins", 75);
	}
	{
		ShopItem@ s = addShopItem(this, "Iron", "$mat_wood$", "mat_iron", "Buy Iron Ore", false);
		AddRequirement(s.requirements, "coin", "coin", "Coins", 150);
	}
	{
		ShopItem@ s = addShopItem(this, "Coal", "$mat_wood$", "mat_coal", "Buy Coal", false);
		AddRequirement(s.requirements, "coin", "coin", "Coins", 125);
	}
	{
		ShopItem@ s = addShopItem(this, "Gold", "$mat_gold$", "mat_gold", "Buy Gold", false);
		AddRequirement(s.requirements, "coin", "coin", "Coins", 100);
	}
	{
		ShopItem@ s = addShopItem(this, "Coins", "$mat_gold$", "coin", "Sell Gold", false);
		AddRequirement(s.requirements, "coin", "coin", "Gold", 50);
	}
}
void onCommand(CBlob@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID("shop made item client") && isClient())
	{
		this.getSprite().PlaySound("/ConstructShort");
	}
}

//sprite - planks layer

void onInit(CSprite@ this)
{
	this.SetZ(50); //foreground

	CBlob@ blob = this.getBlob();
	CSpriteLayer@ planks = this.addSpriteLayer("planks", this.getFilename() , 16, 16, blob.getTeamNum(), blob.getSkinNum());

	if (planks !is null)
	{
		Animation@ anim = planks.addAnimation("default", 0, false);
		anim.AddFrame(6);
		planks.SetOffset(Vec2f(3.0f, -7.0f));
		planks.SetRelativeZ(-100);
	}
}
