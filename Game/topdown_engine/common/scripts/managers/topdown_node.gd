extends Node

#topdown node is a base node for all topdown engine nodes
#doesn't do anything, but ensures you have a single point of change should you want your nodes to inherit from somthing else then a plain node
#a frequent use case for this would be adapting scripts
class_name TopDownNode
