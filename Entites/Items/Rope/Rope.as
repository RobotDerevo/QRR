
void onInit(CBlob@ this)
{
    this.addCommandID("use rope");
    this.addCommandID("use rope client");
}

void onCommand(CBlob@ this, u8 cmd, CBitStream@ params, CSprite@ sprite)
{
    if (cmd == this.getCommandID("use rope") && isServer())
	{
        CControls@ controls = getControls();
        CMap@ map = getMap();
        Vec2f cursor = controls.getMouseWorldPos();
        warn("Cursor" + cursor);
        CBlob@ blob = map.getBlobAtPosition(cursor);
        if(blob !is null && blob.hasTag("player"))
        {
            blob.Tag("rope");
            this. server_SetTimeToDie(0.1f);
        }
	}
    else if (cmd == this.getCommandID("use rope client") && isClient())
    {
        sprite.PlaySound("give.ogg");
    }
}

void GetButtonsFor(CBlob@ this, CBlob@ caller)
{
	if (caller.hasTag("dead"))
		return;
	
	caller.CreateGenericButton("$" + this.getName() + "$", Vec2f_zero, this, this.getCommandID("use rope"), "Use Rope");
}
