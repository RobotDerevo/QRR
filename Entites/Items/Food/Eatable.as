#include "EatCommon.as";

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
	if (this.getDistanceTo(caller) > 96.0f || caller.getHealth() == caller.getInitialHealth()) return;
	CBitStream params;
	params.write_u16(caller.getNetworkID());
	caller.CreateGenericButton(22, Vec2f(0, 0), this, this.getCommandID("eat"), "Eat " + "$egg$", params);
}

void onCommand(CBlob@ this, u8 cmd, CBitStream@ params)
{
	int net_id;
	if (!params.saferead_u16(net_id)) return;
	if (cmd == this.getCommandID("eat") && isClient())
	{
		getBlobByNetworkID(net_id).getSprite().PlaySound(this.get_string("eat sound"));
	}
	if (cmd == this.getCommandID("eat") && isServer())
	{
		Heal(getBlobByNetworkID(net_id), this);
	}
}

