#include "mesh.h"

namespace Coal
{
	Mesh::Mesh(const unsigned int& meshID) : _meshID(meshID)
	{
		//loading of mesh asset data go here 
	}
	Mesh::~Mesh()
	{
		//unloading and handling of GL handles/names go here
	}
}