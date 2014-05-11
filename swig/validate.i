class wxValidator
{
public:
    wxValidator();
    virtual ~wxValidator();
    /* TODO virtual wxObject* Clone() const; */
    wxWindow* GetWindow() const;

    static void SuppressBellOnError(bool suppress = true);
    static bool IsSilent();

    void SetWindow(wxWindow* window);

    virtual bool TransferFromWindow();
    virtual bool TransferToWindow();
    virtual bool Validate(wxWindow* parent);
};

const wxValidator wxDefaultValidator;

