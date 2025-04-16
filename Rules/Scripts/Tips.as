const string[] good_tips = {
    "Use research shop for get books and basic sciense in game",
    "Use !rules for get rules info and !update for update info",
    "Join discord link in tab, where you can: add suggestions in game, read rules and help with developement!",
    "In game we haves 5 races: Orcs, Humans, Demons, Elves, Dwarfs you need know it, if you playing for medic",
    "It mod created by QuantalJ and he team",
    "We have discord channel #wiki where you can know a info about mod.",
    "If you want to build good base, use more iron and stone.",
    "Use kitchen to cook various food!",
    "QL-RP named so because first author is QuantalJ and RP because it roleplay mod.",
    "Magic is not banned, hehe",
    "In mod we have 6 mechanics to live your player: Temperature, Hear, Air procent, Hp, Drink, Eat",
    "Use $ for act chat, ! for occ chat, and & for DG 's Chat",
    "You can be admin! Just ask moderator for it."
};
void onTick(CRules@ this) //Chat Spam
{
    if(getGameTime() % 9000 == 0)
    {
        client_AddToChat("Tip: " + good_tips[XORRandom(good_tips.length)], SColor(255, 145, 145, 225));
    }
}
