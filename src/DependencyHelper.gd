extends Node

# 🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠
# magic strings never go wrong
# 🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠

var _dependencies: Dictionary = {}

func store(key: String, node: Node) -> void:
	_dependencies[key] = node

func retrieve(key) -> Node:
	return _dependencies[key]
