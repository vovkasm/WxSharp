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
