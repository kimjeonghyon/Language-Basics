using System.Collections.Concurrent;

var q = new ConcurrentQueue<string>();
q.Enqueue( "aaaa");
q.Enqueue( "bbbb");
q.Enqueue( "cccc");

string a ;
q.TryDequeue(out a);
q.TryDequeue(out a);
q.TryDequeue(out a);
q.TryDequeue(out a);
q.TryPeek(out a);
