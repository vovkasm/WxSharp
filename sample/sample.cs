using System;
using org.vovkasm.wx;

public class MyApp : wxApp {
    public wxFrame main_window = null;
    public wxButton btn1 = null;

    public override bool OnInit ()
    {
        Console.WriteLine ("C# OnInit called!");
        main_window = new wxFrame(null, (int)wxStandardID.wxID_ANY, "Hello from C#");

        btn1 = new wxButton( main_window, (int)wxStandardID.wxID_HIGHEST, "Click me", wxsharpglue.wxDefaultPosition, wxsharpglue.wxDefaultSize, 0 );

        main_window.Show ();
        SetTopWindow (main_window);
        return base.OnInit ();
    }

    public override int OnExit ()
    {
        Console.WriteLine ("C# OnExit called!");
        return base.OnExit ();
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
