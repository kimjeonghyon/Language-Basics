var names = new List<string> {
                 "Seoul", "New Delhi", "Bangkok", "London", "Paris", "Berlin", "Canberra", "Hong Kong",
            };

// var line = Console.ReadLine();

// var idx = names.FindIndex(s => s == line);
// Console.WriteLine(idx);

// var ct = names.Count(s => s.Contains("o"));
// Console.WriteLine(ct);

// names.Where(s => s.Contains("o"))
//      .ToList()
//      .ForEach(s => Console.WriteLine(s));

names.Where(s => s.StartsWith('B'))
        .Select(s => s.Length)
        .ToList()
        .ForEach(s => Console.WriteLine(s));


var numbers = new List<int> {
    12,87,94,14,53,20,40,35,76,91,31,17,48
};

// var result = numbers.Exists(s=>s % 8 == 0 || s % 9 == 0);

// Console.WriteLine(result);

// numbers.ForEach(s=>Console.WriteLine(s/2.0));

// foreach (var number in numbers.Where(s => s > 50)) {
//     Console.WriteLine(number);
// }

var db = numbers.Select(s => s*2).ToList();
db.ForEach(s => Console.WriteLine(s));
