var files = Directory.EnumerateFiles("src", "*.*", SearchOption.AllDirectories )
                       .Where(file => {
                           var fi = new FileInfo(file);
                           return fi.Length > 10;
                       });
foreach (var file in files)
{
    Console.WriteLine(file);                
}


string devroot = Path.GetFullPath("../../../");
var di = new DirectoryInfo(devroot);
var files2 = di.EnumerateFiles("*.cs", SearchOption.AllDirectories).Take(20);
foreach (var item in files2) {
    Console.WriteLine("{0} {1}", item.FullName, item.Length);
} 