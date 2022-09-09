#include <stdio.h>
#include <memory>
#include "meshmanager.h"
#include "mesh.h"



int main()
{
	//just jam that here to avoid longer declarations
	using namespace Coal;

	//declare test assortment
	const unsigned int soize = 72;
	//scope block to simulate destruction of useage/scope
	{
		//local array of mesh assets
		std::shared_ptr<Mesh> meshes[soize];

		//fill array, passing in overlapping 
		for (int i = 0; i < soize; i++)
		{
			meshes[i] = RequestMesh(i / 8 + 1 / 2);
		}

		//print out full mesh asset list
		PrintAssetList();

		//partially remove entries by replacement
		for (int i = 0; i < soize / 3; i++)
		{
			meshes[i] = 0;
		}
		//perform "not garbage collection" of meshes
		CleanMeshAssets();

		//print again to show after partial removal
		PrintAssetList();
	}

	//perform cleaning after out of scope removal
	CleanMeshAssets();

	//print list, should be empty
	PrintAssetList();


}