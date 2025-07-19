table 52179010 "CRM Marketing Template"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Marketing Template';
    
    fields
    {
        field(1; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            NotBlank = true;
        }
        field(2; "Template Name"; Text[100])
        {
            Caption = 'Template Name';
        }
        field(3; "Template Type"; Option)
        {
            Caption = 'Template Type';
            OptionMembers = Email,SMS,"Social Media",WhatsApp,Newsletter;
            OptionCaption = 'Email,SMS,Social Media,WhatsApp,Newsletter';
        }
        field(4; "Subject"; Text[250])
        {
            Caption = 'Subject';
        }
        field(5; "Content"; Blob)
        {
            Caption = 'Content';
        }
        field(6; "HTML Content"; Boolean)
        {
            Caption = 'HTML Content';
        }
        field(7; "Active"; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
        field(8; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(9; "Category"; Text[50])
        {
            Caption = 'Category';
        }
        field(10; "Tags"; Text[250])
        {
            Caption = 'Tags';
        }
        field(11; "Usage Count"; Integer)
        {
            Caption = 'Usage Count';
            Editable = false;
        }
        field(12; "Last Used Date"; DateTime)
        {
            Caption = 'Last Used Date';
            Editable = false;
        }
        field(13; "Personalization Fields"; Text[250])
        {
            Caption = 'Personalization Fields';
        }
        field(14; "Approval Required"; Boolean)
        {
            Caption = 'Approval Required';
        }
        field(15; "Approval Status"; Enum "CRM Approval Status")
        {
            Caption = 'Approval Status';
        }
        field(16; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(17; "Approved Date"; DateTime)
        {
            Caption = 'Approved Date';
            Editable = false;
        }
        field(18; "GDPR Compliant"; Boolean)
        {
            Caption = 'GDPR Compliant';
        }
        field(19; "Unsubscribe Link Required"; Boolean)
        {
            Caption = 'Unsubscribe Link Required';
        }
        field(20; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(21; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(22; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(23; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(24; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
    }
    
    keys
    {
        key(PK; "Template Code")
        {
            Clustered = true;
        }
        key(Type; "Template Type")
        {
        }
        key(Category; "Category")
        {
        }
        key(Usage; "Usage Count")
        {
        }
        key(Active; "Active")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
        "Approval Status" := "Approval Status"::Pending;
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    procedure GetContentAsText(): Text
    var
        InStream: InStream;
        ContentText: Text;
    begin
        Rec.CalcFields(Content);
        if Rec.Content.HasValue then begin
            Rec.Content.CreateInStream(InStream);
            InStream.ReadText(ContentText);
        end;
        exit(ContentText);
    end;

    procedure SetContentFromText(ContentText: Text)
    var
        OutStream: OutStream;
    begin
        Rec.Content.CreateOutStream(OutStream);
        OutStream.WriteText(ContentText);
    end;

    procedure IncrementUsage()
    begin
        Rec."Usage Count" += 1;
        Rec."Last Used Date" := CurrentDateTime;
        Rec.Modify();
    end;
}