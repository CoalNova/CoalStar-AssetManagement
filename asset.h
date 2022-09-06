#pragma once
#include <stdio.h>

namespace Coal
{
	namespace CoalTypes
	{

		class Asset
		{
		public:
			/// <summary>
			/// Constructor
			/// </summary>
			/// <param name="assetID">Unique Asset ID Number</param>
			Asset(unsigned int assetID);

			/// <summary>
			/// Move Constructor
			/// </summary>
			/// <param name="asset"></param>
			Asset(Asset&& asset);

			/// <summary>
			/// Copy Constructor
			/// </summary>
			/// <param name="asset"></param>
			Asset(Asset& asset);

			/// <summary>
			/// Assignment Operator is Copy
			/// </summary>
			/// <param name="asset"></param>
			Asset operator=(Asset rhd);

			/// <summary>
			/// Destructor
			/// </summary>
			~Asset();

			/// <summary>
			/// Returns Protected Asset ID
			/// </summary>
			const unsigned int GetID()const;

			/// <summary>
			/// Increments And Returns Dependancy Count
			/// </summary>
			const size_t AddDependant();

			/// <summary>
			/// Decrements And Returns Dependancy Count
			/// </summary>
			const size_t RemoveDependant();

			virtual bool NeedsLoaded() = 0;

		protected:
			unsigned int _assetID;
			size_t* dependants;
		};

	}
}