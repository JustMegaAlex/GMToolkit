
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const vec4 day_color = vec4(1, 1, 1, 1);
const vec4 sunset_color = vec4(240./256., 100./256., 35, 1);
const vec4 night_color = vec4(38./256., 38./256., 0.5, 1);
const vec4 sunrise_color = vec4(0./256., 208./256., 1., 1);

vec4 colors[4];

uniform float day_time;

void main()
{
    colors[0] = day_color;
    colors[1] = sunset_color;
    colors[2] = night_color;
    colors[3] = sunrise_color;
	vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    int first = int(day_time);
    int second = int(mod(day_time + 1., 4.));
    float _time = mod(day_time, 1.);
    vec4 day_night= mix(colors[first], colors[second], _time);
    gl_FragColor = vec4(color.rgb * day_night.rgb, color.a);
}
