// QL-RP PNG loader base class - extend this to add your own PNG loading functionality!

#include "BasePNGLoader.as";
#include "MinimapHook.as";
#include "CustomBlocks.as";

// QL-RP custom map colors
namespace rp_colors
{
	enum color
	{
		tradingpost = 0xFFadea8b,
		rp_spawn = 0xFF00ffff,
		orange = 0xFF4e2710,
		red = 0xFF321105,
		green = 0xFF091c09,
		blue = 0xFF1e2254,
		lb = 0xFF0a3740,
		darkpurple = 0xFF1c1d32,
		purple = 0xFF1c0730,
		color_newsand = 0xFFecd590
	};
}

//the loader

class RPPNGLoader : PNGLoader
{
	RPPNGLoader()
	{
		super();
	}

	//override this to extend functionality per-pixel.
	void handlePixel(const SColor &in pixel, int offset) override
	{
		PNGLoader::handlePixel(pixel, offset);

		switch (pixel.color)
		{
			case rp_colors::tradingpost: autotile(offset); spawnBlob(map, "tradingpost", offset, -1); break;
			case rp_colors::orange: autotile(offset); spawnBlob(map, "hall", offset, 4); break;
			case rp_colors::red: autotile(offset); spawnBlob(map, "hall", offset, 1); break;
			case rp_colors::green: autotile(offset); spawnBlob(map, "hall", offset, 2); break;
			case rp_colors::blue: autotile(offset); spawnBlob(map, "hall", offset, 0); break;
			case rp_colors::lb: autotile(offset); spawnBlob(map, "hall", offset, 5); break;
			case rp_colors::darkpurple: autotile(offset); spawnBlob(map, "hall", offset, 6); break;
			case rp_colors::purple: autotile(offset); spawnBlob(map, "hall", offset, 3); break;
			
			case rp_colors::color_newsand:
			{
				map.SetTile(offset, CMap::tile_newsand);
				break;
			}
		};
	}
};

// --------------------------------------------------

bool LoadMap(CMap@ map, const string& in fileName)
{
	print("LOADING RP PNG MAP " + fileName);

	RPPNGLoader loader();

	MiniMap::Initialise();

	return loader.loadMap(map , fileName);
}
