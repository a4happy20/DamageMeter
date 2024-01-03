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



    float screenWidth = 2560.0; // Reference screen width in pixels
    float screenHeight = 1440.0; // Reference screen height in pixels

    float desiredWidth = 60.0;
    float desiredHeight = 110.0;
    
    // Calculate aspect ratio
    float aspectRatio = screenWidth / screenHeight;

    // Calculate adjusted width and height based on aspect ratio
    float adjustedWidth = desiredWidth / screenWidth * 2.0 * aspectRatio;
    float adjustedHeight = desiredHeight / screenHeight * 2.0;

    float quadPosX = 0.0;
    float quadPosY = -0.82;


    switch(vertex) {
        case 0:
            output.pos.xy = float2(quadPosX + adjustedWidth, quadPosY + adjustedHeight); // Top right
            output.uv = float2(0, 1);
            break;
        case 1:
            output.pos.xy = float2(quadPosX + adjustedWidth, quadPosY - adjustedHeight); // Bottom right
            output.uv = float2(0, 0);
            break;
        case 2:
            output.pos.xy = float2(quadPosX - adjustedWidth, quadPosY + adjustedHeight); // Top left
            output.uv = float2(1, 1);
            break;
        case 3:
            output.pos.xy = float2(quadPosX - adjustedWidth, quadPosY - adjustedHeight); // Bottom left
            output.uv = float2(1, 0);
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
Texture2D<float4> damageMeter : register(t95);

void main(vs2ps input, out float4 result : SV_Target0)
{

    result = float4(0, 0, 0, 0);
    #define ALPHA_NOTIFICATION IniParams[94].x
    float alpha = 0.0;
    #define DAMAGE_VALUE IniParams[95].x
    #define NOTIFICATION_TYPE IniParams[95].y
    #define DAMAGEMETERDISABLE IniParams[94].y
    #define BREAK IniParams[94].z
    #define THRESHOLD1 IniParams[87].x
    #define THRESHOLD2 IniParams[87].y
    #define THRESHOLD3 IniParams[87].z
    #define THRESHOLD4 IniParams[87].w
    #define THRESHOLD5 IniParams[88].y
    #define THRESHOLD6 IniParams[88].z
    #define THRESHOLD7 IniParams[88].w
    #define FIVELEVELS IniParams[88].x
    #define SEVENLEVELS IniParams[89].x
    float damage = DAMAGE_VALUE;
    #define TIME IniParams[75].x
    float time = TIME;

    if (DAMAGEMETERDISABLE == 0) {
        if (NOTIFICATION_TYPE != 0) {
            if (damage >= 1.0) {
                // If damage is at or above 1.0, output transparent color
                result = float4(0, 0, 0, 0);
                return;
            }

            input.uv = 1 - input.uv;

            float4 mainTexture = damageMeter.Sample(linearSampler, input.uv);

            // Sample the alpha channel specifically
            float alphaValue = mainTexture.a;

            // Calculate the fill amount based on the damage value and alpha channel
            float fillAmount = saturate(damage);


            if (alphaValue >= 0.30) {
                float4 fillBarColor1, fillBarColor2, fillBarColor3, fillBarColor1_fl, fillBarColor2_fl, fillBarColor3_fl, fillBarColor4_fl, fillBarColor5_fl, fillBarColor1_sl, fillBarColor2_sl, fillBarColor3_sl, fillBarColor4_sl, fillBarColor5_sl, fillBarColor6_sl, fillBarColor7_sl, fillBarColor8_sl;
                float threshold1, threshold2, threshold3, threshold4, threshold5, threshold6, threshold7;

                threshold1 = THRESHOLD1;
                threshold2 = THRESHOLD2;
                threshold3 = THRESHOLD3;
                threshold4 = THRESHOLD4;
                threshold5 = THRESHOLD5;
                threshold6 = THRESHOLD6;
                threshold7 = THRESHOLD7;

                fillBarColor1 = float4(0.5882, 0.8431, 0.1333, 0.75);
                fillBarColor2 = float4(1.0, 0.7215686274509804, 0.1725490196078431, 0.75);
                fillBarColor3 = float4(1.0, 0.1529412, 0.1529412, 0.75);

                fillBarColor1_fl = float4(0.5882, 0.8431, 0.1333, 0.75);
                fillBarColor2_fl = float4(0.5882, 0.8431, 0.1333, 0.75);
                fillBarColor3_fl = float4(1.0, 0.7215686274509804, 0.1725490196078431, 0.75);
                fillBarColor4_fl = float4(1.0, 0.1529412, 0.1529412, 0.75);
                fillBarColor5_fl = float4(1.0, 0.1529412, 0.1529412, 0.75);

                fillBarColor1_sl = float4(0.5882, 0.8431, 0.1333, 0.75);
                fillBarColor2_sl = float4(0.5882, 0.8431, 0.1333, 0.75);
                fillBarColor3_sl = float4(1.0, 0.7215686274509804, 0.1725490196078431, 0.75);
                fillBarColor4_sl = float4(1.0, 0.7215686274509804, 0.1725490196078431, 0.75);
                fillBarColor5_sl = float4(1.0, 0.7215686274509804, 0.1725490196078431, 0.75);
                fillBarColor6_sl = float4(1.0, 0.1529412, 0.1529412, 0.75);
                fillBarColor7_sl = float4(1.0, 0.1529412, 0.1529412, 0.75);
                fillBarColor8_sl = float4(1.0, 0.1529412, 0.1529412, 0.75);

                // Calculate interpolation factors for smooth blending
    //            float factor1 = saturate((damage - 0) / (threshold1 - 0));
    //            float factor2 = saturate((damage - threshold1) / (threshold2 - threshold1));
    //            float factor3 = saturate((damage - threshold2) / (threshold3 - threshold2));
    //            float factor4 = saturate((damage - threshold3) / (threshold4 - threshold3));
    //            float factor5 = saturate((damage - threshold4) / (1.0 - threshold4));

                float4 blendedColor = float4(1.0, 1.0, 1.0, 1.0);
                if (damage <= threshold1) {
                    if(FIVELEVELS == 1) {
                        blendedColor = fillBarColor1_fl;
                    }
                    else {
                        blendedColor = fillBarColor1;
                    }
                }
                else if (damage <= threshold2) {
                    if(FIVELEVELS == 1) {
                        blendedColor = fillBarColor2_fl;
                    }
                    else {
                        blendedColor = fillBarColor2;
                    }
                }
                else if (damage <= threshold3) {
                    if(FIVELEVELS == 1) {
                        blendedColor = fillBarColor3_fl;
                    }
                    else {
                        blendedColor = fillBarColor3;
                    }
                }
                else if (FIVELEVELS == 1) {
                    if (damage <= threshold4) {
                        if (SEVENLEVELS == 1) {
                            blendedColor = fillBarColor4_sl;
                        }
                        else {
                            blendedColor = fillBarColor4_fl;
                        }
                    }
                    else if (damage <= threshold5) {
                        if (SEVENLEVELS == 1) {
                            blendedColor = fillBarColor5_sl;
                        }
                        else {
                            blendedColor = fillBarColor5_fl;
                        }
                    }
                    else if (SEVENLEVELS == 1) {
                        if (damage <= threshold6) {
                            blendedColor = fillBarColor6_sl;
                        }
                        else if (damage <= threshold7) {
                            blendedColor = fillBarColor7_sl;
                        }
                        else {
                            blendedColor = fillBarColor8_sl;
                        }
                    }
                }

                // Interpolate between main texture and blended color based on fillAmount
                float4 finalColor = lerp(mainTexture, blendedColor, step(input.uv.x, saturate(damage)));

                if (BREAK == 1) {
                    float blinkFactor = abs(sin(10.0 * time)); // Adjust speed by changing the number
                    float4 borderColor = lerp(float4(1.0, 1.0, 1.0, 1.0), finalColor, blinkFactor);
                    
                    // Modify the alpha of the border color to make it less opaque
                    borderColor.a *= 1.0;

                    // Combine the border color with the final color
                    finalColor = lerp(mainTexture, borderColor, step(input.uv.x, saturate(damage)));
                }

                // Check for the condition where the border should blink
                if (damage >= 0.86666666) {
                    float blinkFactor = abs(sin(5.0 * time)); // Adjust speed by changing the number
                    float4 borderColor = lerp(float4(1.0, 1.0, 1.0, 1.0), finalColor, blinkFactor);
                    
                    // Modify the alpha of the border color to make it less opaque
                    borderColor.a *= 0.5;

                    // Combine the border color with the final color
                    finalColor = lerp(finalColor, borderColor, step(input.uv.x, saturate(damage)));
                }
                alpha = ALPHA_NOTIFICATION;
                result = finalColor;
            }


            else {
                // If in the transparent region, display the original texture color
                result = mainTexture;
            }

            result.a *= ALPHA_NOTIFICATION;

        return;
        }
    return;
    }
}
#endif


