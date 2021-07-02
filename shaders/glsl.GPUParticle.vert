#pragma header
uniform float u_time;
mat4 rotaion(float degrees){
	float tx = openfl_TextureSize.x * 0.5;
	float ty = openfl_TextureSize.y * 0.5;
	float tz = 0.;
	float radian = degrees * 3.14 / 180.;
	float c = cos(radian);
	float s = sin(radian);
	float x = 0.;
	float y = 0.;
	float z = 1.;
	float x2 = x * x;
	float y2 = y * y;
	float z2 = z * z;
	float ls = x2 + y2 + z2;
	if(ls != 0.){
		float l = 1.;
		x /= l;
		y /= l;
		z /= l;
		x2 /= ls;
		y2 /= ls;
		z2 /= ls;
	}
	float ccos = 1. - c;
	mat4 d = openfl_Matrix;
	d[0].x = x2 + (y2 + z2) * c;
	d[0].y = x * y * ccos + z * s;
	d[0].z = x * z * ccos - y * s;
	d[1].x = x * y * ccos - z * s;
	d[1].y = y2 + (x2 + z2) * c;
	d[1].z = y * z * ccos + x * s;
	d[2].x = x * z * ccos + y * s;
	d[2].y = y * z * ccos - x * s;
	d[2].z = z2 + (x2 + y2) * c;
	d[3].x = (tx * (y2 + z2) - x * (ty * y + tz * z)) * ccos + (ty * z - tz * y) * s;
	d[3].y = (ty * (x2 + z2) - y * (tx * x + tz * z)) * ccos + (tz * x - tx * z) * s;
	d[3].z = (tz * (x2 + y2) - z * (tx * x + ty * y)) * ccos + (tx * y - ty * x) * s;
	return d;
}
mat4 scale(float xScale, float yScale){
	return mat4(xScale, 0.0, 0.0, 0.0, 0.0, yScale, 0.0, 0.0, 0.0, 0.0, 1., 0.0, 0.0, 0.0, 0.0, 1.0);
}
mat4 translation(float x, float y){
	return mat4(0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., x, y, 0., 0.);
}
void main(void){
	#pragma body
	mat4 d = rotaion(360. * sin(u_time));
	mat4 s = scale(1., 1.);
	mat4 t = translation(1.,- 1.);
	gl_Position = (openfl_Matrix + t) * d * s * openfl_Position;
}