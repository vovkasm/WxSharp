%feature("director") wxApp;

class wxApp : public wxEvtHandler
{
public:
    wxApp();
    virtual ~wxApp();

    virtual int OnExit();
    virtual bool OnInit();

    void SetExitOnFrameDelete(bool flag);
    // TODO: getter/setter bool GetExitOnFrameDelete() const;

    void SetTopWindow(wxWindow* window);
    // TODO: getter/setter wxWindow* GetTopWindow() const;

    static void SetInstance(wxApp* app);
    // TODO: getter/setter static wxApp* GetInstance();
};

