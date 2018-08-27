private static async void RunAsync() {
    var text = await TextReaderSample.ReadTextAsync("oop.md");
    Console.WriteLine(text);
}

static class TextReaderSample {
    public static async Task<string> ReadTextAsync(string filePath) {
        var sb = new StringBuilder();
        var sr = new StreamReader(filePath);
        while (!sr.EndOfStream) {
            var line = await sr.ReadLineAsync();
            sb.AppendLine(line);
        }
        return sb.ToString();
    }
}

RunAsync();
// 비동기로 동작하므로 여기서 사용자의 키 입력을 기다리게 해서 프로그램이 끝나지 않게 한다
// Main 메서드에는 async를 사용하지 않는다
Console.ReadLine();