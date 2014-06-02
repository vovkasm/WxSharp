enum wxEventPropagation
{
    wxEVENT_PROPAGATE_NONE = 0,
    wxEVENT_PROPAGATE_MAX = 2147483647 // TODO INT_MAX
};

enum wxEventCategory
{
    EVT_CATEGORY_UI = 1,
    EVT_CATEGORY_USER_INPUT = 2,
    EVT_CATEGORY_SOCKET = 4,
    EVT_CATEGORY_TIMER = 8,
    EVT_CATEGORY_THREAD = 16,
    EVT_CATEGORY_ALL = EVT_CATEGORY_UI|EVT_CATEGORY_USER_INPUT|EVT_CATEGORY_SOCKET|EVT_CATEGORY_TIMER|EVT_CATEGORY_THREAD
};

class wxEvent : public wxObject
{
public:
    wxEvent(int id, wxEventType eventType);
    virtual wxEvent* Clone() const = 0;
};

%{
template <typename T>
class RefToPtrFunc {
public:
    typedef std::function<void(T*)> Func;
    RefToPtrFunc(Func func) : _func(func) { }
    void operator()(T& event) {
        _func(&event);
    }
private:
    Func _func;
};
%}

%{
typedef void (SWIGSTDCALL *wxCommandEventCallback)(wxCommandEvent*);
%}
typedef void (*wxCommandEventCallback)(wxCommandEvent*);
%pragma(csharp) modulecode=%{
    public delegate void ButtonEventHandler(object sender, CommandEvent ev);
    public delegate void CommandEventCallback(CommandEvent arg);
%}

//%cs_callback(wxCommandEventCallback, wxsharpglue.CommandEventCallback);

%typemap(csimports) wxEvtHandler %{
using global::System;
using global::System.Runtime.InteropServices;
using global::System.ComponentModel;
%}
%typemap(cscode) wxEvtHandler %{
    protected EventHandlerList eventDelegates = new EventHandlerList();

    public event wxsharpglue.ButtonEventHandler ButtonEvent {
        add {
            int key = wxsharpglue.EVT_BUTTON;
            wxsharpglue.ButtonEventHandler handler = (wxsharpglue.ButtonEventHandler)eventDelegates[key];
            eventDelegates.AddHandler(key, value);
            if (handler == null) {
                // Connect
            }
        }
        remove {
            int key = wxsharpglue.EVT_BUTTON;
            eventDelegates.RemoveHandler(key, value);
            wxsharpglue.ButtonEventHandler handler = (wxsharpglue.ButtonEventHandler)eventDelegates[key];
            if (handler == null) {
                // Disconnect
            }
        }
    }

    private global::System.IntPtr WrapCommandEventCallback(wxsharpglue.CommandEventCallback handler) {
        Action<IntPtr> realHandler = delegate(IntPtr arg) {
            CommandEvent ev = new CommandEvent(arg, false);
            handler(ev);
        };
        IntPtr realHandlerPtr = Marshal.GetFunctionPointerForDelegate(realHandler);
        return realHandlerPtr;
    }
%}
%typemap(ctype) wxCommandEventCallback "wxCommandEventCallback"
%typemap(in) wxCommandEventCallback  %{ $1 = ($1_type)$input; %}
%typemap(cstype, out="global::System.IntPtr") wxCommandEventCallback "wxsharpglue.CommandEventCallback"
%typemap(csin) wxCommandEventCallback "WrapCommandEventCallback($csinput)"
%typemap(imtype, out="global::System.IntPtr") wxCommandEventCallback "global::System.IntPtr"

class wxEvtHandler : public wxObject
{
public:

%extend {
    #include <functional>
    void BindCommandEvent(wxCommandEventCallback handler) {
        int id = wxID_ANY;
        int lastId = wxID_ANY;
        RefToPtrFunc<wxCommandEvent> fn(handler);
        $self->Bind(wxEVT_BUTTON, fn, id, lastId);
    }
}

    wxEvtHandler();
    virtual ~wxEvtHandler();
};

class wxCommandEvent : public wxEvent
{
public:
    wxCommandEvent(wxEventType commandEventType, int id);
};

typedef int wxEventType;

#define wxEVT_ANY ((wxEventType)-1)

#define wxDECLARE_EXPORTED_EVENT( name, type ) extern const wxEventTypeTag< type > name

extern const wxEventType wxEVT_NULL;

extern const wxEventType wxEVT_ENTER_WINDOW;
extern const wxEventType wxEVT_LEAVE_WINDOW;
extern const wxEventType wxEVT_BUTTON;
