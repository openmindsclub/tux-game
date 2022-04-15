shader_type canvas_item;
render_mode unshaded;

uniform float blurSize : hint_range(0.0, 5.0);

void fragment()
{
COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, blurSize * abs(cos(TIME/ 5.0)) + 2.0);
}