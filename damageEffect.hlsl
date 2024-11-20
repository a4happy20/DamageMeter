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

    #define ACTIVE IniParams[130].x
    #define QUADPOSX IniParams[130].y
    #define QUADPOSY IniParams[131].x
    #define WIDTH IniParams[131].y
    #define HEIGHT IniParams[131].z

    float screenWidth = 2560.0; // Reference screen width in pixels
    float screenHeight = 1440.0; // Reference screen height in pixels

    float desiredWidth = 500.0;
    float desiredHeight = 500.0;

    float quadPosX = 0;
    float quadPosY = 0;

    if (ACTIVE == 1) {
        quadPosX = QUADPOSX;
        quadPosY = QUADPOSY;
        desiredWidth = WIDTH;
        desiredHeight = HEIGHT;
    }

    // Calculate aspect ratio
    float aspectRatio = screenWidth / screenHeight;

    // Calculate adjusted width and height based on aspect ratio
    float adjustedWidth = desiredWidth / screenWidth * 2.0 * aspectRatio;
    float adjustedHeight = desiredHeight / screenHeight * 2.0;


    switch(vertex) {
        case 0:
            output.pos.xy = float2(quadPosX + adjustedWidth, quadPosY + adjustedHeight); // Top right
            output.uv = float2(1, 1);
            break;
        case 1:
            output.pos.xy = float2(quadPosX + adjustedWidth, quadPosY - adjustedHeight); // Bottom right
            output.uv = float2(1, 0);
            break;
        case 2:
            output.pos.xy = float2(quadPosX - adjustedWidth, quadPosY + adjustedHeight); // Top left
            output.uv = float2(0, 1);
            break;
        case 3:
            output.pos.xy = float2(quadPosX - adjustedWidth, quadPosY - adjustedHeight); // Bottom left
            output.uv = float2(0, 0);
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

Texture2D<float4> EffectTexture : register(t110);

void main(vs2ps input, out float4 result : SV_Target0)
{
    //#define ACTIVE IniParams[79].y
    #define BREAK IniParams[94].z
    #define CURRENTTIME IniParams[73].x
    #define ALPHA IniParams[73].y
    #define EFFECTTYPE IniParams[79].z
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


    float2 offset13 = float2(0.1, -0.2);
    float2 offset14 = float2(-0.1, 0.1);
    float2 offset15 = float2(0.2, -0.1);
    float2 offset16 = float2(-0.2, 0.2);
    float2 offset17 = float2(0.3, 0.0);
    float2 offset18 = float2(-0.3, 0.3);


    float2 offset19 = float2(-0.2, -0.5);
    float2 offset20 = float2(-0.4, -0.2);
    float2 offset21 = float2(-0.1, -0.4);
    float2 offset22 = float2(-0.5, -0.1);
    float2 offset23 = float2(0.0, -0.3);
    float2 offset24 = float2(-0.6, 0.0);

// Adjusted offsets
    float2 adjustedOffset1 = float2(0.1, -0.1);
    float2 adjustedOffset2 = float2(-0.1, 0.1);
    float2 adjustedOffset3 = float2(0.1, 0.1);
    float2 adjustedOffset4 = float2(-0.1, -0.1);
    float2 adjustedOffset5 = float2(0.1, 0);
    float2 adjustedOffset6 = float2(-0.1, 0);
    float2 adjustedOffset7 = float2(0, 0.1);
    float2 adjustedOffset8 = float2(0, -0.1);

    float2 adjustedOffset9 = float2(-0.1, 0.1);
    float2 adjustedOffset10 = float2(0.1, -0.1);
    float2 adjustedOffset11 = float2(0.1, 0.1);
    float2 adjustedOffset12 = float2(-0.1, -0.1);
    float2 adjustedOffset13 = float2(0.0, 0.1);
    float2 adjustedOffset14 = float2(0, -0.1);
    float2 adjustedOffset15 = float2(0.1, 0);
    float2 adjustedOffset16 = float2(-0.1, 0);

// Combine offsets
    offset1 += adjustedOffset1;
    offset2 += adjustedOffset2;
    offset3 += adjustedOffset3;
    offset4 += adjustedOffset4;
    offset5 += adjustedOffset5;
    offset6 += adjustedOffset6;
    offset7 += adjustedOffset7;
    offset8 += adjustedOffset8;
    offset9 += adjustedOffset1;
    offset10 += adjustedOffset2;
    offset11 += adjustedOffset3;
    offset12 += adjustedOffset4;


    offset13 += adjustedOffset9;
    offset14 += adjustedOffset10;
    offset15 += adjustedOffset11;
    offset16 += adjustedOffset12;
    offset17 += adjustedOffset13;
    offset18 += adjustedOffset14;
    offset19 += adjustedOffset15;
    offset20 += adjustedOffset16;
    offset21 += adjustedOffset9;
    offset22 += adjustedOffset10;
    offset23 += adjustedOffset11;
    offset24 += adjustedOffset12;


    result = float4(0, 0, 0, 0);

// BREAK == 0 condition allows for manual playing of effect. Remove on release!
    if (BREAK == 1 || BREAK == 0) {

    // red
        float4 color1 = float4(0.9882, 0.0431, 0.0333, 1.0);
        float4 color2 = float4(0.9, 0.043, 0.033, 1.0);
        float4 color3 = float4(0.9882, 0.0431, 0.0333, 1.0);

    // dimensions
        float width = 10.0;
        float height = 5.0;

    // alpha animation speed
        float animationSpeed1 = 0.244;
        float animationSpeed2 = 0.2836;
        float animationSpeed3 = 0.3232;
        float animationSpeed4 = 0.3228;
        float animationSpeed5 = 0.2824;
        float animationSpeed6 = 0.242;


        float alphaMultiplier1 = 0.55 + 0.55 * sin(CURRENTTIME * animationSpeed1);
        float alphaMultiplier2 = 0.45 + 0.45 * sin(CURRENTTIME * animationSpeed2);
        float alphaMultiplier3 = 0.35 + 0.35 * sin(CURRENTTIME * animationSpeed3);
        float alphaMultiplier4 = 0.25 + 0.25 * sin(CURRENTTIME * animationSpeed4);
        float alphaMultiplier5 = 0.45 + 0.45 * sin(CURRENTTIME * animationSpeed5);
        float alphaMultiplier6 = 0.55 + 0.55 * sin(CURRENTTIME * animationSpeed6);


        float2 scaledUV1 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset1;

        float2 scaledUV2 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset2;

        float2 scaledUV3 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset3;

        float2 scaledUV4 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset4;

        float2 scaledUV5 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset5;

        float2 scaledUV6 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset6;



        float2 scaledUV7 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset7;

        float2 scaledUV8 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset8;

        float2 scaledUV9 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset9;

        float2 scaledUV10 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset10;

        float2 scaledUV11 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset11;

        float2 scaledUV12 = float2((1.0 - input.uv.x) * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset12;





        float2 scaledUV13 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset13;

        float2 scaledUV14 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset14;

        float2 scaledUV15 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset15;

        float2 scaledUV16 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset16;

        float2 scaledUV17 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset17;

        float2 scaledUV18 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset18;



        float2 scaledUV19 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset19;

        float2 scaledUV20 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset20;

        float2 scaledUV21 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset21;

        float2 scaledUV22 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset22;

        float2 scaledUV23 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset23;

        float2 scaledUV24 = float2(input.uv.x * width, (1.0 - input.uv.y) * height)
                         + float2((1 - width) * 0.5, (1 - height) * 0.5) + offset24;




    // Adjust the speed of the transitions
        float timeOffset = CURRENTTIME * 0.24;
        float normalizedOffset = frac(timeOffset * (1.0 / height));
        float normalizedOffsetSecond = frac(timeOffset * (1.0 / height));

        {

            scaledUV1.x = saturate(scaledUV1.x - normalizedOffset);
            scaledUV2.x = saturate(scaledUV2.x + normalizedOffset);
            scaledUV3.x = saturate(scaledUV3.x - normalizedOffset);
            scaledUV4.x = saturate(scaledUV4.x + normalizedOffset);
            scaledUV5.x = saturate(scaledUV5.x - normalizedOffset);
            scaledUV6.x = saturate(scaledUV6.x + normalizedOffset);

            scaledUV7.x = saturate(scaledUV7.x - normalizedOffset);
            scaledUV8.x = saturate(scaledUV8.x + normalizedOffset);
            scaledUV9.x = saturate(scaledUV9.x - normalizedOffset);
            scaledUV10.x = saturate(scaledUV10.x + normalizedOffset);
            scaledUV11.x = saturate(scaledUV11.x - normalizedOffset);
            scaledUV12.x = saturate(scaledUV12.x + normalizedOffset);


            scaledUV13.x = saturate(scaledUV13.x + normalizedOffsetSecond);
            scaledUV14.x = saturate(scaledUV14.x - normalizedOffsetSecond);
            scaledUV15.x = saturate(scaledUV15.x + normalizedOffsetSecond);
            scaledUV16.x = saturate(scaledUV16.x - normalizedOffsetSecond);
            scaledUV17.x = saturate(scaledUV17.x + normalizedOffsetSecond);
            scaledUV18.x = saturate(scaledUV18.x - normalizedOffsetSecond);

            scaledUV19.x = saturate(scaledUV19.x + normalizedOffsetSecond);
            scaledUV20.x = saturate(scaledUV20.x - normalizedOffsetSecond);
            scaledUV21.x = saturate(scaledUV21.x + normalizedOffsetSecond);
            scaledUV22.x = saturate(scaledUV22.x - normalizedOffsetSecond);
            scaledUV23.x = saturate(scaledUV23.x + normalizedOffsetSecond);
            scaledUV24.x = saturate(scaledUV24.x - normalizedOffsetSecond);


            scaledUV1.y = saturate(scaledUV1.y + normalizedOffset);
            scaledUV2.y = saturate(scaledUV2.y - normalizedOffset);
            scaledUV3.y = saturate(scaledUV3.y + normalizedOffset);
            scaledUV4.y = saturate(scaledUV4.y - normalizedOffset);
            scaledUV5.y = saturate(scaledUV5.y + normalizedOffset);
            scaledUV6.y = saturate(scaledUV6.y - normalizedOffset);


            scaledUV7.y = saturate(scaledUV7.y + normalizedOffset);
            scaledUV8.y = saturate(scaledUV8.y - normalizedOffset);
            scaledUV9.y = saturate(scaledUV9.y + normalizedOffset);
            scaledUV10.y = saturate(scaledUV10.y - normalizedOffset);
            scaledUV11.y = saturate(scaledUV11.y + normalizedOffset);
            scaledUV12.y = saturate(scaledUV12.y - normalizedOffset);


            scaledUV13.y = saturate(scaledUV13.y - normalizedOffsetSecond);
            scaledUV14.y = saturate(scaledUV14.y + normalizedOffsetSecond);
            scaledUV15.y = saturate(scaledUV15.y - normalizedOffsetSecond);
            scaledUV16.y = saturate(scaledUV16.y + normalizedOffsetSecond);
            scaledUV17.y = saturate(scaledUV17.y - normalizedOffsetSecond);
            scaledUV18.y = saturate(scaledUV18.y + normalizedOffsetSecond);


            scaledUV19.y = saturate(scaledUV19.y - normalizedOffsetSecond);
            scaledUV20.y = saturate(scaledUV20.y + normalizedOffsetSecond);
            scaledUV21.y = saturate(scaledUV21.y - normalizedOffsetSecond);
            scaledUV22.y = saturate(scaledUV22.y + normalizedOffsetSecond);
            scaledUV23.y = saturate(scaledUV23.y - normalizedOffsetSecond);
            scaledUV24.y = saturate(scaledUV24.y + normalizedOffsetSecond);
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


        float4 result13 = EffectTexture.Sample(linearSampler, scaledUV13) * alphaMultiplier1 * color1;
        float4 result14 = EffectTexture.Sample(linearSampler, scaledUV14) * alphaMultiplier2 * color2;
        float4 result15 = EffectTexture.Sample(linearSampler, scaledUV15) * alphaMultiplier3 * color3;
        float4 result16 = EffectTexture.Sample(linearSampler, scaledUV16) * alphaMultiplier4 * color1;
        float4 result17 = EffectTexture.Sample(linearSampler, scaledUV17) * alphaMultiplier5 * color2;
        float4 result18 = EffectTexture.Sample(linearSampler, scaledUV18) * alphaMultiplier6 * color3;


        float4 result19 = EffectTexture.Sample(linearSampler, scaledUV19) * alphaMultiplier1 * color1;
        float4 result20 = EffectTexture.Sample(linearSampler, scaledUV20) * alphaMultiplier2 * color2;
        float4 result21 = EffectTexture.Sample(linearSampler, scaledUV21) * alphaMultiplier3 * color3;
        float4 result22 = EffectTexture.Sample(linearSampler, scaledUV22) * alphaMultiplier4 * color1;
        float4 result23 = EffectTexture.Sample(linearSampler, scaledUV23) * alphaMultiplier5 * color2;
        float4 result24 = EffectTexture.Sample(linearSampler, scaledUV24) * alphaMultiplier6 * color3;

        result += result1 + result2 + result3 + result4 + result5 + result6 + result7 + result8 + result9 + result10 + result11 + result12 + result13 + result14 + result15 + result16 + result17 + result18 + result19 + result20 + result21 + result22 + result23 + result24;

    // Apply glow effect when alpha within range
        if (alphaMultiplier1 >= 0.72) {
            float glowIntensity = 1.0;
            float3 glowColor = float3(1.0, 0.0, 0.0);

        // Calculate glow effect
            float3 glow = result.rgb * glowIntensity * glowColor;

            result1.rgb += glow;
            
        }
        result1.a *= alphaMultiplier1;
        result2.a *= alphaMultiplier2;
        result3.a *= alphaMultiplier3;
        result4.a *= alphaMultiplier4;
        result5.a *= alphaMultiplier5;
        result6.a *= alphaMultiplier6;
        result7.a *= alphaMultiplier1;
        result8.a *= alphaMultiplier2;
        result9.a *= alphaMultiplier3;
        result10.a *= alphaMultiplier4;
        result11.a *= alphaMultiplier5;
        result12.a *= alphaMultiplier6;
        result13.a *= alphaMultiplier1;
        result14.a *= alphaMultiplier2;
        result15.a *= alphaMultiplier3;
        result16.a *= alphaMultiplier4;
        result17.a *= alphaMultiplier5;
        result18.a *= alphaMultiplier6;
        result19.a *= alphaMultiplier1;
        result20.a *= alphaMultiplier2;
        result21.a *= alphaMultiplier3;
        result22.a *= alphaMultiplier4;
        result23.a *= alphaMultiplier5;
        result24.a *= alphaMultiplier6;
        
        result += result1 + result2 + result3 + result4 + result5 + result6 + result7 + result8 + result9 + result10 + result11 + result12 + result13 + result14 + result15 + result16 + result17 + result18 + result19 + result20 + result21 + result22 + result23 + result24;
        result.a *= ALPHA;
        
    return;
    }
}
#endif
