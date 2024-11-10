void onNewPlayerJoin(CRules@ this, CPlayer@ player, CSecurity@ security)
{
    string bad = player.getUsername();
    if(bad == "BohdanU" || bad == "arsenpip")
    {
        if(bad == "arsenpip")
        {
            security.ban(bad, 1440, "Hacking, ban remove 23.07.24");
        }
        else
        {
            security.ban(bad, -1, "Hacking");
        }
    }
    else if(bad.substr(7, 7) == "~" && bad.substr(0, 6) == "BohdanU" || bad.substr(8, 8) == "~" && bad.substr(0, 7) == "arsenpip") //MultiAcc
    {
        if(bad.substr(0, 7) == "arsenpip")
        {
            security.ban(bad, 1440, "Hacking, Your ban be removed 23.07.24");
        }
        if(bad.substr(0, 6) == "BohdanU")
        {
            security.ban(bad, -1, "Hacking");
        }
    }
}