#include "asset.h"


namespace Coal
{
	namespace CoalTypes
	{
		Asset::Asset(unsigned int assetID) :_assetID(assetID), dependants(nullptr)
		{
			if (NeedsLoaded())
			{
				dependants = new size_t;
				*dependants = 1;
			}
		}
		Asset::Asset(Asset&& asset) noexcept : _assetID(asset._assetID), dependants(asset.dependants) {}
		Asset::Asset(Asset& asset) : _assetID(asset._assetID), dependants(asset.dependants) { *asset.dependants += 1; }
		Asset::~Asset()
		{

			printf("Destroyed Asset %u\n", _assetID);
			delete dependants;
		}
		const unsigned int Asset::GetID() const { return _assetID; };
		const size_t Asset::AddDependant() { *dependants += 1; return *dependants; }
		const size_t Asset::RemoveDependant() { *dependants -= 1; return *dependants; }
	}
}