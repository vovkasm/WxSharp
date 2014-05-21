#define wxFRAME_NO_TASKBAR      0x0002  // No taskbar button (MSW only)
#define wxFRAME_TOOL_WINDOW     0x0004  // No taskbar button, no system menu
#define wxFRAME_FLOAT_ON_PARENT 0x0008  // Always above its parent

class wxFrame : public wxTopLevelWindow
{
public:
    wxFrame(wxWindow* parent, wxWindowID id, wxString title, wxPoint pos = wxDefaultPosition, wxSize size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, wxString name = wxFrameNameStr);

    virtual ~wxFrame();



    void Centre(int direction = wxBOTH);
    
    /* TODO
    virtual wxStatusBar* CreateStatusBar(int number = 1, long style = wxSTB_DEFAULT_STYLE,
                                         wxWindowID id = 0,
                                         const wxString& name = wxStatusBarNameStr);
                                         */

    /* TODO
    virtual wxToolBar* CreateToolBar(long style = wxTB_DEFAULT_STYLE,
                                     wxWindowID id = wxID_ANY,
                                     const wxString& name = wxToolBarNameStr);
                                     */

    virtual wxPoint GetClientAreaOrigin() const;
    /* TODO virtual wxMenuBar* GetMenuBar() const; */
    /* TODO virtual wxStatusBar* GetStatusBar() const; */

    int GetStatusBarPane() const;
    /* TODO virtual wxToolBar* GetToolBar() const; */

    /* TODO
    virtual wxStatusBar* OnCreateStatusBar(int number, long style,
                                           wxWindowID id,
                                           const wxString& name);
                                           */

    /* TODO
    virtual wxToolBar* OnCreateToolBar(long style, wxWindowID id,
                                       const wxString& name);
    */

    bool ProcessCommand(int id);

    /* TODO virtual void SetMenuBar(wxMenuBar* menuBar); */
    /* TODO virtual void SetStatusBar(wxStatusBar* statusBar); */

    void SetStatusBarPane(int n);
    virtual void SetStatusText(const wxString& text, int number = 0);
    /* TODO arrays virtual void SetStatusWidths(int n, const int* widths_field); */
    /* TODO virtual void SetToolBar(wxToolBar* toolBar); */

    void PushStatusText(const wxString &text, int number = 0);
    void PopStatusText(int number = 0);

};

