#include "RunnerCommon.as"
#include "MakeDustParticle.as";
#include "FallDamageCommon.as";
#include "KnockedCommon.as";

void onInit(CMovement@ this)
{
	this.getCurrentScript().removeIfTag = "dead";
	this.getCurrentScript().runFlags |= Script::tick_not_attached;
}

void onTick(CMovement@ this)
{
	CBlob@ blob = this.getBlob();
	RunnerMoveVars@ moveVars;
	if (!blob.get("moveVars", @moveVars))
	{
		return;
	}
	const bool left		= blob.isKeyPressed(key_left);
	const bool right	= blob.isKeyPressed(key_right);
	const bool up		= blob.isKeyPressed(key_up);
	const bool down		= blob.isKeyPressed(key_down);

	const bool isknocked = isKnocked(blob);

	const bool is_client = getNet().isClient();

	CMap@ map = blob.getMap();
	Vec2f vel = blob.getVelocity();
	Vec2f pos = blob.getPosition();
	CShape@ shape = blob.getShape();

	const f32 vellen = shape.vellen;
	const bool onground = blob.isOnGround() || blob.isOnLadder();

	shape.SetGravityScale(0.0f);
	Vec2f ladderforce;

	if (up)
	{
		ladderforce.y -= 1.0f;
	}

	if (down)
	{
		ladderforce.y += 1.0f;
	}

	if (left)
	{
		ladderforce.x -= 1.0f;
	}

	if (right)
	{
		ladderforce.x += 1.0f;
	}

	blob.AddForce(ladderforce * moveVars.overallScale * 500.0f);
	//damp vel
	vel *= 0.05f;
	blob.setVelocity(vel);

	moveVars.jumpCount = -1;
	moveVars.fallCount = -1;
	//CleanUp(this, blob, moveVars);
	return;
}
