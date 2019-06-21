// method with a local function
public int Factorial(int number)
{
    if (number < 0)
    {
        throw new ArgumentException(
            $"{nameof(number)} cannot be less than zero.");
    }

    int localFactorial(int localNumber)
    {
        if (localNumber < 1) return 1;
        return localNumber * localFactorial(localNumber - 1);
    }

    return localFactorial(number);
}

WriteLine($"5! is {Factorial(5)}");