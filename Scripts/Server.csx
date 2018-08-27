#! "netcoreapp2.1"

using System.IO;
using System.Net;
using System.Net.Sockets;
using static System.Console;


var listener =new TcpListener(IPAddress.Parse("127.0.0.1"),3000);
listener.Start(); 

TcpClient client = listener.AcceptTcpClient();
WriteLine("Connected!");
NetworkStream ns = client.GetStream();
StreamReader reader = new StreamReader(ns);
string msg = reader.ReadLine();

StreamWriter writer = new StreamWriter(ns);
writer.WriteLine(msg);
writer.Flush();

writer.Close();
reader.Close();

client.Close();
listener.Stop();