/* EventCallback */
%pragma(csharp) modulecode="public delegate int EventDelegate(wxEvent ev);"

%typemap(imtype) (wxEventCallback callback)  "$module.EventDelegate"
%typemap(cstype) (wxEventCallback callback) "$module.EventDelegate"
%typemap(csin) (wxEventCallback callback)  "$csinput"
%typemap(in) (wxEventCallback callback) %{ $1 = ($1_ltype)$input; %}

%typemap(csfinalize) wxApp, wxAppConsole, wxEvtHandler, wxObject, wxAnyButton, wxButton, wxControl, wxFrame, wxNonOwnedWindow, wxTopLevelWindow, wxWindow %{
  ~$csclassname() {
    lock(this) {
      if (swigCPtr.Handle != global::System.IntPtr.Zero) {
        //global::System.Console.WriteLine("Dtor " + this.GetClassName());
        //Destroy();
        swigCPtr = new global::System.Runtime.InteropServices.HandleRef(null, global::System.IntPtr.Zero);
        global::System.GC.SuppressFinalize(this);
      }
    }
  }
%}
