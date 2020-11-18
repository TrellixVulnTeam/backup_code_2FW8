using System;

namespace cshape
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(Program.hash(1, 2));
        }

        //将C#实现的hash函数转换为了JS代码
        static float hash(int i, int j)
        {
            uint OFFSET_BASIS = 2166136261;
            double FNV_PRIME = 1.6777619;
            double t = ((OFFSET_BASIS ^ (uint)i) ^ (uint)j) * FNV_PRIME;
            Console.WriteLine((OFFSET_BASIS ^ (uint)i) ^ (uint)j);
            Console.WriteLine(t);
            //只取小数
            return (float)(t - (uint)(t));
        }

    }
}
