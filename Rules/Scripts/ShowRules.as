#include "Hitters.as";

bool show = true;
void onTick(CRules@ this)
{
    if(getGameTime() % 20 == 0)
    {
        if(isClient() == true)
        {
            if(show == true)
            {
              GUI::DrawTextCentered("TEST", Vec2f(0, 0), SColor(255, 0, 0, 0));
            }
        }
    }
}