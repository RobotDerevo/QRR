//Just regular events
/*
const string[] events = {
    "Atention! Nuclear War starts over 30 sec.",
    "Atention! Meteor Rain started!"
};
int air;
//(UNNAMED) events

const string[] spacee = {
    "Atention! Heat is very low",
    "Atention! Heat is very high",
    "Atention! Only ",
    "percent of air!",
    "Atention! Temp is ",
    "Atention! The Space-Clown here!"
};

void Event()
{
    if(isClient() == true)
    {
        if(30 < air)
        {
            client_AddToChat(spacee[2] + air + spacee[3], SColor(255, 255, 0, 0));
        }
        else if(0.1 < heat)
        {
            client_AddToChat(spacee[0], SColor(255, 255, 0, 0));
        }
        else if()
    }
}