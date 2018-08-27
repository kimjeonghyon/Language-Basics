#! "netcoreapp1.1"
#r "nuget:Microsoft.EntityFrameworkCore.Sqlite, 1.1.1"
#load "ConsoleLogger.csx"

using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Logging;

public class Category
{
  public int CategoryID { get; set; }
  public string CategoryName { get; set; }

  [Column(TypeName = "ntext")]
  public string Description { get; set; }

  // defines a navigation property for related rows
  public virtual ICollection<Product> Products { get; set; }

  public Category()
  {
    this.Products = new List<Product>();
  }
}

public class Product
{
  public int ProductID { get; set; }

  [Required]
  [StringLength(40)]
  public string ProductName { get; set; }

  [Column(TypeName = "money")]
  public decimal? UnitPrice { get; set; }

  // these two define the foreign key relationship
  // to the Categories table
  public int CategoryID { get; set; }
  public virtual Category Category { get; set; }
}

// this manages the connection to the database
public class Northwind : DbContext
{
  // these properties map to tables in the database
  public DbSet<Category> Categories { get; set; }
  public DbSet<Product> Products { get; set; }

  protected override void OnConfiguring(
    DbContextOptionsBuilder optionsBuilder)
  {
    // for Microsoft SQL Server
    // optionsBuilder.UseSqlServer(
    // @"Data Source=(localdb)\mssqllocaldb;" +
    // "Initial Catalog=Northwind;" +
    // "Integrated Security=true;");

    // for SQLite
    optionsBuilder.UseSqlite(
      "Filename=/Users/Jeonghyonkim/Documents/Dev/Repos/Language-Basics/Scripts/data/Northwind.db");
  }

  protected override void OnModelCreating(
    ModelBuilder modelBuilder)
  {
    // example of using Fluent API instead of attributes
    modelBuilder.Entity<Category>()
    .Property(category => category.CategoryName)
    .IsRequired()
    .HasMaxLength(40);
  }
}


using (var db = new Northwind())
{
  using (IDbContextTransaction t =db.Database.BeginTransaction())
  {
    WriteLine($"Transaction started with this isolation level: {t.GetDbTransaction().IsolationLevel}");

    var loggerFactory = db.GetService<ILoggerFactory>();
    loggerFactory.AddProvider(new ConsoleLogProvider());

    WriteLine("List of categories and the number of products:");

    IQueryable<Category> cats;
    // = db.Categories.Include(c => c.Products);

    Write("Enable eager loading? (Y/N): ");
    bool eagerloading = (ReadKey().Key == ConsoleKey.Y);
    bool explicitloading = false;
    WriteLine();
    if (eagerloading)
    {
      cats = db.Categories.Include(c => c.Products);
    }
    else
    {
      cats = db.Categories;
      Write("Enable explicit loading? (Y/N): ");
      explicitloading = (ReadKey().Key == ConsoleKey.Y);
      WriteLine();
    }


    foreach (Category c in cats)
    {
      if (explicitloading)
      {
        Write($"Explicitly load products for {c.CategoryName}? (Y/N): ");
        if (ReadKey().Key == ConsoleKey.Y)
        {
          var products = db.Entry(c).Collection(c2 => c2.Products);
          if (!products.IsLoaded) products.Load();
        }
        WriteLine();
      }

      WriteLine($"{c.CategoryName} has {c.Products.Count} products.");
    }

    WriteLine("List of products that cost more than a given price with most expensive first.");
    string input;
    decimal price;
    do
    {
        Write("Enter a product price: ");
        input = ReadLine();
    } while (!decimal.TryParse(input, out price));

    IQueryable<Product> prods = db.Products
        .Where(product => product.UnitPrice > price)
        .OrderByDescending(product => product.UnitPrice);

    foreach (Product item in prods)
    {
        WriteLine($"{item.ProductID}: {item.ProductName} costs {item.UnitPrice:$#,##0.00}");
    }

    var newProduct = new Product
    {
        CategoryID = 6, // Meat & Poultry
        ProductName = "Bob's Burger",
        UnitPrice = 500M
    };
    // mark product as added in change tracking
    db.Products.Add(newProduct);
    // save tracked changes to database
    db.SaveChanges();
    foreach (var item in db.Products)
    {
        WriteLine($"{item.ProductID}: {item.ProductName} costs {item.UnitPrice:$#,##0.00}");
    }

    Product updateProduct = db.Products.First(
      p => p.ProductName.StartsWith("Bob"));
    updateProduct.UnitPrice += 20M;
    db.SaveChanges();
    foreach (var item in db.Products)
    {
        WriteLine($"{item.ProductID}: {item.ProductName} costs {item.UnitPrice:$#,##0.00}");
    }

    Product deleteProduct = db.Products.First(
      p => p.ProductName.StartsWith("Bob"));
    db.Products.Remove(deleteProduct);
    db.SaveChanges();
    foreach (var item in db.Products)
    {
        WriteLine($"{item.ProductID}: {item.ProductName} costs {item.UnitPrice:$#,##0.00}");
    }

    t.Commit();
  }
}