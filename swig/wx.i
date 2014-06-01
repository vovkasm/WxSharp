%module(directors="1") wxsharpglue
%{
#include <wx/wx.h>
%}

%csconst(1);

%include wchar.i
%include typemaps.i

typedef wchar_t __WCHAR_TYPE__;
%import wx/setup.h
%import wx/chartype.h

%include arrays_csharp.i

CSHARP_ARRAYS(wxChar*, string)
%typemap(imtype, inattributes="[In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex=0, ArraySubType=UnmanagedType.LPStr)]") wxChar *INPUT[] "string[]"

%rename("%(strip:[wx])s") "";

%apply wxChar *INPUT[] { wxChar** argv }

%include wxstring.i
%include wx_typemaps.i

// interface/windowid.h

typedef int wxWindowID;

// complements to files in wxWindows sources in interface directory
%include defs.i
%include object.i
%include event.i
%include app.i
%include window.i
%include frame.i
%include button.i
