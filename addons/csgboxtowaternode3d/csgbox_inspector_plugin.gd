@tool
extends EditorInspectorPlugin

var build_water_node_button:Button
var csg_box_3d:CSGBox3D

func _can_handle(object: Object) -> bool:
	if object is CSGBox3D:
		return true
		
	if object is CSGCombiner3D:
		return true
		
	return false

func _parse_begin(object: Object):
	build_water_node_button = Button.new()
	if object is CSGBox3D:
		build_water_node_button.text = "Build water node child"
		build_water_node_button.pressed.connect(
			func(): build_water_node_from_csg_box(object)
		)
	if object is CSGCombiner3D:
		build_water_node_button.text = "Build all water node"
		build_water_node_button.pressed.connect(
			func(): 
				for child in object.get_children():
					if child is CSGBox3D:
						build_water_node_from_csg_box(child)
		)
	add_custom_control(build_water_node_button)
	

static func build_water_node_from_csg_box(csg_box_3d:CSGBox3D) -> void:
	#print("_build_water_node(%s)" % csg_box_3d)
	var water_node:WaterNode3D
	var exisiting:bool = (csg_box_3d.get_child_count() == 1 and 
							csg_box_3d.get_child(0) is WaterNode3D)
							
	#print("\texisiting: %s" % exisiting)
	if exisiting:
		water_node = csg_box_3d.get_child(0)
	else:
		water_node = WaterNode3D.new()
		water_node.name = "water_node"
		
	#print("\tupdating size")
	water_node.water_size = csg_box_3d.size
	if csg_box_3d.size.y > csg_box_3d.size.x:
		water_node.falling_water = true
	
	if not exisiting:
		#print("\tadd_child")
		csg_box_3d.add_child(water_node)
		if Engine.is_editor_hint():
			#water_node.owner = EditorInterface.get_edited_scene_root()
			water_node.owner = EditorInterface.get_edited_scene_root()
	
	#print("\tupdating position")
	water_node.position = Vector3.ZERO
	#water_node.stop_flowing_instant()
	water_node.start_flowing_tween(1.0)
	
	print("\tdone")
