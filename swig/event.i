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

extern const wxEventType wxEVT_CHECKBOX;
extern const wxEventType wxEVT_CHOICE;
extern const wxEventType wxEVT_LISTBOX;
extern const wxEventType wxEVT_LISTBOX_DCLICK;
extern const wxEventType wxEVT_CHECKLISTBOX;
extern const wxEventType wxEVT_MENU;
extern const wxEventType wxEVT_SLIDER;
extern const wxEventType wxEVT_RADIOBOX;
extern const wxEventType wxEVT_RADIOBUTTON;
extern const wxEventType wxEVT_SCROLLBAR;
extern const wxEventType wxEVT_VLBOX;
extern const wxEventType wxEVT_COMBOBOX;
extern const wxEventType wxEVT_TOOL_RCLICKED;
extern const wxEventType wxEVT_TOOL_DROPDOWN;
extern const wxEventType wxEVT_TOOL_ENTER;
extern const wxEventType wxEVT_COMBOBOX_DROPDOWN;
extern const wxEventType wxEVT_COMBOBOX_CLOSEUP;
extern const wxEventType wxEVT_THREAD;
extern const wxEventType wxEVT_LEFT_DOWN;
extern const wxEventType wxEVT_LEFT_UP;
extern const wxEventType wxEVT_MIDDLE_DOWN;
extern const wxEventType wxEVT_MIDDLE_UP;
extern const wxEventType wxEVT_RIGHT_DOWN;
extern const wxEventType wxEVT_RIGHT_UP;
extern const wxEventType wxEVT_MOTION;
extern const wxEventType wxEVT_ENTER_WINDOW;
extern const wxEventType wxEVT_LEAVE_WINDOW;
extern const wxEventType wxEVT_LEFT_DCLICK;
extern const wxEventType wxEVT_MIDDLE_DCLICK;
extern const wxEventType wxEVT_RIGHT_DCLICK;
extern const wxEventType wxEVT_SET_FOCUS;
extern const wxEventType wxEVT_KILL_FOCUS;
extern const wxEventType wxEVT_CHILD_FOCUS;
extern const wxEventType wxEVT_MOUSEWHEEL;
extern const wxEventType wxEVT_AUX1_DOWN;
extern const wxEventType wxEVT_AUX1_UP;
extern const wxEventType wxEVT_AUX1_DCLICK;
extern const wxEventType wxEVT_AUX2_DOWN;
extern const wxEventType wxEVT_AUX2_UP;
extern const wxEventType wxEVT_AUX2_DCLICK;
extern const wxEventType wxEVT_CHAR;
extern const wxEventType wxEVT_CHAR_HOOK;
extern const wxEventType wxEVT_NAVIGATION_KEY;
extern const wxEventType wxEVT_KEY_DOWN;
extern const wxEventType wxEVT_KEY_UP;
extern const wxEventType wxEVT_HOTKEY;
extern const wxEventType wxEVT_SET_CURSOR;
extern const wxEventType wxEVT_SCROLL_TOP;
extern const wxEventType wxEVT_SCROLL_BOTTOM;
extern const wxEventType wxEVT_SCROLL_LINEUP;
extern const wxEventType wxEVT_SCROLL_LINEDOWN;
extern const wxEventType wxEVT_SCROLL_PAGEUP;
extern const wxEventType wxEVT_SCROLL_PAGEDOWN;
extern const wxEventType wxEVT_SCROLL_THUMBTRACK;
extern const wxEventType wxEVT_SCROLL_THUMBRELEASE;
extern const wxEventType wxEVT_SCROLL_CHANGED;
extern const wxEventType wxEVT_SPIN_UP;
extern const wxEventType wxEVT_SPIN_DOWN;
extern const wxEventType wxEVT_SPIN;
extern const wxEventType wxEVT_SCROLLWIN_TOP;
extern const wxEventType wxEVT_SCROLLWIN_BOTTOM;
extern const wxEventType wxEVT_SCROLLWIN_LINEUP;
extern const wxEventType wxEVT_SCROLLWIN_LINEDOWN;
extern const wxEventType wxEVT_SCROLLWIN_PAGEUP;
extern const wxEventType wxEVT_SCROLLWIN_PAGEDOWN;
extern const wxEventType wxEVT_SCROLLWIN_THUMBTRACK;
extern const wxEventType wxEVT_SCROLLWIN_THUMBRELEASE;
extern const wxEventType wxEVT_SIZE;
extern const wxEventType wxEVT_MOVE;
extern const wxEventType wxEVT_CLOSE_WINDOW;
extern const wxEventType wxEVT_END_SESSION;
extern const wxEventType wxEVT_QUERY_END_SESSION;
extern const wxEventType wxEVT_ACTIVATE_APP;
extern const wxEventType wxEVT_ACTIVATE;
extern const wxEventType wxEVT_CREATE;
extern const wxEventType wxEVT_DESTROY;
extern const wxEventType wxEVT_SHOW;
extern const wxEventType wxEVT_ICONIZE;
extern const wxEventType wxEVT_MAXIMIZE;
extern const wxEventType wxEVT_MOUSE_CAPTURE_CHANGED;
extern const wxEventType wxEVT_MOUSE_CAPTURE_LOST;
extern const wxEventType wxEVT_PAINT;
extern const wxEventType wxEVT_ERASE_BACKGROUND;
extern const wxEventType wxEVT_NC_PAINT;
extern const wxEventType wxEVT_MENU_OPEN;
extern const wxEventType wxEVT_MENU_CLOSE;
extern const wxEventType wxEVT_MENU_HIGHLIGHT;
extern const wxEventType wxEVT_CONTEXT_MENU;
extern const wxEventType wxEVT_SYS_COLOUR_CHANGED;
extern const wxEventType wxEVT_DISPLAY_CHANGED;
extern const wxEventType wxEVT_QUERY_NEW_PALETTE;
extern const wxEventType wxEVT_PALETTE_CHANGED;
extern const wxEventType wxEVT_JOY_BUTTON_DOWN;
extern const wxEventType wxEVT_JOY_BUTTON_UP;
extern const wxEventType wxEVT_JOY_MOVE;
extern const wxEventType wxEVT_JOY_ZMOVE;
extern const wxEventType wxEVT_DROP_FILES;
extern const wxEventType wxEVT_INIT_DIALOG;
extern const wxEventType wxEVT_IDLE;
extern const wxEventType wxEVT_UPDATE_UI;
extern const wxEventType wxEVT_SIZING;
extern const wxEventType wxEVT_MOVING;
extern const wxEventType wxEVT_MOVE_START;
extern const wxEventType wxEVT_MOVE_END;
extern const wxEventType wxEVT_HIBERNATE;
extern const wxEventType wxEVT_TEXT_COPY;
extern const wxEventType wxEVT_TEXT_CUT;
extern const wxEventType wxEVT_TEXT_PASTE;
extern const wxEventType wxEVT_COMMAND_LEFT_CLICK;
extern const wxEventType wxEVT_COMMAND_LEFT_DCLICK;
extern const wxEventType wxEVT_COMMAND_RIGHT_CLICK;
extern const wxEventType wxEVT_COMMAND_RIGHT_DCLICK;
extern const wxEventType wxEVT_COMMAND_SET_FOCUS;
extern const wxEventType wxEVT_COMMAND_KILL_FOCUS;
extern const wxEventType wxEVT_COMMAND_ENTER;
extern const wxEventType wxEVT_HELP;
extern const wxEventType wxEVT_DETAILED_HELP;
extern const wxEventType wxEVT_TOOL;
extern const wxEventType wxEVT_WINDOW_MODAL_DIALOG_CLOSED;
extern const wxEventType wxEVT_BUTTON;
