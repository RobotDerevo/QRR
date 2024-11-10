//string desc = "Food De";
CBlob@ server_MakeFood(Vec2f atpos, const string &in name, const u8 spriteIndex)
{
	if (!isServer())  return null; 

	CBlob@ blob = server_CreateBlobNoInit("food");
	if (blob !is null)
	{
		blob.setPosition(atpos);
		blob.set_string("food name", name);
		blob.set_u8("food sprite", spriteIndex);
		blob.Init();
	}
	return blob;
}

ShopItem@ addFoodItem(CBlob@ this, const string &in foodName, const u8 spriteIndex,
                      const string &in  description, u16 timeToMakeSecs, const u16 quantityLimit, CBitStream@ requirements = null)
{
	const string newIcon = "$" + foodName + "$";
	AddIconToken(newIcon, "Entities/Items/Food/Food.png", Vec2f(16, 16), spriteIndex);
	ShopItem@ item = addProductionItem(this, foodName, newIcon, "food", description, timeToMakeSecs, false, quantityLimit, requirements);
	if (item !is null)
	{
		item.customData = spriteIndex;
	}
	return item;
}


CBlob@ cookFood(CBlob@ ingredient)
{
	string cookedName;
	u8 spriteIndex;
	string n = ingredient.getName();

	if (n == "fishy")
	{
		cookedName = "Cooked Fish";
		spriteIndex = 1;
		//desc = "Freshly grilled fish";
	}
	else if (n == "steak")
	{
		cookedName = "Cooked Steak";
		spriteIndex = 0;
		//desc = "Freshly prepared bison steak";
	}
	else if (n == "grain")
	{
		cookedName = "Bread";
		spriteIndex = 4;
		//desc = "Delicious freshly baked whole grain bread";
	}
	else if (n == "egg")
	{
		cookedName = "Cake";
		spriteIndex = 5;
		//desc = "Sweet cake with icing";
	}
	else if (n == "bucket")
	{
		cookedName = "Beer";
		spriteIndex = 7;
		//desc = "Fresh grain beer";
	}
	else if (n == "brain")
	{
		cookedName = "Cooked Brain";
		spriteIndex = 3;
		//desc = "Rotten cooked brains, looks disgusting";
	}
	else
	{
		return null;
	}

	CBlob@ food = server_MakeFood(ingredient.getPosition(), cookedName, spriteIndex);
	
	ingredient.getSprite().PlaySound("SparkleShort.ogg");
	
	if (food !is null)
	{
		ingredient.server_Die();
		food.setVelocity(ingredient.getVelocity());
		return food;
	}
	
	return null;
}
