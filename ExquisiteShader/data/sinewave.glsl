#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;
uniform float p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;




void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

	float color = 0.0;
	color += sin( 3.0*position.x * cos( time / p6 ) * p12 )  +  cos( 3.0*position.y * cos( time / p9 ) * p1 );
	color += sin( 3.0*position.y * sin( time / p7 ) * p3 )  +  cos( 3.0*position.x * sin( time / p10 ) * p2 );
	color += sin( 3.0* position.x * sin( time / p8 ) * p13 )  +  sin( 3.0*position.y * sin( time / p11 ) * p14 );

	color *= sin( time / p15 ) * 0.5;

	float r = color;
	float g = color * p4;
	float b = sin( color + time / 2.0 ) * p5;
	
	gl_FragColor = vec4(r, g, b, 1.0 );

}