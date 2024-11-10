// #include "Tree.as";
// #include "Bush.as";
// #include "Flowers.as";
// #include "WorldSeason.as";
// #include "BackgroundSeason.as";

//Seasons
//Author QuantalJ
//Lists and variables

string season = "summer";
int n = -1;
void onTick(CRules@ this)
{
    if(isServer() || sv_test == true)
    {
        if(getGameTime() % 90 == 0 || n <= 3)
        {
            n++;
            switch(n) {
                case 0:
                {
                    season = "winter";
                    break;
                }
                case 1:
                {
                    season = "spring";
                    break;
                }
                case 2:
                {
                    season = "summer";
                    break;
                }
                case 3:
                {
                    season = "autumn";
                    break;
                }
                default:
                {
                    warn("SEASON ERROR");
                }
            }
        }
    }
}