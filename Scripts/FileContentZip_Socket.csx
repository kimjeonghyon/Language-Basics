using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Linq;

// 제공되는 클라이언트와 통신하도록 서버를 구현하여 클라이언트로부터 파일명과 암호키를 받아 라인단위로 압축된 문자열을 전송한다. 
// 문자열 암호화 방식 : 클라이언트로 부터 수신받은 암호화키를 압축된 문자열 앞에 붙여서 전송
// ACK 옵션 : 파일명 수신, 암호화키 수신, 암호화된 문자열 전송, ACK 수신, 암호화된 문자열 전송, ACK 수신

using (Socket sock = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp))    {
    IPAddress ipAddress = IPAddress.Parse("127.0.0.1");
    IPEndPoint ep = new IPEndPoint(ipAddress, 9090);
    sock.Bind(ep);
    sock.Listen(10);
    Socket clientSock = sock.Accept();
    byte[] buff = new byte[8192];
    int n = clientSock.Receive(buff);
    string fileName = Encoding.Unicode.GetString(buff, 0, n);
    n = clientSock.Receive(buff);
    string key = Encoding.Unicode.GetString(buff, 0, n);

    Console.WriteLine("key:{0}, fileName:{1}", key, fileName);
    var zippedList = GetZippedList(fileName);

    int sendLine = 0;
    while (true) 
    {
        int nTmp = clientSock.Receive(buff);
        string rcv = Encoding.Unicode.GetString(buff, 0, nTmp);
        Console.WriteLine("Received : {0}", rcv);
        byte[] msg = Encoding.Unicode.GetBytes(key + zippedList[sendLine]);
        clientSock.Send(msg);
        sendLine ++;
        if (zippedList.Count-1 == sendLine) break;
    }  

    sock.Shutdown(SocketShutdown.Both);
}

static List<string> GetZippedList(string fileName) {
    string devroot = Path.GetFullPath("./BIGFILE");
    var di = new DirectoryInfo(devroot);
    // ABCDFILE.txt 를 BIGFILE 하위디렉토리에서 찾아 files 리스트로 저장 
    var files = di.EnumerateFiles(fileName, SearchOption.AllDirectories).Take(20).ToList();

    // ABCDFILE.txt를 읽어서, 1번 문제 수행 (라인 중복 count)
    var lines = File.ReadLines(files[0].FullName)
                    .GroupBy(n=>n)
                    .Select(s => s.Count()>1?""+s.Count()+"#"+s.Key:s.Key);

    
    // 한 줄내에서 3글자 이상 중복 count
    var l2 = lines.Select(line => {
        string[] sa = line.Split('#');
        return string.Concat(sa[0],string.Join("",sa[1].GroupBy(n =>n)
                                                .Select(k =>""+k.Count()+k.Key)));
    });
    
    // 문자열 치환을 한다. 
    // 5개 이전 문자로 치환 (A -> V, Z -> U)
    string sChange = "VWXYZABCDEFHIJKLMNOPQRSTU";
    
    var l3 = new List<string>();
    foreach (var item in l2) {
        StringBuilder sb2 = new StringBuilder();
        foreach (var c in item) {
            var newc = c;
            if (Char.IsLetter(c)) {
                newc = sChange[c-'A'];
            }
            sb2.Append(newc);
        }
        l3.Add(sb2.ToString());
    }
    return l3;
}
