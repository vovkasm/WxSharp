enum wxEventPropagation
{
    wxEVENT_PROPAGATE_NONE = 0,
    wxEVENT_PROPAGATE_MAX = 2147483647 // TODO INT_MAX
};

enum wxEventCategory
{
    wxEVT_CATEGORY_UI = 1,
    wxEVT_CATEGORY_USER_INPUT = 2,
    wxEVT_CATEGORY_SOCKET = 4,
    wxEVT_CATEGORY_TIMER = 8,
    wxEVT_CATEGORY_THREAD = 16,
    wxEVT_CATEGORY_ALL = wxEVT_CATEGORY_UI|wxEVT_CATEGORY_USER_INPUT|wxEVT_CATEGORY_SOCKET|wxEVT_CATEGORY_TIMER|wxEVT_CATEGORY_THREAD
};

class wxEvent : public wxObject
{
public:
    wxEvent(int id = 0, wxEventType eventType = wxEVT_NULL);
    virtual wxEvent* Clone() const = 0;
    wxObject* GetEventObject() const;
    wxEventType GetEventType() const;
    virtual wxEventCategory GetEventCategory() const;
    int GetId() const;
    wxObject *GetEventUserData() const;
    bool GetSkipped() const;
    long GetTimestamp() const;
    bool IsCommandEvent() const;
    void ResumePropagation(int propagationLevel);
    void SetEventObject(wxObject* object);
    void SetEventType(wxEventType type);
    void SetId(int id);
    void SetTimestamp(long timeStamp = 0);
    bool ShouldPropagate() const;
    void Skip(bool skip = true);
    int StopPropagation();
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
    public delegate void CommandEventCallback(wxCommandEvent arg);
%}

//%cs_callback(wxCommandEventCallback, wxsharpglue.CommandEventCallback);

%typemap(cscode) wxEvtHandler %{
    private global::System.IntPtr WrapCommandEventCallback(wxsharpglue.CommandEventCallback handler) {
        Action<IntPtr> realHandler = delegate(IntPtr arg) {
            wxCommandEvent ev = new wxCommandEvent(arg, false);
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
    virtual void QueueEvent(wxEvent *event);
    virtual void AddPendingEvent(const wxEvent& event);

    /* TODO Is this needed at all? 
    template<typename T, typename T1, ...>
    void CallAfter(void (T::*method)(T1, ...), T1 x1, ...);
    
    template<typename T>
    void CallAfter(const T& functor);
    */
    virtual bool ProcessEvent(wxEvent& event);
    bool ProcessEventLocally(wxEvent& event);
    bool SafelyProcessEvent(wxEvent& event);
    void ProcessPendingEvents();
    void DeletePendingEvents();

    /* TODO Is this needed?
    void Connect(int id, int lastId, wxEventType eventType,
                 wxObjectEventFunction function,
                 wxObject* userData = NULL,
                 wxEvtHandler* eventSink = NULL);
    void Connect(int id, wxEventType eventType,
                 wxObjectEventFunction function,
                 wxObject* userData = NULL,
                 wxEvtHandler* eventSink = NULL);
    void Connect(wxEventType eventType,
                 wxObjectEventFunction function,
                 wxObject* userData = NULL,
                 wxEvtHandler* eventSink = NULL);

    bool Disconnect(wxEventType eventType,
                    wxObjectEventFunction function,
                    wxObject* userData = NULL,
                    wxEvtHandler* eventSink = NULL);
    bool Disconnect(int id = wxID_ANY,
                    wxEventType eventType = wxEVT_NULL,
                    wxObjectEventFunction function = NULL,
                    wxObject* userData = NULL,
                    wxEvtHandler* eventSink = NULL);
    bool Disconnect(int id, int lastId,
                    wxEventType eventType,
                    wxObjectEventFunction function = NULL,
                    wxObject* userData = NULL,
                    wxEvtHandler* eventSink = NULL);
    */

    template <typename EventTag, typename Functor>
    void Bind(const EventTag& eventType,
              Functor functor,
              int id = wxID_ANY,
              int lastId = wxID_ANY,
              wxObject *userData = NULL);

    /* TODO
    template <typename EventTag, typename Class, typename EventArg, typename EventHandler>
    void Bind(const EventTag &eventType,
              void (Class::*method)(EventArg &),
              EventHandler *handler,
              int id = wxID_ANY,
              int lastId = wxID_ANY,
              wxObject *userData = NULL);
    */

    template <typename EventTag, typename Functor>
    bool Unbind(const EventTag& eventType,
                Functor functor,
                int id = wxID_ANY,
                int lastId = wxID_ANY,
                wxObject *userData = NULL);

    /* TODO
    template <typename EventTag, typename Class, typename EventArg, typename EventHandler>
    bool Unbind(const EventTag &eventType,
                void (Class::*method)(EventArg&),
                EventHandler *handler,
                int id = wxID_ANY,
                int lastId = wxID_ANY,
                wxObject *userData = NULL );
    */

    /* TODO Is this api really needed?
    void* GetClientData() const; 
    wxClientData* GetClientObject() const; 
    void SetClientData(void* data);
    void SetClientObject(wxClientData* data);
    */

    bool GetEvtHandlerEnabled() const;
    wxEvtHandler* GetNextHandler() const;
    wxEvtHandler* GetPreviousHandler() const;
    void SetEvtHandlerEnabled(bool enabled);
    virtual void SetNextHandler(wxEvtHandler* handler);
    virtual void SetPreviousHandler(wxEvtHandler* handler);

    void Unlink();
    bool IsUnlinked() const;

    static void AddFilter(wxEventFilter* filter);
    static void RemoveFilter(wxEventFilter* filter);

protected:
    /* TODO
    virtual bool TryBefore(wxEvent& event);
    virtual bool TryAfter(wxEvent& event);
    */
};

enum wxKeyCategoryFlags
{
    WXK_CATEGORY_ARROW,
    WXK_CATEGORY_PAGING,
    WXK_CATEGORY_JUMP,
    WXK_CATEGORY_TAB,
    WXK_CATEGORY_CUT,
    WXK_CATEGORY_NAVIGATION
};

class wxKeyEvent : public wxEvent /* TODO , public wxKeyboardState */
{
public:
    wxKeyEvent(wxEventType keyEventType = wxEVT_NULL);
    int GetKeyCode() const;
    bool IsKeyInCategory(int category) const;
    wxPoint GetPosition() const;

    wxUint32 GetRawKeyCode() const;
    wxUint32 GetRawKeyFlags() const;
    wxChar GetUnicodeKey() const;
    wxCoord GetX() const;
    wxCoord GetY() const;
    void DoAllowNextEvent();
    bool IsNextEventAllowed() const;
};

enum
{
    wxJOYSTICK1,
    wxJOYSTICK2
};

enum
{
    wxJOY_BUTTON_ANY = -1,
    wxJOY_BUTTON1    = 1,
    wxJOY_BUTTON2    = 2,
    wxJOY_BUTTON3    = 4,
    wxJOY_BUTTON4    = 8
};

class wxJoystickEvent : public wxEvent
{
public:
    wxJoystickEvent(wxEventType eventType = wxEVT_NULL, int state = 0, int joystick = wxJOYSTICK1, int change = 0);
    bool ButtonDown(int button = wxJOY_BUTTON_ANY) const;
    bool ButtonIsDown(int button = wxJOY_BUTTON_ANY) const;
    bool ButtonUp(int button = wxJOY_BUTTON_ANY) const;
    int GetButtonChange() const;
    int GetButtonState() const;
    int GetJoystick() const;
    wxPoint GetPosition() const;
    int GetZPosition() const;
    bool IsButton() const;
    bool IsMove() const;
    bool IsZMove() const;
};

class wxScrollWinEvent : public wxEvent
{
public:
    wxScrollWinEvent(wxEventType commandType = wxEVT_NULL, int pos = 0, int orientation = 0);
    int GetOrientation() const;
    int GetPosition() const;

    void SetOrientation(int orient);
    void SetPosition(int pos);    
};

class wxSysColourChangedEvent : public wxEvent
{
public:
    wxSysColourChangedEvent();
};

class wxCommandEvent : public wxEvent
{
public:
    wxCommandEvent(wxEventType commandEventType = wxEVT_NULL, int id = 0);
    /* TODO void* GetClientData() const; */
    /* TODO wxClientData* GetClientObject() const; */
    long GetExtraLong() const;
    int GetInt() const;
    int GetSelection() const;
    wxString GetString() const;
    bool IsChecked() const;
    bool IsSelection() const;
    /* TODO void SetClientData(void* clientData); */
    /* TODO void SetClientObject(wxClientData* clientObject); */
    void SetExtraLong(long extraLong);
    void SetInt(int intCommand);
    void SetString(const wxString& string);
};



/**
    @class wxWindowCreateEvent

    This event is sent just after the actual window associated with a wxWindow
    object has been created.

    Since it is derived from wxCommandEvent, the event propagates up
    the window hierarchy.

    @beginEventTable{wxWindowCreateEvent}
    @event{EVT_WINDOW_CREATE(func)}
        Process a @c wxEVT_CREATE event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events, wxWindowDestroyEvent
*/
class wxWindowCreateEvent : public wxCommandEvent
{
public:
    /**
        Constructor.
    */
    wxWindowCreateEvent(wxWindow* win = NULL);

    /// Return the window being created.
    wxWindow *GetWindow() const;
};



/**
    @class wxPaintEvent

    A paint event is sent when a window's contents needs to be repainted.

    The handler of this event must create a wxPaintDC object and use it for
    painting the window contents. For example:
    @code
    void MyWindow::OnPaint(wxPaintEvent& event)
    {
        wxPaintDC dc(this);

        DrawMyDocument(dc);
    }
    @endcode

    Notice that you must @e not create other kinds of wxDC (e.g. wxClientDC or
    wxWindowDC) in EVT_PAINT handlers and also don't create wxPaintDC outside
    of this event handlers.


    You can optimize painting by retrieving the rectangles that have been damaged
    and only repainting these. The rectangles are in terms of the client area,
    and are unscrolled, so you will need to do some calculations using the current
    view position to obtain logical, scrolled units.
    Here is an example of using the wxRegionIterator class:
    @code
    // Called when window needs to be repainted.
    void MyWindow::OnPaint(wxPaintEvent& event)
    {
        wxPaintDC dc(this);

        // Find Out where the window is scrolled to
        int vbX,vbY;                     // Top left corner of client
        GetViewStart(&vbX,&vbY);

        int vX,vY,vW,vH;                 // Dimensions of client area in pixels
        wxRegionIterator upd(GetUpdateRegion()); // get the update rect list

        while (upd)
        {
            vX = upd.GetX();
            vY = upd.GetY();
            vW = upd.GetW();
            vH = upd.GetH();

            // Alternatively we can do this:
            // wxRect rect(upd.GetRect());

            // Repaint this rectangle
            ...some code...

            upd ++ ;
        }
    }
    @endcode

    @remarks
    Please notice that in general it is impossible to change the drawing of a
    standard control (such as wxButton) and so you shouldn't attempt to handle
    paint events for them as even if it might work on some platforms, this is
    inherently not portable and won't work everywhere.


    @beginEventTable{wxPaintEvent}
    @event{EVT_PAINT(func)}
        Process a @c wxEVT_PAINT event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events
*/
class wxPaintEvent : public wxEvent
{
public:
    /**
        Constructor.
    */
    wxPaintEvent(int id = 0);
};



/**
    @class wxMaximizeEvent

    An event being sent when a top level window is maximized. Notice that it is
    not sent when the window is restored to its original size after it had been
    maximized, only a normal wxSizeEvent is generated in this case.

    Currently this event is only generated in wxMSW, wxGTK, wxOSX/Cocoa and wxOS2
    ports so portable programs should only rely on receiving @c wxEVT_SIZE and
    not necessarily this event when the window is maximized.

    @beginEventTable{wxMaximizeEvent}
    @event{EVT_MAXIMIZE(func)}
        Process a @c wxEVT_MAXIMIZE event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events, wxTopLevelWindow::Maximize,
         wxTopLevelWindow::IsMaximized
*/
class wxMaximizeEvent : public wxEvent
{
public:
    /**
        Constructor. Only used by wxWidgets internally.
    */
    wxMaximizeEvent(int id = 0);
};

/**
    The possibles modes to pass to wxUpdateUIEvent::SetMode().
*/
enum wxUpdateUIMode
{
        /** Send UI update events to all windows. */
    wxUPDATE_UI_PROCESS_ALL,

        /** Send UI update events to windows that have
            the wxWS_EX_PROCESS_UI_UPDATES flag specified. */
    wxUPDATE_UI_PROCESS_SPECIFIED
};


/**
    @class wxUpdateUIEvent

    This class is used for pseudo-events which are called by wxWidgets
    to give an application the chance to update various user interface elements.

    Without update UI events, an application has to work hard to check/uncheck,
    enable/disable, show/hide, and set the text for elements such as menu items
    and toolbar buttons. The code for doing this has to be mixed up with the code
    that is invoked when an action is invoked for a menu item or button.

    With update UI events, you define an event handler to look at the state of the
    application and change UI elements accordingly. wxWidgets will call your member
    functions in idle time, so you don't have to worry where to call this code.

    In addition to being a clearer and more declarative method, it also means you don't
    have to worry whether you're updating a toolbar or menubar identifier. The same
    handler can update a menu item and toolbar button, if the identifier is the same.
    Instead of directly manipulating the menu or button, you call functions in the event
    object, such as wxUpdateUIEvent::Check. wxWidgets will determine whether such a
    call has been made, and which UI element to update.

    These events will work for popup menus as well as menubars. Just before a menu is
    popped up, wxMenu::UpdateUI is called to process any UI events for the window that
    owns the menu.

    If you find that the overhead of UI update processing is affecting your application,
    you can do one or both of the following:
    @li Call wxUpdateUIEvent::SetMode with a value of wxUPDATE_UI_PROCESS_SPECIFIED,
        and set the extra style wxWS_EX_PROCESS_UI_UPDATES for every window that should
        receive update events. No other windows will receive update events.
    @li Call wxUpdateUIEvent::SetUpdateInterval with a millisecond value to set the delay
        between updates. You may need to call wxWindow::UpdateWindowUI at critical points,
        for example when a dialog is about to be shown, in case the user sees a slight
        delay before windows are updated.

    Note that although events are sent in idle time, defining a wxIdleEvent handler
    for a window does not affect this because the events are sent from wxWindow::OnInternalIdle
    which is always called in idle time.

    wxWidgets tries to optimize update events on some platforms.
    On Windows and GTK+, events for menubar items are only sent when the menu is about
    to be shown, and not in idle time.


    @beginEventTable{wxUpdateUIEvent}
    @event{EVT_UPDATE_UI(id, func)}
        Process a @c wxEVT_UPDATE_UI event for the command with the given id.
    @event{EVT_UPDATE_UI_RANGE(id1, id2, func)}
        Process a @c wxEVT_UPDATE_UI event for any command with id included in the given range.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events
*/
class wxUpdateUIEvent : public wxCommandEvent
{
public:
    /**
        Constructor.
    */
    wxUpdateUIEvent(wxWindowID commandId = 0);

    /**
        Returns @true if it is appropriate to update (send UI update events to)
        this window.

        This function looks at the mode used (see wxUpdateUIEvent::SetMode),
        the wxWS_EX_PROCESS_UI_UPDATES flag in @a window, the time update events
        were last sent in idle time, and the update interval, to determine whether
        events should be sent to this window now. By default this will always
        return @true because the update mode is initially wxUPDATE_UI_PROCESS_ALL
        and the interval is set to 0; so update events will be sent as often as
        possible. You can reduce the frequency that events are sent by changing the
        mode and/or setting an update interval.

        @see ResetUpdateTime(), SetUpdateInterval(), SetMode()
    */
    static bool CanUpdate(wxWindow* window);

    /**
        Check or uncheck the UI element.
    */
    void Check(bool check);

    /**
        Enable or disable the UI element.
    */
    void Enable(bool enable);

    /**
        Returns @true if the UI element should be checked.
    */
    bool GetChecked() const;

    /**
        Returns @true if the UI element should be enabled.
    */
    bool GetEnabled() const;

    /**
        Static function returning a value specifying how wxWidgets will send update
        events: to all windows, or only to those which specify that they will process
        the events.

        @see SetMode()
    */
    static wxUpdateUIMode GetMode();

    /**
        Returns @true if the application has called Check().
        For wxWidgets internal use only.
    */
    bool GetSetChecked() const;

    /**
        Returns @true if the application has called Enable().
        For wxWidgets internal use only.
    */
    bool GetSetEnabled() const;

    /**
        Returns @true if the application has called Show().
        For wxWidgets internal use only.
    */
    bool GetSetShown() const;

    /**
        Returns @true if the application has called SetText().
        For wxWidgets internal use only.
    */
    bool GetSetText() const;

    /**
        Returns @true if the UI element should be shown.
    */
    bool GetShown() const;

    /**
        Returns the text that should be set for the UI element.
    */
    wxString GetText() const;

    /**
        Returns the current interval between updates in milliseconds.
        The value -1 disables updates, 0 updates as frequently as possible.

        @see SetUpdateInterval().
    */
    static long GetUpdateInterval();

    /**
        Used internally to reset the last-updated time to the current time.

        It is assumed that update events are normally sent in idle time, so this
        is called at the end of idle processing.

        @see CanUpdate(), SetUpdateInterval(), SetMode()
    */
    static void ResetUpdateTime();

    /**
        Specify how wxWidgets will send update events: to all windows, or only to
        those which specify that they will process the events.

        @param mode
            this parameter may be one of the ::wxUpdateUIMode enumeration values.
            The default mode is wxUPDATE_UI_PROCESS_ALL.
    */
    static void SetMode(wxUpdateUIMode mode);

    /**
        Sets the text for this UI element.
    */
    void SetText(const wxString& text);

    /**
        Sets the interval between updates in milliseconds.

        Set to -1 to disable updates, or to 0 to update as frequently as possible.
        The default is 0.

        Use this to reduce the overhead of UI update events if your application
        has a lot of windows. If you set the value to -1 or greater than 0,
        you may also need to call wxWindow::UpdateWindowUI at appropriate points
        in your application, such as when a dialog is about to be shown.
    */
    static void SetUpdateInterval(long updateInterval);

    /**
        Show or hide the UI element.
    */
    void Show(bool show);
};



/**
    @class wxClipboardTextEvent

    This class represents the events generated by a control (typically a
    wxTextCtrl but other windows can generate these events as well) when its
    content gets copied or cut to, or pasted from the clipboard.

    There are three types of corresponding events @c wxEVT_TEXT_COPY,
    @c wxEVT_TEXT_CUT and @c wxEVT_TEXT_PASTE.

    If any of these events is processed (without being skipped) by an event
    handler, the corresponding operation doesn't take place which allows to
    prevent the text from being copied from or pasted to a control. It is also
    possible to examine the clipboard contents in the PASTE event handler and
    transform it in some way before inserting in a control -- for example,
    changing its case or removing invalid characters.

    Finally notice that a CUT event is always preceded by the COPY event which
    makes it possible to only process the latter if it doesn't matter if the
    text was copied or cut.

    @note
    These events are currently only generated by wxTextCtrl in wxGTK and wxOSX
    but are also generated by wxComboBox without wxCB_READONLY style in wxMSW.

    @beginEventTable{wxClipboardTextEvent}
    @event{EVT_TEXT_COPY(id, func)}
           Some or all of the controls content was copied to the clipboard.
    @event{EVT_TEXT_CUT(id, func)}
           Some or all of the controls content was cut (i.e. copied and
           deleted).
    @event{EVT_TEXT_PASTE(id, func)}
           Clipboard content was pasted into the control.
    @endEventTable


    @library{wxcore}
    @category{events}

    @see wxClipboard
*/
class wxClipboardTextEvent : public wxCommandEvent
{
public:
    /**
        Constructor.
    */
    wxClipboardTextEvent(wxEventType commandType = wxEVT_NULL, int id = 0);
};

/**
    Possible axis values for mouse wheel scroll events.

    @since 2.9.4
 */
enum wxMouseWheelAxis
{
    wxMOUSE_WHEEL_VERTICAL,     ///< Vertical scroll event.
    wxMOUSE_WHEEL_HORIZONTAL    ///< Horizontal scroll event.
};


/**
    @class wxMouseEvent

    This event class contains information about the events generated by the mouse:
    they include mouse buttons press and release events and mouse move events.

    All mouse events involving the buttons use @c wxMOUSE_BTN_LEFT for the
    left mouse button, @c wxMOUSE_BTN_MIDDLE for the middle one and
    @c wxMOUSE_BTN_RIGHT for the right one. And if the system supports more
    buttons, the @c wxMOUSE_BTN_AUX1 and @c wxMOUSE_BTN_AUX2 events
    can also be generated. Note that not all mice have even a middle button so a
    portable application should avoid relying on the events from it (but the right
    button click can be emulated using the left mouse button with the control key
    under Mac platforms with a single button mouse).

    For the @c wxEVT_ENTER_WINDOW and @c wxEVT_LEAVE_WINDOW events
    purposes, the mouse is considered to be inside the window if it is in the
    window client area and not inside one of its children. In other words, the
    parent window receives @c wxEVT_LEAVE_WINDOW event not only when the
    mouse leaves the window entirely but also when it enters one of its children.

    The position associated with a mouse event is expressed in the window
    coordinates of the window which generated the event, you can use
    wxWindow::ClientToScreen() to convert it to screen coordinates and possibly
    call wxWindow::ScreenToClient() next to convert it to window coordinates of
    another window.

    @note Note that under Windows CE mouse enter and leave events are not natively
          supported by the system but are generated by wxWidgets itself. This has several
          drawbacks: the LEAVE_WINDOW event might be received some time after the mouse
          left the window and the state variables for it may have changed during this time.

    @note Note the difference between methods like wxMouseEvent::LeftDown and
          the inherited wxMouseState::LeftIsDown: the former returns @true when
          the event corresponds to the left mouse button click while the latter
          returns @true if the left mouse button is currently being pressed.
          For example, when the user is dragging the mouse you can use
          wxMouseEvent::LeftIsDown to test whether the left mouse button is
          (still) depressed. Also, by convention, if wxMouseEvent::LeftDown
          returns @true, wxMouseEvent::LeftIsDown will also return @true in
          wxWidgets whatever the underlying GUI behaviour is (which is
          platform-dependent). The same applies, of course, to other mouse
          buttons as well.


    @beginEventTable{wxMouseEvent}
    @event{EVT_LEFT_DOWN(func)}
        Process a @c wxEVT_LEFT_DOWN event. The handler of this event should normally
        call event.Skip() to allow the default processing to take place as otherwise
        the window under mouse wouldn't get the focus.
    @event{EVT_LEFT_UP(func)}
        Process a @c wxEVT_LEFT_UP event.
    @event{EVT_LEFT_DCLICK(func)}
        Process a @c wxEVT_LEFT_DCLICK event.
    @event{EVT_MIDDLE_DOWN(func)}
        Process a @c wxEVT_MIDDLE_DOWN event.
    @event{EVT_MIDDLE_UP(func)}
        Process a @c wxEVT_MIDDLE_UP event.
    @event{EVT_MIDDLE_DCLICK(func)}
        Process a @c wxEVT_MIDDLE_DCLICK event.
    @event{EVT_RIGHT_DOWN(func)}
        Process a @c wxEVT_RIGHT_DOWN event.
    @event{EVT_RIGHT_UP(func)}
        Process a @c wxEVT_RIGHT_UP event.
    @event{EVT_RIGHT_DCLICK(func)}
        Process a @c wxEVT_RIGHT_DCLICK event.
    @event{EVT_MOUSE_AUX1_DOWN(func)}
        Process a @c wxEVT_AUX1_DOWN event.
    @event{EVT_MOUSE_AUX1_UP(func)}
        Process a @c wxEVT_AUX1_UP event.
    @event{EVT_MOUSE_AUX1_DCLICK(func)}
        Process a @c wxEVT_AUX1_DCLICK event.
    @event{EVT_MOUSE_AUX2_DOWN(func)}
        Process a @c wxEVT_AUX2_DOWN event.
    @event{EVT_MOUSE_AUX2_UP(func)}
        Process a @c wxEVT_AUX2_UP event.
    @event{EVT_MOUSE_AUX2_DCLICK(func)}
        Process a @c wxEVT_AUX2_DCLICK event.
    @event{EVT_MOTION(func)}
        Process a @c wxEVT_MOTION event.
    @event{EVT_ENTER_WINDOW(func)}
        Process a @c wxEVT_ENTER_WINDOW event.
    @event{EVT_LEAVE_WINDOW(func)}
        Process a @c wxEVT_LEAVE_WINDOW event.
    @event{EVT_MOUSEWHEEL(func)}
        Process a @c wxEVT_MOUSEWHEEL event.
    @event{EVT_MOUSE_EVENTS(func)}
        Process all mouse events.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see wxKeyEvent
*/
class wxMouseEvent : public wxEvent /* TODO, public wxMouseState */
{
public:
    /**
        Constructor. Valid event types are:

         @li @c wxEVT_ENTER_WINDOW
         @li @c wxEVT_LEAVE_WINDOW
         @li @c wxEVT_LEFT_DOWN
         @li @c wxEVT_LEFT_UP
         @li @c wxEVT_LEFT_DCLICK
         @li @c wxEVT_MIDDLE_DOWN
         @li @c wxEVT_MIDDLE_UP
         @li @c wxEVT_MIDDLE_DCLICK
         @li @c wxEVT_RIGHT_DOWN
         @li @c wxEVT_RIGHT_UP
         @li @c wxEVT_RIGHT_DCLICK
         @li @c wxEVT_AUX1_DOWN
         @li @c wxEVT_AUX1_UP
         @li @c wxEVT_AUX1_DCLICK
         @li @c wxEVT_AUX2_DOWN
         @li @c wxEVT_AUX2_UP
         @li @c wxEVT_AUX2_DCLICK
         @li @c wxEVT_MOTION
         @li @c wxEVT_MOUSEWHEEL
    */
    wxMouseEvent(wxEventType mouseEventType = wxEVT_NULL);

    /**
        Returns @true if the event was a first extra button double click.
    */
    bool Aux1DClick() const;

    /**
        Returns @true if the first extra button mouse button changed to down.
    */
    bool Aux1Down() const;

    /**
        Returns @true if the first extra button mouse button changed to up.
    */
    bool Aux1Up() const;

    /**
        Returns @true if the event was a second extra button double click.
    */
    bool Aux2DClick() const;

    /**
        Returns @true if the second extra button mouse button changed to down.
    */
    bool Aux2Down() const;

    /**
        Returns @true if the second extra button mouse button changed to up.
    */
    bool Aux2Up() const;

    /**
        Returns @true if the event was generated by the specified button.

        @see wxMouseState::ButtoinIsDown()
    */
    bool Button(wxMouseButton but) const;

    /**
        If the argument is omitted, this returns @true if the event was a mouse
        double click event. Otherwise the argument specifies which double click event
        was generated (see Button() for the possible values).
    */
    bool ButtonDClick(wxMouseButton but = wxMOUSE_BTN_ANY) const;

    /**
        If the argument is omitted, this returns @true if the event was a mouse
        button down event. Otherwise the argument specifies which button-down event
        was generated (see Button() for the possible values).
    */
    bool ButtonDown(wxMouseButton but = wxMOUSE_BTN_ANY) const;

    /**
        If the argument is omitted, this returns @true if the event was a mouse
        button up event. Otherwise the argument specifies which button-up event
        was generated (see Button() for the possible values).
    */
    bool ButtonUp(wxMouseButton but = wxMOUSE_BTN_ANY) const;

    /**
        Returns @true if this was a dragging event (motion while a button is depressed).

        @see Moving()
    */
    bool Dragging() const;

    /**
        Returns @true if the mouse was entering the window.

        @see Leaving()
    */
    bool Entering() const;

    /**
        Returns the mouse button which generated this event or @c wxMOUSE_BTN_NONE
        if no button is involved (for mouse move, enter or leave event, for example).
        Otherwise @c wxMOUSE_BTN_LEFT is returned for the left button down, up and
        double click events, @c wxMOUSE_BTN_MIDDLE and @c wxMOUSE_BTN_RIGHT
        for the same events for the middle and the right buttons respectively.
    */
    int GetButton() const;

    /**
        Returns the number of mouse clicks for this event: 1 for a simple click, 2
        for a double-click, 3 for a triple-click and so on.

        Currently this function is implemented only in wxMac and returns -1 for the
        other platforms (you can still distinguish simple clicks from double-clicks as
        they generate different kinds of events however).

        @since 2.9.0
    */
    int GetClickCount() const;

    /**
        Returns the configured number of lines (or whatever) to be scrolled per
        wheel action.

        Default value under most platforms is three.

        @see GetColumnsPerAction()
    */
    int GetLinesPerAction() const;

    /**
        Returns the configured number of columns (or whatever) to be scrolled per
        wheel action.

        Default value under most platforms is three.

        @see GetLinesPerAction()

        @since 2.9.5
    */
    int GetColumnsPerAction() const;

    /**
        Returns the logical mouse position in pixels (i.e.\ translated according to the
        translation set for the DC, which usually indicates that the window has been
        scrolled).
    */
    wxPoint GetLogicalPosition(const wxDC& dc) const;

    /**
        Get wheel delta, normally 120.

        This is the threshold for action to be taken, and one such action
        (for example, scrolling one increment) should occur for each delta.
    */
    int GetWheelDelta() const;

    /**
        Get wheel rotation, positive or negative indicates direction of rotation.

        Current devices all send an event when rotation is at least +/-WheelDelta, but
        finer resolution devices can be created in the future.

        Because of this you shouldn't assume that one event is equal to 1 line, but you
        should be able to either do partial line scrolling or wait until several
        events accumulate before scrolling.
    */
    int GetWheelRotation() const;

    /**
        Gets the axis the wheel operation concerns.

        Usually the mouse wheel is used to scroll vertically so @c
        wxMOUSE_WHEEL_VERTICAL is returned but some mice (and most trackpads)
        also allow to use the wheel to scroll horizontally in which case
        @c wxMOUSE_WHEEL_HORIZONTAL is returned.

        Notice that before wxWidgets 2.9.4 this method returned @c int.
    */
    wxMouseWheelAxis GetWheelAxis() const;

    /**
        Returns @true if the event was a mouse button event (not necessarily a button
        down event - that may be tested using ButtonDown()).
    */
    bool IsButton() const;

    /**
        Returns @true if the system has been setup to do page scrolling with
        the mouse wheel instead of line scrolling.
    */
    bool IsPageScroll() const;

    /**
        Returns @true if the mouse was leaving the window.

        @see Entering().
    */
    bool Leaving() const;

    /**
        Returns @true if the event was a left double click.
    */
    bool LeftDClick() const;

    /**
        Returns @true if the left mouse button changed to down.
    */
    bool LeftDown() const;

    /**
        Returns @true if the left mouse button changed to up.
    */
    bool LeftUp() const;

    /**
        Returns @true if the Meta key was down at the time of the event.
    */
    bool MetaDown() const;

    /**
        Returns @true if the event was a middle double click.
    */
    bool MiddleDClick() const;

    /**
        Returns @true if the middle mouse button changed to down.
    */
    bool MiddleDown() const;

    /**
        Returns @true if the middle mouse button changed to up.
    */
    bool MiddleUp() const;

    /**
        Returns @true if this was a motion event and no mouse buttons were pressed.
        If any mouse button is held pressed, then this method returns @false and
        Dragging() returns @true.
    */
    bool Moving() const;

    /**
        Returns @true if the event was a right double click.
    */
    bool RightDClick() const;

    /**
        Returns @true if the right mouse button changed to down.
    */
    bool RightDown() const;

    /**
        Returns @true if the right mouse button changed to up.
    */
    bool RightUp() const;
};



/**
    @class wxDropFilesEvent

    This class is used for drop files events, that is, when files have been dropped
    onto the window. This functionality is currently only available under Windows.

    The window must have previously been enabled for dropping by calling
    wxWindow::DragAcceptFiles().

    Important note: this is a separate implementation to the more general drag and drop
    implementation documented in the @ref overview_dnd. It uses the older, Windows
    message-based approach of dropping files.

    @beginEventTable{wxDropFilesEvent}
    @event{EVT_DROP_FILES(func)}
        Process a @c wxEVT_DROP_FILES event.
    @endEventTable

    @onlyfor{wxmsw}

    @library{wxcore}
    @category{events}

    @see @ref overview_events
*/
class wxDropFilesEvent : public wxEvent
{
public:
    /**
        Constructor.
    */
    wxDropFilesEvent(wxEventType id = 0, int noFiles = 0,
                     wxString* files = NULL);

    /**
        Returns an array of filenames.
    */
    wxString* GetFiles() const;

    /**
        Returns the number of files dropped.
    */
    int GetNumberOfFiles() const;

    /**
        Returns the position at which the files were dropped.
        Returns an array of filenames.
    */
    wxPoint GetPosition() const;
};



/**
    @class wxActivateEvent

    An activate event is sent when a window or application is being activated
    or deactivated.

    @beginEventTable{wxActivateEvent}
    @event{EVT_ACTIVATE(func)}
        Process a @c wxEVT_ACTIVATE event.
    @event{EVT_ACTIVATE_APP(func)}
        Process a @c wxEVT_ACTIVATE_APP event.
        This event is received by the wxApp-derived instance only.
    @event{EVT_HIBERNATE(func)}
        Process a hibernate event, supplying the member function. This event applies
        to wxApp only, and only on Windows SmartPhone and PocketPC.
        It is generated when the system is low on memory; the application should free
        up as much memory as possible, and restore full working state when it receives
        a @c wxEVT_ACTIVATE or @c wxEVT_ACTIVATE_APP event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events, wxApp::IsActive
*/
class wxActivateEvent : public wxEvent
{
public:
    /**
        Specifies the reason for the generation of this event.

        See GetActivationReason().

        @since 3.0
    */
    enum Reason
    {
        /// Window activated by mouse click.
        Reason_Mouse,
        /// Window was activated with some other method than mouse click.
        Reason_Unknown
    };

    /**
        Constructor.
    */
    wxActivateEvent(wxEventType eventType = wxEVT_NULL, bool active = true,
                    int id = 0, Reason ActivationReason = Reason_Unknown);

    /**
        Returns @true if the application or window is being activated, @false otherwise.
    */
    bool GetActive() const;

    /**
        Allows to check if the window was activated by clicking it with the
        mouse or in some other way.

        This method is currently only implemented in wxMSW and returns @c
        Reason_Mouse there if the window was activated by a mouse click and @c
        Reason_Unknown if it was activated in any other way (e.g. from
        keyboard or programmatically).

        Under all the other platforms, @c Reason_Unknown is always returned.

        @since 3.0
    */
    Reason GetActivationReason() const;
};



/**
    @class wxContextMenuEvent

    This class is used for context menu events, sent to give
    the application a chance to show a context (popup) menu for a wxWindow.

    Note that if wxContextMenuEvent::GetPosition returns wxDefaultPosition, this
    means that the event originated from a keyboard context button event, and you
    should compute a suitable position yourself, for example by calling wxGetMousePosition().

    Notice that the exact sequence of mouse events is different across the
    platforms. For example, under MSW the context menu event is generated after
    @c EVT_RIGHT_UP event and only if it was not handled but under GTK the
    context menu event is generated after @c EVT_RIGHT_DOWN event. This is
    correct in the sense that it ensures that the context menu is shown
    according to the current platform UI conventions and also means that you
    must not handle (or call wxEvent::Skip() in your handler if you do have
    one) neither right mouse down nor right mouse up event if you plan on
    handling @c EVT_CONTEXT_MENU event.

    @beginEventTable{wxContextMenuEvent}
    @event{EVT_CONTEXT_MENU(func)}
        A right click (or other context menu command depending on platform) has been detected.
    @endEventTable


    @library{wxcore}
    @category{events}

    @see wxCommandEvent, @ref overview_events
*/
class wxContextMenuEvent : public wxCommandEvent
{
public:
    /**
        Constructor.
    */
    wxContextMenuEvent(wxEventType type = wxEVT_NULL, int id = 0,
                       const wxPoint& pos = wxDefaultPosition);

    /**
        Returns the position in screen coordinates at which the menu should be shown.
        Use wxWindow::ScreenToClient to convert to client coordinates.

        You can also omit a position from  wxWindow::PopupMenu in order to use
        the current mouse pointer position.

        If the event originated from a keyboard event, the value returned from this
        function will be wxDefaultPosition.
    */
    const wxPoint& GetPosition() const;

    /**
        Sets the position at which the menu should be shown.
    */
    void SetPosition(const wxPoint& point);
};



/**
    @class wxEraseEvent

    An erase event is sent when a window's background needs to be repainted.

    On some platforms, such as GTK+, this event is simulated (simply generated just
    before the paint event) and may cause flicker. It is therefore recommended that
    you set the text background colour explicitly in order to prevent flicker.
    The default background colour under GTK+ is grey.

    To intercept this event, use the EVT_ERASE_BACKGROUND macro in an event table
    definition.

    You must use the device context returned by GetDC() to draw on, don't create
    a wxPaintDC in the event handler.

    @beginEventTable{wxEraseEvent}
    @event{EVT_ERASE_BACKGROUND(func)}
        Process a @c wxEVT_ERASE_BACKGROUND event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events
*/
class wxEraseEvent : public wxEvent
{
public:
    /**
        Constructor.
    */
    wxEraseEvent(int id = 0, wxDC* dc = NULL);

    /**
        Returns the device context associated with the erase event to draw on.

        The returned pointer is never @NULL.
    */
    wxDC* GetDC() const;
};



/**
    @class wxFocusEvent

    A focus event is sent when a window's focus changes. The window losing focus
    receives a "kill focus" event while the window gaining it gets a "set focus" one.

    Notice that the set focus event happens both when the user gives focus to the
    window (whether using the mouse or keyboard) and when it is done from the
    program itself using wxWindow::SetFocus.

    The focus event handlers should almost invariably call wxEvent::Skip() on
    their event argument to allow the default handling to take place. Failure
    to do this may result in incorrect behaviour of the native controls. Also
    note that wxEVT_KILL_FOCUS handler must not call wxWindow::SetFocus() as
    this, again, is not supported by all native controls. If you need to do
    this, consider using the @ref sec_delayed_action described in wxIdleEvent
    documentation.

    @beginEventTable{wxFocusEvent}
    @event{EVT_SET_FOCUS(func)}
        Process a @c wxEVT_SET_FOCUS event.
    @event{EVT_KILL_FOCUS(func)}
        Process a @c wxEVT_KILL_FOCUS event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events
*/
class wxFocusEvent : public wxEvent
{
public:
    /**
        Constructor.
    */
    wxFocusEvent(wxEventType eventType = wxEVT_NULL, int id = 0);

    /**
        Returns the window associated with this event, that is the window which had the
        focus before for the @c wxEVT_SET_FOCUS event and the window which is
        going to receive focus for the @c wxEVT_KILL_FOCUS one.

        Warning: the window pointer may be @NULL!
    */
    wxWindow *GetWindow() const;

    void SetWindow(wxWindow *win);
};



/**
    @class wxChildFocusEvent

    A child focus event is sent to a (parent-)window when one of its child windows
    gains focus, so that the window could restore the focus back to its corresponding
    child if it loses it now and regains later.

    Notice that child window is the direct child of the window receiving event.
    Use wxWindow::FindFocus() to retrieve the window which is actually getting focus.

    @beginEventTable{wxChildFocusEvent}
    @event{EVT_CHILD_FOCUS(func)}
        Process a @c wxEVT_CHILD_FOCUS event.
    @endEventTable

    @library{wxcore}
    @category{events}

    @see @ref overview_events
*/
class wxChildFocusEvent : public wxCommandEvent
{
public:
    /**
        Constructor.

        @param win
            The direct child which is (or which contains the window which is) receiving
            the focus.
    */
    wxChildFocusEvent(wxWindow* win = NULL);

    /**
        Returns the direct child which receives the focus, or a (grand-)parent of the
        control receiving the focus.

        To get the actually focused control use wxWindow::FindFocus.
    */
    wxWindow *GetWindow() const;
};



/**
    @class wxMouseCaptureLostEvent

    A mouse capture lost event is sent to a window that had obtained mouse capture,
    which was subsequently lost due to an "external" event (for example, when a dialog
    box is shown or if another application captures the mouse).

    If this happens, this event is sent to all windows that are on the capture stack
    (i.e. called CaptureMouse, but didn't call ReleaseMouse yet). The event is
    not sent if the capture changes because of a call to CaptureMouse or
    ReleaseMouse.

    This event is currently emitted under Windows only.

    @beginEventTable{wxMouseCaptureLostEvent}
    @event{EVT_MOUSE_CAPTURE_LOST(func)}
        Process a @c wxEVT_MOUSE_CAPTURE_LOST event.
    @endEventTable

    @onlyfor{wxmsw}

    @library{wxcore}
    @category{events}

    @see wxMouseCaptureChangedEvent, @ref overview_events,
         wxWindow::CaptureMouse, wxWindow::ReleaseMouse, wxWindow::GetCapture
*/
class wxMouseCaptureLostEvent : public wxEvent
{
public:
    /**
        Constructor.
    */
    wxMouseCaptureLostEvent(wxWindowID windowId = 0);
};



class wxDisplayChangedEvent : public wxEvent
{
public:
    wxDisplayChangedEvent();
};


class wxPaletteChangedEvent : public wxEvent
{
public:
    wxPaletteChangedEvent(wxWindowID winid = 0);

    void SetChangedWindow(wxWindow* win);
    wxWindow* GetChangedWindow() const;
};


class wxQueryNewPaletteEvent : public wxEvent
{
public:
    wxQueryNewPaletteEvent(wxWindowID winid = 0);
    
    void SetPaletteRealized(bool realized);
    bool GetPaletteRealized();
};

class wxNotifyEvent : public wxCommandEvent
{
public:
    wxNotifyEvent(wxEventType eventType = wxEVT_NULL, int id = 0);
    void Allow();
    bool IsAllowed() const;
    void Veto();
};

class wxThreadEvent : public wxEvent
{
public:
    wxThreadEvent(wxEventType eventType = wxEVT_THREAD, int id = wxID_ANY);
    virtual wxEvent *Clone() const;
    virtual wxEventCategory GetEventCategory() const;

    /* TODO 
    template<typename T>
    void SetPayload(const T& payload);

    template<typename T>
    T GetPayload() const;
    */
    long GetExtraLong() const;
    int GetInt() const;
    wxString GetString() const;
    void SetExtraLong(long extraLong);
    void SetInt(int intCommand);
    void SetString(const wxString& string);
};

class wxHelpEvent : public wxCommandEvent
{
public:
    enum Origin
    {
        Origin_Unknown,    /**< unrecognized event source. */
        Origin_Keyboard,   /**< event generated from F1 key press. */
        Origin_HelpButton
    };
    wxHelpEvent(wxEventType type = wxEVT_NULL, wxWindowID winid = 0, const wxPoint& pt = wxDefaultPosition, wxHelpEvent::Origin origin = Origin_Unknown);
    wxHelpEvent::Origin GetOrigin() const;
    const wxPoint& GetPosition() const;
    void SetOrigin(wxHelpEvent::Origin origin);
    void SetPosition(const wxPoint& pt);
};

class wxScrollEvent : public wxCommandEvent
{
public:
    wxScrollEvent(wxEventType commandType = wxEVT_NULL, int id = 0, int pos = 0, int orientation = 0);
    int GetOrientation() const;
    int GetPosition() const;
    void SetOrientation(int orient);
    void SetPosition(int pos);    
};

enum wxIdleMode
{
    wxIDLE_PROCESS_ALL,
    wxIDLE_PROCESS_SPECIFIED
};

class wxIdleEvent : public wxEvent
{
public:
    wxIdleEvent();
    static wxIdleMode GetMode();
    bool MoreRequested() const;
    void RequestMore(bool needMore = true);
    static void SetMode(wxIdleMode mode);
};

class wxInitDialogEvent : public wxEvent
{
public:
    wxInitDialogEvent(int id = 0);
};

class wxWindowDestroyEvent : public wxCommandEvent
{
public:
    wxWindowDestroyEvent(wxWindow* win = NULL);
    wxWindow *GetWindow() const;
};

class wxNavigationKeyEvent : public wxEvent
{
public:
    enum wxNavigationKeyEventFlags
    {
        IsBackward = 0x0000,
        IsForward = 0x0001,
        WinChange = 0x0002,
        FromTab = 0x0004
    };

    wxNavigationKeyEvent();
    wxNavigationKeyEvent(const wxNavigationKeyEvent& event);
    wxWindow* GetCurrentFocus() const;
    bool GetDirection() const;
    bool IsFromTab() const;
    bool IsWindowChange() const;
    void SetCurrentFocus(wxWindow* currentFocus);
    void SetDirection(bool direction);
    void SetFlags(long flags);
    void SetFromTab(bool fromTab);
    void SetWindowChange(bool windowChange);
};

class wxMouseCaptureChangedEvent : public wxEvent
{
public:
    wxMouseCaptureChangedEvent(wxWindowID windowId = 0, wxWindow* gainedCapture = NULL);
    wxWindow* GetCapturedWindow() const;
};

class wxCloseEvent : public wxEvent
{
public:
    wxCloseEvent(wxEventType commandEventType = wxEVT_NULL, int id = 0);
    bool CanVeto() const;
    bool GetLoggingOff() const;
    void SetCanVeto(bool canVeto);
    void SetLoggingOff(bool loggingOff);
    void Veto(bool veto = true);
    bool GetVeto() const;
};

/* TODO
class wxMenuEvent : public wxEvent
{
public:
    wxMenuEvent(wxEventType type = wxEVT_NULL, int id = 0, wxMenu* menu = NULL);
    wxMenu* GetMenu() const;
    int GetMenuId() const;
    bool IsPopup() const;
};
*/

class wxShowEvent : public wxEvent
{
public:
    wxShowEvent(int winid = 0, bool show = false);
    void SetShow(bool show);
    bool IsShown() const;
};

class wxIconizeEvent : public wxEvent
{
public:
    wxIconizeEvent(int id = 0, bool iconized = true);
    bool IsIconized() const;
};

class wxMoveEvent : public wxEvent
{
public:
    wxMoveEvent(const wxPoint& pt, int id = 0);
    wxPoint GetPosition() const;
    wxRect GetRect() const;
    void SetRect(const wxRect& rect);
    void SetPosition(const wxPoint& pos);    
};

class wxSizeEvent : public wxEvent
{
public:
    wxSizeEvent(const wxSize& sz, int id = 0);
    wxSize GetSize() const;
    void SetSize(wxSize size);
    wxRect GetRect() const;
    void SetRect(wxRect rect);
};

class wxSetCursorEvent : public wxEvent
{
public:
    wxSetCursorEvent(wxCoord x = 0, wxCoord y = 0);
    /* TODO const wxCursor& GetCursor() const; */
    wxCoord GetX() const;
    wxCoord GetY() const;
    bool HasCursor() const;
    /* TODO void SetCursor(const wxCursor& cursor); */
};

typedef int wxEventType;

#define wxEVT_ANY ((wxEventType)-1)

wxEventType wxNewEventType();

void wxPostEvent(wxEvtHandler* dest, const wxEvent& event);
void wxQueueEvent(wxEvtHandler* dest, wxEvent *event);

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

wxDECLARE_EXPORTED_EVENT(wxEVT_BUTTON, wxCommandEvent);
