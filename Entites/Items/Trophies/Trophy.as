void onInit(CBlob@ this, Animation@ sprite)
{
	this.SetLight(true);
	this.SetLightRadius(64.0f);
	this.SetLightColor(SColor(255, 255, 240, 171));
	this.Tag("fire source");
	this.Tag("ignore_arrow");
	this.Tag("ignore fall");
    sprite.SetFrameIndex(XORRandom(4));
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ blob)
{
    return blob.getShape().isStatic();
}
