#pragma once
#include "asset.h"

namespace Coal
{
	namespace CoalTypes
	{
		class Mesh : public Asset<float>
		{
		public:
			void Print();
			Mesh(Mesh&& mesh) noexcept;
			Mesh(Mesh& mesh); 
			Mesh operator=(Mesh rhd);
			Mesh(unsigned int assetID);
			~Mesh();
		protected:
		};
	}
}