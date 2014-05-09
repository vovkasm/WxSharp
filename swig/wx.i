%module wxsharpglue
%{
#include <wx/wx.h>
%}
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
};

