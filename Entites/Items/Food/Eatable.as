#include "EatCommon.as";
#include "Hungry.as";

string desc = "Food De";

void onInit(CBlob@ this)
{
	if (!this.exists("eat sound"))
	{
		this.set_string("eat sound", "/Eat.ogg");
	}
	
	this.addCommandID("eat");

	this.Tag("pushedByDoor");
}

void GetButtonsFor( CBlob@ this, CBlob@ caller )
{
	if (this.getDistanceTo(caller) > 96.0f) return;
	CBitStream params;
	params.write_u16(caller.getNetworkID());
	caller.CreateGenericButton(22, Vec2f(0, 0), this, this.getCommandID("eat"), "Eat\n" + desc, params);
}

void onCommand(CBlob@ this, u8 cmd, CBitStream@ params)
{
	if (cmd == this.getCommandID("eat") && isClient())
	{
		Heal(this, this);
		this.getSprite().PlaySound(this.get_string("eat sound"));
		hungry_level += 10.0f;
	}
}

