typedef wxRefCounter wxObjectRefData;

class wxRefCounter
{
protected:
    virtual ~wxRefCounter();

public:
    wxRefCounter();
    void DecRef();
    int GetRefCount() const;
    void IncRef();
};

class wxObject
{
public:
    wxObject();
    wxObject(const wxObject& other);
    virtual ~wxObject();
    /* virtual wxClassInfo* GetClassInfo() const; */
    /*bool IsKindOf(const wxClassInfo* info) const ; */

    %extend {
      const wxChar* GetClassName() const {
        return $self->GetClassInfo()->GetClassName();
      }
    }
};

class wxClassInfo
{
public:
    wxClassInfo(const wxChar* className,
                const wxClassInfo* baseClass1,
                const wxClassInfo* baseClass2,
                int size, wxObjectConstructorFn fn);

    wxObject* CreateObject() const;
    static wxClassInfo* FindClass(const wxString& className);
    const wxChar* GetBaseClassName1() const;
    const wxChar* GetBaseClassName2() const;
    const wxChar* GetClassName() const;
    int GetSize() const;
    bool IsDynamic() const;
    bool IsKindOf(const wxClassInfo* info) const;
};
