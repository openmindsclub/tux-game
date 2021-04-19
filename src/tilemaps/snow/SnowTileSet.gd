tool
extends TileSet

const SNOW_BLOCK: int = 4
const TILTED_SNOW: int = 6

const BINDS: Dictionary = {
	SNOW_BLOCK: [TILTED_SNOW],
	TILTED_SNOW: [SNOW_BLOCK]
}

func _is_tile_bound(drawn_id: int, neighbor_id: int) -> bool:
	return BINDS.has(drawn_id) and neighbor_id in BINDS[drawn_id]

#func _is_tile_bound(drawn_id: int, neighbor_id: int) -> bool:
#	return neighbor_id == drawn_id
