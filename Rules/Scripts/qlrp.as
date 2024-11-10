//--------
// The rules script
//--------
#include "RPChat.as";
#include "BasePNGLoader.as";
#define SERVER_ONLY

void onInit(CRules@ this)
{
	if (!this.exists("default class"))
	{
		this.set_string("default class", "peasant");
	}
}

void onPlayerRequestSpawn(CRules@ this, CPlayer@ player)
{
	Respawn(this, player);
}

CBlob@ Respawn(CRules@ this, CPlayer@ player)
{
	if (player !is null)
	{
		// remove previous players blob
		CBlob @blob = player.getBlob();

		if (blob !is null)
		{
			CBlob @blob = player.getBlob();
			blob.server_SetPlayer(null);
			blob.server_Die();
		}
		CBlob @newBlob = server_CreateBlob("peasant", XORRandom(7), getSpawnLocation(player));
		newBlob.server_SetPlayer(player);
		player.client_ChangeTeam(player.getTeamNum());
		return newBlob;
	}

	return null;
}

Vec2f getSpawnLocation(CPlayer@ player)
{
	Vec2f[] spawns;

	if (getMap().getMarkers("blue main spawn", spawns))
	{
		return spawns[ XORRandom(spawns.length) ];
	}
	else if (getMap().getMarkers("ruins", spawns))
	{
		return spawns[ XORRandom(spawns.length) ];
	}

	return Vec2f(0, 0);
}