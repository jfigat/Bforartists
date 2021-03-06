uniform mat4 ModelViewProjectionMatrix;
uniform mat4 ProjectionMatrix;

uniform float pixsize;   /* rv3d->pixsize */
uniform int keep_size;
uniform float objscale;
uniform float pixfactor;

in vec3 pos;
in vec4 color;
in float thickness;
in vec2 uvdata;

out vec4 finalColor;
out float finalThickness;
out vec2 finaluvdata;

#define TRUE 1

float defaultpixsize = pixsize * (1000.0 / pixfactor);

void main()
{
	gl_Position = ModelViewProjectionMatrix * vec4( pos, 1.0 );
	finalColor = color;

	if (keep_size == TRUE) {
		finalThickness = thickness;
	}
	else {
		float size = (ProjectionMatrix[3][3] == 0.0) ? (thickness / (gl_Position.z * defaultpixsize)) : (thickness / defaultpixsize);
		finalThickness = max(size * objscale, 4.0); /* minimum 4 pixels */
	}

	finaluvdata = uvdata;
}
