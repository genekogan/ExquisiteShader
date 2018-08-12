#define PROCESSING_COLOR_SHADER

uniform vec2 resolution;
uniform float time;
uniform float p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    float a = time*p6;
    float d,e,f,g=1.0/p1,h,i,r,q;
    e=p2*(p.x*0.5+0.5);
    f=p3*(p.y*0.5+0.5);
    i=p4+sin(e*g+a/150.0)*20.0;
    d=p5+cos(f*g/2.0)*18.0+cos(e*g)*p7;
    r=sqrt(pow(i-e,2.0)+pow(d-f,2.0));
    q=f/r;
    e=(r*cos(q))-a/2.0;f=(r*sin(q))-a/2.0;
    d=sin(e*g)*p8+sin(e*g)*p11+r;
    h=((f+d)+a/2.0)*g;
    i=cos(h+r*p.x/1.3)*(e+e+a)+cos(q*g*6.0)*(r+h/3.0);
    h=sin(f*g)*p9-sin(e*g)*p10*p.x;
    h=(h+(f-e)*q+sin(r-(a+h)/7.0)*10.0+i/4.0)*g;
    i+=cos(h*2.91*sin(a/p12-q))*p13*sin(q-(r*4.3+a/12.0)*g)+tan(r*g+h)*184.0*cos(r*g+h);
    i=mod(i/5.6,256.0)/64.0;
    if(i<0.0) i+=4.0;
    if(i>=2.0) i=4.0-i;
    d=r/350.0;
    d+=sin(d*d*p14)*p15;
    f=(sin(a*g)+1.0)/2.0;
    gl_FragColor=vec4(vec3(f*i/1.6,i/2.0+d/13.0,i)*d*p.x+vec3(i/1.3+d/8.0,i/2.0+d/18.0,i)*d*(1.0-p.x),1.0);
}
