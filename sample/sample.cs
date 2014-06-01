using System;
using org.vovkasm.wx;

public class MyApp : App {
    public Frame main_window = null;

    public override bool OnInit ()
    {
        Console.WriteLine ("C# OnInit called!");
        main_window = new Frame(null, (int)StandardID.ID_ANY, "Hello from C#");

        Button btnExit = new Button( main_window, (int)StandardID.ID_HIGHEST, "Exit" );
        btnExit.BindCommandEvent( OnBtnExitClick );

        main_window.Show ();
        SetTopWindow (main_window);
        SetExitOnFrameDelete (true);
        return base.OnInit ();
    }

    public void OnBtnExitClick (CommandEvent ev)
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
        bool ret = App.Run(new MyApp());
        if (ret)
            Console.WriteLine ("wxEntry return true, ok");
        else
            Console.WriteLine ("wxEntry return false, something bad");

        Console.WriteLine ("The end!");
    }

}
