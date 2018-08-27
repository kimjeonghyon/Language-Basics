var lines = File.ReadLines("Program.cs")
                            .Select((s,n) => string.Format("{0,4} : {1}", n+1, s));
var path = Path.ChangeExtension("Program.cs","txt");
File.WriteAllLines(path, lines);


// var file1 = args[0];
// var file2 = args[1];
// File.AppendAllLines(file1, File.ReadLines(file2));