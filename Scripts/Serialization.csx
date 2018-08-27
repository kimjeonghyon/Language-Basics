#! "netcoreapp1.1"
#r "nuget:Newtonsoft.Json, 9.0.1"
using Newtonsoft.Json;

public class Person
{
    public Person() { }

    public Person(decimal initialSalary)
    {
        Salary = initialSalary;
    }
    
    public string FirstName { get; set; }
    
    public string LastName { get; set; }
    
    public DateTime DateOfBirth { get; set; }
    public HashSet<Person> Children { get; set; }
    protected decimal Salary { get; set; }
}

// create an object graph
var people = new List<Person>
{
    new Person(30000M) { FirstName = "Alice", LastName = "Smith",
        DateOfBirth = new DateTime(1974, 3, 14) },
    new Person(40000M) { FirstName = "Bob", LastName = "Jones",
        DateOfBirth = new DateTime(1969, 11, 23) },
    new Person(20000M) { FirstName = "Charlie", LastName = "Rose",
        DateOfBirth = new DateTime(1964, 5, 4),
        Children = new HashSet<Person>
        { new Person(0M) { FirstName = "Sally", LastName = "Rose",
        DateOfBirth = new DateTime(1990, 7, 12) } } }
};

// create a file to write to
string jsonFilepath = @"/Users/jeonghyonkim/Downloads/People.json";
// string jsonFilepath = @"C:\Code\Ch10_People.json"; // Windows
StreamWriter jsonStream = File.CreateText(jsonFilepath);

// create an object that will format as JSON
var jss = new JsonSerializer();

// serialize the object graph into a string
jss.Serialize(jsonStream, people);

// you must dispose the stream to release the file lock
jsonStream.Dispose();

WriteLine();
WriteLine($"Written {new FileInfo(jsonFilepath).Length} bytes of JSON to: {jsonFilepath}");

// Display the serialized object graph
WriteLine(File.ReadAllText(jsonFilepath));
