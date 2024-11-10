void onTick(CBlob@ this)
{
    if(XORRandom(1) == 1)
    {
        this. AddForceAtPosition(Vec2f(3.0 * 3.2, 0), this.getPosition());
    }
    else
    {
        this. AddForceAtPosition(Vec2f(3.0 * -3.2, 0), this.getPosition());
     } 
}
