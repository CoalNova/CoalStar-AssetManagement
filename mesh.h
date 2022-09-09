#pragma once

namespace Coal
{
	struct Mesh
	{
		Mesh(const unsigned int& meshID);
		~Mesh();
		const unsigned int
			_meshID; //the mesh-specific identification value
		unsigned int
			_vbo, //opengl 'name' of vertex buffer object in gpu memory
			_vao, //gl name of vertex array object, reponsible for maintaining gl states
			_ibo, //gl name of index buffer object, for utilizing drawing by vertex indices
			_numIndices, //number of indices used for drawing by index
			_vio, //gl name of coalstar/coalspark designed "vertex instance object"
			_numInstances; //number of instances when drawing instanced

	};
}