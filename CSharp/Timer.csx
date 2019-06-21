using System;
using System.Timers;
using static System.Console;

var aTimer = new Timer();

aTimer.Elapsed+=new ElapsedEventHandler(OnTimedEvent);
aTimer.Interval=5000;
aTimer.Enabled=true;

WriteLine("Press \'q\' to quit.");
    while(Read()!='q');

void OnTimedEvent(object source, ElapsedEventArgs e)
 {
     WriteLine($"timer : {DateTime.Now.ToString()}");
  }