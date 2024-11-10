float hungry_level = 50.0f;
bool caneat = false;

void onTick(CBlob@ this)
{
    if(hungry_level <= 90.9f)
    {
        caneat = true;
    }
    else if (hungry_level > 99.9f)
    {
        hungry_level = 99.9f;
        caneat = false;
    }
}