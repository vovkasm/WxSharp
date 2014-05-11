%naturalvar string;

class wxString;
// wxString 
%typemap(ctype) wxString "char *"
%typemap(imtype) wxString "string"
%typemap(cstype) wxString "string"

%typemap(csdirectorin) wxString "$iminput"
%typemap(csdirectorout) wxString "$cscall"

%typemap(in, canthrow=1) wxString 
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   $1.assign($input); %}
%typemap(out) wxString %{ $result = SWIG_csharp_string_callback($1.c_str()); %}

%typemap(directorout, canthrow=1) wxString 
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   $result.assign($input); %}

%typemap(directorin) wxString %{ $input = SWIG_csharp_string_callback($1.c_str()); %}

%typemap(csin) wxString "$csinput"
%typemap(csout, excode=SWIGEXCODE) wxString {
    string ret = $imcall;$excode
    return ret;
  }

%typemap(typecheck) wxString = char *;

%typemap(throws, canthrow=1) wxString
%{ SWIG_CSharpSetPendingException(SWIG_CSharpApplicationException, $1.c_str());
   return $null; %}

// const wxString &
%typemap(ctype) const wxString & "char *"
%typemap(imtype) const wxString & "string"
%typemap(cstype) const wxString & "string"

%typemap(csdirectorin) const wxString & "$iminput"
%typemap(csdirectorout) const wxString & "$cscall"

%typemap(in, canthrow=1) const wxString &
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   $*1_ltype $1_str($input);
   $1 = &$1_str; %}
%typemap(out) const wxString & %{ $result = SWIG_csharp_string_callback($1->c_str()); %}

%typemap(csin) const wxString & "$csinput"
%typemap(csout, excode=SWIGEXCODE) const wxString & {
    string ret = $imcall;$excode
    return ret;
  }

%typemap(directorout, canthrow=1, warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const wxString &
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   /* possible thread/reentrant code problem */
   static $*1_ltype $1_str;
   $1_str = $input;
   $result = &$1_str; %}

%typemap(directorin) const wxString & %{ $input = SWIG_csharp_string_callback($1.c_str()); %}

%typemap(csvarin, excode=SWIGEXCODE2) const wxString & %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) const wxString & %{
    get {
      string ret = $imcall;$excode
      return ret;
    } %}

%typemap(typecheck) const wxString & = char *;

%typemap(throws, canthrow=1) const wxString &
%{ SWIG_CSharpSetPendingException(SWIG_CSharpApplicationException, $1.c_str());
   return $null; %}

