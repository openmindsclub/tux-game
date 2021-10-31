tool
class_name WeaponMetaLoader extends ResourceFormatLoader

const RECOGNISED_EXTENSIONS: PoolStringArray = PoolStringArray(["res", "tres"])
const RESOURCE_TYPE: String = "Resource"

func get_dependencies(path: String, add_types: String) -> void:
	print(path, add_types)

func get_recognized_extensions() -> PoolStringArray:
	return RECOGNISED_EXTENSIONS

func get_resource_type(path: String) -> String:
	return RESOURCE_TYPE if path.get_extension() in RECOGNISED_EXTENSIONS else ""

func handles_type(typename: String) -> bool:
	return typename == RESOURCE_TYPE

func load(path: String, original_path: String):
	var resource: Resource = null
	
	var file: File = File.new()
	var error: int = file.open(original_path, File.READ)
	if (error != OK):
		printerr("Can not load file: %s" % original_path)
		return error
	
	var content: String = file.get_as_text()
	file.close()
	
	var parse_result: JSONParseResult = JSON.parse(content)
	if (parse_result.error != OK):
		printerr(parse_result.error_string)
		return parse_result.error
	
	var data: Dictionary = parse_result.result
	
	if !(data["name"] is String and data.get("speed", 0.0) is float and data["pages"] is Array):
		printerr("invalid dialog file")
		return ERR_PARSE_ERROR
	
	resource = WeaponMeta.new()
	resource.take_over_path(original_path)
	
	return resource
