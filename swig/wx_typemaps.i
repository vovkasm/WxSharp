/* EventCallback */
%pragma(csharp) modulecode="public delegate int EventDelegate(wxEvent ev);"

%typemap(imtype) (wxEventCallback callback)  "$module.EventDelegate"
%typemap(cstype) (wxEventCallback callback) "$module.EventDelegate"
%typemap(csin) (wxEventCallback callback)  "$csinput"
%typemap(in) (wxEventCallback callback) %{ $1 = ($1_ltype)$input; %}

