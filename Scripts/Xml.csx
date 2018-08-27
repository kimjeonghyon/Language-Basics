using System.Xml.Linq;
using System.Xml;

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


// define an array of strings
string[] callsigns = new string[] { "Husker", "Starbuck", "Apollo", "Boomer", "Bulldog", "Athena", "Helo", "Racetrack" };

// define a file to write to using the XML writer helper
string xmlFile = @"/Users/jeonghyonkim/Downloads/Streams.xml";
// string xmlFile = @"C:\Code\Ch10_Streams.xml";

FileStream xmlFileStream = File.Create(xmlFile);
XmlWriter xml = XmlWriter.Create(xmlFileStream,
    new XmlWriterSettings { Indent = true });

// write the XML declaration
xml.WriteStartDocument();

// write a root element
xml.WriteStartElement("callsigns");

// enumerate the strings writing each one to the stream
foreach (string item in callsigns)
{
    xml.WriteElementString("callsign", item);
}

// write the close root element
xml.WriteEndElement();
xml.Dispose();
xmlFileStream.Dispose();

// output all the contents of the file to the Console
WriteLine($"{xmlFile} contains {new FileInfo(xmlFile).Length} bytes.");
WriteLine(File.ReadAllText(xmlFile));