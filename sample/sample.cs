using System;
using org.vovkasm;

public class MyApp : wxApp {
    public override bool OnInit ()
    {
        Console.WriteLine ("C# OnInit called!");
        return base.OnInit ();
    }
    public override int OnRun ()
    {
        Console.WriteLine ("C# OnRun called!");
        return base.OnRun ();
    }
}

public class WxNetSample
{
    static public void Main ()
    {
        MyApp app = new MyApp();
        Console.WriteLine ("Start MainLoop");
        app.MainLoop ();
        Console.WriteLine ("The end!");
    }

}
