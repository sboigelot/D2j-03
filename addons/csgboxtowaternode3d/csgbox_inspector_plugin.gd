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
			func(): WaterNode3D.build_water_node_from_csg_box(object)
		)
	if object is CSGCombiner3D:
		build_water_node_button.text = "Build all water node"
		build_water_node_button.pressed.connect(
			func(): 
				for child in object.get_children():
					if child is CSGBox3D:
						WaterNode3D.build_water_node_from_csg_box(child)
		)
	add_custom_control(build_water_node_button)
	
