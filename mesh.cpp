#include "mesh.h"

namespace Coal
{
	namespace CoalTypes
	{
		Mesh::Mesh(const unsigned int& meshID) : Asset(meshID)
		{
		}
		void Mesh::Print() {}
		bool Mesh::NeedsLoaded()
		{
			return false;
		}
	}
}