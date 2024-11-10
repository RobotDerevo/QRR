#include "Hitters.as";

f32 onHit(CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitterBlob, u8 customData)
{
	if(customData == Hitters::suicide)
	{
		return 0.0f;
	}
	else
	{
		return damage;
	}
}