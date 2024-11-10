namespace CMap
{
	enum CustomTiles
	{
		tile_newsand = 220,
		tile_newsand_d1,
		tile_newsand_d2,
		tile_newsand_d3
	};
};

bool isTileSand(TileType tile)
{
	return tile >= CMap::tile_newsand && tile <= CMap::tile_newsand_d3;
}

void onInit(CMap@ this)
{
    this.legacyTileMinimap = false;
	this.MakeMiniMap();
}
