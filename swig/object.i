class wxObject
{
public:
    %extend {
      const wxChar* GetClassName() const {
        return $self->GetClassInfo()->GetClassName();
      }
    }
};

