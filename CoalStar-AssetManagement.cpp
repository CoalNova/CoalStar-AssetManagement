#include <stdio.h>
#include "meshmanager.h"



int main()
{
	using namespace Coal;
	using namespace CoalTypes;
	using namespace CoalSystem;

	Mesh* meshes[16];

	for (int i = 0; i < 16; i++)
	{
		meshes[i] = new Mesh(i);
	}

	for (int i = 0; i < 16; i++)
	{

		delete meshes[i];
	}

}