class wxEventFilter
{
public:
    enum
    {
        Event_Skip = -1,
        Event_Ignore = 0,
        Event_Processed = 1
    };

    wxEventFilter();
    virtual ~wxEventFilter();
    virtual int FilterEvent(wxEvent& event) = 0;
};
