
var args = Environment.GetCommandLineArgs();

var files = Directory.EnumerateFiles(args[1],"*.*");
if (!Directory.Exists(args[2]))
    Directory.CreateDirectory(args[2]);
foreach (var file in files) {
    var name = Path.GetFileNameWithoutExtension(file) + "_bak";
    var ext = Path.GetExtension(file);
    File.Copy(file, Path.Combine(args[1], name+ext), overwrite:true);
}