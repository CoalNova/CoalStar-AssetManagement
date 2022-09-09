#include "meshmanager.h"
#include <vector>
#include <memory>

namespace Coal
{
	auto meshes = std::vector<std::shared_ptr<Mesh>>();

	std::shared_ptr<Mesh> LoadNewMesh(const unsigned int& meshID)
	{
		auto sharedMesh = std::shared_ptr<Mesh>(new Mesh(meshID));
		meshes.push_back(sharedMesh);
		return sharedMesh;
	}

	std::shared_ptr<Mesh> RequestMesh(const unsigned int& meshID)
	{
		//this attempts to find the mesh, if it exists
		auto iter = std::find_if(meshes.begin(), meshes.end(), [meshID](std::shared_ptr<Mesh> mesh) {return mesh.get()->_meshID == meshID; });
		if (iter == meshes.end())
			return LoadNewMesh(meshID);

		return *iter._Ptr;
	}

	void CleanMeshAssets()
	{
		std::erase_if(meshes, [](const auto& mesh) {return mesh.use_count() < 2; });
	}

	void PrintAssetList()
	{
		printf("\nMeshes master list ---------------\n");
		for (const std::shared_ptr<Mesh>& mesh : meshes)
			printf("Mesh %u has %u dependants\n", mesh.get()->_meshID, mesh.use_count() - 1);
		printf("List End ---------------\n");
	}

}