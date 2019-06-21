using System.Threading;

var outer = Task.Factory.StartNew(() =>
{
    WriteLine("Outer task starting...");
    var inner = Task.Factory.StartNew(() =>
    {
        WriteLine("Inner task starting...");
        Thread.Sleep(2000);
        WriteLine("Inner task finished.");
    }, TaskCreationOptions.AttachedToParent);
});
outer.Wait();
WriteLine("Outer task finished.");
WriteLine("Press ENTER to end.");
ReadLine();