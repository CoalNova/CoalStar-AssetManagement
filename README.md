# CoalStar-AssetManagement
## The conceptual system used in the CoalStar/CoalSpark project which manages assets in memory.

The purpose is for a seamless asset swapping environment, with a hierarchical design. The goal is that asset requests cascade downward. The request will utilize already loaded assets, or else load any necessary data from disk. As well, any asset that is no longer being in use will be unloaded, with memory released. This snippet is a partial implementation, for use as a demonstration of design philosophy.

Code herein utilizes libraries maintained under, and falls under the purview of the ZLib license.
