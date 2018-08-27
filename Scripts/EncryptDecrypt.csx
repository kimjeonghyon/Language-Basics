#load "EncryptionLib.csx"

// Encryption

Write("Enter a message that you want to encrypt: ");
string message = ReadLine();
Write("Enter a password: ");
string password = ReadLine();
string cryptoText = Encrypt(message, password);
WriteLine($"Encrypted text: {cryptoText}");
Write("Enter the password: ");
string password2 = ReadLine();
try
{
    string clearText = Decrypt(cryptoText, password2);
    WriteLine($"Decrypted text: {clearText}");
}
catch
{
    WriteLine(
        "Enable to decrypt because you entered the wrong password!");
}

// Hashing

WriteLine("A user named Alice has been registered with Pa$$w0rd as her password.");
var alice = Register("Alice", "Pa$$w0rd");
WriteLine($"Name: {alice.Name}");
WriteLine($"Salt: {alice.Salt}");
WriteLine(
    $"Salted and hashed password: {alice.SaltedHashedPassword}");
WriteLine();
Write("Enter a different username to register: ");
string username = ReadLine();
Write("Enter a password to register: ");
string password3 = ReadLine();
var user = Register(username, password3);
WriteLine($"Name: {user.Name}");
WriteLine($"Salt: {user.Salt}");
WriteLine(
    $"Salted and hashed password: {user.SaltedHashedPassword}");

bool correctPassword = false;
while (!correctPassword)
{
    Write("Enter a username to log in: ");
    string loginUsername = ReadLine();
    Write("Enter a password to log in: ");
    string loginPassword = ReadLine();
    correctPassword = CheckPassword(
        loginUsername, loginPassword);
    if (correctPassword)
    {
        WriteLine(
            $"Correct! {loginUsername} has been logged in.");
    }
    else
    {
        WriteLine("Invalid username or password. Try again.");
    }
}


// Sign up

Write("Enter some text to sign: ");
string data = ReadLine();
var signature = GenerateSignature(data);
WriteLine($"Signature: {signature}");
WriteLine("Public key used to check signature:");
WriteLine(PublicKey);

if (ValidateSignature(data, signature))
{
  WriteLine("Correct! Signature is valid.");
}
else
{
  WriteLine("Invalid signature.");
}

// create a fake signature by replacing the 
// first character with an X
var fakeSignature = signature.Replace(signature[0], 'X');
if (ValidateSignature(data, fakeSignature))
{
  WriteLine("Correct! Signature is valid.");
}
else
{
  WriteLine($"Invalid signature: {fakeSignature}");
}