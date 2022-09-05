#pragma once
#include "mesh.h"

namespace Coal
{
	namespace CoalSystem
	{
		CoalTypes::Mesh* RequestMesh(const unsigned int& meshID);

		unsigned int ReturnMesh(CoalTypes::Mesh*& mesh);

	}
}