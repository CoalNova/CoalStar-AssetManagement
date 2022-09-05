#include "meshmanager.h"
#include  <vector>

namespace Coal
{
	namespace CoalSystem
	{
		std::vector<CoalTypes::Mesh> meshes = std::vector<CoalTypes::Mesh>();

		CoalTypes::Mesh* RequestMesh(const unsigned int& meshID)
		{
			using namespace CoalTypes;
			std::vector<CoalTypes::Mesh>::iterator iter;
			iter = std::find_if(meshes.begin(), meshes.end(), [meshID](const CoalTypes::Mesh& mesh) { return meshID == mesh.GetID(); });
			if (iter == meshes.end())
			{
				Mesh mesh = Mesh(meshID);
				meshes.push_back(mesh);
				//load mesh data here
				return &meshes.back();
			}
			return iter._Ptr;
		}

		unsigned int ReturnMesh(CoalTypes::Mesh*& mesh)
		{
			if (mesh->RemoveDependant() < 1)
			{
				std::vector<CoalTypes::Mesh>::iterator iter;
				iter = std::find_if(meshes.begin(), meshes.end(), [mesh](const CoalTypes::Mesh& _mesh) { return mesh == &_mesh; });
				if (iter == meshes.end())
				{
					//the provided asset could not be located, but exists.
					//catch and report error as necessary, but issue should should not be terminal to the system, 
					//unless more are using this and it hasn't been added to dependancies.
				}
				meshes.erase(iter);
			}
			return 0;
		}
	}
}