enum
{
    wxUSER_ATTENTION_INFO = 1,  ///< Requests user attention,
    wxUSER_ATTENTION_ERROR = 2  ///< Results in a more drastic action.
};

enum
{
    wxFULLSCREEN_NOMENUBAR   = 0x0001,  ///< Don't display the menu bar.
    wxFULLSCREEN_NOTOOLBAR   = 0x0002,  ///< Don't display toolbar bars.
    wxFULLSCREEN_NOSTATUSBAR = 0x0004,  ///< Don't display the status bar.
    wxFULLSCREEN_NOBORDER    = 0x0008,  ///< Don't display any border.
    wxFULLSCREEN_NOCAPTION   = 0x0010,  ///< Don't display a caption.

    wxFULLSCREEN_ALL    = wxFULLSCREEN_NOMENUBAR | wxFULLSCREEN_NOTOOLBAR |
                          wxFULLSCREEN_NOSTATUSBAR | wxFULLSCREEN_NOBORDER |
                          wxFULLSCREEN_NOCAPTION
};

#define wxDEFAULT_FRAME_STYLE (wxSYSTEM_MENU |          \
                               wxRESIZE_BORDER |        \
                               wxMINIMIZE_BOX |         \
                               wxMAXIMIZE_BOX |         \
                               wxCLOSE_BOX |            \
                               wxCAPTION |              \
                               wxCLIP_CHILDREN)

class wxTopLevelWindow : public wxNonOwnedWindow
{
public:
    wxTopLevelWindow();

    wxTopLevelWindow(wxWindow *parent,
                    wxWindowID id,
                    const wxString& title,
                    const wxPoint& pos = wxDefaultPosition,
                    const wxSize& size = wxDefaultSize,
                    long style = wxDEFAULT_FRAME_STYLE,
                    const wxString& name = wxFrameNameStr);

    virtual ~wxTopLevelWindow();

    bool Create(wxWindow *parent,
                wxWindowID id,
                const wxString& title,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = wxDEFAULT_FRAME_STYLE,
                const wxString& name = wxFrameNameStr);

    virtual bool CanSetTransparent();
    void CenterOnScreen(int direction = wxBOTH);
    void CentreOnScreen(int direction = wxBOTH);
    virtual bool EnableCloseButton(bool enable);
    wxWindow* GetDefaultItem() const;
    static wxSize GetDefaultSize();

    /* TODO wxIcon GetIcon() const; */
    /* TODO const wxIconBundle& GetIcons() const; */

    virtual wxString GetTitle() const;
    virtual void Iconize(bool iconize = true);
    virtual bool IsActive();
    virtual bool IsAlwaysMaximized() const;
    virtual bool IsFullScreen() const;
    virtual bool IsIconized() const;
    virtual bool IsMaximized() const;
    virtual bool Layout();
    virtual void Maximize(bool maximize = true);

#ifdef __WXMSW__
    wxMenu *MSWGetSystemMenu() const;
#endif

    virtual void RequestUserAttention(int flags = wxUSER_ATTENTION_INFO);

    wxWindow* SetDefaultItem(wxWindow* win);
    wxWindow* SetTmpDefaultItem(wxWindow * win);
    wxWindow* GetTmpDefaultItem() const;

    /* TODO void SetIcon(const wxIcon& icon); */
    /* TODO virtual void SetIcons(const wxIconBundle& icons); */
    /* TODO void SetLeftMenu(int id = wxID_ANY, const wxString& label = wxEmptyString, wxMenu* subMenu = NULL); */

    virtual void SetMaxSize(const wxSize& size);
    virtual void SetMinSize(const wxSize& size);
    /* TODO void SetRightMenu(int id = wxID_ANY, const wxString& label = wxEmptyString, wxMenu* subMenu = NULL); */
    virtual void SetSizeHints(int minW, int minH, int maxW = -1, int maxH = -1, int incW = -1, int incH = -1);
    void SetSizeHints(const wxSize& minSize, const wxSize& maxSize = wxDefaultSize, const wxSize& incSize = wxDefaultSize);
    virtual void SetTitle(const wxString& title);
    /* TODO virtual bool SetTransparent(wxByte alpha); */
    virtual bool ShouldPreventAppExit() const;
    virtual void OSXSetModified(bool modified);
    virtual bool OSXIsModified() const;
    virtual void SetRepresentedFilename(const wxString& filename);
    virtual void ShowWithoutActivating();
    virtual bool ShowFullScreen(bool show, long style = wxFULLSCREEN_ALL);
};
