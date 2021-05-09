class_name CommonUtil

static func connect_recursive(node: Node, signal_name, object: Object, method: String, type = null) -> void:
	for _node in node.get_children():
		connect_recursive(_node, signal_name, object, method, type)
	if (type and node is type):
		return
	# warning-ignore:return_value_discarded
	node.connect(signal_name, object, method)

static func get_all_children(node: Node) -> Array:
	var children: Array = node.get_children()
	for child in children.duplicate():
		children.append_array(get_all_children(child))
	return children
