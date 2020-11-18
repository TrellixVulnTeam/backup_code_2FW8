// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Chapter5-SimpleShader"
{
    Properties {
        _Color ("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
    }

    SubShader
    {
      Pass
      {
          CGPROGRAM

          #pragma vertex vert
          #pragma fragment frag

          //在CG代码中定义一个与属性名称和类型都匹配的变量
          fixed4 _Color;

          //使用结构体定义顶点着色器输入
          struct a2v {
              //用模型空间的顶点坐标填充Vertex变量
              float4 vertex : POSITION;
              //模型空间的法线方向
              float3 normal : NORMAL;
              float4 texcoord :TEXCOORD0;
          };

          struct v2f {
              float4 pos : SV_POSITION;
              fixed3 color : COlOR0;
          };

          v2f vert(a2v v) {
              v2f o;

              o.pos = UnityObjectToClipPos(v.vertex);
              o.color = v.normal * 0.8 + fixed3(0.5, 0.5, 0.5);
              return o;
          }

          fixed4 frag(v2f i) : SV_Target {
              fixed3 c = i.color;
              //使用Color属性控制输出颜色
              c *= _Color.rgb;
              return fixed4(c, 1.0);
          }
          
          ENDCG
      }
    }
}
