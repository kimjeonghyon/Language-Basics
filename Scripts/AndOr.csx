using System;

            int v1 = 10, v2 = 10, v3 = 10, v4 = 10;
            bool r1, r2, r3, r4;

            r1 = v1 > 20 && (v1 = 30) > 20;
            r2 = v2 > 20 & ( v2 = 30 ) > 20;
            r3 = v3 > 5 || (v3 = 30) > 20;
            r4 = v4 > 5 | ( v4 = 30 ) > 20;

            Console.WriteLine($"r1 = {r1}, v1 = {v1}");
            Console.WriteLine($"r2 = {r2}, v1 = {v2}");
            Console.WriteLine($"r3 = {r3}, v1 = {v3}");
            Console.WriteLine($"r4 = {r4}, v1 = {v4}");
