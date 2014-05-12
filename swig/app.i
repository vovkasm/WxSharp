%feature("director") wxAppConsole;
%feature("director") wxApp;
class wxAppConsole : public wxEvtHandler
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
    virtual wxWindow* GetTopWindow() const;
    void SetTopWindow(wxWindow* window);

    static void SetInstance(wxAppConsole* app);
    static wxAppConsole* GetInstance();
};

