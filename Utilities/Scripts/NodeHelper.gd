class_name NodeHelper

static func clear_children(node:Node, keep_count:int = 0) -> void:
	for n in node.get_children():
		if keep_count > 0:
			keep_count -= 1
			continue
		node.remove_child(n)
		n.queue_free()

static func connect_if_not_connected(signal_target:Signal, callable:Callable):
	if not signal_target.is_connected(callable):
		signal_target.connect(callable)

static func disconnect_if_connected(signal_target:Signal, callable:Callable):
	if signal_target.is_connected(callable):
		signal_target.disconnect(callable)
