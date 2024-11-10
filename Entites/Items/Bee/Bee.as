//Code for bee 
bool beeattack = false;
void onInit(CBlob@ this)
{
    beeattack = false;
    this.Tag("bee");
    this.Tag("beedefense");
    this.server_SetTimeToDie(20 * 60); //Bee cant live more than 1 day
}
void onTick(CBlob@ this)
{
	f32 x = this.getVelocity().x;
	if (Maths::Abs(x) > 1.0f)
	{
		this.SetFacingLeft(x < 0);
	}
	else
	{
		if (this.isKeyPressed(key_left))
			this.SetFacingLeft(true);
		if (this.isKeyPressed(key_right))
			this.SetFacingLeft(false);
	}
    if(XORRandom(500) > 50)
    {
        if(XORRandom(500) > 50)
        {
            this.AddForce(Vec2f(XORRandom(0.3) * this.getMass(), 0.6 * this.getMass()));
        }
        else
        {
            this.AddForce(Vec2f(XORRandom(0.3) - 0.6 * this.getMass(), -3 * this.getMass()));
        }
    }
    else if(XORRandom(800) < 1)
    {
        beeattack = true;
    }
    else
    {
        this.AddForce(Vec2f(0, -0.4 * this.getMass()));
    }
}

void onCollision( CBlob@ this, CBlob@ blob, bool solid )
{
    if(beeattack == false) return;
    if (blob is null) return;
    if(!blob.hasTag("beedefense") && !blob.hasTag("beedamaged") && blob.hasTag("player"))
    {
        //TODO: Lets make it no spam
        //warn("Bee is attacked!");
        blob.Tag("beedamaged");
        blob.server_Hit(blob, blob.getPosition(), Vec2f(1, 1), 0.5, 0);
        this.server_SetTimeToDie(1);
        blob.Untag("beedamaged");
    }
}