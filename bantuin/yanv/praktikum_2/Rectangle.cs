using System;

public class Rectangle
{
    // Properties
    public double Length { get; set; }
    public double Width { get; set; }

    // Constructor
    public Rectangle(double length, double width)
    {
        Length = length;
        Width = width;
    }

    // Method untuk menghitung luas
    public double HitungLuas()
    {
        return Length * Width;
    }

    // Method untuk menghitung keliling
    public double HitungKeliling()
    {
        return 2 * (Length + Width);
    }
}
