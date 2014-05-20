using System;
using org.vovkasm.wx;

public class MyApp : wxApp {
    public wxFrame main_window = null;

    public override bool OnInit ()
    {
        Console.WriteLine ("C# OnInit called!");
        main_window = new wxFrame(null, (int)wxStandardID.wxID_ANY, "Hello from C#");

        wxButton btnExit = new wxButton( main_window, (int)wxStandardID.wxID_HIGHEST, "Exit" );
        btnExit.BindCommandEvent( OnBtnExitClick );

        main_window.Show ();
        SetTopWindow (main_window);
        SetExitOnFrameDelete (true);
        return base.OnInit ();
    }

    public void OnBtnExitClick (wxCommandEvent ev)
    {
        Console.WriteLine ("BtnExit clicked!");
        main_window.Close(true);
    }

    public override int OnExit ()
    {
        Console.WriteLine ("C# OnExit called!");
        //return base.OnExit ();
        return 1;
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
