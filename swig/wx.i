%module(directors="1") wxsharpglue
%{
#include <wx/wx.h>
%}

%include wchar.i
%include typemaps.i

typedef wchar_t __WCHAR_TYPE__;
%import wx/setup.h
%import wx/chartype.h

%include arrays_csharp.i

CSHARP_ARRAYS(wxChar*, string)
%typemap(imtype, inattributes="[In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex=0, ArraySubType=UnmanagedType.LPStr)]") wxChar *INPUT[] "string[]"

%apply wxChar *INPUT[] { wxChar** argv }

%include wxstring.i
%include wx_typemaps.i

%pragma(csharp) modulecode = %{
    public static bool wxEntry(string[] argv)
    {
        return wxEntry(argv.Length, argv);
    }
%}

bool wxEntry(int argc, wxChar** argv);

// interface/windowid.h

typedef int wxWindowID;

// complements to files in wxWindows sources in interface directory
%include defs.i
%include gdicmn.i
%include object.i
%include eventfilter.i
%include event.i
%include app.i
%include window.i
%include nonownedwnd.i
%include toplevel.i
%include frame.i
%include validate.i
%include control.i
%include anybutton.i
%include button.i
