
void LoadDefaultMapLoaders()
{
	printf("############ GAMEMODE " + sv_gamemode);
	
	if (sv_gamemode == "ql-rp" || sv_gamemode == "WAR" ||
		sv_gamemode == "Quantal 's Roleplay" || sv_gamemode == "QL-RP")
	{
		RegisterFileExtensionScript("Scripts/MapLoaders/LoadRPPNG.as", "png");
	}
	else if (sv_gamemode == "Challenge" || sv_gamemode == "challenge")
	{
		RegisterFileExtensionScript("Scripts/MapLoaders/LoadChallengePNG.as", "png");
	}
	else if (sv_gamemode == "TDM" || sv_gamemode == "tdm")
	{
		RegisterFileExtensionScript("Scripts/MapLoaders/LoadTDMPNG.as", "png");
	}
	else if (sv_gamemode == "ql-rp" || sv_gamemode == "ql-rp")
	{
		RegisterFileExtensionScript("LoadRPPNG.as", "png");
	}
	else
	{
		RegisterFileExtensionScript("Scripts/MapLoaders/LoadPNGMap.as", "png");
	}


	RegisterFileExtensionScript("Scripts/MapLoaders/GenerateFromKAGGen.as", "kaggen.cfg");
}
