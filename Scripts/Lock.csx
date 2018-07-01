using System.Threading.Tasks;
using static System.Console;

static int SharedValue;
static object lockObject = new object(); /* 추가한 부분 */

var t1 = Task.Run(() => Increment());
var t2 = Task.Run(() => Increment());
var t3 = Task.Run(() => Increment());

t1.Wait();
t2.Wait();
t3.Wait();
WriteLine($"SharedValue 변수값 : {SharedValue}");

static void Increment ()
{
    for (int i= 0; i < 100000; i++){
        lock (lockObject) {   /* 추가한 부분 */
            SharedValue = SharedValue +1;
        }
    }
}
