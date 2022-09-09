#pragma once
#include <memory>
#include "mesh.h"

namespace Coal
{
	/// <summary>
	/// The proper method of requesting meshes
	/// </summary>
	/// <param name="meshID"> the ID, name, or other identifier unique to each seperate mesh</param>
	/// <returns>Mesh Shared Pointer</returns>
	std::shared_ptr<Mesh> RequestMesh(const unsigned int& meshID);

	/// <summary>
	/// Checks mesh assets for unused, and performs an unload of assets
	/// </summary>
	/// <returns></returns>
	void CleanMeshAssets();

	/// <summary>
	/// A debug function to output the meshes which are currently loaded, printing their ID and dependant count
	/// </summary>
	void PrintAssetList();

}