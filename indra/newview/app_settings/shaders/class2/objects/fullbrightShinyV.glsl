/**
 * @file fullbrightShinyV.glsl
 *
 * $LicenseInfo:firstyear=2007&license=viewerlgpl$
 * Second Life Viewer Source Code
 * Copyright (C) 2007, Linden Research, Inc.
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation;
 * version 2.1 of the License only.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 * Linden Research, Inc., 945 Battery Street, San Francisco, CA  94111  USA
 * $/LicenseInfo$
 */

uniform mat3 normal_matrix;
uniform mat4 texture_matrix0;
uniform mat4 texture_matrix1;
uniform mat4 modelview_matrix;
uniform mat4 modelview_projection_matrix;


void calcAtmospherics(vec3 inPositionEye);

uniform vec4 origin;

VARYING float vary_texture_index;

ATTRIBUTE vec3 position;
ATTRIBUTE float texture_index;
ATTRIBUTE vec3 normal;
ATTRIBUTE vec4 diffuse_color;
ATTRIBUTE vec2 texcoord0;

VARYING vec4 vertex_color;
VARYING vec2 vary_texcoord0;
VARYING vec3 vary_texcoord1;
VARYING float fog_depth;

void main()
{
	//transform vertex
	vec4 vert = vec4(position.xyz,1.0);
	vary_texture_index = texture_index;
	vec4 pos = (modelview_matrix * vert);
	gl_Position = modelview_projection_matrix*vec4(position.xyz, 1.0);
	
	vec3 norm = normalize(normal_matrix * normal);
	vec3 ref = reflect(pos.xyz, -norm);

	vary_texcoord0 = (texture_matrix0 * vec4(texcoord0,0,1)).xy;
	vary_texcoord1 = (texture_matrix1*vec4(ref,1.0)).xyz;

	calcAtmospherics(pos.xyz);

	vertex_color = diffuse_color;

	fog_depth = pos.z;
}
