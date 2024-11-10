
namespace CMap
{
	enum CustomTiles
	{ 
		tile_iron = 232,
		tile_iron_v1,
		tile_iron_v2,
		tile_iron_v3,
		tile_iron_v4
	};
};

const SColor color_iron(255, 103, 110, 105);

void HandleCustomTile( CMap@ map, int offset, SColor pixel )
{
	if (pixel == color_iron){
		map.SetTile(offset, CMap::tile_iron);
		map.AddTileFlag( offset, Tile::COLLISION | Tile::SOLID);
		//map.AddTileFlag( offset, Tile::BACKGROUND );
		//map.AddTileFlag( offset, Tile::LADDER );
		//map.AddTileFlag( offset, Tile::LIGHT_PASSES );
		//map.AddTileFlag( offset, Tile::WATER_PASSES );
		//map.AddTileFlag( offset, Tile::FLAMMABLE );
		//map.AddTileFlag( offset, Tile::PLATFORM );
		map.AddTileFlag( offset, Tile::LIGHT_SOURCE );
	}
}