using static System.Console;

// 전략 패턴 예시
public abstract class ConverterBase {
    public abstract bool IsMyUnit(string name);
    protected abstract double Ratio { get; }
    public abstract string UnitName { get; }
    public double FromMeter (double meter) {
        return meter /Ratio;
    }
    public double ToMeter (double feet) {
        return feet * Ratio;
    }
}

public class DistanceConverter {
    public ConverterBase From { get; private set; }
    public ConverterBase To { get; private set; }

    public DistanceConverter(ConverterBase from, ConverterBase to) {
        From = from;
        To = to;
    }
    public double Convert(double value) {
        var meter = From.ToMeter(value);
        return To.FromMeter(meter);
    }
}

public class MeterConverter : ConverterBase {
    public override string UnitName {get {return "미터";}}

    protected override double Ratio {get {return 1;}}

    public override bool IsMyUnit(string name) {
        return name.ToLower() == "meter" || name.ToLower() == "metre" || name == UnitName;
    }
}

public class KilometerConverter : ConverterBase {
    public override string UnitName {get {return "킬로미터";}}

    protected override double Ratio {get {return 1000;}}

    public override bool IsMyUnit(string name) {
        return name.ToLower() == "kilometer" || name == UnitName;
    }
}


public class MileConverter : ConverterBase {
    public override string UnitName {get {return "마일";}}

    protected override double Ratio {get {return 1609.34;}}

    public override bool IsMyUnit(string name) {
        return name.ToLower() == "mile" || name == UnitName;
    }
}



public class InchConverter : ConverterBase {
    public override string UnitName {get {return "인치";}}

    protected override double Ratio {get {return 0.0254;}}

    public override bool IsMyUnit(string name) {
        return name.ToLower() == "inch" || name == UnitName;
    }
}

public class FeetConverter : ConverterBase {
    public override string UnitName {get {return "피트";}}

    protected override double Ratio {get {return 0.3048;}}

    public override bool IsMyUnit(string name) {
        return name.ToLower() == "feet" || name == UnitName;
    }
}

public class YardConverter : ConverterBase {
    public override string UnitName {get {return "야드";}}

    protected override double Ratio {get {return 0.9144;}}

    public override bool IsMyUnit(string name) {
        return name.ToLower() == "yard" || name == UnitName;
    }
}


ConverterBase[] _converters = new ConverterBase[] {
    new MeterConverter(),
    new FeetConverter(),
    new YardConverter(),
    new InchConverter(),
    new KilometerConverter(),
    new MileConverter(),
};


var from = _converters.FirstOrDefault(x => x.IsMyUnit("마일"));
var to = _converters.FirstOrDefault(x => x.IsMyUnit("킬로미터"));


var Converter = new DistanceConverter(from, to);

var distance = 100.0;
var result = Converter.Convert(distance);

WriteLine($"{distance} {from.UnitName} 은 {result:0.000} {to.UnitName} 입니다.")