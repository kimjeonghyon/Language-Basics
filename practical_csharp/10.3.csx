

using System.Text.RegularExpressions;
using static System.Console;

var texts = new[] {
               "Time is money.",
               "What time is it?",
               "It will take time.",
               "We reorganized the timetable.",
            };

foreach (var line in texts) {
    var matches = Regex.Matches(line, @"\btime\b",RegexOptions.IgnoreCase);
    foreach (Match m in matches){
	    WriteLine($"{line}: {m.Index}");
    }
}

      


