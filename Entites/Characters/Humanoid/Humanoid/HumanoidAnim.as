// Builder animations

#include "BuilderCommon.as"
#include "FireCommon.as"
#include "Requirements.as"
#include "RunnerAnimCommon.as"
#include "RunnerCommon.as"
#include "KnockedCommon.as"
#include "PixelOffsets.as"
#include "RunnerTextures.as"
#include "Accolades.as"


Vec2f ar = Vec2f(-5.0f, -2.0f);
Vec2f al = Vec2f(2.0f, -2.0f);
Vec2f lr = Vec2f(2.0f, 0.0f);
Vec2f ll = Vec2f(1.0f, 0.0f);
f32 angle = 90.0f;

//Right arm is main

void onInit(CSprite@ this)
{
	
	LoadSprites(this);
	this.getCurrentScript().runFlags |= Script::tick_not_infire;

	this.getBlob().set_string("prev_attack_anim", "strike");

	CSpriteLayer@ rightarm = this.addSpriteLayer("armr", "Human_Arms.png", 32, 32);
	CSpriteLayer@ leftarm = this.addSpriteLayer("arml", "Human_Arms.png", 32, 32);
	CSpriteLayer@ leftleg = this.addSpriteLayer("legl", "Human_Legs.png", 32, 32);
	CSpriteLayer@ rightleg = this.addSpriteLayer("legr", "Human_Legs.png", 32, 32);
	leftleg.SetFrameIndex(0);
	rightleg.SetFrameIndex(7);
	rightarm.SetFrameIndex(1);
	leftarm.SetFrameIndex(0);
	rightarm.SetOffset(ar);
	leftarm.SetOffset(al);
	leftleg.SetOffset(ll);
	rightleg.SetOffset(lr);
	rightarm.SetRelativeZ(-1.0f);
	leftarm.SetRelativeZ(1.0f);
	leftleg.SetRelativeZ(0.22f);
	rightleg.SetRelativeZ(0.22f);
}

void onPlayerInfoChanged(CSprite@ this)
{
	LoadSprites(this);
}

void LoadSprites(CSprite@ this)
{
	int armour = PLAYER_ARMOUR_STANDARD;

	CPlayer@ p = this.getBlob().getPlayer();
	if (p !is null)
	{
		armour = p.getArmourSet();
		if (armour == PLAYER_ARMOUR_STANDARD)
		{
			Accolades@ acc = getPlayerAccolades(p.getUsername());
			if (acc.hasCape())
			{
				armour = PLAYER_ARMOUR_CAPE;
			}
		}
	}

	switch (armour)
	{
	case PLAYER_ARMOUR_STANDARD:
		ensureCorrectRunnerTexture(this, "humanoid", "Humanoid");
		break;
	case PLAYER_ARMOUR_CAPE:
		ensureCorrectRunnerTexture(this, "builder_cape", "BuilderCape");
		break;
	case PLAYER_ARMOUR_GOLD:
		ensureCorrectRunnerTexture(this, "builder_gold", "BuilderGold");
		break;
	}

}

void onTick(CSprite@ this)
{
	CSpriteLayer@ leftarm = this.getSpriteLayer("arml");
	CSpriteLayer@ rightarm = this.getSpriteLayer("armr");
	if (this.isFacingLeft())
	{
		angle = -90.0f;
	}
	else
	{
		angle = 90.0f;
	}
	leftarm.ResetTransform();
	leftarm.RotateByDegrees(angle, Vec2f(0, 0));
	rightarm.ResetTransform();
	rightarm.RotateByDegrees(angle, Vec2f(0, 0));
}
