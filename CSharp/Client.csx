#! "netcoreapp2.1"
using System.Net;
using System.Net.Sockets;
using static System.Console;


var client = new TcpClient("127.0.0.1",3000);
WriteLine("Connected!");
NetworkStream ns = client.GetStream();

var writer = new StreamWriter(ns);
writer.WriteLine("Hellow TCP World!");
writer.Flush();
WriteLine($"sent : Hellow TCP World!");
var reader = new StreamReader(ns);
string msg = reader.ReadLine();
WriteLine($"received : {msg}");

writer.Close();
reader.Close();

client.Close();
