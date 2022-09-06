#pragma once
#include "asset.h"

namespace Coal
{
	namespace CoalTypes
	{
		class Mesh : public Asset
		{
		public:
			Mesh(const unsigned int& meshID);
			void Print();
			bool NeedsLoaded();
		protected:
		};
	}
}