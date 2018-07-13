// DI (의존성 주입) 패턴
using System.Text.RegularExpressions;
using static System.Console;

public interface ITextFileService {
    void Initialize(string fname);
    void Execute(string line);
    void Terminate();
}

public class TextFileProcessor {
    private ITextFileService _service;
    public TextFileProcessor(ITextFileService service) {
        _service = service;
    }
    public void Run (string fileName) {
        _service.Initialize(fileName);
        using (var sr = new StreamReader(fileName)) {
            while (!sr.EndOfStream) {
                var line = sr.ReadLine();
                _service.Execute(line);
            }
        }
        _service.Terminate();
    }
}

class ToHankakuService : ITextFileService {
    private static Dictionary<char, char> _dictionary;

    public ToHankakuService() {
        var zenkaku = "０１２３４５６７８９";
        var hankaku = "0123456789";
        _dictionary = zenkaku.Zip(hankaku, (zen,han) => new { zen, han}).ToDictionary(x => x.zen, x => x.han);
        WriteLine($"Dictionary : {_dictionary}");
    }

    public void Execute(string line)
    {
        var s = Regex.Replace(line, "[０-９]", c => _dictionary[c.Value[0]].ToString());
        WriteLine(s);
    }

    public void Initialize(string fname)
    {
    }

    public void Terminate()
    {
    }
}

var processor = new TextFileProcessor(new ToHankakuService());
processor.Run(Args[0]);