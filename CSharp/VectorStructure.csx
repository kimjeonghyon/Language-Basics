  public struct DisplacementVector
  {
    public int X;
    public int Y;
    public DisplacementVector(int initialX, int initialY)
    {
      X = initialX;
      Y = initialY;
    }

    public static DisplacementVector operator +(
        DisplacementVector vector1, DisplacementVector vector2)
    {
      return new DisplacementVector(vector1.X + vector2.X, vector1.Y + vector2.Y);
    }
  }
var dv1 = new DisplacementVector(3, 5);
var dv2 = new DisplacementVector(-2, 7);
var dv3 = dv1 + dv2;
WriteLine($"({dv1.X}, {dv1.Y}) + ({dv2.X}, {dv2.Y}) = ({dv3.X}, {dv3.Y})");


