#include "Entites/Items/Explosive/Explosion.as";
#include "Entites/Items/Explosive/ExplodeOnDie.as";
#include "Entites/Common/Colision/NoPlayerCollision.as";

void onInit(CBlob@ this)
{   
    this.Tag("exploding");
    this.Tag("player");
    this.tag("vovovoovovovovovovovovovovovovovovoov")
	this.set_f32("explosive_radius", 3500.0f);
	this.set_f32("explosive_damage", 100.0f);
}