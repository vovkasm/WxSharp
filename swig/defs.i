// From interface/defs.h

enum wxGeometryCentre
{
    wxCENTRE                  = 0x0001,
    wxCENTER                  = wxCENTRE
};

enum wxOrientation
{
    wxHORIZONTAL              = 0x0004,
    wxVERTICAL                = 0x0008,
    wxBOTH                    = wxVERTICAL | wxHORIZONTAL,
    wxORIENTATION_MASK        = wxBOTH
};

enum wxDirection
{
    wxLEFT                    = 0x0010,
    wxRIGHT                   = 0x0020,
    wxUP                      = 0x0040,
    wxDOWN                    = 0x0080,

    wxTOP                     = wxUP,
    wxBOTTOM                  = wxDOWN,

    wxNORTH                   = wxUP,
    wxSOUTH                   = wxDOWN,
    wxWEST                    = wxLEFT,
    wxEAST                    = wxRIGHT,

    wxALL                     = (wxUP | wxDOWN | wxRIGHT | wxLEFT),

    wxDIRECTION_MASK           = wxALL
};

enum wxAlignment
{
    wxALIGN_INVALID           = -1,

    wxALIGN_NOT               = 0x0000,
    wxALIGN_CENTER_HORIZONTAL = 0x0100,
    wxALIGN_CENTRE_HORIZONTAL = wxALIGN_CENTER_HORIZONTAL,
    wxALIGN_LEFT              = wxALIGN_NOT,
    wxALIGN_TOP               = wxALIGN_NOT,
    wxALIGN_RIGHT             = 0x0200,
    wxALIGN_BOTTOM            = 0x0400,
    wxALIGN_CENTER_VERTICAL   = 0x0800,
    wxALIGN_CENTRE_VERTICAL   = wxALIGN_CENTER_VERTICAL,

    wxALIGN_CENTER            = (wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL),
    wxALIGN_CENTRE            = wxALIGN_CENTER,

    wxALIGN_MASK              = 0x0f00
};

enum wxSizerFlagBits
{
    wxFIXED_MINSIZE                = 0x8000,
    wxRESERVE_SPACE_EVEN_IF_HIDDEN = 0x0002,

    wxSIZER_FLAG_BITS_MASK         = 0x8002
};

enum wxStretch
{
    wxSTRETCH_NOT             = 0x0000,
    wxSHRINK                  = 0x1000,
    wxGROW                    = 0x2000,
    wxEXPAND                  = wxGROW,
    wxSHAPED                  = 0x4000,
    wxTILE                    = wxSHAPED | 0x8000, 

    wxSTRETCH_MASK            = 0x7000 /* sans wxTILE */
};

enum wxBorder
{
    wxBORDER_DEFAULT = 0,

    wxBORDER_NONE   = 0x00200000,
    wxBORDER_STATIC = 0x01000000,
    wxBORDER_SIMPLE = 0x02000000,
    wxBORDER_RAISED = 0x04000000,
    wxBORDER_SUNKEN = 0x08000000,
    wxBORDER_DOUBLE = 0x10000000, /* deprecated */
    wxBORDER_THEME  = wxBORDER_DOUBLE,

    wxBORDER_MASK   = 0x1f200000
};

#define wxSIZE_AUTO_WIDTH       0x0001
#define wxSIZE_AUTO_HEIGHT      0x0002
#define wxSIZE_AUTO             (wxSIZE_AUTO_WIDTH|wxSIZE_AUTO_HEIGHT)
#define wxSIZE_USE_EXISTING     0x0000
#define wxSIZE_ALLOW_MINUS_ONE  0x0004
#define wxSIZE_NO_ADJUSTMENTS   0x0008
#define wxSIZE_FORCE            0x0010
#define wxSIZE_FORCE_EVENT      0x0020

#define wxVSCROLL               0x80000000U
#define wxHSCROLL               0x40000000U
#define wxCAPTION               0x20000000U

#define wxDOUBLE_BORDER         wxBORDER_DOUBLE
#define wxSUNKEN_BORDER         wxBORDER_SUNKEN
#define wxRAISED_BORDER         wxBORDER_RAISED
#define wxBORDER                wxBORDER_SIMPLE
#define wxSIMPLE_BORDER         wxBORDER_SIMPLE
#define wxSTATIC_BORDER         wxBORDER_STATIC
#define wxNO_BORDER             wxBORDER_NONE

#define wxALWAYS_SHOW_SB        0x00800000

#define wxCLIP_CHILDREN         0x00400000

#define wxCLIP_SIBLINGS         0x20000000

#define wxTRANSPARENT_WINDOW    0x00100000

#define wxTAB_TRAVERSAL         0x00080000

#define wxWANTS_CHARS           0x00040000

#ifdef __WXMOTIF__
#define wxRETAINED              0x00020000
#else
#define wxRETAINED              0x00000000
#endif
#define wxBACKINGSTORE          wxRETAINED

#define wxPOPUP_WINDOW          0x00020000

#define wxFULL_REPAINT_ON_RESIZE 0x00010000

#define wxNO_FULL_REPAINT_ON_RESIZE 0

#define wxWINDOW_STYLE_MASK     \
    (wxVSCROLL|wxHSCROLL|wxBORDER_MASK|wxALWAYS_SHOW_SB|wxCLIP_CHILDREN| \
     wxCLIP_SIBLINGS|wxTRANSPARENT_WINDOW|wxTAB_TRAVERSAL|wxWANTS_CHARS| \
     wxRETAINED|wxPOPUP_WINDOW|wxFULL_REPAINT_ON_RESIZE)

#define wxWS_EX_VALIDATE_RECURSIVELY    0x00000001
#define wxWS_EX_BLOCK_EVENTS            0x00000002
#define wxWS_EX_TRANSIENT               0x00000004
#define wxWS_EX_THEMED_BACKGROUND       0x00000008
#define wxWS_EX_PROCESS_IDLE            0x00000010
#define wxWS_EX_PROCESS_UI_UPDATES      0x00000020
#define wxFRAME_EX_METAL                0x00000040
#define wxDIALOG_EX_METAL               0x00000040
#define wxWS_EX_CONTEXTHELP             0x00000080
#define wxFRAME_EX_CONTEXTHELP          wxWS_EX_CONTEXTHELP
#define wxDIALOG_EX_CONTEXTHELP         wxWS_EX_CONTEXTHELP
#define wxFRAME_DRAWER          0x0020
#define wxFRAME_NO_WINDOW_MENU  0x0100

#define wxMB_DOCKABLE       0x0001
#define wxMENU_TEAROFF      0x0001

#define wxCOLOURED          0x0800
#define wxFIXED_LENGTH      0x0400

#define wxLB_SORT           0x0010
#define wxLB_SINGLE         0x0020
#define wxLB_MULTIPLE       0x0040
#define wxLB_EXTENDED       0x0080
#define wxLB_NEEDED_SB      0x0000
#define wxLB_OWNERDRAW      0x0100
#define wxLB_ALWAYS_SB      0x0200
#define wxLB_NO_SB          0x0400
#define wxLB_HSCROLL        wxHSCROLL
#define wxLB_INT_HEIGHT     0x0800

#define wxCB_SIMPLE         0x0004
#define wxCB_SORT           0x0008
#define wxCB_READONLY       0x0010
#define wxCB_DROPDOWN       0x0020

#define wxRA_LEFTTORIGHT    0x0001
#define wxRA_TOPTOBOTTOM    0x0002

#define wxRA_SPECIFY_COLS   wxHORIZONTAL
#define wxRA_SPECIFY_ROWS   wxVERTICAL

#define wxRA_HORIZONTAL     wxHORIZONTAL
#define wxRA_VERTICAL       wxVERTICAL

#define wxRB_GROUP          0x0004
#define wxRB_SINGLE         0x0008

#define wxSB_HORIZONTAL      wxHORIZONTAL
#define wxSB_VERTICAL        wxVERTICAL

#define wxSP_HORIZONTAL       wxHORIZONTAL /*  4 */
#define wxSP_VERTICAL         wxVERTICAL   /*  8 */
#define wxSP_ARROW_KEYS       0x4000
#define wxSP_WRAP             0x8000

#define wxTC_RIGHTJUSTIFY     0x0010
#define wxTC_FIXEDWIDTH       0x0020
#define wxTC_TOP              0x0000    /*  default */
#define wxTC_LEFT             0x0020
#define wxTC_RIGHT            0x0040
#define wxTC_BOTTOM           0x0080
#define wxTC_MULTILINE        0x0200    /* == wxNB_MULTILINE */
#define wxTC_OWNERDRAW        0x0400

#define wxBI_EXPAND           wxEXPAND

#define wxLI_HORIZONTAL         wxHORIZONTAL
#define wxLI_VERTICAL           wxVERTICAL


/*
 * extended dialog specifiers. these values are stored in a different
 * flag and thus do not overlap with other style flags. note that these
 * values do not correspond to the return values of the dialogs (for
 * those values, look at the wxID_XXX defines).
 */

/*  wxCENTRE already defined as  0x00000001 */
#define wxYES                   0x00000002U
#define wxOK                    0x00000004U
#define wxNO                    0x00000008U
#define wxYES_NO                (wxYES | wxNO)
#define wxCANCEL                0x00000010U
#define wxAPPLY                 0x00000020U
#define wxCLOSE                 0x00000040U

#define wxOK_DEFAULT            0x00000000U  /* has no effect (default) */
#define wxYES_DEFAULT           0x00000000U  /* has no effect (default) */
#define wxNO_DEFAULT            0x00000080U  /* only valid with wxYES_NO */
#define wxCANCEL_DEFAULT        0x80000000U  /* only valid with wxCANCEL */

#define wxICON_EXCLAMATION      0x00000100U
#define wxICON_HAND             0x00000200U
#define wxICON_WARNING          wxICON_EXCLAMATION
#define wxICON_ERROR            wxICON_HAND
#define wxICON_QUESTION         0x00000400U
#define wxICON_INFORMATION      0x00000800U
#define wxICON_STOP             wxICON_HAND
#define wxICON_ASTERISK         wxICON_INFORMATION

#define wxHELP                  0x00001000U
#define wxFORWARD               0x00002000U
#define wxBACKWARD              0x00004000U
#define wxRESET                 0x00008000U
#define wxMORE                  0x00010000U
#define wxSETUP                 0x00020000U
#define wxICON_NONE             0x00040000U
#define wxICON_AUTH_NEEDED      0x00080000U

#define wxICON_MASK \
    (wxICON_EXCLAMATION|wxICON_HAND|wxICON_QUESTION|wxICON_INFORMATION|wxICON_NONE)


/*  symbolic constant used by all Find()-like functions returning positive */
/*  integer on success as failure indicator */
#define wxNOT_FOUND       (-1)

/**
    Background styles.

    @see wxWindow::SetBackgroundStyle()
*/
enum wxBackgroundStyle
{
    /**
        Default background style value indicating that the background may be
        erased in the user-defined EVT_ERASE_BACKGROUND handler.

        If no such handler is defined (or if it skips the event), the effect of
        this style is the same as wxBG_STYLE_SYSTEM. If an empty handler (@em
        not skipping the event) is defined, the effect is the same as
        wxBG_STYLE_PAINT, i.e. the background is not erased at all until
        EVT_PAINT handler is executed.

        This is the only background style value for which erase background
        events are generated at all.
     */
    wxBG_STYLE_ERASE,

    /**
        Use the default background, as determined by the system or the current
        theme.

        If the window has been assigned a non-default background colour, it
        will be used for erasing its background. Otherwise the default
        background (which might be a gradient or a pattern) will be used.

        EVT_ERASE_BACKGROUND event will not be generated at all for windows
        with this style.
     */
    wxBG_STYLE_SYSTEM,

    /**
        Indicates that the background is only erased in the user-defined
        EVT_PAINT handler.

        Using this style avoids flicker which would result from redrawing the
        background twice if the EVT_PAINT handler entirely overwrites it. It
        must not be used however if the paint handler leaves any parts of the
        window unpainted as their contents is then undetermined. Only use it if
        you repaint the whole window in your handler.

        EVT_ERASE_BACKGROUND event will not be generated at all for windows
        with this style.
     */
    wxBG_STYLE_PAINT,
    
    /* this style is deprecated and doesn't do anything, don't use */
    wxBG_STYLE_COLOUR,

    /**
        Indicates that the window background is not erased, letting the parent
        window show through.

        Currently this style is only supported in wxOSX and wxGTK with
        compositing available, see wxWindow::IsTransparentBackgroundSupported().
     */
    wxBG_STYLE_TRANSPARENT,
};


/**
    Standard IDs.

    Notice that some, but @em not all, of these IDs are also stock IDs, i.e.
    you can use them for the button or menu items without specifying the label
    which will be provided by the underlying platform itself. See @ref page_stockitems "the
    list of stock items" for the subset of standard IDs which are stock IDs as well.
*/
enum wxStandardID
{
    /**
       This id delimits the lower bound of the range used by automatically-generated ids
       (i.e. those used when wxID_ANY is specified during construction).
     */
    wxID_AUTO_LOWEST,

    /**
       This id delimits the upper bound of the range used by automatically-generated ids
       (i.e. those used when wxID_ANY is specified during construction).
     */
    wxID_AUTO_HIGHEST,

    /**
        No id matches this one when compared to it.
    */
    wxID_NONE = -3,

    /**
        Id for a separator line in the menu (invalid for normal item).
    */
    wxID_SEPARATOR = -2,

    /**
        Any id: means that we don't care about the id, whether when installing
        an event handler or when creating a new window.
    */
    wxID_ANY = -1,

    wxID_LOWEST = 4999,

    wxID_OPEN,
    wxID_CLOSE,
    wxID_NEW,
    wxID_SAVE,
    wxID_SAVEAS,
    wxID_REVERT,
    wxID_EXIT,
    wxID_UNDO,
    wxID_REDO,
    wxID_HELP,
    wxID_PRINT,
    wxID_PRINT_SETUP,
    wxID_PAGE_SETUP,
    wxID_PREVIEW,
    wxID_ABOUT,
    wxID_HELP_CONTENTS,
    wxID_HELP_INDEX,
    wxID_HELP_SEARCH,
    wxID_HELP_COMMANDS,
    wxID_HELP_PROCEDURES,
    wxID_HELP_CONTEXT,
    wxID_CLOSE_ALL,
    wxID_PREFERENCES,

    wxID_EDIT = 5030,
    wxID_CUT,
    wxID_COPY,
    wxID_PASTE,
    wxID_CLEAR,
    wxID_FIND,
    wxID_DUPLICATE,
    wxID_SELECTALL,
    wxID_DELETE,
    wxID_REPLACE,
    wxID_REPLACE_ALL,
    wxID_PROPERTIES,

    wxID_VIEW_DETAILS,
    wxID_VIEW_LARGEICONS,
    wxID_VIEW_SMALLICONS,
    wxID_VIEW_LIST,
    wxID_VIEW_SORTDATE,
    wxID_VIEW_SORTNAME,
    wxID_VIEW_SORTSIZE,
    wxID_VIEW_SORTTYPE,

    wxID_FILE = 5050,
    wxID_FILE1,
    wxID_FILE2,
    wxID_FILE3,
    wxID_FILE4,
    wxID_FILE5,
    wxID_FILE6,
    wxID_FILE7,
    wxID_FILE8,
    wxID_FILE9,

    /** Standard button and menu IDs */
    wxID_OK = 5100,
    wxID_CANCEL,
    wxID_APPLY,
    wxID_YES,
    wxID_NO,
    wxID_STATIC,
    wxID_FORWARD,
    wxID_BACKWARD,
    wxID_DEFAULT,
    wxID_MORE,
    wxID_SETUP,
    wxID_RESET,
    wxID_CONTEXT_HELP,
    wxID_YESTOALL,
    wxID_NOTOALL,
    wxID_ABORT,
    wxID_RETRY,
    wxID_IGNORE,
    wxID_ADD,
    wxID_REMOVE,

    wxID_UP,
    wxID_DOWN,
    wxID_HOME,
    wxID_REFRESH,
    wxID_STOP,
    wxID_INDEX,

    wxID_BOLD,
    wxID_ITALIC,
    wxID_JUSTIFY_CENTER,
    wxID_JUSTIFY_FILL,
    wxID_JUSTIFY_RIGHT,
    wxID_JUSTIFY_LEFT,
    wxID_UNDERLINE,
    wxID_INDENT,
    wxID_UNINDENT,
    wxID_ZOOM_100,
    wxID_ZOOM_FIT,
    wxID_ZOOM_IN,
    wxID_ZOOM_OUT,
    wxID_UNDELETE,
    wxID_REVERT_TO_SAVED,
    wxID_CDROM,
    wxID_CONVERT,
    wxID_EXECUTE,
    wxID_FLOPPY,
    wxID_HARDDISK,
    wxID_BOTTOM,
    wxID_FIRST,
    wxID_LAST,
    wxID_TOP,
    wxID_INFO,
    wxID_JUMP_TO,
    wxID_NETWORK,
    wxID_SELECT_COLOR,
    wxID_SELECT_FONT,
    wxID_SORT_ASCENDING,
    wxID_SORT_DESCENDING,
    wxID_SPELL_CHECK,
    wxID_STRIKETHROUGH,

    /** System menu IDs (used by wxUniv): */
    wxID_SYSTEM_MENU = 5200,
    wxID_CLOSE_FRAME,
    wxID_MOVE_FRAME,
    wxID_RESIZE_FRAME,
    wxID_MAXIMIZE_FRAME,
    wxID_ICONIZE_FRAME,
    wxID_RESTORE_FRAME,

    /** MDI window menu ids */
    wxID_MDI_WINDOW_FIRST = 5230,
    wxID_MDI_WINDOW_CASCADE = wxID_MDI_WINDOW_FIRST,
    wxID_MDI_WINDOW_TILE_HORZ,
    wxID_MDI_WINDOW_TILE_VERT,
    wxID_MDI_WINDOW_ARRANGE_ICONS,
    wxID_MDI_WINDOW_PREV,
    wxID_MDI_WINDOW_NEXT,
    wxID_MDI_WINDOW_LAST = wxID_MDI_WINDOW_NEXT,

    /** IDs used by generic file dialog (13 consecutive starting from this value) */
    wxID_FILEDLGG = 5900,

    /** IDs used by generic file ctrl (4 consecutive starting from this value) */
    wxID_FILECTRL = 5950,

    wxID_HIGHEST = 5999
};

/**
    Item kinds for use with wxMenu, wxMenuItem, and wxToolBar.

    @see wxMenu::Append(), wxMenuItem::wxMenuItem(), wxToolBar::AddTool()
*/
enum wxItemKind
{
    wxITEM_SEPARATOR = -1,

    /**
        Normal tool button / menu item.

        @see wxToolBar::AddTool(), wxMenu::AppendItem().
    */
    wxITEM_NORMAL,

    /**
        Check (or toggle) tool button / menu item.

        @see wxToolBar::AddCheckTool(), wxMenu::AppendCheckItem().
    */
    wxITEM_CHECK,

    /**
        Radio tool button / menu item.

        @see wxToolBar::AddRadioTool(), wxMenu::AppendRadioItem().
    */
    wxITEM_RADIO,

    /**
        Normal tool button with a dropdown arrow next to it. Clicking the
        dropdown arrow sends a @c wxEVT_TOOL_DROPDOWN event and may
        also display the menu previously associated with the item with
        wxToolBar::SetDropdownMenu(). Currently this type of tools is supported
        under MSW and GTK.
    */
    wxITEM_DROPDOWN,

    wxITEM_MAX
};

/**
    Generic hit test results.
*/
enum wxHitTest
{
    wxHT_NOWHERE,

    /*  scrollbar */
    wxHT_SCROLLBAR_FIRST = wxHT_NOWHERE,
    wxHT_SCROLLBAR_ARROW_LINE_1,    /**< left or upper arrow to scroll by line */
    wxHT_SCROLLBAR_ARROW_LINE_2,    /**< right or down */
    wxHT_SCROLLBAR_ARROW_PAGE_1,    /**< left or upper arrow to scroll by page */
    wxHT_SCROLLBAR_ARROW_PAGE_2,    /**< right or down */
    wxHT_SCROLLBAR_THUMB,           /**< on the thumb */
    wxHT_SCROLLBAR_BAR_1,           /**< bar to the left/above the thumb */
    wxHT_SCROLLBAR_BAR_2,           /**< bar to the right/below the thumb */
    wxHT_SCROLLBAR_LAST,

    /*  window */
    wxHT_WINDOW_OUTSIDE,            /**< not in this window at all */
    wxHT_WINDOW_INSIDE,             /**< in the client area */
    wxHT_WINDOW_VERT_SCROLLBAR,     /**< on the vertical scrollbar */
    wxHT_WINDOW_HORZ_SCROLLBAR,     /**< on the horizontal scrollbar */
    wxHT_WINDOW_CORNER,             /**< on the corner between 2 scrollbars */

    wxHT_MAX
};

/**
    Data format IDs used by wxDataFormat.
*/
enum wxDataFormatId
{
    wxDF_INVALID =          0,
    wxDF_TEXT =             1,  /* CF_TEXT */
    wxDF_BITMAP =           2,  /* CF_BITMAP */
    wxDF_METAFILE =         3,  /* CF_METAFILEPICT */
    wxDF_SYLK =             4,
    wxDF_DIF =              5,
    wxDF_TIFF =             6,
    wxDF_OEMTEXT =          7,  /* CF_OEMTEXT */
    wxDF_DIB =              8,  /* CF_DIB */
    wxDF_PALETTE =          9,
    wxDF_PENDATA =          10,
    wxDF_RIFF =             11,
    wxDF_WAVE =             12,
    wxDF_UNICODETEXT =      13,
    wxDF_ENHMETAFILE =      14,
    wxDF_FILENAME =         15, /* CF_HDROP */
    wxDF_LOCALE =           16,
    wxDF_PRIVATE =          20,
    wxDF_HTML =             30, /* Note: does not correspond to CF_ constant */
    wxDF_MAX
};

/**
    Virtual keycodes used by wxKeyEvent and some other wxWidgets functions.

    Note that the range <code>0..255</code> corresponds to the characters of
    the current locale, in particular the <code>32..127</code> subrange is for
    the ASCII symbols, and all the special key values such as @c WXK_END lie
    above this range.
*/
enum wxKeyCode
{
    /**
        No key.

        This value is returned by wxKeyEvent::GetKeyCode() if there is no
        non-Unicode representation for the pressed key (e.g. a Cyrillic letter
        was entered when not using a Cyrillic locale) and by
        wxKeyEvent::GetUnicodeKey() if there is no Unicode representation for
        the key (this happens for the special, non printable, keys only, e.g.
        WXK_HOME).

        @since 2.9.2 (you can simply use 0 with previous versions).
     */
    WXK_NONE    =    0,

    WXK_CONTROL_A = 1,
    WXK_CONTROL_B,
    WXK_CONTROL_C,
    WXK_CONTROL_D,
    WXK_CONTROL_E,
    WXK_CONTROL_F,
    WXK_CONTROL_G,
    WXK_CONTROL_H,
    WXK_CONTROL_I,
    WXK_CONTROL_J,
    WXK_CONTROL_K,
    WXK_CONTROL_L,
    WXK_CONTROL_M,
    WXK_CONTROL_N,
    WXK_CONTROL_O,
    WXK_CONTROL_P,
    WXK_CONTROL_Q,
    WXK_CONTROL_R,
    WXK_CONTROL_S,
    WXK_CONTROL_T,
    WXK_CONTROL_U,
    WXK_CONTROL_V,
    WXK_CONTROL_W,
    WXK_CONTROL_X,
    WXK_CONTROL_Y,
    WXK_CONTROL_Z,
    
    WXK_BACK    =    8,     //!< Backspace.
    WXK_TAB     =    9,
    WXK_RETURN  =    13,
    WXK_ESCAPE  =    27,
    WXK_SPACE   =    32,

    WXK_DELETE  =    127,

    /**
        Special key values.

        These are, by design, not compatible with Unicode characters.
        If you want to get a Unicode character from a key event, use
        wxKeyEvent::GetUnicodeKey() instead.
    */
    WXK_START   = 300,
    WXK_LBUTTON,
    WXK_RBUTTON,
    WXK_CANCEL,
    WXK_MBUTTON,
    WXK_CLEAR,
    WXK_SHIFT,
    WXK_ALT,
    /** Note that under Mac OS X, to improve compatibility with other
      * systems, 'WXK_CONTROL' represents the 'Command' key. Use this
      * constant to work with keyboard shortcuts. See 'WXK_RAW_CONTROL'
      * to get the state of the actual 'Control' key.
      */
    WXK_CONTROL,
    /** Under Mac OS X, where the 'Command' key is mapped to 'Control'
      * to improve compatibility with other systems, WXK_RAW_CONTROL may
      * be used to obtain the state of the actual 'Control' key
      * ('WXK_CONTROL' would obtain the status of the 'Command' key).
      * Under Windows/Linux/Others, this is equivalent to WXK_CONTROL
      */
    WXK_RAW_CONTROL,
    WXK_MENU,
    WXK_PAUSE,
    WXK_CAPITAL,
    WXK_END,
    WXK_HOME,
    WXK_LEFT,
    WXK_UP,
    WXK_RIGHT,
    WXK_DOWN,
    WXK_SELECT,
    WXK_PRINT,
    WXK_EXECUTE,
    WXK_SNAPSHOT,
    WXK_INSERT,
    WXK_HELP,
    WXK_NUMPAD0,
    WXK_NUMPAD1,
    WXK_NUMPAD2,
    WXK_NUMPAD3,
    WXK_NUMPAD4,
    WXK_NUMPAD5,
    WXK_NUMPAD6,
    WXK_NUMPAD7,
    WXK_NUMPAD8,
    WXK_NUMPAD9,
    WXK_MULTIPLY,
    WXK_ADD,
    WXK_SEPARATOR,
    WXK_SUBTRACT,
    WXK_DECIMAL,
    WXK_DIVIDE,
    WXK_F1,
    WXK_F2,
    WXK_F3,
    WXK_F4,
    WXK_F5,
    WXK_F6,
    WXK_F7,
    WXK_F8,
    WXK_F9,
    WXK_F10,
    WXK_F11,
    WXK_F12,
    WXK_F13,
    WXK_F14,
    WXK_F15,
    WXK_F16,
    WXK_F17,
    WXK_F18,
    WXK_F19,
    WXK_F20,
    WXK_F21,
    WXK_F22,
    WXK_F23,
    WXK_F24,
    WXK_NUMLOCK,
    WXK_SCROLL,
    WXK_PAGEUP,
    WXK_PAGEDOWN,

    WXK_NUMPAD_SPACE,
    WXK_NUMPAD_TAB,
    WXK_NUMPAD_ENTER,
    WXK_NUMPAD_F1,
    WXK_NUMPAD_F2,
    WXK_NUMPAD_F3,
    WXK_NUMPAD_F4,
    WXK_NUMPAD_HOME,
    WXK_NUMPAD_LEFT,
    WXK_NUMPAD_UP,
    WXK_NUMPAD_RIGHT,
    WXK_NUMPAD_DOWN,
    WXK_NUMPAD_PAGEUP,
    WXK_NUMPAD_PAGEDOWN,
    WXK_NUMPAD_END,
    WXK_NUMPAD_BEGIN,
    WXK_NUMPAD_INSERT,
    WXK_NUMPAD_DELETE,
    WXK_NUMPAD_EQUAL,
    WXK_NUMPAD_MULTIPLY,
    WXK_NUMPAD_ADD,
    WXK_NUMPAD_SEPARATOR,
    WXK_NUMPAD_SUBTRACT,
    WXK_NUMPAD_DECIMAL,
    WXK_NUMPAD_DIVIDE,

    /** The following key codes are only generated under Windows currently */
    WXK_WINDOWS_LEFT,
    WXK_WINDOWS_RIGHT,
    WXK_WINDOWS_MENU ,
    
    /** This special key code was used to represent the key used for keyboard shortcuts. Under Mac OS X,
      * this key maps to the 'Command' (aka logo or 'Apple') key, whereas on Linux/Windows/others
      * this is the Control key, with the new semantic of WXK_CONTROL, WXK_COMMAND is not needed anymore
      */
    WXK_COMMAND,

    /** Hardware-specific buttons */
    WXK_SPECIAL1 = 193,
    WXK_SPECIAL2,
    WXK_SPECIAL3,
    WXK_SPECIAL4,
    WXK_SPECIAL5,
    WXK_SPECIAL6,
    WXK_SPECIAL7,
    WXK_SPECIAL8,
    WXK_SPECIAL9,
    WXK_SPECIAL10,
    WXK_SPECIAL11,
    WXK_SPECIAL12,
    WXK_SPECIAL13,
    WXK_SPECIAL14,
    WXK_SPECIAL15,
    WXK_SPECIAL16,
    WXK_SPECIAL17,
    WXK_SPECIAL18,
    WXK_SPECIAL19,
    WXK_SPECIAL20
};

/**
    This enum contains bit mask constants used in wxKeyEvent.
*/
enum wxKeyModifier
{
    wxMOD_NONE      = 0x0000,
    wxMOD_ALT       = 0x0001,
    /** Ctlr Key, corresponds to Command key on OS X */
    wxMOD_CONTROL   = 0x0002,
    wxMOD_ALTGR     = wxMOD_ALT | wxMOD_CONTROL,
    wxMOD_SHIFT     = 0x0004,
    wxMOD_META      = 0x0008,
    wxMOD_WIN       = wxMOD_META,
    
    /** used to describe the true Ctrl Key under OSX, 
    identic to @c wxMOD_CONTROL on other platforms */
    wxMOD_RAW_CONTROL,
    
    /** deprecated, identic to @c wxMOD_CONTROL on all platforms */
    wxMOD_CMD       = wxMOD_CONTROL,
    wxMOD_ALL       = 0xffff
};

/**
    Paper size types for use with the printing framework.

    @see overview_printing, wxPrintData::SetPaperId()
*/
enum wxPaperSize
{
    wxPAPER_10X11,              ///<  10 x 11 in
    wxPAPER_10X14,              ///<  10-by-14-inch sheet
    wxPAPER_11X17,              ///<  11-by-17-inch sheet
    wxPAPER_12X11,              ///< 12 x 11 in
    wxPAPER_15X11,              ///<  15 x 11 in
    wxPAPER_9X11,               ///<  9 x 11 in
    wxPAPER_A2,                 ///<  A2 420 x 594 mm
    wxPAPER_A3,                 ///<  A3 sheet, 297 by 420 millimeters
    wxPAPER_A3_EXTRA,           ///<  A3 Extra 322 x 445 mm
    wxPAPER_A3_EXTRA_TRANSVERSE, ///<  A3 Extra Transverse 322 x 445 mm
    wxPAPER_A3_ROTATED,         ///< A3 Rotated 420 x 297 mm
    wxPAPER_A3_TRANSVERSE,      ///<  A3 Transverse 297 x 420 mm
    wxPAPER_A4,                 ///<  A4 Sheet, 210 by 297 millimeters
    wxPAPER_A4SMALL,            ///<  A4 small sheet, 210 by 297 millimeters
    wxPAPER_A4_EXTRA,           ///<  A4 Extra 9.27 x 12.69 in
    wxPAPER_A4_PLUS,            ///<  A4 Plus 210 x 330 mm
    wxPAPER_A4_ROTATED,         ///< A4 Rotated 297 x 210 mm
    wxPAPER_A4_TRANSVERSE,      ///<  A4 Transverse 210 x 297 mm
    wxPAPER_A5,                 ///<  A5 sheet, 148 by 210 millimeters
    wxPAPER_A5_EXTRA,           ///<  A5 Extra 174 x 235 mm
    wxPAPER_A5_ROTATED,         ///< A5 Rotated 210 x 148 mm
    wxPAPER_A5_TRANSVERSE,      ///<  A5 Transverse 148 x 210 mm
    wxPAPER_A6,                 ///< A6 105 x 148 mm
    wxPAPER_A6_ROTATED,         ///< A6 Rotated 148 x 105 mm
    wxPAPER_A_PLUS,             ///<  SuperA/SuperA/A4 227 x 356 mm
    wxPAPER_B4,                 ///<  B4 sheet, 250 by 354 millimeters
    wxPAPER_B4_JIS_ROTATED,     ///< B4 (JIS) Rotated 364 x 257 mm
    wxPAPER_B5,                 ///<  B5 sheet, 182-by-257-millimeter paper
    wxPAPER_B5_EXTRA,           ///<  B5 (ISO) Extra 201 x 276 mm
    wxPAPER_B5_JIS_ROTATED,     ///< B5 (JIS) Rotated 257 x 182 mm
    wxPAPER_B5_TRANSVERSE,      ///<  B5 (JIS) Transverse 182 x 257 mm
    wxPAPER_B6_JIS,             ///< B6 (JIS) 128 x 182 mm
    wxPAPER_B6_JIS_ROTATED,     ///< B6 (JIS) Rotated 182 x 128 mm
    wxPAPER_B_PLUS,             ///<  SuperB/SuperB/A3 305 x 487 mm
    wxPAPER_CSHEET,             ///<  C Sheet, 17 by 22 inches
    wxPAPER_DBL_JAPANESE_POSTCARD, ///< Japanese Double Postcard 200 x 148 mm
    wxPAPER_DBL_JAPANESE_POSTCARD_ROTATED, ///< Double Japanese Postcard Rotated 148 x 200 mm
    wxPAPER_DSHEET,             ///<  D Sheet, 22 by 34 inches
    wxPAPER_ENV_10,             ///<  #10 Envelope, 4 1/8 by 9 1/2 inches
    wxPAPER_ENV_11,             ///<  #11 Envelope, 4 1/2 by 10 3/8 inches
    wxPAPER_ENV_12,             ///<  #12 Envelope, 4 3/4 by 11 inches
    wxPAPER_ENV_14,             ///<  #14 Envelope, 5 by 11 1/2 inches
    wxPAPER_ENV_9,              ///<  #9 Envelope, 3 7/8 by 8 7/8 inches
    wxPAPER_ENV_B4,             ///<  B4 Envelope, 250 by 353 millimeters
    wxPAPER_ENV_B5,             ///<  B5 Envelope, 176 by 250 millimeters
    wxPAPER_ENV_B6,             ///<  B6 Envelope, 176 by 125 millimeters
    wxPAPER_ENV_C3,             ///<  C3 Envelope, 324 by 458 millimeters
    wxPAPER_ENV_C4,             ///<  C4 Envelope, 229 by 324 millimeters
    wxPAPER_ENV_C5,             ///<  C5 Envelope, 162 by 229 millimeters
    wxPAPER_ENV_C6,             ///<  C6 Envelope, 114 by 162 millimeters
    wxPAPER_ENV_C65,            ///<  C65 Envelope, 114 by 229 millimeters
    wxPAPER_ENV_DL,             ///<  DL Envelope, 110 by 220 millimeters
    wxPAPER_ENV_INVITE,         ///<  Envelope Invite 220 x 220 mm
    wxPAPER_ENV_ITALY,          ///<  Italy Envelope, 110 by 230 millimeters
    wxPAPER_ENV_MONARCH,        ///<  Monarch Envelope, 3 7/8 by 7 1/2 inches
    wxPAPER_ENV_PERSONAL,       ///<  6 3/4 Envelope, 3 5/8 by 6 1/2 inches
    wxPAPER_ESHEET,             ///<  E Sheet, 34 by 44 inches
    wxPAPER_EXECUTIVE,          ///<  Executive, 7 1/4 by 10 1/2 inches
    wxPAPER_FANFOLD_LGL_GERMAN, ///<  German Legal Fanfold, 8 1/2 by 13 inches
    wxPAPER_FANFOLD_STD_GERMAN, ///<  German Std Fanfold, 8 1/2 by 12 inches
    wxPAPER_FANFOLD_US,         ///<  US Std Fanfold, 14 7/8 by 11 inches
    wxPAPER_FOLIO,              ///<  Folio, 8-1/2-by-13-inch paper
    wxPAPER_ISO_B4,             ///<  B4 (ISO) 250 x 353 mm
    wxPAPER_JAPANESE_POSTCARD,  ///<  Japanese Postcard 100 x 148 mm
    wxPAPER_JAPANESE_POSTCARD_ROTATED, ///< Japanese Postcard Rotated 148 x 100 mm
    wxPAPER_JENV_CHOU3,         ///< Japanese Envelope Chou #3
    wxPAPER_JENV_CHOU3_ROTATED, ///< Japanese Envelope Chou #3 Rotated
    wxPAPER_JENV_CHOU4,         ///< Japanese Envelope Chou #4
    wxPAPER_JENV_CHOU4_ROTATED, ///< Japanese Envelope Chou #4 Rotated
    wxPAPER_JENV_KAKU2,         ///< Japanese Envelope Kaku #2
    wxPAPER_JENV_KAKU2_ROTATED, ///< Japanese Envelope Kaku #2 Rotated
    wxPAPER_JENV_KAKU3,         ///< Japanese Envelope Kaku #3
    wxPAPER_JENV_KAKU3_ROTATED, ///< Japanese Envelope Kaku #3 Rotated
    wxPAPER_JENV_YOU4,          ///< Japanese Envelope You #4
    wxPAPER_JENV_YOU4_ROTATED,  ///< Japanese Envelope You #4 Rotated
    wxPAPER_LEDGER,             ///<  Ledger, 17 by 11 inches
    wxPAPER_LEGAL,              ///<  Legal, 8 1/2 by 14 inches
    wxPAPER_LEGAL_EXTRA,        ///<  Legal Extra 9.5 x 15 in
    wxPAPER_LETTER,             ///<  Letter, 8 1/2 by 11 inches
    wxPAPER_LETTERSMALL,        ///<  Letter Small, 8 1/2 by 11 inches
    wxPAPER_LETTER_EXTRA,       ///<  Letter Extra 9.5 x 12 in
    wxPAPER_LETTER_EXTRA_TRANSVERSE, ///<  Letter Extra Transverse 9.5 x 12 in
    wxPAPER_LETTER_PLUS,        ///<  Letter Plus 8.5 x 12.69 in
    wxPAPER_LETTER_ROTATED,     ///< Letter Rotated 11 x 8 1/2 in
    wxPAPER_LETTER_TRANSVERSE,  ///<  Letter Transverse 8.5 x 11 in
    wxPAPER_NONE,               ///<  Use specific dimensions
    wxPAPER_NOTE,               ///<  Note, 8 1/2 by 11 inches
    wxPAPER_P16K,               ///< PRC 16K 146 x 215 mm
    wxPAPER_P16K_ROTATED,       ///< PRC 16K Rotated
    wxPAPER_P32K,               ///< PRC 32K 97 x 151 mm
    wxPAPER_P32KBIG,            ///< PRC 32K(Big) 97 x 151 mm
    wxPAPER_P32KBIG_ROTATED,    ///< PRC 32K(Big) Rotated
    wxPAPER_P32K_ROTATED,       ///< PRC 32K Rotated
    wxPAPER_PENV_1,             ///< PRC Envelope #1 102 x 165 mm
    wxPAPER_PENV_10,            ///< PRC Envelope #10 324 x 458 mm
    wxPAPER_PENV_10_ROTATED,    ///< PRC Envelope #10 Rotated 458 x 324 m
    wxPAPER_PENV_1_ROTATED,     ///< PRC Envelope #1 Rotated 165 x 102 mm
    wxPAPER_PENV_2,             ///< PRC Envelope #2 102 x 176 mm
    wxPAPER_PENV_2_ROTATED,     ///< PRC Envelope #2 Rotated 176 x 102 mm
    wxPAPER_PENV_3,             ///< PRC Envelope #3 125 x 176 mm
    wxPAPER_PENV_3_ROTATED,     ///< PRC Envelope #3 Rotated 176 x 125 mm
    wxPAPER_PENV_4,             ///< PRC Envelope #4 110 x 208 mm
    wxPAPER_PENV_4_ROTATED,     ///< PRC Envelope #4 Rotated 208 x 110 mm
    wxPAPER_PENV_5,             ///< PRC Envelope #5 110 x 220 mm
    wxPAPER_PENV_5_ROTATED,     ///< PRC Envelope #5 Rotated 220 x 110 mm
    wxPAPER_PENV_6,             ///< PRC Envelope #6 120 x 230 mm
    wxPAPER_PENV_6_ROTATED,     ///< PRC Envelope #6 Rotated 230 x 120 mm
    wxPAPER_PENV_7,             ///< PRC Envelope #7 160 x 230 mm
    wxPAPER_PENV_7_ROTATED,     ///< PRC Envelope #7 Rotated 230 x 160 mm
    wxPAPER_PENV_8,             ///< PRC Envelope #8 120 x 309 mm
    wxPAPER_PENV_8_ROTATED,     ///< PRC Envelope #8 Rotated 309 x 120 mm
    wxPAPER_PENV_9,             ///< PRC Envelope #9 229 x 324 mm
    wxPAPER_PENV_9_ROTATED,     ///< PRC Envelope #9 Rotated 324 x 229 mm
    wxPAPER_QUARTO,             ///<  Quarto, 215-by-275-millimeter paper
    wxPAPER_STATEMENT,          ///<  Statement, 5 1/2 by 8 1/2 inches
    wxPAPER_TABLOID,            ///<  Tabloid, 11 by 17 inches
    wxPAPER_TABLOID_EXTRA       ///<  Tabloid Extra 11.69 x 18 in
};

/**
    Printing orientation
*/

enum wxPrintOrientation
{
   wxPORTRAIT,
   wxLANDSCAPE
};

/**
    Duplex printing modes.
*/
enum wxDuplexMode
{
    wxDUPLEX_SIMPLEX, /**< Non-duplex */
    wxDUPLEX_HORIZONTAL,
    wxDUPLEX_VERTICAL
};

/**
    Print quality.
*/
#define wxPRINT_QUALITY_HIGH    -1
#define wxPRINT_QUALITY_MEDIUM  -2
#define wxPRINT_QUALITY_LOW     -3
#define wxPRINT_QUALITY_DRAFT   -4

typedef int wxPrintQuality;

/**
    Print mode (currently PostScript only).
*/
enum wxPrintMode
{
    wxPRINT_MODE_NONE =    0,
    wxPRINT_MODE_PREVIEW = 1,   /**< Preview in external application */
    wxPRINT_MODE_FILE =    2,   /**< Print to file */
    wxPRINT_MODE_PRINTER = 3,   /**< Send to printer */
    wxPRINT_MODE_STREAM =  4    /**< Send postscript data into a stream */
};

/**
    Flags which can be used in wxWindow::UpdateWindowUI().
*/
enum wxUpdateUI
{
    wxUPDATE_UI_NONE,
    wxUPDATE_UI_RECURSE,
    wxUPDATE_UI_FROMIDLE  /**<  Invoked from On(Internal)Idle */
};


// ----------------------------------------------------------------------------
// constants
// ----------------------------------------------------------------------------

/**
    Top level window styles common to wxFrame and wxDialog
*/

#define wxSTAY_ON_TOP           0x8000
#define wxICONIZE               0x4000
#define wxMINIMIZE              wxICONIZE
#define wxMAXIMIZE              0x2000
#define wxCLOSE_BOX             0x1000

#define wxSYSTEM_MENU           0x0800
#define wxMINIMIZE_BOX          0x0400
#define wxMAXIMIZE_BOX          0x0200

#define wxTINY_CAPTION          0x0080  // clashes with wxNO_DEFAULT
#define wxRESIZE_BORDER         0x0040


// ----------------------------------------------------------------------------
// types
// ----------------------------------------------------------------------------

/** The type for screen and DC coordinates. */
typedef int wxCoord;

/** A special value meaning "use default coordinate". */
const wxCoord wxDefaultCoord = -1;

//@{
/** 8 bit type (the mapping is more complex than a simple @c typedef and is not shown here). */
typedef signed char wxInt8;
typedef unsigned char wxUint8;
typedef wxUint8 wxByte;
//@}

//@{
/** 16 bit type (the mapping is more complex than a simple @c typedef and is not shown here). */
typedef signed short wxInt16;
typedef unsigned short wxUint16;
typedef wxUint16 wxWord;
typedef wxUint16 wxChar16;
//@}

//@{
/** 32 bit type (the mapping is more complex than a simple @c typedef and is not shown here). */
typedef int wxInt32;
typedef unsigned int wxUint32;
typedef wxUint32 wxDword;
typedef wxUint32 wxChar32;
//@}

//@{
/** 64 bit type (the mapping is more complex than a simple @c typedef and is not shown here). */
typedef wxLongLong_t wxInt64;
typedef wxULongLong_t wxUint64;
//@}

//@{
/**
    Signed and unsigned integral types big enough to contain all of @c long,
    @c size_t and @c void*.
    (The mapping is more complex than a simple @c typedef and is not shown here).
*/
typedef ssize_t wxIntPtr;
typedef size_t wxUIntPtr;
//@}


/**
    32 bit IEEE float ( 1 sign, 8 exponent bits, 23 fraction bits ).
    (The mapping is more complex than a simple @c typedef and is not shown here).
*/
typedef float wxFloat32;


/**
    64 bit IEEE float ( 1 sign, 11 exponent bits, 52 fraction bits ).
    (The mapping is more complex than a simple @c typedef and is not shown here).
*/
typedef double wxFloat64;

/**
    Native fastest representation that has at least wxFloat64 precision, so use
    the IEEE types for storage, and this for calculations.
    (The mapping is more complex than a simple @c typedef and is not shown here).
*/
typedef double wxDouble;
