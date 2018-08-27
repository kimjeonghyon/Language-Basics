// 1. streamreader class 를 이용해 구현
// var count = 0;
// using (var sr = new StreamReader("Program.cs")) {
//     while (!sr.EndOfStream) {
//         var line = sr.ReadLine();
//         if (line.Contains ("class")) count++;
//     }
// }
// Console.WriteLine($"class count :{count}");

// 2. File.ReadAllines 를 이용해 구현
// var count = File.ReadAllLines("Program.cs").Count(s => s.Contains("class"));
// Console.WriteLine(count);

// 3. File.ReadLines 를 이용해 구현
var count = File.ReadLines("Program.cs").Count(s => s.Contains("class"));