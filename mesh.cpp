#include "mesh.h"

namespace Coal
{
	namespace CoalTypes
	{
		void Mesh::Print() {}
		Mesh::Mesh(Mesh&& mesh) noexcept : Asset(mesh) {}
		Mesh::Mesh(Mesh& mesh) : Asset(mesh) {}
		Mesh Mesh::operator=(Mesh rhd) { *dependants += 1; return rhd; }
		Mesh::Mesh(unsigned int assetID) : Asset(assetID)
		{

		}
		Mesh::~Mesh()
		{
		}
	}
}