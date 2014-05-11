%naturalvar string;

class wxString;
// string
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

