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

	if(leftleg !is null)
	{
		Animation@ def = leftleg.addAnimation("default", 0, false);
		def.AddFrame(0);
		Animation@ run = leftleg.addAnimation("run", 3, true);
		run.AddFrame(1);
		run.AddFrame(2);
		run.AddFrame(3);
		run.AddFrame(4);

		leftleg.SetOffset(ll);
		leftleg.SetRelativeZ(0.22f);
	}

	if(rightleg !is null)
	{
		Animation@ def = rightleg.addAnimation("default", 0, false);
		def.AddFrame(7);
		Animation@ run = rightleg.addAnimation("run", 3, true);
		run.AddFrame(8);
		run.AddFrame(9);
		run.AddFrame(10);
		run.AddFrame(11);

		rightleg.SetOffset(lr);
		rightleg.SetRelativeZ(0.22f);
	}

	if(rightarm !is null)
	{
		Animation@ def = rightarm.addAnimation("default", 0, false);
		def.AddFrame(1);

		rightarm.SetOffset(ar);
		rightarm.SetRelativeZ(-1.0f);
	}

	if(leftarm !is null)
	{
		Animation@ def = leftarm.addAnimation("default", 0, false);
		def.AddFrame(0);

		leftarm.SetOffset(al);
		leftarm.SetRelativeZ(0.22f);
	}
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
	CBlob@ blob = this.getBlob();
	CSpriteLayer@ leftarm = this.getSpriteLayer("arml");
	CSpriteLayer@ rightarm = this.getSpriteLayer("armr");
	CSpriteLayer@ leftleg = this.getSpriteLayer("legl");
	CSpriteLayer@ rightleg = this.getSpriteLayer("legr");

	bool left = blob.isKeyPressed(key_left);
	bool right = blob.isKeyPressed(key_right);
	bool up = blob.isKeyPressed(key_up);
	bool down = blob.isKeyPressed(key_down);

	RunnerMoveVars@ moveVars;
	if (!blob.get("moveVars", @moveVars))
	{
		return;
	}

	if (left || right)
	{
		rightleg.getAnimation("run").time = 3.0f/Maths::Max(moveVars.walkFactor,0.01f);
		rightleg.SetAnimation("run");
		leftleg.getAnimation("run").time = 3.0f/Maths::Max(moveVars.walkFactor,0.01f);
		leftleg.SetAnimation("run");
	}
	else
	{
		rightleg.getAnimation("default");
		rightleg.SetAnimation("default");
		leftleg.getAnimation("default");
		leftleg.SetAnimation("default");
	}
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
