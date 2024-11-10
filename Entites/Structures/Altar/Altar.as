#include "StandardRespawnCommand.as"
#include "StandardControlsCommon.as"

void onInit(CBlob@ this)
{
	this.CreateRespawnPoint("ruins", Vec2f(0.0f, 16.0f));
	this.getShape().SetStatic(true);
	this.getShape().getConsts().mapCollisions = false;
	this.getSprite().SetZ(-50.0f);   // push to background
	this.server_setTeamNum(10);
}
