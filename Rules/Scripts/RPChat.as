#include "Rules.as";
int kssec = 1;
int kstic = kssec * 30;
bool rpmod = true;
string message = "nomessage";
string[] chaprob = {
    "QuantalJ"
};
bool onClientProcessChat(CRules@ this, const string &in textIn, string &out textOut, CPlayer@ player)
{
    if(player.getUsername() == "StonesRabbit" || player.getUsername() == "QuantalJ" || player.getUsername() == "loku")
    {
        CMap@ map;
        CSecurity@ security;
        CBlob@ blob = player.getBlob();
        if(textIn.substr(0, 1) == "#")
        {
            textOut = "[ADMIN]: " + textIn.substr(1, 1000000);
            return true;
        }
        else if(textIn == "!rpo")
        {
            rpmod = false;
            message = "[SERVER]: Rp mode turned off!";
            return true;
        }
        else if(textIn == "!rpe")
        {
            rpmod = true;
            message = "[SERVER]: Rp mode turned on!";
            return true;
        }
    }
    if(rpmod == true)
    {
        if(textIn == "!confirm")
        {
            if(player.isMyPlayer() == true)
            {
                client_AddToChat("You confirmed rules.", SColor(255, 255, 0, 0));
                render = false;
            }
        }
        if(textIn == "!rules")
        {
            if(player.isMyPlayer() == true)
            {
                client_AddToChat("ERROR", SColor(255, 255, 0, 0));    
            }
        }
        if(textIn == "!update")
        {
            if(player.isMyPlayer() == true)
            {
                client_AddToChat(" v.1.2 =beta=  added: eat button, rules, background sand", SColor(255, 0, 0, 0));
            }
        }
        if(textIn.substr(0, 1) == "!")
        {
            textOut = "[OCC]: " + textIn.substr(1, 1000000);
            return true;
        }
        if(textIn.substr(0, 1) == "$" && player.getBlob() !is null)
        {
            textOut = "*" + textIn.substr(1, 1000000) + "*";
            return true;
        }
        if(textIn == "!map" || textIn == "!rules" || textIn == "!lobby" || textIn == "!update" || textIn == "!rpo" || textIn == "!rpe" || textIn == "!sound")
        {
            print("ADVANCED COMMANDS USE");
            textOut = ""; 
        }
        else
        {
            if(player.getBlob() !is null)
            {
                textOut = textIn;
                // getRules().SetCurrentState(GAME);
                // this.server_AddToChat("ABOBA", SColor(255, 0, 0, 0));
                // textOut = " ";
                return true;
            }
            else
            {
                textOut = "[OCC]: " + textIn;
                return true;
            }
        }
        return false;
    }
    else
    {
        textOut = "[OCC]: " + textIn;
        return true;
    }
    return false;
}

void onTick(CPlayer@ player, CRules@ this)
{
    if(message != "nomessage")
    {
        client_AddToChat("" + message, SColor(255, 0, 255, 0));
        message = "nomessage";
    }
}
