using System;
using org.vovkasm.wx;

public class MyApp : wxApp {
    public override bool OnInit ()
    {
        Console.WriteLine ("C# OnInit called!");
        return base.OnInit ();
    }
}

public class WxNetSample
{
    static public void Main ()
    {
        string[] args = new string[0];
        MyApp app = new MyApp();

        MyApp.SetInstance(app);
        bool ret = wxsharpglue.wxEntry(args);
        if (ret)
            Console.WriteLine ("wxEntry return true, ok");
        else
            Console.WriteLine ("wxEntry return false, something bad");

        Console.WriteLine ("The end!");
    }

}
