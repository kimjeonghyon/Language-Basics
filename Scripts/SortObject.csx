 public class Person : IComparable<Person>
{
    // fields
    public string Name;
    public int CompareTo(Person other)
    {
        return Name.CompareTo(other.Name);
    }
}

public class PersonComparer : IComparer<Person>
  {
    public int Compare(Person x, Person y)
    {
      int temp = x.Name.Length.CompareTo(y.Name.Length);
      if (temp == 0)
      {
        return x.Name.CompareTo(y.Name);
      }
      else
      {
        return temp;
      }
    }
  }
  
Person[] people =
{
    new Person { Name = "Simon" },
    new Person { Name = "Jenny" },
    new Person { Name = "Adam" },
    new Person { Name = "Richard" }
};

WriteLine("Initial list of people:");
foreach (var person in people)
{
    WriteLine($"{person.Name}");
}

WriteLine("Use Person's sort implementation:");
Array.Sort(people);
foreach (var person in people)
{
    WriteLine($"{person.Name}");
}

WriteLine("Use PersonComparer's sort implementation:");
Array.Sort(people, new PersonComparer());
foreach (var person in people)
{
    WriteLine($"{person.Name}");
}