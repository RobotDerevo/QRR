void onTick(CBlob@ this)
{
    if(isClient() == true)
    {
        this.server_setTeamNum(10);
    }
}