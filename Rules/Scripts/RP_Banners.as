#define CLIENT_ONLY;

#include "GameStateBanners.as";

const u32 buildBannerDuration = 5;
const u32 gameBannerDuration = 20;
const u32 winBannerDuration = 8;

Banner@ getBuildBanner()
{
	u32 duration = buildBannerDuration * getTicksASecond();
	string text = "Build defenses!";
	string secondary_text = "Increased build speed and resupplies";

	Icon@ left_icon = Icon("InteractionIcons.png", 21, Vec2f(32, 32), Vec2f(160, 32), 0);
	Icon@ right_icon = Icon("InteractionIcons.png", 21, Vec2f(32, 32), Vec2f(96, -32), 0);

	Banner banner(duration, text, left_icon, right_icon, true, secondary_text);

	return banner;
}

Banner@ getGameBanner(int team=0)
{
	u32 duration = gameBannerDuration * getTicksASecond();
	string text = "Welcome to QL-RP Read rules:\n 1.Dont be jerk: If administator say something to stop do, please stop it. Dont ruin game to other players.\n 2.Must roleplay: You can't public no roleplay info in rp-chat. \n 3.Grief: Please dont grief other bases with no reason. \n 4.No spamming: Dont spamming in occ chat or rp chat\n 5.Main language is only English: You need talk only on English other languages don't avaliable to roleplay.\n 6.No rp content: You can't build Swastikas or other sympholic buildings.\n 7.No racism:No racism to players in occ chat.\n 8.Normal language: Dont use: plz, pls, afk or others same words in game.\n 9.Hacking: Hacking is banned.\n 10.Stupid character: Your chacter is too can die and he is too scared to die. And too haves limits\n 11.Metagaming: You can't use discord, dm messages, occ chat and other in roleplay.\n 12.Mechanics: Dont use su**de when you in prison or other roleplay situtiaons, you can use it only if your game is dont work how needed, or others techs game situation\n 13.Character limits: You dont know your old live if you respawned or you in new character.\n 14.Bugs: Dont use bugs and exploits in game, if you found a bug type a message in disocrd channel \n";

	Icon@ left_icon = Icon("Blank.png", 0, Vec2f(32, 32), Vec2f(184, 32), team);
	Icon@ right_icon = Icon("Blank.png", 0, Vec2f(32, 32), Vec2f(120, -32), team);

	Banner banner(duration, text, left_icon, right_icon);

	return banner;
}

Banner@ getWinBanner(int team=0)
{
	u32 duration = winBannerDuration * getTicksASecond();
	string text = "{TEAM} team wins";
	string teamName = (team == 0 ? "Blue" : "Red");
	string actual_text = teamName + " team wins";

	Icon@ team_icon = getTeamIcon(team);
	Icon@ left_icon = Icon("MenuItems.png", 31, Vec2f(32, 32), Vec2f(192, 32), team);
	Icon@ right_icon = Icon("MenuItems.png", 31, Vec2f(32, 32), Vec2f(128, -32), team);

	Banner banner(duration, text, left_icon, right_icon, team, true, team_icon);

	return banner;
}

Banner@[] banners;

void onInit(CRules@ this)
{
	banners.push_back(getBuildBanner());
	banners.push_back(getGameBanner());
	banners.push_back(getWinBanner());
}

void onReload(CRules@ this)
{
	banners.clear();
	onInit(this);
}

void onTick(CRules@ this)
{
	if (this.get_bool("Draw Banner"))
	{
		u8 banner_type = this.get_u8("Animate Banner");
		
		if (banner_type >= banners.length)	
			return;
		
		Banner@ banner = banners[banner_type];

		if (banner_type == BannerType::GAME_START)
		{
			CPlayer@ p = getLocalPlayer();
			int team = (p is null ? 0 : p.getTeamNum());
			// show flags of enemy team colour
			team ^= 1;

			banner.setTeam(team);
		}
		else if (banner_type == BannerType::GAME_END) 
		{
			banner.setTeam(this.getTeamWon());
			banner.main_text = banner.main_text.replace("{TEAM}", (banner.team == 0 ? getTranslatedString("Blue") : getTranslatedString("Red")));
		}

		if (this.get_u32("Banner Start") + banner.duration < getGameTime() || banner is null) // banner just finished
		{
			this.set_bool("Draw Banner", false);
			onReload(this);
		}
	}
}

void onRender(CRules@ this)
{
	if (this.get_bool("Draw Banner"))
	{
		u8 banner_type = this.get_u8("Animate Banner");

		Driver@ driver = getDriver();
		if (driver !is null)
		{
			if (bannerPos != bannerDest)
			{
				frameTime = Maths::Min(frameTime + (getRenderDeltaTime() / maxTime), 1);

				bannerPos = Vec2f_lerp(bannerStart, bannerDest, frameTime);
			}

			if (banner_type >= banners.length)
				return;

			Banner@ banner = banners[banner_type];

			if (banner !is null)
			{
				banner.draw(bannerPos);
			}
		}
	}
}