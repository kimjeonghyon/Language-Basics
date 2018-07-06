using System.Text.RegularExpressions;


var lines = File.ReadAllLines("input_10.4.txt");
var newlines = lines.Select(s => Regex.Replace(s,@"\bversion\s*=\s*""v4\.0""",@"version=""v5.0""",RegexOptions.IgnoreCase));

File.WriteAllLines("output_10.4.txt", newlines);