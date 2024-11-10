#include "RPChat.as";
#define SERVER_ONLY

void onTick(CRules@ rules)
{
    if(rpmod == true)
    {
        getNet().server_SendMsg("Rp mode was turned on!");
    }
    else
    {
        getNet().server_SendMsg("Rp mode was turned off!");
    }
}
