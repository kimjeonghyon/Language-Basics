string path = "/Users/jeonghyonkim/Documents"; // macOS

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
