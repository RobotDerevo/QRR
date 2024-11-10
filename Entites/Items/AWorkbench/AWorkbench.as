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

	this.Tag("can settle"); //for DieOnCollapse to prevent 2 second life :)

	InitWorkshop(this);
}


void InitWorkshop(CBlob@ this)
{
	InitCosts(); //read from cfg

	this.set_Vec2f("shop offset", Vec2f_zero);
	this.set_Vec2f("shop menu size", Vec2f(5, 5));

	{
		ShopItem@ s = addShopItem(this, "Burger", "$food$", "food", "A Burger, you can eat it!", false);
		AddRequirement(s.requirements, "blob", "grain", "Grain", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Egg", "$egg$", "egg", "An egg.", false);
		AddRequirement(s.requirements, "blob", "heart", "Heart", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Bison", "$crate$", "bison", "A bison, loves burgers.", false);
		AddRequirement(s.requirements, "blob", "heart", "Heart", 2);
		AddRequirement(s.requirements, "blob", "egg", "Egg", 1);
		AddRequirement(s.requirements, "blob", "food", "Burger", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Buy stone", "$mat_stone$", "mat_stone", "Buy stone", false);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 50);
	}
	{
		ShopItem@ s = addShopItem(this, "Buy wood", "$mat_wood$", "mat_wood", "Buy wood", false);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 50);
	}
	{
		ShopItem@ s = addShopItem(this, "Sell stone", "$mat_gold$", "mat_gold", "Sell stone", false);
		AddRequirement(s.requirements, "blob", "mat_stone", "Stone", 250);
	}
	{
		ShopItem@ s = addShopItem(this, "Sell wood", "$mat_gold$", "mat_gold", "Sell wood", false);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 250);
	}
	{
		ShopItem@ s = addShopItem(this, "Gift", "$crate$", "chest", "A gift-chest", false);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 20);
	}
	{
		ShopItem@ s = addShopItem(this, "Iron Crate", "$ircrate$", "ircrate", "An strong iron crate!", false);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 10);
		AddRequirement(s.requirements, "blob", "mat_stone", "Stone", 70);
	}
	{
		ShopItem@ s = addShopItem(this, "Advanced Drill", "$advdrill$", "advdrill", "A better drill with better timeout for mining \n Crate in", false, true);
		AddRequirement(s.requirements, "blob", "mat_gold", "Gold", 30);
		AddRequirement(s.requirements, "blob", "mat_stone", "Stone", 100);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 30);
	}
	{
		ShopItem@ s = addShopItem(this, "Bomber", "$crate$", "bomber", "A fast baloon, you can fly with your friends!", false, true);
		AddRequirement(s.requirements, "blob", "mat_stone", "Stone", 10);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 50);
	}
	{
		ShopItem@ s = addShopItem(this, "Catapult", "$crate$", "catapult", "A catapult for jump in enemy bases!", false, true);
		AddRequirement(s.requirements, "blob", "mat_stone", "Stone", 20);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 100);
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
