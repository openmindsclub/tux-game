tool
class_name WeaponMetaSaver extends ResourceFormatSaver

const RECOGNISED_EXTENSIONS: PoolStringArray = PoolStringArray(["res", "tres"])

func get_recognized_extensions(resource: Resource) -> PoolStringArray:
	return RECOGNISED_EXTENSIONS if resource is WeaponMeta else []

func recognize(resource: Resource) -> bool:
	return resource is WeaponMeta

func save(path: String, resource: Resource, flags: int) -> int:
	var error: int = OK
	if (resource is WeaponMeta):
		var meta: WeaponMeta = resource as WeaponMeta
		
		var data: Dictionary = {
			"name": meta.name,
			"texture": meta.texture
		}
		
#		for i in dialog.pages.size() - 1:
#			var page: Dictionary = dialog.pages[i]
#			var content: String = page.get("content", "")
#			var speed: float = page.get("speed", 0.0)
#			data[i] = {"content": content}
#			if (speed > 0):
#				data[i]["speed"] = speed
		
		var file: File = File.new()
		error = file.open(path, File.WRITE)
		if (error == OK):
			file.store_string(JSON.print(data, "\t"))
		file.close()
	else:
		error = ERR_INVALID_DATA
		
	return error
