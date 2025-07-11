// Merkoss's Plushie

const string[] messages = {
	"Can you stop?",
	"However I'm lazy",
	"Germans arent a majority in kag",
	"Otherwise another nothing happens",
	"Uhm, thats normal",
	"True words",
	"Aliens do exist (deep below)",  //The most funny lol
	"Why did you agree to doing it?",
	"Who kidnapped me this time" // This time :skull:
};

const string[] names = {
	"The Dark Markoss",
	"Merkoss",
	"Markoss",
	"Darkoss",
	"That's Markoss",
	"The Admin",
	"The Quantal's Basement Guy" // this is a joke
};

void onInit(CBlob@ this)
{
	this.Tag("place norotate"); // required
	this.Tag("ignore fall");
	this.Tag("plushie");
	this.setInventoryName(names[XORRandom(names.get_length())] + "'s Plushie");
}

void onTick(CBlob@ this)
{
	AttachmentPoint@ point = this.getAttachments().getAttachmentPointByName("PICKUP");
	CBlob@ holder = point.getOccupied();

	if (holder is null || holder.isAttached()) return;

		if (holder.isKeyPressed(key_action1) && getGameTime() % 60 == 0) // Only 2 second for 1 phrase
		{
			this.Chat(messages[XORRandom(messages.get_length())]);
		}
}
