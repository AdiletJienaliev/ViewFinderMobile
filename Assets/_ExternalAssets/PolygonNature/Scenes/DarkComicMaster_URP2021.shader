////////////////////////////////////////
// Generated with Better Shaders
//
// Auto-generated shader code, don't hand edit!
//
//   Unity Version: 2021.3.1f1
//   Render Pipeline: URP2021
//   Platform: WindowsEditor
////////////////////////////////////////


Shader "Andicraft/Dark Comic Master"
{
   Properties
   {
      [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
      [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
      [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
      
	
	[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 0
	[Toggle] _CutoffEnabled ("Alpha Cutout", Int) = 0
	_Cutoff ("-Threshold [_CutoffEnabled == 1]", Range(0,1)) = 0.33
	_TEXTURESFOLDOUT ("# Textures", Int) = 0
		
		[MainTexture] _MainTex ("Color &&", 2D) = "white" {}
			[MainColor] _Color ("Main Color", Color) = (0, 1, 0, 1)
		_MaskMap ("Mask Map &", 2D) = "" {}
		_MaskMapNote ("!NOTE R: Metalness G: Smoothness B: Tint Mask A: Line Mask", Int) = 0
		[Normal] _BumpMap ("Normal Map &&", 2D) = "bump" {}
			_NormalMapStr ("Strength", Range(0,2)) = 1
		[Toggle(_EMISSION)] _Emission ("Emission", Int) = 0
			_EmissionTexture ("-Emission Map && [_EMISSION] &&", 2D) = "white" {}
			[HDR] _EmissionColor ("-Emission Color [_EMISSION]", Color) = (0,0,0,1)
			_LightmapEmissionStr ("-Lightmap Emission Strength [_EMISSION]", Float) = 1
		_TilingOffset ("Tiling/Offset &", Vector) = (1,1,0,0)
		_Spacer ("### ", Int) = 0

		_MinMaxPaintEdge ("-!DRAWER MinMax _PaintMaskEdges.x _PaintMaskEdges.y", Int) = 0
		_PaintMaskEdges ("Paint Mask Edges", Vector) = (0, 1, 0, 0)
		[Toggle] _LinesOn ("Enable Line Art Mask", Int) = 1
		

	_LINESFOLDOUT ("# Line Art", Int) = 0
		[Toggle] _InvertShadowedLines ("Invert in shadows", Int) = 1
		[Toggle] _KeepLinesThicc ("Even Size in Distance", Int) = 1

	_LIGHTINGFOLDOUT ("# Lighting", Int) = 0

		_DiffuseCategory ("## Diffuse", Int) = 0
			[KeywordEnum(Stepped, Textured)] _DiffuseLightingStyle ("-Style", Int) = 0

			_Spacer ("### ", Int) = 0

			// Stepped options
				_DiffuseSteps ("-Diffuse Steps [_DiffuseLightingStyle == 0]", Int) = 1
			
			// Textured Options
				[KeywordEnum(Screenspace, ViewDirection, ScreenStable, Worldspace, Objectspace)] _DiffuseTextureMapping ("-Mapping Type [_DiffuseLightingStyle == 1]", Int) = 2
				_DiffuseTexture ("-Texture && [_DiffuseLightingStyle == 1]", 2D) = "white "{}
				[KeywordEnum(SingleChannel, Crosshatch)] _DiffuseHatching ("Texture Type [_DiffuseLightingStyle == 1]", Int) = 0
				_HatchingRanges ("-Crosshatch Ranges (R, G, B) & [_DiffuseHatching == 1 && _DiffuseLightingStyle == 1]", Vector) = (0.33, 0.66, 1)
				_DiffuseTextureSize ("-Texture Size [_DiffuseLightingStyle == 1]", Float) = 1
				[Toggle] _ScreenStableDistanceScale ("--Scale by Distance [_DiffuseLightingStyle == 1 && _DiffuseTextureMapping == 2]", Int) = 0
				_DiffuseTextureContrast ("-Contrast [_DiffuseLightingStyle == 1]", Range(0.05, 2)) = 1 
				_MinMaxDiffEdge ("-!DRAWER MinMax _DiffuseEdge.x _DiffuseEdge.y", Int) = 0
				_DiffuseEdge ("Edges", Vector) = (0, 1, 0, 0)
				

			_Spacer ("### ", Int) = 0

			_DiffuseRim ("-Light-aligned rim size", Range(0,1)) = 0.1

		_SpecularCategory ("## Specular", Int) = 0
			[KeywordEnum(CookTorrance, Phong, BlinnPhong, Disabled)] _SpecularType ("-Specular Type", Int) = 0
			[KeywordEnum(Basic, Stepped,  Textured)] _SpecularLightingStyle ("-Style", Int) = 0

			// Basic Options
				_MinMaxSpecEdge ("-!DRAWER MinMax _SpecularEdge.x _SpecularEdge.y [_SpecularLightingStyle == 0]", Int) = 0
				_SpecularEdge ("Edges", Vector) = (0, 1, 0, 0)

			// Stepped options
				_SpecularSteps ("-Specular Steps [_SpecularLightingStyle == 1]", Int) = 1
			
			// Textured Options
				[KeywordEnum(Screenspace, ViewDirection, ScreenStable, Worldspace, Objectspace)] _SpecularTextureMapping ("-Mapping Type [_SpecularLightingStyle == 2]", Int) = 2
				_SpecularTexture ("-Texture && [_SpecularLightingStyle == 2]", 2D) = "white "{}
				[KeywordEnum(SingleChannel, Crosshatch)] _SpecularHatching ("Texture Type [_SpecularLightingStyle == 2]", Int) = 0
				_HatchingRangesSpec ("-Crosshatch Ranges (R, G, B) & [_SpecularHatching == 1 && _SpecularLightingStyle == 2]", Vector) = (0.33, 0.66, 1)
				_SpecularTextureSize ("-Texture Size [_SpecularLightingStyle == 2]", Float) = 1
				[Toggle] _ScreenStableDistanceScaleSpec ("--Scale by Distance [_SpecularLightingStyle == 2 && _SpecularTextureMapping == 2]", Int) = 0
				_SpecularTextureContrast ("-Contrast [_SpecularLightingStyle == 2]", Range(0.05, 2)) = 1 
				_MinMaxSpecEdge ("-!DRAWER MinMax _SpecularEdge.x _SpecularEdge.y [_SpecularLightingStyle == 2]", Int) = 0

		_ReflectionsCategory ("## Reflections", Int) = 0
			[Toggle] _ReflectionsEnabled ("Enabled", Int) = 1
			_BaseReflectStrength ("Base Strength", Range(0,1)) = 0.5
			_ReflectionFresnelParams ("Fresnel Settings (Power, Offset, Strength, Tightness) &", Vector) = (0.5, 0.05, 0.297, 0.85)

		_AmbientCategory ("## Ambient", Int) = 0
			_AmbientShadowStrength ("-Ambient in Shadows", Range(0,1)) = 0


   }
   SubShader
   {
      Tags { "RenderPipeline"="UniversalPipeline" "RenderType" = "Opaque" "UniversalMaterialType" = "Unlit" "Queue" = "Geometry" }

      

      
        Pass
        {
            Name "Universal Forward"
            Tags 
            { 
                "LightMode" = "UniversalForward"
            }
            Cull Back
            Blend One Zero
            ZTest LEqual
            ZWrite On

            Blend One Zero, One Zero
Cull Back
ZTest LEqual
ZWrite On

            	Cull[_Cull]


            HLSLPROGRAM

               #pragma vertex Vert
   #pragma fragment Frag

            #pragma target 3.0

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma multi_compile_fog
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
    
            // Keywords
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
            #pragma multi_compile_fragment _ _LIGHT_LAYERS
            #pragma multi_compile_fragment _ DEBUG_DISPLAY
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile _ _CLUSTERED_RENDERING
            // GraphKeywords: <None>

            #define SHADER_PASS SHADERPASS_FORWARD
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define _PASSFORWARD 1
            #define _FOG_FRAGMENT 1
            

            
	#pragma multi_compile_local _DIFFUSELIGHTINGSTYLE_STEPPED _DIFFUSELIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _SPECULARLIGHTINGSTYLE_BASIC _SPECULARLIGHTINGSTYLE_STEPPED _SPECULARLIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _DIFFUSETEXTUREMAPPING_SCREENSPACE _DIFFUSETEXTUREMAPPING_VIEWDIRECTION _DIFFUSETEXTUREMAPPING_SCREENSTABLE _DIFFUSETEXTUREMAPPING_WORLDSPACE _DIFFUSETEXTUREMAPPING_OBJECTSPACE
	#pragma multi_compile_local _SPECULARTEXTUREMAPPING_SCREENSPACE _SPECULARTEXTUREMAPPING_VIEWDIRECTION _SPECULARTEXTUREMAPPING_SCREENSTABLE _SPECULARTEXTUREMAPPING_WORLDSPACE _SPECULARTEXTUREMAPPING_OBJECTSPACE
	#pragma shader_feature_local _EMISSION
	#pragma shader_feature_local _REFLECTIONSENABLED_ON


   #define _URP 1

#define _UNLIT 1
#define _USINGTEXCOORD1 1
#define NEED_FACING 1

            // this has to be here or specular color will be ignored. Not in SG code
            #if _SIMPLELIT
               #define _SPECULAR_COLOR
            #endif


            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
            

        

               #undef WorldNormalVector
      #define WorldNormalVector(data, normal) mul(normal, data.TBNMatrix)
      
      #define UnityObjectToWorldNormal(normal) mul(GetObjectToWorldMatrix(), normal)

      #define _WorldSpaceLightPos0 _MainLightPosition
      
      #define UNITY_DECLARE_TEX2D(name) TEXTURE2D(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2D_NOSAMPLER(name) TEXTURE2D(name);
      #define UNITY_DECLARE_TEX2DARRAY(name) TEXTURE2D_ARRAY(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(name) TEXTURE2D_ARRAY(name);

      #define UNITY_SAMPLE_TEX2DARRAY(tex,coord)            SAMPLE_TEXTURE2D_ARRAY(tex, sampler##tex, coord.xy, coord.z)
      #define UNITY_SAMPLE_TEX2DARRAY_LOD(tex,coord,lod)    SAMPLE_TEXTURE2D_ARRAY_LOD(tex, sampler##tex, coord.xy, coord.z, lod)
      #define UNITY_SAMPLE_TEX2D(tex, coord)                SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
      #define UNITY_SAMPLE_TEX2D_SAMPLER(tex, samp, coord)  SAMPLE_TEXTURE2D(tex, sampler##samp, coord)

      #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod)   SAMPLE_TEXTURE2D_LOD(tex, sampler_##tex, coord, lod)
      #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) SAMPLE_TEXTURE2D_LOD (tex, sampler##samplertex,coord, lod)
     
      #if defined(UNITY_COMPILER_HLSL)
         #define UNITY_INITIALIZE_OUTPUT(type,name) name = (type)0;
      #else
         #define UNITY_INITIALIZE_OUTPUT(type,name)
      #endif

      #define sampler2D_float sampler2D
      #define sampler2D_half sampler2D

      

      // data across stages, stripped like the above.
      struct VertexToPixel
      {
         float4 pos : SV_POSITION;
         float3 worldPos : TEXCOORD0;
         float3 worldNormal : TEXCOORD1;
         float4 worldTangent : TEXCOORD2;
          float4 texcoord0 : TEXCOORD3;
          float4 texcoord1 : TEXCOORD4;
         // float4 texcoord2 : TEXCOORD5;

         // #if %TEXCOORD3REQUIREKEY%
          float4 texcoord3 : TEXCOORD6;
         // #endif

         // #if %SCREENPOSREQUIREKEY%
          float4 screenPos : TEXCOORD7;
         // #endif

         // #if %VERTEXCOLORREQUIREKEY%
         // half4 vertexColor : COLOR;
         // #endif

         #if defined(LIGHTMAP_ON)
            float2 lightmapUV : TEXCOORD8;
         #endif
         #if defined(DYNAMICLIGHTMAP_ON)
            float2 dynamicLightmapUV : TEXCOORD9;
         #endif
         #if !defined(LIGHTMAP_ON)
            float3 sh : TEXCOORD10;
         #endif

         #if defined(VARYINGS_NEED_FOG_AND_VERTEX_LIGHT)
            float4 fogFactorAndVertexLight : TEXCOORD11;
         #endif

         #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
           float4 shadowCoord : TEXCOORD12;
         #endif

         // #if %EXTRAV2F0REQUIREKEY%
         // float4 extraV2F0 : TEXCOORD13;
         // #endif

         // #if %EXTRAV2F1REQUIREKEY%
         // float4 extraV2F1 : TEXCOORD14;
         // #endif

         // #if %EXTRAV2F2REQUIREKEY%
         // float4 extraV2F2 : TEXCOORD15;
         // #endif

         // #if %EXTRAV2F3REQUIREKEY%
         // float4 extraV2F3 : TEXCOORD16;
         // #endif

         // #if %EXTRAV2F4REQUIREKEY%
         // float4 extraV2F4 : TEXCOORD17;
         // #endif

         // #if %EXTRAV2F5REQUIREKEY%
         // float4 extraV2F5 : TEXCOORD18;
         // #endif

         // #if %EXTRAV2F6REQUIREKEY%
         // float4 extraV2F6 : TEXCOORD19;
         // #endif

         // #if %EXTRAV2F7REQUIREKEY%
         // float4 extraV2F7 : TEXCOORD20;
         // #endif

         #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
         #endif
         #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
         #endif
         #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
         #endif
         #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
         #endif
      };


         
            
            // data describing the user output of a pixel
            struct Surface
            {
               half3 Albedo;
               half Height;
               half3 Normal;
               half Smoothness;
               half3 Emission;
               half Metallic;
               half3 Specular;
               half Occlusion;
               half SpecularPower; // for simple lighting
               half Alpha;
               float outputDepth; // if written, SV_Depth semantic is used. ShaderData.clipPos.z is unused value
               // HDRP Only
               half SpecularOcclusion;
               half SubsurfaceMask;
               half Thickness;
               half CoatMask;
               half CoatSmoothness;
               half Anisotropy;
               half IridescenceMask;
               half IridescenceThickness;
               int DiffusionProfileHash;
               float SpecularAAThreshold;
               float SpecularAAScreenSpaceVariance;
               // requires _OVERRIDE_BAKEDGI to be defined, but is mapped in all pipelines
               float3 DiffuseGI;
               float3 BackDiffuseGI;
               float3 SpecularGI;
               // requires _OVERRIDE_SHADOWMASK to be defines
               float4 ShadowMask;
            };

            // Data the user declares in blackboard blocks
            struct Blackboard
            {
                
                float blackboardDummyData;
            };

            // data the user might need, this will grow to be big. But easy to strip
            struct ShaderData
            {
               float4 clipPos; // SV_POSITION
               float3 localSpacePosition;
               float3 localSpaceNormal;
               float3 localSpaceTangent;
        
               float3 worldSpacePosition;
               float3 worldSpaceNormal;
               float3 worldSpaceTangent;
               float tangentSign;

               float3 worldSpaceViewDir;
               float3 tangentSpaceViewDir;

               float4 texcoord0;
               float4 texcoord1;
               float4 texcoord2;
               float4 texcoord3;

               float2 screenUV;
               float4 screenPos;

               float4 vertexColor;
               bool isFrontFace;

               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;

               float3x3 TBNMatrix;
               Blackboard blackboard;
            };

            struct VertexData
            {
               #if SHADER_TARGET > 30
               // uint vertexID : SV_VertexID;
               #endif
               float4 vertex : POSITION;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;

               // optimize out mesh coords when not in use by user or lighting system
               #if _URP && (_USINGTEXCOORD1 || _PASSMETA || _PASSFORWARD || _PASSGBUFFER)
                  float4 texcoord1 : TEXCOORD1;
               #endif

               #if _URP && (_USINGTEXCOORD2 || _PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && defined(DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif

               #if _STANDARD && (_USINGTEXCOORD1 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER || _PASSFORWARDADD) && LIGHTMAP_ON)))
                  float4 texcoord1 : TEXCOORD1;
               #endif
               #if _STANDARD && (_USINGTEXCOORD2 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif


               #if _HDRP
                  float4 texcoord1 : TEXCOORD1;
                  float4 texcoord2 : TEXCOORD2;
               #endif

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD4; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity    : TEXCOORD5; // Add Precomputed Velocity (Alembic computes velocities on runtime side).
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct TessVertex 
            {
               float4 vertex : INTERNALTESSPOS;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;
               float4 texcoord1 : TEXCOORD1;
               float4 texcoord2 : TEXCOORD2;

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               // #if %EXTRAV2F0REQUIREKEY%
               // float4 extraV2F0 : TEXCOORD5;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // float4 extraV2F1 : TEXCOORD6;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // float4 extraV2F2 : TEXCOORD7;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // float4 extraV2F3 : TEXCOORD8;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // float4 extraV2F4 : TEXCOORD9;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // float4 extraV2F5 : TEXCOORD10;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // float4 extraV2F6 : TEXCOORD11;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // float4 extraV2F7 : TEXCOORD12;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD13; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity : TEXCOORD14;
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
               UNITY_VERTEX_OUTPUT_STEREO
            };

            struct ExtraV2F
            {
               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;
               Blackboard blackboard;
               float4 time;
            };


            float3 WorldToTangentSpace(ShaderData d, float3 normal)
            {
               return mul(d.TBNMatrix, normal);
            }

            float3 TangentToWorldSpace(ShaderData d, float3 normal)
            {
               return mul(normal, d.TBNMatrix);
            }

            // in this case, make standard more like SRPs, because we can't fix
            // unity_WorldToObject in HDRP, since it already does macro-fu there

            #if _STANDARD
               float3 TransformWorldToObject(float3 p) { return mul(unity_WorldToObject, float4(p, 1)); };
               float3 TransformObjectToWorld(float3 p) { return mul(unity_ObjectToWorld, float4(p, 1)); };
               float4 TransformWorldToObject(float4 p) { return mul(unity_WorldToObject, p); };
               float4 TransformObjectToWorld(float4 p) { return mul(unity_ObjectToWorld, p); };
               float4x4 GetWorldToObjectMatrix() { return unity_WorldToObject; }
               float4x4 GetObjectToWorldMatrix() { return unity_ObjectToWorld; }
               #if (defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (SHADER_TARGET_SURFACE_ANALYSIS && !SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod) tex.SampleLevel (sampler##tex,coord, lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) tex.SampleLevel (sampler##samplertex,coord, lod)
              #else
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex2D (tex,coord,0,lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) tex2D (tex,coord,0,lod)
              #endif

               #undef GetWorldToObjectMatrix()

               #define GetWorldToObjectMatrix()   unity_WorldToObject


            #endif

            float3 GetCameraWorldPosition()
            {
               #if _HDRP
                  return GetCameraRelativePositionWS(_WorldSpaceCameraPos);
               #else
                  return _WorldSpaceCameraPos;
               #endif
            }

            #if _GRABPASSUSED
               #if _STANDARD
                  TEXTURE2D(%GRABTEXTURE%);
                  SAMPLER(sampler_%GRABTEXTURE%);
               #endif

               half3 GetSceneColor(float2 uv)
               {
                  #if _STANDARD
                     return SAMPLE_TEXTURE2D(%GRABTEXTURE%, sampler_%GRABTEXTURE%, uv).rgb;
                  #else
                     return SHADERGRAPH_SAMPLE_SCENE_COLOR(uv);
                  #endif
               }
            #endif


      
            #if _STANDARD
               UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
               float GetSceneDepth(float2 uv) { return SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv)); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv)); } 
            #else
               float GetSceneDepth(float2 uv) { return SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv), _ZBufferParams); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv), _ZBufferParams); } 
            #endif

            float3 GetWorldPositionFromDepthBuffer(float2 uv, float3 worldSpaceViewDir)
            {
               float eye = GetLinearEyeDepth(uv);
               float3 camView = mul((float3x3)GetObjectToWorldMatrix(), transpose(mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V)) [2].xyz);

               float dt = dot(worldSpaceViewDir, camView);
               float3 div = worldSpaceViewDir/dt;
               float3 wpos = (eye * div) + GetCameraWorldPosition();
               return wpos;
            }

            #if _HDRP
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return GetAbsolutePositionWS(TransformObjectToWorld(pos));
            }
            #else
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return TransformObjectToWorld(pos);
            }
            #endif

            #if _STANDARD
               UNITY_DECLARE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture);
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  float4 depthNorms = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture, uv);
                  float3 norms = DecodeViewNormalStereo(depthNorms);
                  norms = mul((float3x3)GetWorldToViewMatrix(), norms) * 0.5 + 0.5;
                  return norms;
               }
            #elif _HDRP
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  NormalData nd;
                  DecodeFromNormalBuffer(_ScreenSize.xy * uv, nd);
                  return nd.normalWS;
               }
            #elif _URP
               #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                  #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
               #endif

               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                     return SampleSceneNormals(uv);
                  #else
                     float3 wpos = GetWorldPositionFromDepthBuffer(uv, worldSpaceViewDir);
                     return normalize(-cross(ddx(wpos), ddy(wpos))) * 0.5 + 0.5;
                  #endif

                }
             #endif

             #if _HDRP

               half3 UnpackNormalmapRGorAG(half4 packednormal)
               {
                     // This do the trick
                  packednormal.x *= packednormal.w;

                  half3 normal;
                  normal.xy = packednormal.xy * 2 - 1;
                  normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                  return normal;
               }
               half3 UnpackNormal(half4 packednormal)
               {
                  #if defined(UNITY_NO_DXT5nm)
                     return packednormal.xyz * 2 - 1;
                  #else
                     return UnpackNormalmapRGorAG(packednormal);
                  #endif
               }
               #endif
               #if _HDRP || _URP

               half3 UnpackScaleNormal(half4 packednormal, half scale)
               {
                 #ifndef UNITY_NO_DXT5nm
                   // Unpack normal as DXT5nm (1, y, 1, x) or BC5 (x, y, 0, 1)
                   // Note neutral texture like "bump" is (0, 0, 1, 1) to work with both plain RGB normal and DXT5nm/BC5
                   packednormal.x *= packednormal.w;
                 #endif
                   half3 normal;
                   normal.xy = (packednormal.xy * 2 - 1) * scale;
                   normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                   return normal;
               }	

             #endif


            void GetSun(out float3 lightDir, out float3 color)
            {
               lightDir = float3(0.5, 0.5, 0);
               color = 1;
               #if _HDRP
                  if (_DirectionalLightCount > 0)
                  {
                     DirectionalLightData light = _DirectionalLightDatas[0];
                     lightDir = -light.forward.xyz;
                     color = light.color;
                  }
               #elif _STANDARD
			         lightDir = normalize(_WorldSpaceLightPos0.xyz);
                  color = _LightColor0.rgb;
               #elif _URP
	               Light light = GetMainLight();
	               lightDir = light.direction;
	               color = light.color;
               #endif
            }


            
         CBUFFER_START(UnityPerMaterial)

            
	int _DiffuseLightingStyle;
	int _SpecularLightingStyle;
	int _CutoffEnabled;
	float _Cutoff;
	half4 _Color;
	float _AmbientShadowStrength;
	float _NormalMapStr;
	float4 _TilingOffset;
	int _DiffuseSteps;
	int _SpecularType;
	int _SpecularSteps;
	int _SpecularHatching;
	float2 _DiffuseEdge;
	int _DiffuseTextureMapping;
	int _ScreenStableDistanceScale;
	int _ScreenStableDistanceScaleSpec;
	float _DiffuseTextureSize;
	float _DiffuseRim;
	float2 _SpecularEdge;
	int _LinesOn;
	int _InvertShadowedLines;
	int _DiffuseHatching;
	float _DiffuseTextureContrast;
	float3 _HatchingRanges;
	float3 _HatchingRangesSpec;
	int _SpecularTextureMapping;
	float _SpecularTextureSize;
	int _KeepLinesThicc;
	float _SpecularTextureContrast;
	int _ReflectionsEnabled;
	float4 _ReflectionFresnelParams;
	float _BaseReflectStrength;
	float3 _EmissionColor;
	float _LightmapEmissionStr;
	float2 _PaintMaskEdges;



         CBUFFER_END

         

         

         #ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()


	// TODO:
	// Flip backface normals
	// Alpha cutoff support

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskMap);
	SAMPLER(sampler_MaskMap);

	TEXTURE2D(_BumpMap);
	SAMPLER(sampler_BumpMap);

	TEXTURE2D(_DiffuseTexture);
	TEXTURE2D(_SpecularTexture);

	TEXTURE2D(_EmissionTexture);
	SAMPLER(sampler_EmissionTexture);

	TEXTURE3D(_WobbleTexture);

	float invLerp(float from, float to, float value) {
		return (value - from) / (to - from);
	}

	float4 invLerp(float4 from, float4 to, float4 value) {
		return (value - from) / (to - from);
	}

	float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value){
		float rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	float4 remap(float4 origFrom, float4 origTo, float4 targetFrom, float4 targetTo, float4 value){
		float4 rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	SAMPLER(s_linear_repeat_sampler);

	void MainLight(out float3 direction, out float3 color, out float distanceAtten)
	{
		Light mainLight = GetMainLight();
		direction = mainLight.direction;
		color = mainLight.color;
		distanceAtten = mainLight.distanceAttenuation;
	}

	float ToonSharpen(float input, float edge = 0.1f)
	{
		float fw = fwidth(input)*0.5;
		return saturate(remap(edge - fw, edge + fw, 0, 1, input));
	}

	float3 Posterize(float3 input, int steps)
	{
		return round(input*steps)/steps;
	}

	float Posterize(float input, int steps)
	{
		return round(input*steps)/steps;

	}

	float Fresnel(float3 worldNormal, float3 viewAngle, float exp = 4)
	{
		return 1 - pow(abs(dot(worldNormal, viewAngle)),exp);
	}

	float MainLightShadows(float3 worldPos, float2 lightmapUV = float2(0.0,0.0))
	{
		float4 shadowCoord = TransformWorldToShadowCoord(worldPos);

		#if !defined (LIGHTMAP_ON) || defined(_LIGHTINGTYPE_VERTEX)
			half4 shadowMask = unity_ProbesOcclusion;
		#else
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half4 shadowMask = SAMPLE_SHADOWMASK(lightmapUV);
		#endif

		return ToonSharpen(MainLightShadow(shadowCoord, worldPos, shadowMask, _MainLightOcclusionProbes), 0.5f);
	}

	float3 GetAmbient(float3 worldNormal, float2 lightmapUV)
	{
		#ifdef LIGHTMAP_ON
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half3 bakedGI = SampleLightmap(lightmapUV, worldNormal);

			#if defined(_MIXED_LIGHTING_SUBTRACTIVE)
				Light mainLight = GetMainLight();
				bakedGI = SubtractDirectMainLightFromLightmap(mainLight, worldNormal, bakedGI);
			#endif

			return bakedGI;
		#else
			return SampleSH(worldNormal);
		#endif
	}

	float3 GetReflections(float3 worldNormal, float3 viewDir, float smoothness)
	{
		float perceptualRoughness = 1 - smoothness;
		perceptualRoughness *= perceptualRoughness;
		float mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
		float3 sample = SHADERGRAPH_REFLECTION_PROBE(viewDir, worldNormal, mip);
		return sample.rgb;
	}

	void SSAO(ShaderData d, out float directOcclusion, out float indirectOcclusion)
	{
		#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(ALPHABLEND)
			float2 uv = d.screenUV;

			AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(uv);
			directOcclusion = aoFactor.directAmbientOcclusion;
			indirectOcclusion = aoFactor.indirectAmbientOcclusion;
		#else
			directOcclusion = 1;
			indirectOcclusion = 1;
		#endif
	}

	half3 Triplanar(Texture2D tex, half3 samplePos, half3 normal, float size)
	{
		half2 uvX = samplePos.zy;
		half2 uvY = samplePos.xz + 0.67;
		half2 uvZ = samplePos.xy + 0.33;

		half3 lx = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvX / size).rgb;
		half3 ly = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvY / size).rgb;
		half3 lz = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvZ / size).rgb;

		float3 blend = pow(abs(normal),4);
		blend /= dot(blend, float3(1,1,1));

		return lx * blend.x + ly * blend.y + lz * blend.z;
	}

	half3 ViewDirLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float3 objPos = TransformObjectToWorld(0);
		float dist = distance(objPos, _WorldSpaceCameraPos);

		float3 samplePos = d.worldSpaceViewDir - _WorldSpaceCameraPos/dist;

		return Triplanar(tex, samplePos, d.worldSpaceViewDir, size);
	}

	half3 ScreenStableLightingTexture(ShaderData d, Texture2D tex, float size, int screenStableDistScale)
	{
		float3 objPos = TransformObjectToWorld(0);

		float dist = 3;

		if (screenStableDistScale)
			dist = distance(_WorldSpaceCameraPos, objPos);

		float4 clipPos = TransformObjectToHClip(TransformWorldToObject(d.worldSpacePosition));
		clipPos = ComputeScreenPos(clipPos);
		clipPos.xy /= clipPos.w;

		float4 objClipPos = TransformWorldToHClip(objPos);
		objClipPos = ComputeScreenPos(objClipPos);
		objClipPos.xy /= objClipPos.w;

		float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
		objClipPos.xy *= screenratio;
		clipPos.xy *= screenratio; 

		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, (clipPos.rg - objClipPos.rg) * size * dist).rgb;
	}

	half3 WorldSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, d.worldSpacePosition, d.worldSpaceNormal, size);
	}

	half3 ObjectSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, TransformWorldToObject(d.worldSpacePosition), TransformWorldToObject(d.worldSpaceNormal), size);
	}

	half3 ScreenSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float screenratio = _ScreenParams.x / _ScreenParams.y;
		float2 uv = d.screenUV;
		uv.x *= screenratio;
		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uv / size).rgb;
	}

	float TexturedDiffuse(float3 lightingTex, float inputDiffuse, float lightStr = 1, bool mainLight = false)
	{
		lightingTex = pow(abs(lightingTex), _DiffuseTextureContrast);
		float origDiffuse = inputDiffuse;
		if (mainLight)
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse));
		else
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse*lightStr));

		UNITY_BRANCH
		if (_DiffuseHatching == 0)
		{	
			origDiffuse = ToonSharpen(max(1 - lightingTex.r,0.025), 1 - origDiffuse);
		}
		else
		{
			lightingTex = max(1 - lightingTex,0.01);
			float3 hatchDiffuse = origDiffuse;
			hatchDiffuse.r = smoothstep(0, _HatchingRanges.r, origDiffuse);
			hatchDiffuse.g = smoothstep(0, _HatchingRanges.g, origDiffuse);
			hatchDiffuse.b = smoothstep(0, _HatchingRanges.b, origDiffuse);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchDiffuse.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchDiffuse.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchDiffuse.b);

			float combined = min(min(lightingTex.r, lightingTex.g),lightingTex.b);
			origDiffuse = ToonSharpen(combined, 1 - origDiffuse)*lightStr;
		}
		return origDiffuse;
	}

	float TexturedSpecular(float3 lightingTex, float inputSpec, float lightStr = 1)
	{
		
		lightingTex = pow(abs(lightingTex), _SpecularTextureContrast);
		//lightingTex -= 0.15;
		float origSpecular = smoothstep(_SpecularEdge.x, _SpecularEdge.y, saturate(inputSpec*lightStr*0.5));

		UNITY_BRANCH
		if (_SpecularHatching == 0)
		{	
			origSpecular = 1 - smoothstep(0, origSpecular, ToonSharpen(1 - lightingTex.r, origSpecular));
		}
		else
		{
			lightingTex = 1 - lightingTex;
			float3 hatchSpec = origSpecular;
			hatchSpec.r = smoothstep(1 - _HatchingRangesSpec.r, 1, origSpecular);
			hatchSpec.g = smoothstep(1 - _HatchingRangesSpec.g, 1, origSpecular);
			hatchSpec.b = smoothstep(1 - _HatchingRangesSpec.b, 1, origSpecular);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchSpec.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchSpec.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchSpec.b);

			float combined = max(max(lightingTex.r, lightingTex.g),lightingTex.b);
			origSpecular = smoothstep(0, origSpecular, combined);
		}
		return origSpecular;
	}

	float GetDiffuse(float3 lightingTex, Light l, ShaderData d, Surface o, bool mainLight = false, float lineArt = 1)
	{
		float diffuse = saturate(dot(l.direction, d.worldSpaceNormal));
		
		#if defined(_DIFFUSELIGHTINGSTYLE_STEPPED)
			diffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, diffuse);
			diffuse *= length(l.color);
			diffuse *= l.shadowAttenuation * saturate(l.distanceAttenuation);
			if (_DiffuseSteps > 1)
			{
				
				float origDiffuse = diffuse;
				float powLerpFactor = saturate(invLerp(1, 12, _DiffuseSteps));
				float powFactor = lerp(0.5, 1, powLerpFactor);

				diffuse = Posterize(pow(abs(diffuse), powFactor), _DiffuseSteps);

			}
			else
				diffuse = ToonSharpen(diffuse,0.075);

			diffuse /= length(l.color);
		#elif defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			diffuse *= l.shadowAttenuation * l.distanceAttenuation;
			diffuse = TexturedDiffuse(lightingTex, diffuse, length(l.color), mainLight);
		#endif

		UNITY_BRANCH
		if (_DiffuseRim*lineArt*l.shadowAttenuation*l.distanceAttenuation > 0)
		{
			float rim = Fresnel(d.worldSpaceNormal, d.worldSpaceViewDir);
			float mainLightAlignment = saturate(-dot(d.worldSpaceViewDir, l.direction));
			
			float rimSize = lerp(1.0, 0.9, _DiffuseRim*l.distanceAttenuation*l.distanceAttenuation);

			rim = ToonSharpen(rim,lerp(1.01, rimSize, mainLightAlignment)) * ToonSharpen(mainLightAlignment);
			diffuse = max(diffuse, rim);
		}

		return diffuse;
	}
	
	float GetSpecular(float3 lightingTex, Light l, ShaderData d, Surface o)
	{
		float baseSpec = 0;
		float SpecSmoothness = exp2(10 * o.Smoothness + 1).x;

		[branch]
		if (_SpecularType == 0) //Cook-Torrance
		{
			float roughness = 1 - o.Smoothness;
			roughness *= roughness;

			float3 h = SafeNormalize(l.direction + d.worldSpaceViewDir);
			float nh = saturate(dot(d.worldSpaceNormal, h));
			float lh = saturate(dot(l.direction, h));
			float d = nh * nh * (roughness * roughness - 1.0) + 1.00001;
			float normTerm = roughness * 4.0 + 2.0;
			float specTerm = roughness * roughness;
			specTerm /= (d * d) * max(0.1, lh * lh) * normTerm;
			baseSpec = specTerm*0.04;
		}
		else if (_SpecularType == 1) //Phong
		{
			float3 r = reflect(-l.direction, d.worldSpaceNormal);
			float rdotv = max(0, dot(r, d.worldSpaceViewDir));

			baseSpec = pow(rdotv, SpecSmoothness)*o.Smoothness;
		}
		else if (_SpecularType == 2) //Blinn-Phong
		{
			float3 h = SafeNormalize(l.direction+d.worldSpaceViewDir);
			float ndh = saturate(dot(d.worldSpaceNormal, h));

			baseSpec = pow(ndh, SpecSmoothness)*o.Smoothness;
		}
		else
		{
			return 0;
		}

		

		#if defined(_SPECULARLIGHTINGSTYLE_BASIC)
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation * length(l.color);
			baseSpec = smoothstep(_SpecularEdge.x,_SpecularEdge.y, baseSpec);
			baseSpec /= length(l.color);
		#elif defined(_SPECULARLIGHTINGSTYLE_STEPPED)
			baseSpec *= saturate(l.distanceAttenuation) * l.shadowAttenuation;
			baseSpec *= length(l.color);
			baseSpec = Posterize(baseSpec, max(1,_SpecularSteps));
			baseSpec /= length(l.color);
		#else
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation;
			baseSpec = TexturedSpecular(lightingTex, baseSpec, length(l.color));
		#endif	

		
		return baseSpec;
	}

	void Ext_ModifyVertex0 (inout VertexData v, inout ExtraV2F d)
	{
		v.texcoord0.xy = v.texcoord0.xy * _TilingOffset.xy + _TilingOffset.zw;

		if (_DiffuseTextureMapping == 2)
		{
			float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
			clipPos.xy /= clipPos.w;  

			float3 objPos = TransformObjectToWorld(0);
			float camDist = distance(objPos, _WorldSpaceCameraPos);
			float4 objClipPos = TransformWorldToHClip(objPos);
			objClipPos.xy /= objClipPos.w;

			float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
			objClipPos.xy *= screenratio;
			clipPos.xy *= screenratio;

			v.texcoord3 = (clipPos - objClipPos); 
		}
	}

	void Ext_SurfaceFunction0 (inout Surface o, ShaderData d)
	{
		
		// Handle input data
		float4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, d.texcoord0.xy);
		float4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, d.texcoord0.xy);
		o.Normal = UnpackScaleNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, d.texcoord0.xy), _NormalMapStr);
		d.worldSpaceNormal = TransformTangentToWorld(o.Normal, d.TBNMatrix);

		float diffuseColorMult = 1.0f;
		float specColorMult = 1.0f;

		if (_DiffuseLightingStyle == 1)
			diffuseColorMult = 0.5f;

		if (_SpecularLightingStyle = 2)
			specColorMult = 0.5f;

		if (!d.isFrontFace)
		{
			d.worldSpaceNormal *= -1;
		}

		o.Metallic = masks.r;
		o.Smoothness = masks.g;
		o.Alpha = baseColor.a * _Color.a;

		if (_CutoffEnabled)
			clip(o.Alpha - _Cutoff);

		o.Occlusion = 1;
		float3 specColor = 1;
		float paintmask = masks.b;

		float3 paintedColor = baseColor.rgb * _Color.rgb;
		baseColor.rgb = lerp(baseColor.rgb, paintedColor, smoothstep(_PaintMaskEdges.x, _PaintMaskEdges.y, paintmask));

		#if defined(_EMISSION)
			o.Emission = SAMPLE_TEXTURE2D(_EmissionTexture, sampler_EmissionTexture, d.texcoord0).rgb * _EmissionColor;
		#endif

		half lines = 1;
		half origlines = 1;
		float lineCutoff = 0.5;

		#if defined(LIGHTMAP_ON)
			half4 shadowMask = SAMPLE_SHADOWMASK(d.texcoord1.xy);
		#else
			half4 shadowMask = unity_ProbesOcclusion;
		#endif

		// -------------
		// LINE ART
		// -------------
		UNITY_BRANCH
		if (_LinesOn)
		{
			UNITY_BRANCH
			if (_KeepLinesThicc)
			{
				float dist = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
				float fresnel = pow(abs(dot(d.worldSpaceNormal, d.worldSpaceViewDir)),3);
				lineCutoff = lerp(0.5, 0.95, max(saturate(dist*0.2), fresnel));
			}
			lines = 1 - masks.a;

			 // Save original lines to use if ambient is raised
		}

		#ifdef _DBUFFER
			ApplyDecal(d.clipPos, baseColor.rgb, specColor, d.worldSpaceNormal, o.Metallic, lines, o.Smoothness);
		#endif

		if (_LinesOn)
		{
			lines = ToonSharpen(lines, lineCutoff);
			origlines = lines;
		}
		else
		{
			lines = 1;
		}

		// Store lighting values in these
		float3 mainLightDir;
		float3 mainLightCol;
		float mainLightAtten;
		MainLight(mainLightDir, mainLightCol, mainLightAtten);

		float2 lightmapUV = d.texcoord1.xy;

		float mainShadows = MainLightShadows(d.worldSpacePosition, lightmapUV);
		float3 ambient = GetAmbient(d.worldSpaceNormal, lightmapUV) * baseColor.rgb;

		Light mainLight = GetMainLight();

		#if   defined(_DIFFUSETEXTUREMAPPING_SCREENSPACE)
			float3 diffuseLightingTex = ScreenSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_VIEWDIRECTION)
			float3 diffuseLightingTex = ViewDirLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_SCREENSTABLE)
			float3 diffuseLightingTex = ScreenStableLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize, _ScreenStableDistanceScale);
		#elif defined(_DIFFUSETEXTUREMAPPING_WORLDSPACE)
			float3 diffuseLightingTex = WorldSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_OBJECTSPACE)
			float3 diffuseLightingTex = ObjectSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#endif

		#if   defined(_SPECULARTEXTUREMAPPING_SCREENSPACE)
			float3 specLightingTex = ScreenSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_VIEWDIRECTION)
			float3 specLightingTex = ViewDirLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_SCREENSTABLE)
			float3 specLightingTex = ScreenStableLightingTexture(d, _SpecularTexture, _SpecularTextureSize, _ScreenStableDistanceScale);
		#elif defined(_SPECULARTEXTUREMAPPING_WORLDSPACE)
			float3 specLightingTex = WorldSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_OBJECTSPACE)
			float3 specLightingTex = ObjectSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#endif
		

		float indirOcclusion, directOcclusion;
		SSAO(d, directOcclusion, indirOcclusion);

		#if defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			directOcclusion = TexturedDiffuse(diffuseLightingTex, directOcclusion);
			//indirOcclusion = TexturedDiffuse(diffuseLightingTex, indirOcclusion);
			ambient = min(indirOcclusion, ambient);
		#endif

		float mainDiffuseFactor = GetDiffuse(diffuseLightingTex, mainLight, d, o, true, lines)*directOcclusion*diffuseColorMult;
		mainDiffuseFactor *= mainShadows;
		float mainSpecFactor = GetSpecular(specLightingTex, mainLight, d, o) * specColorMult;
		
		float3 addLightDiffuse = 0;
		float3 addLightSpecular = 0;
		// -------------
		// ADDITIONALLIGHTS
		// -------------
		int pixelLights = GetAdditionalLightsCount();
		for (int i = 0; i < pixelLights; ++i)
		{
			Light light = GetAdditionalLight(i, d.worldSpacePosition, shadowMask);

			float diffuse = GetDiffuse(diffuseLightingTex, light, d, o, false, lines) * diffuseColorMult;
			float specular = GetSpecular(specLightingTex, light, d, o) * specColorMult;

			addLightDiffuse += diffuse * light.color;
			addLightSpecular += specular * light.color;
		}
		
		float diffuseDarkest = ToonSharpen(length(addLightDiffuse)+saturate(mainDiffuseFactor*length(mainLight.color)),0.025);

		// -------------
		// REFLECTIONS
		// -------------
		float3 reflections = 0;
		
		#if defined(_REFLECTIONSENABLED_ON)
			float reflectStr = 0.04*_BaseReflectStrength*2;;
			reflections = GetReflections(d.worldSpaceNormal, d.worldSpaceViewDir, o.Smoothness);
			float perceptualRoughness = (1 - o.Smoothness);
			perceptualRoughness *= perceptualRoughness;		

			float fresnel = pow(1.0 - saturate(dot(d.worldSpaceNormal, d.worldSpaceViewDir)-_ReflectionFresnelParams.y), _ReflectionFresnelParams.x*16);
			fresnel = smoothstep(_ReflectionFresnelParams.w*0.5, 1 - _ReflectionFresnelParams.w*0.5, fresnel);
			reflectStr = lerp(reflectStr, clamp(0, 2, 0.04*_ReflectionFresnelParams.z*50), fresnel);

			reflections *= reflectStr;
			reflections /= perceptualRoughness + 0.5;

			reflections = lerp(reflections, reflections * baseColor.rgb, o.Metallic);
		#endif
		
		#if defined(ALPHABLEND) && !defined(_PASSMETA)

			if (_OpaqueLines)
				o.Alpha = max(o.Alpha, 1 - lines);

			UNITY_BRANCH
			if (_PreserveSpec)
			{
				o.Alpha = max(Luminance(reflections), o.Alpha);
				o.Alpha = max(mainSpecFactor, o.Alpha);
				o.Alpha = max(addLightSpecular, o.Alpha);
			}

			float3 refractionCol = 0;
			float origAlpha = o.Alpha;
			UNITY_BRANCH
			if (_Refraction)
			{
				float4 offsetPos = float4(d.worldSpacePosition + d.worldSpaceNormal * _RefractionStr, 1.0);
				offsetPos = mul(GetWorldToHClipMatrix(), offsetPos);
				float scale = 1.0;

				#if UNITY_UV_STARTS_AT_TOP
					scale = -1.0;
				#endif

				float4 grabPos = offsetPos *0.5f;
				grabPos.xy = float2(grabPos.x, grabPos.y*scale) + grabPos.w;
				grabPos.zw = offsetPos.zw;
				grabPos.xy /= grabPos.w;
				grabPos.xy = saturate(grabPos.xy);

				float3 refraction = GetSceneColor(grabPos.xy);
				refractionCol = refraction;
				if (_RefractionTint)
					refraction *= baseColor.rgb;

				_RefractionEdge = 1 - _RefractionEdge;
				if (_RefractionEdge > 0)
				{
					float2 cubemapBlendFactors = pow(abs((grabPos.xy - 0.5) * 2.0),0.25);
					float blend = smoothstep(_RefractionEdge, 1, max(cubemapBlendFactors.x, cubemapBlendFactors.y));
					float3 refractDir = refract(-d.worldSpaceViewDir, d.worldSpaceNormal, 1 - _RefractionStr);
					float3 reflectProbe = GetReflections(-refractDir, refractDir, 1.0);
					
					refractionCol = lerp(refraction, reflectProbe, blend);
				}
				
				o.Alpha = 1;
			}

		#endif		

		float3 mainSpec = mainSpecFactor * mainLightCol;
		float3 mainDiffuse = mainDiffuseFactor * mainLightCol;

		addLightSpecular = lerp(addLightSpecular, addLightSpecular * baseColor.rgb, o.Metallic);
		mainSpec = lerp(mainSpec, mainSpec * specColor, o.Metallic);

		lines = lerp(1 - lines, lines, diffuseDarkest);
		
		if (_InvertShadowedLines)
			diffuseDarkest = lerp(diffuseDarkest, 1, lines);

		o.Albedo = baseColor.rgb;
		o.Emission *= _LightmapEmissionStr;
		#if !defined(_PASSMETA)
			o.Albedo *= mainDiffuse * lines;
			o.Albedo += reflections* mainDiffuse *lines;
			o.Albedo += addLightDiffuse * lines * baseColor.rgb + addLightSpecular * lines;
			o.Albedo += mainSpec * mainDiffuse * mainShadows * lines;
			
			o.Albedo += lerp(ambient*diffuseDarkest * lines, ambient*origlines, _AmbientShadowStrength);
			#if defined(ALPHABLEND)
				if (_Refraction)
				{
					o.Albedo = lerp(refractionCol, o.Albedo, origAlpha);
				}
			#endif
			o.Albedo += o.Emission;
		#endif
	}




        
            void ChainSurfaceFunction(inout Surface l, inout ShaderData d)
            {
                  Ext_SurfaceFunction0(l, d);
                 // Ext_SurfaceFunction1(l, d);
                 // Ext_SurfaceFunction2(l, d);
                 // Ext_SurfaceFunction3(l, d);
                 // Ext_SurfaceFunction4(l, d);
                 // Ext_SurfaceFunction5(l, d);
                 // Ext_SurfaceFunction6(l, d);
                 // Ext_SurfaceFunction7(l, d);
                 // Ext_SurfaceFunction8(l, d);
                 // Ext_SurfaceFunction9(l, d);
		           // Ext_SurfaceFunction10(l, d);
                 // Ext_SurfaceFunction11(l, d);
                 // Ext_SurfaceFunction12(l, d);
                 // Ext_SurfaceFunction13(l, d);
                 // Ext_SurfaceFunction14(l, d);
                 // Ext_SurfaceFunction15(l, d);
                 // Ext_SurfaceFunction16(l, d);
                 // Ext_SurfaceFunction17(l, d);
                 // Ext_SurfaceFunction18(l, d);
		           // Ext_SurfaceFunction19(l, d);
                 // Ext_SurfaceFunction20(l, d);
                 // Ext_SurfaceFunction21(l, d);
                 // Ext_SurfaceFunction22(l, d);
                 // Ext_SurfaceFunction23(l, d);
                 // Ext_SurfaceFunction24(l, d);
                 // Ext_SurfaceFunction25(l, d);
                 // Ext_SurfaceFunction26(l, d);
                 // Ext_SurfaceFunction27(l, d);
                 // Ext_SurfaceFunction28(l, d);
		           // Ext_SurfaceFunction29(l, d);
            }

            void ChainModifyVertex(inout VertexData v, inout VertexToPixel v2p, float4 time)
            {
                 ExtraV2F d;
                 
                 ZERO_INITIALIZE(ExtraV2F, d);
                 ZERO_INITIALIZE(Blackboard, d.blackboard);
                 // due to motion vectors in HDRP, we need to use the last
                 // time in certain spots. So if you are going to use _Time to adjust vertices,
                 // you need to use this time or motion vectors will break. 
                 d.time = time;

                   Ext_ModifyVertex0(v, d);
                 // Ext_ModifyVertex1(v, d);
                 // Ext_ModifyVertex2(v, d);
                 // Ext_ModifyVertex3(v, d);
                 // Ext_ModifyVertex4(v, d);
                 // Ext_ModifyVertex5(v, d);
                 // Ext_ModifyVertex6(v, d);
                 // Ext_ModifyVertex7(v, d);
                 // Ext_ModifyVertex8(v, d);
                 // Ext_ModifyVertex9(v, d);
                 // Ext_ModifyVertex10(v, d);
                 // Ext_ModifyVertex11(v, d);
                 // Ext_ModifyVertex12(v, d);
                 // Ext_ModifyVertex13(v, d);
                 // Ext_ModifyVertex14(v, d);
                 // Ext_ModifyVertex15(v, d);
                 // Ext_ModifyVertex16(v, d);
                 // Ext_ModifyVertex17(v, d);
                 // Ext_ModifyVertex18(v, d);
                 // Ext_ModifyVertex19(v, d);
                 // Ext_ModifyVertex20(v, d);
                 // Ext_ModifyVertex21(v, d);
                 // Ext_ModifyVertex22(v, d);
                 // Ext_ModifyVertex23(v, d);
                 // Ext_ModifyVertex24(v, d);
                 // Ext_ModifyVertex25(v, d);
                 // Ext_ModifyVertex26(v, d);
                 // Ext_ModifyVertex27(v, d);
                 // Ext_ModifyVertex28(v, d);
                 // Ext_ModifyVertex29(v, d);


                 // #if %EXTRAV2F0REQUIREKEY%
                 // v2p.extraV2F0 = d.extraV2F0;
                 // #endif

                 // #if %EXTRAV2F1REQUIREKEY%
                 // v2p.extraV2F1 = d.extraV2F1;
                 // #endif

                 // #if %EXTRAV2F2REQUIREKEY%
                 // v2p.extraV2F2 = d.extraV2F2;
                 // #endif

                 // #if %EXTRAV2F3REQUIREKEY%
                 // v2p.extraV2F3 = d.extraV2F3;
                 // #endif

                 // #if %EXTRAV2F4REQUIREKEY%
                 // v2p.extraV2F4 = d.extraV2F4;
                 // #endif

                 // #if %EXTRAV2F5REQUIREKEY%
                 // v2p.extraV2F5 = d.extraV2F5;
                 // #endif

                 // #if %EXTRAV2F6REQUIREKEY%
                 // v2p.extraV2F6 = d.extraV2F6;
                 // #endif

                 // #if %EXTRAV2F7REQUIREKEY%
                 // v2p.extraV2F7 = d.extraV2F7;
                 // #endif
            }

            void ChainModifyTessellatedVertex(inout VertexData v, inout VertexToPixel v2p)
            {
               ExtraV2F d;
               ZERO_INITIALIZE(ExtraV2F, d);
               ZERO_INITIALIZE(Blackboard, d.blackboard);

               // #if %EXTRAV2F0REQUIREKEY%
               // d.extraV2F0 = v2p.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // d.extraV2F1 = v2p.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // d.extraV2F2 = v2p.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // d.extraV2F3 = v2p.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // d.extraV2F4 = v2p.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // d.extraV2F5 = v2p.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // d.extraV2F6 = v2p.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // d.extraV2F7 = v2p.extraV2F7;
               // #endif


               // Ext_ModifyTessellatedVertex0(v, d);
               // Ext_ModifyTessellatedVertex1(v, d);
               // Ext_ModifyTessellatedVertex2(v, d);
               // Ext_ModifyTessellatedVertex3(v, d);
               // Ext_ModifyTessellatedVertex4(v, d);
               // Ext_ModifyTessellatedVertex5(v, d);
               // Ext_ModifyTessellatedVertex6(v, d);
               // Ext_ModifyTessellatedVertex7(v, d);
               // Ext_ModifyTessellatedVertex8(v, d);
               // Ext_ModifyTessellatedVertex9(v, d);
               // Ext_ModifyTessellatedVertex10(v, d);
               // Ext_ModifyTessellatedVertex11(v, d);
               // Ext_ModifyTessellatedVertex12(v, d);
               // Ext_ModifyTessellatedVertex13(v, d);
               // Ext_ModifyTessellatedVertex14(v, d);
               // Ext_ModifyTessellatedVertex15(v, d);
               // Ext_ModifyTessellatedVertex16(v, d);
               // Ext_ModifyTessellatedVertex17(v, d);
               // Ext_ModifyTessellatedVertex18(v, d);
               // Ext_ModifyTessellatedVertex19(v, d);
               // Ext_ModifyTessellatedVertex20(v, d);
               // Ext_ModifyTessellatedVertex21(v, d);
               // Ext_ModifyTessellatedVertex22(v, d);
               // Ext_ModifyTessellatedVertex23(v, d);
               // Ext_ModifyTessellatedVertex24(v, d);
               // Ext_ModifyTessellatedVertex25(v, d);
               // Ext_ModifyTessellatedVertex26(v, d);
               // Ext_ModifyTessellatedVertex27(v, d);
               // Ext_ModifyTessellatedVertex28(v, d);
               // Ext_ModifyTessellatedVertex29(v, d);

               // #if %EXTRAV2F0REQUIREKEY%
               // v2p.extraV2F0 = d.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // v2p.extraV2F1 = d.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // v2p.extraV2F2 = d.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // v2p.extraV2F3 = d.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // v2p.extraV2F4 = d.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // v2p.extraV2F5 = d.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // v2p.extraV2F6 = d.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // v2p.extraV2F7 = d.extraV2F7;
               // #endif
            }

            void ChainFinalColorForward(inout Surface l, inout ShaderData d, inout half4 color)
            {
               //   Ext_FinalColorForward0(l, d, color);
               //   Ext_FinalColorForward1(l, d, color);
               //   Ext_FinalColorForward2(l, d, color);
               //   Ext_FinalColorForward3(l, d, color);
               //   Ext_FinalColorForward4(l, d, color);
               //   Ext_FinalColorForward5(l, d, color);
               //   Ext_FinalColorForward6(l, d, color);
               //   Ext_FinalColorForward7(l, d, color);
               //   Ext_FinalColorForward8(l, d, color);
               //   Ext_FinalColorForward9(l, d, color);
               //  Ext_FinalColorForward10(l, d, color);
               //  Ext_FinalColorForward11(l, d, color);
               //  Ext_FinalColorForward12(l, d, color);
               //  Ext_FinalColorForward13(l, d, color);
               //  Ext_FinalColorForward14(l, d, color);
               //  Ext_FinalColorForward15(l, d, color);
               //  Ext_FinalColorForward16(l, d, color);
               //  Ext_FinalColorForward17(l, d, color);
               //  Ext_FinalColorForward18(l, d, color);
               //  Ext_FinalColorForward19(l, d, color);
               //  Ext_FinalColorForward20(l, d, color);
               //  Ext_FinalColorForward21(l, d, color);
               //  Ext_FinalColorForward22(l, d, color);
               //  Ext_FinalColorForward23(l, d, color);
               //  Ext_FinalColorForward24(l, d, color);
               //  Ext_FinalColorForward25(l, d, color);
               //  Ext_FinalColorForward26(l, d, color);
               //  Ext_FinalColorForward27(l, d, color);
               //  Ext_FinalColorForward28(l, d, color);
               //  Ext_FinalColorForward29(l, d, color);
            }

            void ChainFinalGBufferStandard(inout Surface s, inout ShaderData d, inout half4 GBuffer0, inout half4 GBuffer1, inout half4 GBuffer2, inout half4 outEmission, inout half4 outShadowMask)
            {
               //   Ext_FinalGBufferStandard0(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard1(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard2(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard3(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard4(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard5(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard6(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard7(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard8(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard9(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard10(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard11(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard12(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard13(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard14(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard15(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard16(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard17(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard18(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard19(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard20(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard21(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard22(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard23(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard24(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard25(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard26(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard27(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard28(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard29(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
            }



         

         ShaderData CreateShaderData(VertexToPixel i
                  #if NEED_FACING
                     , bool facing
                  #endif
         )
         {
            ShaderData d = (ShaderData)0;
            d.clipPos = i.pos;
            d.worldSpacePosition = i.worldPos;

            d.worldSpaceNormal = normalize(i.worldNormal);
            d.worldSpaceTangent = normalize(i.worldTangent.xyz);
            d.tangentSign = i.worldTangent.w;
            float3 bitangent = cross(i.worldTangent.xyz, i.worldNormal) * d.tangentSign * -1;
            

            d.TBNMatrix = float3x3(d.worldSpaceTangent, bitangent, d.worldSpaceNormal);
            d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

            d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
             d.texcoord0 = i.texcoord0;
             d.texcoord1 = i.texcoord1;
            // d.texcoord2 = i.texcoord2;

            // #if %TEXCOORD3REQUIREKEY%
             d.texcoord3 = i.texcoord3;
            // #endif

             d.isFrontFace = facing;
            // #if %VERTEXCOLORREQUIREKEY%
            // d.vertexColor = i.vertexColor;
            // #endif

            // these rarely get used, so we back transform them. Usually will be stripped.
            #if _HDRP
                // d.localSpacePosition = mul(unity_WorldToObject, float4(GetCameraRelativePositionWS(i.worldPos), 1)).xyz;
            #else
                // d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
            #endif
            // d.localSpaceNormal = normalize(mul((float3x3)unity_WorldToObject, i.worldNormal));
            // d.localSpaceTangent = normalize(mul((float3x3)unity_WorldToObject, i.worldTangent.xyz));

            // #if %SCREENPOSREQUIREKEY%
             d.screenPos = i.screenPos;
             d.screenUV = (i.screenPos.xy / i.screenPos.w);
            // #endif


            // #if %EXTRAV2F0REQUIREKEY%
            // d.extraV2F0 = i.extraV2F0;
            // #endif

            // #if %EXTRAV2F1REQUIREKEY%
            // d.extraV2F1 = i.extraV2F1;
            // #endif

            // #if %EXTRAV2F2REQUIREKEY%
            // d.extraV2F2 = i.extraV2F2;
            // #endif

            // #if %EXTRAV2F3REQUIREKEY%
            // d.extraV2F3 = i.extraV2F3;
            // #endif

            // #if %EXTRAV2F4REQUIREKEY%
            // d.extraV2F4 = i.extraV2F4;
            // #endif

            // #if %EXTRAV2F5REQUIREKEY%
            // d.extraV2F5 = i.extraV2F5;
            // #endif

            // #if %EXTRAV2F6REQUIREKEY%
            // d.extraV2F6 = i.extraV2F6;
            // #endif

            // #if %EXTRAV2F7REQUIREKEY%
            // d.extraV2F7 = i.extraV2F7;
            // #endif

            return d;
         }
         

         
         #if defined(_PASSSHADOW)
            float3 _LightDirection;
            float3 _LightPosition;
         #endif

         // vertex shader
         VertexToPixel Vert (VertexData v)
         {
           
           VertexToPixel o = (VertexToPixel)0;

           UNITY_SETUP_INSTANCE_ID(v);
           UNITY_TRANSFER_INSTANCE_ID(v, o);
           UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


#if !_TESSELLATION_ON
           ChainModifyVertex(v, o, _Time);
#endif

            o.texcoord0 = v.texcoord0;
            o.texcoord1 = v.texcoord1;
           // o.texcoord2 = v.texcoord2;

           // #if %TEXCOORD3REQUIREKEY%
            o.texcoord3 = v.texcoord3;
           // #endif

           // #if %VERTEXCOLORREQUIREKEY%
           // o.vertexColor = v.vertexColor;
           // #endif
           
           VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
           o.worldPos = TransformObjectToWorld(v.vertex.xyz);
           o.worldNormal = TransformObjectToWorldNormal(v.normal);
           o.worldTangent = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);

          // For some very odd reason, in 2021.2, we can't use Unity's defines, but have to use our own..
          #if _PASSSHADOW
              #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                 float3 lightDirectionWS = normalize(_LightPosition - o.worldPos);
              #else
                 float3 lightDirectionWS = _LightDirection;
              #endif
              // Define shadow pass specific clip position for Universal
              o.pos = TransformWorldToHClip(ApplyShadowBias(o.worldPos, o.worldNormal, lightDirectionWS));
              #if UNITY_REVERSED_Z
                  o.pos.z = min(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #else
                  o.pos.z = max(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #endif
          #elif _PASSMETA
              o.pos = MetaVertexPosition(float4(v.vertex.xyz, 0), v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
          #else
              o.pos = TransformWorldToHClip(o.worldPos);
          #endif

          // #if %SCREENPOSREQUIREKEY%
           o.screenPos = ComputeScreenPos(o.pos, _ProjectionParams.x);
          // #endif

          #if _PASSFORWARD || _PASSGBUFFER
              float2 uv1 = v.texcoord1.xy;
              OUTPUT_LIGHTMAP_UV(uv1, unity_LightmapST, o.lightmapUV);
               o.texcoord1.xy = uv1;
              OUTPUT_SH(o.worldNormal, o.sh);
              #if defined(DYNAMICLIGHTMAP_ON)
                   o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              #endif
          #endif

          #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
              half fogFactor = 0;
              #if defined(_FOG_FRAGMENT)
                fogFactor = ComputeFogFactor(o.pos.z);
              #endif
              #if _BAKEDLIT
                 o.fogFactorAndVertexLight = half4(fogFactor, 0, 0, 0);
              #else
                 half3 vertexLight = VertexLighting(o.worldPos, o.worldNormal);
                 o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
              #endif
          #endif

          #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             o.shadowCoord = GetShadowCoord(vertexInput);
          #endif

           return o;
         }


         

#if _UNLIT
   #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Unlit.hlsl"  
#endif

         // fragment shader
         half4 Frag (VertexToPixel IN
            #ifdef _DEPTHOFFSET_ON
              , out float outputDepth : SV_Depth
            #endif
            #if NEED_FACING
               , bool facing : SV_IsFrontFace
            #endif
         ) : SV_Target
         {
           UNITY_SETUP_INSTANCE_ID(IN);
           UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

           ShaderData d = CreateShaderData(IN
                  #if NEED_FACING
                     , facing
                  #endif
               );
           Surface l = (Surface)0;

           #ifdef _DEPTHOFFSET_ON
              l.outputDepth = outputDepth;
           #endif

           l.Albedo = half3(0.5, 0.5, 0.5);
           l.Normal = float3(0,0,1);
           l.Occlusion = 1;
           l.Alpha = 1;

           ChainSurfaceFunction(l, d);

           #ifdef _DEPTHOFFSET_ON
              outputDepth = l.outputDepth;
           #endif

           #if _USESPECULAR || _SIMPLELIT
              float3 specular = l.Specular;
              float metallic = 1;
           #else   
              float3 specular = 0;
              float metallic = l.Metallic;
           #endif


            
           
            InputData inputData = (InputData)0;

            inputData.positionWS = IN.worldPos;
            #if _WORLDSPACENORMAL
              inputData.normalWS = l.Normal;
            #else
              inputData.normalWS = normalize(TangentToWorldSpace(d, l.Normal));
            #endif

            inputData.viewDirectionWS = SafeNormalize(d.worldSpaceViewDir);


            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
                  inputData.shadowCoord = IN.shadowCoord;
            #elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                  inputData.shadowCoord = TransformWorldToShadowCoord(IN.worldPos);
            #else
                  inputData.shadowCoord = float4(0, 0, 0, 0);
            #endif
            
#if _BAKEDLIT
            inputData.fogCoord = IN.fogFactorAndVertexLight.x;
            inputData.vertexLighting = 0;
#else
            inputData.fogCoord = InitializeInputDataFog(float4(IN.worldPos, 1.0), IN.fogFactorAndVertexLight.x);
            inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
#endif    



            #if defined(_OVERRIDE_BAKEDGI)
               inputData.bakedGI = l.DiffuseGI;
               l.Emission += l.SpecularGI;
            #elif _BAKEDLIT
               inputData.bakedGI = SAMPLE_GI(IN.lightmapUV, IN.sh, inputData.normalWS);
            #else
               #if defined(DYNAMICLIGHTMAP_ON)
                  inputData.bakedGI = SAMPLE_GI(IN.lightmapUV, IN.dynamicLightmapUV.xy, IN.sh, inputData.normalWS);
               #else
                  inputData.bakedGI = SAMPLE_GI(IN.lightmapUV, IN.sh, inputData.normalWS);
               #endif
            #endif
            inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.pos);
            #if !_BAKEDLIT
               inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUV);
           
               #if defined(_OVERRIDE_SHADOWMASK)
                  float4 mulColor = saturate(dot(l.ShadowMask, _MainLightOcclusionProbes)); //unity_OcclusionMaskSelector));
                  inputData.shadowMask = mulColor;
               #endif
            #else
               inputData.shadowMask = float4(1,1,1,1);
            #endif

            #if defined(DEBUG_DISPLAY)
                #if defined(DYNAMICLIGHTMAP_ON)
                  inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
                #endif
                #if defined(LIGHTMAP_ON)
                  inputData.staticLightmapUV = IN.lightmapUV;
                #else
                  inputData.vertexSH = IN.sh;
                #endif
            #endif

            #if _WORLDSPACENORMAL
              float3 normalTS = WorldToTangentSpace(d, l.Normal);
            #else
              float3 normalTS = l.Normal;
            #endif

            SurfaceData surface         = (SurfaceData)0;
            surface.albedo              = l.Albedo;
            surface.metallic            = saturate(metallic);
            surface.specular            = specular;
            surface.smoothness          = saturate(l.Smoothness),
            surface.occlusion           = l.Occlusion,
            surface.emission            = l.Emission,
            surface.alpha               = saturate(l.Alpha);
            surface.clearCoatMask       = 0;
            surface.clearCoatSmoothness = 1;

            #ifdef _CLEARCOAT
                  surface.clearCoatMask       = saturate(l.CoatMask);
                  surface.clearCoatSmoothness = saturate(l.CoatSmoothness);
            #endif

            #if !_UNLIT
               half4 color = half4(l.Albedo, l.Alpha);
               #ifdef _DBUFFER
                  #if _BAKEDLIT
                     ApplyDecalToBaseColorAndNormal(IN.pos, color, inputData.normalWS);
                  #else
                     ApplyDecalToSurfaceData(IN.pos, surface, inputData);
                  #endif
               #endif
               #if _SIMPLELIT
                  color = UniversalFragmentBlinnPhong(
                     inputData,
                     surface);
               #elif _BAKEDLIT
                  color = UniversalFragmentBakedLit(inputData, color.rgb, color.a, normalTS);
               #else
                  color = UniversalFragmentPBR(inputData, surface);
               #endif

               #if !DISABLEFOG
                  color.rgb = MixFog(color.rgb, inputData.fogCoord);
               #endif

            #else // unlit
               #ifdef _DBUFFER
                  ApplyDecalToSurfaceData(IN.pos, surface, inputData);
               #endif
               half4 color = UniversalFragmentUnlit(inputData, l.Albedo, l.Alpha);
               #if !DISABLEFOG
                  color.rgb = MixFog(color.rgb, inputData.fogCoord);
               #endif
            #endif
            ChainFinalColorForward(l, d, color);

            return color;

         }

         ENDHLSL

      }


      
        Pass
        {
            Name "GBuffer"
            Tags
            {
               "LightMode" = "UniversalGBuffer"
            }
           
             Blend One Zero
             ZTest LEqual
             ZWrite On

            

            HLSLPROGRAM

               #pragma vertex Vert
   #pragma fragment Frag

            #pragma target 3.0

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma multi_compile_instancing
            #pragma multi_compile_fog
            #pragma instancing_options renderinglayer
            
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
            #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
            #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
            #pragma multi_compile_fragment _ _LIGHT_LAYERS
            #pragma multi_compile_fragment _ _RENDER_PASS_ENABLED
            #pragma multi_compile_fragment _ DEBUG_DISPLAY
            #pragma multi_compile _ SHADOWS_SHADOWMASK

            #define _FOG_FRAGMENT 1

            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define SHADERPASS SHADERPASS_GBUFFER
            #define _PASSGBUFFER 1

            
	#pragma multi_compile_local _DIFFUSELIGHTINGSTYLE_STEPPED _DIFFUSELIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _SPECULARLIGHTINGSTYLE_BASIC _SPECULARLIGHTINGSTYLE_STEPPED _SPECULARLIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _DIFFUSETEXTUREMAPPING_SCREENSPACE _DIFFUSETEXTUREMAPPING_VIEWDIRECTION _DIFFUSETEXTUREMAPPING_SCREENSTABLE _DIFFUSETEXTUREMAPPING_WORLDSPACE _DIFFUSETEXTUREMAPPING_OBJECTSPACE
	#pragma multi_compile_local _SPECULARTEXTUREMAPPING_SCREENSPACE _SPECULARTEXTUREMAPPING_VIEWDIRECTION _SPECULARTEXTUREMAPPING_SCREENSTABLE _SPECULARTEXTUREMAPPING_WORLDSPACE _SPECULARTEXTUREMAPPING_OBJECTSPACE
	#pragma shader_feature_local _EMISSION
	#pragma shader_feature_local _REFLECTIONSENABLED_ON


   #define _URP 1

#define _UNLIT 1
#define _USINGTEXCOORD1 1
#define NEED_FACING 1

            

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
            

            

                  #undef WorldNormalVector
      #define WorldNormalVector(data, normal) mul(normal, data.TBNMatrix)
      
      #define UnityObjectToWorldNormal(normal) mul(GetObjectToWorldMatrix(), normal)

      #define _WorldSpaceLightPos0 _MainLightPosition
      
      #define UNITY_DECLARE_TEX2D(name) TEXTURE2D(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2D_NOSAMPLER(name) TEXTURE2D(name);
      #define UNITY_DECLARE_TEX2DARRAY(name) TEXTURE2D_ARRAY(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(name) TEXTURE2D_ARRAY(name);

      #define UNITY_SAMPLE_TEX2DARRAY(tex,coord)            SAMPLE_TEXTURE2D_ARRAY(tex, sampler##tex, coord.xy, coord.z)
      #define UNITY_SAMPLE_TEX2DARRAY_LOD(tex,coord,lod)    SAMPLE_TEXTURE2D_ARRAY_LOD(tex, sampler##tex, coord.xy, coord.z, lod)
      #define UNITY_SAMPLE_TEX2D(tex, coord)                SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
      #define UNITY_SAMPLE_TEX2D_SAMPLER(tex, samp, coord)  SAMPLE_TEXTURE2D(tex, sampler##samp, coord)

      #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod)   SAMPLE_TEXTURE2D_LOD(tex, sampler_##tex, coord, lod)
      #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) SAMPLE_TEXTURE2D_LOD (tex, sampler##samplertex,coord, lod)
     
      #if defined(UNITY_COMPILER_HLSL)
         #define UNITY_INITIALIZE_OUTPUT(type,name) name = (type)0;
      #else
         #define UNITY_INITIALIZE_OUTPUT(type,name)
      #endif

      #define sampler2D_float sampler2D
      #define sampler2D_half sampler2D

      

      // data across stages, stripped like the above.
      struct VertexToPixel
      {
         float4 pos : SV_POSITION;
         float3 worldPos : TEXCOORD0;
         float3 worldNormal : TEXCOORD1;
         float4 worldTangent : TEXCOORD2;
          float4 texcoord0 : TEXCOORD3;
          float4 texcoord1 : TEXCOORD4;
         // float4 texcoord2 : TEXCOORD5;

         // #if %TEXCOORD3REQUIREKEY%
          float4 texcoord3 : TEXCOORD6;
         // #endif

         // #if %SCREENPOSREQUIREKEY%
          float4 screenPos : TEXCOORD7;
         // #endif

         // #if %VERTEXCOLORREQUIREKEY%
         // half4 vertexColor : COLOR;
         // #endif

         #if defined(LIGHTMAP_ON)
            float2 lightmapUV : TEXCOORD8;
         #endif
         #if defined(DYNAMICLIGHTMAP_ON)
            float2 dynamicLightmapUV : TEXCOORD9;
         #endif
         #if !defined(LIGHTMAP_ON)
            float3 sh : TEXCOORD10;
         #endif

         #if defined(VARYINGS_NEED_FOG_AND_VERTEX_LIGHT)
            float4 fogFactorAndVertexLight : TEXCOORD11;
         #endif

         #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
           float4 shadowCoord : TEXCOORD12;
         #endif

         // #if %EXTRAV2F0REQUIREKEY%
         // float4 extraV2F0 : TEXCOORD13;
         // #endif

         // #if %EXTRAV2F1REQUIREKEY%
         // float4 extraV2F1 : TEXCOORD14;
         // #endif

         // #if %EXTRAV2F2REQUIREKEY%
         // float4 extraV2F2 : TEXCOORD15;
         // #endif

         // #if %EXTRAV2F3REQUIREKEY%
         // float4 extraV2F3 : TEXCOORD16;
         // #endif

         // #if %EXTRAV2F4REQUIREKEY%
         // float4 extraV2F4 : TEXCOORD17;
         // #endif

         // #if %EXTRAV2F5REQUIREKEY%
         // float4 extraV2F5 : TEXCOORD18;
         // #endif

         // #if %EXTRAV2F6REQUIREKEY%
         // float4 extraV2F6 : TEXCOORD19;
         // #endif

         // #if %EXTRAV2F7REQUIREKEY%
         // float4 extraV2F7 : TEXCOORD20;
         // #endif

         #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
         #endif
         #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
         #endif
         #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
         #endif
         #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
         #endif
      };



            
            
            // data describing the user output of a pixel
            struct Surface
            {
               half3 Albedo;
               half Height;
               half3 Normal;
               half Smoothness;
               half3 Emission;
               half Metallic;
               half3 Specular;
               half Occlusion;
               half SpecularPower; // for simple lighting
               half Alpha;
               float outputDepth; // if written, SV_Depth semantic is used. ShaderData.clipPos.z is unused value
               // HDRP Only
               half SpecularOcclusion;
               half SubsurfaceMask;
               half Thickness;
               half CoatMask;
               half CoatSmoothness;
               half Anisotropy;
               half IridescenceMask;
               half IridescenceThickness;
               int DiffusionProfileHash;
               float SpecularAAThreshold;
               float SpecularAAScreenSpaceVariance;
               // requires _OVERRIDE_BAKEDGI to be defined, but is mapped in all pipelines
               float3 DiffuseGI;
               float3 BackDiffuseGI;
               float3 SpecularGI;
               // requires _OVERRIDE_SHADOWMASK to be defines
               float4 ShadowMask;
            };

            // Data the user declares in blackboard blocks
            struct Blackboard
            {
                
                float blackboardDummyData;
            };

            // data the user might need, this will grow to be big. But easy to strip
            struct ShaderData
            {
               float4 clipPos; // SV_POSITION
               float3 localSpacePosition;
               float3 localSpaceNormal;
               float3 localSpaceTangent;
        
               float3 worldSpacePosition;
               float3 worldSpaceNormal;
               float3 worldSpaceTangent;
               float tangentSign;

               float3 worldSpaceViewDir;
               float3 tangentSpaceViewDir;

               float4 texcoord0;
               float4 texcoord1;
               float4 texcoord2;
               float4 texcoord3;

               float2 screenUV;
               float4 screenPos;

               float4 vertexColor;
               bool isFrontFace;

               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;

               float3x3 TBNMatrix;
               Blackboard blackboard;
            };

            struct VertexData
            {
               #if SHADER_TARGET > 30
               // uint vertexID : SV_VertexID;
               #endif
               float4 vertex : POSITION;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;

               // optimize out mesh coords when not in use by user or lighting system
               #if _URP && (_USINGTEXCOORD1 || _PASSMETA || _PASSFORWARD || _PASSGBUFFER)
                  float4 texcoord1 : TEXCOORD1;
               #endif

               #if _URP && (_USINGTEXCOORD2 || _PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && defined(DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif

               #if _STANDARD && (_USINGTEXCOORD1 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER || _PASSFORWARDADD) && LIGHTMAP_ON)))
                  float4 texcoord1 : TEXCOORD1;
               #endif
               #if _STANDARD && (_USINGTEXCOORD2 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif


               #if _HDRP
                  float4 texcoord1 : TEXCOORD1;
                  float4 texcoord2 : TEXCOORD2;
               #endif

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD4; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity    : TEXCOORD5; // Add Precomputed Velocity (Alembic computes velocities on runtime side).
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct TessVertex 
            {
               float4 vertex : INTERNALTESSPOS;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;
               float4 texcoord1 : TEXCOORD1;
               float4 texcoord2 : TEXCOORD2;

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               // #if %EXTRAV2F0REQUIREKEY%
               // float4 extraV2F0 : TEXCOORD5;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // float4 extraV2F1 : TEXCOORD6;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // float4 extraV2F2 : TEXCOORD7;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // float4 extraV2F3 : TEXCOORD8;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // float4 extraV2F4 : TEXCOORD9;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // float4 extraV2F5 : TEXCOORD10;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // float4 extraV2F6 : TEXCOORD11;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // float4 extraV2F7 : TEXCOORD12;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD13; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity : TEXCOORD14;
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
               UNITY_VERTEX_OUTPUT_STEREO
            };

            struct ExtraV2F
            {
               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;
               Blackboard blackboard;
               float4 time;
            };


            float3 WorldToTangentSpace(ShaderData d, float3 normal)
            {
               return mul(d.TBNMatrix, normal);
            }

            float3 TangentToWorldSpace(ShaderData d, float3 normal)
            {
               return mul(normal, d.TBNMatrix);
            }

            // in this case, make standard more like SRPs, because we can't fix
            // unity_WorldToObject in HDRP, since it already does macro-fu there

            #if _STANDARD
               float3 TransformWorldToObject(float3 p) { return mul(unity_WorldToObject, float4(p, 1)); };
               float3 TransformObjectToWorld(float3 p) { return mul(unity_ObjectToWorld, float4(p, 1)); };
               float4 TransformWorldToObject(float4 p) { return mul(unity_WorldToObject, p); };
               float4 TransformObjectToWorld(float4 p) { return mul(unity_ObjectToWorld, p); };
               float4x4 GetWorldToObjectMatrix() { return unity_WorldToObject; }
               float4x4 GetObjectToWorldMatrix() { return unity_ObjectToWorld; }
               #if (defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (SHADER_TARGET_SURFACE_ANALYSIS && !SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod) tex.SampleLevel (sampler##tex,coord, lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) tex.SampleLevel (sampler##samplertex,coord, lod)
              #else
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex2D (tex,coord,0,lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) tex2D (tex,coord,0,lod)
              #endif

               #undef GetWorldToObjectMatrix()

               #define GetWorldToObjectMatrix()   unity_WorldToObject


            #endif

            float3 GetCameraWorldPosition()
            {
               #if _HDRP
                  return GetCameraRelativePositionWS(_WorldSpaceCameraPos);
               #else
                  return _WorldSpaceCameraPos;
               #endif
            }

            #if _GRABPASSUSED
               #if _STANDARD
                  TEXTURE2D(%GRABTEXTURE%);
                  SAMPLER(sampler_%GRABTEXTURE%);
               #endif

               half3 GetSceneColor(float2 uv)
               {
                  #if _STANDARD
                     return SAMPLE_TEXTURE2D(%GRABTEXTURE%, sampler_%GRABTEXTURE%, uv).rgb;
                  #else
                     return SHADERGRAPH_SAMPLE_SCENE_COLOR(uv);
                  #endif
               }
            #endif


      
            #if _STANDARD
               UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
               float GetSceneDepth(float2 uv) { return SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv)); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv)); } 
            #else
               float GetSceneDepth(float2 uv) { return SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv), _ZBufferParams); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv), _ZBufferParams); } 
            #endif

            float3 GetWorldPositionFromDepthBuffer(float2 uv, float3 worldSpaceViewDir)
            {
               float eye = GetLinearEyeDepth(uv);
               float3 camView = mul((float3x3)GetObjectToWorldMatrix(), transpose(mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V)) [2].xyz);

               float dt = dot(worldSpaceViewDir, camView);
               float3 div = worldSpaceViewDir/dt;
               float3 wpos = (eye * div) + GetCameraWorldPosition();
               return wpos;
            }

            #if _HDRP
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return GetAbsolutePositionWS(TransformObjectToWorld(pos));
            }
            #else
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return TransformObjectToWorld(pos);
            }
            #endif

            #if _STANDARD
               UNITY_DECLARE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture);
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  float4 depthNorms = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture, uv);
                  float3 norms = DecodeViewNormalStereo(depthNorms);
                  norms = mul((float3x3)GetWorldToViewMatrix(), norms) * 0.5 + 0.5;
                  return norms;
               }
            #elif _HDRP
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  NormalData nd;
                  DecodeFromNormalBuffer(_ScreenSize.xy * uv, nd);
                  return nd.normalWS;
               }
            #elif _URP
               #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                  #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
               #endif

               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                     return SampleSceneNormals(uv);
                  #else
                     float3 wpos = GetWorldPositionFromDepthBuffer(uv, worldSpaceViewDir);
                     return normalize(-cross(ddx(wpos), ddy(wpos))) * 0.5 + 0.5;
                  #endif

                }
             #endif

             #if _HDRP

               half3 UnpackNormalmapRGorAG(half4 packednormal)
               {
                     // This do the trick
                  packednormal.x *= packednormal.w;

                  half3 normal;
                  normal.xy = packednormal.xy * 2 - 1;
                  normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                  return normal;
               }
               half3 UnpackNormal(half4 packednormal)
               {
                  #if defined(UNITY_NO_DXT5nm)
                     return packednormal.xyz * 2 - 1;
                  #else
                     return UnpackNormalmapRGorAG(packednormal);
                  #endif
               }
               #endif
               #if _HDRP || _URP

               half3 UnpackScaleNormal(half4 packednormal, half scale)
               {
                 #ifndef UNITY_NO_DXT5nm
                   // Unpack normal as DXT5nm (1, y, 1, x) or BC5 (x, y, 0, 1)
                   // Note neutral texture like "bump" is (0, 0, 1, 1) to work with both plain RGB normal and DXT5nm/BC5
                   packednormal.x *= packednormal.w;
                 #endif
                   half3 normal;
                   normal.xy = (packednormal.xy * 2 - 1) * scale;
                   normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                   return normal;
               }	

             #endif


            void GetSun(out float3 lightDir, out float3 color)
            {
               lightDir = float3(0.5, 0.5, 0);
               color = 1;
               #if _HDRP
                  if (_DirectionalLightCount > 0)
                  {
                     DirectionalLightData light = _DirectionalLightDatas[0];
                     lightDir = -light.forward.xyz;
                     color = light.color;
                  }
               #elif _STANDARD
			         lightDir = normalize(_WorldSpaceLightPos0.xyz);
                  color = _LightColor0.rgb;
               #elif _URP
	               Light light = GetMainLight();
	               lightDir = light.direction;
	               color = light.color;
               #endif
            }


            
            CBUFFER_START(UnityPerMaterial)

               
	int _DiffuseLightingStyle;
	int _SpecularLightingStyle;
	int _CutoffEnabled;
	float _Cutoff;
	half4 _Color;
	float _AmbientShadowStrength;
	float _NormalMapStr;
	float4 _TilingOffset;
	int _DiffuseSteps;
	int _SpecularType;
	int _SpecularSteps;
	int _SpecularHatching;
	float2 _DiffuseEdge;
	int _DiffuseTextureMapping;
	int _ScreenStableDistanceScale;
	int _ScreenStableDistanceScaleSpec;
	float _DiffuseTextureSize;
	float _DiffuseRim;
	float2 _SpecularEdge;
	int _LinesOn;
	int _InvertShadowedLines;
	int _DiffuseHatching;
	float _DiffuseTextureContrast;
	float3 _HatchingRanges;
	float3 _HatchingRangesSpec;
	int _SpecularTextureMapping;
	float _SpecularTextureSize;
	int _KeepLinesThicc;
	float _SpecularTextureContrast;
	int _ReflectionsEnabled;
	float4 _ReflectionFresnelParams;
	float _BaseReflectStrength;
	float3 _EmissionColor;
	float _LightmapEmissionStr;
	float2 _PaintMaskEdges;



            CBUFFER_END

            

            

            #ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()


	// TODO:
	// Flip backface normals
	// Alpha cutoff support

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskMap);
	SAMPLER(sampler_MaskMap);

	TEXTURE2D(_BumpMap);
	SAMPLER(sampler_BumpMap);

	TEXTURE2D(_DiffuseTexture);
	TEXTURE2D(_SpecularTexture);

	TEXTURE2D(_EmissionTexture);
	SAMPLER(sampler_EmissionTexture);

	TEXTURE3D(_WobbleTexture);

	float invLerp(float from, float to, float value) {
		return (value - from) / (to - from);
	}

	float4 invLerp(float4 from, float4 to, float4 value) {
		return (value - from) / (to - from);
	}

	float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value){
		float rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	float4 remap(float4 origFrom, float4 origTo, float4 targetFrom, float4 targetTo, float4 value){
		float4 rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	SAMPLER(s_linear_repeat_sampler);

	void MainLight(out float3 direction, out float3 color, out float distanceAtten)
	{
		Light mainLight = GetMainLight();
		direction = mainLight.direction;
		color = mainLight.color;
		distanceAtten = mainLight.distanceAttenuation;
	}

	float ToonSharpen(float input, float edge = 0.1f)
	{
		float fw = fwidth(input)*0.5;
		return saturate(remap(edge - fw, edge + fw, 0, 1, input));
	}

	float3 Posterize(float3 input, int steps)
	{
		return round(input*steps)/steps;
	}

	float Posterize(float input, int steps)
	{
		return round(input*steps)/steps;

	}

	float Fresnel(float3 worldNormal, float3 viewAngle, float exp = 4)
	{
		return 1 - pow(abs(dot(worldNormal, viewAngle)),exp);
	}

	float MainLightShadows(float3 worldPos, float2 lightmapUV = float2(0.0,0.0))
	{
		float4 shadowCoord = TransformWorldToShadowCoord(worldPos);

		#if !defined (LIGHTMAP_ON) || defined(_LIGHTINGTYPE_VERTEX)
			half4 shadowMask = unity_ProbesOcclusion;
		#else
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half4 shadowMask = SAMPLE_SHADOWMASK(lightmapUV);
		#endif

		return ToonSharpen(MainLightShadow(shadowCoord, worldPos, shadowMask, _MainLightOcclusionProbes), 0.5f);
	}

	float3 GetAmbient(float3 worldNormal, float2 lightmapUV)
	{
		#ifdef LIGHTMAP_ON
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half3 bakedGI = SampleLightmap(lightmapUV, worldNormal);

			#if defined(_MIXED_LIGHTING_SUBTRACTIVE)
				Light mainLight = GetMainLight();
				bakedGI = SubtractDirectMainLightFromLightmap(mainLight, worldNormal, bakedGI);
			#endif

			return bakedGI;
		#else
			return SampleSH(worldNormal);
		#endif
	}

	float3 GetReflections(float3 worldNormal, float3 viewDir, float smoothness)
	{
		float perceptualRoughness = 1 - smoothness;
		perceptualRoughness *= perceptualRoughness;
		float mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
		float3 sample = SHADERGRAPH_REFLECTION_PROBE(viewDir, worldNormal, mip);
		return sample.rgb;
	}

	void SSAO(ShaderData d, out float directOcclusion, out float indirectOcclusion)
	{
		#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(ALPHABLEND)
			float2 uv = d.screenUV;

			AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(uv);
			directOcclusion = aoFactor.directAmbientOcclusion;
			indirectOcclusion = aoFactor.indirectAmbientOcclusion;
		#else
			directOcclusion = 1;
			indirectOcclusion = 1;
		#endif
	}

	half3 Triplanar(Texture2D tex, half3 samplePos, half3 normal, float size)
	{
		half2 uvX = samplePos.zy;
		half2 uvY = samplePos.xz + 0.67;
		half2 uvZ = samplePos.xy + 0.33;

		half3 lx = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvX / size).rgb;
		half3 ly = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvY / size).rgb;
		half3 lz = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvZ / size).rgb;

		float3 blend = pow(abs(normal),4);
		blend /= dot(blend, float3(1,1,1));

		return lx * blend.x + ly * blend.y + lz * blend.z;
	}

	half3 ViewDirLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float3 objPos = TransformObjectToWorld(0);
		float dist = distance(objPos, _WorldSpaceCameraPos);

		float3 samplePos = d.worldSpaceViewDir - _WorldSpaceCameraPos/dist;

		return Triplanar(tex, samplePos, d.worldSpaceViewDir, size);
	}

	half3 ScreenStableLightingTexture(ShaderData d, Texture2D tex, float size, int screenStableDistScale)
	{
		float3 objPos = TransformObjectToWorld(0);

		float dist = 3;

		if (screenStableDistScale)
			dist = distance(_WorldSpaceCameraPos, objPos);

		float4 clipPos = TransformObjectToHClip(TransformWorldToObject(d.worldSpacePosition));
		clipPos = ComputeScreenPos(clipPos);
		clipPos.xy /= clipPos.w;

		float4 objClipPos = TransformWorldToHClip(objPos);
		objClipPos = ComputeScreenPos(objClipPos);
		objClipPos.xy /= objClipPos.w;

		float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
		objClipPos.xy *= screenratio;
		clipPos.xy *= screenratio; 

		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, (clipPos.rg - objClipPos.rg) * size * dist).rgb;
	}

	half3 WorldSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, d.worldSpacePosition, d.worldSpaceNormal, size);
	}

	half3 ObjectSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, TransformWorldToObject(d.worldSpacePosition), TransformWorldToObject(d.worldSpaceNormal), size);
	}

	half3 ScreenSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float screenratio = _ScreenParams.x / _ScreenParams.y;
		float2 uv = d.screenUV;
		uv.x *= screenratio;
		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uv / size).rgb;
	}

	float TexturedDiffuse(float3 lightingTex, float inputDiffuse, float lightStr = 1, bool mainLight = false)
	{
		lightingTex = pow(abs(lightingTex), _DiffuseTextureContrast);
		float origDiffuse = inputDiffuse;
		if (mainLight)
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse));
		else
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse*lightStr));

		UNITY_BRANCH
		if (_DiffuseHatching == 0)
		{	
			origDiffuse = ToonSharpen(max(1 - lightingTex.r,0.025), 1 - origDiffuse);
		}
		else
		{
			lightingTex = max(1 - lightingTex,0.01);
			float3 hatchDiffuse = origDiffuse;
			hatchDiffuse.r = smoothstep(0, _HatchingRanges.r, origDiffuse);
			hatchDiffuse.g = smoothstep(0, _HatchingRanges.g, origDiffuse);
			hatchDiffuse.b = smoothstep(0, _HatchingRanges.b, origDiffuse);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchDiffuse.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchDiffuse.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchDiffuse.b);

			float combined = min(min(lightingTex.r, lightingTex.g),lightingTex.b);
			origDiffuse = ToonSharpen(combined, 1 - origDiffuse)*lightStr;
		}
		return origDiffuse;
	}

	float TexturedSpecular(float3 lightingTex, float inputSpec, float lightStr = 1)
	{
		
		lightingTex = pow(abs(lightingTex), _SpecularTextureContrast);
		//lightingTex -= 0.15;
		float origSpecular = smoothstep(_SpecularEdge.x, _SpecularEdge.y, saturate(inputSpec*lightStr*0.5));

		UNITY_BRANCH
		if (_SpecularHatching == 0)
		{	
			origSpecular = 1 - smoothstep(0, origSpecular, ToonSharpen(1 - lightingTex.r, origSpecular));
		}
		else
		{
			lightingTex = 1 - lightingTex;
			float3 hatchSpec = origSpecular;
			hatchSpec.r = smoothstep(1 - _HatchingRangesSpec.r, 1, origSpecular);
			hatchSpec.g = smoothstep(1 - _HatchingRangesSpec.g, 1, origSpecular);
			hatchSpec.b = smoothstep(1 - _HatchingRangesSpec.b, 1, origSpecular);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchSpec.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchSpec.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchSpec.b);

			float combined = max(max(lightingTex.r, lightingTex.g),lightingTex.b);
			origSpecular = smoothstep(0, origSpecular, combined);
		}
		return origSpecular;
	}

	float GetDiffuse(float3 lightingTex, Light l, ShaderData d, Surface o, bool mainLight = false, float lineArt = 1)
	{
		float diffuse = saturate(dot(l.direction, d.worldSpaceNormal));
		
		#if defined(_DIFFUSELIGHTINGSTYLE_STEPPED)
			diffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, diffuse);
			diffuse *= length(l.color);
			diffuse *= l.shadowAttenuation * saturate(l.distanceAttenuation);
			if (_DiffuseSteps > 1)
			{
				
				float origDiffuse = diffuse;
				float powLerpFactor = saturate(invLerp(1, 12, _DiffuseSteps));
				float powFactor = lerp(0.5, 1, powLerpFactor);

				diffuse = Posterize(pow(abs(diffuse), powFactor), _DiffuseSteps);

			}
			else
				diffuse = ToonSharpen(diffuse,0.075);

			diffuse /= length(l.color);
		#elif defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			diffuse *= l.shadowAttenuation * l.distanceAttenuation;
			diffuse = TexturedDiffuse(lightingTex, diffuse, length(l.color), mainLight);
		#endif

		UNITY_BRANCH
		if (_DiffuseRim*lineArt*l.shadowAttenuation*l.distanceAttenuation > 0)
		{
			float rim = Fresnel(d.worldSpaceNormal, d.worldSpaceViewDir);
			float mainLightAlignment = saturate(-dot(d.worldSpaceViewDir, l.direction));
			
			float rimSize = lerp(1.0, 0.9, _DiffuseRim*l.distanceAttenuation*l.distanceAttenuation);

			rim = ToonSharpen(rim,lerp(1.01, rimSize, mainLightAlignment)) * ToonSharpen(mainLightAlignment);
			diffuse = max(diffuse, rim);
		}

		return diffuse;
	}
	
	float GetSpecular(float3 lightingTex, Light l, ShaderData d, Surface o)
	{
		float baseSpec = 0;
		float SpecSmoothness = exp2(10 * o.Smoothness + 1).x;

		[branch]
		if (_SpecularType == 0) //Cook-Torrance
		{
			float roughness = 1 - o.Smoothness;
			roughness *= roughness;

			float3 h = SafeNormalize(l.direction + d.worldSpaceViewDir);
			float nh = saturate(dot(d.worldSpaceNormal, h));
			float lh = saturate(dot(l.direction, h));
			float d = nh * nh * (roughness * roughness - 1.0) + 1.00001;
			float normTerm = roughness * 4.0 + 2.0;
			float specTerm = roughness * roughness;
			specTerm /= (d * d) * max(0.1, lh * lh) * normTerm;
			baseSpec = specTerm*0.04;
		}
		else if (_SpecularType == 1) //Phong
		{
			float3 r = reflect(-l.direction, d.worldSpaceNormal);
			float rdotv = max(0, dot(r, d.worldSpaceViewDir));

			baseSpec = pow(rdotv, SpecSmoothness)*o.Smoothness;
		}
		else if (_SpecularType == 2) //Blinn-Phong
		{
			float3 h = SafeNormalize(l.direction+d.worldSpaceViewDir);
			float ndh = saturate(dot(d.worldSpaceNormal, h));

			baseSpec = pow(ndh, SpecSmoothness)*o.Smoothness;
		}
		else
		{
			return 0;
		}

		

		#if defined(_SPECULARLIGHTINGSTYLE_BASIC)
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation * length(l.color);
			baseSpec = smoothstep(_SpecularEdge.x,_SpecularEdge.y, baseSpec);
			baseSpec /= length(l.color);
		#elif defined(_SPECULARLIGHTINGSTYLE_STEPPED)
			baseSpec *= saturate(l.distanceAttenuation) * l.shadowAttenuation;
			baseSpec *= length(l.color);
			baseSpec = Posterize(baseSpec, max(1,_SpecularSteps));
			baseSpec /= length(l.color);
		#else
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation;
			baseSpec = TexturedSpecular(lightingTex, baseSpec, length(l.color));
		#endif	

		
		return baseSpec;
	}

	void Ext_ModifyVertex0 (inout VertexData v, inout ExtraV2F d)
	{
		v.texcoord0.xy = v.texcoord0.xy * _TilingOffset.xy + _TilingOffset.zw;

		if (_DiffuseTextureMapping == 2)
		{
			float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
			clipPos.xy /= clipPos.w;  

			float3 objPos = TransformObjectToWorld(0);
			float camDist = distance(objPos, _WorldSpaceCameraPos);
			float4 objClipPos = TransformWorldToHClip(objPos);
			objClipPos.xy /= objClipPos.w;

			float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
			objClipPos.xy *= screenratio;
			clipPos.xy *= screenratio;

			v.texcoord3 = (clipPos - objClipPos); 
		}
	}

	void Ext_SurfaceFunction0 (inout Surface o, ShaderData d)
	{
		
		// Handle input data
		float4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, d.texcoord0.xy);
		float4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, d.texcoord0.xy);
		o.Normal = UnpackScaleNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, d.texcoord0.xy), _NormalMapStr);
		d.worldSpaceNormal = TransformTangentToWorld(o.Normal, d.TBNMatrix);

		float diffuseColorMult = 1.0f;
		float specColorMult = 1.0f;

		if (_DiffuseLightingStyle == 1)
			diffuseColorMult = 0.5f;

		if (_SpecularLightingStyle = 2)
			specColorMult = 0.5f;

		if (!d.isFrontFace)
		{
			d.worldSpaceNormal *= -1;
		}

		o.Metallic = masks.r;
		o.Smoothness = masks.g;
		o.Alpha = baseColor.a * _Color.a;

		if (_CutoffEnabled)
			clip(o.Alpha - _Cutoff);

		o.Occlusion = 1;
		float3 specColor = 1;
		float paintmask = masks.b;

		float3 paintedColor = baseColor.rgb * _Color.rgb;
		baseColor.rgb = lerp(baseColor.rgb, paintedColor, smoothstep(_PaintMaskEdges.x, _PaintMaskEdges.y, paintmask));

		#if defined(_EMISSION)
			o.Emission = SAMPLE_TEXTURE2D(_EmissionTexture, sampler_EmissionTexture, d.texcoord0).rgb * _EmissionColor;
		#endif

		half lines = 1;
		half origlines = 1;
		float lineCutoff = 0.5;

		#if defined(LIGHTMAP_ON)
			half4 shadowMask = SAMPLE_SHADOWMASK(d.texcoord1.xy);
		#else
			half4 shadowMask = unity_ProbesOcclusion;
		#endif

		// -------------
		// LINE ART
		// -------------
		UNITY_BRANCH
		if (_LinesOn)
		{
			UNITY_BRANCH
			if (_KeepLinesThicc)
			{
				float dist = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
				float fresnel = pow(abs(dot(d.worldSpaceNormal, d.worldSpaceViewDir)),3);
				lineCutoff = lerp(0.5, 0.95, max(saturate(dist*0.2), fresnel));
			}
			lines = 1 - masks.a;

			 // Save original lines to use if ambient is raised
		}

		#ifdef _DBUFFER
			ApplyDecal(d.clipPos, baseColor.rgb, specColor, d.worldSpaceNormal, o.Metallic, lines, o.Smoothness);
		#endif

		if (_LinesOn)
		{
			lines = ToonSharpen(lines, lineCutoff);
			origlines = lines;
		}
		else
		{
			lines = 1;
		}

		// Store lighting values in these
		float3 mainLightDir;
		float3 mainLightCol;
		float mainLightAtten;
		MainLight(mainLightDir, mainLightCol, mainLightAtten);

		float2 lightmapUV = d.texcoord1.xy;

		float mainShadows = MainLightShadows(d.worldSpacePosition, lightmapUV);
		float3 ambient = GetAmbient(d.worldSpaceNormal, lightmapUV) * baseColor.rgb;

		Light mainLight = GetMainLight();

		#if   defined(_DIFFUSETEXTUREMAPPING_SCREENSPACE)
			float3 diffuseLightingTex = ScreenSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_VIEWDIRECTION)
			float3 diffuseLightingTex = ViewDirLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_SCREENSTABLE)
			float3 diffuseLightingTex = ScreenStableLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize, _ScreenStableDistanceScale);
		#elif defined(_DIFFUSETEXTUREMAPPING_WORLDSPACE)
			float3 diffuseLightingTex = WorldSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_OBJECTSPACE)
			float3 diffuseLightingTex = ObjectSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#endif

		#if   defined(_SPECULARTEXTUREMAPPING_SCREENSPACE)
			float3 specLightingTex = ScreenSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_VIEWDIRECTION)
			float3 specLightingTex = ViewDirLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_SCREENSTABLE)
			float3 specLightingTex = ScreenStableLightingTexture(d, _SpecularTexture, _SpecularTextureSize, _ScreenStableDistanceScale);
		#elif defined(_SPECULARTEXTUREMAPPING_WORLDSPACE)
			float3 specLightingTex = WorldSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_OBJECTSPACE)
			float3 specLightingTex = ObjectSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#endif
		

		float indirOcclusion, directOcclusion;
		SSAO(d, directOcclusion, indirOcclusion);

		#if defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			directOcclusion = TexturedDiffuse(diffuseLightingTex, directOcclusion);
			//indirOcclusion = TexturedDiffuse(diffuseLightingTex, indirOcclusion);
			ambient = min(indirOcclusion, ambient);
		#endif

		float mainDiffuseFactor = GetDiffuse(diffuseLightingTex, mainLight, d, o, true, lines)*directOcclusion*diffuseColorMult;
		mainDiffuseFactor *= mainShadows;
		float mainSpecFactor = GetSpecular(specLightingTex, mainLight, d, o) * specColorMult;
		
		float3 addLightDiffuse = 0;
		float3 addLightSpecular = 0;
		// -------------
		// ADDITIONALLIGHTS
		// -------------
		int pixelLights = GetAdditionalLightsCount();
		for (int i = 0; i < pixelLights; ++i)
		{
			Light light = GetAdditionalLight(i, d.worldSpacePosition, shadowMask);

			float diffuse = GetDiffuse(diffuseLightingTex, light, d, o, false, lines) * diffuseColorMult;
			float specular = GetSpecular(specLightingTex, light, d, o) * specColorMult;

			addLightDiffuse += diffuse * light.color;
			addLightSpecular += specular * light.color;
		}
		
		float diffuseDarkest = ToonSharpen(length(addLightDiffuse)+saturate(mainDiffuseFactor*length(mainLight.color)),0.025);

		// -------------
		// REFLECTIONS
		// -------------
		float3 reflections = 0;
		
		#if defined(_REFLECTIONSENABLED_ON)
			float reflectStr = 0.04*_BaseReflectStrength*2;;
			reflections = GetReflections(d.worldSpaceNormal, d.worldSpaceViewDir, o.Smoothness);
			float perceptualRoughness = (1 - o.Smoothness);
			perceptualRoughness *= perceptualRoughness;		

			float fresnel = pow(1.0 - saturate(dot(d.worldSpaceNormal, d.worldSpaceViewDir)-_ReflectionFresnelParams.y), _ReflectionFresnelParams.x*16);
			fresnel = smoothstep(_ReflectionFresnelParams.w*0.5, 1 - _ReflectionFresnelParams.w*0.5, fresnel);
			reflectStr = lerp(reflectStr, clamp(0, 2, 0.04*_ReflectionFresnelParams.z*50), fresnel);

			reflections *= reflectStr;
			reflections /= perceptualRoughness + 0.5;

			reflections = lerp(reflections, reflections * baseColor.rgb, o.Metallic);
		#endif
		
		#if defined(ALPHABLEND) && !defined(_PASSMETA)

			if (_OpaqueLines)
				o.Alpha = max(o.Alpha, 1 - lines);

			UNITY_BRANCH
			if (_PreserveSpec)
			{
				o.Alpha = max(Luminance(reflections), o.Alpha);
				o.Alpha = max(mainSpecFactor, o.Alpha);
				o.Alpha = max(addLightSpecular, o.Alpha);
			}

			float3 refractionCol = 0;
			float origAlpha = o.Alpha;
			UNITY_BRANCH
			if (_Refraction)
			{
				float4 offsetPos = float4(d.worldSpacePosition + d.worldSpaceNormal * _RefractionStr, 1.0);
				offsetPos = mul(GetWorldToHClipMatrix(), offsetPos);
				float scale = 1.0;

				#if UNITY_UV_STARTS_AT_TOP
					scale = -1.0;
				#endif

				float4 grabPos = offsetPos *0.5f;
				grabPos.xy = float2(grabPos.x, grabPos.y*scale) + grabPos.w;
				grabPos.zw = offsetPos.zw;
				grabPos.xy /= grabPos.w;
				grabPos.xy = saturate(grabPos.xy);

				float3 refraction = GetSceneColor(grabPos.xy);
				refractionCol = refraction;
				if (_RefractionTint)
					refraction *= baseColor.rgb;

				_RefractionEdge = 1 - _RefractionEdge;
				if (_RefractionEdge > 0)
				{
					float2 cubemapBlendFactors = pow(abs((grabPos.xy - 0.5) * 2.0),0.25);
					float blend = smoothstep(_RefractionEdge, 1, max(cubemapBlendFactors.x, cubemapBlendFactors.y));
					float3 refractDir = refract(-d.worldSpaceViewDir, d.worldSpaceNormal, 1 - _RefractionStr);
					float3 reflectProbe = GetReflections(-refractDir, refractDir, 1.0);
					
					refractionCol = lerp(refraction, reflectProbe, blend);
				}
				
				o.Alpha = 1;
			}

		#endif		

		float3 mainSpec = mainSpecFactor * mainLightCol;
		float3 mainDiffuse = mainDiffuseFactor * mainLightCol;

		addLightSpecular = lerp(addLightSpecular, addLightSpecular * baseColor.rgb, o.Metallic);
		mainSpec = lerp(mainSpec, mainSpec * specColor, o.Metallic);

		lines = lerp(1 - lines, lines, diffuseDarkest);
		
		if (_InvertShadowedLines)
			diffuseDarkest = lerp(diffuseDarkest, 1, lines);

		o.Albedo = baseColor.rgb;
		o.Emission *= _LightmapEmissionStr;
		#if !defined(_PASSMETA)
			o.Albedo *= mainDiffuse * lines;
			o.Albedo += reflections* mainDiffuse *lines;
			o.Albedo += addLightDiffuse * lines * baseColor.rgb + addLightSpecular * lines;
			o.Albedo += mainSpec * mainDiffuse * mainShadows * lines;
			
			o.Albedo += lerp(ambient*diffuseDarkest * lines, ambient*origlines, _AmbientShadowStrength);
			#if defined(ALPHABLEND)
				if (_Refraction)
				{
					o.Albedo = lerp(refractionCol, o.Albedo, origAlpha);
				}
			#endif
			o.Albedo += o.Emission;
		#endif
	}




        
            void ChainSurfaceFunction(inout Surface l, inout ShaderData d)
            {
                  Ext_SurfaceFunction0(l, d);
                 // Ext_SurfaceFunction1(l, d);
                 // Ext_SurfaceFunction2(l, d);
                 // Ext_SurfaceFunction3(l, d);
                 // Ext_SurfaceFunction4(l, d);
                 // Ext_SurfaceFunction5(l, d);
                 // Ext_SurfaceFunction6(l, d);
                 // Ext_SurfaceFunction7(l, d);
                 // Ext_SurfaceFunction8(l, d);
                 // Ext_SurfaceFunction9(l, d);
		           // Ext_SurfaceFunction10(l, d);
                 // Ext_SurfaceFunction11(l, d);
                 // Ext_SurfaceFunction12(l, d);
                 // Ext_SurfaceFunction13(l, d);
                 // Ext_SurfaceFunction14(l, d);
                 // Ext_SurfaceFunction15(l, d);
                 // Ext_SurfaceFunction16(l, d);
                 // Ext_SurfaceFunction17(l, d);
                 // Ext_SurfaceFunction18(l, d);
		           // Ext_SurfaceFunction19(l, d);
                 // Ext_SurfaceFunction20(l, d);
                 // Ext_SurfaceFunction21(l, d);
                 // Ext_SurfaceFunction22(l, d);
                 // Ext_SurfaceFunction23(l, d);
                 // Ext_SurfaceFunction24(l, d);
                 // Ext_SurfaceFunction25(l, d);
                 // Ext_SurfaceFunction26(l, d);
                 // Ext_SurfaceFunction27(l, d);
                 // Ext_SurfaceFunction28(l, d);
		           // Ext_SurfaceFunction29(l, d);
            }

            void ChainModifyVertex(inout VertexData v, inout VertexToPixel v2p, float4 time)
            {
                 ExtraV2F d;
                 
                 ZERO_INITIALIZE(ExtraV2F, d);
                 ZERO_INITIALIZE(Blackboard, d.blackboard);
                 // due to motion vectors in HDRP, we need to use the last
                 // time in certain spots. So if you are going to use _Time to adjust vertices,
                 // you need to use this time or motion vectors will break. 
                 d.time = time;

                   Ext_ModifyVertex0(v, d);
                 // Ext_ModifyVertex1(v, d);
                 // Ext_ModifyVertex2(v, d);
                 // Ext_ModifyVertex3(v, d);
                 // Ext_ModifyVertex4(v, d);
                 // Ext_ModifyVertex5(v, d);
                 // Ext_ModifyVertex6(v, d);
                 // Ext_ModifyVertex7(v, d);
                 // Ext_ModifyVertex8(v, d);
                 // Ext_ModifyVertex9(v, d);
                 // Ext_ModifyVertex10(v, d);
                 // Ext_ModifyVertex11(v, d);
                 // Ext_ModifyVertex12(v, d);
                 // Ext_ModifyVertex13(v, d);
                 // Ext_ModifyVertex14(v, d);
                 // Ext_ModifyVertex15(v, d);
                 // Ext_ModifyVertex16(v, d);
                 // Ext_ModifyVertex17(v, d);
                 // Ext_ModifyVertex18(v, d);
                 // Ext_ModifyVertex19(v, d);
                 // Ext_ModifyVertex20(v, d);
                 // Ext_ModifyVertex21(v, d);
                 // Ext_ModifyVertex22(v, d);
                 // Ext_ModifyVertex23(v, d);
                 // Ext_ModifyVertex24(v, d);
                 // Ext_ModifyVertex25(v, d);
                 // Ext_ModifyVertex26(v, d);
                 // Ext_ModifyVertex27(v, d);
                 // Ext_ModifyVertex28(v, d);
                 // Ext_ModifyVertex29(v, d);


                 // #if %EXTRAV2F0REQUIREKEY%
                 // v2p.extraV2F0 = d.extraV2F0;
                 // #endif

                 // #if %EXTRAV2F1REQUIREKEY%
                 // v2p.extraV2F1 = d.extraV2F1;
                 // #endif

                 // #if %EXTRAV2F2REQUIREKEY%
                 // v2p.extraV2F2 = d.extraV2F2;
                 // #endif

                 // #if %EXTRAV2F3REQUIREKEY%
                 // v2p.extraV2F3 = d.extraV2F3;
                 // #endif

                 // #if %EXTRAV2F4REQUIREKEY%
                 // v2p.extraV2F4 = d.extraV2F4;
                 // #endif

                 // #if %EXTRAV2F5REQUIREKEY%
                 // v2p.extraV2F5 = d.extraV2F5;
                 // #endif

                 // #if %EXTRAV2F6REQUIREKEY%
                 // v2p.extraV2F6 = d.extraV2F6;
                 // #endif

                 // #if %EXTRAV2F7REQUIREKEY%
                 // v2p.extraV2F7 = d.extraV2F7;
                 // #endif
            }

            void ChainModifyTessellatedVertex(inout VertexData v, inout VertexToPixel v2p)
            {
               ExtraV2F d;
               ZERO_INITIALIZE(ExtraV2F, d);
               ZERO_INITIALIZE(Blackboard, d.blackboard);

               // #if %EXTRAV2F0REQUIREKEY%
               // d.extraV2F0 = v2p.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // d.extraV2F1 = v2p.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // d.extraV2F2 = v2p.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // d.extraV2F3 = v2p.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // d.extraV2F4 = v2p.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // d.extraV2F5 = v2p.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // d.extraV2F6 = v2p.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // d.extraV2F7 = v2p.extraV2F7;
               // #endif


               // Ext_ModifyTessellatedVertex0(v, d);
               // Ext_ModifyTessellatedVertex1(v, d);
               // Ext_ModifyTessellatedVertex2(v, d);
               // Ext_ModifyTessellatedVertex3(v, d);
               // Ext_ModifyTessellatedVertex4(v, d);
               // Ext_ModifyTessellatedVertex5(v, d);
               // Ext_ModifyTessellatedVertex6(v, d);
               // Ext_ModifyTessellatedVertex7(v, d);
               // Ext_ModifyTessellatedVertex8(v, d);
               // Ext_ModifyTessellatedVertex9(v, d);
               // Ext_ModifyTessellatedVertex10(v, d);
               // Ext_ModifyTessellatedVertex11(v, d);
               // Ext_ModifyTessellatedVertex12(v, d);
               // Ext_ModifyTessellatedVertex13(v, d);
               // Ext_ModifyTessellatedVertex14(v, d);
               // Ext_ModifyTessellatedVertex15(v, d);
               // Ext_ModifyTessellatedVertex16(v, d);
               // Ext_ModifyTessellatedVertex17(v, d);
               // Ext_ModifyTessellatedVertex18(v, d);
               // Ext_ModifyTessellatedVertex19(v, d);
               // Ext_ModifyTessellatedVertex20(v, d);
               // Ext_ModifyTessellatedVertex21(v, d);
               // Ext_ModifyTessellatedVertex22(v, d);
               // Ext_ModifyTessellatedVertex23(v, d);
               // Ext_ModifyTessellatedVertex24(v, d);
               // Ext_ModifyTessellatedVertex25(v, d);
               // Ext_ModifyTessellatedVertex26(v, d);
               // Ext_ModifyTessellatedVertex27(v, d);
               // Ext_ModifyTessellatedVertex28(v, d);
               // Ext_ModifyTessellatedVertex29(v, d);

               // #if %EXTRAV2F0REQUIREKEY%
               // v2p.extraV2F0 = d.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // v2p.extraV2F1 = d.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // v2p.extraV2F2 = d.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // v2p.extraV2F3 = d.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // v2p.extraV2F4 = d.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // v2p.extraV2F5 = d.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // v2p.extraV2F6 = d.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // v2p.extraV2F7 = d.extraV2F7;
               // #endif
            }

            void ChainFinalColorForward(inout Surface l, inout ShaderData d, inout half4 color)
            {
               //   Ext_FinalColorForward0(l, d, color);
               //   Ext_FinalColorForward1(l, d, color);
               //   Ext_FinalColorForward2(l, d, color);
               //   Ext_FinalColorForward3(l, d, color);
               //   Ext_FinalColorForward4(l, d, color);
               //   Ext_FinalColorForward5(l, d, color);
               //   Ext_FinalColorForward6(l, d, color);
               //   Ext_FinalColorForward7(l, d, color);
               //   Ext_FinalColorForward8(l, d, color);
               //   Ext_FinalColorForward9(l, d, color);
               //  Ext_FinalColorForward10(l, d, color);
               //  Ext_FinalColorForward11(l, d, color);
               //  Ext_FinalColorForward12(l, d, color);
               //  Ext_FinalColorForward13(l, d, color);
               //  Ext_FinalColorForward14(l, d, color);
               //  Ext_FinalColorForward15(l, d, color);
               //  Ext_FinalColorForward16(l, d, color);
               //  Ext_FinalColorForward17(l, d, color);
               //  Ext_FinalColorForward18(l, d, color);
               //  Ext_FinalColorForward19(l, d, color);
               //  Ext_FinalColorForward20(l, d, color);
               //  Ext_FinalColorForward21(l, d, color);
               //  Ext_FinalColorForward22(l, d, color);
               //  Ext_FinalColorForward23(l, d, color);
               //  Ext_FinalColorForward24(l, d, color);
               //  Ext_FinalColorForward25(l, d, color);
               //  Ext_FinalColorForward26(l, d, color);
               //  Ext_FinalColorForward27(l, d, color);
               //  Ext_FinalColorForward28(l, d, color);
               //  Ext_FinalColorForward29(l, d, color);
            }

            void ChainFinalGBufferStandard(inout Surface s, inout ShaderData d, inout half4 GBuffer0, inout half4 GBuffer1, inout half4 GBuffer2, inout half4 outEmission, inout half4 outShadowMask)
            {
               //   Ext_FinalGBufferStandard0(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard1(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard2(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard3(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard4(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard5(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard6(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard7(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard8(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard9(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard10(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard11(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard12(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard13(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard14(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard15(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard16(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard17(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard18(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard19(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard20(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard21(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard22(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard23(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard24(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard25(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard26(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard27(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard28(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard29(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
            }



            

         ShaderData CreateShaderData(VertexToPixel i
                  #if NEED_FACING
                     , bool facing
                  #endif
         )
         {
            ShaderData d = (ShaderData)0;
            d.clipPos = i.pos;
            d.worldSpacePosition = i.worldPos;

            d.worldSpaceNormal = normalize(i.worldNormal);
            d.worldSpaceTangent = normalize(i.worldTangent.xyz);
            d.tangentSign = i.worldTangent.w;
            float3 bitangent = cross(i.worldTangent.xyz, i.worldNormal) * d.tangentSign * -1;
            

            d.TBNMatrix = float3x3(d.worldSpaceTangent, bitangent, d.worldSpaceNormal);
            d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

            d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
             d.texcoord0 = i.texcoord0;
             d.texcoord1 = i.texcoord1;
            // d.texcoord2 = i.texcoord2;

            // #if %TEXCOORD3REQUIREKEY%
             d.texcoord3 = i.texcoord3;
            // #endif

             d.isFrontFace = facing;
            // #if %VERTEXCOLORREQUIREKEY%
            // d.vertexColor = i.vertexColor;
            // #endif

            // these rarely get used, so we back transform them. Usually will be stripped.
            #if _HDRP
                // d.localSpacePosition = mul(unity_WorldToObject, float4(GetCameraRelativePositionWS(i.worldPos), 1)).xyz;
            #else
                // d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
            #endif
            // d.localSpaceNormal = normalize(mul((float3x3)unity_WorldToObject, i.worldNormal));
            // d.localSpaceTangent = normalize(mul((float3x3)unity_WorldToObject, i.worldTangent.xyz));

            // #if %SCREENPOSREQUIREKEY%
             d.screenPos = i.screenPos;
             d.screenUV = (i.screenPos.xy / i.screenPos.w);
            // #endif


            // #if %EXTRAV2F0REQUIREKEY%
            // d.extraV2F0 = i.extraV2F0;
            // #endif

            // #if %EXTRAV2F1REQUIREKEY%
            // d.extraV2F1 = i.extraV2F1;
            // #endif

            // #if %EXTRAV2F2REQUIREKEY%
            // d.extraV2F2 = i.extraV2F2;
            // #endif

            // #if %EXTRAV2F3REQUIREKEY%
            // d.extraV2F3 = i.extraV2F3;
            // #endif

            // #if %EXTRAV2F4REQUIREKEY%
            // d.extraV2F4 = i.extraV2F4;
            // #endif

            // #if %EXTRAV2F5REQUIREKEY%
            // d.extraV2F5 = i.extraV2F5;
            // #endif

            // #if %EXTRAV2F6REQUIREKEY%
            // d.extraV2F6 = i.extraV2F6;
            // #endif

            // #if %EXTRAV2F7REQUIREKEY%
            // d.extraV2F7 = i.extraV2F7;
            // #endif

            return d;
         }
         

            
         #if defined(_PASSSHADOW)
            float3 _LightDirection;
            float3 _LightPosition;
         #endif

         // vertex shader
         VertexToPixel Vert (VertexData v)
         {
           
           VertexToPixel o = (VertexToPixel)0;

           UNITY_SETUP_INSTANCE_ID(v);
           UNITY_TRANSFER_INSTANCE_ID(v, o);
           UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


#if !_TESSELLATION_ON
           ChainModifyVertex(v, o, _Time);
#endif

            o.texcoord0 = v.texcoord0;
            o.texcoord1 = v.texcoord1;
           // o.texcoord2 = v.texcoord2;

           // #if %TEXCOORD3REQUIREKEY%
            o.texcoord3 = v.texcoord3;
           // #endif

           // #if %VERTEXCOLORREQUIREKEY%
           // o.vertexColor = v.vertexColor;
           // #endif
           
           VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
           o.worldPos = TransformObjectToWorld(v.vertex.xyz);
           o.worldNormal = TransformObjectToWorldNormal(v.normal);
           o.worldTangent = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);

          // For some very odd reason, in 2021.2, we can't use Unity's defines, but have to use our own..
          #if _PASSSHADOW
              #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                 float3 lightDirectionWS = normalize(_LightPosition - o.worldPos);
              #else
                 float3 lightDirectionWS = _LightDirection;
              #endif
              // Define shadow pass specific clip position for Universal
              o.pos = TransformWorldToHClip(ApplyShadowBias(o.worldPos, o.worldNormal, lightDirectionWS));
              #if UNITY_REVERSED_Z
                  o.pos.z = min(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #else
                  o.pos.z = max(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #endif
          #elif _PASSMETA
              o.pos = MetaVertexPosition(float4(v.vertex.xyz, 0), v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
          #else
              o.pos = TransformWorldToHClip(o.worldPos);
          #endif

          // #if %SCREENPOSREQUIREKEY%
           o.screenPos = ComputeScreenPos(o.pos, _ProjectionParams.x);
          // #endif

          #if _PASSFORWARD || _PASSGBUFFER
              float2 uv1 = v.texcoord1.xy;
              OUTPUT_LIGHTMAP_UV(uv1, unity_LightmapST, o.lightmapUV);
               o.texcoord1.xy = uv1;
              OUTPUT_SH(o.worldNormal, o.sh);
              #if defined(DYNAMICLIGHTMAP_ON)
                   o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              #endif
          #endif

          #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
              half fogFactor = 0;
              #if defined(_FOG_FRAGMENT)
                fogFactor = ComputeFogFactor(o.pos.z);
              #endif
              #if _BAKEDLIT
                 o.fogFactorAndVertexLight = half4(fogFactor, 0, 0, 0);
              #else
                 half3 vertexLight = VertexLighting(o.worldPos, o.worldNormal);
                 o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
              #endif
          #endif

          #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             o.shadowCoord = GetShadowCoord(vertexInput);
          #endif

           return o;
         }


            

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

            // fragment shader
            FragmentOutput Frag (VertexToPixel IN
            #ifdef _DEPTHOFFSET_ON
              , out float outputDepth : SV_Depth
            #endif
            #if NEED_FACING
               , bool facing : SV_IsFrontFace
            #endif
            ) 
            {
               UNITY_SETUP_INSTANCE_ID(IN);
               UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

               ShaderData d = CreateShaderData(IN
                  #if NEED_FACING
                     , facing
                  #endif
               );
               Surface l = (Surface)0;

               #ifdef _DEPTHOFFSET_ON
                  l.outputDepth = outputDepth;
               #endif

               l.Albedo = half3(0.5, 0.5, 0.5);
               l.Normal = float3(0,0,1);
               l.Occlusion = 1;
               l.Alpha = 1;

               ChainSurfaceFunction(l, d);

               #ifdef _DEPTHOFFSET_ON
                  outputDepth = l.outputDepth;
               #endif

               #if _USESPECULAR || _SIMPLELIT
                  float3 specular = l.Specular;
                  float metallic = 0;
               #else   
                  float3 specular = 0;
                  float metallic = l.Metallic;
               #endif

               InputData inputData = (InputData)0;

               inputData.positionWS = IN.worldPos;
               #if _WORLDSPACENORMAL
                  inputData.normalWS = l.Normal;
               #else
                  inputData.normalWS = normalize(TangentToWorldSpace(d, l.Normal));
               #endif

               inputData.viewDirectionWS = SafeNormalize(d.worldSpaceViewDir);


               #if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                   inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
               #else
                   inputData.shadowCoord = float4(0, 0, 0, 0);
               #endif

               //inputData.fogCoord = IN.fogFactorAndVertexLight.x;
               InitializeInputDataFog(float4(IN.worldPos, 1.0), IN.fogFactorAndVertexLight.x);
               inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;


               #if defined(_OVERRIDE_BAKEDGI)
                  inputData.bakedGI = l.DiffuseGI;
                  l.Emission += l.SpecularGI;
               #else
                  #if defined(DYNAMICLIGHTMAP_ON)
                   inputData.bakedGI = SAMPLE_GI(IN.lightmapUV, IN.dynamicLightmapUV.xy, IN.sh, inputData.normalWS);
                  #else
                      inputData.bakedGI = SAMPLE_GI(IN.lightmapUV, IN.sh, inputData.normalWS);
                  #endif
               #endif

               inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.pos);
               inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUV);

               #if defined(DEBUG_DISPLAY)
                   #if defined(DYNAMICLIGHTMAP_ON)
                     inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
                   #endif
                   #if defined(LIGHTMAP_ON)
                     inputData.staticLightmapUV = IN.lightmapUV;
                   #else
                     inputData.vertexSH = IN.sh;
                   #endif
               #endif

               #ifdef _DBUFFER
                   ApplyDecal(IN.pos,
                       l.Albedo,
                       specular,
                       inputData.normalWS,
                       metallic,
                       l.Occlusion,
                       l.Smoothness);
               #endif

               BRDFData brdfData;
               InitializeBRDFData(l.Albedo, metallic, specular, l.Smoothness, l.Alpha, brdfData);
               Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
               MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
               half3 color = GlobalIllumination(brdfData, inputData.bakedGI, l.Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);

               return BRDFDataToGbuffer(brdfData, inputData, l.Smoothness, l.Emission + color, l.Occlusion);
            }

         ENDHLSL

      }


      
        Pass
        {
            Name "ShadowCaster"
            Tags 
            { 
                "LightMode" = "ShadowCaster"
            }
           
            // Render State
            Blend One Zero, One Zero
            Cull Back
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>

            	Cull[_Cull]


            HLSLPROGRAM

               #pragma vertex Vert
   #pragma fragment Frag

            #pragma target 3.0

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma multi_compile_instancing
  
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW


            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define _PASSSHADOW 1

            
	#pragma multi_compile_local _DIFFUSELIGHTINGSTYLE_STEPPED _DIFFUSELIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _SPECULARLIGHTINGSTYLE_BASIC _SPECULARLIGHTINGSTYLE_STEPPED _SPECULARLIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _DIFFUSETEXTUREMAPPING_SCREENSPACE _DIFFUSETEXTUREMAPPING_VIEWDIRECTION _DIFFUSETEXTUREMAPPING_SCREENSTABLE _DIFFUSETEXTUREMAPPING_WORLDSPACE _DIFFUSETEXTUREMAPPING_OBJECTSPACE
	#pragma multi_compile_local _SPECULARTEXTUREMAPPING_SCREENSPACE _SPECULARTEXTUREMAPPING_VIEWDIRECTION _SPECULARTEXTUREMAPPING_SCREENSTABLE _SPECULARTEXTUREMAPPING_WORLDSPACE _SPECULARTEXTUREMAPPING_OBJECTSPACE
	#pragma shader_feature_local _EMISSION
	#pragma shader_feature_local _REFLECTIONSENABLED_ON


   #define _URP 1

#define _UNLIT 1
#define _USINGTEXCOORD1 1
#define NEED_FACING 1
                 
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
            
                  #undef WorldNormalVector
      #define WorldNormalVector(data, normal) mul(normal, data.TBNMatrix)
      
      #define UnityObjectToWorldNormal(normal) mul(GetObjectToWorldMatrix(), normal)

      #define _WorldSpaceLightPos0 _MainLightPosition
      
      #define UNITY_DECLARE_TEX2D(name) TEXTURE2D(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2D_NOSAMPLER(name) TEXTURE2D(name);
      #define UNITY_DECLARE_TEX2DARRAY(name) TEXTURE2D_ARRAY(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(name) TEXTURE2D_ARRAY(name);

      #define UNITY_SAMPLE_TEX2DARRAY(tex,coord)            SAMPLE_TEXTURE2D_ARRAY(tex, sampler##tex, coord.xy, coord.z)
      #define UNITY_SAMPLE_TEX2DARRAY_LOD(tex,coord,lod)    SAMPLE_TEXTURE2D_ARRAY_LOD(tex, sampler##tex, coord.xy, coord.z, lod)
      #define UNITY_SAMPLE_TEX2D(tex, coord)                SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
      #define UNITY_SAMPLE_TEX2D_SAMPLER(tex, samp, coord)  SAMPLE_TEXTURE2D(tex, sampler##samp, coord)

      #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod)   SAMPLE_TEXTURE2D_LOD(tex, sampler_##tex, coord, lod)
      #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) SAMPLE_TEXTURE2D_LOD (tex, sampler##samplertex,coord, lod)
     
      #if defined(UNITY_COMPILER_HLSL)
         #define UNITY_INITIALIZE_OUTPUT(type,name) name = (type)0;
      #else
         #define UNITY_INITIALIZE_OUTPUT(type,name)
      #endif

      #define sampler2D_float sampler2D
      #define sampler2D_half sampler2D

      

      // data across stages, stripped like the above.
      struct VertexToPixel
      {
         float4 pos : SV_POSITION;
         float3 worldPos : TEXCOORD0;
         float3 worldNormal : TEXCOORD1;
         float4 worldTangent : TEXCOORD2;
          float4 texcoord0 : TEXCOORD3;
          float4 texcoord1 : TEXCOORD4;
         // float4 texcoord2 : TEXCOORD5;

         // #if %TEXCOORD3REQUIREKEY%
          float4 texcoord3 : TEXCOORD6;
         // #endif

         // #if %SCREENPOSREQUIREKEY%
          float4 screenPos : TEXCOORD7;
         // #endif

         // #if %VERTEXCOLORREQUIREKEY%
         // half4 vertexColor : COLOR;
         // #endif

         #if defined(LIGHTMAP_ON)
            float2 lightmapUV : TEXCOORD8;
         #endif
         #if defined(DYNAMICLIGHTMAP_ON)
            float2 dynamicLightmapUV : TEXCOORD9;
         #endif
         #if !defined(LIGHTMAP_ON)
            float3 sh : TEXCOORD10;
         #endif

         #if defined(VARYINGS_NEED_FOG_AND_VERTEX_LIGHT)
            float4 fogFactorAndVertexLight : TEXCOORD11;
         #endif

         #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
           float4 shadowCoord : TEXCOORD12;
         #endif

         // #if %EXTRAV2F0REQUIREKEY%
         // float4 extraV2F0 : TEXCOORD13;
         // #endif

         // #if %EXTRAV2F1REQUIREKEY%
         // float4 extraV2F1 : TEXCOORD14;
         // #endif

         // #if %EXTRAV2F2REQUIREKEY%
         // float4 extraV2F2 : TEXCOORD15;
         // #endif

         // #if %EXTRAV2F3REQUIREKEY%
         // float4 extraV2F3 : TEXCOORD16;
         // #endif

         // #if %EXTRAV2F4REQUIREKEY%
         // float4 extraV2F4 : TEXCOORD17;
         // #endif

         // #if %EXTRAV2F5REQUIREKEY%
         // float4 extraV2F5 : TEXCOORD18;
         // #endif

         // #if %EXTRAV2F6REQUIREKEY%
         // float4 extraV2F6 : TEXCOORD19;
         // #endif

         // #if %EXTRAV2F7REQUIREKEY%
         // float4 extraV2F7 : TEXCOORD20;
         // #endif

         #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
         #endif
         #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
         #endif
         #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
         #endif
         #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
         #endif
      };

         
            
            
            // data describing the user output of a pixel
            struct Surface
            {
               half3 Albedo;
               half Height;
               half3 Normal;
               half Smoothness;
               half3 Emission;
               half Metallic;
               half3 Specular;
               half Occlusion;
               half SpecularPower; // for simple lighting
               half Alpha;
               float outputDepth; // if written, SV_Depth semantic is used. ShaderData.clipPos.z is unused value
               // HDRP Only
               half SpecularOcclusion;
               half SubsurfaceMask;
               half Thickness;
               half CoatMask;
               half CoatSmoothness;
               half Anisotropy;
               half IridescenceMask;
               half IridescenceThickness;
               int DiffusionProfileHash;
               float SpecularAAThreshold;
               float SpecularAAScreenSpaceVariance;
               // requires _OVERRIDE_BAKEDGI to be defined, but is mapped in all pipelines
               float3 DiffuseGI;
               float3 BackDiffuseGI;
               float3 SpecularGI;
               // requires _OVERRIDE_SHADOWMASK to be defines
               float4 ShadowMask;
            };

            // Data the user declares in blackboard blocks
            struct Blackboard
            {
                
                float blackboardDummyData;
            };

            // data the user might need, this will grow to be big. But easy to strip
            struct ShaderData
            {
               float4 clipPos; // SV_POSITION
               float3 localSpacePosition;
               float3 localSpaceNormal;
               float3 localSpaceTangent;
        
               float3 worldSpacePosition;
               float3 worldSpaceNormal;
               float3 worldSpaceTangent;
               float tangentSign;

               float3 worldSpaceViewDir;
               float3 tangentSpaceViewDir;

               float4 texcoord0;
               float4 texcoord1;
               float4 texcoord2;
               float4 texcoord3;

               float2 screenUV;
               float4 screenPos;

               float4 vertexColor;
               bool isFrontFace;

               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;

               float3x3 TBNMatrix;
               Blackboard blackboard;
            };

            struct VertexData
            {
               #if SHADER_TARGET > 30
               // uint vertexID : SV_VertexID;
               #endif
               float4 vertex : POSITION;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;

               // optimize out mesh coords when not in use by user or lighting system
               #if _URP && (_USINGTEXCOORD1 || _PASSMETA || _PASSFORWARD || _PASSGBUFFER)
                  float4 texcoord1 : TEXCOORD1;
               #endif

               #if _URP && (_USINGTEXCOORD2 || _PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && defined(DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif

               #if _STANDARD && (_USINGTEXCOORD1 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER || _PASSFORWARDADD) && LIGHTMAP_ON)))
                  float4 texcoord1 : TEXCOORD1;
               #endif
               #if _STANDARD && (_USINGTEXCOORD2 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif


               #if _HDRP
                  float4 texcoord1 : TEXCOORD1;
                  float4 texcoord2 : TEXCOORD2;
               #endif

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD4; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity    : TEXCOORD5; // Add Precomputed Velocity (Alembic computes velocities on runtime side).
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct TessVertex 
            {
               float4 vertex : INTERNALTESSPOS;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;
               float4 texcoord1 : TEXCOORD1;
               float4 texcoord2 : TEXCOORD2;

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               // #if %EXTRAV2F0REQUIREKEY%
               // float4 extraV2F0 : TEXCOORD5;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // float4 extraV2F1 : TEXCOORD6;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // float4 extraV2F2 : TEXCOORD7;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // float4 extraV2F3 : TEXCOORD8;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // float4 extraV2F4 : TEXCOORD9;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // float4 extraV2F5 : TEXCOORD10;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // float4 extraV2F6 : TEXCOORD11;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // float4 extraV2F7 : TEXCOORD12;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD13; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity : TEXCOORD14;
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
               UNITY_VERTEX_OUTPUT_STEREO
            };

            struct ExtraV2F
            {
               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;
               Blackboard blackboard;
               float4 time;
            };


            float3 WorldToTangentSpace(ShaderData d, float3 normal)
            {
               return mul(d.TBNMatrix, normal);
            }

            float3 TangentToWorldSpace(ShaderData d, float3 normal)
            {
               return mul(normal, d.TBNMatrix);
            }

            // in this case, make standard more like SRPs, because we can't fix
            // unity_WorldToObject in HDRP, since it already does macro-fu there

            #if _STANDARD
               float3 TransformWorldToObject(float3 p) { return mul(unity_WorldToObject, float4(p, 1)); };
               float3 TransformObjectToWorld(float3 p) { return mul(unity_ObjectToWorld, float4(p, 1)); };
               float4 TransformWorldToObject(float4 p) { return mul(unity_WorldToObject, p); };
               float4 TransformObjectToWorld(float4 p) { return mul(unity_ObjectToWorld, p); };
               float4x4 GetWorldToObjectMatrix() { return unity_WorldToObject; }
               float4x4 GetObjectToWorldMatrix() { return unity_ObjectToWorld; }
               #if (defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (SHADER_TARGET_SURFACE_ANALYSIS && !SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod) tex.SampleLevel (sampler##tex,coord, lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) tex.SampleLevel (sampler##samplertex,coord, lod)
              #else
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex2D (tex,coord,0,lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) tex2D (tex,coord,0,lod)
              #endif

               #undef GetWorldToObjectMatrix()

               #define GetWorldToObjectMatrix()   unity_WorldToObject


            #endif

            float3 GetCameraWorldPosition()
            {
               #if _HDRP
                  return GetCameraRelativePositionWS(_WorldSpaceCameraPos);
               #else
                  return _WorldSpaceCameraPos;
               #endif
            }

            #if _GRABPASSUSED
               #if _STANDARD
                  TEXTURE2D(%GRABTEXTURE%);
                  SAMPLER(sampler_%GRABTEXTURE%);
               #endif

               half3 GetSceneColor(float2 uv)
               {
                  #if _STANDARD
                     return SAMPLE_TEXTURE2D(%GRABTEXTURE%, sampler_%GRABTEXTURE%, uv).rgb;
                  #else
                     return SHADERGRAPH_SAMPLE_SCENE_COLOR(uv);
                  #endif
               }
            #endif


      
            #if _STANDARD
               UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
               float GetSceneDepth(float2 uv) { return SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv)); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv)); } 
            #else
               float GetSceneDepth(float2 uv) { return SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv), _ZBufferParams); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv), _ZBufferParams); } 
            #endif

            float3 GetWorldPositionFromDepthBuffer(float2 uv, float3 worldSpaceViewDir)
            {
               float eye = GetLinearEyeDepth(uv);
               float3 camView = mul((float3x3)GetObjectToWorldMatrix(), transpose(mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V)) [2].xyz);

               float dt = dot(worldSpaceViewDir, camView);
               float3 div = worldSpaceViewDir/dt;
               float3 wpos = (eye * div) + GetCameraWorldPosition();
               return wpos;
            }

            #if _HDRP
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return GetAbsolutePositionWS(TransformObjectToWorld(pos));
            }
            #else
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return TransformObjectToWorld(pos);
            }
            #endif

            #if _STANDARD
               UNITY_DECLARE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture);
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  float4 depthNorms = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture, uv);
                  float3 norms = DecodeViewNormalStereo(depthNorms);
                  norms = mul((float3x3)GetWorldToViewMatrix(), norms) * 0.5 + 0.5;
                  return norms;
               }
            #elif _HDRP
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  NormalData nd;
                  DecodeFromNormalBuffer(_ScreenSize.xy * uv, nd);
                  return nd.normalWS;
               }
            #elif _URP
               #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                  #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
               #endif

               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                     return SampleSceneNormals(uv);
                  #else
                     float3 wpos = GetWorldPositionFromDepthBuffer(uv, worldSpaceViewDir);
                     return normalize(-cross(ddx(wpos), ddy(wpos))) * 0.5 + 0.5;
                  #endif

                }
             #endif

             #if _HDRP

               half3 UnpackNormalmapRGorAG(half4 packednormal)
               {
                     // This do the trick
                  packednormal.x *= packednormal.w;

                  half3 normal;
                  normal.xy = packednormal.xy * 2 - 1;
                  normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                  return normal;
               }
               half3 UnpackNormal(half4 packednormal)
               {
                  #if defined(UNITY_NO_DXT5nm)
                     return packednormal.xyz * 2 - 1;
                  #else
                     return UnpackNormalmapRGorAG(packednormal);
                  #endif
               }
               #endif
               #if _HDRP || _URP

               half3 UnpackScaleNormal(half4 packednormal, half scale)
               {
                 #ifndef UNITY_NO_DXT5nm
                   // Unpack normal as DXT5nm (1, y, 1, x) or BC5 (x, y, 0, 1)
                   // Note neutral texture like "bump" is (0, 0, 1, 1) to work with both plain RGB normal and DXT5nm/BC5
                   packednormal.x *= packednormal.w;
                 #endif
                   half3 normal;
                   normal.xy = (packednormal.xy * 2 - 1) * scale;
                   normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                   return normal;
               }	

             #endif


            void GetSun(out float3 lightDir, out float3 color)
            {
               lightDir = float3(0.5, 0.5, 0);
               color = 1;
               #if _HDRP
                  if (_DirectionalLightCount > 0)
                  {
                     DirectionalLightData light = _DirectionalLightDatas[0];
                     lightDir = -light.forward.xyz;
                     color = light.color;
                  }
               #elif _STANDARD
			         lightDir = normalize(_WorldSpaceLightPos0.xyz);
                  color = _LightColor0.rgb;
               #elif _URP
	               Light light = GetMainLight();
	               lightDir = light.direction;
	               color = light.color;
               #endif
            }


            
            CBUFFER_START(UnityPerMaterial)

               
	int _DiffuseLightingStyle;
	int _SpecularLightingStyle;
	int _CutoffEnabled;
	float _Cutoff;
	half4 _Color;
	float _AmbientShadowStrength;
	float _NormalMapStr;
	float4 _TilingOffset;
	int _DiffuseSteps;
	int _SpecularType;
	int _SpecularSteps;
	int _SpecularHatching;
	float2 _DiffuseEdge;
	int _DiffuseTextureMapping;
	int _ScreenStableDistanceScale;
	int _ScreenStableDistanceScaleSpec;
	float _DiffuseTextureSize;
	float _DiffuseRim;
	float2 _SpecularEdge;
	int _LinesOn;
	int _InvertShadowedLines;
	int _DiffuseHatching;
	float _DiffuseTextureContrast;
	float3 _HatchingRanges;
	float3 _HatchingRangesSpec;
	int _SpecularTextureMapping;
	float _SpecularTextureSize;
	int _KeepLinesThicc;
	float _SpecularTextureContrast;
	int _ReflectionsEnabled;
	float4 _ReflectionFresnelParams;
	float _BaseReflectStrength;
	float3 _EmissionColor;
	float _LightmapEmissionStr;
	float2 _PaintMaskEdges;



            CBUFFER_END

            

            

            #ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()


	// TODO:
	// Flip backface normals
	// Alpha cutoff support

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskMap);
	SAMPLER(sampler_MaskMap);

	TEXTURE2D(_BumpMap);
	SAMPLER(sampler_BumpMap);

	TEXTURE2D(_DiffuseTexture);
	TEXTURE2D(_SpecularTexture);

	TEXTURE2D(_EmissionTexture);
	SAMPLER(sampler_EmissionTexture);

	TEXTURE3D(_WobbleTexture);

	float invLerp(float from, float to, float value) {
		return (value - from) / (to - from);
	}

	float4 invLerp(float4 from, float4 to, float4 value) {
		return (value - from) / (to - from);
	}

	float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value){
		float rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	float4 remap(float4 origFrom, float4 origTo, float4 targetFrom, float4 targetTo, float4 value){
		float4 rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	SAMPLER(s_linear_repeat_sampler);

	void MainLight(out float3 direction, out float3 color, out float distanceAtten)
	{
		Light mainLight = GetMainLight();
		direction = mainLight.direction;
		color = mainLight.color;
		distanceAtten = mainLight.distanceAttenuation;
	}

	float ToonSharpen(float input, float edge = 0.1f)
	{
		float fw = fwidth(input)*0.5;
		return saturate(remap(edge - fw, edge + fw, 0, 1, input));
	}

	float3 Posterize(float3 input, int steps)
	{
		return round(input*steps)/steps;
	}

	float Posterize(float input, int steps)
	{
		return round(input*steps)/steps;

	}

	float Fresnel(float3 worldNormal, float3 viewAngle, float exp = 4)
	{
		return 1 - pow(abs(dot(worldNormal, viewAngle)),exp);
	}

	float MainLightShadows(float3 worldPos, float2 lightmapUV = float2(0.0,0.0))
	{
		float4 shadowCoord = TransformWorldToShadowCoord(worldPos);

		#if !defined (LIGHTMAP_ON) || defined(_LIGHTINGTYPE_VERTEX)
			half4 shadowMask = unity_ProbesOcclusion;
		#else
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half4 shadowMask = SAMPLE_SHADOWMASK(lightmapUV);
		#endif

		return ToonSharpen(MainLightShadow(shadowCoord, worldPos, shadowMask, _MainLightOcclusionProbes), 0.5f);
	}

	float3 GetAmbient(float3 worldNormal, float2 lightmapUV)
	{
		#ifdef LIGHTMAP_ON
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half3 bakedGI = SampleLightmap(lightmapUV, worldNormal);

			#if defined(_MIXED_LIGHTING_SUBTRACTIVE)
				Light mainLight = GetMainLight();
				bakedGI = SubtractDirectMainLightFromLightmap(mainLight, worldNormal, bakedGI);
			#endif

			return bakedGI;
		#else
			return SampleSH(worldNormal);
		#endif
	}

	float3 GetReflections(float3 worldNormal, float3 viewDir, float smoothness)
	{
		float perceptualRoughness = 1 - smoothness;
		perceptualRoughness *= perceptualRoughness;
		float mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
		float3 sample = SHADERGRAPH_REFLECTION_PROBE(viewDir, worldNormal, mip);
		return sample.rgb;
	}

	void SSAO(ShaderData d, out float directOcclusion, out float indirectOcclusion)
	{
		#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(ALPHABLEND)
			float2 uv = d.screenUV;

			AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(uv);
			directOcclusion = aoFactor.directAmbientOcclusion;
			indirectOcclusion = aoFactor.indirectAmbientOcclusion;
		#else
			directOcclusion = 1;
			indirectOcclusion = 1;
		#endif
	}

	half3 Triplanar(Texture2D tex, half3 samplePos, half3 normal, float size)
	{
		half2 uvX = samplePos.zy;
		half2 uvY = samplePos.xz + 0.67;
		half2 uvZ = samplePos.xy + 0.33;

		half3 lx = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvX / size).rgb;
		half3 ly = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvY / size).rgb;
		half3 lz = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvZ / size).rgb;

		float3 blend = pow(abs(normal),4);
		blend /= dot(blend, float3(1,1,1));

		return lx * blend.x + ly * blend.y + lz * blend.z;
	}

	half3 ViewDirLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float3 objPos = TransformObjectToWorld(0);
		float dist = distance(objPos, _WorldSpaceCameraPos);

		float3 samplePos = d.worldSpaceViewDir - _WorldSpaceCameraPos/dist;

		return Triplanar(tex, samplePos, d.worldSpaceViewDir, size);
	}

	half3 ScreenStableLightingTexture(ShaderData d, Texture2D tex, float size, int screenStableDistScale)
	{
		float3 objPos = TransformObjectToWorld(0);

		float dist = 3;

		if (screenStableDistScale)
			dist = distance(_WorldSpaceCameraPos, objPos);

		float4 clipPos = TransformObjectToHClip(TransformWorldToObject(d.worldSpacePosition));
		clipPos = ComputeScreenPos(clipPos);
		clipPos.xy /= clipPos.w;

		float4 objClipPos = TransformWorldToHClip(objPos);
		objClipPos = ComputeScreenPos(objClipPos);
		objClipPos.xy /= objClipPos.w;

		float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
		objClipPos.xy *= screenratio;
		clipPos.xy *= screenratio; 

		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, (clipPos.rg - objClipPos.rg) * size * dist).rgb;
	}

	half3 WorldSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, d.worldSpacePosition, d.worldSpaceNormal, size);
	}

	half3 ObjectSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, TransformWorldToObject(d.worldSpacePosition), TransformWorldToObject(d.worldSpaceNormal), size);
	}

	half3 ScreenSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float screenratio = _ScreenParams.x / _ScreenParams.y;
		float2 uv = d.screenUV;
		uv.x *= screenratio;
		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uv / size).rgb;
	}

	float TexturedDiffuse(float3 lightingTex, float inputDiffuse, float lightStr = 1, bool mainLight = false)
	{
		lightingTex = pow(abs(lightingTex), _DiffuseTextureContrast);
		float origDiffuse = inputDiffuse;
		if (mainLight)
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse));
		else
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse*lightStr));

		UNITY_BRANCH
		if (_DiffuseHatching == 0)
		{	
			origDiffuse = ToonSharpen(max(1 - lightingTex.r,0.025), 1 - origDiffuse);
		}
		else
		{
			lightingTex = max(1 - lightingTex,0.01);
			float3 hatchDiffuse = origDiffuse;
			hatchDiffuse.r = smoothstep(0, _HatchingRanges.r, origDiffuse);
			hatchDiffuse.g = smoothstep(0, _HatchingRanges.g, origDiffuse);
			hatchDiffuse.b = smoothstep(0, _HatchingRanges.b, origDiffuse);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchDiffuse.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchDiffuse.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchDiffuse.b);

			float combined = min(min(lightingTex.r, lightingTex.g),lightingTex.b);
			origDiffuse = ToonSharpen(combined, 1 - origDiffuse)*lightStr;
		}
		return origDiffuse;
	}

	float TexturedSpecular(float3 lightingTex, float inputSpec, float lightStr = 1)
	{
		
		lightingTex = pow(abs(lightingTex), _SpecularTextureContrast);
		//lightingTex -= 0.15;
		float origSpecular = smoothstep(_SpecularEdge.x, _SpecularEdge.y, saturate(inputSpec*lightStr*0.5));

		UNITY_BRANCH
		if (_SpecularHatching == 0)
		{	
			origSpecular = 1 - smoothstep(0, origSpecular, ToonSharpen(1 - lightingTex.r, origSpecular));
		}
		else
		{
			lightingTex = 1 - lightingTex;
			float3 hatchSpec = origSpecular;
			hatchSpec.r = smoothstep(1 - _HatchingRangesSpec.r, 1, origSpecular);
			hatchSpec.g = smoothstep(1 - _HatchingRangesSpec.g, 1, origSpecular);
			hatchSpec.b = smoothstep(1 - _HatchingRangesSpec.b, 1, origSpecular);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchSpec.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchSpec.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchSpec.b);

			float combined = max(max(lightingTex.r, lightingTex.g),lightingTex.b);
			origSpecular = smoothstep(0, origSpecular, combined);
		}
		return origSpecular;
	}

	float GetDiffuse(float3 lightingTex, Light l, ShaderData d, Surface o, bool mainLight = false, float lineArt = 1)
	{
		float diffuse = saturate(dot(l.direction, d.worldSpaceNormal));
		
		#if defined(_DIFFUSELIGHTINGSTYLE_STEPPED)
			diffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, diffuse);
			diffuse *= length(l.color);
			diffuse *= l.shadowAttenuation * saturate(l.distanceAttenuation);
			if (_DiffuseSteps > 1)
			{
				
				float origDiffuse = diffuse;
				float powLerpFactor = saturate(invLerp(1, 12, _DiffuseSteps));
				float powFactor = lerp(0.5, 1, powLerpFactor);

				diffuse = Posterize(pow(abs(diffuse), powFactor), _DiffuseSteps);

			}
			else
				diffuse = ToonSharpen(diffuse,0.075);

			diffuse /= length(l.color);
		#elif defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			diffuse *= l.shadowAttenuation * l.distanceAttenuation;
			diffuse = TexturedDiffuse(lightingTex, diffuse, length(l.color), mainLight);
		#endif

		UNITY_BRANCH
		if (_DiffuseRim*lineArt*l.shadowAttenuation*l.distanceAttenuation > 0)
		{
			float rim = Fresnel(d.worldSpaceNormal, d.worldSpaceViewDir);
			float mainLightAlignment = saturate(-dot(d.worldSpaceViewDir, l.direction));
			
			float rimSize = lerp(1.0, 0.9, _DiffuseRim*l.distanceAttenuation*l.distanceAttenuation);

			rim = ToonSharpen(rim,lerp(1.01, rimSize, mainLightAlignment)) * ToonSharpen(mainLightAlignment);
			diffuse = max(diffuse, rim);
		}

		return diffuse;
	}
	
	float GetSpecular(float3 lightingTex, Light l, ShaderData d, Surface o)
	{
		float baseSpec = 0;
		float SpecSmoothness = exp2(10 * o.Smoothness + 1).x;

		[branch]
		if (_SpecularType == 0) //Cook-Torrance
		{
			float roughness = 1 - o.Smoothness;
			roughness *= roughness;

			float3 h = SafeNormalize(l.direction + d.worldSpaceViewDir);
			float nh = saturate(dot(d.worldSpaceNormal, h));
			float lh = saturate(dot(l.direction, h));
			float d = nh * nh * (roughness * roughness - 1.0) + 1.00001;
			float normTerm = roughness * 4.0 + 2.0;
			float specTerm = roughness * roughness;
			specTerm /= (d * d) * max(0.1, lh * lh) * normTerm;
			baseSpec = specTerm*0.04;
		}
		else if (_SpecularType == 1) //Phong
		{
			float3 r = reflect(-l.direction, d.worldSpaceNormal);
			float rdotv = max(0, dot(r, d.worldSpaceViewDir));

			baseSpec = pow(rdotv, SpecSmoothness)*o.Smoothness;
		}
		else if (_SpecularType == 2) //Blinn-Phong
		{
			float3 h = SafeNormalize(l.direction+d.worldSpaceViewDir);
			float ndh = saturate(dot(d.worldSpaceNormal, h));

			baseSpec = pow(ndh, SpecSmoothness)*o.Smoothness;
		}
		else
		{
			return 0;
		}

		

		#if defined(_SPECULARLIGHTINGSTYLE_BASIC)
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation * length(l.color);
			baseSpec = smoothstep(_SpecularEdge.x,_SpecularEdge.y, baseSpec);
			baseSpec /= length(l.color);
		#elif defined(_SPECULARLIGHTINGSTYLE_STEPPED)
			baseSpec *= saturate(l.distanceAttenuation) * l.shadowAttenuation;
			baseSpec *= length(l.color);
			baseSpec = Posterize(baseSpec, max(1,_SpecularSteps));
			baseSpec /= length(l.color);
		#else
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation;
			baseSpec = TexturedSpecular(lightingTex, baseSpec, length(l.color));
		#endif	

		
		return baseSpec;
	}

	void Ext_ModifyVertex0 (inout VertexData v, inout ExtraV2F d)
	{
		v.texcoord0.xy = v.texcoord0.xy * _TilingOffset.xy + _TilingOffset.zw;

		if (_DiffuseTextureMapping == 2)
		{
			float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
			clipPos.xy /= clipPos.w;  

			float3 objPos = TransformObjectToWorld(0);
			float camDist = distance(objPos, _WorldSpaceCameraPos);
			float4 objClipPos = TransformWorldToHClip(objPos);
			objClipPos.xy /= objClipPos.w;

			float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
			objClipPos.xy *= screenratio;
			clipPos.xy *= screenratio;

			v.texcoord3 = (clipPos - objClipPos); 
		}
	}

	void Ext_SurfaceFunction0 (inout Surface o, ShaderData d)
	{
		
		// Handle input data
		float4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, d.texcoord0.xy);
		float4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, d.texcoord0.xy);
		o.Normal = UnpackScaleNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, d.texcoord0.xy), _NormalMapStr);
		d.worldSpaceNormal = TransformTangentToWorld(o.Normal, d.TBNMatrix);

		float diffuseColorMult = 1.0f;
		float specColorMult = 1.0f;

		if (_DiffuseLightingStyle == 1)
			diffuseColorMult = 0.5f;

		if (_SpecularLightingStyle = 2)
			specColorMult = 0.5f;

		if (!d.isFrontFace)
		{
			d.worldSpaceNormal *= -1;
		}

		o.Metallic = masks.r;
		o.Smoothness = masks.g;
		o.Alpha = baseColor.a * _Color.a;

		if (_CutoffEnabled)
			clip(o.Alpha - _Cutoff);

		o.Occlusion = 1;
		float3 specColor = 1;
		float paintmask = masks.b;

		float3 paintedColor = baseColor.rgb * _Color.rgb;
		baseColor.rgb = lerp(baseColor.rgb, paintedColor, smoothstep(_PaintMaskEdges.x, _PaintMaskEdges.y, paintmask));

		#if defined(_EMISSION)
			o.Emission = SAMPLE_TEXTURE2D(_EmissionTexture, sampler_EmissionTexture, d.texcoord0).rgb * _EmissionColor;
		#endif

		half lines = 1;
		half origlines = 1;
		float lineCutoff = 0.5;

		#if defined(LIGHTMAP_ON)
			half4 shadowMask = SAMPLE_SHADOWMASK(d.texcoord1.xy);
		#else
			half4 shadowMask = unity_ProbesOcclusion;
		#endif

		// -------------
		// LINE ART
		// -------------
		UNITY_BRANCH
		if (_LinesOn)
		{
			UNITY_BRANCH
			if (_KeepLinesThicc)
			{
				float dist = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
				float fresnel = pow(abs(dot(d.worldSpaceNormal, d.worldSpaceViewDir)),3);
				lineCutoff = lerp(0.5, 0.95, max(saturate(dist*0.2), fresnel));
			}
			lines = 1 - masks.a;

			 // Save original lines to use if ambient is raised
		}

		#ifdef _DBUFFER
			ApplyDecal(d.clipPos, baseColor.rgb, specColor, d.worldSpaceNormal, o.Metallic, lines, o.Smoothness);
		#endif

		if (_LinesOn)
		{
			lines = ToonSharpen(lines, lineCutoff);
			origlines = lines;
		}
		else
		{
			lines = 1;
		}

		// Store lighting values in these
		float3 mainLightDir;
		float3 mainLightCol;
		float mainLightAtten;
		MainLight(mainLightDir, mainLightCol, mainLightAtten);

		float2 lightmapUV = d.texcoord1.xy;

		float mainShadows = MainLightShadows(d.worldSpacePosition, lightmapUV);
		float3 ambient = GetAmbient(d.worldSpaceNormal, lightmapUV) * baseColor.rgb;

		Light mainLight = GetMainLight();

		#if   defined(_DIFFUSETEXTUREMAPPING_SCREENSPACE)
			float3 diffuseLightingTex = ScreenSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_VIEWDIRECTION)
			float3 diffuseLightingTex = ViewDirLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_SCREENSTABLE)
			float3 diffuseLightingTex = ScreenStableLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize, _ScreenStableDistanceScale);
		#elif defined(_DIFFUSETEXTUREMAPPING_WORLDSPACE)
			float3 diffuseLightingTex = WorldSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_OBJECTSPACE)
			float3 diffuseLightingTex = ObjectSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#endif

		#if   defined(_SPECULARTEXTUREMAPPING_SCREENSPACE)
			float3 specLightingTex = ScreenSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_VIEWDIRECTION)
			float3 specLightingTex = ViewDirLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_SCREENSTABLE)
			float3 specLightingTex = ScreenStableLightingTexture(d, _SpecularTexture, _SpecularTextureSize, _ScreenStableDistanceScale);
		#elif defined(_SPECULARTEXTUREMAPPING_WORLDSPACE)
			float3 specLightingTex = WorldSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_OBJECTSPACE)
			float3 specLightingTex = ObjectSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#endif
		

		float indirOcclusion, directOcclusion;
		SSAO(d, directOcclusion, indirOcclusion);

		#if defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			directOcclusion = TexturedDiffuse(diffuseLightingTex, directOcclusion);
			//indirOcclusion = TexturedDiffuse(diffuseLightingTex, indirOcclusion);
			ambient = min(indirOcclusion, ambient);
		#endif

		float mainDiffuseFactor = GetDiffuse(diffuseLightingTex, mainLight, d, o, true, lines)*directOcclusion*diffuseColorMult;
		mainDiffuseFactor *= mainShadows;
		float mainSpecFactor = GetSpecular(specLightingTex, mainLight, d, o) * specColorMult;
		
		float3 addLightDiffuse = 0;
		float3 addLightSpecular = 0;
		// -------------
		// ADDITIONALLIGHTS
		// -------------
		int pixelLights = GetAdditionalLightsCount();
		for (int i = 0; i < pixelLights; ++i)
		{
			Light light = GetAdditionalLight(i, d.worldSpacePosition, shadowMask);

			float diffuse = GetDiffuse(diffuseLightingTex, light, d, o, false, lines) * diffuseColorMult;
			float specular = GetSpecular(specLightingTex, light, d, o) * specColorMult;

			addLightDiffuse += diffuse * light.color;
			addLightSpecular += specular * light.color;
		}
		
		float diffuseDarkest = ToonSharpen(length(addLightDiffuse)+saturate(mainDiffuseFactor*length(mainLight.color)),0.025);

		// -------------
		// REFLECTIONS
		// -------------
		float3 reflections = 0;
		
		#if defined(_REFLECTIONSENABLED_ON)
			float reflectStr = 0.04*_BaseReflectStrength*2;;
			reflections = GetReflections(d.worldSpaceNormal, d.worldSpaceViewDir, o.Smoothness);
			float perceptualRoughness = (1 - o.Smoothness);
			perceptualRoughness *= perceptualRoughness;		

			float fresnel = pow(1.0 - saturate(dot(d.worldSpaceNormal, d.worldSpaceViewDir)-_ReflectionFresnelParams.y), _ReflectionFresnelParams.x*16);
			fresnel = smoothstep(_ReflectionFresnelParams.w*0.5, 1 - _ReflectionFresnelParams.w*0.5, fresnel);
			reflectStr = lerp(reflectStr, clamp(0, 2, 0.04*_ReflectionFresnelParams.z*50), fresnel);

			reflections *= reflectStr;
			reflections /= perceptualRoughness + 0.5;

			reflections = lerp(reflections, reflections * baseColor.rgb, o.Metallic);
		#endif
		
		#if defined(ALPHABLEND) && !defined(_PASSMETA)

			if (_OpaqueLines)
				o.Alpha = max(o.Alpha, 1 - lines);

			UNITY_BRANCH
			if (_PreserveSpec)
			{
				o.Alpha = max(Luminance(reflections), o.Alpha);
				o.Alpha = max(mainSpecFactor, o.Alpha);
				o.Alpha = max(addLightSpecular, o.Alpha);
			}

			float3 refractionCol = 0;
			float origAlpha = o.Alpha;
			UNITY_BRANCH
			if (_Refraction)
			{
				float4 offsetPos = float4(d.worldSpacePosition + d.worldSpaceNormal * _RefractionStr, 1.0);
				offsetPos = mul(GetWorldToHClipMatrix(), offsetPos);
				float scale = 1.0;

				#if UNITY_UV_STARTS_AT_TOP
					scale = -1.0;
				#endif

				float4 grabPos = offsetPos *0.5f;
				grabPos.xy = float2(grabPos.x, grabPos.y*scale) + grabPos.w;
				grabPos.zw = offsetPos.zw;
				grabPos.xy /= grabPos.w;
				grabPos.xy = saturate(grabPos.xy);

				float3 refraction = GetSceneColor(grabPos.xy);
				refractionCol = refraction;
				if (_RefractionTint)
					refraction *= baseColor.rgb;

				_RefractionEdge = 1 - _RefractionEdge;
				if (_RefractionEdge > 0)
				{
					float2 cubemapBlendFactors = pow(abs((grabPos.xy - 0.5) * 2.0),0.25);
					float blend = smoothstep(_RefractionEdge, 1, max(cubemapBlendFactors.x, cubemapBlendFactors.y));
					float3 refractDir = refract(-d.worldSpaceViewDir, d.worldSpaceNormal, 1 - _RefractionStr);
					float3 reflectProbe = GetReflections(-refractDir, refractDir, 1.0);
					
					refractionCol = lerp(refraction, reflectProbe, blend);
				}
				
				o.Alpha = 1;
			}

		#endif		

		float3 mainSpec = mainSpecFactor * mainLightCol;
		float3 mainDiffuse = mainDiffuseFactor * mainLightCol;

		addLightSpecular = lerp(addLightSpecular, addLightSpecular * baseColor.rgb, o.Metallic);
		mainSpec = lerp(mainSpec, mainSpec * specColor, o.Metallic);

		lines = lerp(1 - lines, lines, diffuseDarkest);
		
		if (_InvertShadowedLines)
			diffuseDarkest = lerp(diffuseDarkest, 1, lines);

		o.Albedo = baseColor.rgb;
		o.Emission *= _LightmapEmissionStr;
		#if !defined(_PASSMETA)
			o.Albedo *= mainDiffuse * lines;
			o.Albedo += reflections* mainDiffuse *lines;
			o.Albedo += addLightDiffuse * lines * baseColor.rgb + addLightSpecular * lines;
			o.Albedo += mainSpec * mainDiffuse * mainShadows * lines;
			
			o.Albedo += lerp(ambient*diffuseDarkest * lines, ambient*origlines, _AmbientShadowStrength);
			#if defined(ALPHABLEND)
				if (_Refraction)
				{
					o.Albedo = lerp(refractionCol, o.Albedo, origAlpha);
				}
			#endif
			o.Albedo += o.Emission;
		#endif
	}




        
            void ChainSurfaceFunction(inout Surface l, inout ShaderData d)
            {
                  Ext_SurfaceFunction0(l, d);
                 // Ext_SurfaceFunction1(l, d);
                 // Ext_SurfaceFunction2(l, d);
                 // Ext_SurfaceFunction3(l, d);
                 // Ext_SurfaceFunction4(l, d);
                 // Ext_SurfaceFunction5(l, d);
                 // Ext_SurfaceFunction6(l, d);
                 // Ext_SurfaceFunction7(l, d);
                 // Ext_SurfaceFunction8(l, d);
                 // Ext_SurfaceFunction9(l, d);
		           // Ext_SurfaceFunction10(l, d);
                 // Ext_SurfaceFunction11(l, d);
                 // Ext_SurfaceFunction12(l, d);
                 // Ext_SurfaceFunction13(l, d);
                 // Ext_SurfaceFunction14(l, d);
                 // Ext_SurfaceFunction15(l, d);
                 // Ext_SurfaceFunction16(l, d);
                 // Ext_SurfaceFunction17(l, d);
                 // Ext_SurfaceFunction18(l, d);
		           // Ext_SurfaceFunction19(l, d);
                 // Ext_SurfaceFunction20(l, d);
                 // Ext_SurfaceFunction21(l, d);
                 // Ext_SurfaceFunction22(l, d);
                 // Ext_SurfaceFunction23(l, d);
                 // Ext_SurfaceFunction24(l, d);
                 // Ext_SurfaceFunction25(l, d);
                 // Ext_SurfaceFunction26(l, d);
                 // Ext_SurfaceFunction27(l, d);
                 // Ext_SurfaceFunction28(l, d);
		           // Ext_SurfaceFunction29(l, d);
            }

            void ChainModifyVertex(inout VertexData v, inout VertexToPixel v2p, float4 time)
            {
                 ExtraV2F d;
                 
                 ZERO_INITIALIZE(ExtraV2F, d);
                 ZERO_INITIALIZE(Blackboard, d.blackboard);
                 // due to motion vectors in HDRP, we need to use the last
                 // time in certain spots. So if you are going to use _Time to adjust vertices,
                 // you need to use this time or motion vectors will break. 
                 d.time = time;

                   Ext_ModifyVertex0(v, d);
                 // Ext_ModifyVertex1(v, d);
                 // Ext_ModifyVertex2(v, d);
                 // Ext_ModifyVertex3(v, d);
                 // Ext_ModifyVertex4(v, d);
                 // Ext_ModifyVertex5(v, d);
                 // Ext_ModifyVertex6(v, d);
                 // Ext_ModifyVertex7(v, d);
                 // Ext_ModifyVertex8(v, d);
                 // Ext_ModifyVertex9(v, d);
                 // Ext_ModifyVertex10(v, d);
                 // Ext_ModifyVertex11(v, d);
                 // Ext_ModifyVertex12(v, d);
                 // Ext_ModifyVertex13(v, d);
                 // Ext_ModifyVertex14(v, d);
                 // Ext_ModifyVertex15(v, d);
                 // Ext_ModifyVertex16(v, d);
                 // Ext_ModifyVertex17(v, d);
                 // Ext_ModifyVertex18(v, d);
                 // Ext_ModifyVertex19(v, d);
                 // Ext_ModifyVertex20(v, d);
                 // Ext_ModifyVertex21(v, d);
                 // Ext_ModifyVertex22(v, d);
                 // Ext_ModifyVertex23(v, d);
                 // Ext_ModifyVertex24(v, d);
                 // Ext_ModifyVertex25(v, d);
                 // Ext_ModifyVertex26(v, d);
                 // Ext_ModifyVertex27(v, d);
                 // Ext_ModifyVertex28(v, d);
                 // Ext_ModifyVertex29(v, d);


                 // #if %EXTRAV2F0REQUIREKEY%
                 // v2p.extraV2F0 = d.extraV2F0;
                 // #endif

                 // #if %EXTRAV2F1REQUIREKEY%
                 // v2p.extraV2F1 = d.extraV2F1;
                 // #endif

                 // #if %EXTRAV2F2REQUIREKEY%
                 // v2p.extraV2F2 = d.extraV2F2;
                 // #endif

                 // #if %EXTRAV2F3REQUIREKEY%
                 // v2p.extraV2F3 = d.extraV2F3;
                 // #endif

                 // #if %EXTRAV2F4REQUIREKEY%
                 // v2p.extraV2F4 = d.extraV2F4;
                 // #endif

                 // #if %EXTRAV2F5REQUIREKEY%
                 // v2p.extraV2F5 = d.extraV2F5;
                 // #endif

                 // #if %EXTRAV2F6REQUIREKEY%
                 // v2p.extraV2F6 = d.extraV2F6;
                 // #endif

                 // #if %EXTRAV2F7REQUIREKEY%
                 // v2p.extraV2F7 = d.extraV2F7;
                 // #endif
            }

            void ChainModifyTessellatedVertex(inout VertexData v, inout VertexToPixel v2p)
            {
               ExtraV2F d;
               ZERO_INITIALIZE(ExtraV2F, d);
               ZERO_INITIALIZE(Blackboard, d.blackboard);

               // #if %EXTRAV2F0REQUIREKEY%
               // d.extraV2F0 = v2p.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // d.extraV2F1 = v2p.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // d.extraV2F2 = v2p.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // d.extraV2F3 = v2p.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // d.extraV2F4 = v2p.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // d.extraV2F5 = v2p.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // d.extraV2F6 = v2p.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // d.extraV2F7 = v2p.extraV2F7;
               // #endif


               // Ext_ModifyTessellatedVertex0(v, d);
               // Ext_ModifyTessellatedVertex1(v, d);
               // Ext_ModifyTessellatedVertex2(v, d);
               // Ext_ModifyTessellatedVertex3(v, d);
               // Ext_ModifyTessellatedVertex4(v, d);
               // Ext_ModifyTessellatedVertex5(v, d);
               // Ext_ModifyTessellatedVertex6(v, d);
               // Ext_ModifyTessellatedVertex7(v, d);
               // Ext_ModifyTessellatedVertex8(v, d);
               // Ext_ModifyTessellatedVertex9(v, d);
               // Ext_ModifyTessellatedVertex10(v, d);
               // Ext_ModifyTessellatedVertex11(v, d);
               // Ext_ModifyTessellatedVertex12(v, d);
               // Ext_ModifyTessellatedVertex13(v, d);
               // Ext_ModifyTessellatedVertex14(v, d);
               // Ext_ModifyTessellatedVertex15(v, d);
               // Ext_ModifyTessellatedVertex16(v, d);
               // Ext_ModifyTessellatedVertex17(v, d);
               // Ext_ModifyTessellatedVertex18(v, d);
               // Ext_ModifyTessellatedVertex19(v, d);
               // Ext_ModifyTessellatedVertex20(v, d);
               // Ext_ModifyTessellatedVertex21(v, d);
               // Ext_ModifyTessellatedVertex22(v, d);
               // Ext_ModifyTessellatedVertex23(v, d);
               // Ext_ModifyTessellatedVertex24(v, d);
               // Ext_ModifyTessellatedVertex25(v, d);
               // Ext_ModifyTessellatedVertex26(v, d);
               // Ext_ModifyTessellatedVertex27(v, d);
               // Ext_ModifyTessellatedVertex28(v, d);
               // Ext_ModifyTessellatedVertex29(v, d);

               // #if %EXTRAV2F0REQUIREKEY%
               // v2p.extraV2F0 = d.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // v2p.extraV2F1 = d.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // v2p.extraV2F2 = d.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // v2p.extraV2F3 = d.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // v2p.extraV2F4 = d.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // v2p.extraV2F5 = d.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // v2p.extraV2F6 = d.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // v2p.extraV2F7 = d.extraV2F7;
               // #endif
            }

            void ChainFinalColorForward(inout Surface l, inout ShaderData d, inout half4 color)
            {
               //   Ext_FinalColorForward0(l, d, color);
               //   Ext_FinalColorForward1(l, d, color);
               //   Ext_FinalColorForward2(l, d, color);
               //   Ext_FinalColorForward3(l, d, color);
               //   Ext_FinalColorForward4(l, d, color);
               //   Ext_FinalColorForward5(l, d, color);
               //   Ext_FinalColorForward6(l, d, color);
               //   Ext_FinalColorForward7(l, d, color);
               //   Ext_FinalColorForward8(l, d, color);
               //   Ext_FinalColorForward9(l, d, color);
               //  Ext_FinalColorForward10(l, d, color);
               //  Ext_FinalColorForward11(l, d, color);
               //  Ext_FinalColorForward12(l, d, color);
               //  Ext_FinalColorForward13(l, d, color);
               //  Ext_FinalColorForward14(l, d, color);
               //  Ext_FinalColorForward15(l, d, color);
               //  Ext_FinalColorForward16(l, d, color);
               //  Ext_FinalColorForward17(l, d, color);
               //  Ext_FinalColorForward18(l, d, color);
               //  Ext_FinalColorForward19(l, d, color);
               //  Ext_FinalColorForward20(l, d, color);
               //  Ext_FinalColorForward21(l, d, color);
               //  Ext_FinalColorForward22(l, d, color);
               //  Ext_FinalColorForward23(l, d, color);
               //  Ext_FinalColorForward24(l, d, color);
               //  Ext_FinalColorForward25(l, d, color);
               //  Ext_FinalColorForward26(l, d, color);
               //  Ext_FinalColorForward27(l, d, color);
               //  Ext_FinalColorForward28(l, d, color);
               //  Ext_FinalColorForward29(l, d, color);
            }

            void ChainFinalGBufferStandard(inout Surface s, inout ShaderData d, inout half4 GBuffer0, inout half4 GBuffer1, inout half4 GBuffer2, inout half4 outEmission, inout half4 outShadowMask)
            {
               //   Ext_FinalGBufferStandard0(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard1(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard2(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard3(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard4(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard5(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard6(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard7(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard8(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard9(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard10(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard11(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard12(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard13(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard14(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard15(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard16(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard17(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard18(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard19(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard20(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard21(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard22(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard23(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard24(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard25(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard26(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard27(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard28(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard29(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
            }



            

         ShaderData CreateShaderData(VertexToPixel i
                  #if NEED_FACING
                     , bool facing
                  #endif
         )
         {
            ShaderData d = (ShaderData)0;
            d.clipPos = i.pos;
            d.worldSpacePosition = i.worldPos;

            d.worldSpaceNormal = normalize(i.worldNormal);
            d.worldSpaceTangent = normalize(i.worldTangent.xyz);
            d.tangentSign = i.worldTangent.w;
            float3 bitangent = cross(i.worldTangent.xyz, i.worldNormal) * d.tangentSign * -1;
            

            d.TBNMatrix = float3x3(d.worldSpaceTangent, bitangent, d.worldSpaceNormal);
            d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

            d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
             d.texcoord0 = i.texcoord0;
             d.texcoord1 = i.texcoord1;
            // d.texcoord2 = i.texcoord2;

            // #if %TEXCOORD3REQUIREKEY%
             d.texcoord3 = i.texcoord3;
            // #endif

             d.isFrontFace = facing;
            // #if %VERTEXCOLORREQUIREKEY%
            // d.vertexColor = i.vertexColor;
            // #endif

            // these rarely get used, so we back transform them. Usually will be stripped.
            #if _HDRP
                // d.localSpacePosition = mul(unity_WorldToObject, float4(GetCameraRelativePositionWS(i.worldPos), 1)).xyz;
            #else
                // d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
            #endif
            // d.localSpaceNormal = normalize(mul((float3x3)unity_WorldToObject, i.worldNormal));
            // d.localSpaceTangent = normalize(mul((float3x3)unity_WorldToObject, i.worldTangent.xyz));

            // #if %SCREENPOSREQUIREKEY%
             d.screenPos = i.screenPos;
             d.screenUV = (i.screenPos.xy / i.screenPos.w);
            // #endif


            // #if %EXTRAV2F0REQUIREKEY%
            // d.extraV2F0 = i.extraV2F0;
            // #endif

            // #if %EXTRAV2F1REQUIREKEY%
            // d.extraV2F1 = i.extraV2F1;
            // #endif

            // #if %EXTRAV2F2REQUIREKEY%
            // d.extraV2F2 = i.extraV2F2;
            // #endif

            // #if %EXTRAV2F3REQUIREKEY%
            // d.extraV2F3 = i.extraV2F3;
            // #endif

            // #if %EXTRAV2F4REQUIREKEY%
            // d.extraV2F4 = i.extraV2F4;
            // #endif

            // #if %EXTRAV2F5REQUIREKEY%
            // d.extraV2F5 = i.extraV2F5;
            // #endif

            // #if %EXTRAV2F6REQUIREKEY%
            // d.extraV2F6 = i.extraV2F6;
            // #endif

            // #if %EXTRAV2F7REQUIREKEY%
            // d.extraV2F7 = i.extraV2F7;
            // #endif

            return d;
         }
         

            
         #if defined(_PASSSHADOW)
            float3 _LightDirection;
            float3 _LightPosition;
         #endif

         // vertex shader
         VertexToPixel Vert (VertexData v)
         {
           
           VertexToPixel o = (VertexToPixel)0;

           UNITY_SETUP_INSTANCE_ID(v);
           UNITY_TRANSFER_INSTANCE_ID(v, o);
           UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


#if !_TESSELLATION_ON
           ChainModifyVertex(v, o, _Time);
#endif

            o.texcoord0 = v.texcoord0;
            o.texcoord1 = v.texcoord1;
           // o.texcoord2 = v.texcoord2;

           // #if %TEXCOORD3REQUIREKEY%
            o.texcoord3 = v.texcoord3;
           // #endif

           // #if %VERTEXCOLORREQUIREKEY%
           // o.vertexColor = v.vertexColor;
           // #endif
           
           VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
           o.worldPos = TransformObjectToWorld(v.vertex.xyz);
           o.worldNormal = TransformObjectToWorldNormal(v.normal);
           o.worldTangent = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);

          // For some very odd reason, in 2021.2, we can't use Unity's defines, but have to use our own..
          #if _PASSSHADOW
              #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                 float3 lightDirectionWS = normalize(_LightPosition - o.worldPos);
              #else
                 float3 lightDirectionWS = _LightDirection;
              #endif
              // Define shadow pass specific clip position for Universal
              o.pos = TransformWorldToHClip(ApplyShadowBias(o.worldPos, o.worldNormal, lightDirectionWS));
              #if UNITY_REVERSED_Z
                  o.pos.z = min(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #else
                  o.pos.z = max(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #endif
          #elif _PASSMETA
              o.pos = MetaVertexPosition(float4(v.vertex.xyz, 0), v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
          #else
              o.pos = TransformWorldToHClip(o.worldPos);
          #endif

          // #if %SCREENPOSREQUIREKEY%
           o.screenPos = ComputeScreenPos(o.pos, _ProjectionParams.x);
          // #endif

          #if _PASSFORWARD || _PASSGBUFFER
              float2 uv1 = v.texcoord1.xy;
              OUTPUT_LIGHTMAP_UV(uv1, unity_LightmapST, o.lightmapUV);
               o.texcoord1.xy = uv1;
              OUTPUT_SH(o.worldNormal, o.sh);
              #if defined(DYNAMICLIGHTMAP_ON)
                   o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              #endif
          #endif

          #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
              half fogFactor = 0;
              #if defined(_FOG_FRAGMENT)
                fogFactor = ComputeFogFactor(o.pos.z);
              #endif
              #if _BAKEDLIT
                 o.fogFactorAndVertexLight = half4(fogFactor, 0, 0, 0);
              #else
                 half3 vertexLight = VertexLighting(o.worldPos, o.worldNormal);
                 o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
              #endif
          #endif

          #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             o.shadowCoord = GetShadowCoord(vertexInput);
          #endif

           return o;
         }


            

            // fragment shader
            half4 Frag (VertexToPixel IN
            #ifdef _DEPTHOFFSET_ON
              , out float outputDepth : SV_Depth
            #endif
            #if NEED_FACING
               , bool facing : SV_IsFrontFace
            #endif
            ) : SV_Target
            {
               UNITY_SETUP_INSTANCE_ID(IN);

               ShaderData d = CreateShaderData(IN
                  #if NEED_FACING
                     , facing
                  #endif
               );
               Surface l = (Surface)0;

               #ifdef _DEPTHOFFSET_ON
                  l.outputDepth = outputDepth;
               #endif

               l.Albedo = half3(0.5, 0.5, 0.5);
               l.Normal = float3(0,0,1);
               l.Occlusion = 1;
               l.Alpha = 1;

               ChainSurfaceFunction(l, d);

               #ifdef _DEPTHOFFSET_ON
                  outputDepth = l.outputDepth;
               #endif

             return 0;

            }

         ENDHLSL

      }


      
        Pass
        {
            Name "DepthOnly"
            Tags 
            { 
                "LightMode" = "DepthOnly"
            }
           
            // Render State
            Blend One Zero, One Zero
            Cull Back
            ZTest LEqual
            ZWrite On
            ColorMask 0
            
            

            HLSLPROGRAM

               #pragma vertex Vert
   #pragma fragment Frag


            #define _PASSDEPTH 1

            #pragma target 3.0
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            
	#pragma multi_compile_local _DIFFUSELIGHTINGSTYLE_STEPPED _DIFFUSELIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _SPECULARLIGHTINGSTYLE_BASIC _SPECULARLIGHTINGSTYLE_STEPPED _SPECULARLIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _DIFFUSETEXTUREMAPPING_SCREENSPACE _DIFFUSETEXTUREMAPPING_VIEWDIRECTION _DIFFUSETEXTUREMAPPING_SCREENSTABLE _DIFFUSETEXTUREMAPPING_WORLDSPACE _DIFFUSETEXTUREMAPPING_OBJECTSPACE
	#pragma multi_compile_local _SPECULARTEXTUREMAPPING_SCREENSPACE _SPECULARTEXTUREMAPPING_VIEWDIRECTION _SPECULARTEXTUREMAPPING_SCREENSTABLE _SPECULARTEXTUREMAPPING_WORLDSPACE _SPECULARTEXTUREMAPPING_OBJECTSPACE
	#pragma shader_feature_local _EMISSION
	#pragma shader_feature_local _REFLECTIONSENABLED_ON


   #define _URP 1

#define _UNLIT 1
#define _USINGTEXCOORD1 1
#define NEED_FACING 1
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Version.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"


                  #undef WorldNormalVector
      #define WorldNormalVector(data, normal) mul(normal, data.TBNMatrix)
      
      #define UnityObjectToWorldNormal(normal) mul(GetObjectToWorldMatrix(), normal)

      #define _WorldSpaceLightPos0 _MainLightPosition
      
      #define UNITY_DECLARE_TEX2D(name) TEXTURE2D(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2D_NOSAMPLER(name) TEXTURE2D(name);
      #define UNITY_DECLARE_TEX2DARRAY(name) TEXTURE2D_ARRAY(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(name) TEXTURE2D_ARRAY(name);

      #define UNITY_SAMPLE_TEX2DARRAY(tex,coord)            SAMPLE_TEXTURE2D_ARRAY(tex, sampler##tex, coord.xy, coord.z)
      #define UNITY_SAMPLE_TEX2DARRAY_LOD(tex,coord,lod)    SAMPLE_TEXTURE2D_ARRAY_LOD(tex, sampler##tex, coord.xy, coord.z, lod)
      #define UNITY_SAMPLE_TEX2D(tex, coord)                SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
      #define UNITY_SAMPLE_TEX2D_SAMPLER(tex, samp, coord)  SAMPLE_TEXTURE2D(tex, sampler##samp, coord)

      #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod)   SAMPLE_TEXTURE2D_LOD(tex, sampler_##tex, coord, lod)
      #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) SAMPLE_TEXTURE2D_LOD (tex, sampler##samplertex,coord, lod)
     
      #if defined(UNITY_COMPILER_HLSL)
         #define UNITY_INITIALIZE_OUTPUT(type,name) name = (type)0;
      #else
         #define UNITY_INITIALIZE_OUTPUT(type,name)
      #endif

      #define sampler2D_float sampler2D
      #define sampler2D_half sampler2D

      

      // data across stages, stripped like the above.
      struct VertexToPixel
      {
         float4 pos : SV_POSITION;
         float3 worldPos : TEXCOORD0;
         float3 worldNormal : TEXCOORD1;
         float4 worldTangent : TEXCOORD2;
          float4 texcoord0 : TEXCOORD3;
          float4 texcoord1 : TEXCOORD4;
         // float4 texcoord2 : TEXCOORD5;

         // #if %TEXCOORD3REQUIREKEY%
          float4 texcoord3 : TEXCOORD6;
         // #endif

         // #if %SCREENPOSREQUIREKEY%
          float4 screenPos : TEXCOORD7;
         // #endif

         // #if %VERTEXCOLORREQUIREKEY%
         // half4 vertexColor : COLOR;
         // #endif

         #if defined(LIGHTMAP_ON)
            float2 lightmapUV : TEXCOORD8;
         #endif
         #if defined(DYNAMICLIGHTMAP_ON)
            float2 dynamicLightmapUV : TEXCOORD9;
         #endif
         #if !defined(LIGHTMAP_ON)
            float3 sh : TEXCOORD10;
         #endif

         #if defined(VARYINGS_NEED_FOG_AND_VERTEX_LIGHT)
            float4 fogFactorAndVertexLight : TEXCOORD11;
         #endif

         #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
           float4 shadowCoord : TEXCOORD12;
         #endif

         // #if %EXTRAV2F0REQUIREKEY%
         // float4 extraV2F0 : TEXCOORD13;
         // #endif

         // #if %EXTRAV2F1REQUIREKEY%
         // float4 extraV2F1 : TEXCOORD14;
         // #endif

         // #if %EXTRAV2F2REQUIREKEY%
         // float4 extraV2F2 : TEXCOORD15;
         // #endif

         // #if %EXTRAV2F3REQUIREKEY%
         // float4 extraV2F3 : TEXCOORD16;
         // #endif

         // #if %EXTRAV2F4REQUIREKEY%
         // float4 extraV2F4 : TEXCOORD17;
         // #endif

         // #if %EXTRAV2F5REQUIREKEY%
         // float4 extraV2F5 : TEXCOORD18;
         // #endif

         // #if %EXTRAV2F6REQUIREKEY%
         // float4 extraV2F6 : TEXCOORD19;
         // #endif

         // #if %EXTRAV2F7REQUIREKEY%
         // float4 extraV2F7 : TEXCOORD20;
         // #endif

         #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
         #endif
         #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
         #endif
         #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
         #endif
         #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
         #endif
      };

         
            
            
            // data describing the user output of a pixel
            struct Surface
            {
               half3 Albedo;
               half Height;
               half3 Normal;
               half Smoothness;
               half3 Emission;
               half Metallic;
               half3 Specular;
               half Occlusion;
               half SpecularPower; // for simple lighting
               half Alpha;
               float outputDepth; // if written, SV_Depth semantic is used. ShaderData.clipPos.z is unused value
               // HDRP Only
               half SpecularOcclusion;
               half SubsurfaceMask;
               half Thickness;
               half CoatMask;
               half CoatSmoothness;
               half Anisotropy;
               half IridescenceMask;
               half IridescenceThickness;
               int DiffusionProfileHash;
               float SpecularAAThreshold;
               float SpecularAAScreenSpaceVariance;
               // requires _OVERRIDE_BAKEDGI to be defined, but is mapped in all pipelines
               float3 DiffuseGI;
               float3 BackDiffuseGI;
               float3 SpecularGI;
               // requires _OVERRIDE_SHADOWMASK to be defines
               float4 ShadowMask;
            };

            // Data the user declares in blackboard blocks
            struct Blackboard
            {
                
                float blackboardDummyData;
            };

            // data the user might need, this will grow to be big. But easy to strip
            struct ShaderData
            {
               float4 clipPos; // SV_POSITION
               float3 localSpacePosition;
               float3 localSpaceNormal;
               float3 localSpaceTangent;
        
               float3 worldSpacePosition;
               float3 worldSpaceNormal;
               float3 worldSpaceTangent;
               float tangentSign;

               float3 worldSpaceViewDir;
               float3 tangentSpaceViewDir;

               float4 texcoord0;
               float4 texcoord1;
               float4 texcoord2;
               float4 texcoord3;

               float2 screenUV;
               float4 screenPos;

               float4 vertexColor;
               bool isFrontFace;

               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;

               float3x3 TBNMatrix;
               Blackboard blackboard;
            };

            struct VertexData
            {
               #if SHADER_TARGET > 30
               // uint vertexID : SV_VertexID;
               #endif
               float4 vertex : POSITION;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;

               // optimize out mesh coords when not in use by user or lighting system
               #if _URP && (_USINGTEXCOORD1 || _PASSMETA || _PASSFORWARD || _PASSGBUFFER)
                  float4 texcoord1 : TEXCOORD1;
               #endif

               #if _URP && (_USINGTEXCOORD2 || _PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && defined(DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif

               #if _STANDARD && (_USINGTEXCOORD1 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER || _PASSFORWARDADD) && LIGHTMAP_ON)))
                  float4 texcoord1 : TEXCOORD1;
               #endif
               #if _STANDARD && (_USINGTEXCOORD2 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif


               #if _HDRP
                  float4 texcoord1 : TEXCOORD1;
                  float4 texcoord2 : TEXCOORD2;
               #endif

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD4; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity    : TEXCOORD5; // Add Precomputed Velocity (Alembic computes velocities on runtime side).
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct TessVertex 
            {
               float4 vertex : INTERNALTESSPOS;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;
               float4 texcoord1 : TEXCOORD1;
               float4 texcoord2 : TEXCOORD2;

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               // #if %EXTRAV2F0REQUIREKEY%
               // float4 extraV2F0 : TEXCOORD5;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // float4 extraV2F1 : TEXCOORD6;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // float4 extraV2F2 : TEXCOORD7;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // float4 extraV2F3 : TEXCOORD8;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // float4 extraV2F4 : TEXCOORD9;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // float4 extraV2F5 : TEXCOORD10;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // float4 extraV2F6 : TEXCOORD11;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // float4 extraV2F7 : TEXCOORD12;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD13; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity : TEXCOORD14;
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
               UNITY_VERTEX_OUTPUT_STEREO
            };

            struct ExtraV2F
            {
               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;
               Blackboard blackboard;
               float4 time;
            };


            float3 WorldToTangentSpace(ShaderData d, float3 normal)
            {
               return mul(d.TBNMatrix, normal);
            }

            float3 TangentToWorldSpace(ShaderData d, float3 normal)
            {
               return mul(normal, d.TBNMatrix);
            }

            // in this case, make standard more like SRPs, because we can't fix
            // unity_WorldToObject in HDRP, since it already does macro-fu there

            #if _STANDARD
               float3 TransformWorldToObject(float3 p) { return mul(unity_WorldToObject, float4(p, 1)); };
               float3 TransformObjectToWorld(float3 p) { return mul(unity_ObjectToWorld, float4(p, 1)); };
               float4 TransformWorldToObject(float4 p) { return mul(unity_WorldToObject, p); };
               float4 TransformObjectToWorld(float4 p) { return mul(unity_ObjectToWorld, p); };
               float4x4 GetWorldToObjectMatrix() { return unity_WorldToObject; }
               float4x4 GetObjectToWorldMatrix() { return unity_ObjectToWorld; }
               #if (defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (SHADER_TARGET_SURFACE_ANALYSIS && !SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod) tex.SampleLevel (sampler##tex,coord, lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) tex.SampleLevel (sampler##samplertex,coord, lod)
              #else
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex2D (tex,coord,0,lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) tex2D (tex,coord,0,lod)
              #endif

               #undef GetWorldToObjectMatrix()

               #define GetWorldToObjectMatrix()   unity_WorldToObject


            #endif

            float3 GetCameraWorldPosition()
            {
               #if _HDRP
                  return GetCameraRelativePositionWS(_WorldSpaceCameraPos);
               #else
                  return _WorldSpaceCameraPos;
               #endif
            }

            #if _GRABPASSUSED
               #if _STANDARD
                  TEXTURE2D(%GRABTEXTURE%);
                  SAMPLER(sampler_%GRABTEXTURE%);
               #endif

               half3 GetSceneColor(float2 uv)
               {
                  #if _STANDARD
                     return SAMPLE_TEXTURE2D(%GRABTEXTURE%, sampler_%GRABTEXTURE%, uv).rgb;
                  #else
                     return SHADERGRAPH_SAMPLE_SCENE_COLOR(uv);
                  #endif
               }
            #endif


      
            #if _STANDARD
               UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
               float GetSceneDepth(float2 uv) { return SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv)); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv)); } 
            #else
               float GetSceneDepth(float2 uv) { return SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv), _ZBufferParams); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv), _ZBufferParams); } 
            #endif

            float3 GetWorldPositionFromDepthBuffer(float2 uv, float3 worldSpaceViewDir)
            {
               float eye = GetLinearEyeDepth(uv);
               float3 camView = mul((float3x3)GetObjectToWorldMatrix(), transpose(mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V)) [2].xyz);

               float dt = dot(worldSpaceViewDir, camView);
               float3 div = worldSpaceViewDir/dt;
               float3 wpos = (eye * div) + GetCameraWorldPosition();
               return wpos;
            }

            #if _HDRP
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return GetAbsolutePositionWS(TransformObjectToWorld(pos));
            }
            #else
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return TransformObjectToWorld(pos);
            }
            #endif

            #if _STANDARD
               UNITY_DECLARE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture);
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  float4 depthNorms = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture, uv);
                  float3 norms = DecodeViewNormalStereo(depthNorms);
                  norms = mul((float3x3)GetWorldToViewMatrix(), norms) * 0.5 + 0.5;
                  return norms;
               }
            #elif _HDRP
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  NormalData nd;
                  DecodeFromNormalBuffer(_ScreenSize.xy * uv, nd);
                  return nd.normalWS;
               }
            #elif _URP
               #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                  #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
               #endif

               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                     return SampleSceneNormals(uv);
                  #else
                     float3 wpos = GetWorldPositionFromDepthBuffer(uv, worldSpaceViewDir);
                     return normalize(-cross(ddx(wpos), ddy(wpos))) * 0.5 + 0.5;
                  #endif

                }
             #endif

             #if _HDRP

               half3 UnpackNormalmapRGorAG(half4 packednormal)
               {
                     // This do the trick
                  packednormal.x *= packednormal.w;

                  half3 normal;
                  normal.xy = packednormal.xy * 2 - 1;
                  normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                  return normal;
               }
               half3 UnpackNormal(half4 packednormal)
               {
                  #if defined(UNITY_NO_DXT5nm)
                     return packednormal.xyz * 2 - 1;
                  #else
                     return UnpackNormalmapRGorAG(packednormal);
                  #endif
               }
               #endif
               #if _HDRP || _URP

               half3 UnpackScaleNormal(half4 packednormal, half scale)
               {
                 #ifndef UNITY_NO_DXT5nm
                   // Unpack normal as DXT5nm (1, y, 1, x) or BC5 (x, y, 0, 1)
                   // Note neutral texture like "bump" is (0, 0, 1, 1) to work with both plain RGB normal and DXT5nm/BC5
                   packednormal.x *= packednormal.w;
                 #endif
                   half3 normal;
                   normal.xy = (packednormal.xy * 2 - 1) * scale;
                   normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                   return normal;
               }	

             #endif


            void GetSun(out float3 lightDir, out float3 color)
            {
               lightDir = float3(0.5, 0.5, 0);
               color = 1;
               #if _HDRP
                  if (_DirectionalLightCount > 0)
                  {
                     DirectionalLightData light = _DirectionalLightDatas[0];
                     lightDir = -light.forward.xyz;
                     color = light.color;
                  }
               #elif _STANDARD
			         lightDir = normalize(_WorldSpaceLightPos0.xyz);
                  color = _LightColor0.rgb;
               #elif _URP
	               Light light = GetMainLight();
	               lightDir = light.direction;
	               color = light.color;
               #endif
            }


            
            CBUFFER_START(UnityPerMaterial)

               
	int _DiffuseLightingStyle;
	int _SpecularLightingStyle;
	int _CutoffEnabled;
	float _Cutoff;
	half4 _Color;
	float _AmbientShadowStrength;
	float _NormalMapStr;
	float4 _TilingOffset;
	int _DiffuseSteps;
	int _SpecularType;
	int _SpecularSteps;
	int _SpecularHatching;
	float2 _DiffuseEdge;
	int _DiffuseTextureMapping;
	int _ScreenStableDistanceScale;
	int _ScreenStableDistanceScaleSpec;
	float _DiffuseTextureSize;
	float _DiffuseRim;
	float2 _SpecularEdge;
	int _LinesOn;
	int _InvertShadowedLines;
	int _DiffuseHatching;
	float _DiffuseTextureContrast;
	float3 _HatchingRanges;
	float3 _HatchingRangesSpec;
	int _SpecularTextureMapping;
	float _SpecularTextureSize;
	int _KeepLinesThicc;
	float _SpecularTextureContrast;
	int _ReflectionsEnabled;
	float4 _ReflectionFresnelParams;
	float _BaseReflectStrength;
	float3 _EmissionColor;
	float _LightmapEmissionStr;
	float2 _PaintMaskEdges;



            CBUFFER_END

            

            

            #ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()


	// TODO:
	// Flip backface normals
	// Alpha cutoff support

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskMap);
	SAMPLER(sampler_MaskMap);

	TEXTURE2D(_BumpMap);
	SAMPLER(sampler_BumpMap);

	TEXTURE2D(_DiffuseTexture);
	TEXTURE2D(_SpecularTexture);

	TEXTURE2D(_EmissionTexture);
	SAMPLER(sampler_EmissionTexture);

	TEXTURE3D(_WobbleTexture);

	float invLerp(float from, float to, float value) {
		return (value - from) / (to - from);
	}

	float4 invLerp(float4 from, float4 to, float4 value) {
		return (value - from) / (to - from);
	}

	float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value){
		float rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	float4 remap(float4 origFrom, float4 origTo, float4 targetFrom, float4 targetTo, float4 value){
		float4 rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	SAMPLER(s_linear_repeat_sampler);

	void MainLight(out float3 direction, out float3 color, out float distanceAtten)
	{
		Light mainLight = GetMainLight();
		direction = mainLight.direction;
		color = mainLight.color;
		distanceAtten = mainLight.distanceAttenuation;
	}

	float ToonSharpen(float input, float edge = 0.1f)
	{
		float fw = fwidth(input)*0.5;
		return saturate(remap(edge - fw, edge + fw, 0, 1, input));
	}

	float3 Posterize(float3 input, int steps)
	{
		return round(input*steps)/steps;
	}

	float Posterize(float input, int steps)
	{
		return round(input*steps)/steps;

	}

	float Fresnel(float3 worldNormal, float3 viewAngle, float exp = 4)
	{
		return 1 - pow(abs(dot(worldNormal, viewAngle)),exp);
	}

	float MainLightShadows(float3 worldPos, float2 lightmapUV = float2(0.0,0.0))
	{
		float4 shadowCoord = TransformWorldToShadowCoord(worldPos);

		#if !defined (LIGHTMAP_ON) || defined(_LIGHTINGTYPE_VERTEX)
			half4 shadowMask = unity_ProbesOcclusion;
		#else
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half4 shadowMask = SAMPLE_SHADOWMASK(lightmapUV);
		#endif

		return ToonSharpen(MainLightShadow(shadowCoord, worldPos, shadowMask, _MainLightOcclusionProbes), 0.5f);
	}

	float3 GetAmbient(float3 worldNormal, float2 lightmapUV)
	{
		#ifdef LIGHTMAP_ON
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half3 bakedGI = SampleLightmap(lightmapUV, worldNormal);

			#if defined(_MIXED_LIGHTING_SUBTRACTIVE)
				Light mainLight = GetMainLight();
				bakedGI = SubtractDirectMainLightFromLightmap(mainLight, worldNormal, bakedGI);
			#endif

			return bakedGI;
		#else
			return SampleSH(worldNormal);
		#endif
	}

	float3 GetReflections(float3 worldNormal, float3 viewDir, float smoothness)
	{
		float perceptualRoughness = 1 - smoothness;
		perceptualRoughness *= perceptualRoughness;
		float mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
		float3 sample = SHADERGRAPH_REFLECTION_PROBE(viewDir, worldNormal, mip);
		return sample.rgb;
	}

	void SSAO(ShaderData d, out float directOcclusion, out float indirectOcclusion)
	{
		#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(ALPHABLEND)
			float2 uv = d.screenUV;

			AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(uv);
			directOcclusion = aoFactor.directAmbientOcclusion;
			indirectOcclusion = aoFactor.indirectAmbientOcclusion;
		#else
			directOcclusion = 1;
			indirectOcclusion = 1;
		#endif
	}

	half3 Triplanar(Texture2D tex, half3 samplePos, half3 normal, float size)
	{
		half2 uvX = samplePos.zy;
		half2 uvY = samplePos.xz + 0.67;
		half2 uvZ = samplePos.xy + 0.33;

		half3 lx = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvX / size).rgb;
		half3 ly = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvY / size).rgb;
		half3 lz = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvZ / size).rgb;

		float3 blend = pow(abs(normal),4);
		blend /= dot(blend, float3(1,1,1));

		return lx * blend.x + ly * blend.y + lz * blend.z;
	}

	half3 ViewDirLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float3 objPos = TransformObjectToWorld(0);
		float dist = distance(objPos, _WorldSpaceCameraPos);

		float3 samplePos = d.worldSpaceViewDir - _WorldSpaceCameraPos/dist;

		return Triplanar(tex, samplePos, d.worldSpaceViewDir, size);
	}

	half3 ScreenStableLightingTexture(ShaderData d, Texture2D tex, float size, int screenStableDistScale)
	{
		float3 objPos = TransformObjectToWorld(0);

		float dist = 3;

		if (screenStableDistScale)
			dist = distance(_WorldSpaceCameraPos, objPos);

		float4 clipPos = TransformObjectToHClip(TransformWorldToObject(d.worldSpacePosition));
		clipPos = ComputeScreenPos(clipPos);
		clipPos.xy /= clipPos.w;

		float4 objClipPos = TransformWorldToHClip(objPos);
		objClipPos = ComputeScreenPos(objClipPos);
		objClipPos.xy /= objClipPos.w;

		float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
		objClipPos.xy *= screenratio;
		clipPos.xy *= screenratio; 

		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, (clipPos.rg - objClipPos.rg) * size * dist).rgb;
	}

	half3 WorldSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, d.worldSpacePosition, d.worldSpaceNormal, size);
	}

	half3 ObjectSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, TransformWorldToObject(d.worldSpacePosition), TransformWorldToObject(d.worldSpaceNormal), size);
	}

	half3 ScreenSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float screenratio = _ScreenParams.x / _ScreenParams.y;
		float2 uv = d.screenUV;
		uv.x *= screenratio;
		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uv / size).rgb;
	}

	float TexturedDiffuse(float3 lightingTex, float inputDiffuse, float lightStr = 1, bool mainLight = false)
	{
		lightingTex = pow(abs(lightingTex), _DiffuseTextureContrast);
		float origDiffuse = inputDiffuse;
		if (mainLight)
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse));
		else
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse*lightStr));

		UNITY_BRANCH
		if (_DiffuseHatching == 0)
		{	
			origDiffuse = ToonSharpen(max(1 - lightingTex.r,0.025), 1 - origDiffuse);
		}
		else
		{
			lightingTex = max(1 - lightingTex,0.01);
			float3 hatchDiffuse = origDiffuse;
			hatchDiffuse.r = smoothstep(0, _HatchingRanges.r, origDiffuse);
			hatchDiffuse.g = smoothstep(0, _HatchingRanges.g, origDiffuse);
			hatchDiffuse.b = smoothstep(0, _HatchingRanges.b, origDiffuse);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchDiffuse.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchDiffuse.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchDiffuse.b);

			float combined = min(min(lightingTex.r, lightingTex.g),lightingTex.b);
			origDiffuse = ToonSharpen(combined, 1 - origDiffuse)*lightStr;
		}
		return origDiffuse;
	}

	float TexturedSpecular(float3 lightingTex, float inputSpec, float lightStr = 1)
	{
		
		lightingTex = pow(abs(lightingTex), _SpecularTextureContrast);
		//lightingTex -= 0.15;
		float origSpecular = smoothstep(_SpecularEdge.x, _SpecularEdge.y, saturate(inputSpec*lightStr*0.5));

		UNITY_BRANCH
		if (_SpecularHatching == 0)
		{	
			origSpecular = 1 - smoothstep(0, origSpecular, ToonSharpen(1 - lightingTex.r, origSpecular));
		}
		else
		{
			lightingTex = 1 - lightingTex;
			float3 hatchSpec = origSpecular;
			hatchSpec.r = smoothstep(1 - _HatchingRangesSpec.r, 1, origSpecular);
			hatchSpec.g = smoothstep(1 - _HatchingRangesSpec.g, 1, origSpecular);
			hatchSpec.b = smoothstep(1 - _HatchingRangesSpec.b, 1, origSpecular);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchSpec.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchSpec.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchSpec.b);

			float combined = max(max(lightingTex.r, lightingTex.g),lightingTex.b);
			origSpecular = smoothstep(0, origSpecular, combined);
		}
		return origSpecular;
	}

	float GetDiffuse(float3 lightingTex, Light l, ShaderData d, Surface o, bool mainLight = false, float lineArt = 1)
	{
		float diffuse = saturate(dot(l.direction, d.worldSpaceNormal));
		
		#if defined(_DIFFUSELIGHTINGSTYLE_STEPPED)
			diffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, diffuse);
			diffuse *= length(l.color);
			diffuse *= l.shadowAttenuation * saturate(l.distanceAttenuation);
			if (_DiffuseSteps > 1)
			{
				
				float origDiffuse = diffuse;
				float powLerpFactor = saturate(invLerp(1, 12, _DiffuseSteps));
				float powFactor = lerp(0.5, 1, powLerpFactor);

				diffuse = Posterize(pow(abs(diffuse), powFactor), _DiffuseSteps);

			}
			else
				diffuse = ToonSharpen(diffuse,0.075);

			diffuse /= length(l.color);
		#elif defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			diffuse *= l.shadowAttenuation * l.distanceAttenuation;
			diffuse = TexturedDiffuse(lightingTex, diffuse, length(l.color), mainLight);
		#endif

		UNITY_BRANCH
		if (_DiffuseRim*lineArt*l.shadowAttenuation*l.distanceAttenuation > 0)
		{
			float rim = Fresnel(d.worldSpaceNormal, d.worldSpaceViewDir);
			float mainLightAlignment = saturate(-dot(d.worldSpaceViewDir, l.direction));
			
			float rimSize = lerp(1.0, 0.9, _DiffuseRim*l.distanceAttenuation*l.distanceAttenuation);

			rim = ToonSharpen(rim,lerp(1.01, rimSize, mainLightAlignment)) * ToonSharpen(mainLightAlignment);
			diffuse = max(diffuse, rim);
		}

		return diffuse;
	}
	
	float GetSpecular(float3 lightingTex, Light l, ShaderData d, Surface o)
	{
		float baseSpec = 0;
		float SpecSmoothness = exp2(10 * o.Smoothness + 1).x;

		[branch]
		if (_SpecularType == 0) //Cook-Torrance
		{
			float roughness = 1 - o.Smoothness;
			roughness *= roughness;

			float3 h = SafeNormalize(l.direction + d.worldSpaceViewDir);
			float nh = saturate(dot(d.worldSpaceNormal, h));
			float lh = saturate(dot(l.direction, h));
			float d = nh * nh * (roughness * roughness - 1.0) + 1.00001;
			float normTerm = roughness * 4.0 + 2.0;
			float specTerm = roughness * roughness;
			specTerm /= (d * d) * max(0.1, lh * lh) * normTerm;
			baseSpec = specTerm*0.04;
		}
		else if (_SpecularType == 1) //Phong
		{
			float3 r = reflect(-l.direction, d.worldSpaceNormal);
			float rdotv = max(0, dot(r, d.worldSpaceViewDir));

			baseSpec = pow(rdotv, SpecSmoothness)*o.Smoothness;
		}
		else if (_SpecularType == 2) //Blinn-Phong
		{
			float3 h = SafeNormalize(l.direction+d.worldSpaceViewDir);
			float ndh = saturate(dot(d.worldSpaceNormal, h));

			baseSpec = pow(ndh, SpecSmoothness)*o.Smoothness;
		}
		else
		{
			return 0;
		}

		

		#if defined(_SPECULARLIGHTINGSTYLE_BASIC)
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation * length(l.color);
			baseSpec = smoothstep(_SpecularEdge.x,_SpecularEdge.y, baseSpec);
			baseSpec /= length(l.color);
		#elif defined(_SPECULARLIGHTINGSTYLE_STEPPED)
			baseSpec *= saturate(l.distanceAttenuation) * l.shadowAttenuation;
			baseSpec *= length(l.color);
			baseSpec = Posterize(baseSpec, max(1,_SpecularSteps));
			baseSpec /= length(l.color);
		#else
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation;
			baseSpec = TexturedSpecular(lightingTex, baseSpec, length(l.color));
		#endif	

		
		return baseSpec;
	}

	void Ext_ModifyVertex0 (inout VertexData v, inout ExtraV2F d)
	{
		v.texcoord0.xy = v.texcoord0.xy * _TilingOffset.xy + _TilingOffset.zw;

		if (_DiffuseTextureMapping == 2)
		{
			float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
			clipPos.xy /= clipPos.w;  

			float3 objPos = TransformObjectToWorld(0);
			float camDist = distance(objPos, _WorldSpaceCameraPos);
			float4 objClipPos = TransformWorldToHClip(objPos);
			objClipPos.xy /= objClipPos.w;

			float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
			objClipPos.xy *= screenratio;
			clipPos.xy *= screenratio;

			v.texcoord3 = (clipPos - objClipPos); 
		}
	}

	void Ext_SurfaceFunction0 (inout Surface o, ShaderData d)
	{
		
		// Handle input data
		float4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, d.texcoord0.xy);
		float4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, d.texcoord0.xy);
		o.Normal = UnpackScaleNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, d.texcoord0.xy), _NormalMapStr);
		d.worldSpaceNormal = TransformTangentToWorld(o.Normal, d.TBNMatrix);

		float diffuseColorMult = 1.0f;
		float specColorMult = 1.0f;

		if (_DiffuseLightingStyle == 1)
			diffuseColorMult = 0.5f;

		if (_SpecularLightingStyle = 2)
			specColorMult = 0.5f;

		if (!d.isFrontFace)
		{
			d.worldSpaceNormal *= -1;
		}

		o.Metallic = masks.r;
		o.Smoothness = masks.g;
		o.Alpha = baseColor.a * _Color.a;

		if (_CutoffEnabled)
			clip(o.Alpha - _Cutoff);

		o.Occlusion = 1;
		float3 specColor = 1;
		float paintmask = masks.b;

		float3 paintedColor = baseColor.rgb * _Color.rgb;
		baseColor.rgb = lerp(baseColor.rgb, paintedColor, smoothstep(_PaintMaskEdges.x, _PaintMaskEdges.y, paintmask));

		#if defined(_EMISSION)
			o.Emission = SAMPLE_TEXTURE2D(_EmissionTexture, sampler_EmissionTexture, d.texcoord0).rgb * _EmissionColor;
		#endif

		half lines = 1;
		half origlines = 1;
		float lineCutoff = 0.5;

		#if defined(LIGHTMAP_ON)
			half4 shadowMask = SAMPLE_SHADOWMASK(d.texcoord1.xy);
		#else
			half4 shadowMask = unity_ProbesOcclusion;
		#endif

		// -------------
		// LINE ART
		// -------------
		UNITY_BRANCH
		if (_LinesOn)
		{
			UNITY_BRANCH
			if (_KeepLinesThicc)
			{
				float dist = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
				float fresnel = pow(abs(dot(d.worldSpaceNormal, d.worldSpaceViewDir)),3);
				lineCutoff = lerp(0.5, 0.95, max(saturate(dist*0.2), fresnel));
			}
			lines = 1 - masks.a;

			 // Save original lines to use if ambient is raised
		}

		#ifdef _DBUFFER
			ApplyDecal(d.clipPos, baseColor.rgb, specColor, d.worldSpaceNormal, o.Metallic, lines, o.Smoothness);
		#endif

		if (_LinesOn)
		{
			lines = ToonSharpen(lines, lineCutoff);
			origlines = lines;
		}
		else
		{
			lines = 1;
		}

		// Store lighting values in these
		float3 mainLightDir;
		float3 mainLightCol;
		float mainLightAtten;
		MainLight(mainLightDir, mainLightCol, mainLightAtten);

		float2 lightmapUV = d.texcoord1.xy;

		float mainShadows = MainLightShadows(d.worldSpacePosition, lightmapUV);
		float3 ambient = GetAmbient(d.worldSpaceNormal, lightmapUV) * baseColor.rgb;

		Light mainLight = GetMainLight();

		#if   defined(_DIFFUSETEXTUREMAPPING_SCREENSPACE)
			float3 diffuseLightingTex = ScreenSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_VIEWDIRECTION)
			float3 diffuseLightingTex = ViewDirLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_SCREENSTABLE)
			float3 diffuseLightingTex = ScreenStableLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize, _ScreenStableDistanceScale);
		#elif defined(_DIFFUSETEXTUREMAPPING_WORLDSPACE)
			float3 diffuseLightingTex = WorldSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_OBJECTSPACE)
			float3 diffuseLightingTex = ObjectSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#endif

		#if   defined(_SPECULARTEXTUREMAPPING_SCREENSPACE)
			float3 specLightingTex = ScreenSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_VIEWDIRECTION)
			float3 specLightingTex = ViewDirLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_SCREENSTABLE)
			float3 specLightingTex = ScreenStableLightingTexture(d, _SpecularTexture, _SpecularTextureSize, _ScreenStableDistanceScale);
		#elif defined(_SPECULARTEXTUREMAPPING_WORLDSPACE)
			float3 specLightingTex = WorldSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_OBJECTSPACE)
			float3 specLightingTex = ObjectSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#endif
		

		float indirOcclusion, directOcclusion;
		SSAO(d, directOcclusion, indirOcclusion);

		#if defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			directOcclusion = TexturedDiffuse(diffuseLightingTex, directOcclusion);
			//indirOcclusion = TexturedDiffuse(diffuseLightingTex, indirOcclusion);
			ambient = min(indirOcclusion, ambient);
		#endif

		float mainDiffuseFactor = GetDiffuse(diffuseLightingTex, mainLight, d, o, true, lines)*directOcclusion*diffuseColorMult;
		mainDiffuseFactor *= mainShadows;
		float mainSpecFactor = GetSpecular(specLightingTex, mainLight, d, o) * specColorMult;
		
		float3 addLightDiffuse = 0;
		float3 addLightSpecular = 0;
		// -------------
		// ADDITIONALLIGHTS
		// -------------
		int pixelLights = GetAdditionalLightsCount();
		for (int i = 0; i < pixelLights; ++i)
		{
			Light light = GetAdditionalLight(i, d.worldSpacePosition, shadowMask);

			float diffuse = GetDiffuse(diffuseLightingTex, light, d, o, false, lines) * diffuseColorMult;
			float specular = GetSpecular(specLightingTex, light, d, o) * specColorMult;

			addLightDiffuse += diffuse * light.color;
			addLightSpecular += specular * light.color;
		}
		
		float diffuseDarkest = ToonSharpen(length(addLightDiffuse)+saturate(mainDiffuseFactor*length(mainLight.color)),0.025);

		// -------------
		// REFLECTIONS
		// -------------
		float3 reflections = 0;
		
		#if defined(_REFLECTIONSENABLED_ON)
			float reflectStr = 0.04*_BaseReflectStrength*2;;
			reflections = GetReflections(d.worldSpaceNormal, d.worldSpaceViewDir, o.Smoothness);
			float perceptualRoughness = (1 - o.Smoothness);
			perceptualRoughness *= perceptualRoughness;		

			float fresnel = pow(1.0 - saturate(dot(d.worldSpaceNormal, d.worldSpaceViewDir)-_ReflectionFresnelParams.y), _ReflectionFresnelParams.x*16);
			fresnel = smoothstep(_ReflectionFresnelParams.w*0.5, 1 - _ReflectionFresnelParams.w*0.5, fresnel);
			reflectStr = lerp(reflectStr, clamp(0, 2, 0.04*_ReflectionFresnelParams.z*50), fresnel);

			reflections *= reflectStr;
			reflections /= perceptualRoughness + 0.5;

			reflections = lerp(reflections, reflections * baseColor.rgb, o.Metallic);
		#endif
		
		#if defined(ALPHABLEND) && !defined(_PASSMETA)

			if (_OpaqueLines)
				o.Alpha = max(o.Alpha, 1 - lines);

			UNITY_BRANCH
			if (_PreserveSpec)
			{
				o.Alpha = max(Luminance(reflections), o.Alpha);
				o.Alpha = max(mainSpecFactor, o.Alpha);
				o.Alpha = max(addLightSpecular, o.Alpha);
			}

			float3 refractionCol = 0;
			float origAlpha = o.Alpha;
			UNITY_BRANCH
			if (_Refraction)
			{
				float4 offsetPos = float4(d.worldSpacePosition + d.worldSpaceNormal * _RefractionStr, 1.0);
				offsetPos = mul(GetWorldToHClipMatrix(), offsetPos);
				float scale = 1.0;

				#if UNITY_UV_STARTS_AT_TOP
					scale = -1.0;
				#endif

				float4 grabPos = offsetPos *0.5f;
				grabPos.xy = float2(grabPos.x, grabPos.y*scale) + grabPos.w;
				grabPos.zw = offsetPos.zw;
				grabPos.xy /= grabPos.w;
				grabPos.xy = saturate(grabPos.xy);

				float3 refraction = GetSceneColor(grabPos.xy);
				refractionCol = refraction;
				if (_RefractionTint)
					refraction *= baseColor.rgb;

				_RefractionEdge = 1 - _RefractionEdge;
				if (_RefractionEdge > 0)
				{
					float2 cubemapBlendFactors = pow(abs((grabPos.xy - 0.5) * 2.0),0.25);
					float blend = smoothstep(_RefractionEdge, 1, max(cubemapBlendFactors.x, cubemapBlendFactors.y));
					float3 refractDir = refract(-d.worldSpaceViewDir, d.worldSpaceNormal, 1 - _RefractionStr);
					float3 reflectProbe = GetReflections(-refractDir, refractDir, 1.0);
					
					refractionCol = lerp(refraction, reflectProbe, blend);
				}
				
				o.Alpha = 1;
			}

		#endif		

		float3 mainSpec = mainSpecFactor * mainLightCol;
		float3 mainDiffuse = mainDiffuseFactor * mainLightCol;

		addLightSpecular = lerp(addLightSpecular, addLightSpecular * baseColor.rgb, o.Metallic);
		mainSpec = lerp(mainSpec, mainSpec * specColor, o.Metallic);

		lines = lerp(1 - lines, lines, diffuseDarkest);
		
		if (_InvertShadowedLines)
			diffuseDarkest = lerp(diffuseDarkest, 1, lines);

		o.Albedo = baseColor.rgb;
		o.Emission *= _LightmapEmissionStr;
		#if !defined(_PASSMETA)
			o.Albedo *= mainDiffuse * lines;
			o.Albedo += reflections* mainDiffuse *lines;
			o.Albedo += addLightDiffuse * lines * baseColor.rgb + addLightSpecular * lines;
			o.Albedo += mainSpec * mainDiffuse * mainShadows * lines;
			
			o.Albedo += lerp(ambient*diffuseDarkest * lines, ambient*origlines, _AmbientShadowStrength);
			#if defined(ALPHABLEND)
				if (_Refraction)
				{
					o.Albedo = lerp(refractionCol, o.Albedo, origAlpha);
				}
			#endif
			o.Albedo += o.Emission;
		#endif
	}




        
            void ChainSurfaceFunction(inout Surface l, inout ShaderData d)
            {
                  Ext_SurfaceFunction0(l, d);
                 // Ext_SurfaceFunction1(l, d);
                 // Ext_SurfaceFunction2(l, d);
                 // Ext_SurfaceFunction3(l, d);
                 // Ext_SurfaceFunction4(l, d);
                 // Ext_SurfaceFunction5(l, d);
                 // Ext_SurfaceFunction6(l, d);
                 // Ext_SurfaceFunction7(l, d);
                 // Ext_SurfaceFunction8(l, d);
                 // Ext_SurfaceFunction9(l, d);
		           // Ext_SurfaceFunction10(l, d);
                 // Ext_SurfaceFunction11(l, d);
                 // Ext_SurfaceFunction12(l, d);
                 // Ext_SurfaceFunction13(l, d);
                 // Ext_SurfaceFunction14(l, d);
                 // Ext_SurfaceFunction15(l, d);
                 // Ext_SurfaceFunction16(l, d);
                 // Ext_SurfaceFunction17(l, d);
                 // Ext_SurfaceFunction18(l, d);
		           // Ext_SurfaceFunction19(l, d);
                 // Ext_SurfaceFunction20(l, d);
                 // Ext_SurfaceFunction21(l, d);
                 // Ext_SurfaceFunction22(l, d);
                 // Ext_SurfaceFunction23(l, d);
                 // Ext_SurfaceFunction24(l, d);
                 // Ext_SurfaceFunction25(l, d);
                 // Ext_SurfaceFunction26(l, d);
                 // Ext_SurfaceFunction27(l, d);
                 // Ext_SurfaceFunction28(l, d);
		           // Ext_SurfaceFunction29(l, d);
            }

            void ChainModifyVertex(inout VertexData v, inout VertexToPixel v2p, float4 time)
            {
                 ExtraV2F d;
                 
                 ZERO_INITIALIZE(ExtraV2F, d);
                 ZERO_INITIALIZE(Blackboard, d.blackboard);
                 // due to motion vectors in HDRP, we need to use the last
                 // time in certain spots. So if you are going to use _Time to adjust vertices,
                 // you need to use this time or motion vectors will break. 
                 d.time = time;

                   Ext_ModifyVertex0(v, d);
                 // Ext_ModifyVertex1(v, d);
                 // Ext_ModifyVertex2(v, d);
                 // Ext_ModifyVertex3(v, d);
                 // Ext_ModifyVertex4(v, d);
                 // Ext_ModifyVertex5(v, d);
                 // Ext_ModifyVertex6(v, d);
                 // Ext_ModifyVertex7(v, d);
                 // Ext_ModifyVertex8(v, d);
                 // Ext_ModifyVertex9(v, d);
                 // Ext_ModifyVertex10(v, d);
                 // Ext_ModifyVertex11(v, d);
                 // Ext_ModifyVertex12(v, d);
                 // Ext_ModifyVertex13(v, d);
                 // Ext_ModifyVertex14(v, d);
                 // Ext_ModifyVertex15(v, d);
                 // Ext_ModifyVertex16(v, d);
                 // Ext_ModifyVertex17(v, d);
                 // Ext_ModifyVertex18(v, d);
                 // Ext_ModifyVertex19(v, d);
                 // Ext_ModifyVertex20(v, d);
                 // Ext_ModifyVertex21(v, d);
                 // Ext_ModifyVertex22(v, d);
                 // Ext_ModifyVertex23(v, d);
                 // Ext_ModifyVertex24(v, d);
                 // Ext_ModifyVertex25(v, d);
                 // Ext_ModifyVertex26(v, d);
                 // Ext_ModifyVertex27(v, d);
                 // Ext_ModifyVertex28(v, d);
                 // Ext_ModifyVertex29(v, d);


                 // #if %EXTRAV2F0REQUIREKEY%
                 // v2p.extraV2F0 = d.extraV2F0;
                 // #endif

                 // #if %EXTRAV2F1REQUIREKEY%
                 // v2p.extraV2F1 = d.extraV2F1;
                 // #endif

                 // #if %EXTRAV2F2REQUIREKEY%
                 // v2p.extraV2F2 = d.extraV2F2;
                 // #endif

                 // #if %EXTRAV2F3REQUIREKEY%
                 // v2p.extraV2F3 = d.extraV2F3;
                 // #endif

                 // #if %EXTRAV2F4REQUIREKEY%
                 // v2p.extraV2F4 = d.extraV2F4;
                 // #endif

                 // #if %EXTRAV2F5REQUIREKEY%
                 // v2p.extraV2F5 = d.extraV2F5;
                 // #endif

                 // #if %EXTRAV2F6REQUIREKEY%
                 // v2p.extraV2F6 = d.extraV2F6;
                 // #endif

                 // #if %EXTRAV2F7REQUIREKEY%
                 // v2p.extraV2F7 = d.extraV2F7;
                 // #endif
            }

            void ChainModifyTessellatedVertex(inout VertexData v, inout VertexToPixel v2p)
            {
               ExtraV2F d;
               ZERO_INITIALIZE(ExtraV2F, d);
               ZERO_INITIALIZE(Blackboard, d.blackboard);

               // #if %EXTRAV2F0REQUIREKEY%
               // d.extraV2F0 = v2p.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // d.extraV2F1 = v2p.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // d.extraV2F2 = v2p.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // d.extraV2F3 = v2p.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // d.extraV2F4 = v2p.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // d.extraV2F5 = v2p.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // d.extraV2F6 = v2p.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // d.extraV2F7 = v2p.extraV2F7;
               // #endif


               // Ext_ModifyTessellatedVertex0(v, d);
               // Ext_ModifyTessellatedVertex1(v, d);
               // Ext_ModifyTessellatedVertex2(v, d);
               // Ext_ModifyTessellatedVertex3(v, d);
               // Ext_ModifyTessellatedVertex4(v, d);
               // Ext_ModifyTessellatedVertex5(v, d);
               // Ext_ModifyTessellatedVertex6(v, d);
               // Ext_ModifyTessellatedVertex7(v, d);
               // Ext_ModifyTessellatedVertex8(v, d);
               // Ext_ModifyTessellatedVertex9(v, d);
               // Ext_ModifyTessellatedVertex10(v, d);
               // Ext_ModifyTessellatedVertex11(v, d);
               // Ext_ModifyTessellatedVertex12(v, d);
               // Ext_ModifyTessellatedVertex13(v, d);
               // Ext_ModifyTessellatedVertex14(v, d);
               // Ext_ModifyTessellatedVertex15(v, d);
               // Ext_ModifyTessellatedVertex16(v, d);
               // Ext_ModifyTessellatedVertex17(v, d);
               // Ext_ModifyTessellatedVertex18(v, d);
               // Ext_ModifyTessellatedVertex19(v, d);
               // Ext_ModifyTessellatedVertex20(v, d);
               // Ext_ModifyTessellatedVertex21(v, d);
               // Ext_ModifyTessellatedVertex22(v, d);
               // Ext_ModifyTessellatedVertex23(v, d);
               // Ext_ModifyTessellatedVertex24(v, d);
               // Ext_ModifyTessellatedVertex25(v, d);
               // Ext_ModifyTessellatedVertex26(v, d);
               // Ext_ModifyTessellatedVertex27(v, d);
               // Ext_ModifyTessellatedVertex28(v, d);
               // Ext_ModifyTessellatedVertex29(v, d);

               // #if %EXTRAV2F0REQUIREKEY%
               // v2p.extraV2F0 = d.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // v2p.extraV2F1 = d.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // v2p.extraV2F2 = d.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // v2p.extraV2F3 = d.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // v2p.extraV2F4 = d.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // v2p.extraV2F5 = d.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // v2p.extraV2F6 = d.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // v2p.extraV2F7 = d.extraV2F7;
               // #endif
            }

            void ChainFinalColorForward(inout Surface l, inout ShaderData d, inout half4 color)
            {
               //   Ext_FinalColorForward0(l, d, color);
               //   Ext_FinalColorForward1(l, d, color);
               //   Ext_FinalColorForward2(l, d, color);
               //   Ext_FinalColorForward3(l, d, color);
               //   Ext_FinalColorForward4(l, d, color);
               //   Ext_FinalColorForward5(l, d, color);
               //   Ext_FinalColorForward6(l, d, color);
               //   Ext_FinalColorForward7(l, d, color);
               //   Ext_FinalColorForward8(l, d, color);
               //   Ext_FinalColorForward9(l, d, color);
               //  Ext_FinalColorForward10(l, d, color);
               //  Ext_FinalColorForward11(l, d, color);
               //  Ext_FinalColorForward12(l, d, color);
               //  Ext_FinalColorForward13(l, d, color);
               //  Ext_FinalColorForward14(l, d, color);
               //  Ext_FinalColorForward15(l, d, color);
               //  Ext_FinalColorForward16(l, d, color);
               //  Ext_FinalColorForward17(l, d, color);
               //  Ext_FinalColorForward18(l, d, color);
               //  Ext_FinalColorForward19(l, d, color);
               //  Ext_FinalColorForward20(l, d, color);
               //  Ext_FinalColorForward21(l, d, color);
               //  Ext_FinalColorForward22(l, d, color);
               //  Ext_FinalColorForward23(l, d, color);
               //  Ext_FinalColorForward24(l, d, color);
               //  Ext_FinalColorForward25(l, d, color);
               //  Ext_FinalColorForward26(l, d, color);
               //  Ext_FinalColorForward27(l, d, color);
               //  Ext_FinalColorForward28(l, d, color);
               //  Ext_FinalColorForward29(l, d, color);
            }

            void ChainFinalGBufferStandard(inout Surface s, inout ShaderData d, inout half4 GBuffer0, inout half4 GBuffer1, inout half4 GBuffer2, inout half4 outEmission, inout half4 outShadowMask)
            {
               //   Ext_FinalGBufferStandard0(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard1(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard2(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard3(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard4(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard5(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard6(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard7(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard8(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard9(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard10(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard11(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard12(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard13(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard14(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard15(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard16(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard17(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard18(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard19(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard20(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard21(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard22(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard23(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard24(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard25(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard26(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard27(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard28(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard29(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
            }



            

         ShaderData CreateShaderData(VertexToPixel i
                  #if NEED_FACING
                     , bool facing
                  #endif
         )
         {
            ShaderData d = (ShaderData)0;
            d.clipPos = i.pos;
            d.worldSpacePosition = i.worldPos;

            d.worldSpaceNormal = normalize(i.worldNormal);
            d.worldSpaceTangent = normalize(i.worldTangent.xyz);
            d.tangentSign = i.worldTangent.w;
            float3 bitangent = cross(i.worldTangent.xyz, i.worldNormal) * d.tangentSign * -1;
            

            d.TBNMatrix = float3x3(d.worldSpaceTangent, bitangent, d.worldSpaceNormal);
            d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

            d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
             d.texcoord0 = i.texcoord0;
             d.texcoord1 = i.texcoord1;
            // d.texcoord2 = i.texcoord2;

            // #if %TEXCOORD3REQUIREKEY%
             d.texcoord3 = i.texcoord3;
            // #endif

             d.isFrontFace = facing;
            // #if %VERTEXCOLORREQUIREKEY%
            // d.vertexColor = i.vertexColor;
            // #endif

            // these rarely get used, so we back transform them. Usually will be stripped.
            #if _HDRP
                // d.localSpacePosition = mul(unity_WorldToObject, float4(GetCameraRelativePositionWS(i.worldPos), 1)).xyz;
            #else
                // d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
            #endif
            // d.localSpaceNormal = normalize(mul((float3x3)unity_WorldToObject, i.worldNormal));
            // d.localSpaceTangent = normalize(mul((float3x3)unity_WorldToObject, i.worldTangent.xyz));

            // #if %SCREENPOSREQUIREKEY%
             d.screenPos = i.screenPos;
             d.screenUV = (i.screenPos.xy / i.screenPos.w);
            // #endif


            // #if %EXTRAV2F0REQUIREKEY%
            // d.extraV2F0 = i.extraV2F0;
            // #endif

            // #if %EXTRAV2F1REQUIREKEY%
            // d.extraV2F1 = i.extraV2F1;
            // #endif

            // #if %EXTRAV2F2REQUIREKEY%
            // d.extraV2F2 = i.extraV2F2;
            // #endif

            // #if %EXTRAV2F3REQUIREKEY%
            // d.extraV2F3 = i.extraV2F3;
            // #endif

            // #if %EXTRAV2F4REQUIREKEY%
            // d.extraV2F4 = i.extraV2F4;
            // #endif

            // #if %EXTRAV2F5REQUIREKEY%
            // d.extraV2F5 = i.extraV2F5;
            // #endif

            // #if %EXTRAV2F6REQUIREKEY%
            // d.extraV2F6 = i.extraV2F6;
            // #endif

            // #if %EXTRAV2F7REQUIREKEY%
            // d.extraV2F7 = i.extraV2F7;
            // #endif

            return d;
         }
         

            
         #if defined(_PASSSHADOW)
            float3 _LightDirection;
            float3 _LightPosition;
         #endif

         // vertex shader
         VertexToPixel Vert (VertexData v)
         {
           
           VertexToPixel o = (VertexToPixel)0;

           UNITY_SETUP_INSTANCE_ID(v);
           UNITY_TRANSFER_INSTANCE_ID(v, o);
           UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


#if !_TESSELLATION_ON
           ChainModifyVertex(v, o, _Time);
#endif

            o.texcoord0 = v.texcoord0;
            o.texcoord1 = v.texcoord1;
           // o.texcoord2 = v.texcoord2;

           // #if %TEXCOORD3REQUIREKEY%
            o.texcoord3 = v.texcoord3;
           // #endif

           // #if %VERTEXCOLORREQUIREKEY%
           // o.vertexColor = v.vertexColor;
           // #endif
           
           VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
           o.worldPos = TransformObjectToWorld(v.vertex.xyz);
           o.worldNormal = TransformObjectToWorldNormal(v.normal);
           o.worldTangent = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);

          // For some very odd reason, in 2021.2, we can't use Unity's defines, but have to use our own..
          #if _PASSSHADOW
              #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                 float3 lightDirectionWS = normalize(_LightPosition - o.worldPos);
              #else
                 float3 lightDirectionWS = _LightDirection;
              #endif
              // Define shadow pass specific clip position for Universal
              o.pos = TransformWorldToHClip(ApplyShadowBias(o.worldPos, o.worldNormal, lightDirectionWS));
              #if UNITY_REVERSED_Z
                  o.pos.z = min(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #else
                  o.pos.z = max(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #endif
          #elif _PASSMETA
              o.pos = MetaVertexPosition(float4(v.vertex.xyz, 0), v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
          #else
              o.pos = TransformWorldToHClip(o.worldPos);
          #endif

          // #if %SCREENPOSREQUIREKEY%
           o.screenPos = ComputeScreenPos(o.pos, _ProjectionParams.x);
          // #endif

          #if _PASSFORWARD || _PASSGBUFFER
              float2 uv1 = v.texcoord1.xy;
              OUTPUT_LIGHTMAP_UV(uv1, unity_LightmapST, o.lightmapUV);
               o.texcoord1.xy = uv1;
              OUTPUT_SH(o.worldNormal, o.sh);
              #if defined(DYNAMICLIGHTMAP_ON)
                   o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              #endif
          #endif

          #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
              half fogFactor = 0;
              #if defined(_FOG_FRAGMENT)
                fogFactor = ComputeFogFactor(o.pos.z);
              #endif
              #if _BAKEDLIT
                 o.fogFactorAndVertexLight = half4(fogFactor, 0, 0, 0);
              #else
                 half3 vertexLight = VertexLighting(o.worldPos, o.worldNormal);
                 o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
              #endif
          #endif

          #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             o.shadowCoord = GetShadowCoord(vertexInput);
          #endif

           return o;
         }


            

            // fragment shader
            half4 Frag (VertexToPixel IN
            #ifdef _DEPTHOFFSET_ON
              , out float outputDepth : SV_Depth
            #endif
            #if NEED_FACING
               , bool facing : SV_IsFrontFace
            #endif
            ) : SV_Target
            {
               UNITY_SETUP_INSTANCE_ID(IN);
               UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

               ShaderData d = CreateShaderData(IN
                  #if NEED_FACING
                     , facing
                  #endif
               );
               Surface l = (Surface)0;

               #ifdef _DEPTHOFFSET_ON
                  l.outputDepth = outputDepth;
               #endif

               l.Albedo = half3(0.5, 0.5, 0.5);
               l.Normal = float3(0,0,1);
               l.Occlusion = 1;
               l.Alpha = 1;

               ChainSurfaceFunction(l, d);

               #ifdef _DEPTHOFFSET_ON
                  outputDepth = l.outputDepth;
               #endif

               return 0;

            }

         ENDHLSL

      }


      
        Pass
        {
            Name "Meta"
            Tags 
            { 
                "LightMode" = "Meta"
            }

            Cull Off
            

            

            HLSLPROGRAM

               #pragma vertex Vert
   #pragma fragment Frag

            #pragma target 3.0

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
        
            #define SHADERPASS SHADERPASS_META
            #define _PASSMETA 1


            
	#pragma multi_compile_local _DIFFUSELIGHTINGSTYLE_STEPPED _DIFFUSELIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _SPECULARLIGHTINGSTYLE_BASIC _SPECULARLIGHTINGSTYLE_STEPPED _SPECULARLIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _DIFFUSETEXTUREMAPPING_SCREENSPACE _DIFFUSETEXTUREMAPPING_VIEWDIRECTION _DIFFUSETEXTUREMAPPING_SCREENSTABLE _DIFFUSETEXTUREMAPPING_WORLDSPACE _DIFFUSETEXTUREMAPPING_OBJECTSPACE
	#pragma multi_compile_local _SPECULARTEXTUREMAPPING_SCREENSPACE _SPECULARTEXTUREMAPPING_VIEWDIRECTION _SPECULARTEXTUREMAPPING_SCREENSTABLE _SPECULARTEXTUREMAPPING_WORLDSPACE _SPECULARTEXTUREMAPPING_OBJECTSPACE
	#pragma shader_feature_local _EMISSION
	#pragma shader_feature_local _REFLECTIONSENABLED_ON


   #define _URP 1

#define _UNLIT 1
#define _USINGTEXCOORD1 1
#define NEED_FACING 1


            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Version.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

                  #undef WorldNormalVector
      #define WorldNormalVector(data, normal) mul(normal, data.TBNMatrix)
      
      #define UnityObjectToWorldNormal(normal) mul(GetObjectToWorldMatrix(), normal)

      #define _WorldSpaceLightPos0 _MainLightPosition
      
      #define UNITY_DECLARE_TEX2D(name) TEXTURE2D(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2D_NOSAMPLER(name) TEXTURE2D(name);
      #define UNITY_DECLARE_TEX2DARRAY(name) TEXTURE2D_ARRAY(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(name) TEXTURE2D_ARRAY(name);

      #define UNITY_SAMPLE_TEX2DARRAY(tex,coord)            SAMPLE_TEXTURE2D_ARRAY(tex, sampler##tex, coord.xy, coord.z)
      #define UNITY_SAMPLE_TEX2DARRAY_LOD(tex,coord,lod)    SAMPLE_TEXTURE2D_ARRAY_LOD(tex, sampler##tex, coord.xy, coord.z, lod)
      #define UNITY_SAMPLE_TEX2D(tex, coord)                SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
      #define UNITY_SAMPLE_TEX2D_SAMPLER(tex, samp, coord)  SAMPLE_TEXTURE2D(tex, sampler##samp, coord)

      #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod)   SAMPLE_TEXTURE2D_LOD(tex, sampler_##tex, coord, lod)
      #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) SAMPLE_TEXTURE2D_LOD (tex, sampler##samplertex,coord, lod)
     
      #if defined(UNITY_COMPILER_HLSL)
         #define UNITY_INITIALIZE_OUTPUT(type,name) name = (type)0;
      #else
         #define UNITY_INITIALIZE_OUTPUT(type,name)
      #endif

      #define sampler2D_float sampler2D
      #define sampler2D_half sampler2D

      

      // data across stages, stripped like the above.
      struct VertexToPixel
      {
         float4 pos : SV_POSITION;
         float3 worldPos : TEXCOORD0;
         float3 worldNormal : TEXCOORD1;
         float4 worldTangent : TEXCOORD2;
          float4 texcoord0 : TEXCOORD3;
          float4 texcoord1 : TEXCOORD4;
         // float4 texcoord2 : TEXCOORD5;

         // #if %TEXCOORD3REQUIREKEY%
          float4 texcoord3 : TEXCOORD6;
         // #endif

         // #if %SCREENPOSREQUIREKEY%
          float4 screenPos : TEXCOORD7;
         // #endif

         // #if %VERTEXCOLORREQUIREKEY%
         // half4 vertexColor : COLOR;
         // #endif

         #if defined(LIGHTMAP_ON)
            float2 lightmapUV : TEXCOORD8;
         #endif
         #if defined(DYNAMICLIGHTMAP_ON)
            float2 dynamicLightmapUV : TEXCOORD9;
         #endif
         #if !defined(LIGHTMAP_ON)
            float3 sh : TEXCOORD10;
         #endif

         #if defined(VARYINGS_NEED_FOG_AND_VERTEX_LIGHT)
            float4 fogFactorAndVertexLight : TEXCOORD11;
         #endif

         #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
           float4 shadowCoord : TEXCOORD12;
         #endif

         // #if %EXTRAV2F0REQUIREKEY%
         // float4 extraV2F0 : TEXCOORD13;
         // #endif

         // #if %EXTRAV2F1REQUIREKEY%
         // float4 extraV2F1 : TEXCOORD14;
         // #endif

         // #if %EXTRAV2F2REQUIREKEY%
         // float4 extraV2F2 : TEXCOORD15;
         // #endif

         // #if %EXTRAV2F3REQUIREKEY%
         // float4 extraV2F3 : TEXCOORD16;
         // #endif

         // #if %EXTRAV2F4REQUIREKEY%
         // float4 extraV2F4 : TEXCOORD17;
         // #endif

         // #if %EXTRAV2F5REQUIREKEY%
         // float4 extraV2F5 : TEXCOORD18;
         // #endif

         // #if %EXTRAV2F6REQUIREKEY%
         // float4 extraV2F6 : TEXCOORD19;
         // #endif

         // #if %EXTRAV2F7REQUIREKEY%
         // float4 extraV2F7 : TEXCOORD20;
         // #endif

         #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
         #endif
         #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
         #endif
         #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
         #endif
         #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
         #endif
      };


            
            
            // data describing the user output of a pixel
            struct Surface
            {
               half3 Albedo;
               half Height;
               half3 Normal;
               half Smoothness;
               half3 Emission;
               half Metallic;
               half3 Specular;
               half Occlusion;
               half SpecularPower; // for simple lighting
               half Alpha;
               float outputDepth; // if written, SV_Depth semantic is used. ShaderData.clipPos.z is unused value
               // HDRP Only
               half SpecularOcclusion;
               half SubsurfaceMask;
               half Thickness;
               half CoatMask;
               half CoatSmoothness;
               half Anisotropy;
               half IridescenceMask;
               half IridescenceThickness;
               int DiffusionProfileHash;
               float SpecularAAThreshold;
               float SpecularAAScreenSpaceVariance;
               // requires _OVERRIDE_BAKEDGI to be defined, but is mapped in all pipelines
               float3 DiffuseGI;
               float3 BackDiffuseGI;
               float3 SpecularGI;
               // requires _OVERRIDE_SHADOWMASK to be defines
               float4 ShadowMask;
            };

            // Data the user declares in blackboard blocks
            struct Blackboard
            {
                
                float blackboardDummyData;
            };

            // data the user might need, this will grow to be big. But easy to strip
            struct ShaderData
            {
               float4 clipPos; // SV_POSITION
               float3 localSpacePosition;
               float3 localSpaceNormal;
               float3 localSpaceTangent;
        
               float3 worldSpacePosition;
               float3 worldSpaceNormal;
               float3 worldSpaceTangent;
               float tangentSign;

               float3 worldSpaceViewDir;
               float3 tangentSpaceViewDir;

               float4 texcoord0;
               float4 texcoord1;
               float4 texcoord2;
               float4 texcoord3;

               float2 screenUV;
               float4 screenPos;

               float4 vertexColor;
               bool isFrontFace;

               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;

               float3x3 TBNMatrix;
               Blackboard blackboard;
            };

            struct VertexData
            {
               #if SHADER_TARGET > 30
               // uint vertexID : SV_VertexID;
               #endif
               float4 vertex : POSITION;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;

               // optimize out mesh coords when not in use by user or lighting system
               #if _URP && (_USINGTEXCOORD1 || _PASSMETA || _PASSFORWARD || _PASSGBUFFER)
                  float4 texcoord1 : TEXCOORD1;
               #endif

               #if _URP && (_USINGTEXCOORD2 || _PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && defined(DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif

               #if _STANDARD && (_USINGTEXCOORD1 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER || _PASSFORWARDADD) && LIGHTMAP_ON)))
                  float4 texcoord1 : TEXCOORD1;
               #endif
               #if _STANDARD && (_USINGTEXCOORD2 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif


               #if _HDRP
                  float4 texcoord1 : TEXCOORD1;
                  float4 texcoord2 : TEXCOORD2;
               #endif

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD4; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity    : TEXCOORD5; // Add Precomputed Velocity (Alembic computes velocities on runtime side).
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct TessVertex 
            {
               float4 vertex : INTERNALTESSPOS;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;
               float4 texcoord1 : TEXCOORD1;
               float4 texcoord2 : TEXCOORD2;

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               // #if %EXTRAV2F0REQUIREKEY%
               // float4 extraV2F0 : TEXCOORD5;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // float4 extraV2F1 : TEXCOORD6;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // float4 extraV2F2 : TEXCOORD7;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // float4 extraV2F3 : TEXCOORD8;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // float4 extraV2F4 : TEXCOORD9;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // float4 extraV2F5 : TEXCOORD10;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // float4 extraV2F6 : TEXCOORD11;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // float4 extraV2F7 : TEXCOORD12;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD13; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity : TEXCOORD14;
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
               UNITY_VERTEX_OUTPUT_STEREO
            };

            struct ExtraV2F
            {
               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;
               Blackboard blackboard;
               float4 time;
            };


            float3 WorldToTangentSpace(ShaderData d, float3 normal)
            {
               return mul(d.TBNMatrix, normal);
            }

            float3 TangentToWorldSpace(ShaderData d, float3 normal)
            {
               return mul(normal, d.TBNMatrix);
            }

            // in this case, make standard more like SRPs, because we can't fix
            // unity_WorldToObject in HDRP, since it already does macro-fu there

            #if _STANDARD
               float3 TransformWorldToObject(float3 p) { return mul(unity_WorldToObject, float4(p, 1)); };
               float3 TransformObjectToWorld(float3 p) { return mul(unity_ObjectToWorld, float4(p, 1)); };
               float4 TransformWorldToObject(float4 p) { return mul(unity_WorldToObject, p); };
               float4 TransformObjectToWorld(float4 p) { return mul(unity_ObjectToWorld, p); };
               float4x4 GetWorldToObjectMatrix() { return unity_WorldToObject; }
               float4x4 GetObjectToWorldMatrix() { return unity_ObjectToWorld; }
               #if (defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (SHADER_TARGET_SURFACE_ANALYSIS && !SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod) tex.SampleLevel (sampler##tex,coord, lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) tex.SampleLevel (sampler##samplertex,coord, lod)
              #else
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex2D (tex,coord,0,lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) tex2D (tex,coord,0,lod)
              #endif

               #undef GetWorldToObjectMatrix()

               #define GetWorldToObjectMatrix()   unity_WorldToObject


            #endif

            float3 GetCameraWorldPosition()
            {
               #if _HDRP
                  return GetCameraRelativePositionWS(_WorldSpaceCameraPos);
               #else
                  return _WorldSpaceCameraPos;
               #endif
            }

            #if _GRABPASSUSED
               #if _STANDARD
                  TEXTURE2D(%GRABTEXTURE%);
                  SAMPLER(sampler_%GRABTEXTURE%);
               #endif

               half3 GetSceneColor(float2 uv)
               {
                  #if _STANDARD
                     return SAMPLE_TEXTURE2D(%GRABTEXTURE%, sampler_%GRABTEXTURE%, uv).rgb;
                  #else
                     return SHADERGRAPH_SAMPLE_SCENE_COLOR(uv);
                  #endif
               }
            #endif


      
            #if _STANDARD
               UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
               float GetSceneDepth(float2 uv) { return SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv)); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv)); } 
            #else
               float GetSceneDepth(float2 uv) { return SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv), _ZBufferParams); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv), _ZBufferParams); } 
            #endif

            float3 GetWorldPositionFromDepthBuffer(float2 uv, float3 worldSpaceViewDir)
            {
               float eye = GetLinearEyeDepth(uv);
               float3 camView = mul((float3x3)GetObjectToWorldMatrix(), transpose(mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V)) [2].xyz);

               float dt = dot(worldSpaceViewDir, camView);
               float3 div = worldSpaceViewDir/dt;
               float3 wpos = (eye * div) + GetCameraWorldPosition();
               return wpos;
            }

            #if _HDRP
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return GetAbsolutePositionWS(TransformObjectToWorld(pos));
            }
            #else
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return TransformObjectToWorld(pos);
            }
            #endif

            #if _STANDARD
               UNITY_DECLARE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture);
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  float4 depthNorms = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture, uv);
                  float3 norms = DecodeViewNormalStereo(depthNorms);
                  norms = mul((float3x3)GetWorldToViewMatrix(), norms) * 0.5 + 0.5;
                  return norms;
               }
            #elif _HDRP
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  NormalData nd;
                  DecodeFromNormalBuffer(_ScreenSize.xy * uv, nd);
                  return nd.normalWS;
               }
            #elif _URP
               #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                  #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
               #endif

               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                     return SampleSceneNormals(uv);
                  #else
                     float3 wpos = GetWorldPositionFromDepthBuffer(uv, worldSpaceViewDir);
                     return normalize(-cross(ddx(wpos), ddy(wpos))) * 0.5 + 0.5;
                  #endif

                }
             #endif

             #if _HDRP

               half3 UnpackNormalmapRGorAG(half4 packednormal)
               {
                     // This do the trick
                  packednormal.x *= packednormal.w;

                  half3 normal;
                  normal.xy = packednormal.xy * 2 - 1;
                  normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                  return normal;
               }
               half3 UnpackNormal(half4 packednormal)
               {
                  #if defined(UNITY_NO_DXT5nm)
                     return packednormal.xyz * 2 - 1;
                  #else
                     return UnpackNormalmapRGorAG(packednormal);
                  #endif
               }
               #endif
               #if _HDRP || _URP

               half3 UnpackScaleNormal(half4 packednormal, half scale)
               {
                 #ifndef UNITY_NO_DXT5nm
                   // Unpack normal as DXT5nm (1, y, 1, x) or BC5 (x, y, 0, 1)
                   // Note neutral texture like "bump" is (0, 0, 1, 1) to work with both plain RGB normal and DXT5nm/BC5
                   packednormal.x *= packednormal.w;
                 #endif
                   half3 normal;
                   normal.xy = (packednormal.xy * 2 - 1) * scale;
                   normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                   return normal;
               }	

             #endif


            void GetSun(out float3 lightDir, out float3 color)
            {
               lightDir = float3(0.5, 0.5, 0);
               color = 1;
               #if _HDRP
                  if (_DirectionalLightCount > 0)
                  {
                     DirectionalLightData light = _DirectionalLightDatas[0];
                     lightDir = -light.forward.xyz;
                     color = light.color;
                  }
               #elif _STANDARD
			         lightDir = normalize(_WorldSpaceLightPos0.xyz);
                  color = _LightColor0.rgb;
               #elif _URP
	               Light light = GetMainLight();
	               lightDir = light.direction;
	               color = light.color;
               #endif
            }


            
            CBUFFER_START(UnityPerMaterial)

               
	int _DiffuseLightingStyle;
	int _SpecularLightingStyle;
	int _CutoffEnabled;
	float _Cutoff;
	half4 _Color;
	float _AmbientShadowStrength;
	float _NormalMapStr;
	float4 _TilingOffset;
	int _DiffuseSteps;
	int _SpecularType;
	int _SpecularSteps;
	int _SpecularHatching;
	float2 _DiffuseEdge;
	int _DiffuseTextureMapping;
	int _ScreenStableDistanceScale;
	int _ScreenStableDistanceScaleSpec;
	float _DiffuseTextureSize;
	float _DiffuseRim;
	float2 _SpecularEdge;
	int _LinesOn;
	int _InvertShadowedLines;
	int _DiffuseHatching;
	float _DiffuseTextureContrast;
	float3 _HatchingRanges;
	float3 _HatchingRangesSpec;
	int _SpecularTextureMapping;
	float _SpecularTextureSize;
	int _KeepLinesThicc;
	float _SpecularTextureContrast;
	int _ReflectionsEnabled;
	float4 _ReflectionFresnelParams;
	float _BaseReflectStrength;
	float3 _EmissionColor;
	float _LightmapEmissionStr;
	float2 _PaintMaskEdges;



            CBUFFER_END

            

            

            #ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()


	// TODO:
	// Flip backface normals
	// Alpha cutoff support

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskMap);
	SAMPLER(sampler_MaskMap);

	TEXTURE2D(_BumpMap);
	SAMPLER(sampler_BumpMap);

	TEXTURE2D(_DiffuseTexture);
	TEXTURE2D(_SpecularTexture);

	TEXTURE2D(_EmissionTexture);
	SAMPLER(sampler_EmissionTexture);

	TEXTURE3D(_WobbleTexture);

	float invLerp(float from, float to, float value) {
		return (value - from) / (to - from);
	}

	float4 invLerp(float4 from, float4 to, float4 value) {
		return (value - from) / (to - from);
	}

	float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value){
		float rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	float4 remap(float4 origFrom, float4 origTo, float4 targetFrom, float4 targetTo, float4 value){
		float4 rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	SAMPLER(s_linear_repeat_sampler);

	void MainLight(out float3 direction, out float3 color, out float distanceAtten)
	{
		Light mainLight = GetMainLight();
		direction = mainLight.direction;
		color = mainLight.color;
		distanceAtten = mainLight.distanceAttenuation;
	}

	float ToonSharpen(float input, float edge = 0.1f)
	{
		float fw = fwidth(input)*0.5;
		return saturate(remap(edge - fw, edge + fw, 0, 1, input));
	}

	float3 Posterize(float3 input, int steps)
	{
		return round(input*steps)/steps;
	}

	float Posterize(float input, int steps)
	{
		return round(input*steps)/steps;

	}

	float Fresnel(float3 worldNormal, float3 viewAngle, float exp = 4)
	{
		return 1 - pow(abs(dot(worldNormal, viewAngle)),exp);
	}

	float MainLightShadows(float3 worldPos, float2 lightmapUV = float2(0.0,0.0))
	{
		float4 shadowCoord = TransformWorldToShadowCoord(worldPos);

		#if !defined (LIGHTMAP_ON) || defined(_LIGHTINGTYPE_VERTEX)
			half4 shadowMask = unity_ProbesOcclusion;
		#else
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half4 shadowMask = SAMPLE_SHADOWMASK(lightmapUV);
		#endif

		return ToonSharpen(MainLightShadow(shadowCoord, worldPos, shadowMask, _MainLightOcclusionProbes), 0.5f);
	}

	float3 GetAmbient(float3 worldNormal, float2 lightmapUV)
	{
		#ifdef LIGHTMAP_ON
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half3 bakedGI = SampleLightmap(lightmapUV, worldNormal);

			#if defined(_MIXED_LIGHTING_SUBTRACTIVE)
				Light mainLight = GetMainLight();
				bakedGI = SubtractDirectMainLightFromLightmap(mainLight, worldNormal, bakedGI);
			#endif

			return bakedGI;
		#else
			return SampleSH(worldNormal);
		#endif
	}

	float3 GetReflections(float3 worldNormal, float3 viewDir, float smoothness)
	{
		float perceptualRoughness = 1 - smoothness;
		perceptualRoughness *= perceptualRoughness;
		float mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
		float3 sample = SHADERGRAPH_REFLECTION_PROBE(viewDir, worldNormal, mip);
		return sample.rgb;
	}

	void SSAO(ShaderData d, out float directOcclusion, out float indirectOcclusion)
	{
		#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(ALPHABLEND)
			float2 uv = d.screenUV;

			AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(uv);
			directOcclusion = aoFactor.directAmbientOcclusion;
			indirectOcclusion = aoFactor.indirectAmbientOcclusion;
		#else
			directOcclusion = 1;
			indirectOcclusion = 1;
		#endif
	}

	half3 Triplanar(Texture2D tex, half3 samplePos, half3 normal, float size)
	{
		half2 uvX = samplePos.zy;
		half2 uvY = samplePos.xz + 0.67;
		half2 uvZ = samplePos.xy + 0.33;

		half3 lx = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvX / size).rgb;
		half3 ly = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvY / size).rgb;
		half3 lz = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvZ / size).rgb;

		float3 blend = pow(abs(normal),4);
		blend /= dot(blend, float3(1,1,1));

		return lx * blend.x + ly * blend.y + lz * blend.z;
	}

	half3 ViewDirLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float3 objPos = TransformObjectToWorld(0);
		float dist = distance(objPos, _WorldSpaceCameraPos);

		float3 samplePos = d.worldSpaceViewDir - _WorldSpaceCameraPos/dist;

		return Triplanar(tex, samplePos, d.worldSpaceViewDir, size);
	}

	half3 ScreenStableLightingTexture(ShaderData d, Texture2D tex, float size, int screenStableDistScale)
	{
		float3 objPos = TransformObjectToWorld(0);

		float dist = 3;

		if (screenStableDistScale)
			dist = distance(_WorldSpaceCameraPos, objPos);

		float4 clipPos = TransformObjectToHClip(TransformWorldToObject(d.worldSpacePosition));
		clipPos = ComputeScreenPos(clipPos);
		clipPos.xy /= clipPos.w;

		float4 objClipPos = TransformWorldToHClip(objPos);
		objClipPos = ComputeScreenPos(objClipPos);
		objClipPos.xy /= objClipPos.w;

		float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
		objClipPos.xy *= screenratio;
		clipPos.xy *= screenratio; 

		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, (clipPos.rg - objClipPos.rg) * size * dist).rgb;
	}

	half3 WorldSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, d.worldSpacePosition, d.worldSpaceNormal, size);
	}

	half3 ObjectSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, TransformWorldToObject(d.worldSpacePosition), TransformWorldToObject(d.worldSpaceNormal), size);
	}

	half3 ScreenSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float screenratio = _ScreenParams.x / _ScreenParams.y;
		float2 uv = d.screenUV;
		uv.x *= screenratio;
		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uv / size).rgb;
	}

	float TexturedDiffuse(float3 lightingTex, float inputDiffuse, float lightStr = 1, bool mainLight = false)
	{
		lightingTex = pow(abs(lightingTex), _DiffuseTextureContrast);
		float origDiffuse = inputDiffuse;
		if (mainLight)
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse));
		else
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse*lightStr));

		UNITY_BRANCH
		if (_DiffuseHatching == 0)
		{	
			origDiffuse = ToonSharpen(max(1 - lightingTex.r,0.025), 1 - origDiffuse);
		}
		else
		{
			lightingTex = max(1 - lightingTex,0.01);
			float3 hatchDiffuse = origDiffuse;
			hatchDiffuse.r = smoothstep(0, _HatchingRanges.r, origDiffuse);
			hatchDiffuse.g = smoothstep(0, _HatchingRanges.g, origDiffuse);
			hatchDiffuse.b = smoothstep(0, _HatchingRanges.b, origDiffuse);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchDiffuse.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchDiffuse.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchDiffuse.b);

			float combined = min(min(lightingTex.r, lightingTex.g),lightingTex.b);
			origDiffuse = ToonSharpen(combined, 1 - origDiffuse)*lightStr;
		}
		return origDiffuse;
	}

	float TexturedSpecular(float3 lightingTex, float inputSpec, float lightStr = 1)
	{
		
		lightingTex = pow(abs(lightingTex), _SpecularTextureContrast);
		//lightingTex -= 0.15;
		float origSpecular = smoothstep(_SpecularEdge.x, _SpecularEdge.y, saturate(inputSpec*lightStr*0.5));

		UNITY_BRANCH
		if (_SpecularHatching == 0)
		{	
			origSpecular = 1 - smoothstep(0, origSpecular, ToonSharpen(1 - lightingTex.r, origSpecular));
		}
		else
		{
			lightingTex = 1 - lightingTex;
			float3 hatchSpec = origSpecular;
			hatchSpec.r = smoothstep(1 - _HatchingRangesSpec.r, 1, origSpecular);
			hatchSpec.g = smoothstep(1 - _HatchingRangesSpec.g, 1, origSpecular);
			hatchSpec.b = smoothstep(1 - _HatchingRangesSpec.b, 1, origSpecular);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchSpec.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchSpec.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchSpec.b);

			float combined = max(max(lightingTex.r, lightingTex.g),lightingTex.b);
			origSpecular = smoothstep(0, origSpecular, combined);
		}
		return origSpecular;
	}

	float GetDiffuse(float3 lightingTex, Light l, ShaderData d, Surface o, bool mainLight = false, float lineArt = 1)
	{
		float diffuse = saturate(dot(l.direction, d.worldSpaceNormal));
		
		#if defined(_DIFFUSELIGHTINGSTYLE_STEPPED)
			diffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, diffuse);
			diffuse *= length(l.color);
			diffuse *= l.shadowAttenuation * saturate(l.distanceAttenuation);
			if (_DiffuseSteps > 1)
			{
				
				float origDiffuse = diffuse;
				float powLerpFactor = saturate(invLerp(1, 12, _DiffuseSteps));
				float powFactor = lerp(0.5, 1, powLerpFactor);

				diffuse = Posterize(pow(abs(diffuse), powFactor), _DiffuseSteps);

			}
			else
				diffuse = ToonSharpen(diffuse,0.075);

			diffuse /= length(l.color);
		#elif defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			diffuse *= l.shadowAttenuation * l.distanceAttenuation;
			diffuse = TexturedDiffuse(lightingTex, diffuse, length(l.color), mainLight);
		#endif

		UNITY_BRANCH
		if (_DiffuseRim*lineArt*l.shadowAttenuation*l.distanceAttenuation > 0)
		{
			float rim = Fresnel(d.worldSpaceNormal, d.worldSpaceViewDir);
			float mainLightAlignment = saturate(-dot(d.worldSpaceViewDir, l.direction));
			
			float rimSize = lerp(1.0, 0.9, _DiffuseRim*l.distanceAttenuation*l.distanceAttenuation);

			rim = ToonSharpen(rim,lerp(1.01, rimSize, mainLightAlignment)) * ToonSharpen(mainLightAlignment);
			diffuse = max(diffuse, rim);
		}

		return diffuse;
	}
	
	float GetSpecular(float3 lightingTex, Light l, ShaderData d, Surface o)
	{
		float baseSpec = 0;
		float SpecSmoothness = exp2(10 * o.Smoothness + 1).x;

		[branch]
		if (_SpecularType == 0) //Cook-Torrance
		{
			float roughness = 1 - o.Smoothness;
			roughness *= roughness;

			float3 h = SafeNormalize(l.direction + d.worldSpaceViewDir);
			float nh = saturate(dot(d.worldSpaceNormal, h));
			float lh = saturate(dot(l.direction, h));
			float d = nh * nh * (roughness * roughness - 1.0) + 1.00001;
			float normTerm = roughness * 4.0 + 2.0;
			float specTerm = roughness * roughness;
			specTerm /= (d * d) * max(0.1, lh * lh) * normTerm;
			baseSpec = specTerm*0.04;
		}
		else if (_SpecularType == 1) //Phong
		{
			float3 r = reflect(-l.direction, d.worldSpaceNormal);
			float rdotv = max(0, dot(r, d.worldSpaceViewDir));

			baseSpec = pow(rdotv, SpecSmoothness)*o.Smoothness;
		}
		else if (_SpecularType == 2) //Blinn-Phong
		{
			float3 h = SafeNormalize(l.direction+d.worldSpaceViewDir);
			float ndh = saturate(dot(d.worldSpaceNormal, h));

			baseSpec = pow(ndh, SpecSmoothness)*o.Smoothness;
		}
		else
		{
			return 0;
		}

		

		#if defined(_SPECULARLIGHTINGSTYLE_BASIC)
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation * length(l.color);
			baseSpec = smoothstep(_SpecularEdge.x,_SpecularEdge.y, baseSpec);
			baseSpec /= length(l.color);
		#elif defined(_SPECULARLIGHTINGSTYLE_STEPPED)
			baseSpec *= saturate(l.distanceAttenuation) * l.shadowAttenuation;
			baseSpec *= length(l.color);
			baseSpec = Posterize(baseSpec, max(1,_SpecularSteps));
			baseSpec /= length(l.color);
		#else
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation;
			baseSpec = TexturedSpecular(lightingTex, baseSpec, length(l.color));
		#endif	

		
		return baseSpec;
	}

	void Ext_ModifyVertex0 (inout VertexData v, inout ExtraV2F d)
	{
		v.texcoord0.xy = v.texcoord0.xy * _TilingOffset.xy + _TilingOffset.zw;

		if (_DiffuseTextureMapping == 2)
		{
			float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
			clipPos.xy /= clipPos.w;  

			float3 objPos = TransformObjectToWorld(0);
			float camDist = distance(objPos, _WorldSpaceCameraPos);
			float4 objClipPos = TransformWorldToHClip(objPos);
			objClipPos.xy /= objClipPos.w;

			float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
			objClipPos.xy *= screenratio;
			clipPos.xy *= screenratio;

			v.texcoord3 = (clipPos - objClipPos); 
		}
	}

	void Ext_SurfaceFunction0 (inout Surface o, ShaderData d)
	{
		
		// Handle input data
		float4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, d.texcoord0.xy);
		float4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, d.texcoord0.xy);
		o.Normal = UnpackScaleNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, d.texcoord0.xy), _NormalMapStr);
		d.worldSpaceNormal = TransformTangentToWorld(o.Normal, d.TBNMatrix);

		float diffuseColorMult = 1.0f;
		float specColorMult = 1.0f;

		if (_DiffuseLightingStyle == 1)
			diffuseColorMult = 0.5f;

		if (_SpecularLightingStyle = 2)
			specColorMult = 0.5f;

		if (!d.isFrontFace)
		{
			d.worldSpaceNormal *= -1;
		}

		o.Metallic = masks.r;
		o.Smoothness = masks.g;
		o.Alpha = baseColor.a * _Color.a;

		if (_CutoffEnabled)
			clip(o.Alpha - _Cutoff);

		o.Occlusion = 1;
		float3 specColor = 1;
		float paintmask = masks.b;

		float3 paintedColor = baseColor.rgb * _Color.rgb;
		baseColor.rgb = lerp(baseColor.rgb, paintedColor, smoothstep(_PaintMaskEdges.x, _PaintMaskEdges.y, paintmask));

		#if defined(_EMISSION)
			o.Emission = SAMPLE_TEXTURE2D(_EmissionTexture, sampler_EmissionTexture, d.texcoord0).rgb * _EmissionColor;
		#endif

		half lines = 1;
		half origlines = 1;
		float lineCutoff = 0.5;

		#if defined(LIGHTMAP_ON)
			half4 shadowMask = SAMPLE_SHADOWMASK(d.texcoord1.xy);
		#else
			half4 shadowMask = unity_ProbesOcclusion;
		#endif

		// -------------
		// LINE ART
		// -------------
		UNITY_BRANCH
		if (_LinesOn)
		{
			UNITY_BRANCH
			if (_KeepLinesThicc)
			{
				float dist = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
				float fresnel = pow(abs(dot(d.worldSpaceNormal, d.worldSpaceViewDir)),3);
				lineCutoff = lerp(0.5, 0.95, max(saturate(dist*0.2), fresnel));
			}
			lines = 1 - masks.a;

			 // Save original lines to use if ambient is raised
		}

		#ifdef _DBUFFER
			ApplyDecal(d.clipPos, baseColor.rgb, specColor, d.worldSpaceNormal, o.Metallic, lines, o.Smoothness);
		#endif

		if (_LinesOn)
		{
			lines = ToonSharpen(lines, lineCutoff);
			origlines = lines;
		}
		else
		{
			lines = 1;
		}

		// Store lighting values in these
		float3 mainLightDir;
		float3 mainLightCol;
		float mainLightAtten;
		MainLight(mainLightDir, mainLightCol, mainLightAtten);

		float2 lightmapUV = d.texcoord1.xy;

		float mainShadows = MainLightShadows(d.worldSpacePosition, lightmapUV);
		float3 ambient = GetAmbient(d.worldSpaceNormal, lightmapUV) * baseColor.rgb;

		Light mainLight = GetMainLight();

		#if   defined(_DIFFUSETEXTUREMAPPING_SCREENSPACE)
			float3 diffuseLightingTex = ScreenSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_VIEWDIRECTION)
			float3 diffuseLightingTex = ViewDirLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_SCREENSTABLE)
			float3 diffuseLightingTex = ScreenStableLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize, _ScreenStableDistanceScale);
		#elif defined(_DIFFUSETEXTUREMAPPING_WORLDSPACE)
			float3 diffuseLightingTex = WorldSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_OBJECTSPACE)
			float3 diffuseLightingTex = ObjectSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#endif

		#if   defined(_SPECULARTEXTUREMAPPING_SCREENSPACE)
			float3 specLightingTex = ScreenSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_VIEWDIRECTION)
			float3 specLightingTex = ViewDirLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_SCREENSTABLE)
			float3 specLightingTex = ScreenStableLightingTexture(d, _SpecularTexture, _SpecularTextureSize, _ScreenStableDistanceScale);
		#elif defined(_SPECULARTEXTUREMAPPING_WORLDSPACE)
			float3 specLightingTex = WorldSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_OBJECTSPACE)
			float3 specLightingTex = ObjectSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#endif
		

		float indirOcclusion, directOcclusion;
		SSAO(d, directOcclusion, indirOcclusion);

		#if defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			directOcclusion = TexturedDiffuse(diffuseLightingTex, directOcclusion);
			//indirOcclusion = TexturedDiffuse(diffuseLightingTex, indirOcclusion);
			ambient = min(indirOcclusion, ambient);
		#endif

		float mainDiffuseFactor = GetDiffuse(diffuseLightingTex, mainLight, d, o, true, lines)*directOcclusion*diffuseColorMult;
		mainDiffuseFactor *= mainShadows;
		float mainSpecFactor = GetSpecular(specLightingTex, mainLight, d, o) * specColorMult;
		
		float3 addLightDiffuse = 0;
		float3 addLightSpecular = 0;
		// -------------
		// ADDITIONALLIGHTS
		// -------------
		int pixelLights = GetAdditionalLightsCount();
		for (int i = 0; i < pixelLights; ++i)
		{
			Light light = GetAdditionalLight(i, d.worldSpacePosition, shadowMask);

			float diffuse = GetDiffuse(diffuseLightingTex, light, d, o, false, lines) * diffuseColorMult;
			float specular = GetSpecular(specLightingTex, light, d, o) * specColorMult;

			addLightDiffuse += diffuse * light.color;
			addLightSpecular += specular * light.color;
		}
		
		float diffuseDarkest = ToonSharpen(length(addLightDiffuse)+saturate(mainDiffuseFactor*length(mainLight.color)),0.025);

		// -------------
		// REFLECTIONS
		// -------------
		float3 reflections = 0;
		
		#if defined(_REFLECTIONSENABLED_ON)
			float reflectStr = 0.04*_BaseReflectStrength*2;;
			reflections = GetReflections(d.worldSpaceNormal, d.worldSpaceViewDir, o.Smoothness);
			float perceptualRoughness = (1 - o.Smoothness);
			perceptualRoughness *= perceptualRoughness;		

			float fresnel = pow(1.0 - saturate(dot(d.worldSpaceNormal, d.worldSpaceViewDir)-_ReflectionFresnelParams.y), _ReflectionFresnelParams.x*16);
			fresnel = smoothstep(_ReflectionFresnelParams.w*0.5, 1 - _ReflectionFresnelParams.w*0.5, fresnel);
			reflectStr = lerp(reflectStr, clamp(0, 2, 0.04*_ReflectionFresnelParams.z*50), fresnel);

			reflections *= reflectStr;
			reflections /= perceptualRoughness + 0.5;

			reflections = lerp(reflections, reflections * baseColor.rgb, o.Metallic);
		#endif
		
		#if defined(ALPHABLEND) && !defined(_PASSMETA)

			if (_OpaqueLines)
				o.Alpha = max(o.Alpha, 1 - lines);

			UNITY_BRANCH
			if (_PreserveSpec)
			{
				o.Alpha = max(Luminance(reflections), o.Alpha);
				o.Alpha = max(mainSpecFactor, o.Alpha);
				o.Alpha = max(addLightSpecular, o.Alpha);
			}

			float3 refractionCol = 0;
			float origAlpha = o.Alpha;
			UNITY_BRANCH
			if (_Refraction)
			{
				float4 offsetPos = float4(d.worldSpacePosition + d.worldSpaceNormal * _RefractionStr, 1.0);
				offsetPos = mul(GetWorldToHClipMatrix(), offsetPos);
				float scale = 1.0;

				#if UNITY_UV_STARTS_AT_TOP
					scale = -1.0;
				#endif

				float4 grabPos = offsetPos *0.5f;
				grabPos.xy = float2(grabPos.x, grabPos.y*scale) + grabPos.w;
				grabPos.zw = offsetPos.zw;
				grabPos.xy /= grabPos.w;
				grabPos.xy = saturate(grabPos.xy);

				float3 refraction = GetSceneColor(grabPos.xy);
				refractionCol = refraction;
				if (_RefractionTint)
					refraction *= baseColor.rgb;

				_RefractionEdge = 1 - _RefractionEdge;
				if (_RefractionEdge > 0)
				{
					float2 cubemapBlendFactors = pow(abs((grabPos.xy - 0.5) * 2.0),0.25);
					float blend = smoothstep(_RefractionEdge, 1, max(cubemapBlendFactors.x, cubemapBlendFactors.y));
					float3 refractDir = refract(-d.worldSpaceViewDir, d.worldSpaceNormal, 1 - _RefractionStr);
					float3 reflectProbe = GetReflections(-refractDir, refractDir, 1.0);
					
					refractionCol = lerp(refraction, reflectProbe, blend);
				}
				
				o.Alpha = 1;
			}

		#endif		

		float3 mainSpec = mainSpecFactor * mainLightCol;
		float3 mainDiffuse = mainDiffuseFactor * mainLightCol;

		addLightSpecular = lerp(addLightSpecular, addLightSpecular * baseColor.rgb, o.Metallic);
		mainSpec = lerp(mainSpec, mainSpec * specColor, o.Metallic);

		lines = lerp(1 - lines, lines, diffuseDarkest);
		
		if (_InvertShadowedLines)
			diffuseDarkest = lerp(diffuseDarkest, 1, lines);

		o.Albedo = baseColor.rgb;
		o.Emission *= _LightmapEmissionStr;
		#if !defined(_PASSMETA)
			o.Albedo *= mainDiffuse * lines;
			o.Albedo += reflections* mainDiffuse *lines;
			o.Albedo += addLightDiffuse * lines * baseColor.rgb + addLightSpecular * lines;
			o.Albedo += mainSpec * mainDiffuse * mainShadows * lines;
			
			o.Albedo += lerp(ambient*diffuseDarkest * lines, ambient*origlines, _AmbientShadowStrength);
			#if defined(ALPHABLEND)
				if (_Refraction)
				{
					o.Albedo = lerp(refractionCol, o.Albedo, origAlpha);
				}
			#endif
			o.Albedo += o.Emission;
		#endif
	}




        
            void ChainSurfaceFunction(inout Surface l, inout ShaderData d)
            {
                  Ext_SurfaceFunction0(l, d);
                 // Ext_SurfaceFunction1(l, d);
                 // Ext_SurfaceFunction2(l, d);
                 // Ext_SurfaceFunction3(l, d);
                 // Ext_SurfaceFunction4(l, d);
                 // Ext_SurfaceFunction5(l, d);
                 // Ext_SurfaceFunction6(l, d);
                 // Ext_SurfaceFunction7(l, d);
                 // Ext_SurfaceFunction8(l, d);
                 // Ext_SurfaceFunction9(l, d);
		           // Ext_SurfaceFunction10(l, d);
                 // Ext_SurfaceFunction11(l, d);
                 // Ext_SurfaceFunction12(l, d);
                 // Ext_SurfaceFunction13(l, d);
                 // Ext_SurfaceFunction14(l, d);
                 // Ext_SurfaceFunction15(l, d);
                 // Ext_SurfaceFunction16(l, d);
                 // Ext_SurfaceFunction17(l, d);
                 // Ext_SurfaceFunction18(l, d);
		           // Ext_SurfaceFunction19(l, d);
                 // Ext_SurfaceFunction20(l, d);
                 // Ext_SurfaceFunction21(l, d);
                 // Ext_SurfaceFunction22(l, d);
                 // Ext_SurfaceFunction23(l, d);
                 // Ext_SurfaceFunction24(l, d);
                 // Ext_SurfaceFunction25(l, d);
                 // Ext_SurfaceFunction26(l, d);
                 // Ext_SurfaceFunction27(l, d);
                 // Ext_SurfaceFunction28(l, d);
		           // Ext_SurfaceFunction29(l, d);
            }

            void ChainModifyVertex(inout VertexData v, inout VertexToPixel v2p, float4 time)
            {
                 ExtraV2F d;
                 
                 ZERO_INITIALIZE(ExtraV2F, d);
                 ZERO_INITIALIZE(Blackboard, d.blackboard);
                 // due to motion vectors in HDRP, we need to use the last
                 // time in certain spots. So if you are going to use _Time to adjust vertices,
                 // you need to use this time or motion vectors will break. 
                 d.time = time;

                   Ext_ModifyVertex0(v, d);
                 // Ext_ModifyVertex1(v, d);
                 // Ext_ModifyVertex2(v, d);
                 // Ext_ModifyVertex3(v, d);
                 // Ext_ModifyVertex4(v, d);
                 // Ext_ModifyVertex5(v, d);
                 // Ext_ModifyVertex6(v, d);
                 // Ext_ModifyVertex7(v, d);
                 // Ext_ModifyVertex8(v, d);
                 // Ext_ModifyVertex9(v, d);
                 // Ext_ModifyVertex10(v, d);
                 // Ext_ModifyVertex11(v, d);
                 // Ext_ModifyVertex12(v, d);
                 // Ext_ModifyVertex13(v, d);
                 // Ext_ModifyVertex14(v, d);
                 // Ext_ModifyVertex15(v, d);
                 // Ext_ModifyVertex16(v, d);
                 // Ext_ModifyVertex17(v, d);
                 // Ext_ModifyVertex18(v, d);
                 // Ext_ModifyVertex19(v, d);
                 // Ext_ModifyVertex20(v, d);
                 // Ext_ModifyVertex21(v, d);
                 // Ext_ModifyVertex22(v, d);
                 // Ext_ModifyVertex23(v, d);
                 // Ext_ModifyVertex24(v, d);
                 // Ext_ModifyVertex25(v, d);
                 // Ext_ModifyVertex26(v, d);
                 // Ext_ModifyVertex27(v, d);
                 // Ext_ModifyVertex28(v, d);
                 // Ext_ModifyVertex29(v, d);


                 // #if %EXTRAV2F0REQUIREKEY%
                 // v2p.extraV2F0 = d.extraV2F0;
                 // #endif

                 // #if %EXTRAV2F1REQUIREKEY%
                 // v2p.extraV2F1 = d.extraV2F1;
                 // #endif

                 // #if %EXTRAV2F2REQUIREKEY%
                 // v2p.extraV2F2 = d.extraV2F2;
                 // #endif

                 // #if %EXTRAV2F3REQUIREKEY%
                 // v2p.extraV2F3 = d.extraV2F3;
                 // #endif

                 // #if %EXTRAV2F4REQUIREKEY%
                 // v2p.extraV2F4 = d.extraV2F4;
                 // #endif

                 // #if %EXTRAV2F5REQUIREKEY%
                 // v2p.extraV2F5 = d.extraV2F5;
                 // #endif

                 // #if %EXTRAV2F6REQUIREKEY%
                 // v2p.extraV2F6 = d.extraV2F6;
                 // #endif

                 // #if %EXTRAV2F7REQUIREKEY%
                 // v2p.extraV2F7 = d.extraV2F7;
                 // #endif
            }

            void ChainModifyTessellatedVertex(inout VertexData v, inout VertexToPixel v2p)
            {
               ExtraV2F d;
               ZERO_INITIALIZE(ExtraV2F, d);
               ZERO_INITIALIZE(Blackboard, d.blackboard);

               // #if %EXTRAV2F0REQUIREKEY%
               // d.extraV2F0 = v2p.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // d.extraV2F1 = v2p.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // d.extraV2F2 = v2p.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // d.extraV2F3 = v2p.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // d.extraV2F4 = v2p.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // d.extraV2F5 = v2p.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // d.extraV2F6 = v2p.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // d.extraV2F7 = v2p.extraV2F7;
               // #endif


               // Ext_ModifyTessellatedVertex0(v, d);
               // Ext_ModifyTessellatedVertex1(v, d);
               // Ext_ModifyTessellatedVertex2(v, d);
               // Ext_ModifyTessellatedVertex3(v, d);
               // Ext_ModifyTessellatedVertex4(v, d);
               // Ext_ModifyTessellatedVertex5(v, d);
               // Ext_ModifyTessellatedVertex6(v, d);
               // Ext_ModifyTessellatedVertex7(v, d);
               // Ext_ModifyTessellatedVertex8(v, d);
               // Ext_ModifyTessellatedVertex9(v, d);
               // Ext_ModifyTessellatedVertex10(v, d);
               // Ext_ModifyTessellatedVertex11(v, d);
               // Ext_ModifyTessellatedVertex12(v, d);
               // Ext_ModifyTessellatedVertex13(v, d);
               // Ext_ModifyTessellatedVertex14(v, d);
               // Ext_ModifyTessellatedVertex15(v, d);
               // Ext_ModifyTessellatedVertex16(v, d);
               // Ext_ModifyTessellatedVertex17(v, d);
               // Ext_ModifyTessellatedVertex18(v, d);
               // Ext_ModifyTessellatedVertex19(v, d);
               // Ext_ModifyTessellatedVertex20(v, d);
               // Ext_ModifyTessellatedVertex21(v, d);
               // Ext_ModifyTessellatedVertex22(v, d);
               // Ext_ModifyTessellatedVertex23(v, d);
               // Ext_ModifyTessellatedVertex24(v, d);
               // Ext_ModifyTessellatedVertex25(v, d);
               // Ext_ModifyTessellatedVertex26(v, d);
               // Ext_ModifyTessellatedVertex27(v, d);
               // Ext_ModifyTessellatedVertex28(v, d);
               // Ext_ModifyTessellatedVertex29(v, d);

               // #if %EXTRAV2F0REQUIREKEY%
               // v2p.extraV2F0 = d.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // v2p.extraV2F1 = d.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // v2p.extraV2F2 = d.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // v2p.extraV2F3 = d.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // v2p.extraV2F4 = d.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // v2p.extraV2F5 = d.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // v2p.extraV2F6 = d.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // v2p.extraV2F7 = d.extraV2F7;
               // #endif
            }

            void ChainFinalColorForward(inout Surface l, inout ShaderData d, inout half4 color)
            {
               //   Ext_FinalColorForward0(l, d, color);
               //   Ext_FinalColorForward1(l, d, color);
               //   Ext_FinalColorForward2(l, d, color);
               //   Ext_FinalColorForward3(l, d, color);
               //   Ext_FinalColorForward4(l, d, color);
               //   Ext_FinalColorForward5(l, d, color);
               //   Ext_FinalColorForward6(l, d, color);
               //   Ext_FinalColorForward7(l, d, color);
               //   Ext_FinalColorForward8(l, d, color);
               //   Ext_FinalColorForward9(l, d, color);
               //  Ext_FinalColorForward10(l, d, color);
               //  Ext_FinalColorForward11(l, d, color);
               //  Ext_FinalColorForward12(l, d, color);
               //  Ext_FinalColorForward13(l, d, color);
               //  Ext_FinalColorForward14(l, d, color);
               //  Ext_FinalColorForward15(l, d, color);
               //  Ext_FinalColorForward16(l, d, color);
               //  Ext_FinalColorForward17(l, d, color);
               //  Ext_FinalColorForward18(l, d, color);
               //  Ext_FinalColorForward19(l, d, color);
               //  Ext_FinalColorForward20(l, d, color);
               //  Ext_FinalColorForward21(l, d, color);
               //  Ext_FinalColorForward22(l, d, color);
               //  Ext_FinalColorForward23(l, d, color);
               //  Ext_FinalColorForward24(l, d, color);
               //  Ext_FinalColorForward25(l, d, color);
               //  Ext_FinalColorForward26(l, d, color);
               //  Ext_FinalColorForward27(l, d, color);
               //  Ext_FinalColorForward28(l, d, color);
               //  Ext_FinalColorForward29(l, d, color);
            }

            void ChainFinalGBufferStandard(inout Surface s, inout ShaderData d, inout half4 GBuffer0, inout half4 GBuffer1, inout half4 GBuffer2, inout half4 outEmission, inout half4 outShadowMask)
            {
               //   Ext_FinalGBufferStandard0(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard1(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard2(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard3(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard4(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard5(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard6(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard7(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard8(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard9(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard10(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard11(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard12(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard13(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard14(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard15(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard16(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard17(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard18(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard19(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard20(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard21(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard22(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard23(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard24(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard25(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard26(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard27(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard28(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard29(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
            }



            

         ShaderData CreateShaderData(VertexToPixel i
                  #if NEED_FACING
                     , bool facing
                  #endif
         )
         {
            ShaderData d = (ShaderData)0;
            d.clipPos = i.pos;
            d.worldSpacePosition = i.worldPos;

            d.worldSpaceNormal = normalize(i.worldNormal);
            d.worldSpaceTangent = normalize(i.worldTangent.xyz);
            d.tangentSign = i.worldTangent.w;
            float3 bitangent = cross(i.worldTangent.xyz, i.worldNormal) * d.tangentSign * -1;
            

            d.TBNMatrix = float3x3(d.worldSpaceTangent, bitangent, d.worldSpaceNormal);
            d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

            d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
             d.texcoord0 = i.texcoord0;
             d.texcoord1 = i.texcoord1;
            // d.texcoord2 = i.texcoord2;

            // #if %TEXCOORD3REQUIREKEY%
             d.texcoord3 = i.texcoord3;
            // #endif

             d.isFrontFace = facing;
            // #if %VERTEXCOLORREQUIREKEY%
            // d.vertexColor = i.vertexColor;
            // #endif

            // these rarely get used, so we back transform them. Usually will be stripped.
            #if _HDRP
                // d.localSpacePosition = mul(unity_WorldToObject, float4(GetCameraRelativePositionWS(i.worldPos), 1)).xyz;
            #else
                // d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
            #endif
            // d.localSpaceNormal = normalize(mul((float3x3)unity_WorldToObject, i.worldNormal));
            // d.localSpaceTangent = normalize(mul((float3x3)unity_WorldToObject, i.worldTangent.xyz));

            // #if %SCREENPOSREQUIREKEY%
             d.screenPos = i.screenPos;
             d.screenUV = (i.screenPos.xy / i.screenPos.w);
            // #endif


            // #if %EXTRAV2F0REQUIREKEY%
            // d.extraV2F0 = i.extraV2F0;
            // #endif

            // #if %EXTRAV2F1REQUIREKEY%
            // d.extraV2F1 = i.extraV2F1;
            // #endif

            // #if %EXTRAV2F2REQUIREKEY%
            // d.extraV2F2 = i.extraV2F2;
            // #endif

            // #if %EXTRAV2F3REQUIREKEY%
            // d.extraV2F3 = i.extraV2F3;
            // #endif

            // #if %EXTRAV2F4REQUIREKEY%
            // d.extraV2F4 = i.extraV2F4;
            // #endif

            // #if %EXTRAV2F5REQUIREKEY%
            // d.extraV2F5 = i.extraV2F5;
            // #endif

            // #if %EXTRAV2F6REQUIREKEY%
            // d.extraV2F6 = i.extraV2F6;
            // #endif

            // #if %EXTRAV2F7REQUIREKEY%
            // d.extraV2F7 = i.extraV2F7;
            // #endif

            return d;
         }
         

            
         #if defined(_PASSSHADOW)
            float3 _LightDirection;
            float3 _LightPosition;
         #endif

         // vertex shader
         VertexToPixel Vert (VertexData v)
         {
           
           VertexToPixel o = (VertexToPixel)0;

           UNITY_SETUP_INSTANCE_ID(v);
           UNITY_TRANSFER_INSTANCE_ID(v, o);
           UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


#if !_TESSELLATION_ON
           ChainModifyVertex(v, o, _Time);
#endif

            o.texcoord0 = v.texcoord0;
            o.texcoord1 = v.texcoord1;
           // o.texcoord2 = v.texcoord2;

           // #if %TEXCOORD3REQUIREKEY%
            o.texcoord3 = v.texcoord3;
           // #endif

           // #if %VERTEXCOLORREQUIREKEY%
           // o.vertexColor = v.vertexColor;
           // #endif
           
           VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
           o.worldPos = TransformObjectToWorld(v.vertex.xyz);
           o.worldNormal = TransformObjectToWorldNormal(v.normal);
           o.worldTangent = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);

          // For some very odd reason, in 2021.2, we can't use Unity's defines, but have to use our own..
          #if _PASSSHADOW
              #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                 float3 lightDirectionWS = normalize(_LightPosition - o.worldPos);
              #else
                 float3 lightDirectionWS = _LightDirection;
              #endif
              // Define shadow pass specific clip position for Universal
              o.pos = TransformWorldToHClip(ApplyShadowBias(o.worldPos, o.worldNormal, lightDirectionWS));
              #if UNITY_REVERSED_Z
                  o.pos.z = min(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #else
                  o.pos.z = max(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #endif
          #elif _PASSMETA
              o.pos = MetaVertexPosition(float4(v.vertex.xyz, 0), v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
          #else
              o.pos = TransformWorldToHClip(o.worldPos);
          #endif

          // #if %SCREENPOSREQUIREKEY%
           o.screenPos = ComputeScreenPos(o.pos, _ProjectionParams.x);
          // #endif

          #if _PASSFORWARD || _PASSGBUFFER
              float2 uv1 = v.texcoord1.xy;
              OUTPUT_LIGHTMAP_UV(uv1, unity_LightmapST, o.lightmapUV);
               o.texcoord1.xy = uv1;
              OUTPUT_SH(o.worldNormal, o.sh);
              #if defined(DYNAMICLIGHTMAP_ON)
                   o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              #endif
          #endif

          #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
              half fogFactor = 0;
              #if defined(_FOG_FRAGMENT)
                fogFactor = ComputeFogFactor(o.pos.z);
              #endif
              #if _BAKEDLIT
                 o.fogFactorAndVertexLight = half4(fogFactor, 0, 0, 0);
              #else
                 half3 vertexLight = VertexLighting(o.worldPos, o.worldNormal);
                 o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
              #endif
          #endif

          #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             o.shadowCoord = GetShadowCoord(vertexInput);
          #endif

           return o;
         }


            

            // fragment shader
            half4 Frag (VertexToPixel IN
               #if NEED_FACING
                  , bool facing : SV_IsFrontFace
               #endif
            ) : SV_Target
            {
               UNITY_SETUP_INSTANCE_ID(IN);

               ShaderData d = CreateShaderData(IN
                  #if NEED_FACING
                     , facing
                  #endif
               );

               Surface l = (Surface)0;

               l.Albedo = half3(0.5, 0.5, 0.5);
               l.Normal = float3(0,0,1);
               l.Occlusion = 1;
               l.Alpha = 1;

               ChainSurfaceFunction(l, d);

               MetaInput metaInput = (MetaInput)0;
               metaInput.Albedo = l.Albedo;
               metaInput.Emission = l.Emission;

               return MetaFragment(metaInput);

            }

         ENDHLSL

      }


      
        Pass
        {
            Name "DepthNormals"
            Tags
            {
               "LightMode" = "DepthNormals"
            }
    
            // Render State
            Cull Back
            Blend One Zero
            ZTest LEqual
            ZWrite On

            

            HLSLPROGRAM

               #pragma vertex Vert
   #pragma fragment Frag

            #pragma target 3.0

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma multi_compile_fog
            #pragma multi_compile_instancing
            #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT // forward-only variant


            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
            #define _PASSDEPTH 1
            #define _PASSDEPTHNORMALS 1


            
	#pragma multi_compile_local _DIFFUSELIGHTINGSTYLE_STEPPED _DIFFUSELIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _SPECULARLIGHTINGSTYLE_BASIC _SPECULARLIGHTINGSTYLE_STEPPED _SPECULARLIGHTINGSTYLE_TEXTURED
	#pragma multi_compile_local _DIFFUSETEXTUREMAPPING_SCREENSPACE _DIFFUSETEXTUREMAPPING_VIEWDIRECTION _DIFFUSETEXTUREMAPPING_SCREENSTABLE _DIFFUSETEXTUREMAPPING_WORLDSPACE _DIFFUSETEXTUREMAPPING_OBJECTSPACE
	#pragma multi_compile_local _SPECULARTEXTUREMAPPING_SCREENSPACE _SPECULARTEXTUREMAPPING_VIEWDIRECTION _SPECULARTEXTUREMAPPING_SCREENSTABLE _SPECULARTEXTUREMAPPING_WORLDSPACE _SPECULARTEXTUREMAPPING_OBJECTSPACE
	#pragma shader_feature_local _EMISSION
	#pragma shader_feature_local _REFLECTIONSENABLED_ON


   #define _URP 1

#define _UNLIT 1
#define _USINGTEXCOORD1 1
#define NEED_FACING 1

            // this has to be here or specular color will be ignored. Not in SG code
            #if _SIMPLELIT
               #define _SPECULAR_COLOR
            #endif


            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Version.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"


        

               #undef WorldNormalVector
      #define WorldNormalVector(data, normal) mul(normal, data.TBNMatrix)
      
      #define UnityObjectToWorldNormal(normal) mul(GetObjectToWorldMatrix(), normal)

      #define _WorldSpaceLightPos0 _MainLightPosition
      
      #define UNITY_DECLARE_TEX2D(name) TEXTURE2D(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2D_NOSAMPLER(name) TEXTURE2D(name);
      #define UNITY_DECLARE_TEX2DARRAY(name) TEXTURE2D_ARRAY(name); SAMPLER(sampler##name);
      #define UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(name) TEXTURE2D_ARRAY(name);

      #define UNITY_SAMPLE_TEX2DARRAY(tex,coord)            SAMPLE_TEXTURE2D_ARRAY(tex, sampler##tex, coord.xy, coord.z)
      #define UNITY_SAMPLE_TEX2DARRAY_LOD(tex,coord,lod)    SAMPLE_TEXTURE2D_ARRAY_LOD(tex, sampler##tex, coord.xy, coord.z, lod)
      #define UNITY_SAMPLE_TEX2D(tex, coord)                SAMPLE_TEXTURE2D(tex, sampler##tex, coord)
      #define UNITY_SAMPLE_TEX2D_SAMPLER(tex, samp, coord)  SAMPLE_TEXTURE2D(tex, sampler##samp, coord)

      #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod)   SAMPLE_TEXTURE2D_LOD(tex, sampler_##tex, coord, lod)
      #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) SAMPLE_TEXTURE2D_LOD (tex, sampler##samplertex,coord, lod)
     
      #if defined(UNITY_COMPILER_HLSL)
         #define UNITY_INITIALIZE_OUTPUT(type,name) name = (type)0;
      #else
         #define UNITY_INITIALIZE_OUTPUT(type,name)
      #endif

      #define sampler2D_float sampler2D
      #define sampler2D_half sampler2D

      

      // data across stages, stripped like the above.
      struct VertexToPixel
      {
         float4 pos : SV_POSITION;
         float3 worldPos : TEXCOORD0;
         float3 worldNormal : TEXCOORD1;
         float4 worldTangent : TEXCOORD2;
          float4 texcoord0 : TEXCOORD3;
          float4 texcoord1 : TEXCOORD4;
         // float4 texcoord2 : TEXCOORD5;

         // #if %TEXCOORD3REQUIREKEY%
          float4 texcoord3 : TEXCOORD6;
         // #endif

         // #if %SCREENPOSREQUIREKEY%
          float4 screenPos : TEXCOORD7;
         // #endif

         // #if %VERTEXCOLORREQUIREKEY%
         // half4 vertexColor : COLOR;
         // #endif

         #if defined(LIGHTMAP_ON)
            float2 lightmapUV : TEXCOORD8;
         #endif
         #if defined(DYNAMICLIGHTMAP_ON)
            float2 dynamicLightmapUV : TEXCOORD9;
         #endif
         #if !defined(LIGHTMAP_ON)
            float3 sh : TEXCOORD10;
         #endif

         #if defined(VARYINGS_NEED_FOG_AND_VERTEX_LIGHT)
            float4 fogFactorAndVertexLight : TEXCOORD11;
         #endif

         #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
           float4 shadowCoord : TEXCOORD12;
         #endif

         // #if %EXTRAV2F0REQUIREKEY%
         // float4 extraV2F0 : TEXCOORD13;
         // #endif

         // #if %EXTRAV2F1REQUIREKEY%
         // float4 extraV2F1 : TEXCOORD14;
         // #endif

         // #if %EXTRAV2F2REQUIREKEY%
         // float4 extraV2F2 : TEXCOORD15;
         // #endif

         // #if %EXTRAV2F3REQUIREKEY%
         // float4 extraV2F3 : TEXCOORD16;
         // #endif

         // #if %EXTRAV2F4REQUIREKEY%
         // float4 extraV2F4 : TEXCOORD17;
         // #endif

         // #if %EXTRAV2F5REQUIREKEY%
         // float4 extraV2F5 : TEXCOORD18;
         // #endif

         // #if %EXTRAV2F6REQUIREKEY%
         // float4 extraV2F6 : TEXCOORD19;
         // #endif

         // #if %EXTRAV2F7REQUIREKEY%
         // float4 extraV2F7 : TEXCOORD20;
         // #endif

         #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
         #endif
         #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
         #endif
         #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
         #endif
         #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
         #endif
      };


         
            
            // data describing the user output of a pixel
            struct Surface
            {
               half3 Albedo;
               half Height;
               half3 Normal;
               half Smoothness;
               half3 Emission;
               half Metallic;
               half3 Specular;
               half Occlusion;
               half SpecularPower; // for simple lighting
               half Alpha;
               float outputDepth; // if written, SV_Depth semantic is used. ShaderData.clipPos.z is unused value
               // HDRP Only
               half SpecularOcclusion;
               half SubsurfaceMask;
               half Thickness;
               half CoatMask;
               half CoatSmoothness;
               half Anisotropy;
               half IridescenceMask;
               half IridescenceThickness;
               int DiffusionProfileHash;
               float SpecularAAThreshold;
               float SpecularAAScreenSpaceVariance;
               // requires _OVERRIDE_BAKEDGI to be defined, but is mapped in all pipelines
               float3 DiffuseGI;
               float3 BackDiffuseGI;
               float3 SpecularGI;
               // requires _OVERRIDE_SHADOWMASK to be defines
               float4 ShadowMask;
            };

            // Data the user declares in blackboard blocks
            struct Blackboard
            {
                
                float blackboardDummyData;
            };

            // data the user might need, this will grow to be big. But easy to strip
            struct ShaderData
            {
               float4 clipPos; // SV_POSITION
               float3 localSpacePosition;
               float3 localSpaceNormal;
               float3 localSpaceTangent;
        
               float3 worldSpacePosition;
               float3 worldSpaceNormal;
               float3 worldSpaceTangent;
               float tangentSign;

               float3 worldSpaceViewDir;
               float3 tangentSpaceViewDir;

               float4 texcoord0;
               float4 texcoord1;
               float4 texcoord2;
               float4 texcoord3;

               float2 screenUV;
               float4 screenPos;

               float4 vertexColor;
               bool isFrontFace;

               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;

               float3x3 TBNMatrix;
               Blackboard blackboard;
            };

            struct VertexData
            {
               #if SHADER_TARGET > 30
               // uint vertexID : SV_VertexID;
               #endif
               float4 vertex : POSITION;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;

               // optimize out mesh coords when not in use by user or lighting system
               #if _URP && (_USINGTEXCOORD1 || _PASSMETA || _PASSFORWARD || _PASSGBUFFER)
                  float4 texcoord1 : TEXCOORD1;
               #endif

               #if _URP && (_USINGTEXCOORD2 || _PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && defined(DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif

               #if _STANDARD && (_USINGTEXCOORD1 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER || _PASSFORWARDADD) && LIGHTMAP_ON)))
                  float4 texcoord1 : TEXCOORD1;
               #endif
               #if _STANDARD && (_USINGTEXCOORD2 || (_PASSMETA || ((_PASSFORWARD || _PASSGBUFFER) && DYNAMICLIGHTMAP_ON)))
                  float4 texcoord2 : TEXCOORD2;
               #endif


               #if _HDRP
                  float4 texcoord1 : TEXCOORD1;
                  float4 texcoord2 : TEXCOORD2;
               #endif

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD4; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity    : TEXCOORD5; // Add Precomputed Velocity (Alembic computes velocities on runtime side).
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct TessVertex 
            {
               float4 vertex : INTERNALTESSPOS;
               float3 normal : NORMAL;
               float4 tangent : TANGENT;
               float4 texcoord0 : TEXCOORD0;
               float4 texcoord1 : TEXCOORD1;
               float4 texcoord2 : TEXCOORD2;

               // #if %TEXCOORD3REQUIREKEY%
                float4 texcoord3 : TEXCOORD3;
               // #endif

               // #if %VERTEXCOLORREQUIREKEY%
               // float4 vertexColor : COLOR;
               // #endif

               // #if %EXTRAV2F0REQUIREKEY%
               // float4 extraV2F0 : TEXCOORD5;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // float4 extraV2F1 : TEXCOORD6;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // float4 extraV2F2 : TEXCOORD7;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // float4 extraV2F3 : TEXCOORD8;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // float4 extraV2F4 : TEXCOORD9;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // float4 extraV2F5 : TEXCOORD10;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // float4 extraV2F6 : TEXCOORD11;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // float4 extraV2F7 : TEXCOORD12;
               // #endif

               #if _HDRP && (_PASSMOTIONVECTOR || ((_PASSFORWARD || _PASSUNLIT) && defined(_WRITE_TRANSPARENT_MOTION_VECTOR)))
                  float3 previousPositionOS : TEXCOORD13; // Contain previous transform position (in case of skinning for example)
                  #if defined (_ADD_PRECOMPUTED_VELOCITY)
                     float3 precomputedVelocity : TEXCOORD14;
                  #endif
               #endif

               UNITY_VERTEX_INPUT_INSTANCE_ID
               UNITY_VERTEX_OUTPUT_STEREO
            };

            struct ExtraV2F
            {
               float4 extraV2F0;
               float4 extraV2F1;
               float4 extraV2F2;
               float4 extraV2F3;
               float4 extraV2F4;
               float4 extraV2F5;
               float4 extraV2F6;
               float4 extraV2F7;
               Blackboard blackboard;
               float4 time;
            };


            float3 WorldToTangentSpace(ShaderData d, float3 normal)
            {
               return mul(d.TBNMatrix, normal);
            }

            float3 TangentToWorldSpace(ShaderData d, float3 normal)
            {
               return mul(normal, d.TBNMatrix);
            }

            // in this case, make standard more like SRPs, because we can't fix
            // unity_WorldToObject in HDRP, since it already does macro-fu there

            #if _STANDARD
               float3 TransformWorldToObject(float3 p) { return mul(unity_WorldToObject, float4(p, 1)); };
               float3 TransformObjectToWorld(float3 p) { return mul(unity_ObjectToWorld, float4(p, 1)); };
               float4 TransformWorldToObject(float4 p) { return mul(unity_WorldToObject, p); };
               float4 TransformObjectToWorld(float4 p) { return mul(unity_ObjectToWorld, p); };
               float4x4 GetWorldToObjectMatrix() { return unity_WorldToObject; }
               float4x4 GetObjectToWorldMatrix() { return unity_ObjectToWorld; }
               #if (defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (SHADER_TARGET_SURFACE_ANALYSIS && !SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord, lod) tex.SampleLevel (sampler##tex,coord, lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord, lod) tex.SampleLevel (sampler##samplertex,coord, lod)
              #else
                 #define UNITY_SAMPLE_TEX2D_LOD(tex,coord,lod) tex2D (tex,coord,0,lod)
                 #define UNITY_SAMPLE_TEX2D_SAMPLER_LOD(tex,samplertex,coord,lod) tex2D (tex,coord,0,lod)
              #endif

               #undef GetWorldToObjectMatrix()

               #define GetWorldToObjectMatrix()   unity_WorldToObject


            #endif

            float3 GetCameraWorldPosition()
            {
               #if _HDRP
                  return GetCameraRelativePositionWS(_WorldSpaceCameraPos);
               #else
                  return _WorldSpaceCameraPos;
               #endif
            }

            #if _GRABPASSUSED
               #if _STANDARD
                  TEXTURE2D(%GRABTEXTURE%);
                  SAMPLER(sampler_%GRABTEXTURE%);
               #endif

               half3 GetSceneColor(float2 uv)
               {
                  #if _STANDARD
                     return SAMPLE_TEXTURE2D(%GRABTEXTURE%, sampler_%GRABTEXTURE%, uv).rgb;
                  #else
                     return SHADERGRAPH_SAMPLE_SCENE_COLOR(uv);
                  #endif
               }
            #endif


      
            #if _STANDARD
               UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
               float GetSceneDepth(float2 uv) { return SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv)); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv)); } 
            #else
               float GetSceneDepth(float2 uv) { return SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); }
               float GetLinear01Depth(float2 uv) { return Linear01Depth(GetSceneDepth(uv), _ZBufferParams); }
               float GetLinearEyeDepth(float2 uv) { return LinearEyeDepth(GetSceneDepth(uv), _ZBufferParams); } 
            #endif

            float3 GetWorldPositionFromDepthBuffer(float2 uv, float3 worldSpaceViewDir)
            {
               float eye = GetLinearEyeDepth(uv);
               float3 camView = mul((float3x3)GetObjectToWorldMatrix(), transpose(mul(GetWorldToObjectMatrix(), UNITY_MATRIX_I_V)) [2].xyz);

               float dt = dot(worldSpaceViewDir, camView);
               float3 div = worldSpaceViewDir/dt;
               float3 wpos = (eye * div) + GetCameraWorldPosition();
               return wpos;
            }

            #if _HDRP
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return GetAbsolutePositionWS(TransformObjectToWorld(pos));
            }
            #else
            float3 ObjectToWorldSpacePosition(float3 pos)
            {
               return TransformObjectToWorld(pos);
            }
            #endif

            #if _STANDARD
               UNITY_DECLARE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture);
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  float4 depthNorms = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_CameraDepthNormalsTexture, uv);
                  float3 norms = DecodeViewNormalStereo(depthNorms);
                  norms = mul((float3x3)GetWorldToViewMatrix(), norms) * 0.5 + 0.5;
                  return norms;
               }
            #elif _HDRP
               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  NormalData nd;
                  DecodeFromNormalBuffer(_ScreenSize.xy * uv, nd);
                  return nd.normalWS;
               }
            #elif _URP
               #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                  #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareNormalsTexture.hlsl"
               #endif

               float3 GetSceneNormal(float2 uv, float3 worldSpaceViewDir)
               {
                  #if (SHADER_LIBRARY_VERSION_MAJOR >= 10)
                     return SampleSceneNormals(uv);
                  #else
                     float3 wpos = GetWorldPositionFromDepthBuffer(uv, worldSpaceViewDir);
                     return normalize(-cross(ddx(wpos), ddy(wpos))) * 0.5 + 0.5;
                  #endif

                }
             #endif

             #if _HDRP

               half3 UnpackNormalmapRGorAG(half4 packednormal)
               {
                     // This do the trick
                  packednormal.x *= packednormal.w;

                  half3 normal;
                  normal.xy = packednormal.xy * 2 - 1;
                  normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                  return normal;
               }
               half3 UnpackNormal(half4 packednormal)
               {
                  #if defined(UNITY_NO_DXT5nm)
                     return packednormal.xyz * 2 - 1;
                  #else
                     return UnpackNormalmapRGorAG(packednormal);
                  #endif
               }
               #endif
               #if _HDRP || _URP

               half3 UnpackScaleNormal(half4 packednormal, half scale)
               {
                 #ifndef UNITY_NO_DXT5nm
                   // Unpack normal as DXT5nm (1, y, 1, x) or BC5 (x, y, 0, 1)
                   // Note neutral texture like "bump" is (0, 0, 1, 1) to work with both plain RGB normal and DXT5nm/BC5
                   packednormal.x *= packednormal.w;
                 #endif
                   half3 normal;
                   normal.xy = (packednormal.xy * 2 - 1) * scale;
                   normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
                   return normal;
               }	

             #endif


            void GetSun(out float3 lightDir, out float3 color)
            {
               lightDir = float3(0.5, 0.5, 0);
               color = 1;
               #if _HDRP
                  if (_DirectionalLightCount > 0)
                  {
                     DirectionalLightData light = _DirectionalLightDatas[0];
                     lightDir = -light.forward.xyz;
                     color = light.color;
                  }
               #elif _STANDARD
			         lightDir = normalize(_WorldSpaceLightPos0.xyz);
                  color = _LightColor0.rgb;
               #elif _URP
	               Light light = GetMainLight();
	               lightDir = light.direction;
	               color = light.color;
               #endif
            }


            
         CBUFFER_START(UnityPerMaterial)

            
	int _DiffuseLightingStyle;
	int _SpecularLightingStyle;
	int _CutoffEnabled;
	float _Cutoff;
	half4 _Color;
	float _AmbientShadowStrength;
	float _NormalMapStr;
	float4 _TilingOffset;
	int _DiffuseSteps;
	int _SpecularType;
	int _SpecularSteps;
	int _SpecularHatching;
	float2 _DiffuseEdge;
	int _DiffuseTextureMapping;
	int _ScreenStableDistanceScale;
	int _ScreenStableDistanceScaleSpec;
	float _DiffuseTextureSize;
	float _DiffuseRim;
	float2 _SpecularEdge;
	int _LinesOn;
	int _InvertShadowedLines;
	int _DiffuseHatching;
	float _DiffuseTextureContrast;
	float3 _HatchingRanges;
	float3 _HatchingRangesSpec;
	int _SpecularTextureMapping;
	float _SpecularTextureSize;
	int _KeepLinesThicc;
	float _SpecularTextureContrast;
	int _ReflectionsEnabled;
	float4 _ReflectionFresnelParams;
	float _BaseReflectStrength;
	float3 _EmissionColor;
	float _LightmapEmissionStr;
	float2 _PaintMaskEdges;



         CBUFFER_END

         

         

         #ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif
#define unity_ObjectToWorld GetObjectToWorldMatrix()
#define unity_WorldToObject GetWorldToObjectMatrix()


	// TODO:
	// Flip backface normals
	// Alpha cutoff support

	TEXTURE2D(_MainTex);
	SAMPLER(sampler_MainTex);

	TEXTURE2D(_MaskMap);
	SAMPLER(sampler_MaskMap);

	TEXTURE2D(_BumpMap);
	SAMPLER(sampler_BumpMap);

	TEXTURE2D(_DiffuseTexture);
	TEXTURE2D(_SpecularTexture);

	TEXTURE2D(_EmissionTexture);
	SAMPLER(sampler_EmissionTexture);

	TEXTURE3D(_WobbleTexture);

	float invLerp(float from, float to, float value) {
		return (value - from) / (to - from);
	}

	float4 invLerp(float4 from, float4 to, float4 value) {
		return (value - from) / (to - from);
	}

	float remap(float origFrom, float origTo, float targetFrom, float targetTo, float value){
		float rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	float4 remap(float4 origFrom, float4 origTo, float4 targetFrom, float4 targetTo, float4 value){
		float4 rel = invLerp(origFrom, origTo, value);
		return lerp(targetFrom, targetTo, rel);
	}

	SAMPLER(s_linear_repeat_sampler);

	void MainLight(out float3 direction, out float3 color, out float distanceAtten)
	{
		Light mainLight = GetMainLight();
		direction = mainLight.direction;
		color = mainLight.color;
		distanceAtten = mainLight.distanceAttenuation;
	}

	float ToonSharpen(float input, float edge = 0.1f)
	{
		float fw = fwidth(input)*0.5;
		return saturate(remap(edge - fw, edge + fw, 0, 1, input));
	}

	float3 Posterize(float3 input, int steps)
	{
		return round(input*steps)/steps;
	}

	float Posterize(float input, int steps)
	{
		return round(input*steps)/steps;

	}

	float Fresnel(float3 worldNormal, float3 viewAngle, float exp = 4)
	{
		return 1 - pow(abs(dot(worldNormal, viewAngle)),exp);
	}

	float MainLightShadows(float3 worldPos, float2 lightmapUV = float2(0.0,0.0))
	{
		float4 shadowCoord = TransformWorldToShadowCoord(worldPos);

		#if !defined (LIGHTMAP_ON) || defined(_LIGHTINGTYPE_VERTEX)
			half4 shadowMask = unity_ProbesOcclusion;
		#else
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half4 shadowMask = SAMPLE_SHADOWMASK(lightmapUV);
		#endif

		return ToonSharpen(MainLightShadow(shadowCoord, worldPos, shadowMask, _MainLightOcclusionProbes), 0.5f);
	}

	float3 GetAmbient(float3 worldNormal, float2 lightmapUV)
	{
		#ifdef LIGHTMAP_ON
			lightmapUV = lightmapUV * unity_LightmapST.xy + unity_LightmapST.zw;

			half3 bakedGI = SampleLightmap(lightmapUV, worldNormal);

			#if defined(_MIXED_LIGHTING_SUBTRACTIVE)
				Light mainLight = GetMainLight();
				bakedGI = SubtractDirectMainLightFromLightmap(mainLight, worldNormal, bakedGI);
			#endif

			return bakedGI;
		#else
			return SampleSH(worldNormal);
		#endif
	}

	float3 GetReflections(float3 worldNormal, float3 viewDir, float smoothness)
	{
		float perceptualRoughness = 1 - smoothness;
		perceptualRoughness *= perceptualRoughness;
		float mip = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
		float3 sample = SHADERGRAPH_REFLECTION_PROBE(viewDir, worldNormal, mip);
		return sample.rgb;
	}

	void SSAO(ShaderData d, out float directOcclusion, out float indirectOcclusion)
	{
		#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(ALPHABLEND)
			float2 uv = d.screenUV;

			AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(uv);
			directOcclusion = aoFactor.directAmbientOcclusion;
			indirectOcclusion = aoFactor.indirectAmbientOcclusion;
		#else
			directOcclusion = 1;
			indirectOcclusion = 1;
		#endif
	}

	half3 Triplanar(Texture2D tex, half3 samplePos, half3 normal, float size)
	{
		half2 uvX = samplePos.zy;
		half2 uvY = samplePos.xz + 0.67;
		half2 uvZ = samplePos.xy + 0.33;

		half3 lx = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvX / size).rgb;
		half3 ly = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvY / size).rgb;
		half3 lz = SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uvZ / size).rgb;

		float3 blend = pow(abs(normal),4);
		blend /= dot(blend, float3(1,1,1));

		return lx * blend.x + ly * blend.y + lz * blend.z;
	}

	half3 ViewDirLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float3 objPos = TransformObjectToWorld(0);
		float dist = distance(objPos, _WorldSpaceCameraPos);

		float3 samplePos = d.worldSpaceViewDir - _WorldSpaceCameraPos/dist;

		return Triplanar(tex, samplePos, d.worldSpaceViewDir, size);
	}

	half3 ScreenStableLightingTexture(ShaderData d, Texture2D tex, float size, int screenStableDistScale)
	{
		float3 objPos = TransformObjectToWorld(0);

		float dist = 3;

		if (screenStableDistScale)
			dist = distance(_WorldSpaceCameraPos, objPos);

		float4 clipPos = TransformObjectToHClip(TransformWorldToObject(d.worldSpacePosition));
		clipPos = ComputeScreenPos(clipPos);
		clipPos.xy /= clipPos.w;

		float4 objClipPos = TransformWorldToHClip(objPos);
		objClipPos = ComputeScreenPos(objClipPos);
		objClipPos.xy /= objClipPos.w;

		float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
		objClipPos.xy *= screenratio;
		clipPos.xy *= screenratio; 

		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, (clipPos.rg - objClipPos.rg) * size * dist).rgb;
	}

	half3 WorldSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, d.worldSpacePosition, d.worldSpaceNormal, size);
	}

	half3 ObjectSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		return Triplanar(tex, TransformWorldToObject(d.worldSpacePosition), TransformWorldToObject(d.worldSpaceNormal), size);
	}

	half3 ScreenSpaceLightingTexture(ShaderData d, Texture2D tex, float size)
	{
		float screenratio = _ScreenParams.x / _ScreenParams.y;
		float2 uv = d.screenUV;
		uv.x *= screenratio;
		return SAMPLE_TEXTURE2D(tex, s_linear_repeat_sampler, uv / size).rgb;
	}

	float TexturedDiffuse(float3 lightingTex, float inputDiffuse, float lightStr = 1, bool mainLight = false)
	{
		lightingTex = pow(abs(lightingTex), _DiffuseTextureContrast);
		float origDiffuse = inputDiffuse;
		if (mainLight)
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse));
		else
			origDiffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, saturate(origDiffuse*lightStr));

		UNITY_BRANCH
		if (_DiffuseHatching == 0)
		{	
			origDiffuse = ToonSharpen(max(1 - lightingTex.r,0.025), 1 - origDiffuse);
		}
		else
		{
			lightingTex = max(1 - lightingTex,0.01);
			float3 hatchDiffuse = origDiffuse;
			hatchDiffuse.r = smoothstep(0, _HatchingRanges.r, origDiffuse);
			hatchDiffuse.g = smoothstep(0, _HatchingRanges.g, origDiffuse);
			hatchDiffuse.b = smoothstep(0, _HatchingRanges.b, origDiffuse);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchDiffuse.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchDiffuse.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchDiffuse.b);

			float combined = min(min(lightingTex.r, lightingTex.g),lightingTex.b);
			origDiffuse = ToonSharpen(combined, 1 - origDiffuse)*lightStr;
		}
		return origDiffuse;
	}

	float TexturedSpecular(float3 lightingTex, float inputSpec, float lightStr = 1)
	{
		
		lightingTex = pow(abs(lightingTex), _SpecularTextureContrast);
		//lightingTex -= 0.15;
		float origSpecular = smoothstep(_SpecularEdge.x, _SpecularEdge.y, saturate(inputSpec*lightStr*0.5));

		UNITY_BRANCH
		if (_SpecularHatching == 0)
		{	
			origSpecular = 1 - smoothstep(0, origSpecular, ToonSharpen(1 - lightingTex.r, origSpecular));
		}
		else
		{
			lightingTex = 1 - lightingTex;
			float3 hatchSpec = origSpecular;
			hatchSpec.r = smoothstep(1 - _HatchingRangesSpec.r, 1, origSpecular);
			hatchSpec.g = smoothstep(1 - _HatchingRangesSpec.g, 1, origSpecular);
			hatchSpec.b = smoothstep(1 - _HatchingRangesSpec.b, 1, origSpecular);

			lightingTex.r = smoothstep(0, lightingTex.r, hatchSpec.r);
			lightingTex.g = smoothstep(0, lightingTex.g, hatchSpec.g);
			lightingTex.b = smoothstep(0, lightingTex.b, hatchSpec.b);

			float combined = max(max(lightingTex.r, lightingTex.g),lightingTex.b);
			origSpecular = smoothstep(0, origSpecular, combined);
		}
		return origSpecular;
	}

	float GetDiffuse(float3 lightingTex, Light l, ShaderData d, Surface o, bool mainLight = false, float lineArt = 1)
	{
		float diffuse = saturate(dot(l.direction, d.worldSpaceNormal));
		
		#if defined(_DIFFUSELIGHTINGSTYLE_STEPPED)
			diffuse = smoothstep(_DiffuseEdge.x, _DiffuseEdge.y, diffuse);
			diffuse *= length(l.color);
			diffuse *= l.shadowAttenuation * saturate(l.distanceAttenuation);
			if (_DiffuseSteps > 1)
			{
				
				float origDiffuse = diffuse;
				float powLerpFactor = saturate(invLerp(1, 12, _DiffuseSteps));
				float powFactor = lerp(0.5, 1, powLerpFactor);

				diffuse = Posterize(pow(abs(diffuse), powFactor), _DiffuseSteps);

			}
			else
				diffuse = ToonSharpen(diffuse,0.075);

			diffuse /= length(l.color);
		#elif defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			diffuse *= l.shadowAttenuation * l.distanceAttenuation;
			diffuse = TexturedDiffuse(lightingTex, diffuse, length(l.color), mainLight);
		#endif

		UNITY_BRANCH
		if (_DiffuseRim*lineArt*l.shadowAttenuation*l.distanceAttenuation > 0)
		{
			float rim = Fresnel(d.worldSpaceNormal, d.worldSpaceViewDir);
			float mainLightAlignment = saturate(-dot(d.worldSpaceViewDir, l.direction));
			
			float rimSize = lerp(1.0, 0.9, _DiffuseRim*l.distanceAttenuation*l.distanceAttenuation);

			rim = ToonSharpen(rim,lerp(1.01, rimSize, mainLightAlignment)) * ToonSharpen(mainLightAlignment);
			diffuse = max(diffuse, rim);
		}

		return diffuse;
	}
	
	float GetSpecular(float3 lightingTex, Light l, ShaderData d, Surface o)
	{
		float baseSpec = 0;
		float SpecSmoothness = exp2(10 * o.Smoothness + 1).x;

		[branch]
		if (_SpecularType == 0) //Cook-Torrance
		{
			float roughness = 1 - o.Smoothness;
			roughness *= roughness;

			float3 h = SafeNormalize(l.direction + d.worldSpaceViewDir);
			float nh = saturate(dot(d.worldSpaceNormal, h));
			float lh = saturate(dot(l.direction, h));
			float d = nh * nh * (roughness * roughness - 1.0) + 1.00001;
			float normTerm = roughness * 4.0 + 2.0;
			float specTerm = roughness * roughness;
			specTerm /= (d * d) * max(0.1, lh * lh) * normTerm;
			baseSpec = specTerm*0.04;
		}
		else if (_SpecularType == 1) //Phong
		{
			float3 r = reflect(-l.direction, d.worldSpaceNormal);
			float rdotv = max(0, dot(r, d.worldSpaceViewDir));

			baseSpec = pow(rdotv, SpecSmoothness)*o.Smoothness;
		}
		else if (_SpecularType == 2) //Blinn-Phong
		{
			float3 h = SafeNormalize(l.direction+d.worldSpaceViewDir);
			float ndh = saturate(dot(d.worldSpaceNormal, h));

			baseSpec = pow(ndh, SpecSmoothness)*o.Smoothness;
		}
		else
		{
			return 0;
		}

		

		#if defined(_SPECULARLIGHTINGSTYLE_BASIC)
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation * length(l.color);
			baseSpec = smoothstep(_SpecularEdge.x,_SpecularEdge.y, baseSpec);
			baseSpec /= length(l.color);
		#elif defined(_SPECULARLIGHTINGSTYLE_STEPPED)
			baseSpec *= saturate(l.distanceAttenuation) * l.shadowAttenuation;
			baseSpec *= length(l.color);
			baseSpec = Posterize(baseSpec, max(1,_SpecularSteps));
			baseSpec /= length(l.color);
		#else
			baseSpec *= l.distanceAttenuation * l.shadowAttenuation;
			baseSpec = TexturedSpecular(lightingTex, baseSpec, length(l.color));
		#endif	

		
		return baseSpec;
	}

	void Ext_ModifyVertex0 (inout VertexData v, inout ExtraV2F d)
	{
		v.texcoord0.xy = v.texcoord0.xy * _TilingOffset.xy + _TilingOffset.zw;

		if (_DiffuseTextureMapping == 2)
		{
			float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
			clipPos.xy /= clipPos.w;  

			float3 objPos = TransformObjectToWorld(0);
			float camDist = distance(objPos, _WorldSpaceCameraPos);
			float4 objClipPos = TransformWorldToHClip(objPos);
			objClipPos.xy /= objClipPos.w;

			float2 screenratio = float2(1, _ScreenParams.y / _ScreenParams.x);
			objClipPos.xy *= screenratio;
			clipPos.xy *= screenratio;

			v.texcoord3 = (clipPos - objClipPos); 
		}
	}

	void Ext_SurfaceFunction0 (inout Surface o, ShaderData d)
	{
		
		// Handle input data
		float4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, d.texcoord0.xy);
		float4 masks = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, d.texcoord0.xy);
		o.Normal = UnpackScaleNormal(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, d.texcoord0.xy), _NormalMapStr);
		d.worldSpaceNormal = TransformTangentToWorld(o.Normal, d.TBNMatrix);

		float diffuseColorMult = 1.0f;
		float specColorMult = 1.0f;

		if (_DiffuseLightingStyle == 1)
			diffuseColorMult = 0.5f;

		if (_SpecularLightingStyle = 2)
			specColorMult = 0.5f;

		if (!d.isFrontFace)
		{
			d.worldSpaceNormal *= -1;
		}

		o.Metallic = masks.r;
		o.Smoothness = masks.g;
		o.Alpha = baseColor.a * _Color.a;

		if (_CutoffEnabled)
			clip(o.Alpha - _Cutoff);

		o.Occlusion = 1;
		float3 specColor = 1;
		float paintmask = masks.b;

		float3 paintedColor = baseColor.rgb * _Color.rgb;
		baseColor.rgb = lerp(baseColor.rgb, paintedColor, smoothstep(_PaintMaskEdges.x, _PaintMaskEdges.y, paintmask));

		#if defined(_EMISSION)
			o.Emission = SAMPLE_TEXTURE2D(_EmissionTexture, sampler_EmissionTexture, d.texcoord0).rgb * _EmissionColor;
		#endif

		half lines = 1;
		half origlines = 1;
		float lineCutoff = 0.5;

		#if defined(LIGHTMAP_ON)
			half4 shadowMask = SAMPLE_SHADOWMASK(d.texcoord1.xy);
		#else
			half4 shadowMask = unity_ProbesOcclusion;
		#endif

		// -------------
		// LINE ART
		// -------------
		UNITY_BRANCH
		if (_LinesOn)
		{
			UNITY_BRANCH
			if (_KeepLinesThicc)
			{
				float dist = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
				float fresnel = pow(abs(dot(d.worldSpaceNormal, d.worldSpaceViewDir)),3);
				lineCutoff = lerp(0.5, 0.95, max(saturate(dist*0.2), fresnel));
			}
			lines = 1 - masks.a;

			 // Save original lines to use if ambient is raised
		}

		#ifdef _DBUFFER
			ApplyDecal(d.clipPos, baseColor.rgb, specColor, d.worldSpaceNormal, o.Metallic, lines, o.Smoothness);
		#endif

		if (_LinesOn)
		{
			lines = ToonSharpen(lines, lineCutoff);
			origlines = lines;
		}
		else
		{
			lines = 1;
		}

		// Store lighting values in these
		float3 mainLightDir;
		float3 mainLightCol;
		float mainLightAtten;
		MainLight(mainLightDir, mainLightCol, mainLightAtten);

		float2 lightmapUV = d.texcoord1.xy;

		float mainShadows = MainLightShadows(d.worldSpacePosition, lightmapUV);
		float3 ambient = GetAmbient(d.worldSpaceNormal, lightmapUV) * baseColor.rgb;

		Light mainLight = GetMainLight();

		#if   defined(_DIFFUSETEXTUREMAPPING_SCREENSPACE)
			float3 diffuseLightingTex = ScreenSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_VIEWDIRECTION)
			float3 diffuseLightingTex = ViewDirLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_SCREENSTABLE)
			float3 diffuseLightingTex = ScreenStableLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize, _ScreenStableDistanceScale);
		#elif defined(_DIFFUSETEXTUREMAPPING_WORLDSPACE)
			float3 diffuseLightingTex = WorldSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#elif defined(_DIFFUSETEXTUREMAPPING_OBJECTSPACE)
			float3 diffuseLightingTex = ObjectSpaceLightingTexture(d, _DiffuseTexture, _DiffuseTextureSize);
		#endif

		#if   defined(_SPECULARTEXTUREMAPPING_SCREENSPACE)
			float3 specLightingTex = ScreenSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_VIEWDIRECTION)
			float3 specLightingTex = ViewDirLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_SCREENSTABLE)
			float3 specLightingTex = ScreenStableLightingTexture(d, _SpecularTexture, _SpecularTextureSize, _ScreenStableDistanceScale);
		#elif defined(_SPECULARTEXTUREMAPPING_WORLDSPACE)
			float3 specLightingTex = WorldSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#elif defined(_SPECULARTEXTUREMAPPING_OBJECTSPACE)
			float3 specLightingTex = ObjectSpaceLightingTexture(d, _SpecularTexture, _SpecularTextureSize);
		#endif
		

		float indirOcclusion, directOcclusion;
		SSAO(d, directOcclusion, indirOcclusion);

		#if defined(_DIFFUSELIGHTINGSTYLE_TEXTURED)
			directOcclusion = TexturedDiffuse(diffuseLightingTex, directOcclusion);
			//indirOcclusion = TexturedDiffuse(diffuseLightingTex, indirOcclusion);
			ambient = min(indirOcclusion, ambient);
		#endif

		float mainDiffuseFactor = GetDiffuse(diffuseLightingTex, mainLight, d, o, true, lines)*directOcclusion*diffuseColorMult;
		mainDiffuseFactor *= mainShadows;
		float mainSpecFactor = GetSpecular(specLightingTex, mainLight, d, o) * specColorMult;
		
		float3 addLightDiffuse = 0;
		float3 addLightSpecular = 0;
		// -------------
		// ADDITIONALLIGHTS
		// -------------
		int pixelLights = GetAdditionalLightsCount();
		for (int i = 0; i < pixelLights; ++i)
		{
			Light light = GetAdditionalLight(i, d.worldSpacePosition, shadowMask);

			float diffuse = GetDiffuse(diffuseLightingTex, light, d, o, false, lines) * diffuseColorMult;
			float specular = GetSpecular(specLightingTex, light, d, o) * specColorMult;

			addLightDiffuse += diffuse * light.color;
			addLightSpecular += specular * light.color;
		}
		
		float diffuseDarkest = ToonSharpen(length(addLightDiffuse)+saturate(mainDiffuseFactor*length(mainLight.color)),0.025);

		// -------------
		// REFLECTIONS
		// -------------
		float3 reflections = 0;
		
		#if defined(_REFLECTIONSENABLED_ON)
			float reflectStr = 0.04*_BaseReflectStrength*2;;
			reflections = GetReflections(d.worldSpaceNormal, d.worldSpaceViewDir, o.Smoothness);
			float perceptualRoughness = (1 - o.Smoothness);
			perceptualRoughness *= perceptualRoughness;		

			float fresnel = pow(1.0 - saturate(dot(d.worldSpaceNormal, d.worldSpaceViewDir)-_ReflectionFresnelParams.y), _ReflectionFresnelParams.x*16);
			fresnel = smoothstep(_ReflectionFresnelParams.w*0.5, 1 - _ReflectionFresnelParams.w*0.5, fresnel);
			reflectStr = lerp(reflectStr, clamp(0, 2, 0.04*_ReflectionFresnelParams.z*50), fresnel);

			reflections *= reflectStr;
			reflections /= perceptualRoughness + 0.5;

			reflections = lerp(reflections, reflections * baseColor.rgb, o.Metallic);
		#endif
		
		#if defined(ALPHABLEND) && !defined(_PASSMETA)

			if (_OpaqueLines)
				o.Alpha = max(o.Alpha, 1 - lines);

			UNITY_BRANCH
			if (_PreserveSpec)
			{
				o.Alpha = max(Luminance(reflections), o.Alpha);
				o.Alpha = max(mainSpecFactor, o.Alpha);
				o.Alpha = max(addLightSpecular, o.Alpha);
			}

			float3 refractionCol = 0;
			float origAlpha = o.Alpha;
			UNITY_BRANCH
			if (_Refraction)
			{
				float4 offsetPos = float4(d.worldSpacePosition + d.worldSpaceNormal * _RefractionStr, 1.0);
				offsetPos = mul(GetWorldToHClipMatrix(), offsetPos);
				float scale = 1.0;

				#if UNITY_UV_STARTS_AT_TOP
					scale = -1.0;
				#endif

				float4 grabPos = offsetPos *0.5f;
				grabPos.xy = float2(grabPos.x, grabPos.y*scale) + grabPos.w;
				grabPos.zw = offsetPos.zw;
				grabPos.xy /= grabPos.w;
				grabPos.xy = saturate(grabPos.xy);

				float3 refraction = GetSceneColor(grabPos.xy);
				refractionCol = refraction;
				if (_RefractionTint)
					refraction *= baseColor.rgb;

				_RefractionEdge = 1 - _RefractionEdge;
				if (_RefractionEdge > 0)
				{
					float2 cubemapBlendFactors = pow(abs((grabPos.xy - 0.5) * 2.0),0.25);
					float blend = smoothstep(_RefractionEdge, 1, max(cubemapBlendFactors.x, cubemapBlendFactors.y));
					float3 refractDir = refract(-d.worldSpaceViewDir, d.worldSpaceNormal, 1 - _RefractionStr);
					float3 reflectProbe = GetReflections(-refractDir, refractDir, 1.0);
					
					refractionCol = lerp(refraction, reflectProbe, blend);
				}
				
				o.Alpha = 1;
			}

		#endif		

		float3 mainSpec = mainSpecFactor * mainLightCol;
		float3 mainDiffuse = mainDiffuseFactor * mainLightCol;

		addLightSpecular = lerp(addLightSpecular, addLightSpecular * baseColor.rgb, o.Metallic);
		mainSpec = lerp(mainSpec, mainSpec * specColor, o.Metallic);

		lines = lerp(1 - lines, lines, diffuseDarkest);
		
		if (_InvertShadowedLines)
			diffuseDarkest = lerp(diffuseDarkest, 1, lines);

		o.Albedo = baseColor.rgb;
		o.Emission *= _LightmapEmissionStr;
		#if !defined(_PASSMETA)
			o.Albedo *= mainDiffuse * lines;
			o.Albedo += reflections* mainDiffuse *lines;
			o.Albedo += addLightDiffuse * lines * baseColor.rgb + addLightSpecular * lines;
			o.Albedo += mainSpec * mainDiffuse * mainShadows * lines;
			
			o.Albedo += lerp(ambient*diffuseDarkest * lines, ambient*origlines, _AmbientShadowStrength);
			#if defined(ALPHABLEND)
				if (_Refraction)
				{
					o.Albedo = lerp(refractionCol, o.Albedo, origAlpha);
				}
			#endif
			o.Albedo += o.Emission;
		#endif
	}




        
            void ChainSurfaceFunction(inout Surface l, inout ShaderData d)
            {
                  Ext_SurfaceFunction0(l, d);
                 // Ext_SurfaceFunction1(l, d);
                 // Ext_SurfaceFunction2(l, d);
                 // Ext_SurfaceFunction3(l, d);
                 // Ext_SurfaceFunction4(l, d);
                 // Ext_SurfaceFunction5(l, d);
                 // Ext_SurfaceFunction6(l, d);
                 // Ext_SurfaceFunction7(l, d);
                 // Ext_SurfaceFunction8(l, d);
                 // Ext_SurfaceFunction9(l, d);
		           // Ext_SurfaceFunction10(l, d);
                 // Ext_SurfaceFunction11(l, d);
                 // Ext_SurfaceFunction12(l, d);
                 // Ext_SurfaceFunction13(l, d);
                 // Ext_SurfaceFunction14(l, d);
                 // Ext_SurfaceFunction15(l, d);
                 // Ext_SurfaceFunction16(l, d);
                 // Ext_SurfaceFunction17(l, d);
                 // Ext_SurfaceFunction18(l, d);
		           // Ext_SurfaceFunction19(l, d);
                 // Ext_SurfaceFunction20(l, d);
                 // Ext_SurfaceFunction21(l, d);
                 // Ext_SurfaceFunction22(l, d);
                 // Ext_SurfaceFunction23(l, d);
                 // Ext_SurfaceFunction24(l, d);
                 // Ext_SurfaceFunction25(l, d);
                 // Ext_SurfaceFunction26(l, d);
                 // Ext_SurfaceFunction27(l, d);
                 // Ext_SurfaceFunction28(l, d);
		           // Ext_SurfaceFunction29(l, d);
            }

            void ChainModifyVertex(inout VertexData v, inout VertexToPixel v2p, float4 time)
            {
                 ExtraV2F d;
                 
                 ZERO_INITIALIZE(ExtraV2F, d);
                 ZERO_INITIALIZE(Blackboard, d.blackboard);
                 // due to motion vectors in HDRP, we need to use the last
                 // time in certain spots. So if you are going to use _Time to adjust vertices,
                 // you need to use this time or motion vectors will break. 
                 d.time = time;

                   Ext_ModifyVertex0(v, d);
                 // Ext_ModifyVertex1(v, d);
                 // Ext_ModifyVertex2(v, d);
                 // Ext_ModifyVertex3(v, d);
                 // Ext_ModifyVertex4(v, d);
                 // Ext_ModifyVertex5(v, d);
                 // Ext_ModifyVertex6(v, d);
                 // Ext_ModifyVertex7(v, d);
                 // Ext_ModifyVertex8(v, d);
                 // Ext_ModifyVertex9(v, d);
                 // Ext_ModifyVertex10(v, d);
                 // Ext_ModifyVertex11(v, d);
                 // Ext_ModifyVertex12(v, d);
                 // Ext_ModifyVertex13(v, d);
                 // Ext_ModifyVertex14(v, d);
                 // Ext_ModifyVertex15(v, d);
                 // Ext_ModifyVertex16(v, d);
                 // Ext_ModifyVertex17(v, d);
                 // Ext_ModifyVertex18(v, d);
                 // Ext_ModifyVertex19(v, d);
                 // Ext_ModifyVertex20(v, d);
                 // Ext_ModifyVertex21(v, d);
                 // Ext_ModifyVertex22(v, d);
                 // Ext_ModifyVertex23(v, d);
                 // Ext_ModifyVertex24(v, d);
                 // Ext_ModifyVertex25(v, d);
                 // Ext_ModifyVertex26(v, d);
                 // Ext_ModifyVertex27(v, d);
                 // Ext_ModifyVertex28(v, d);
                 // Ext_ModifyVertex29(v, d);


                 // #if %EXTRAV2F0REQUIREKEY%
                 // v2p.extraV2F0 = d.extraV2F0;
                 // #endif

                 // #if %EXTRAV2F1REQUIREKEY%
                 // v2p.extraV2F1 = d.extraV2F1;
                 // #endif

                 // #if %EXTRAV2F2REQUIREKEY%
                 // v2p.extraV2F2 = d.extraV2F2;
                 // #endif

                 // #if %EXTRAV2F3REQUIREKEY%
                 // v2p.extraV2F3 = d.extraV2F3;
                 // #endif

                 // #if %EXTRAV2F4REQUIREKEY%
                 // v2p.extraV2F4 = d.extraV2F4;
                 // #endif

                 // #if %EXTRAV2F5REQUIREKEY%
                 // v2p.extraV2F5 = d.extraV2F5;
                 // #endif

                 // #if %EXTRAV2F6REQUIREKEY%
                 // v2p.extraV2F6 = d.extraV2F6;
                 // #endif

                 // #if %EXTRAV2F7REQUIREKEY%
                 // v2p.extraV2F7 = d.extraV2F7;
                 // #endif
            }

            void ChainModifyTessellatedVertex(inout VertexData v, inout VertexToPixel v2p)
            {
               ExtraV2F d;
               ZERO_INITIALIZE(ExtraV2F, d);
               ZERO_INITIALIZE(Blackboard, d.blackboard);

               // #if %EXTRAV2F0REQUIREKEY%
               // d.extraV2F0 = v2p.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // d.extraV2F1 = v2p.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // d.extraV2F2 = v2p.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // d.extraV2F3 = v2p.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // d.extraV2F4 = v2p.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // d.extraV2F5 = v2p.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // d.extraV2F6 = v2p.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // d.extraV2F7 = v2p.extraV2F7;
               // #endif


               // Ext_ModifyTessellatedVertex0(v, d);
               // Ext_ModifyTessellatedVertex1(v, d);
               // Ext_ModifyTessellatedVertex2(v, d);
               // Ext_ModifyTessellatedVertex3(v, d);
               // Ext_ModifyTessellatedVertex4(v, d);
               // Ext_ModifyTessellatedVertex5(v, d);
               // Ext_ModifyTessellatedVertex6(v, d);
               // Ext_ModifyTessellatedVertex7(v, d);
               // Ext_ModifyTessellatedVertex8(v, d);
               // Ext_ModifyTessellatedVertex9(v, d);
               // Ext_ModifyTessellatedVertex10(v, d);
               // Ext_ModifyTessellatedVertex11(v, d);
               // Ext_ModifyTessellatedVertex12(v, d);
               // Ext_ModifyTessellatedVertex13(v, d);
               // Ext_ModifyTessellatedVertex14(v, d);
               // Ext_ModifyTessellatedVertex15(v, d);
               // Ext_ModifyTessellatedVertex16(v, d);
               // Ext_ModifyTessellatedVertex17(v, d);
               // Ext_ModifyTessellatedVertex18(v, d);
               // Ext_ModifyTessellatedVertex19(v, d);
               // Ext_ModifyTessellatedVertex20(v, d);
               // Ext_ModifyTessellatedVertex21(v, d);
               // Ext_ModifyTessellatedVertex22(v, d);
               // Ext_ModifyTessellatedVertex23(v, d);
               // Ext_ModifyTessellatedVertex24(v, d);
               // Ext_ModifyTessellatedVertex25(v, d);
               // Ext_ModifyTessellatedVertex26(v, d);
               // Ext_ModifyTessellatedVertex27(v, d);
               // Ext_ModifyTessellatedVertex28(v, d);
               // Ext_ModifyTessellatedVertex29(v, d);

               // #if %EXTRAV2F0REQUIREKEY%
               // v2p.extraV2F0 = d.extraV2F0;
               // #endif

               // #if %EXTRAV2F1REQUIREKEY%
               // v2p.extraV2F1 = d.extraV2F1;
               // #endif

               // #if %EXTRAV2F2REQUIREKEY%
               // v2p.extraV2F2 = d.extraV2F2;
               // #endif

               // #if %EXTRAV2F3REQUIREKEY%
               // v2p.extraV2F3 = d.extraV2F3;
               // #endif

               // #if %EXTRAV2F4REQUIREKEY%
               // v2p.extraV2F4 = d.extraV2F4;
               // #endif

               // #if %EXTRAV2F5REQUIREKEY%
               // v2p.extraV2F5 = d.extraV2F5;
               // #endif

               // #if %EXTRAV2F6REQUIREKEY%
               // v2p.extraV2F6 = d.extraV2F6;
               // #endif

               // #if %EXTRAV2F7REQUIREKEY%
               // v2p.extraV2F7 = d.extraV2F7;
               // #endif
            }

            void ChainFinalColorForward(inout Surface l, inout ShaderData d, inout half4 color)
            {
               //   Ext_FinalColorForward0(l, d, color);
               //   Ext_FinalColorForward1(l, d, color);
               //   Ext_FinalColorForward2(l, d, color);
               //   Ext_FinalColorForward3(l, d, color);
               //   Ext_FinalColorForward4(l, d, color);
               //   Ext_FinalColorForward5(l, d, color);
               //   Ext_FinalColorForward6(l, d, color);
               //   Ext_FinalColorForward7(l, d, color);
               //   Ext_FinalColorForward8(l, d, color);
               //   Ext_FinalColorForward9(l, d, color);
               //  Ext_FinalColorForward10(l, d, color);
               //  Ext_FinalColorForward11(l, d, color);
               //  Ext_FinalColorForward12(l, d, color);
               //  Ext_FinalColorForward13(l, d, color);
               //  Ext_FinalColorForward14(l, d, color);
               //  Ext_FinalColorForward15(l, d, color);
               //  Ext_FinalColorForward16(l, d, color);
               //  Ext_FinalColorForward17(l, d, color);
               //  Ext_FinalColorForward18(l, d, color);
               //  Ext_FinalColorForward19(l, d, color);
               //  Ext_FinalColorForward20(l, d, color);
               //  Ext_FinalColorForward21(l, d, color);
               //  Ext_FinalColorForward22(l, d, color);
               //  Ext_FinalColorForward23(l, d, color);
               //  Ext_FinalColorForward24(l, d, color);
               //  Ext_FinalColorForward25(l, d, color);
               //  Ext_FinalColorForward26(l, d, color);
               //  Ext_FinalColorForward27(l, d, color);
               //  Ext_FinalColorForward28(l, d, color);
               //  Ext_FinalColorForward29(l, d, color);
            }

            void ChainFinalGBufferStandard(inout Surface s, inout ShaderData d, inout half4 GBuffer0, inout half4 GBuffer1, inout half4 GBuffer2, inout half4 outEmission, inout half4 outShadowMask)
            {
               //   Ext_FinalGBufferStandard0(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard1(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard2(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard3(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard4(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard5(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard6(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard7(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard8(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //   Ext_FinalGBufferStandard9(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard10(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard11(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard12(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard13(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard14(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard15(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard16(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard17(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard18(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard19(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard20(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard21(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard22(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard23(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard24(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard25(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard26(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard27(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard28(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
               //  Ext_FinalGBufferStandard29(s, d, GBuffer0, GBuffer1, GBuffer2, outEmission, outShadowMask);
            }



         

         ShaderData CreateShaderData(VertexToPixel i
                  #if NEED_FACING
                     , bool facing
                  #endif
         )
         {
            ShaderData d = (ShaderData)0;
            d.clipPos = i.pos;
            d.worldSpacePosition = i.worldPos;

            d.worldSpaceNormal = normalize(i.worldNormal);
            d.worldSpaceTangent = normalize(i.worldTangent.xyz);
            d.tangentSign = i.worldTangent.w;
            float3 bitangent = cross(i.worldTangent.xyz, i.worldNormal) * d.tangentSign * -1;
            

            d.TBNMatrix = float3x3(d.worldSpaceTangent, bitangent, d.worldSpaceNormal);
            d.worldSpaceViewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

            d.tangentSpaceViewDir = mul(d.TBNMatrix, d.worldSpaceViewDir);
             d.texcoord0 = i.texcoord0;
             d.texcoord1 = i.texcoord1;
            // d.texcoord2 = i.texcoord2;

            // #if %TEXCOORD3REQUIREKEY%
             d.texcoord3 = i.texcoord3;
            // #endif

             d.isFrontFace = facing;
            // #if %VERTEXCOLORREQUIREKEY%
            // d.vertexColor = i.vertexColor;
            // #endif

            // these rarely get used, so we back transform them. Usually will be stripped.
            #if _HDRP
                // d.localSpacePosition = mul(unity_WorldToObject, float4(GetCameraRelativePositionWS(i.worldPos), 1)).xyz;
            #else
                // d.localSpacePosition = mul(unity_WorldToObject, float4(i.worldPos, 1)).xyz;
            #endif
            // d.localSpaceNormal = normalize(mul((float3x3)unity_WorldToObject, i.worldNormal));
            // d.localSpaceTangent = normalize(mul((float3x3)unity_WorldToObject, i.worldTangent.xyz));

            // #if %SCREENPOSREQUIREKEY%
             d.screenPos = i.screenPos;
             d.screenUV = (i.screenPos.xy / i.screenPos.w);
            // #endif


            // #if %EXTRAV2F0REQUIREKEY%
            // d.extraV2F0 = i.extraV2F0;
            // #endif

            // #if %EXTRAV2F1REQUIREKEY%
            // d.extraV2F1 = i.extraV2F1;
            // #endif

            // #if %EXTRAV2F2REQUIREKEY%
            // d.extraV2F2 = i.extraV2F2;
            // #endif

            // #if %EXTRAV2F3REQUIREKEY%
            // d.extraV2F3 = i.extraV2F3;
            // #endif

            // #if %EXTRAV2F4REQUIREKEY%
            // d.extraV2F4 = i.extraV2F4;
            // #endif

            // #if %EXTRAV2F5REQUIREKEY%
            // d.extraV2F5 = i.extraV2F5;
            // #endif

            // #if %EXTRAV2F6REQUIREKEY%
            // d.extraV2F6 = i.extraV2F6;
            // #endif

            // #if %EXTRAV2F7REQUIREKEY%
            // d.extraV2F7 = i.extraV2F7;
            // #endif

            return d;
         }
         

         
         #if defined(_PASSSHADOW)
            float3 _LightDirection;
            float3 _LightPosition;
         #endif

         // vertex shader
         VertexToPixel Vert (VertexData v)
         {
           
           VertexToPixel o = (VertexToPixel)0;

           UNITY_SETUP_INSTANCE_ID(v);
           UNITY_TRANSFER_INSTANCE_ID(v, o);
           UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


#if !_TESSELLATION_ON
           ChainModifyVertex(v, o, _Time);
#endif

            o.texcoord0 = v.texcoord0;
            o.texcoord1 = v.texcoord1;
           // o.texcoord2 = v.texcoord2;

           // #if %TEXCOORD3REQUIREKEY%
            o.texcoord3 = v.texcoord3;
           // #endif

           // #if %VERTEXCOLORREQUIREKEY%
           // o.vertexColor = v.vertexColor;
           // #endif
           
           VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
           o.worldPos = TransformObjectToWorld(v.vertex.xyz);
           o.worldNormal = TransformObjectToWorldNormal(v.normal);
           o.worldTangent = float4(TransformObjectToWorldDir(v.tangent.xyz), v.tangent.w);

          // For some very odd reason, in 2021.2, we can't use Unity's defines, but have to use our own..
          #if _PASSSHADOW
              #if _CASTING_PUNCTUAL_LIGHT_SHADOW
                 float3 lightDirectionWS = normalize(_LightPosition - o.worldPos);
              #else
                 float3 lightDirectionWS = _LightDirection;
              #endif
              // Define shadow pass specific clip position for Universal
              o.pos = TransformWorldToHClip(ApplyShadowBias(o.worldPos, o.worldNormal, lightDirectionWS));
              #if UNITY_REVERSED_Z
                  o.pos.z = min(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #else
                  o.pos.z = max(o.pos.z, o.pos.w * UNITY_NEAR_CLIP_VALUE);
              #endif
          #elif _PASSMETA
              o.pos = MetaVertexPosition(float4(v.vertex.xyz, 0), v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
          #else
              o.pos = TransformWorldToHClip(o.worldPos);
          #endif

          // #if %SCREENPOSREQUIREKEY%
           o.screenPos = ComputeScreenPos(o.pos, _ProjectionParams.x);
          // #endif

          #if _PASSFORWARD || _PASSGBUFFER
              float2 uv1 = v.texcoord1.xy;
              OUTPUT_LIGHTMAP_UV(uv1, unity_LightmapST, o.lightmapUV);
               o.texcoord1.xy = uv1;
              OUTPUT_SH(o.worldNormal, o.sh);
              #if defined(DYNAMICLIGHTMAP_ON)
                   o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              #endif
          #endif

          #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
              half fogFactor = 0;
              #if defined(_FOG_FRAGMENT)
                fogFactor = ComputeFogFactor(o.pos.z);
              #endif
              #if _BAKEDLIT
                 o.fogFactorAndVertexLight = half4(fogFactor, 0, 0, 0);
              #else
                 half3 vertexLight = VertexLighting(o.worldPos, o.worldNormal);
                 o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
              #endif
          #endif

          #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             o.shadowCoord = GetShadowCoord(vertexInput);
          #endif

           return o;
         }


         

         // fragment shader
         half4 Frag (VertexToPixel IN
            #ifdef _DEPTHOFFSET_ON
              , out float outputDepth : SV_Depth
            #endif
            #if NEED_FACING
               , bool facing : SV_IsFrontFace
            #endif
         ) : SV_Target
         {
           UNITY_SETUP_INSTANCE_ID(IN);
           UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

           ShaderData d = CreateShaderData(IN
                  #if NEED_FACING
                     , facing
                  #endif
               );
           Surface l = (Surface)0;

           #ifdef _DEPTHOFFSET_ON
              l.outputDepth = outputDepth;
           #endif

           l.Albedo = half3(0.5, 0.5, 0.5);
           l.Normal = float3(0,0,1);
           l.Occlusion = 1;
           l.Alpha = 1;

           ChainSurfaceFunction(l, d);

           #ifdef _DEPTHOFFSET_ON
              outputDepth = l.outputDepth;
           #endif

          #if defined(_GBUFFER_NORMALS_OCT)
              float3 normalWS = d.worldSpaceNormal;
              float2 octNormalWS = PackNormalOctQuadEncode(normalWS);           // values between [-1, +1], must use fp32 on some platforms
              float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);   // values between [ 0,  1]
              half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);      // values between [ 0,  1]
              return half4(packedNormalWS, 0.0);
          #else
              return half4(NormalizeNormalPerPixel(d.worldSpaceNormal), 0.0);
          #endif

         
         }

         ENDHLSL

      }


      


      

   }
   
   
   CustomEditor "Needle.MarkdownShaderGUI"
}
