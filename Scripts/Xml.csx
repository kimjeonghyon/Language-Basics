using System.Xml.Linq;

string path = "/Users/Jeonghyonkim/Documents/Dev/Repos/Language-Basics/Scripts/data"; 
XDocument doc = XDocument.Load(Path.Combine(path,"settings.xml"));

var appSettings = doc.Descendants(
    "appSettings").Descendants("add")
    .Select(node => new
    {
        Key = node.Attribute("key").Value,
        Value = node.Attribute("value").Value
    })
    .ToArray();

foreach (var item in appSettings)
{
    WriteLine($"{item.Key}: {item.Value}");
}