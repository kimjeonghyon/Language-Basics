using System.Text.RegularExpressions;

var lines = File.ReadAllLines("input_10.5.html");

// var newlines = lines.Select(s => Regex.Replace(s,
//     @"<(/?)([A-Z][A-Z0-9]*)(.*?)>",
//     m => {
//         return string.Format("<{0}{1}{2}>"
//          , m.Groups[1].Value, m.Groups[2].Value.ToLower(),
//          m.Groups[3].Value); }));

var newlines = lines.Select(s => Regex.Replace(s,
    @"<(/?)([A-Z][A-Z0-9]*)(.*?)>",
    "<$1"+"$2".ToLower() +"$3>"
    ));

File.WriteAllLines("output_10.5.html", newlines);

