table 52179103 "Working Paper Management"
{
    Caption = 'Working Paper Management';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "WP No."; Code[20])
        {
            Caption = 'Working Paper No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Index Code"; Code[20])
        {
            Caption = 'Index Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
        }
        field(5; "Phase"; Option)
        {
            Caption = 'Phase';
            OptionMembers = Planning,"Audit Program",Fieldwork,"Prior Year Follow-up","Audit Report","Follow-up";
            OptionCaption = 'Planning,Audit Program,Fieldwork,Prior Year Follow-up,Audit Report,Follow-up';
            DataClassification = ToBeClassified;
        }
        field(6; "Sub Item"; Text[100])
        {
            Caption = 'Sub Item';
            DataClassification = ToBeClassified;
        }
        field(7; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = "Internal Document","External Document","IDEA Analysis","Excel Workbook","Word Document","Scanned Image","Flow Chart","Email","Other";
            OptionCaption = 'Internal Document,External Document,IDEA Analysis,Excel Workbook,Word Document,Scanned Image,Flow Chart,Email,Other';
            DataClassification = ToBeClassified;
        }
        field(8; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = ToBeClassified;
        }
        field(9; "File Content"; Blob)
        {
            Caption = 'File Content';
            DataClassification = ToBeClassified;
        }
        field(10; "Prepared By"; Code[50])
        {
            Caption = 'Prepared By';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
        }
        field(11; "Prepared Date"; Date)
        {
            Caption = 'Prepared Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Reviewed By"; Code[50])
        {
            Caption = 'Reviewed By';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
        }
        field(13; "Review Date"; Date)
        {
            Caption = 'Review Date';
            DataClassification = ToBeClassified;
        }
        field(14; "Review Status"; Option)
        {
            Caption = 'Review Status';
            OptionMembers = "Not Reviewed","Under Review",Reviewed,"Review Comments";
            OptionCaption = 'Not Reviewed,Under Review,Reviewed,Review Comments';
            DataClassification = ToBeClassified;
        }
        field(15; "Review Notes"; Text[250])
        {
            Caption = 'Review Notes';
            DataClassification = ToBeClassified;
        }
        field(16; "Reviewer 2"; Code[50])
        {
            Caption = 'Reviewer 2';
            TableRelation = "Auditors List"."Auditor No";
            DataClassification = ToBeClassified;
        }
        field(17; "Review Date 2"; Date)
        {
            Caption = 'Review Date 2';
            DataClassification = ToBeClassified;
        }
        field(18; "Review Notes 2"; Text[250])
        {
            Caption = 'Review Notes 2';
            DataClassification = ToBeClassified;
        }
        field(19; "Sign-off Status"; Option)
        {
            Caption = 'Sign-off Status';
            OptionMembers = "Not Signed","Preparer Signed","Reviewer 1 Signed","Reviewer 2 Signed","All Signed";
            OptionCaption = 'Not Signed,Preparer Signed,Reviewer 1 Signed,Reviewer 2 Signed,All Signed';
            DataClassification = ToBeClassified;
        }
        field(20; "Electronic Signature"; Text[100])
        {
            Caption = 'Electronic Signature';
            DataClassification = ToBeClassified;
        }
        field(21; "Linked to Finding"; Boolean)
        {
            Caption = 'Linked to Finding';
            DataClassification = ToBeClassified;
        }
        field(22; "Finding No."; Code[20])
        {
            Caption = 'Finding No.';
            TableRelation = "Audit Finding Enhanced"."Finding No.";
            DataClassification = ToBeClassified;
        }
        field(23; "Linked to Procedure"; Boolean)
        {
            Caption = 'Linked to Procedure';
            DataClassification = ToBeClassified;
        }
        field(24; "Procedure No."; Code[20])
        {
            Caption = 'Procedure No.';
            DataClassification = ToBeClassified;
        }
        field(25; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = ToBeClassified;
        }
        field(26; "Current Version"; Boolean)
        {
            Caption = 'Current Version';
            DataClassification = ToBeClassified;
        }
        field(27; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Modified DateTime"; DateTime)
        {
            Caption = 'Modified DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "File Size (KB)"; Integer)
        {
            Caption = 'File Size (KB)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Confidential"; Boolean)
        {
            Caption = 'Confidential';
            DataClassification = ToBeClassified;
        }
        field(31; "Retention Period"; DateFormula)
        {
            Caption = 'Retention Period';
            DataClassification = ToBeClassified;
        }
        field(32; "Disposal Date"; Date)
        {
            Caption = 'Disposal Date';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "WP No.")
        {
            Clustered = true;
        }
        key(Index; "Audit No.", "Index Code")
        {
        }
        key(Phase; "Audit No.", Phase, "Sub Item")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created DateTime" := CurrentDateTime;
        if "Prepared Date" = 0D then
            "Prepared Date" := Today;
    end;
    
    trigger OnModify()
    begin
        "Modified DateTime" := CurrentDateTime;
    end;
}