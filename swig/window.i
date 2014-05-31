class wxWindow : public wxEvtHandler
{
public:
    wxWindow(wxWindow* parent, wxWindowID id);
    virtual ~wxWindow();

    virtual bool Show(bool show = true);
    bool Close(bool force = false);
};
