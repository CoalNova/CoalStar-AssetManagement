#pragma once
#include <stdio.h>

namespace Coal
{
	namespace CoalTypes
	{
		/// <summary>
		/// Asset virtual template
		/// </summary>
		/// <typeparam name="T"></typeparam>
		template<class T>
		class Asset
		{
		public:
			/// <summary>
			/// Constructor
			/// </summary>
			/// <param name="assetID">Unique Asset ID Number</param>
			Asset<T>(unsigned int assetID) :_assetID(assetID), payload(nullptr), dependants(new size_t)
			{
				*dependants = 1;
				printf("Generated Asset %u\n", _assetID);
			}

			/// <summary>
			/// Move Constructor
			/// </summary>
			/// <param name="asset"></param>
			Asset(Asset&& asset) noexcept : _assetID(asset._assetID), payload(asset.payload), dependants(asset.dependants) {}

			/// <summary>
			/// Copy Constructor
			/// </summary>
			/// <param name="asset"></param>
			Asset(Asset& asset) : _assetID(asset._assetID), payload(asset.payload), dependants(asset.dependants) { *asset.dependants += 1; }

			/// <summary>
			/// Assignment Operator is Copy
			/// </summary>
			/// <param name="asset"></param>
			Asset operator=(Asset rhd) { *dependants += 1; return rhd; }

			/// <summary>
			/// Destructor
			/// </summary>
			~Asset()
			{

				printf("Destroyed Asset %u\n", _assetID);
				delete payload; 
				delete dependants;
			}

			/// <summary>
			/// Returns Protected Asset ID
			/// </summary>
			const unsigned int GetID() const { return _assetID; }

			/// <summary>
			/// Increments And Returns Dependancy Count
			/// </summary>
			const size_t AddDependant() { *dependants += 1; return *dependants; }

			/// <summary>
			/// Decrements And Returns Dependancy Count
			/// </summary>
			const size_t RemoveDependant() { *dependants -= 1; return *dependants; }

		protected:
			unsigned int _assetID;
			T* payload;
			size_t* dependants;
		};

	}
}