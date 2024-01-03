Texture1D<float4> IniParams : register(t120);

// Since vb is not used in this case, this custom structure is used
struct vs2ps {
    float4 pos : SV_Position0;
    float2 uv : TEXCOORD1;
};

#ifdef VERTEX_SHADER

void main(
    out vs2ps output,
    uint vertex : SV_VertexID)
{

    switch(vertex) {
        case 0:
            output.pos.xy = float2(1, -1); // Top right
            output.uv = float2(1, 0);
            break;
        case 1:
            output.pos.xy = float2(1, 1); // Bottom right
            output.uv = float2(1, 1);
            break;
        case 2:
            output.pos.xy = float2(-1, -1); // Top left
            output.uv = float2(0, 0);
            break;
        case 3:
            output.pos.xy = float2(-1, 1); // Bottom left
            output.uv = float2(0, 1);
            break;
        default:
            output.pos.xy = 0;
            output.uv = float2(0, 0);
            break;
    };
    output.pos.zw = float2(0, 1);
}
#endif

#ifdef PIXEL_SHADER
SamplerState linearSampler : register(s0);

Texture2D<float4> EffectTexture : register(t96); 

void main(vs2ps input, out float4 result : SV_Target0)
{
    #define NOTIFICATION_TYPE IniParams[78].y
    #define SCALE_WIDTH 10.0
    #define SCALE_HEIGHT 5.0
    #define CURRENTTIME IniParams[78].x
    #define ALPHA IniParams[78].z
    #define EFFECTTYPE IniParams[79].x
    float alpha = 0.0;

    // Define offsets
    float2 offset1 = float2(-0.2, 0.1);
    float2 offset2 = float2(0.1, -0.1);
    float2 offset3 = float2(-0.1, 0.2);
    float2 offset4 = float2(0.2, -0.2);
    float2 offset5 = float2(0.0, 0.3);
    float2 offset6 = float2(0.3, -0.3);


    float2 offset7 = float2(-0.5, -0.2);
    float2 offset8 = float2(-0.2, -0.4);
    float2 offset9 = float2(-0.4, -0.1);
    float2 offset10 = float2(-0.1, -0.5);
    float2 offset11 = float2(-0.3, 0.0);
    float2 offset12 = float2(0.0, -0.6);


    result = float4(0, 0, 0, 0);

    if (NOTIFICATION_TYPE != 0) {

        float4 color1 = float4(0.5882, 0.8431, 0.1333, 1.0);
        float4 color2 = float4(0.8, 0.843, 0.133, 1.0);
        float4 color3 = float4(0.5882, 0.8431, 0.1333, 1.0);

        float animationSpeed1 = 0.022;
        float animationSpeed2 = 0.0418;
        float animationSpeed3 = 0.0616;
        float animationSpeed4 = 0.0614;
        float animationSpeed5 = 0.0412;
        float animationSpeed6 = 0.021;


        float alphaMultiplier1 = 0.55 + 0.55 * sin(CURRENTTIME * animationSpeed1);
        float alphaMultiplier2 = 0.45 + 0.45 * sin(CURRENTTIME * animationSpeed2);
        float alphaMultiplier3 = 0.35 + 0.35 * sin(CURRENTTIME * animationSpeed3);
        float alphaMultiplier4 = 0.25 + 0.25 * sin(CURRENTTIME * animationSpeed4);
        float alphaMultiplier5 = 0.45 + 0.45 * sin(CURRENTTIME * animationSpeed5);
        float alphaMultiplier6 = 0.55 + 0.55 * sin(CURRENTTIME * animationSpeed6);


        float2 scaledUV1 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset1;

        float2 scaledUV2 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset2;

        float2 scaledUV3 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset3;

        float2 scaledUV4 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset4;

        float2 scaledUV5 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset5;

        float2 scaledUV6 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset6;



        float2 scaledUV7 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset7;

        float2 scaledUV8 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset8;

        float2 scaledUV9 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset9;

        float2 scaledUV10 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset10;

        float2 scaledUV11 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset11;

        float2 scaledUV12 = float2(input.uv.x * SCALE_WIDTH, (1.0 - input.uv.y) * SCALE_HEIGHT)
                         + float2((1 - SCALE_WIDTH) * 0.5, (1 - SCALE_HEIGHT) * 0.5) + offset12;



        // Offset the UV coordinates to create a sliding effect
        float timeOffset = CURRENTTIME * 0.01;  // Adjust the speed of the sliding effect
        float normalizedOffset = frac(timeOffset * (1.0 / SCALE_HEIGHT));

        if (EFFECTTYPE == 1) {
            // fullscreen effect
            scaledUV1.y += timeOffset;
            scaledUV2.y += timeOffset;
            scaledUV3.y += timeOffset;
            scaledUV4.y += timeOffset;
            scaledUV5.y += timeOffset;
            scaledUV6.y += timeOffset;

            // Wrap the UV coordinates
            scaledUV1.y = frac(scaledUV1.y);
            scaledUV2.y = frac(scaledUV2.y);
            scaledUV3.y = frac(scaledUV3.y);
            scaledUV4.y = frac(scaledUV4.y);
            scaledUV5.y = frac(scaledUV5.y);
            scaledUV6.y = frac(scaledUV6.y);
        }

        else {
            // localized effect
            scaledUV1.x = saturate(scaledUV1.x);
            scaledUV2.x = saturate(scaledUV2.x);
            scaledUV3.x = saturate(scaledUV3.x);
            scaledUV4.x = saturate(scaledUV4.x);
            scaledUV5.x = saturate(scaledUV5.x);
            scaledUV6.x = saturate(scaledUV6.x);

            scaledUV7.x = saturate(scaledUV7.x);
            scaledUV8.x = saturate(scaledUV8.x);
            scaledUV9.x = saturate(scaledUV9.x);
            scaledUV10.x = saturate(scaledUV10.x);
            scaledUV11.x = saturate(scaledUV11.x);
            scaledUV12.x = saturate(scaledUV12.x);

            scaledUV1.y = saturate(scaledUV1.y + normalizedOffset);
            scaledUV2.y = saturate(scaledUV2.y + normalizedOffset);
            scaledUV3.y = saturate(scaledUV3.y + normalizedOffset);
            scaledUV4.y = saturate(scaledUV4.y + normalizedOffset);
            scaledUV5.y = saturate(scaledUV5.y + normalizedOffset);
            scaledUV6.y = saturate(scaledUV6.y + normalizedOffset);


            scaledUV7.y = saturate(scaledUV7.y + normalizedOffset);
            scaledUV8.y = saturate(scaledUV8.y + normalizedOffset);
            scaledUV9.y = saturate(scaledUV9.y + normalizedOffset);
            scaledUV10.y = saturate(scaledUV10.y + normalizedOffset);
            scaledUV11.y = saturate(scaledUV11.y + normalizedOffset);
            scaledUV12.y = saturate(scaledUV12.y + normalizedOffset);
        }

        float4 result1 = EffectTexture.Sample(linearSampler, scaledUV1) * alphaMultiplier1 * color1;
        float4 result2 = EffectTexture.Sample(linearSampler, scaledUV2) * alphaMultiplier2 * color2;
        float4 result3 = EffectTexture.Sample(linearSampler, scaledUV3) * alphaMultiplier3 * color3;
        float4 result4 = EffectTexture.Sample(linearSampler, scaledUV4) * alphaMultiplier4 * color1;
        float4 result5 = EffectTexture.Sample(linearSampler, scaledUV5) * alphaMultiplier5 * color2;
        float4 result6 = EffectTexture.Sample(linearSampler, scaledUV6) * alphaMultiplier6 * color3;


        float4 result7 = EffectTexture.Sample(linearSampler, scaledUV7) * alphaMultiplier1 * color1;
        float4 result8 = EffectTexture.Sample(linearSampler, scaledUV8) * alphaMultiplier2 * color2;
        float4 result9 = EffectTexture.Sample(linearSampler, scaledUV9) * alphaMultiplier3 * color3;
        float4 result10 = EffectTexture.Sample(linearSampler, scaledUV10) * alphaMultiplier4 * color1;
        float4 result11 = EffectTexture.Sample(linearSampler, scaledUV11) * alphaMultiplier5 * color2;
        float4 result12 = EffectTexture.Sample(linearSampler, scaledUV12) * alphaMultiplier6 * color3;


        result += result1 + result2 + result3 + result4 + result5 + result6 + result7 + result8 + result9 + result10 + result11 + result12;

        // Apply glow effect to texSample1 when alpha is 1.0
        if (alphaMultiplier1 >= 0.72) {
            float glowIntensity = 1.0; // Increase glow intensity for better visibility
            float3 glowColor = float3(0.5882, 0.8431, 0.1333);

            // Calculate glow effect
            float3 glow = result.rgb * glowIntensity * glowColor;

            result.rgb += glow;
            
        }
        alpha = ALPHA;
        result.a *= ALPHA;
        
    return;
    }
}
#endif
