# CoalStar-AssetManagement
## The conceptual system used in the CoalStar project which manages assets in memory.

The purpose for this is to demonstrate a standardized memory handling sequence for game assets. It is designed to facilitate a seamless asset swapping environment, with a hierarchical design and multiple users per asset. The goal is that as asset requests cascade downward (setpiece -> mesh -> material -> shader program), the request will utilize already loaded assets, or else load any necessary data from disk. 

The thought process to overwriting memory instead of freeing it when no longer is based on the fundamentals of an open-world environment. For example: the focal context for asset relevance moves out of a high asset density area to a low density one, only to return back. Each asset no longer relevent would have its subscribers reduced '0' but retain in memory. The new area with new assets would overwrite only a small amount of entries, leaving the rest in stasis. When the focal context returns to the high density area, most of the information still persists, and may be used again immediately. 

--- 

This snippet is a dummy partial implementation, for use as a demonstration of design philosophy. Useage is just running, and produces two users before releasing them back. 