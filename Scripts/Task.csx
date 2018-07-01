using System;
using System.Threading.Tasks;
using System.Threading;
using static System.Console;

var t1 = Task.Factory.StartNew(()=> DoLongWork(100));
var t2 = new Task(()=> DoLongWork(50));
t2.Start();
var t3 = Task.Run(()=> DoLongWork(10));


static void DoLongWork(int num) 
{
    int sum = 0;
    for (int i = 1; i <= num; i ++) {
        sum +=i;
        Thread.Sleep(100);
    }
    Console.WriteLine($"1부터 {num}까지 더한 결과 : {sum}");
}

ReadLine();