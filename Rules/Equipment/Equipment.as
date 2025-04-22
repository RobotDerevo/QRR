#include "RunnerHead.as"

const u8 GRID_SIZE = 48;
const Vec2f MENU_SIZE(1, 3);
const u8 GRID_PADDING = 12;

void onCreateInventoryMenu(CInventory@ this, CBlob@ forBlob, CGridMenu@ menu)
{
	CBlob@ blob = this.getBlob();
	if (blob is null) return;

	const Vec2f INVENTORY_CE = this.getInventorySlots() * GRID_SIZE / 2 + menu.getUpperLeftPosition();
	blob.set_Vec2f("backpack position", INVENTORY_CE);

	blob.ClearGridMenusExceptInventory();

    const Vec2f MENU_CE = Vec2f(0, MENU_SIZE.y * -GRID_SIZE - GRID_PADDING) + INVENTORY_CE;

    CGridMenu@ equip = CreateGridMenu(MENU_CE, blob, MENU_SIZE, "Equipment");

    //equipment
    blob.addCommandID("equip_head");
    blob.addCommandID("equip_torso");
    blob.addCommandID("equip_legs");
    
    CBitStream params;
	params.write_u8(1);
    AddIconToken("$head$", "Head.png", Vec2f(12, 10), 0);
    AddIconToken("$torso$", "Equipemnt.png", Vec2f(12, 10), 0);
    AddIconToken("$legs$", "Legs.png", Vec2f(12, 10), 0);
    CGridButton@ head = equip.AddButton("$head$", "Head", blob.getCommandID("equiphead"), Vec2f(1, 1), params);
    CGridButton@ torso = equip.AddButton("$torso$", "Torso", blob.getCommandID("equipra"), Vec2f(1, 1), params);
    CGridButton@ legs = equip.AddButton("$legs$", "Legs", blob.getCommandID("equiplegs"), Vec2f(1, 1), params);
}

void onCommand(CBlob@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID("equiptorso"))
	{
        CSprite@ sprite = this.getSprite();
        CSpriteLayer@ torso = sprite.getSpriteLayer("torso");
        CBlob@ carb = this.getCarriedBlob();
        if(carb !is null)
        {
            string eq = carb.getName();
            if(eq == "goldbar") torso.SetTexture("GoldArmor.png", 8, 8);
        }
	}
}
