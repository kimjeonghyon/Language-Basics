using System;
using static System.Console;
using System.IO;

WriteLine("Before parsing");
Write("What is your age? ");
string input = Console.ReadLine();
try
{
    int age = int.Parse(input);
    WriteLine($"You are {age} years old.");
}
catch (OverflowException)
{
    WriteLine("Your age is a valid number format but it is either too big or small.");
}
catch (FormatException)
{
    WriteLine("The age you entered is not a valid number format.");
}
catch (Exception ex)
{
    WriteLine($"{ex.GetType()} says {ex.Message}");
}
WriteLine("After parsing");

string path = "/Users/Jeonghyonkim/Document"; // macOS

FileStream file = null;
StreamWriter writer = null;
try
{
    if (Directory.Exists(path))
    {
        file = File.OpenWrite(Path.Combine(path, "file.txt"));
        writer = new StreamWriter(file);
        writer.WriteLine("Hello, C#!");
    }
    else
    {
        WriteLine($"{path} does not exist!");
    }
}
catch (Exception ex)
{
    // if the path doesn't exist the exception will be caught
    //WriteLine($"{ex.GetType()} says {ex.Message}");
     WriteLine("Exception When file1 Write");
}
finally
{
    if (writer != null)
    {
        writer.Dispose();
        WriteLine("The writer's unmanaged resources have been disposed.");
    }
    if (file != null)
    {
        file.Dispose();
        WriteLine("The file's unmanaged resources have been disposed.");
    }
}

if (!Directory.Exists(path)) {
    WriteLine("Directory does not exists..");
    return;
}

using (FileStream file2 = File.OpenWrite(
  Path.Combine(path, "file2.txt")))
{
    using (StreamWriter writer2 = new StreamWriter(file2))
    {
        try
        {
            writer2.WriteLine("Welcome, .NET Core!");
        }
        catch (Exception ex)
        {
            WriteLine("Exception When file2 Write");
            //WriteLine($"{ex.GetType()} says {ex.Message}");
        }
    } // automatically calls Dispose if the object is not null
} // automatically calls Dispose if the object is not null


