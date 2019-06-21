using System;
using System.Text;
using static System.Console;

var str = "test statement";
byte[] byteStr = Encoding.UTF8.GetBytes(str); 
var encodedStr = Convert.ToBase64String(byteStr); WriteLine(encodedStr); 
byte[] decodedBytes = Convert.FromBase64String(encodedStr); WriteLine(Encoding.UTF8.GetString(decodedBytes));
