void onInit(CBlob@ this)
{
    this.maxQuantity = 32;
	this.getCurrentScript().runFlags |= Script::remove_after_this;
}
