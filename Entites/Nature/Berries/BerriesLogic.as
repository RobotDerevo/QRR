// Flowers logic
int drop = 0;
#include "PlantGrowthCommon.as";

void onInit(CBlob@ this)
{
	this.SetFacingLeft(XORRandom(2) == 0); //random facing
	this.getSprite().ReloadSprites(uint(XORRandom(0)), 0); //random color

	this.getCurrentScript().tickFrequency = 15;
	this.getSprite().SetZ(10.0f);

	this.set_u8(growth_chance, default_growth_chance);
	this.set_u8(growth_time, default_growth_time);

	this.Tag("scenary");
}


void onTick(CBlob@ this)
{
	bool grown = this.hasTag(grown_tag);
	if (grown)
	{
		drop = 3 + XORRandom(4);
	}
}

void onDie(CBlob@ this)
{
	for(int i = 0; i == drop; i++)
	{
		server_CreateBlob("berry", 0, this.getPosition());
	}
}