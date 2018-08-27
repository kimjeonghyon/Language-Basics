#! "netcoreapp2.1"
#load "./data/Library.csx"

// 책목록을 출력할 때 카테고리명도 출력하라
var l = Library.Books
        .Join (Library.Categories, b => b.CategoryId, c => c.Id,
            (b, c) => new {
                PublishedYear = b.PublishedYear,
                Price = b.Price,
                Title = b.Title,
                CategoryName = c.Name
            }
        )
        .OrderByDescending(x=>x.PublishedYear)
        .ThenByDescending(x=>x.Price);
foreach (var i in l) {
    Console.WriteLine($"{i.PublishedYear}년 {i.Price}원 {i.Title}({i.CategoryName})");
}

// 2016년 발간된 책에 대하여 카테고리명을 distinct 로 
var query = Library.Books
            .Where(x=>x.PublishedYear == 2016)
            .Join
            (Library.Categories,
            b => b.CategoryId,
            c => c.Id,
            (b , c)=> c.Name)
            .Distinct();
foreach(var name  in query) {
    Console.WriteLine(name);
}

// 카테고리명으로 그룹핑하여 순서대로 출력
var query = Library.Books
            .Join(Library.Categories,
            b => b.CategoryId,
            c => c.Id,
            (b , c ) => new {
                Categoryname=c.Name,
                b.Title
            })
            .GroupBy(x=>x.Categoryname)
            .OrderBy(x=>x.Key);
foreach (var g in query) {
    Console.WriteLine($"#{g.Key}");
    foreach(var b in g) {
        Console.WriteLine($"    {b.Title}");
    }
}

// Development 카테고리의 책들을 발행년도순으로 그룹바이하여 출력
var cId = Library.Categories
            .Single(x=>x.Name == "Development").Id;
var query = Library.Books
            .Where(x=>x.CategoryId==cId)
            .GroupBy(x=>x.PublishedYear)
            .OrderBy(x=>x.Key);
foreach (var g in query) {
    Console.WriteLine($"#{g.Key}년");
    foreach (var i in g) {
        Console.WriteLine($"    {i.Title}");
    }
}

// Group by Having 의 구현
var query = Library.Categories
            .GroupJoin(
                Library.Books,
                c => c.Id,
                b => b.CategoryId,
                (c,b) => new {
                    CategoryName = c.Name,
                    Count = b.Count()
                })
            .Where(x=>x.Count >=4);
foreach (var g in query) {
    Console.WriteLine($"{g.CategoryName} : {g.Count}");
}