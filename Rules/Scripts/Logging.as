bool confirm = false;
void onNewPlayerJoin(CRules@ this, CPlayer@ player)
{
    if(!isServer()) return;
    string name = player.getUsername();
    getNet().server_SendMsg("SERVER: " + name + " connected");
}