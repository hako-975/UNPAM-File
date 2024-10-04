using System;

public class Student
{
    // Properties
    public string Name { get; set; }
    public int Age { get; set; }
    public double Grade { get; set; }

    // Constructor
    public Student(string name, int age, double grade)
    {
        Name = name;
        Age = age;
        Grade = grade;
    }

    // Method untuk menampilkan informasi siswa
    public void DisplayInfo()
    {
        Console.WriteLine("Nama: " + Name);
        Console.WriteLine("Umur: " + Age);
        Console.WriteLine("Nilai: " + Grade);
    }
}
