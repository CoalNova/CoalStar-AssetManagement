# CoalStar-AssetManagement
## The conceptual system used in the CoalStar/CoalSpark project which manages assets in memory.

The purpose is for a seamless asset swapping environment, with a hierarchical design. The goal is that asset requests cascade downward, to utilize already loaded assets, or else load any necessary data from disk. As well, any asset that is no longer being will be unloaded, with memory released.

This will appear similar to a smart pointer implementation, but specialized for use within the Coal* Engine(s). Many calls will be generalized or commented as this codebase exists outside the Engine environment.

Code herein utilizes libraries maintained under, and falls under the purview of the ZLib license.
