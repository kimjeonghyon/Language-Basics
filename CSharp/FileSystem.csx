// define a directory path
// string dir = @"C:\Code\Ch10_Example\"; // Windows
using System.IO;
using static System.IO.Directory;
string dir = @"/Users/jeonghyonkim/Downloads/Test"; // macOS

// check if it exists
WriteLine($"Does {dir} exist? {Exists(dir)}");
// create a directory
CreateDirectory(dir);
WriteLine($"Does {dir} exist? {Exists(dir)}");
// delete a directory
Delete(dir);
WriteLine($"Does {dir} exist? {Exists(dir)}");

// string textFile = @"C:\Code\Ch10.txt"; // Windows
// string backupFile = @"C:\Code\Ch10.bak"; // Windows
string textFile = @"/Users/jeonghyonkim/Downloads/Ch10.txt"; // macOS
string backupFile = @"/Users/jeonghyonkim/Downloads/Ch10.bak"; // macOS

// check if a file exists
WriteLine($"Does {textFile} exist? {File.Exists(textFile)}");

// create a new text file and write a line to it
StreamWriter textWriter = File.CreateText(textFile);
textWriter.WriteLine("Hello, C#!");
textWriter.Dispose();
WriteLine($"Does {textFile} exist? {File.Exists(textFile)}");

// copy a file and overwrite if it already exists
File.Copy(textFile, backupFile, true);
WriteLine($"Does {backupFile} exist? {File.Exists(backupFile)}");

// delete a file
File.Delete(textFile);
WriteLine($"Does {textFile} exist? {File.Exists(textFile)}");

// read from a text file
StreamReader textReader = File.OpenText(backupFile);
WriteLine(textReader.ReadToEnd());
textReader.Dispose();

string backup = @"/Users/jeonghyonkim/Downloads/Ch10.bak"; // macOS
// string backup = @"C:\Code\Ch10.bak"; // Windows

WriteLine($"File Name: {Path.GetFileName(textFile)}");
WriteLine($"File Name without Extension: {Path.GetFileNameWithoutExtension(textFile)}");
WriteLine($"File Extension: {Path.GetExtension(textFile)}");
WriteLine($"Random File Name: {Path.GetRandomFileName()}");
WriteLine($"Temporary File Name: {Path.GetTempFileName()}");

var info = new FileInfo(backup);
WriteLine($"{backup} contains {info.Length} bytes.");
WriteLine($"{backup} was last accessed {info.LastAccessTime}.");
WriteLine($"{backup} has readonly set to {info.IsReadOnly}.");


string path = "/Users/jeonghyonkim/Downloads"; // macOS

Stream s = File.Open(
    Path.Combine(path, "file.txt"),
    FileMode.OpenOrCreate);
    
switch (s)
{
    case FileStream writeableFile when s.CanWrite:
        WriteLine("The stream is to a file that I can write to.");
        break;
    case FileStream readOnlyFile:
        WriteLine("The stream is to a read-only file.");
        break;
    case MemoryStream ms:
        WriteLine("The stream is to a memory address.");
        break;
    default: // always evaluated last despite its current position
        WriteLine("The stream is some other type.");
        break;
    case null:
        WriteLine("The stream is null.");
        break;
}
