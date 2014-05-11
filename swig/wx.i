%module(directors="1") wxsharpglue
%{
#include <wx/wx.h>
%}

%include wchar.i
%include typemaps.i

typedef wchar_t __WCHAR_TYPE__;
%import wx/setup.h
%import wx/chartype.h

%include arrays_csharp.i

CSHARP_ARRAYS(wxChar*, string)
%typemap(imtype, inattributes="[In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex=0, ArraySubType=UnmanagedType.LPStr)]") wxChar *INPUT[] "string[]"

%apply wxChar *INPUT[] { wxChar** argv }

%include wxstring.i

%pragma(csharp) modulecode = %{
    public static bool wxEntry(string[] argv)
    {
        return wxEntry(argv.Length, argv);
    }
%}

bool wxEntry(int argc, wxChar** argv);

// interface/app.h

%feature("director") wxAppConsole;
%feature("director") wxApp;
class wxAppConsole
{
public:
    virtual ~wxAppConsole();
    
    virtual int MainLoop();
    virtual void ExitMainLoop();
    virtual int OnExit();
    virtual bool OnInit();
    virtual int OnRun();
};

class wxApp : public wxAppConsole
{
public:
    wxApp();
    virtual ~wxApp();
    //virtual wxVideoMode GetDisplayMode() const;
    bool GetExitOnFrameDelete() const;
    virtual bool IsActive() const;

    static void SetInstance(wxAppConsole* app);
    static wxAppConsole* GetInstance();
};

// interface/windowid.h

typedef int wxWindowID;

// interface/defs.h
%include defs.i
// interface/gdicmn.h
%include gdicmn.i
// interface/window.h
%include window.i
// interface/nonownedwnd.h
%include nonownedwnd.i
// interface/toplevel.h
%include toplevel.i
// interface/frame.h
%include frame.i
