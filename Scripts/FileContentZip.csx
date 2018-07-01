using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Linq;


static List<string> GetZippedList(string fileName) {
    string devroot = Path.GetFullPath("./data");
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

var zippedList = GetZippedList("ABCDFILE.txt");
zippedList.ForEach(Console.WriteLine);
