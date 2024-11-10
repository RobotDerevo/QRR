#include "RPChat.as";

const string rules = "Welcome to the ql-rp. Please read rules:\n1.Don't be an asshole\n2.You must roleplay\n3.Don't Griefing\n4.Don't spamming\n5.Don't playing using  a MG(Meta Gaming)\n6.Don't hacking\n7.Don't Suicide for a dumb way\n8.Don't Use bugs and exploits  or Power Gaming\n9.Providing false information to the administration\n10.Random Deathmatch (killing everyone for nothing/being orc) is banned";
bool render = true;

void onRender(CRules@ this)
{
    if(render != true)
    {
        return;
    }
    GUI::DrawTextCentered(rules, getDriver().getScreenCenterPos(), SColor(255, 255, 255, 255));
}