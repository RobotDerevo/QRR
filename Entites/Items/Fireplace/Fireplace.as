// Fireplace

#include "ProductionCommon.as";
#include "Requirements.as";
#include "MakeFood.as";
#include "FireParticle.as";
#include "FireCommon.as";
#include "FireplaceCommon.as";
#include "Hitters.as";

void onInit(CBlob@ this)
{
	this.getCurrentScript().tickFrequency = 9;
	this.getSprite().SetEmitSound("CampfireSound.ogg");
	this.getSprite().SetEmitSoundPaused(false);
	this.getSprite().SetAnimation("small");
	this.set_u16("wood", 50);
	this.getSprite().SetFacingLeft(XORRandom(2) == 0);

	this.SetLight(true);
	this.SetLightColor(SColor(255, 255, 240, 171));

	this.Tag("fire source");
	//this.server_SetTimeToDie(60*3);
	this.getSprite().SetZ(-20.0f);
}


void makeLargeSmokeParticle(Vec2f pos, f32 gravity = -0.06f)
{
	string texture;

	texture = "Entities/Effects/Sprites/LargeSmoke.png";

	ParticleAnimated(texture, pos, Vec2f(0, 0), 0.0f, 1.0f, 5, gravity, true);
}

void onTick(CBlob@ this)
{
	CSprite@ sprite = this.getSprite();
	
	if(sprite.isAnimation("large"))
	{
		makeLargeSmokeParticle(this.getPosition() + getRandomVelocity(90.0f, 3.0f, 90.0f));
	}
	else
	{
		makeSmokeParticle(this.getPosition() + getRandomVelocity(90.0f, 3.0f, 90.0f));
	}

	if(this.get_u16("wood") <= 149.0f) sprite.SetAnimation("small");
	if(this.get_u16("wood") >= 150.0f) sprite.SetAnimation("medium");
	if(this.get_u16("wood") >= 250.0f) sprite.SetAnimation("large");
}


void onCollision(CBlob@ this, CBlob@ blob, bool solid)
{	
	if (blob is null) return;
	//blob.Tag(burning_tag);
	//blob.Tag("tick after burning is done");
	blob.Tag("fire source");
	if (blob is null) return;
	
	if (this.getSprite().isAnimation("fire"))
	{
		CBlob@ food = cookFood(blob);
		if (food !is null)
		{
			food.setVelocity(blob.getVelocity().opMul(0.5f));
		}
	}
	else if (blob.hasTag("fire source")) //fire arrow works
	{
		Ignite(this);
	}
	if(blob.getName() == "log")
	{
		this.set_u16("wood", 15);
		blob.server_SetTimeToDie(0.1f);
	}
	if(blob.getName() == "mat_wood")
	{
		this.set_u16("wood", blob.getQuantity());
		blob.server_SetTimeToDie(0.1f);
	}
}

void onInit(CSprite@ this)
{
	this.SetZ(-50); //background

	//init flame layer
	CSpriteLayer@ fire = this.addSpriteLayer("fire_animation_large", "Entities/Effects/Sprites/LargeFire.png", 16, 16, -1, -1);

	if (fire !is null)
	{
		if(this.isAnimation("small"))
		{
			fire.SetOffset(Vec2f(-2.0f, -2.0f));
		}
		else if(this.isAnimation("medium"))
		{
			fire.SetOffset(Vec2f(-2.0f, -4.0f));
		}
		else if(this.isAnimation("large"))
		{
			fire.SetOffset(Vec2f(-2.0f, -6.0f));
		}
		fire.SetRelativeZ(1);
		{
			Animation@ anim = fire.addAnimation("fire", 6, true);
			anim.AddFrame(1);
			anim.AddFrame(2);
			anim.AddFrame(3);
		}
		fire.SetVisible(true);
	}
}

f32 onHit(CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitterBlob, u8 customData)
{
	return damage;
}