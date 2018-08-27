using System.Threading;

static Random r = new Random();
static string Message; // a shared resource
static object conch = new object();
static int Counter; // another shared resource

static void MethodA()
{
    if(Monitor.TryEnter(conch, TimeSpan.FromSeconds(15))) {
        try
        {    
            for (int i = 0; i < 5; i++)
            {
                Thread.Sleep(r.Next(2000));
                Message += "A";
                // monitor가 없어도 Counter 값은 thread safe 하다. 
                Interlocked.Increment(ref Counter);
                Write(".");
            }
        }
        finally
        {
            Monitor.Exit(conch);
        }
    }
    
}

static void MethodB()
{
    if (Monitor.TryEnter(conch, TimeSpan.FromSeconds(15)))
    {
        try
        {
            
            for (int i = 0; i < 5; i++)
            {
                Thread.Sleep(r.Next(2000));
                Message += "B";
                Interlocked.Increment(ref Counter);
                Write(".");
            }
        }
        finally
        {
            Monitor.Exit(conch);
        }
    }
}

WriteLine("Please wait for the tasks to complete.");
Stopwatch watch = Stopwatch.StartNew();
Task a = Task.Factory.StartNew(MethodA);
Task b = Task.Factory.StartNew(MethodB);

Task.WaitAll(new Task[] { a, b });
WriteLine();
WriteLine($"Results: {Message}.");
WriteLine($"{watch.ElapsedMilliseconds:#,##0} elapsed milliseconds.");
WriteLine($"{Counter} string modifications.");