
#include "EmotesCommon.as";

string[] emoteBinds;
int cooldowntime = 3 * 30;
bool iscoldown = false;

void onInit(CBlob@ this)
{
	this.getCurrentScript().runFlags |= Script::tick_myplayer;
	this.getCurrentScript().removeIfTag = "dead";

	CPlayer@ me = getLocalPlayer();
	if (me !is null)
	{
		emoteBinds = readEmoteBindings(me);
	}
}

void onTick(CBlob@ this)
{
	CPlayer@ player = getLocalPlayer();
	CRules@ rules = getRules();
	if (rules.hasTag("reload emotes"))
	{
		rules.Untag("reload emotes");
		onInit(this);
	}
	
	if (getHUD().hasMenus())
	{
		return;
	}

	CControls@ controls = getControls();
	if(iscoldown == false)
	{
		for (uint i = 0; i < 9; i++)
		{
			if (controls.isKeyJustPressed(KEY_NUMPAD1 + i))
			{
				string emotene = "";
				string emotedo = "";
				string emoteen = "";
				if(emoteBinds[9 + i] == "down" || emoteBinds[9 + i] == "up" || emoteBinds[9 + i] == "left" || emoteBinds[9 + i] == "right")
				{
					emotedo = "points ";
					emotene = emotedo + emoteBinds[9 + i] + emoteen;
				}
				else
				{
					emoteen = "s";
					emotedo = "";
					emotene = emoteBinds[9 + i] + emoteen;
				}
				iscoldown = true;
				client_SendChat("$" + emotene, 0);
				iscoldown = true;
				set_emote(this, emoteBinds[9 + i]);
				break;
			}
		}

		if (controls.ActionKeyPressed(AK_BUILD_MODIFIER))
		{
			return;
		}

		for (uint8 i = 0; i < 9; i++)
		{
			if (controls.isKeyJustPressed(KEY_KEY_1 + i))
			{
				string emotene = "";
				string emotedo = "";
				string emoteen = "";
				if(emoteBinds[i] == "down" || emoteBinds[i] == "up" || emoteBinds[i] == "left" || emoteBinds[i] == "right")
				{
					emotedo = "points ";
					emotene = emotedo + emoteBinds[i] + emoteen;
				}
				else
				{
					emoteen = "s";
					emotedo = "";
					emotene = emoteBinds[i] + emoteen;
				}
				iscoldown = true;
				client_SendChat("$" + emotene, 0);
				set_emote(this, emoteBinds[i]);
				break;
			}
		}
	}
	else
	{
		if(getGameTime() % cooldowntime == 0)
		{
			iscoldown = false;
		}
	}
}
