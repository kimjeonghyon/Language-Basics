using System;
using System.IO;
using System.Text;

string devroot = Path.GetFullPath("./");
string target = Path.GetFullPath("../copied");

DirectoryInfo di = new DirectoryInfo(devroot);
DirectoryInfo cp = new DirectoryInfo(target);
if (Directory.Exists(cp.FullName)==false) {
    Directory.CreateDirectory(cp.FullName);
}

FileInfo[] fi = di.GetFiles();
foreach (var f in fi) 
{
    if (f.Length > 500) {
        f.CopyTo(Path.Combine(cp.ToString(),f.Name));     
    }
}
