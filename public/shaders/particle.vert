precision lowp float;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

uniform float time;

attribute vec2 speed;
attribute vec2 angle;
attribute vec3 position;

attribute float maxLife;

attribute float size;

varying float vTime;
varying float vMaxLife;

attribute vec2 hue;
attribute vec2 saturation;
attribute vec2 lightness;
attribute vec2 opacity;

varying vec2 vHue;
varying vec2 vSaturation;
varying vec2 vLightness;
varying vec2 vOpacity;

void main()
{

    float tmpTime = mod(time, maxLife);
    float timePercent = tmpTime / maxLife;

    float deltaAnglePercent = (angle.y-angle.x) * timePercent - (angle.x*-1.);

//    float sizePercent = abs(((size.x-size.y) * timePercent) - size.x);

    gl_PointSize = size;


    // displacement = initialVelocity * Time + .5 * acceleration * Time * Time
    float displacement = (speed.x * max((size * 0.165), 1.) * tmpTime) + (.5 * speed.y * tmpTime * tmpTime);


    vec3 velocity = vec3(displacement * cos(deltaAnglePercent), displacement * sin(deltaAnglePercent), 0.);

    // ease out quad
    // -(p * (p - 2));
//    velocity *= -(timePercent * (timePercent - 2.));

	gl_Position = projectionMatrix * modelViewMatrix * vec4(position.x + velocity.x, position.y + velocity.y, 0., 1.);

	vTime = tmpTime;
	vMaxLife = maxLife;

	vHue = hue;
	vSaturation = saturation;
	vLightness = lightness;
	vOpacity = opacity;
}