# CoalStar-AssetManagement
## The conceptual system used in the CoalStar project which manages assets in memory.

The purpose for this is to demonstrate a standardized memory handling sequence for game assets. It is designed around a seamless asset swapping environment, with a hierarchical design and multiple users per asset. The goal is that as asset requests cascade downward (setpiece -> mesh -> material -> shader program), the request will utilize already loaded assets, or else load any necessary data from disk. 

The thought process to overwriting memory instead of freeing it is based on the applicatino of an open-world environment. For example: the focal context for asset relevance moves out of a high asset density area to a low density one, only to return back. Each asset no longer relevent would have its subscribers reduced '0'. The new area with new assets would overwrite only a small amount of entries, leaving the rest in stasis. When the focal context returns to the high density area, most of the information is retained to be directly used. If moving between two areas with absolutely different assets the system would have to account for the memory loading/unloading _regardless_.  

This snippet is a dummy partial implementation, for use as a demonstration of design philosophy.