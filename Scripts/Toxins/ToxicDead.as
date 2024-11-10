int toxicdamage = XORRandom(50) + 10;


void onTick(CBlob@ this, CPlayer@ player)
{
    CCamera@ camera = getCamera();
    Vec2f oldcamerapos = camera.getPosition();
	camera.setPosition(Vec2f(Maths::Cos(getGameTime()) + oldcamerapos.x, Maths::Sin(getGameTime()) + oldcamerapos.y));
    if(getGameTime() % 30 == 0)
    {
        if(XORRandom(3) == 0)
        {
            SetScreenFlash(255, 15, 165, 65, 0.75f);
        }
        //server_Hit(this, this.getPosition(), Vec2f(1, 1), 0.5, 0);
        client_SendChat("$pukes", 0);
    }
}