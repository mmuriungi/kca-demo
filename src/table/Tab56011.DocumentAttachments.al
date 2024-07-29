table 56011 "Document Attachments"
{

    fields
    {
        field(1; "Document No"; Code[100])
        {
            NotBlank = true;
        }
        field(2; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(3; "Document Link"; Text[200])
        {
        }
        field(6; "Attachment No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; "Language Code (Default)"; Code[50])
        {
            TableRelation = Language;
        }
        field(8; Attachment; Option)
        {
            Editable = false;
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1; "Document No", "Document Description")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DocLink: Record "Document Attachments";

    procedure PlaceFilter(prompt: Boolean; DocumentNo: Code[10]): Boolean
    begin
        IF prompt THEN BEGIN
            SETFILTER("Document No", DocumentNo);
        END;
    end;
}

