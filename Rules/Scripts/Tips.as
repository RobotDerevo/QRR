const string[] good_tips = {
    "Join our discord server where you can report violators, find out information about updates, and chat with other players!",
    "You can take part in the development, for this visit our github!",
    "If you don't understand something, don't be afraid to ask the moderator about it!",
    "Use $ for act-chat, / for normal, without prefix you will use OOC chat!"
};
void onTick(CRules@ this) //Chat Spam
{
    if(getGameTime() % 11000 == 0)
    {
        client_AddToChat("TIP: " + good_tips[XORRandom(good_tips.length)], SColor(255, 145, 145, 225));
    }
}
