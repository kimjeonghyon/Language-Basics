// 템플릿 패턴
using System.Text.RegularExpressions;

public abstract class TextProcessor {
    public static void Run<T>(string fileName) where T:TextProcessor, new() {
        var self = new T();
        self.Process(fileName);
    }
    private void Process (string fileName) {
        Initialize(fileName);
        using (var sr = new StreamReader(fileName)) {
            while (!sr.EndOfStream) {
                var line = sr.ReadLine();
                Execute(line);
            }
        }
        Terminate();
    }
    protected virtual void Initialize(string fname) {}
    protected virtual void Execute(string line) {}
    protected virtual void Terminate() {}
}

public class ToHankakuProcess : TextProcessor {
    private static Dictionary<char, char> _dictionary = 
        new Dictionary<char, char> () {
            {'０','0'},{'１','1'},{'２','2'},{'３','3'},{'４','4'},
            {'５','5'},{'６','6'},{'７','7'},{'８','8'},{'９','9'}
        };

        protected override void Execute(string line) {
            var s = Regex.Replace(line, "[０-９]", c => _dictionary[c.Value[0]].ToString());
            Console.WriteLine(s);
        }
}


TextProcessor.Run<ToHankakuProcess>(Args[0]);