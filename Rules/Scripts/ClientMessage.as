#define CLIENT_ONLY
void onTick(CRules@ this, CPlayer@ player)
{
    string role = "";
    uint8 rolehelpnum = 0;
    const string[] rolehelp = {
        "As a god, you should help new players (in oos chat!) and moderate the game.",
        "As a member, you report to the Leader.",
        "As a leader, you control the life of the empire and all of your citizens!"
    };
    if(player.getUsername() == "QuantalJ")
    {
        role = "God";
        rolehelpnum = 0;
    }
    else
    {
        if(XORRandom(1000) > 300)
        {
            role = "Member";
            rolehelpnum = 1;
        }
        else
        {
            role = "Leader";
            rolehelpnum = 2;
        }
    }
    client_AddToChat("[SERVER]: Weclome to ql-rp -EARTH-, on this roleplay server you can relax\n and play your role!\n Join to us discord: \n Your role: " + role + " . \n" + rolehelp[rolehelpnum], SColor(255, 255, 0, 255));
}