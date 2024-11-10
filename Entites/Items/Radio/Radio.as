void onInit(CBlob@ this)
{

}

bool onClientProcessChat(CRules@ this, const string &in textIn, string &out textOut, CPlayer@ player, CBlob@ blob)
{
    if(blob.isAttached())
    {
        client_
        textOut = textIn;
        return true;
    }
}