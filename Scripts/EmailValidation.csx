using System.Text.RegularExpressions;
using static System.Console;

public static bool IsValidEmail(this string input)
{
    // use simple regular expression to check 
    // that the input string is a valid email 
    return Regex.IsMatch(input, @"[a-zA-Z0-9\.-_]+@[a-zA-Z0-9\.-_]+");

}
  
bool bmail = "jeonghyonkim@lgcns.com".IsValidEmail();

WriteLine(bmail)
